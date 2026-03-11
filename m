Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164141125892
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLW-0007ji-Cz; Wed, 11 Mar 2026 15:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PLU-0007ii-Fk; Wed, 11 Mar 2026 15:35:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PLS-00008a-BF; Wed, 11 Mar 2026 15:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257667; bh=YtDoghmkkyVJMChQomssBGKozuJ8XG9j41PlyEXUoaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xYsLZJJM2VTN7GYCx6sqoyZmspq9Cne/DYm/TABier9j0ORlg7DE4nlMrUaz/IMoZ
 7G5lehVw7up9eZu1CWcMxovzBV84uoplUr2fsxspfF6Fuhs3cDTUv4PwbQeQkdGBUq
 bwysDF682MDK7KHcmga5TJwBqNqmFEqrfQ2kcnYPth/di2W/GGNL13cBE51TSsikHz
 en8+zrMLXSY9Soy+MV7p3oUo4O8yw0p3Cn7KZOVbrKlLRkltSztzm2oJvYYR/WJ6nl
 XiIV2cfnwoZUGvnqeU/oZKQZsq4WDOBBAdsLnNLLJRL4sblT9OTO4SbAyVqmkDeCgp
 7iPaEcNOw0j4A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C5451920F4;
 Wed, 11 Mar 2026 22:34:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4E9AA37C459;
 Wed, 11 Mar 2026 22:35:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 12/53] target/arm: Fix feature check in DO_SVE2_RRX,
 DO_SVE2_RRX_TB
Date: Wed, 11 Mar 2026 22:34:05 +0300
Message-ID: <20260311193449.1096110-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In the macros DO_SVE2_RRX and DO_SVE2_RRX_TB we use the
feature check aa64_sve, thus exposing this set of instructions
in SVE as well as SVE2. Use aa64_sve2 instead, so they UNDEF
on an SVE1-only CPU as they should.

Strictly, the condition here should be "SVE2 or SME"; but we
will correct that in a following commit with all the other
missing "or SME" checks.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260202133353.2231685-4-peter.maydell@linaro.org
(cherry picked from commit ee5bf0962ed6e0eb42d6bc9bfb3687f2408e3580)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 07b827fa8e..d69a2f5d75 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3769,7 +3769,7 @@ TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_2h, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
 
 DO_SVE2_RRX(MUL_zzx_h, gen_helper_gvec_mul_idx_h)
@@ -3787,7 +3787,7 @@ DO_SVE2_RRX(SQRDMULH_zzx_d, gen_helper_sve2_sqrdmulh_idx_d)
 #undef DO_SVE2_RRX
 
 #define DO_SVE2_RRX_TB(NAME, FUNC, TOP) \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, (a->index << 1) | TOP)
 
 DO_SVE2_RRX_TB(SQDMULLB_zzx_s, gen_helper_sve2_sqdmull_idx_s, false)
-- 
2.47.3


