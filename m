Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFD2C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ldT-0004AA-OE; Wed, 16 Sep 2026 05:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldN-0003y6-AU; Wed, 16 Sep 2026 05:08:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldL-0007RU-AS; Wed, 16 Sep 2026 05:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549560; bh=5gPQAkCLSSrx0K3p8MYccSoLuD1B7NlHnPdfgv1mdR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nQlEPmZNQ6NRatkQxgi2KUQvKBGp5rUdH0iY2IuglKkO4yccRJDIVC872InxZk2Jn
 Jsawbh09w/rbmrXv4B8PKXIZacYGasOIzX3ZgMzKMM4q8eDFc0nKAzxkceq3iZFIl1
 VWWo5YFPa+/R6LzblmJrxnucwj7S7rHPyMFj8QxaZCm/ubnkikKM230ASsrKhlaLs/
 VKVnP8t7AHutMPL3h2dpsdmQZr4IQBXBwzu10lHrdUu8STL6UWSqdzPBkIcMsMiDY1
 ddx91foItpB4WBwfQmfl8IJI2etsJoO1C1hGnX7XWXwfHniJPQ4HzlDX5/DxUoNxEi
 nSAjtYVn2PbTQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E80EF1D56D2;
 Wed, 16 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93CA3429E1C;
 Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7F3455A793; Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 29/57] target/arm: Make IT insn undef when not present
Date: Wed, 16 Sep 2026 12:03:53 +0300
Message-ID: <20260916090516.677749-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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
index 515db84af16..b480f6f65ea 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1,3 +1,4 @@
+
 /*
  *  ARM translation
  *
@@ -6008,6 +6009,16 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
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


