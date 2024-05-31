Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75967C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyhm-0000rR-AZ; Fri, 31 May 2024 05:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sCyhj-0000q3-JQ; Fri, 31 May 2024 05:37:43 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sCyhh-0001pb-Ph; Fri, 31 May 2024 05:37:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 887402601D2;
 Fri, 31 May 2024 11:37:38 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id DuctskPxmdKX; Fri, 31 May 2024 11:37:36 +0200 (CEST)
Received: from applejack.lan (83.11.37.15.ipv4.supernova.orange.pl
 [83.11.37.15])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 00F522619EA;
 Fri, 31 May 2024 11:37:35 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 1/1] hw/arm/sbsa-ref: switch to 1GHz timer frequency
Date: Fri, 31 May 2024 11:37:29 +0200
Message-ID: <20240531093729.220758-2-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531093729.220758-1-marcin.juszkiewicz@linaro.org>
References: <20240531093729.220758-1-marcin.juszkiewicz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Updated firmware for QEMU CI is already in merge queue so we can move
platform to be future proof.

All supported cpus work fine with 1GHz timer frequency when firmware is
fresh enough.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 hw/arm/sbsa-ref.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 57c337fd92..7bd6898edf 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -62,16 +62,12 @@
 
 /*
  * Generic timer frequency in Hz (which drives both the CPU generic timers
- * and the SBSA watchdog-timer). Older versions of the TF-A firmware
- * typically used with sbsa-ref (including the binaries in our Avocado test
- * Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
- * assume it is this value.
+ * and the SBSA watchdog-timer). Older (<2.11) versions of the TF-A firmware
+ * assumed 62.5MHz here.
  *
- * TODO: this value is not architecturally correct for an Armv8.6 or
- * better CPU, so we should move to 1GHz once the TF-A fix above has
- * made it into a release and into our Avocado test.
+ * Starting with Armv8.6 CPU 1GHz timer frequency is mandated.
  */
-#define SBSA_GTIMER_HZ 62500000
+#define SBSA_GTIMER_HZ 1000000000
 
 enum {
     SBSA_FLASH,
-- 
2.45.1


