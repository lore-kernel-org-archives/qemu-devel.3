Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB2C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBmE-0002mf-U1; Wed, 14 May 2025 09:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBk0-0007uA-Lh; Wed, 14 May 2025 09:01:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBjo-0008If-V9; Wed, 14 May 2025 09:01:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A098A121AFE;
 Wed, 14 May 2025 15:57:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4B4C020B86C;
 Wed, 14 May 2025 15:58:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 32/34] hw/i2c/imx: Always set interrupt status bit if
 interrupt condition occurs
Date: Wed, 14 May 2025 15:57:54 +0300
Message-Id: <20250514125758.92030-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

According to the i.MX 8M Plus reference manual, the status flag
I2C_I2SR[IIF] continues to be set when an interrupt condition
occurs even when I2C interrupts are disabled (I2C_I2CR[IIEN] is
clear). However, the device model only sets the flag when I2C
interrupts are enabled which causes U-Boot to loop forever. Fix
the device model by always setting the flag and let I2C_I2CR[IIEN]
guard I2C interrupts only.

Also remove the comment in the code since it merely stated the
obvious and would be outdated now.

Cc: qemu-stable@nongnu.org
Fixes: 20d0f9cf6a41 ("i.MX: Add I2C controller emulator")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-ID: <20250507124040.425773-1-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 54e54e594bc8273d210f7ff4448c165a989cbbe8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index c565fd5b8a..1dd0167e47 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -90,13 +90,12 @@ static void imx_i2c_reset(DeviceState *dev)
 
 static inline void imx_i2c_raise_interrupt(IMXI2CState *s)
 {
-    /*
-     * raise an interrupt if the device is enabled and it is configured
-     * to generate some interrupts.
-     */
-    if (imx_i2c_is_enabled(s) && imx_i2c_interrupt_is_enabled(s)) {
+    if (imx_i2c_is_enabled(s)) {
         s->i2sr |= I2SR_IIF;
-        qemu_irq_raise(s->irq);
+
+        if (imx_i2c_interrupt_is_enabled(s)) {
+            qemu_irq_raise(s->irq);
+        }
     }
 }
 
-- 
2.39.5


