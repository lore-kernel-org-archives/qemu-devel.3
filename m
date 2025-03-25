Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5814BC3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyBL-0002Pw-AP; Tue, 25 Mar 2025 02:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twyAb-0000Fg-3t; Tue, 25 Mar 2025 02:53:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twyAP-000215-FF; Tue, 25 Mar 2025 02:53:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F0BF107D84;
 Tue, 25 Mar 2025 09:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A472B1D5E8F;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8FF9357066; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chao Liu <lc00631@tecorigin.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 66/69] target/riscv: refactor VSTART_CHECK_EARLY_EXIT()
 to accept vl as a parameter
Date: Tue, 25 Mar 2025 09:50:39 +0300
Message-Id: <20250325065043.3263864-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chao Liu <lc00631@tecorigin.com>

Some vector instructions are special, such as the vlm.v instruction,
where setting its vl actually sets evl = (vl + 7) >> 3. To improve
maintainability, we will uniformly use VSTART_CHECK_EARLY_EXIT() to
check for the condition vstart >= vl. This function will also handle
cases involving evl.

Fixes: df4252b2ec ("target/riscv/vector_helpers: do early exit when
vstart >= vl")
Signed-off-by: Chao Liu <lc00631@tecorigin.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <f575979874e323a9e0da7796aa391c7d87e56f88.1741573286.git.lc00631@tecorigin.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e83845316abcea9024eb5402a6c5eb8b092c79d5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index f7423df226..1526de96f5 100644
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
index 3731500717..08c7b4eaaf 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -265,7 +265,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
@@ -388,10 +388,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t msize = nf * esz;
     int mmu_index = riscv_env_mmu_index(env, false);
 
-    if (env->vstart >= evl) {
-        env->vstart = 0;
-        return;
-    }
+    VSTART_CHECK_EARLY_EXIT(env, evl);
 
     /* Calculate the page range of first page */
     addr = base + ((env->vstart * nf) << log2_esz);
@@ -533,7 +530,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     /* load bytes from guest memory */
     for (i = env->vstart; i < env->vl; env->vstart = ++i) {
@@ -625,7 +622,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     target_ulong addr, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     /* probe every access */
     for (i = env->vstart; i < env->vl; i++) {
@@ -1092,7 +1089,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -1126,7 +1123,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
-    VSTART_CHECK_EARLY_EXIT(env);                                        \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
                                                                          \
     for (i = env->vstart; i < vl; i++) {                                 \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
@@ -1163,7 +1160,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -1203,7 +1200,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
     uint32_t i;                                                 \
                                                                 \
-    VSTART_CHECK_EARLY_EXIT(env);                               \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                           \
                                                                 \
     for (i = env->vstart; i < vl; i++) {                        \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
@@ -1301,7 +1298,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vma = vext_vma(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -1350,7 +1347,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     uint32_t vma = vext_vma(desc);                          \
     uint32_t i;                                             \
                                                             \
-    VSTART_CHECK_EARLY_EXIT(env);                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                       \
                                                             \
     for (i = env->vstart; i < vl; i++) {                    \
         if (!vm && !vext_elem_mask(v0, i)) {                \
@@ -1414,7 +1411,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -1481,7 +1478,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
-    VSTART_CHECK_EARLY_EXIT(env);                                   \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                               \
                                                                     \
     for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
@@ -2030,7 +2027,7 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
@@ -2056,7 +2053,7 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
@@ -2081,7 +2078,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
@@ -2107,7 +2104,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
-    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
@@ -2154,7 +2151,7 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -2281,7 +2278,7 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env);
+    VSTART_CHECK_EARLY_EXIT(env, vl);
 
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -3080,7 +3077,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
                                                           \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
@@ -3125,7 +3122,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
                                                           \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
@@ -3713,7 +3710,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
-    VSTART_CHECK_EARLY_EXIT(env);                      \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                  \
                                                        \
     if (vl == 0) {                                     \
         return;                                        \
@@ -4236,7 +4233,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
@@ -4278,7 +4275,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
-    VSTART_CHECK_EARLY_EXIT(env);                                   \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                               \
                                                                     \
     for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
@@ -4473,7 +4470,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -4803,7 +4800,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     int a, b;                                             \
                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
                                                           \
     for (i = env->vstart; i < vl; i++) {                  \
         a = vext_elem_mask(vs1, i);                       \
@@ -4998,7 +4995,7 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
     uint32_t vma = vext_vma(desc);                                        \
     int i;                                                                \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -5035,7 +5032,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong offset = s1, i_min, i;                                   \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     i_min = MAX(env->vstart, offset);                                     \
     for (i = i_min; i < vl; i++) {                                        \
@@ -5070,7 +5067,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong i_max, i_min, i;                                         \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
     i_max = MAX(i_min, env->vstart);                                      \
@@ -5114,7 +5111,7 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                          \
     uint32_t i;                                                             \
                                                                             \
-    VSTART_CHECK_EARLY_EXIT(env);                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                       \
                                                                             \
     for (i = env->vstart; i < vl; i++) {                                    \
         if (!vm && !vext_elem_mask(v0, i)) {                                \
@@ -5165,7 +5162,7 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                            \
     uint32_t i;                                                               \
                                                                               \
-    VSTART_CHECK_EARLY_EXIT(env);                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                         \
                                                                               \
     for (i = env->vstart; i < vl; i++) {                                      \
         if (!vm && !vext_elem_mask(v0, i)) {                                  \
@@ -5242,7 +5239,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint64_t index;                                                       \
     uint32_t i;                                                           \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -5287,7 +5284,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint64_t index = s1;                                                  \
     uint32_t i;                                                           \
                                                                           \
-    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -5383,7 +5380,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
     uint32_t vma = vext_vma(desc);                               \
     uint32_t i;                                                  \
                                                                  \
-    VSTART_CHECK_EARLY_EXIT(env);                                \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                            \
                                                                  \
     for (i = env->vstart; i < vl; i++) {                         \
         if (!vm && !vext_elem_mask(v0, i)) {                     \
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 05b2d01e58..b490b1d398 100644
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
index 9e1e15b575..9d41bb3b10 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -24,11 +24,11 @@
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
@@ -158,7 +158,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
-    VSTART_CHECK_EARLY_EXIT(env);                      \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                  \
                                                        \
     for (i = env->vstart; i < vl; i++) {               \
         if (!vm && !vext_elem_mask(v0, i)) {           \
-- 
2.39.5


