Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D49F3380B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2P37-0000s3-38; Tue, 17 Mar 2026 03:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2P35-0000rd-KP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2P33-0006tC-DM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773733264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/+k0eCiPPaE3SrKUP9/n0lGLkwnj+VjFsiElr4uWvaw=;
 b=FU6WQskS6lMqbTplkRzEO2pMqIAZQnoFs2+FUCvwH5/sV/6eQQowDUq0YaPYxcUzR8tpyj
 e2GmniyRAMDVQyQDw9zxfgZ3syGUfu7IUHuWc4y5aWeIsSEKGClS/oYdAmxH1yPdbtnLQR
 8y1WPdXtS/cajMnVrWRaeBriopEv9vw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-yKhq5bITPOeSAvQuxCiRbw-1; Tue,
 17 Mar 2026 03:41:00 -0400
X-MC-Unique: yKhq5bITPOeSAvQuxCiRbw-1
X-Mimecast-MFC-AGG-ID: yKhq5bITPOeSAvQuxCiRbw_1773733257
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 012C51954238; Tue, 17 Mar 2026 07:40:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 465021955F19; Tue, 17 Mar 2026 07:40:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] hw/pci-host/raven: Fix crash when introspecting raven-pcihost
 from the CLI
Date: Tue, 17 Mar 2026 08:40:49 +0100
Message-ID: <20260317074049.436460-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QEMU currently crashes when introspecting raven-pcihost from the command
line interface:

 $ ./qemu-system-ppc -device raven-pcihost,help
 Segmentation fault (core dumped)

This happens because the raven_pcihost_initfn instance init function
calls get_system_memory(), but that is not available here yet.

There does not seem to be a compelling reason for initializing the
memory regions from the instance init function, so let's simply move
the code into the realize() function instead to fix this issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci-host/raven.c | 68 +++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index b3c2678667a..b3836dc9a28 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -212,8 +212,39 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
     MemoryRegion *address_space_mem = get_system_memory();
+    Object *obj = OBJECT(d);
     int i;
 
+    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
+    memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
+                          "pci-io-non-contiguous", 0x00800000);
+    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
+    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
+
+    /*
+     * Raven's raven_io_ops use the address-space API to access pci-conf-idx
+     * (which is also owned by the raven device). As such, mark the
+     * pci_io_non_contiguous as re-entrancy safe.
+     */
+    s->pci_io_non_contiguous.disable_reentrancy_guard = true;
+
+    /* CPU address space */
+    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
+                                &s->pci_io);
+    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
+                                        &s->pci_io_non_contiguous, 1);
+    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
+
+    /* Bus master address space */
+    memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
+    memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
+                             &s->pci_memory, 0,
+                             memory_region_size(&s->pci_memory));
+    memory_region_init_alias(&s->bm_ram_alias, obj, "bm-system",
+                             address_space_mem, 0, 0x80000000);
+    memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
+    memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
+
     /*
      * According to PReP specification section 6.1.6 "System Interrupt
      * Assignments", all PCI interrupts are routed via IRQ 15
@@ -256,42 +287,6 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     pci_setup_iommu(h->bus, &raven_iommu_ops, s);
 }
 
-static void raven_pcihost_initfn(Object *obj)
-{
-    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
-    MemoryRegion *address_space_mem = get_system_memory();
-
-    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
-    memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
-                          "pci-io-non-contiguous", 0x00800000);
-    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
-    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
-
-    /*
-     * Raven's raven_io_ops use the address-space API to access pci-conf-idx
-     * (which is also owned by the raven device). As such, mark the
-     * pci_io_non_contiguous as re-entrancy safe.
-     */
-    s->pci_io_non_contiguous.disable_reentrancy_guard = true;
-
-    /* CPU address space */
-    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
-                                &s->pci_io);
-    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
-                                        &s->pci_io_non_contiguous, 1);
-    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-
-    /* Bus master address space */
-    memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
-    memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
-                             &s->pci_memory, 0,
-                             memory_region_size(&s->pci_memory));
-    memory_region_init_alias(&s->bm_ram_alias, obj, "bm-system",
-                             get_system_memory(), 0, 0x80000000);
-    memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
-    memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
-}
-
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -330,7 +325,6 @@ static const TypeInfo raven_types[] = {
         .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
         .parent = TYPE_PCI_HOST_BRIDGE,
         .instance_size = sizeof(PREPPCIState),
-        .instance_init = raven_pcihost_initfn,
         .class_init = raven_pcihost_class_init,
     },
     {
-- 
2.53.0


