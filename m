Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBE0CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCAQ-0001px-I5; Thu, 18 Jun 2026 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caixiangfeng@bytedance.com>)
 id 1waAWM-0000zp-OF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:02:58 -0400
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caixiangfeng@bytedance.com>)
 id 1waAWL-00048F-2C
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781780565; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3npWah6PK9X89Q87/+arVCTPuG7yXO4k/Ki/KNmHuao=;
 b=BqBABcjU/DvpD1SntNsPyj2EPnwxtk/DG8zaQsd6qydfkVNEfDILDTtDlajRaFHeYtkrhh
 JHmwwo70iYoxFxP5xLdqAh92BBbGiATSVdjU7ifHyfpjG/DImwoXBY8p1QBgWn13jv/EBI
 VKyblCzdvQhiQdziQuMOu4mf2k6KMbY3gBPFQVdrL16pSyP0WpMkDiJNd1sQeq5nYbQoNW
 YGMljWDaW0I48bISLUSfAhJP/BxthhlL/QacENCnjlel5PX0ISiC7qNzyoinTV/GuSe/0l
 HXCVIiPrOyY0e+q5BQwg131YXuHv3hE5hbmBBOIcnMlHkxSHCmzfIs29UMlZig==
X-Lms-Return-Path: <lba+26a33d054+ffe197+nongnu.org+caixiangfeng@bytedance.com>
From: "Xiangfeng Cai" <caixiangfeng@bytedance.com>
Date: Thu, 18 Jun 2026 19:01:18 +0800
In-Reply-To: <20260618110119.3084296-1-caixiangfeng@bytedance.com>
X-Original-From: Xiangfeng Cai <caixiangfeng@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/2] hw/usb/hcd-xhci-pci: break host link cycle so
 device_finalize() runs on unplug
X-Mailer: git-send-email 2.55.0.rc1
Cc: <caixiangfeng@bytedance.com>, <yanfei.xu@bytedance.com>, 
 "Fabiano Rosas" <farosas@suse.de>, "Laurent Vivier" <lvivier@redhat.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
References: <20260618110119.3084296-1-caixiangfeng@bytedance.com>
To: <qemu-devel@nongnu.org>
Message-Id: <20260618110119.3084296-2-caixiangfeng@bytedance.com>
Received-SPF: pass client-ip=209.127.230.114;
 envelope-from=caixiangfeng@bytedance.com; helo=va-1-114.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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
---
 hw/usb/hcd-xhci-pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index c5446a4a5e..b124251ae3 100644
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
2.55.0.rc1

