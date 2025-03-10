Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB33C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 02:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trT1Y-0003eX-KI; Sun, 09 Mar 2025 22:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1trT1W-0003db-5f; Sun, 09 Mar 2025 22:37:46 -0400
Received: from out28-149.mail.aliyun.com ([115.124.28.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1trT1T-0003Qo-FV; Sun, 09 Mar 2025 22:37:45 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.booCGfo_1741574252 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 10 Mar 2025 10:37:32 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: alistair23@gmail.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 lc00631@tecorigin.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 zqz00548@tecorigin.com
Subject: [PATCH v4 2/2] target/riscv: fix handling of nop for vstart >= vl in
 some vector instruction
Date: Mon, 10 Mar 2025 10:35:25 +0800
Message-ID: <b2649f14915150be4c602d63cd3ea4adf47e9d75.1741573286.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1741573286.git.lc00631@tecorigin.com>
References: <cover.1741573286.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.149;
 envelope-from=lc00631@tecorigin.com; helo=out28-149.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Recently, when I was writing a RISCV test, I found that when VL is set to 0, the
instruction should be nop, but when I tested it, I found that QEMU will treat
all elements as tail elements, and in the case of VTA=1, write all elements
to 1.

After troubleshooting, it was found that the vext_vx_rm_1 function was called in
the vext_vx_rm_2, and then the vext_set_elems_1s function was called to process
the tail element, but only VSTART >= vl was checked in the vext_vx_rm_1
function, which caused the tail element to still be processed even if it was
returned in advance.

So I've made the following change:

Put VSTART_CHECK_EARLY_EXIT(env) at the beginning of the vext_vx_rm_2 function,
so that the VSTART register is checked correctly.

Fixes: df4252b2ec ("target/riscv/vector_helpers: do early exit when
vstart >= vl")
Signed-off-by: Chao Liu <lc00631@tecorigin.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 217d2f6..67b3baf 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2175,8 +2175,6 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env, vl);
-
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2200,6 +2198,8 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vta = vext_vta(desc);
     uint32_t vma = vext_vma(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
     switch (env->vxrm) {
     case 0: /* rnu */
         vext_vv_rm_1(vd, v0, vs1, vs2,
@@ -2302,8 +2302,6 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env, vl);
-
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2327,6 +2325,8 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
     uint32_t vta = vext_vta(desc);
     uint32_t vma = vext_vma(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
     switch (env->vxrm) {
     case 0: /* rnu */
         vext_vx_rm_1(vd, v0, s1, vs2,
@@ -4662,6 +4662,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     TD s1 =  *((TD *)vs1 + HD(0));                        \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
+                                                          \
     for (i = env->vstart; i < vl; i++) {                  \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
@@ -4750,6 +4752,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
     uint32_t i;                                            \
     TD s1 =  *((TD *)vs1 + HD(0));                         \
                                                            \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                      \
+                                                           \
     for (i = env->vstart; i < vl; i++) {                   \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
         if (!vm && !vext_elem_mask(v0, i)) {               \
@@ -4914,6 +4918,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
     int i;
     bool first_mask_bit = false;
 
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -4986,6 +4992,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -5344,6 +5352,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t num = 0, i;                                                  \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vext_elem_mask(vs1, i)) {                                    \
             continue;                                                     \
-- 
2.48.1


