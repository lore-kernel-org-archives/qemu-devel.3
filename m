Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307F9CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV7y-0005un-31; Sat, 13 Jun 2026 16:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7v-0005b2-8A; Sat, 13 Jun 2026 16:38:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7t-0003tP-Ho; Sat, 13 Jun 2026 16:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382964; bh=avXEFBMXyDcCefkdmfwuGAjiUyl870djlo++1qvZzJI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U+q5A3Oo0eBprxbIeEpL0s5/W6Y5GPbyKwECcm1cnbz8LHXvilLc0K+ZL2/H18jia
 zaAkg+5cr+5E4XtqQm92is1qNyecYpgQ3uZWIG/s7a427oSzEoTFgwY9StVoXExg+5
 r0NdKw5XbCyeZtndwGsvkjWIqk28xXRe/bbqCTAvgc3/s6AKbVL28a0ojpmlPhUtxr
 oJpWiMUBSdFIz6ZQwcmT6mP2QuIo9bBUH726+DB+DqH9C2PmmoCpUiwCpSq1/g3qH3
 gkanh3lRZq4XGza+FbRthYrK2G2nKwAqIEoDad9tGMsXbnCsj7oo5dTihi5licRHT3
 yUUKV9Mr4okFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2B7961B6EF8;
 Sat, 13 Jun 2026 23:36:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 936E33CE949;
 Sat, 13 Jun 2026 23:36:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 29/72] target/arm: Set correct fp flags for FLOGB when
 FPCR.AH = 1
Date: Sat, 13 Jun 2026 23:34:55 +0300
Message-ID: <20260613203542.1809153-29-mjt@tls.msk.ru>
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

Our implementation of the FLOGB insn does the operations entirely
in the helper function, without needing to use fpu functions.
This means it needs to handle all the fp status flags itself.
We aren't setting float_flag_input_denormal_used when we
use (i.e. do not flush to zero) an input denormal, which means
that FPCR.IDC isn't set when it should be for FPCR.AH=1.
We missed this when we added float_flag_input_denormal_used
and made the fpu/ code set it.

Add the missing float_raise().

Cc: qemu-stable@nongnu.org
Fixes: d38a57a3f ("target/arm: Enable FEAT_AFP for '-cpu max'")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260521122913.1565011-4-peter.maydell@linaro.org
(cherry picked from commit 23ece2805f9a3f90f317aac1b49ee45783b57636)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 179cbd74fb..d884ba474f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5036,6 +5036,7 @@ static int16_t do_float16_logb_as_int(float16 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -15 - clz32(frac);
             }
             /* flush to zero */
@@ -5064,6 +5065,7 @@ static int32_t do_float32_logb_as_int(float32 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -127 - clz32(frac);
             }
             /* flush to zero */
@@ -5092,6 +5094,7 @@ static int64_t do_float64_logb_as_int(float64 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -1023 - clz64(frac);
             }
             /* flush to zero */
-- 
2.47.3


