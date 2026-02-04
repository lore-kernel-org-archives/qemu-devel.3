Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB9E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBX-0000nc-1S; Wed, 04 Feb 2026 05:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaB9-0000VK-3X
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaB7-0003zn-9A
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MquVSRVZfbbDT3uJLAMkLNQfrRxztkav4yYJm+5pL+o=;
 b=BwjFt10+wOJSDe+AXZnn4nPek985rCvDyzY2ttP1wVnULVv5LWaSfuBNXX9E0NTvMhLkNO
 mEpX6Fx3s7RC5JsOBGFBbPhgAAZuSSnZ4smcrNaY8y0fZgZgXEnTEF+rgVreEF+OkjGwzj
 b/J2ksm/T349DQH5v4SSAj3KfAWbvNM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-5x8X_4t8MUSIsVrHiGKG7A-1; Wed,
 04 Feb 2026 05:32:05 -0500
X-MC-Unique: 5x8X_4t8MUSIsVrHiGKG7A-1
X-Mimecast-MFC-AGG-ID: 5x8X_4t8MUSIsVrHiGKG7A_1770201124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9901C18001E3; Wed,  4 Feb 2026 10:32:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2644A18004BB; Wed,  4 Feb 2026 10:32:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/45] hw/pci-host/aspeed_pcie: Drop AST2600 RC_H root-bus
 remap and bus-nr property
Date: Wed,  4 Feb 2026 11:31:02 +0100
Message-ID: <20260204103136.1795455-12-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The original AST2600 PCIe design supported both RC_L and RC_H, using root bus
number 0 for RC_L and 0x80 for RC_H. In that model, the root port appeared as
80:08.0 and QEMU carried a "bus-nr" property plus a config-space bus remap to
translate bus 0x80 to bus 0x00 for PCI enumeration.

Linux mainline has since dropped RC_L support and updated the RC_H root bus
number to start at 0. The root port is now enumerated as 00:08.0, matching the
default QEMU PCIe subsystem root bus numbering.

Remove the bus number setting and the AST2600 bus remap logic, and drop the
corresponding "bus-nr"/rc_bus_nr fields and property plumbing. QEMU now relies
on the default root bus 0 behavior.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260127032348.2238527-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h |  2 --
 hw/pci-host/aspeed_pcie.c         | 19 +------------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index fde5816ea30c..143b3565917a 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -69,7 +69,6 @@ struct AspeedPCIERcState {
     uint64_t dram_base;
     uint32_t msi_addr;
     uint32_t rp_addr;
-    uint32_t bus_nr;
     char name[16];
     qemu_irq irq;
 
@@ -102,7 +101,6 @@ struct AspeedPCIECfgClass {
 
     uint32_t rc_msi_addr;
     uint32_t rc_rp_addr;
-    uint64_t rc_bus_nr;
     uint64_t nr_regs;
     bool rc_has_rd;
 };
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 4fdda959396f..4f896f855cb4 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -268,7 +268,7 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
     AspeedPCIECfgState *cfg =
            container_of(rc, AspeedPCIECfgState, rc);
 
-    snprintf(rc->name, sizeof(rc->name), "%04x:%02x", cfg->id, rc->bus_nr);
+    snprintf(rc->name, sizeof(rc->name), "%04x:00", cfg->id);
 
     return rc->name;
 }
@@ -283,7 +283,6 @@ static void aspeed_pcie_rc_instance_init(Object *obj)
 }
 
 static const Property aspeed_pcie_rc_props[] = {
-    DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
     DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
     DEFINE_PROP_UINT32("msi-addr", AspeedPCIERcState, msi_addr, 0),
     DEFINE_PROP_UINT64("dram-base", AspeedPCIERcState, dram_base, 0),
@@ -490,17 +489,6 @@ static void aspeed_pcie_cfg_readwrite(AspeedPCIECfgState *s,
     offset = cfg_addr & 0xffc;
 
     pci = PCI_HOST_BRIDGE(rc);
-
-    /*
-     * On the AST2600, the RC_H bus number range from 0x80 to 0xFF, with the
-     * root device and root port assigned to bus 0x80 instead of the standard
-     * 0x00. To allow the PCI subsystem to correctly discover devices on the
-     * root bus, bus 0x80 is remapped to 0x00.
-     */
-    if (bus == rc->bus_nr) {
-        bus = 0;
-    }
-
     pdev = pci_find_device(pci->bus, bus, devfn);
     if (!pdev) {
         s->regs[desc->rdata_reg] = ~0;
@@ -650,9 +638,6 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
                           apc->nr_regs << 2);
     sysbus_init_mmio(sbd, &s->mmio);
 
-    object_property_set_int(OBJECT(&s->rc), "bus-nr",
-                            apc->rc_bus_nr,
-                            &error_abort);
     object_property_set_int(OBJECT(&s->rc), "rp-addr",
                             apc->rc_rp_addr,
                             &error_abort);
@@ -691,7 +676,6 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
     apc->reg_map = &aspeed_regmap;
     apc->nr_regs = 0x100 >> 2;
     apc->rc_msi_addr = 0x1e77005C;
-    apc->rc_bus_nr = 0x80;
     apc->rc_rp_addr = PCI_DEVFN(8, 0);
 }
 
@@ -811,7 +795,6 @@ static void aspeed_2700_pcie_cfg_class_init(ObjectClass *klass,
     apc->reg_map = &aspeed_2700_regmap;
     apc->nr_regs = 0x100 >> 2;
     apc->rc_msi_addr = 0x000000F0;
-    apc->rc_bus_nr = 0;
     apc->rc_rp_addr = PCI_DEVFN(0, 0);
 }
 
-- 
2.52.0


