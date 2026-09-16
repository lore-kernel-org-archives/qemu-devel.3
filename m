Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC92C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n3L-0007J2-J0; Wed, 16 Sep 2026 06:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2N-000611-Uj; Wed, 16 Sep 2026 06:38:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2L-0001ze-1Z; Wed, 16 Sep 2026 06:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=i2eTjwAS15hDaE5AkghnwVPezGdJR8H9au733wSuoIs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xrFd35O4pgMtGa49uKuVZj0TWtpI+GrDum0Mtwwwgy0uGe2MaORTU0QnGFwjoiC1L
 5wsnMBLhkNB05HQXI6Ojvqa4NyT4vygSjT2dlQWM3ApeD/kyIlsMPRqyLbWvQZso2a
 B+5pOQabACx2fdAlIufmuG0z3xsNod3AH8fwxjTTbKY2P9V6xnIIDDly7jXXb4BAw6
 tO9Njc8uqf7XNlihTftwDdx3rzEpKQTowPWbM8YApYJ6HHlTM7fz4A01Wragbd1II5
 XDbmb5ksC9OZTheBOGEW8IeYdZlwaU57lDOP3ccd/z7h8ngtSp/qG5T6sWzj0sl62k
 H2jixvRplnrRA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B4B91D580F;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C9FFA429F6D;
 Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B45965A817; Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 27/56] target/arm: Make IT insn undef when not present
Date: Wed, 16 Sep 2026 13:35:45 +0300
Message-ID: <20260916103622.684817-27-mjt@tls.msk.ru>
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

The IT insn is introduced for A-profile starting in v6T2; for
M-profile it is present when the Main Extension is implemented (which
includes v7M and excludes v6M).  We were missing the feature-check,
so fail to UNDEF on earlier cores.

Add the missing check.

Cc: qemu-stable@nongnu.org
Fixes: 9ee6e8bb853bde ("ARMv7 support.")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821132550.168896-3-peter.maydell@linaro.org
(cherry picked from commit 50d6757147dbc74b1b904535afaf986f72e942ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index df98dc2e34d..3d352497a70 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1,3 +1,4 @@
+
 /*
  *  ARM translation
  *
@@ -6038,6 +6039,16 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
 {
     int cond_mask = a->cond_mask;
 
+    /*
+     * IT insn introduced in v6T2 for A-profile; it is only present
+     * on M-profile if the Main Extension is implemented.
+     */
+    if (!(arm_dc_feature(s, ARM_FEATURE_M)
+          ? arm_dc_feature(s, ARM_FEATURE_M_MAIN)
+          : arm_dc_feature(s, ARM_FEATURE_THUMB2))) {
+        return false;
+    }
+
     /*
      * No actual code generated for this insn, just setup state.
      *
-- 
2.47.3


