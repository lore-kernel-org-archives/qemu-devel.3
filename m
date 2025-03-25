Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C1EC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyAe-0000Ol-9M; Tue, 25 Mar 2025 02:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twyA2-0007BE-1Y; Tue, 25 Mar 2025 02:53:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9y-0001zw-7j; Tue, 25 Mar 2025 02:53:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 01FF4107D81;
 Tue, 25 Mar 2025 09:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 98D661D5E8C;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8894157060; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 63/69] target/ppc: Fix facility interrupt checks for VSX
Date: Tue, 25 Mar 2025 09:50:36 +0300
Message-Id: <20250325065043.3263864-12-mjt@tls.msk.ru>
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

From: Nicholas Piggin <npiggin@gmail.com>

Facility interrupt checks in general should come after the ISA version
check, because the facility interrupt and facility type themselves are
ISA dependent and should not appear on CPUs where the instruction does
not exist at all.

This resolves a QEMU crash booting NetBSD/macppc due to

  qemu: fatal: Raised an exception without defined vector 94

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2741
Cc: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Debugged-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: aa0f34ec3fc7 ("target/ppc: implement vrlq")
Fixes: 7419dc5b2b5b ("target/ppc: Move VSX vector storage access insns to decodetree.")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 8defe9da08135d03e054f20cb8fea4389be96e18)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 70d0ad2e71..92d6e8c603 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -994,8 +994,8 @@ static bool do_vector_rotl_quad(DisasContext *ctx, arg_VX *a, bool mask,
 {
     TCGv_i64 ah, al, vrb, n, t0, t1, zero = tcg_constant_i64(0);
 
-    REQUIRE_VECTOR(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA310);
+    REQUIRE_VECTOR(ctx);
 
     ah = tcg_temp_new_i64();
     al = tcg_temp_new_i64();
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index a869f30e86..00ad57c628 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -61,8 +61,8 @@ static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
     TCGv EA;
     TCGv_i64 t0;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
@@ -80,8 +80,8 @@ static bool trans_LXVW4X(DisasContext *ctx, arg_LXVW4X *a)
     TCGv EA;
     TCGv_i64 xth, xtl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
@@ -113,12 +113,12 @@ static bool trans_LXVWSX(DisasContext *ctx, arg_LXVWSX *a)
     TCGv EA;
     TCGv_i32 data;
 
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     if (a->rt < 32) {
         REQUIRE_VSX(ctx);
     } else {
         REQUIRE_VECTOR(ctx);
     }
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
@@ -133,8 +133,8 @@ static bool trans_LXVDSX(DisasContext *ctx, arg_LXVDSX *a)
     TCGv EA;
     TCGv_i64 data;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
@@ -185,8 +185,8 @@ static bool trans_LXVH8X(DisasContext *ctx, arg_LXVH8X *a)
     TCGv EA;
     TCGv_i64 xth, xtl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
@@ -208,8 +208,8 @@ static bool trans_LXVB16X(DisasContext *ctx, arg_LXVB16X *a)
     TCGv EA;
     TCGv_i128 data;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
@@ -312,8 +312,8 @@ static bool trans_STXVD2X(DisasContext *ctx, arg_STXVD2X *a)
     TCGv EA;
     TCGv_i64 t0;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
@@ -331,8 +331,8 @@ static bool trans_STXVW4X(DisasContext *ctx, arg_STXVW4X *a)
     TCGv EA;
     TCGv_i64 xsh, xsl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
@@ -364,8 +364,8 @@ static bool trans_STXVH8X(DisasContext *ctx, arg_STXVH8X *a)
     TCGv EA;
     TCGv_i64 xsh, xsl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
@@ -394,8 +394,8 @@ static bool trans_STXVB16X(DisasContext *ctx, arg_STXVB16X *a)
     TCGv EA;
     TCGv_i128 data;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
-- 
2.39.5


