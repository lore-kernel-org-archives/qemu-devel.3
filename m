Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346F1D2A559
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AMb-0004zY-BP; Wed, 16 Oct 2024 16:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMY-0004yT-Gs; Wed, 16 Oct 2024 16:11:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMW-0000il-Ro; Wed, 16 Oct 2024 16:11:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C6B2198F9E;
 Wed, 16 Oct 2024 23:10:09 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A002815637E;
 Wed, 16 Oct 2024 23:10:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 44/49] hw/char/pl011: Use correct masks for IBRD and
 FBRD
Date: Wed, 16 Oct 2024 23:10:03 +0300
Message-Id: <20241016201025.256294-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit b88cfee90268cad we defined masks for the IBRD and FBRD
integer and fractional baud rate divider registers, to prevent the
guest from writing invalid values which could cause division-by-zero.
Unfortunately we got the mask values the wrong way around: the FBRD
register is six bits and the IBRD register is 16 bits, not
vice-versa.

You would only run into this bug if you programmed the UART to a baud
rate of less than 9600, because for 9600 baud and above the IBRD
value will fit into 6 bits, as per the table in
 https://developer.arm.com/documentation/ddi0183/g/programmers-model/register-descriptions/fractional-baud-rate-register--uartfbrd

The only visible effects would be that the value read back from
the register by the guest would be truncated, and we would
print an incorrect baud rate in the debug logs.

Cc: qemu-stable@nongnu.org
Fixes: b88cfee90268 ("hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2610
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20241007144732.2491331-1-peter.maydell@linaro.org
(cherry picked from commit cd247eae16ab1b9ce97fd34c000c1b883feeda45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f8078aa216..949e9d0e0d 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -88,10 +88,10 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_LBE      (1 << 7)
 
 /* Integer Baud Rate Divider, UARTIBRD */
-#define IBRD_MASK 0x3f
+#define IBRD_MASK 0xffff
 
 /* Fractional Baud Rate Divider, UARTFBRD */
-#define FBRD_MASK 0xffff
+#define FBRD_MASK 0x3f
 
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
-- 
2.39.5


