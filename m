Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E521AC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n3o-0007z5-8J; Wed, 16 Sep 2026 06:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2L-0005rG-08; Wed, 16 Sep 2026 06:38:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2D-0001yx-VQ; Wed, 16 Sep 2026 06:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=djJszjwEWhZSV76xQmF5LHS0gSDaH7ORP7stN6fh+Zo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tY6qrEdoFKRMDeupYZYG2eCXYiyYaYP7y1q5FLeLt6JzMRGm7cU659TEcQvSJQatW
 saZuHAbUg9C8duXmHopT1n5NtsXeUgAj+4Pe1PuB9SyBMuEI0ce1U/gJs6cZWE2ekb
 TC+iC8Gx7w26BE+j4PRvkrHY5Y2w9qlAtvAd7j5vQ5qA+CVNSPOV+BPgCdq7rkmPSM
 0h7m0pXHmLEgkAHwq39+Dysrf6q4D0roD0XAzr9FaYi3Ua6CwaDWpGprdb9TpkFitk
 80qrEMCrtCyOyDbT0C/6kZX2q9vRg2138LBuF9Rjc9ZFl8Y0RKtmJwvJmoVcdrP7vF
 ekqjGhAM1te/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 065F21D580E;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C59C9429F6C;
 Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B17D35A815; Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 26/56] target/arm: Make CBZ/CBNZ UNDEF before v6T2
Date: Wed, 16 Sep 2026 13:35:44 +0300
Message-ID: <20260916103622.684817-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The Thumb CBZ/CBNZ encodings are only introduced in v6T2 (for
A-profile) and v7M (for M-profile).  We missed out the feature-check
in trans_CBZ(), so don't UNDEF on v5T or v6M.  Add the missing check:
conveniently, the ARM_FEATURE_THUMB2 feature is true for exactly the
cases where CBZ is implemented.

Cc: qemu-stable@nongnu.org
Fixes: 9ee6e8bb853bde ("ARMv7 support.")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821132550.168896-2-peter.maydell@linaro.org
(cherry picked from commit c05e01a885811f85c291ffa8513cb1d159b8c8b8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 055f3c5b403..df98dc2e34d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5783,7 +5783,14 @@ static bool trans_TBH(DisasContext *s, arg_tbranch *a)
 
 static bool trans_CBZ(DisasContext *s, arg_CBZ *a)
 {
-    TCGv_i32 tmp = load_reg(s, a->rn);
+    TCGv_i32 tmp;
+
+    /* CBZ was introduced in v6T2 and v7M */
+    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+        return false;
+    }
+
+    tmp = load_reg(s, a->rn);
 
     arm_gen_condlabel(s);
     tcg_gen_brcondi_i32(a->nz ? TCG_COND_EQ : TCG_COND_NE,
-- 
2.47.3


