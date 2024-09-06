Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B393CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWx1-0005TS-II; Fri, 06 Sep 2024 07:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwI-0001yU-9Z; Fri, 06 Sep 2024 07:15:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwG-00080r-IQ; Fri, 06 Sep 2024 07:15:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 612858C48C;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6E0C21336F6;
 Fri,  6 Sep 2024 14:13:26 +0300 (MSK)
Received: (nullmailer pid 353633 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 28/69] target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN
 if EL2 is not enabled
Date: Fri,  6 Sep 2024 14:12:37 +0300
Message-Id: <20240906111324.353230-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

When determining the current vector length, the SMCR_EL2.LEN and
SVCR_EL2.LEN settings should only be considered if EL2 is enabled
(compare the pseudocode CurrentSVL and CurrentNSVL which call
EL2Enabled()).

We were checking against ARM_FEATURE_EL2 rather than calling
arm_is_el2_enabled(), which meant that we would look at
SMCR_EL2/SVCR_EL2 when in Secure EL1 or Secure EL0 even if Secure EL2
was not enabled.

Use the correct check in sve_vqm1_for_el_sm().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-5-peter.maydell@linaro.org
(cherry picked from commit f573ac059ed060234fcef4299fae9e500d357c33)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a620481d7c..42044ae14b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7191,7 +7191,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
     if (el <= 1 && !el_is_in_host(env, el)) {
         len = MIN(len, 0xf & (uint32_t)cr[1]);
     }
-    if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+    if (el <= 2 && arm_is_el2_enabled(env)) {
         len = MIN(len, 0xf & (uint32_t)cr[2]);
     }
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.39.2


