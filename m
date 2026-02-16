Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A645EE81A3A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 15:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs0qd-0005t0-OE; Mon, 16 Feb 2026 10:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vs0qb-0005sP-CS
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vs0qT-0001Io-4R
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771256947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+USCgHFiPNvrOaxKAyrXKL9M8GKKvwHi8L2w83I4I2M=;
 b=FyN1zGD4Cz0uZp1SnmYbPCLw2WqeDGUoMD+aJh19batPWyBR8qpsmTItcKsF42o8WrApaY
 XpbgQnX8KROZlZePakObQfJ7XScccCnmbMNkGQgh2ebvcaAS3DoWr7/1EB/9DK1kr/wtAo
 dPgIIj9uKbrAQVC3qzFhRVto82WDK9k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-MSWwJHU_MFipdxW0LjjtWQ-1; Mon,
 16 Feb 2026 10:49:05 -0500
X-MC-Unique: MSWwJHU_MFipdxW0LjjtWQ-1
X-Mimecast-MFC-AGG-ID: MSWwJHU_MFipdxW0LjjtWQ_1771256944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912F6195FDC6; Mon, 16 Feb 2026 15:49:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.142])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C041180087F; Mon, 16 Feb 2026 15:49:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] hw/pci-host/sabre: Mark unusable PCI busses as full to ease
 device plugging
Date: Mon, 16 Feb 2026 16:49:01 +0100
Message-ID: <20260216154901.602613-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

When trying to plug a PCI device to a Sparc64 machine, you currently
have to specify the right bus ("bus=pciB"), otherwise you get this error:

 $ qemu-system-sparc64 -device virtio-scsi-pci
 qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/function
  available for virtio-scsi-pci, all in use or reserved

This is quite annoying for the unexperienced users, and it also breaks
e.g. the iotests ("make check-block") when running with qemu-system-sparc64.

Mark the non-usable PCI busses as full now, so that QEMU can automatically
plug new PCI devices to the right "pciB" bus.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Only lightly tested, it seems to work fine for me at a first glance,
 but maybe I missed something...

 hw/pci-host/sabre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index cd2328ad53f..9c8519f3849 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -382,6 +382,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
                                      &s->pci_mmio,
                                      &s->pci_ioport,
                                      0, 0x40, TYPE_PCI_BUS);
+    qbus_mark_full(&phb->bus->qbus);
 
     pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
 
@@ -400,6 +401,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     s->bridgeA = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
     pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
+    qbus_mark_full(&s->bridgeA->sec_bus.qbus);
 }
 
 static void sabre_init(Object *obj)
-- 
2.53.0


