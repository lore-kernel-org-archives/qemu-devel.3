Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E08BC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWV0-0004LK-J6; Wed, 22 Jul 2026 08:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWTA-0007GD-8j; Wed, 22 Jul 2026 08:54:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWT8-000351-Ct; Wed, 22 Jul 2026 08:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=5u7MKqtu7+Rdv8zyobpkdOXB6EyHMRizMEccjKKjtNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=r7AakhXlqz4LZrdtRZ3ghUa2ydlt9deaT3c7dnYdFX01f99srK4+FLeavA+q6EHSZ
 ENPsLF2m7s0cyHv7A9QBltk7JFzbspUu3DIeNMLK7qr2v0Cnq/yxg1z4tSi7HNqRz/
 umIOYRQ6IPRiKa930n5gSoqx2cHbet6MLbZdlHedOwVLlnkbQJ0EabGhDcvf538qrT
 Vavu6QaQnm6ZTZodsKwlKDYJyv0HE2xsI2oCBV36F7jOO7WfxgBCAtYZABzFdb0YS0
 XBSatPsUQ6bq4iKlQ4S+eNImLm60m4i7ioqjLQq/9fYlp9USUtaHhxsFGKmmryhaaK
 Ab/gpsbaAqDzQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 38F6B1C3B50;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 81D2C3F37A0;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E292A17F75; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiangfeng Cai <caixiangfeng@bytedance.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 115/127] hw/usb/hcd-xhci-pci: break host link cycle
 so device_finalize() runs on unplug
Date: Wed, 22 Jul 2026 15:48:40 +0300
Message-ID: <20260722124859.32371-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

From: Xiangfeng Cai <caixiangfeng@bytedance.com>

The xHCI PCI wrapper embeds an xhci-core child via object_initialize_child()
and, in usb_xhci_pci_realize(), points the child's "host" link back at the PCI
device:

    object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);

"host" is a DEFINE_PROP_LINK property, which qdev registers as an
OBJ_PROP_LINK_STRONG link. A strong link takes a reference on its target, so
this creates a refcount cycle: the PCI device owns the child, and the child's
strong link pins the PCI device.

On unplug (guest ACPI eject or QMP device_del), pci_qdev_unrealize() calls
pc->exit() but never unrealizes the no-bus child. object_unparent() then drops
only the parent/bus references, leaving the link reference in place. The PCI
device stays at refcount 1 forever, so object_finalize()/device_finalize() is
never reached. Symptom observed under gdb after eject:

    p *((Object *)dev)  =>  ref = 1, parent = 0x0, realized = false
    p ((XHCIPciState *)dev)->xhci.hostOpaque  =>  points back at dev

Fix usb_xhci_pci_exit() to tear down the embedded child explicitly: unrealize
it first (so the set-link-before-realize check passes), then clear the "host"
link. This releases the strong reference, lets the PCI device refcount reach 0,
and allows device_finalize() to run.

Fixes: 8ddab8dd3d81 ("usb/hcd-xhci: Split pci wrapper for xhci base model")
Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260618110119.3084296-2-caixiangfeng@bytedance.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 054ef33f674cdc6cb87df599790d99cfcda363cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index c5446a4a5e1..b124251ae33 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -196,6 +196,18 @@ static void usb_xhci_pci_exit(PCIDevice *dev)
         && dev->msix_entry_used) {
         msix_uninit(dev, &s->xhci.mem, &s->xhci.mem);
     }
+    /*
+     * The embedded xhci-core child holds a strong "host" link back to this
+     * PCI device (set in usb_xhci_pci_realize()), forming a refcount cycle:
+     * the PCI device owns the child, and the child's strong link pins the PCI
+     * device. On unplug, object_unparent() only drops the parent/bus refs, so
+     * the link ref keeps this device at refcount 1 forever and
+     * device_finalize() never runs. Unrealize the child first (so the
+     * realized-check in set_link passes), then clear the link to break the
+     * cycle.
+     */
+    qdev_unrealize(DEVICE(&s->xhci));
+    object_property_set_link(OBJECT(&s->xhci), "host", NULL, &error_abort);
 }
 
 static const VMStateDescription vmstate_xhci_pci = {
-- 
2.47.3


