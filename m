Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB01C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQq-0001pR-H9; Wed, 12 Aug 2026 10:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQY-0001XY-He; Wed, 12 Aug 2026 10:59:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQW-0001fR-IE; Wed, 12 Aug 2026 10:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=UQSuvcekvtULWBPPBsVtcH5RNYJmKi/a280gMyY1RTM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b8shl5n4myrubxkZIUq12o/Q/yh9uSpddpbPnNx1T4RxVwZtTrOYcV5AGZO0pRym+
 8mVm6xMcxyO8WMvraMp5puyUgFtKZZt5SIIp0tATP+0bEwZpau8/YhtskQ/ORX8Kcu
 MbEwqVjA6US1VbmqKKAGiewOAsUv3veLb/uotVSoBhgKh1o3cAFoMcadtfyy1aqq2g
 dyLUpyhTEsgs1VOUkXwLEvbD1/tslIha3pA5xxLc1am8BH0i2cxXkSj4ij5R2v90k2
 WpGlky0VJnFpm7iDm3ir/2fhSQ/10B9Fto4gg8k4SrlRZZZosQYDMg9dnVVZYng0R2
 2oLMAf1PzSqNg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4404C1CA65D;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9EEA3409D9F;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0904D2FA15; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 089/120] target/arm: Fix b16b16 feature test for SME2
 BFCLAMP, BFMAX, BFMIN
Date: Wed, 12 Aug 2026 17:49:12 +0300
Message-ID: <20260812144955.649205-89-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Richard Henderson <richard.henderson@linaro.org>

These are controlled by FEAT_SVE_B16B16 not FEAT_SME_B16B16.

Cc: qemu-stable@nongnu.org
Fixes: bc65d2bd1cb ("target/arm: Implement SME2 Multiple and Single SVE Destructive")
Fixes: 930760eb753 ("target/arm: Implement SME2 Multiple Vectors SVE Destructive")
Fixes: 8b61eff8e72 ("target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 702252a0dbc3ad9a51e4092a986b2f98e8c6adcb)
(Mjt: context fixup across v11.0.0-1336-g1de033cf3e08
 "target/arm: Implement FEAT_FAMINMAX for SME")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 6064ed86970..abe73c038bc 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -709,7 +709,7 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     TCGv_ptr fpst;
 
     /* These insns use MO_8 to encode BFloat16. */
-    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
@@ -744,7 +744,7 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
     gen_helper_gvec_3_ptr *fn;
     TCGv_ptr fpst;
 
-    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
@@ -1628,7 +1628,7 @@ static bool trans_FCLAMP(DisasContext *s, arg_zzz_en *a)
         return false;
     }
     /* This insn uses MO_8 to encode BFloat16. */
-    if (a->esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
-- 
2.47.3


