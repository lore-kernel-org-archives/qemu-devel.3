Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE2BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAJv-0006HJ-W2; Wed, 12 Aug 2026 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIV-0004XA-Vy; Wed, 12 Aug 2026 10:51:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIU-0006lc-0O; Wed, 12 Aug 2026 10:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=mSvmnGqGO/Cb4zu+AAeW+ToyoSkyL4u8VtuHxKWRus4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LM7diNx5pISS4UDPVY/e5pcJOS/YOjo9zkeKR4ZP4zsOvibSd0WRsjQs8awSkTi9x
 i5pPH0/FDrAF3wBNQsR/eA1Z33QpfdCOMymOKHGdKHgNrqQ+BLtv/iotbQL4qz9iki
 J/iSMrP8w0zFUe5fUmSEK6/6eo906RkdpMG3en0nhQyzhoL3hQnFUH0YrvqR82bKjg
 +5mLIb57iAxhJkdUu35ply3kMxf2O5tTYYv1m23deixONs5Y4eIpHWtmel4ecnjAh9
 3mhltL0/T8Lz/U+NfmKAvCKatT5REPiGwULljunwEMAJXxusQm9wtnaiBu6dfLWIDl
 mAuyNq6MlUz/A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 018F31CA610;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5C79B409D4C;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B88492F97B; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 012/120] vfio/pci: reject invalid PCI_INTERRUPT_PIN
 values
Date: Wed, 12 Aug 2026 17:47:55 +0300
Message-ID: <20260812144955.649205-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

qemu-kvm aborts a few seconds after starting a VM with a
passed-through GPU whose PCI_INTERRUPT_PIN comes back as an
out-of-range value: vfio_intx_enable() only guards against pin == 0
and stores vdev->intx.pin = pin - 1 with no upper-bound check. That
value later reaches pci_irq_handler()'s
assert(0 <= irq_num && irq_num < PCI_NUM_PINS) via
pci_irq_deassert() -> pci_set_irq(), aborting the process.

Legal PCI_INTERRUPT_PIN values are 0 (no legacy interrupt) or
1-PCI_NUM_PINS (INTA-INTD); reject anything else before it reaches
vdev->intx.pin, whether the out-of-range value came from a read
failure (now caught by the previous commit) or was handed back as
data by the device itself.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alex Williamson <alex@shazbot.org>
CC: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260717122232.468955-3-den@openvz.org
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 86abb10256a58d50513d1f9c65652b7b6b7faafc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b24c3b35113..5c192ee54b4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -346,6 +346,11 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    if (pin > PCI_NUM_PINS) {
+        error_setg(errp, "invalid PCI interrupt pin %d", pin);
+        return false;
+    }
+
     /*
      * Do not alter interrupt state during vfio_realize and cpr load.
      * The incoming state is cleared thereafter.
-- 
2.47.3


