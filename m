Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CF4C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBnp-0005cN-GE; Wed, 14 May 2025 09:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBje-0007hL-Ct; Wed, 14 May 2025 09:01:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBjV-0008Gt-Pj; Wed, 14 May 2025 09:01:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79B1F121AFA;
 Wed, 14 May 2025 15:57:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1A82920B868;
 Wed, 14 May 2025 15:58:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 28/34] hw/gpio/imx_gpio: Fix interpretation of GDIR
 polarity
Date: Wed, 14 May 2025 15:57:50 +0300
Message-Id: <20250514125758.92030-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

According to the i.MX 8M Plus reference manual, a GPIO pin is
configured as an output when the corresponding bit in the GDIR
register is set.  The function imx_gpio_set_int_line() is intended to
be a no-op if the pin is configured as an output, returning early in
such cases.  However, it inverts the condition.  Fix this by
returning early when the bit is set.

cc: qemu-stable@nongnu.org
Fixes: f44272809779 ("i.MX: Add GPIO device")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250501183445.2389-4-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit eba837a31b9579e30cc6d7ecb4b5c2662a6ffaba)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 27535a577f..e3ed6b2a63 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -79,7 +79,7 @@ static void imx_gpio_update_int(IMXGPIOState *s)
 static void imx_gpio_set_int_line(IMXGPIOState *s, int line, IMXGPIOLevel level)
 {
     /* if this signal isn't configured as an input signal, nothing to do */
-    if (!extract32(s->gdir, line, 1)) {
+    if (extract32(s->gdir, line, 1)) {
         return;
     }
 
-- 
2.39.5


