Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59136C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgWs-0008Pn-7b; Tue, 28 Jan 2025 03:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgW0-0007cx-LQ; Tue, 28 Jan 2025 03:00:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgVu-0001JR-78; Tue, 28 Jan 2025 03:00:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F3A08E1B08;
 Tue, 28 Jan 2025 10:54:25 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6EBB71A62EF;
 Tue, 28 Jan 2025 10:54:51 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 0FC8D52075; Tue, 28 Jan 2025 10:54:51 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.9 39/45] hw/usb/hcd-xhci-pci: Use modulo to select MSI
 vector as per spec
Date: Mon, 27 Jan 2025 23:26:20 +0300
Message-Id: <20250127202630.3724367-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
References: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QEMU would crash with a failed assertion if the XHCI controller
attempted to raise the interrupt on an interrupter corresponding
to a MSI vector with a higher index than the highest configured
for the device by the guest driver.

This behaviour is correct on the MSI/PCI side: per PCI 3.0 spec,
devices must ensure they do not send MSI notifications for
vectors beyond the range of those allocated by the system/driver
software. Unlike MSI-X, there is no generic way for handling
aliasing in the case of fewer allocated vectors than requested,
so the specifics are up to device implementors. (Section
6.8.3.4. "Sending Messages")

It turns out the XHCI spec (Implementation Note in section 4.17,
"Interrupters") requires that the host controller signal the MSI
vector with the number computed by taking the interrupter number
modulo the number of enabled MSI vectors.

This change introduces that modulo calculation, fixing the
failed assertion. This makes the device work correctly in MSI mode
with macOS's XHCI driver, which only allocates a single vector.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250112210056.16658-2-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit bb5b7fced6b5d3334ab20702fc846e47bb1fb731)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 643d4643e4..560ce582b2 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     }
 
     if (msi_enabled(pci_dev) && level) {
+        n %= msi_nr_vectors_allocated(pci_dev);
         msi_notify(pci_dev, n);
         return true;
     }
-- 
2.39.5


