Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B665C5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMI3B-0004LU-Mw; Mon, 02 Jun 2025 23:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uMI38-0004LB-Ke; Mon, 02 Jun 2025 23:10:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uMI35-0007hh-MI; Mon, 02 Jun 2025 23:10:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxeXGsZz5oaJYJAQ--.31663S3;
 Tue, 03 Jun 2025 11:10:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCx7xuqZz5olg4GAQ--.20522S2;
 Tue, 03 Jun 2025 11:10:34 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
Subject: [PATCH v2] target/loongarch: add check for fcond
Date: Tue,  3 Jun 2025 10:48:09 +0800
Message-Id: <20250603024810.350510-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx7xuqZz5olg4GAQ--.20522S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

fcond only has 22 types, add a check for fcond.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2972

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 .../loongarch/tcg/insn_trans/trans_fcmp.c.inc | 25 +++++++++++++------
 .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 +++++++++---
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
index 3babf69e4a..6a2c030a6b 100644
--- a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
@@ -4,10 +4,15 @@
  */
 
 /* bit0(signaling/quiet) bit1(lt) bit2(eq) bit3(un) bit4(neq) */
-static uint32_t get_fcmp_flags(int cond)
+static uint32_t get_fcmp_flags(DisasContext *ctx, int cond)
 {
     uint32_t flags = 0;
 
+    /*check cond , cond =[0-8,10,12] */
+    if ((cond > 8) &&(cond != 10) && (cond != 12)) {
+        return -1;
+    }
+
     if (cond & 0x1) {
         flags |= FCMP_LT;
     }
@@ -26,9 +31,14 @@ static uint32_t get_fcmp_flags(int cond)
 static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
 {
     TCGv var, src1, src2;
-    uint32_t flags;
+    uint32_t flags = get_fcmp_flags(ctx, a->fcond >>1);
     void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
 
+    if (flags == -1) {
+        generate_exception(ctx, EXCCODE_INE);
+        return true;
+    }
+
     if (!avail_FP_SP(ctx)) {
         return false;
     }
@@ -39,8 +49,6 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_s : gen_helper_fcmp_c_s);
-    flags = get_fcmp_flags(a->fcond >> 1);
-
     fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
 
     tcg_gen_st8_tl(var, tcg_env, offsetof(CPULoongArchState, cf[a->cd]));
@@ -50,9 +58,14 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
 static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
 {
     TCGv var, src1, src2;
-    uint32_t flags;
+    uint32_t flags = get_fcmp_flags(ctx, a->fcond >> 1);
     void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
 
+    if (flags == -1) {
+        generate_exception(ctx, EXCCODE_INE);
+        return true;
+    }
+
     if (!avail_FP_DP(ctx)) {
         return false;
     }
@@ -63,8 +76,6 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_d : gen_helper_fcmp_c_d);
-    flags = get_fcmp_flags(a->fcond >> 1);
-
     fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
 
     tcg_gen_st8_tl(var, tcg_env, offsetof(CPULoongArchState, cf[a->cd]));
diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 7a1309a32d..d87c722dcc 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -4658,19 +4658,23 @@ TRANS(xvslti_du, LASX, do_xcmpi, MO_64, TCG_COND_LTU)
 
 static bool do_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
 {
-    uint32_t flags;
+    uint32_t flags = get_fcmp_flags(ctx, a->fcond >> 1);
     void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
     TCGv_i32 oprsz = tcg_constant_i32(sz);
 
+    if(flags == -1){
+        generate_exception(ctx, EXCCODE_INE);
+        return true;
+    }
+
     if (!check_vec(ctx, sz)) {
         return true;
     }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
-    flags = get_fcmp_flags(a->fcond >> 1);
     fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
 
     return true;
@@ -4678,19 +4682,23 @@ static bool do_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
 
 static bool do_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
 {
-    uint32_t flags;
+    uint32_t flags = get_fcmp_flags(ctx, a->fcond >> 1);
     void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
     TCGv_i32 oprsz = tcg_constant_i32(sz);
 
+    if (flags == -1) {
+        generate_exception(ctx, EXCCODE_INE);
+        return true;
+    }
+
     if (!check_vec(ctx, sz)) {
         return true;
     }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
-    flags = get_fcmp_flags(a->fcond >> 1);
     fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
 
     return true;
-- 
2.34.1


