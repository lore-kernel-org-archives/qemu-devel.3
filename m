Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C30C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua98G-0007mc-6a; Fri, 11 Jul 2025 04:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8zZ-0000HB-4J; Fri, 11 Jul 2025 04:20:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8zV-0004Ne-Os; Fri, 11 Jul 2025 04:20:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 02ADB1356E6;
 Fri, 11 Jul 2025 11:17:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EE32A23FA5B;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 27/39] target/loongarch: add check for fcond
Date: Fri, 11 Jul 2025 11:16:23 +0300
Message-ID: <20250711081745.1785806-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Song Gao <gaosong@loongson.cn>

fcond only has 22 types, add a check for fcond.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2972

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250603024810.350510-1-gaosong@loongson.cn>
(cherry picked from commit e7788da9860c97920c19fa1150806186513ef256)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
index dff92772ad..d6f0560349 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -4655,19 +4655,23 @@ TRANS(xvslti_du, LASX, do_xcmpi, MO_64, TCG_COND_LTU)
 
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
@@ -4675,19 +4679,23 @@ static bool do_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
 
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
2.47.2


