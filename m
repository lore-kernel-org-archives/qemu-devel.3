Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161C2C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllOj-0003lF-MN; Mon, 20 Jul 2026 06:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOd-0003kN-I5
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOW-0008G8-Qa
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784543924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLUsY2VBLGGIb5Mf8uahKqDvB7i9l70WALZmTD9bRZE=;
 b=RQ7hN5VFzhU07wFtWwMBLObAYBCAcM2XL1dLfY3lr42fUgGBNR4InsSDTo1Jg9XqUxWB3s
 f61DB0I7LT26SCWU6izyhYX8XFXyXCHnSwalnf1zwa1AgcIUXm5sykmv9NAgY7ic8uE5Pq
 fqota4T2pmXMzos3QfgLA/0fCQDda3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-j3VhDpSrPjaJ9l78zzI4tA-1; Mon,
 20 Jul 2026 06:38:42 -0400
X-MC-Unique: j3VhDpSrPjaJ9l78zzI4tA-1
X-Mimecast-MFC-AGG-ID: j3VhDpSrPjaJ9l78zzI4tA_1784543921
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79D3C195607A; Mon, 20 Jul 2026 10:38:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FCA8158E; Mon, 20 Jul 2026 10:38:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Xiangfeng Cai <caixiangfeng@bytedance.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 2/7] hw/usb/hcd-xhci-pci: break host link cycle so
 device_finalize() runs on unplug
Date: Mon, 20 Jul 2026 12:38:28 +0200
Message-ID: <20260720103833.364506-3-thuth@redhat.com>
In-Reply-To: <20260720103833.364506-1-thuth@redhat.com>
References: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
---
 hw/usb/hcd-xhci-pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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
2.55.0


