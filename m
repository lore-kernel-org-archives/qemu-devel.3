Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BCACD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV7u-0005RA-2H; Sat, 13 Jun 2026 16:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7r-0005JG-O9; Sat, 13 Jun 2026 16:38:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7p-0003mJ-Rs; Sat, 13 Jun 2026 16:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382964; bh=WoDzbd+bsFS1hjb4l+NXgUrDQ81yYUUXj+/8Gg3rZ10=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oQkV7kHEKKnssx0rVTwnWKay3rkAQuGsa8DoStteL701rDRsbGAH3h5ZmpqpIDqL6
 D7qI4ncEXHwrQfPTHUnh8pNLIRoCYByc8HiLv7tmkiWB9VcljslOywKAf6niwci83Y
 DUX123fDfnct9u0yhcWSKmyBpPD73f0xzOOsSBQPKaG7OAiZGn6F6Aq4ruAPQkTiA2
 hQPgHR7mN3BZWT102y4q1r5SKJ5AAq3wpYUU1/+I91acenzYZvIixHcvryR60APn3i
 HnzNg7XKHbGe/S5AO+jIZ5iTBX7U8RQ89Oc3VeCjD2TIp9IbwVQ1oMDtBYuhx0qAXW
 Wobv9Y9wplPlQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C0BD1B6EF6;
 Sat, 13 Jun 2026 23:36:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 756353CE947;
 Sat, 13 Jun 2026 23:36:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 27/72] target/arm: SVE2 FMAXP, FMINP must honour AH=1
Date: Sat, 13 Jun 2026 23:34:53 +0300
Message-ID: <20260613203542.1809153-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The behaviour of floating-point maximum and minimum insns has
some odd special cases when FPCR.AH=1. We get this right in most
places (for instance, the ASIMD FMAXP, FMINP) but forgot about
it for the SVE2 versions of FMAXP and FMINP.

Cc: qemu-stable@nongnu.org
Fixes: 384433e70983 ("target/arm: Implement FPCR.AH semantics for FMINP and FMAXP")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260521122913.1565011-2-peter.maydell@linaro.org
(cherry picked from commit 446050c4dfe4566ae3fcba9c6588c89a66ed4b33)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index c3541a8ca8..cd05dd0fb4 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -2914,6 +2914,20 @@ DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve2_ah_fmaxp_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fmaxp_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fmaxp_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve2_ah_fminp_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fminp_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fminp_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve2_eor3, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_bcax, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_bsl1n, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 062d8881bd..179cbd74fb 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -778,6 +778,14 @@ DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_h, float16, H1_2, float16_min)
 DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_s, float32, H1_4, float32_min)
 DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_d, float64, H1_8, float64_min)
 
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_h, float16, H1_2, helper_vfp_ah_maxh)
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_s, float32, H1_4, helper_vfp_ah_maxs)
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_d, float64, H1_8, helper_vfp_ah_maxd)
+
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_h, float16, H1_2, helper_vfp_ah_minh)
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_s, float32, H1_4, helper_vfp_ah_mins)
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_d, float64, H1_8, helper_vfp_ah_mind)
+
 #undef DO_ZPZZ_PAIR_FP
 
 /* Three-operand expander, controlled by a predicate, in which the
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bace3fda1..6a5c508743 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7666,8 +7666,8 @@ TRANS_FEAT_NONSTREAMING(HISTSEG, aa64_sve2, gen_gvec_ool_arg_zzz,
 DO_ZPZZ_FP(FADDP, aa64_sme_or_sve2, sve2_faddp_zpzz)
 DO_ZPZZ_FP(FMAXNMP, aa64_sme_or_sve2, sve2_fmaxnmp_zpzz)
 DO_ZPZZ_FP(FMINNMP, aa64_sme_or_sve2, sve2_fminnmp_zpzz)
-DO_ZPZZ_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz)
-DO_ZPZZ_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz)
+DO_ZPZZ_AH_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz, sve2_ah_fmaxp_zpzz)
+DO_ZPZZ_AH_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz, sve2_ah_fminp_zpzz)
 
 static bool do_fmmla(DisasContext *s, arg_rrrr_esz *a,
                      gen_helper_gvec_4_ptr *fn)
-- 
2.47.3


