Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B101CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn1E-0005oP-Ma; Tue, 26 May 2026 04:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0w-0005YF-3S
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0u-0007zZ-2b
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCgznlD0h4aDrCL60FtGy8ty0eINfhTz603sGwzZIJc=;
 b=hOqT5Rar9TIdRRt7WLnvyo0SgIB7CyoG3kmb9o6ucvh6npA02wzW2ByzaSZsOOMsBeco/C
 EEFR1Car3aDukauoQ4dcqhCbD+yRxVb7U2CQAot2nYLSOHLbykFVhVR26ZKHP6fxbcXUnN
 Wn93zbSKp86tPyMHLR1VpWWesvYBC5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-GSV4cJANMpefHJTkI8bM9w-1; Tue,
 26 May 2026 04:19:44 -0400
X-MC-Unique: GSV4cJANMpefHJTkI8bM9w-1
X-Mimecast-MFC-AGG-ID: GSV4cJANMpefHJTkI8bM9w_1779783583
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6865F18005B3; Tue, 26 May 2026 08:19:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA76B180075B; Tue, 26 May 2026 08:19:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/37] hw/pci-host/aspeed_pcie: convert to use Resettable
 interface
Date: Tue, 26 May 2026 10:18:35 +0200
Message-ID: <20260526081848.651835-25-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kane Chen <kane_chen@aspeedtech.com>

Replace the legacy reset callback registered via
device_class_set_legacy_reset() with the Resettable interface.

Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-11-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/pci-host/aspeed_pcie.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index c150496f7b9c..186e5aeea298 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -613,9 +613,9 @@ static void aspeed_pcie_cfg_instance_init(Object *obj)
     return;
 }
 
-static void aspeed_pcie_cfg_reset(DeviceState *dev)
+static void aspeed_pcie_cfg_reset_hold(Object *obj, ResetType type)
 {
-    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(dev);
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(obj);
     AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
 
     memset(s->regs, 0, apc->nr_regs << 2);
@@ -663,12 +663,13 @@ static const Property aspeed_pcie_cfg_props[] = {
 static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_CLASS(klass);
 
     dc->desc = "ASPEED PCIe Config";
     dc->realize = aspeed_pcie_cfg_realize;
     dc->unrealize = aspeed_pcie_cfg_unrealize;
-    device_class_set_legacy_reset(dc, aspeed_pcie_cfg_reset);
+    rc->phases.hold = aspeed_pcie_cfg_reset_hold;
     device_class_set_props(dc, aspeed_pcie_cfg_props);
 
     apc->reg_ops = &aspeed_pcie_cfg_ops;
@@ -870,9 +871,9 @@ static const MemoryRegionOps aspeed_pcie_phy_ops = {
     },
 };
 
-static void aspeed_pcie_phy_reset(DeviceState *dev)
+static void aspeed_pcie_phy_reset_hold(Object *obj, ResetType type)
 {
-    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(dev);
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(obj);
     AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_GET_CLASS(s);
 
     memset(s->regs, 0, apc->nr_regs << 2);
@@ -913,12 +914,13 @@ static const Property aspeed_pcie_phy_props[] = {
 static void aspeed_pcie_phy_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_CLASS(klass);
 
     dc->desc = "ASPEED PCIe Phy";
     dc->realize = aspeed_pcie_phy_realize;
     dc->unrealize = aspeed_pcie_phy_unrealize;
-    device_class_set_legacy_reset(dc, aspeed_pcie_phy_reset);
+    rc->phases.hold = aspeed_pcie_phy_reset_hold;
     device_class_set_props(dc, aspeed_pcie_phy_props);
 
     apc->nr_regs = 0x100 >> 2;
@@ -932,9 +934,9 @@ static const TypeInfo aspeed_pcie_phy_info = {
     .class_size = sizeof(AspeedPCIEPhyClass),
 };
 
-static void aspeed_2700_pcie_phy_reset(DeviceState *dev)
+static void aspeed_2700_pcie_phy_reset_hold(Object *obj, ResetType type)
 {
-    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(dev);
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(obj);
     AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_GET_CLASS(s);
 
     memset(s->regs, 0, apc->nr_regs << 2);
@@ -950,10 +952,11 @@ static void aspeed_2700_pcie_phy_class_init(ObjectClass *klass,
                                             const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_CLASS(klass);
 
     dc->desc = "ASPEED AST2700 PCIe Phy";
-    device_class_set_legacy_reset(dc, aspeed_2700_pcie_phy_reset);
+    rc->phases.hold = aspeed_2700_pcie_phy_reset_hold;
 
     apc->nr_regs = 0x800 >> 2;
 }
-- 
2.54.0


