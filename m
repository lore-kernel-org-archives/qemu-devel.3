Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B387C35FF1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 02:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trT1c-0003xI-18; Sun, 09 Mar 2025 22:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1trT1X-0003eI-KE; Sun, 09 Mar 2025 22:37:47 -0400
Received: from out28-97.mail.aliyun.com ([115.124.28.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1trT1T-0003Qq-Hs; Sun, 09 Mar 2025 22:37:47 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.booCGce_1741574249 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 10 Mar 2025 10:37:32 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: alistair23@gmail.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 lc00631@tecorigin.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 zqz00548@tecorigin.com
Subject: [PATCH v4 1/2] target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to
 accept vl as a parameter
Date: Mon, 10 Mar 2025 10:35:24 +0800
Message-ID: <f575979874e323a9e0da7796aa391c7d87e56f88.1741573286.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1741573286.git.lc00631@tecorigin.com>
References: <cover.1741573286.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.97; envelope-from=lc00631@tecorigin.com;
 helo=out28-97.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Some vector instructions are special, such as the vlm.v instruction,
where setting its vl actually sets evl = (vl + 7) >> 3. To improve
maintainability, we will uniformly use VSTART_CHECK_EARLY_EXIT() to
check for the condition vstart >= vl. This function will also handle
cases involving evl.

Fixes: df4252b2ec ("target/riscv/vector_helpers: do early exit when
vstart >= vl")
Signed-off-by: Chao Liu <lc00631@tecorigin.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vcrypto_helper.c   | 32 +++++++--------
 target/riscv/vector_helper.c    | 69 ++++++++++++++++-----------------
 target/riscv/vector_internals.c |  4 +-
 target/riscv/vector_internals.h | 12 +++---
 4 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index f7423df..1526de9 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -222,7 +222,7 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
         uint32_t total_elems = vext_get_total_elems(env, desc, 4);        \
         uint32_t vta = vext_vta(desc);                                    \
                                                                           \
-        VSTART_CHECK_EARLY_EXIT(env);                                     \
+        VSTART_CHECK_EARLY_EXIT(env, vl);                                 \
                                                                           \
         for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {        \
             AESState round_key;                                           \
@@ -248,7 +248,7 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
         uint32_t total_elems = vext_get_total_elems(env, desc, 4);        \
         uint32_t vta = vext_vta(desc);                                    \
                                                                           \
-        VSTART_CHECK_EARLY_EXIT(env);                                     \
+        VSTART_CHECK_EARLY_EXIT(env, vl);                                 \
                                                                           \
         for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {        \
             AESState round_key;                                           \
@@ -309,7 +309,7 @@ void HELPER(vaeskf1_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
     uint32_t vta = vext_vta(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     uimm &= 0b1111;
     if (uimm > 10 || uimm == 0) {
@@ -357,7 +357,7 @@ void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
     uint32_t vta = vext_vta(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     uimm &= 0b1111;
     if (uimm > 14 || uimm < 2) {
@@ -465,7 +465,7 @@ void HELPER(vsha2ms_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         if (sew == MO_32) {
@@ -582,7 +582,7 @@ void HELPER(vsha2ch32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
@@ -602,7 +602,7 @@ void HELPER(vsha2ch64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
@@ -622,7 +622,7 @@ void HELPER(vsha2cl32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
@@ -642,7 +642,7 @@ void HELPER(vsha2cl64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
@@ -676,7 +676,7 @@ void HELPER(vsm3me_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
     uint32_t *vs1 = vs1_vptr;
     uint32_t *vs2 = vs2_vptr;
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (int i = env->vstart / 8; i < env->vl / 8; i++) {
         uint32_t w[24];
@@ -777,7 +777,7 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     uint32_t *vs2 = vs2_vptr;
     uint32_t v1[8], v2[8], v3[8];
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (int i = env->vstart / 8; i < env->vl / 8; i++) {
         for (int k = 0; k < 8; k++) {
@@ -802,7 +802,7 @@ void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
     uint32_t vta = vext_vta(desc);
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         uint64_t Y[2] = {vd[i * 2 + 0], vd[i * 2 + 1]};
@@ -841,7 +841,7 @@ void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
     uint32_t vta = vext_vta(desc);
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         uint64_t Y[2] = {brev8(vd[i * 2 + 0]), brev8(vd[i * 2 + 1])};
@@ -879,7 +879,7 @@ void HELPER(vsm4k_vi)(void *vd, void *vs2, uint32_t uimm5, CPURISCVState *env,
     uint32_t esz = sizeof(uint32_t);
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = group_start; i < group_end; ++i) {
         uint32_t vstart = i * egs;
@@ -937,7 +937,7 @@ void HELPER(vsm4r_vv)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t esz = sizeof(uint32_t);
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = group_start; i < group_end; ++i) {
         uint32_t vstart = i * egs;
@@ -973,7 +973,7 @@ void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t esz = sizeof(uint32_t);
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = group_start; i < group_end; ++i) {
         uint32_t vstart = i * egs;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 71b823d..217d2f6 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -260,7 +260,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
@@ -383,10 +383,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t msize = nf * esz;
     int mmu_index = riscv_env_mmu_index(env, false);
 
-    if (env->vstart >= evl) {
-        env->vstart = 0;
-        return;
-    }
+    VSTART_CHECK_EARLY_EXIT(env, evl);
 
 #if defined(CONFIG_USER_ONLY)
     /*
@@ -544,7 +541,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     /* load bytes from guest memory */
     for (i = env->vstart; i < env->vl; env->vstart = ++i) {
@@ -638,7 +635,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     int flags;
     void *host;
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     addr = base + ((env->vstart * nf) << log2_esz);
     page_split = -(addr | TARGET_PAGE_MASK);
@@ -1116,7 +1113,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -1150,7 +1147,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
-    VSTART_CHECK_EARLY_EXIT(env);                                        \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
                                                                          \
     for (i = env->vstart; i < vl; i++) {                                 \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
@@ -1187,7 +1184,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -1227,7 +1224,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
     uint32_t i;                                                 \
                                                                 \
-    VSTART_CHECK_EARLY_EXIT(env);                               \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                           \
                                                                 \
     for (i = env->vstart; i < vl; i++) {                        \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
@@ -1325,7 +1322,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vma = vext_vma(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -1374,7 +1371,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     uint32_t vma = vext_vma(desc);                          \
     uint32_t i;                                             \
                                                             \
-    VSTART_CHECK_EARLY_EXIT(env);                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                       \
                                                             \
     for (i = env->vstart; i < vl; i++) {                    \
         if (!vm && !vext_elem_mask(v0, i)) {                \
@@ -1438,7 +1435,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -1505,7 +1502,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
-    VSTART_CHECK_EARLY_EXIT(env);                                   \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                               \
                                                                     \
     for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
@@ -2054,7 +2051,7 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
@@ -2080,7 +2077,7 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
@@ -2105,7 +2102,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
@@ -2131,7 +2128,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
@@ -2178,7 +2175,7 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -2305,7 +2302,7 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -3104,7 +3101,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
                                                           \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
@@ -3149,7 +3146,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
                                                           \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
@@ -3737,7 +3734,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
-    VSTART_CHECK_EARLY_EXIT(env);                      \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                  \
                                                        \
     if (vl == 0) {                                     \
         return;                                        \
@@ -4260,7 +4257,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -4302,7 +4299,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
-    VSTART_CHECK_EARLY_EXIT(env);                                   \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                               \
                                                                     \
     for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
@@ -4497,7 +4494,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -4827,7 +4824,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     int a, b;                                             \
                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
                                                           \
     for (i = env->vstart; i < vl; i++) {                  \
         a = vext_elem_mask(vs1, i);                       \
@@ -5022,7 +5019,7 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
     uint32_t vma = vext_vma(desc);                                        \
     int i;                                                                \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -5059,7 +5056,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong offset = s1, i_min, i;                                   \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     i_min = MAX(env->vstart, offset);                                     \
     for (i = i_min; i < vl; i++) {                                        \
@@ -5094,7 +5091,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong i_max, i_min, i;                                         \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
     i_max = MAX(i_min, env->vstart);                                      \
@@ -5138,7 +5135,7 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                          \
     uint32_t i;                                                             \
                                                                             \
-    VSTART_CHECK_EARLY_EXIT(env);                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                       \
                                                                             \
     for (i = env->vstart; i < vl; i++) {                                    \
         if (!vm && !vext_elem_mask(v0, i)) {                                \
@@ -5189,7 +5186,7 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                            \
     uint32_t i;                                                               \
                                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                         \
                                                                               \
     for (i = env->vstart; i < vl; i++) {                                      \
         if (!vm && !vext_elem_mask(v0, i)) {                                  \
@@ -5266,7 +5263,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint64_t index;                                                       \
     uint32_t i;                                                           \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -5311,7 +5308,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint64_t index = s1;                                                  \
     uint32_t i;                                                           \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -5407,7 +5404,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
     uint32_t vma = vext_vma(desc);                               \
     uint32_t i;                                                  \
                                                                  \
-    VSTART_CHECK_EARLY_EXIT(env);                                \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                            \
                                                                  \
     for (i = env->vstart; i < vl; i++) {                         \
         if (!vm && !vext_elem_mask(v0, i)) {                     \
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 05b2d01..b490b1d 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -66,7 +66,7 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vma = vext_vma(desc);
     uint32_t i;
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -92,7 +92,7 @@ void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
     uint32_t vma = vext_vma(desc);
     uint32_t i;
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index a11cc83..8eee7e5 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -25,11 +25,11 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 
-#define VSTART_CHECK_EARLY_EXIT(env) do { \
-    if (env->vstart >= env->vl) {         \
-        env->vstart = 0;                  \
-        return;                           \
-    }                                     \
+#define VSTART_CHECK_EARLY_EXIT(env, vl) do { \
+    if (env->vstart >= vl) {                  \
+        env->vstart = 0;                      \
+        return;                               \
+    }                                         \
 } while (0)
 
 static inline uint32_t vext_nf(uint32_t desc)
@@ -159,7 +159,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
-    VSTART_CHECK_EARLY_EXIT(env);                      \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                  \
                                                        \
     for (i = env->vstart; i < vl; i++) {               \
         if (!vm && !vext_elem_mask(v0, i)) {           \
-- 
2.48.1


