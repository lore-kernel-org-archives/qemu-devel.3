Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21942CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8n-0004Fe-Ng; Mon, 29 Sep 2025 12:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H84-0003Bo-G5
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H80-0002ss-Hf
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRGfIADnbxQLASkEsNkxa8b+HPhV/U2wqvMv6xwGtHw=;
 b=cq73+htIGGFy4LjXWEecxEN5rN3tuptlo1+OgDuq2GM/Qj/qzQKG6EycstsVj3mVWae8SS
 pQ3imrMHpVEslGg73+qYv50kXNZVjZzD3698DQjK5zLASnAFa4IkLBtIz0QRyzguoWjIWq
 6vFJxEyTYgh0rW3wDvb/kKebxpSIpdk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-kpdFrozxNYmtAz2g1iLIXw-1; Mon,
 29 Sep 2025 12:53:27 -0400
X-MC-Unique: kpdFrozxNYmtAz2g1iLIXw-1
X-Mimecast-MFC-AGG-ID: kpdFrozxNYmtAz2g1iLIXw_1759164806
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C3E8180057E; Mon, 29 Sep 2025 16:53:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 459911800452; Mon, 29 Sep 2025 16:53:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/32] hw/pci-host/aspeed: Add AST2700 PCIe PHY
Date: Mon, 29 Sep 2025 18:52:20 +0200
Message-ID: <20250929165230.797471-23-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce a PCIe Host Controller PHY model for AST2700. This adds an
AST2700 specific PHY type (TYPE_ASPEED_2700_PCIE_PHY) with a 0x800 byte
register space and link-status bits compatible with the firmware’s
expectations.

AST2700 provides three PCIe RCs; PCIe0 and PCIe1 are GEN4, PCIe2 is
GEN2. The PHY exposes:
PEHR_2700_LINK_GEN2 at 0x344, bit 18 indicates GEN2 link up
PEHR_2700_LINK_GEN4 at 0x358, bit 8 indicates GEN4 link up

In real hardware these GEN2/GEN4 link bits are mutually exclusive.
QEMU does not model GEN2 vs GEN4 signaling differences, so the reset
handler sets both bits to 1. This keeps the model simple and lets
firmware see the link as up; firmware will read the appropriate
register per RC port to infer the intended mode.

The header gains TYPE_ASPEED_2700_PCIE_PHY; the new class derives from
TYPE_ASPEED_PCIE_PHY, sets nr_regs to 0x800 >> 2, and installs an
AST2700 reset routine that programs the class code (0x06040011) and the
GEN2/GEN4 status bits.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h |  1 +
 hw/pci-host/aspeed_pcie.c         | 39 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index 5e60cba07b66..5806505f30ef 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -114,6 +114,7 @@ struct AspeedPCIECfgClass {
 };
 
 #define TYPE_ASPEED_PCIE_PHY "aspeed.pcie-phy"
+#define TYPE_ASPEED_2700_PCIE_PHY TYPE_ASPEED_PCIE_PHY "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedPCIEPhyState, AspeedPCIEPhyClass, ASPEED_PCIE_PHY);
 
 struct AspeedPCIEPhyState {
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 8be55b962fc7..788160d5325c 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -696,6 +696,12 @@ REG32(PEHR_PROTECT,     0x7C)
 REG32(PEHR_LINK,        0xC0)
     FIELD(PEHR_LINK, STS, 5, 1)
 
+/* AST2700 */
+REG32(PEHR_2700_LINK_GEN2,  0x344)
+    FIELD(PEHR_2700_LINK_GEN2, STS, 18, 1)
+REG32(PEHR_2700_LINK_GEN4,  0x358)
+    FIELD(PEHR_2700_LINK_GEN4, STS, 8, 1)
+
 #define ASPEED_PCIE_PHY_UNLOCK  0xA8
 
 static uint64_t aspeed_pcie_phy_read(void *opaque, hwaddr addr,
@@ -803,6 +809,38 @@ static const TypeInfo aspeed_pcie_phy_info = {
     .class_size = sizeof(AspeedPCIEPhyClass),
 };
 
+static void aspeed_2700_pcie_phy_reset(DeviceState *dev)
+{
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(dev);
+    AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_GET_CLASS(s);
+
+    memset(s->regs, 0, apc->nr_regs << 2);
+
+    s->regs[R_PEHR_ID] =
+        (0x1150 << R_PEHR_ID_DEV_SHIFT) | PCI_VENDOR_ID_ASPEED;
+    s->regs[R_PEHR_CLASS_CODE] = 0x06040011;
+    s->regs[R_PEHR_2700_LINK_GEN2] = R_PEHR_2700_LINK_GEN2_STS_MASK;
+    s->regs[R_PEHR_2700_LINK_GEN4] = R_PEHR_2700_LINK_GEN4_STS_MASK;
+}
+
+static void aspeed_2700_pcie_phy_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_CLASS(klass);
+
+    dc->desc = "ASPEED AST2700 PCIe Phy";
+    device_class_set_legacy_reset(dc, aspeed_2700_pcie_phy_reset);
+
+    apc->nr_regs = 0x800 >> 2;
+}
+
+static const TypeInfo aspeed_2700_pcie_phy_info = {
+    .name       = TYPE_ASPEED_2700_PCIE_PHY,
+    .parent     = TYPE_ASPEED_PCIE_PHY,
+    .class_init = aspeed_2700_pcie_phy_class_init,
+};
+
 static void aspeed_pcie_register_types(void)
 {
     type_register_static(&aspeed_pcie_rc_info);
@@ -810,6 +848,7 @@ static void aspeed_pcie_register_types(void)
     type_register_static(&aspeed_pcie_root_port_info);
     type_register_static(&aspeed_pcie_cfg_info);
     type_register_static(&aspeed_pcie_phy_info);
+    type_register_static(&aspeed_2700_pcie_phy_info);
 }
 
 type_init(aspeed_pcie_register_types);
-- 
2.51.0


