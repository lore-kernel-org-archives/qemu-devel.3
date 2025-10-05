Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3381DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 06:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5IfB-0004pm-1U; Sun, 05 Oct 2025 02:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5If6-0004nD-H5; Sun, 05 Oct 2025 02:56:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5If4-0007xP-NU; Sun, 05 Oct 2025 02:56:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 117AE15A8EA;
 Sun, 05 Oct 2025 09:55:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 60D5229947F;
 Sun,  5 Oct 2025 09:55:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: ShengYi Hung <aokblast@FreeBSD.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 5/8] wdt_i6300esb: fix incorrect mask for interrupt type
Date: Sun,  5 Oct 2025 09:55:33 +0300
Message-ID: <20251005065538.436862-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251005065538.436862-1-mjt@tls.msk.ru>
References: <20251005065538.436862-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: ShengYi Hung <aokblast@FreeBSD.org>

According to Intel 6300ESB Controller Hub Datasheet 14.4.15, the interrupt
type mask should be 0x03 (0b11) instead of 0x11. In the original
implementation, when we want to disable all interrupt by setting the
value to 0x03, we will get 0x01 which is incorrect when we want to read
the value again. However, there is no problem when considering the correct
behavior since 0x01 is reserved and unused just like 0x03. This patch is
just a fix to return the register value.

Signed-off-by: ShengYi Hung <aokblast@FreeBSD.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/watchdog/wdt_i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index bb8a2766b6..3aa01b8d68 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -55,7 +55,7 @@
 /* Config register bits */
 #define ESB_WDT_REBOOT  (0x01 << 5)   /* Enable reboot on timeout          */
 #define ESB_WDT_FREQ    (0x01 << 2)   /* Decrement frequency               */
-#define ESB_WDT_INTTYPE (0x11 << 0)   /* Interrupt type on timer1 timeout  */
+#define ESB_WDT_INTTYPE (0x03 << 0)   /* Interrupt type on timer1 timeout  */
 
 /* Reload register bits */
 #define ESB_WDT_RELOAD  (0x01 << 8)    /* prevent timeout                   */
-- 
2.47.3


