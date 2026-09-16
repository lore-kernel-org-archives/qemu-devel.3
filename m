Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABCFC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ldT-00049w-Qk; Wed, 16 Sep 2026 05:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldL-0003w9-37; Wed, 16 Sep 2026 05:08:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldJ-0007Pz-Av; Wed, 16 Sep 2026 05:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549560; bh=bENLbQuW/cWME8k7e48VF18YPWnTClhuUH86cmvfzIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K+ZCuScwHUJjoj5foP3qaCzNzaBUtUKCpYb5PbLQY8IScYyA6TWw1GbApRwz5w4Jq
 sxFSDRo5Dkhid+JRq2BgqaYFyPgCpTBdYXpxvpeVxHEt/+5AF5/OBhB1bn3n14Yg1V
 RFB5ZXz+FE45ZUosoxLVy9V3xs2yvLvYd8xX+n6o2fBFTTp90GMXhrwLixjneI61hx
 /A6zT3MdxcZYhzIWySqNs7PpWF38b9QY+NJsZKkfz2xdG6sgyQks1rkNiMV+wq0OzF
 NWfJpCN1eihhK1pEENNUoEUuawehlv+Bv9Tw4Yr9jvUL8CL+Xh9qzP7JQv+bgK08QC
 nlnyKSGsWqNfQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E34531D56D1;
 Wed, 16 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F306429E1B;
 Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7C4E95A791; Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 28/57] target/arm: Make CBZ/CBNZ UNDEF before v6T2
Date: Wed, 16 Sep 2026 12:03:52 +0300
Message-ID: <20260916090516.677749-28-mjt@tls.msk.ru>
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
index c57d1a6e73b..515db84af16 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5753,7 +5753,14 @@ static bool trans_TBH(DisasContext *s, arg_tbranch *a)
 
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


