Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C91C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4I-00037p-1T; Mon, 27 Jul 2026 01:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4A-00035y-5g
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE48-0003St-H7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlvkrgsEA9eAyK8sO+gEUPMsIddzXNN5H6LFRBn5jHc=;
 b=c0H009XRraTENkh7c96uUcsdrctjykLs3HxGiQLXTgdDUbFhs5e5KZyYBOX0KB9M/pPIFf
 TPh5x6kMpRytb/QBy8OakJYKKUK3QO/Ciw7LAgK6Im5nJoZPPk23d6etYMlBekifoXqxjC
 VpauE1i5NqGupcuJNyaxwdHcNAD/i90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-xZEqcayeM9yEDjlCmbhlxQ-1; Mon,
 27 Jul 2026 01:39:47 -0400
X-MC-Unique: xZEqcayeM9yEDjlCmbhlxQ-1
X-Mimecast-MFC-AGG-ID: xZEqcayeM9yEDjlCmbhlxQ_1785130786
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17BB11955F26; Mon, 27 Jul 2026 05:39:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 452141956088; Mon, 27 Jul 2026 05:39:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 01/11] pci: Add PCI_BASE_ADDRESS_MEM_ALWAYS_ON BAR flag
Date: Mon, 27 Jul 2026 07:39:25 +0200
Message-ID: <20260727053935.1392269-2-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When VFIO opens a VF, it issues a Function Level Reset which clears
PCI_COMMAND_MEMORY. This unmaps all BARs, including the migration
BAR.

Add a QEMU-internal BAR type flag that keeps a memory BAR mapped
regardless of PCI_COMMAND_MEMORY. This is needed for host-only
control regions (e.g. migration BARs) that are accessed by a VFIO
variant driver, not by the guest.

Assisted-by: Claude
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci/pci.h | 6 ++++++
 hw/pci/pci.c         | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a0b..923c8f0e15bc 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -164,6 +164,12 @@ typedef struct PCIIORegion {
     MemoryRegion *address_space;
 } PCIIORegion;
 
+/*
+ * QEMU-internal: keep this BAR mapped regardless of PCI_COMMAND_MEMORY.
+ * Stripped before writing to config space.
+ */
+#define PCI_BASE_ADDRESS_MEM_ALWAYS_ON  0x10
+
 #define PCI_ROM_SLOT 6
 #define PCI_NUM_REGIONS 7
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e283..1394132c1472 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1544,7 +1544,8 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
         }
 
         addr = pci_bar(pci_dev, region_num);
-        pci_set_long(pci_dev->config + addr, type);
+        pci_set_long(pci_dev->config + addr,
+                     type & ~PCI_BASE_ADDRESS_MEM_ALWAYS_ON);
 
         if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
             r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
@@ -1686,7 +1687,8 @@ pcibus_t pci_bar_address(PCIDevice *d,
         return new_addr;
     }
 
-    if (!(cmd & PCI_COMMAND_MEMORY)) {
+    if (!(cmd & PCI_COMMAND_MEMORY) &&
+        !(type & PCI_BASE_ADDRESS_MEM_ALWAYS_ON)) {
         return PCI_BAR_UNMAPPED;
     }
     new_addr = pci_config_get_bar_addr(d, reg, type, size);
-- 
2.55.0


