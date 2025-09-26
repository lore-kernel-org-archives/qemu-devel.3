Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB6ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27uo-0005Pd-N2; Fri, 26 Sep 2025 08:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27ul-0005PA-1B; Fri, 26 Sep 2025 08:51:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27uW-0007fP-4w; Fri, 26 Sep 2025 08:51:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C65CC157F67;
 Fri, 26 Sep 2025 15:45:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 34CCD290F25;
 Fri, 26 Sep 2025 15:45:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 31/38] target/sparc: Relax decode of rs2_or_imm for v7
Date: Fri, 26 Sep 2025 15:45:31 +0300
Message-ID: <20250926124540.2221746-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

For v7, bits [12:5] are ignored for !imm.
For v8, those same bits are reserved, but are not trapped.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit df663ac0a4e5d916b6b3e77552a925fec02bced4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b54285e491..45956673f7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2527,6 +2527,32 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS4(C)    false
 #endif
 
+/*
+ * We decoded bit 13 as imm, and bits [12:0] as rs2_or_imm.
+ * For v9, if !imm, then the unused bits [12:5] must be zero.
+ * For v7 and v8, the unused bits are ignored; clear them here.
+ */
+static bool check_rs2(DisasContext *dc, int *rs2)
+{
+    if (unlikely(*rs2 & ~0x1f)) {
+        if (avail_64(dc)) {
+            return false;
+        }
+        *rs2 &= 0x1f;
+    }
+    return true;
+}
+
+static bool check_r_r_ri(DisasContext *dc, arg_r_r_ri *a)
+{
+    return a->imm || check_rs2(dc, &a->rs2_or_imm);
+}
+
+static bool check_r_r_ri_cc(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    return a->imm || check_rs2(dc, &a->rs2_or_imm);
+}
+
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
 {
@@ -3250,8 +3276,7 @@ static bool do_wr_special(DisasContext *dc, arg_r_r_ri *a, bool priv,
 {
     TCGv src;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && (a->rs2_or_imm & ~0x1f)) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
     if (!priv) {
@@ -3694,8 +3719,7 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a,
 {
     TCGv dst, src1;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri_cc(dc, a)) {
         return false;
     }
 
@@ -3779,11 +3803,11 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
     if (!a->cc && a->rs1 == 0) {
+        if (!check_r_r_ri_cc(dc, a)) {
+            return false;
+        }
         if (a->imm || a->rs2_or_imm == 0) {
             gen_store_gpr(dc, a->rd, tcg_constant_tl(a->rs2_or_imm));
-        } else if (a->rs2_or_imm & ~0x1f) {
-            /* For simplicity, we under-decoded the rs2 form. */
-            return false;
         } else {
             gen_store_gpr(dc, a->rd, cpu_regs[a->rs2_or_imm]);
         }
@@ -3800,8 +3824,7 @@ static bool trans_UDIV(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_DIV(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -3852,8 +3875,7 @@ static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_64(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -3890,8 +3912,7 @@ static bool trans_SDIVX(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_64(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -4187,8 +4208,7 @@ TRANS(SRA_i, ALL, do_shift_i, a, false, false)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!imm && rs2_or_imm & ~0x1f) {
+    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
         return NULL;
     }
     if (imm || rs2_or_imm == 0) {
@@ -4251,8 +4271,7 @@ static bool do_add_special(DisasContext *dc, arg_r_r_ri *a,
 {
     TCGv src1, sum;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -4370,8 +4389,7 @@ static TCGv gen_ldst_addr(DisasContext *dc, int rs1, bool imm, int rs2_or_imm)
 {
     TCGv addr, tmp = NULL;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!imm && rs2_or_imm & ~0x1f) {
+    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
         return NULL;
     }
 
-- 
2.47.3


