Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E31CCAC58C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 17:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1g4-00072o-KD; Tue, 09 Sep 2025 12:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fg-0006PR-AP
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fc-0007fL-3d
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKWmvwbl3Ykqw62VPAK0MxfC1m5cPJWLJRvuPtRLz5Q=;
 b=heo0OcjHIW3GsGLr+owQ9acS8o1xBx/RfVJ24QBzlgVFv0yfbL7e7EboDfkIw6CqMKNM2M
 3GsF4ICAqylZcvmvqVWXMyOyAydAVmzwjQI/rgK0+TSFL40x5V1IkwNlg0DN0cvG5RPr/l
 CRyTvZXMPvp/sBoaakSWZ+hVa++fSjc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-9NVuwgytMzWtYUYjkAlydg-1; Tue,
 09 Sep 2025 12:58:12 -0400
X-MC-Unique: 9NVuwgytMzWtYUYjkAlydg-1
X-Mimecast-MFC-AGG-ID: 9NVuwgytMzWtYUYjkAlydg_1757437091
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0E991800451; Tue,  9 Sep 2025 16:58:11 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 214711800446; Tue,  9 Sep 2025 16:58:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/15] hw/net: mark all NICs as insecure except e1000,
 e1000e & xen
Date: Tue,  9 Sep 2025 17:57:25 +0100
Message-ID: <20250909165726.3814465-15-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Historically most NICs are only interesting for non-virtualization
use cases and have not been written with malicious guests in mind.

The exception is a handful of NICs from the x86 world. These days
virtio-net or xen-net should be used in all virtualized guests.
An exception is made, however, for the e1000/e1000e NICs since
they are a common fallback NIC option for scenarios where virtio
is not available.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/allwinner-sun8i-emac.c  | 1 +
 hw/net/allwinner_emac.c        | 3 ++-
 hw/net/cadence_gem.c           | 1 +
 hw/net/can/can_kvaser_pci.c    | 1 +
 hw/net/can/can_mioe3680_pci.c  | 1 +
 hw/net/can/can_pcm3680_pci.c   | 1 +
 hw/net/can/ctucan_pci.c        | 1 +
 hw/net/can/xlnx-versal-canfd.c | 1 +
 hw/net/can/xlnx-zynqmp-can.c   | 1 +
 hw/net/dp8393x.c               | 1 +
 hw/net/e1000.c                 | 1 +
 hw/net/e1000e.c                | 1 +
 hw/net/eepro100.c              | 1 +
 hw/net/fsl_etsec/etsec.c       | 1 +
 hw/net/ftgmac100.c             | 1 +
 hw/net/igb.c                   | 1 +
 hw/net/igbvf.c                 | 1 +
 hw/net/imx_fec.c               | 2 ++
 hw/net/lan9118.c               | 1 +
 hw/net/lan9118_phy.c           | 1 +
 hw/net/lance.c                 | 1 +
 hw/net/lasi_i82596.c           | 1 +
 hw/net/mcf_fec.c               | 1 +
 hw/net/msf2-emac.c             | 1 +
 hw/net/mv88w8618_eth.c         | 1 +
 hw/net/ne2000-isa.c            | 1 +
 hw/net/ne2000-pci.c            | 1 +
 hw/net/npcm7xx_emc.c           | 1 +
 hw/net/npcm_gmac.c             | 1 +
 hw/net/npcm_pcs.c              | 1 +
 hw/net/opencores_eth.c         | 1 +
 hw/net/pcnet-pci.c             | 1 +
 hw/net/rocker/rocker.c         | 1 +
 hw/net/rtl8139.c               | 1 +
 hw/net/smc91c111.c             | 1 +
 hw/net/spapr_llan.c            | 1 +
 hw/net/stellaris_enet.c        | 1 +
 hw/net/sungem.c                | 1 +
 hw/net/sunhme.c                | 1 +
 hw/net/tulip.c                 | 1 +
 hw/net/virtio-net.c            | 1 +
 hw/net/vmxnet3.c               | 1 +
 hw/net/xen_nic.c               | 1 +
 hw/net/xgmac.c                 | 1 +
 hw/net/xilinx_axienet.c        | 1 +
 hw/net/xilinx_ethlite.c        | 1 +
 46 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 30a81576b4..9239be7a2b 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -892,6 +892,7 @@ static const TypeInfo allwinner_sun8i_emac_info = {
     .instance_size  = sizeof(AwSun8iEmacState),
     .instance_init  = allwinner_sun8i_emac_init,
     .class_init     = allwinner_sun8i_emac_class_init,
+    .insecure       = true,
 };
 
 static void allwinner_sun8i_emac_register_types(void)
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 77d089d988..2c2cd68aae 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -528,8 +528,9 @@ static const TypeInfo aw_emac_info = {
     .name           = TYPE_AW_EMAC,
     .parent         = TYPE_SYS_BUS_DEVICE,
     .instance_size  = sizeof(AwEmacState),
-    .instance_init   = aw_emac_init,
+    .instance_init  = aw_emac_init,
     .class_init     = aw_emac_class_init,
+    .insecure       = true,
 };
 
 static void aw_emac_register_types(void)
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 44446666de..0d9894a95a 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1833,6 +1833,7 @@ static const TypeInfo gem_info = {
     .instance_size  = sizeof(CadenceGEMState),
     .instance_init = gem_init,
     .class_init = gem_class_init,
+    .insecure = true,
 };
 
 static void gem_register_types(void)
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index be16769de2..d22d8af9d0 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -305,6 +305,7 @@ static const TypeInfo kvaser_pci_info = {
     .instance_size = sizeof(KvaserPCIState),
     .class_init    = kvaser_pci_class_init,
     .instance_init = kvaser_pci_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 44f3ba370d..9d73b3da8f 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -248,6 +248,7 @@ static const TypeInfo mioe3680_pci_info = {
     .instance_size = sizeof(Mioe3680PCIState),
     .class_init    = mioe3680_pci_class_init,
     .instance_init = mioe3680_pci_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 7296d63be7..dd17f184e9 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -249,6 +249,7 @@ static const TypeInfo pcm3680i_pci_info = {
     .instance_size = sizeof(Pcm3680iPCIState),
     .class_init    = pcm3680i_pci_class_init,
     .instance_init = pcm3680i_pci_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index bed6785433..24dbd2b7c5 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -262,6 +262,7 @@ static const TypeInfo ctucan_pci_info = {
     .instance_size = sizeof(CtuCanPCIState),
     .class_init    = ctucan_pci_class_init,
     .instance_init = ctucan_pci_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 3eb111949f..3bd3e92c29 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -2068,6 +2068,7 @@ static const TypeInfo canfd_info = {
     .instance_size = sizeof(XlnxVersalCANFDState),
     .class_init    = canfd_class_init,
     .instance_init = canfd_init,
+    .insecure      = true,
 };
 
 static void canfd_register_types(void)
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index ca9edd4a5b..c9a21e0fe5 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -1194,6 +1194,7 @@ static const TypeInfo can_info = {
     .instance_size = sizeof(XlnxZynqMPCANState),
     .class_init    = xlnx_zynqmp_can_class_init,
     .instance_init = xlnx_zynqmp_can_init,
+    .insecure      = true,
 };
 
 static void can_register_types(void)
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index d49032059b..06e0da8052 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -956,6 +956,7 @@ static const TypeInfo dp8393x_info = {
     .instance_size = sizeof(dp8393xState),
     .instance_init = dp8393x_instance_init,
     .class_init    = dp8393x_class_init,
+    .insecure      = true,
 };
 
 static void dp8393x_register_types(void)
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a80a7b0cdb..684350557f 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1759,6 +1759,7 @@ static void e1000_register_types(void)
         type_info.parent = TYPE_E1000_BASE;
         type_info.class_data = info;
         type_info.class_init = e1000_class_init;
+        type_info.secure = true,
 
         type_register_static(&type_info);
     }
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 89e6d52ba0..83cf3cf643 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -721,6 +721,7 @@ static const TypeInfo e1000e_info = {
     .instance_size = sizeof(E1000EState),
     .class_init = e1000e_class_init,
     .instance_init = e1000e_instance_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index d47df5a97f..78c7bb1a12 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2094,6 +2094,7 @@ static void eepro100_register_types(void)
         type_info.class_init = eepro100_class_init;
         type_info.instance_size = sizeof(EEPRO100State);
         type_info.instance_init = eepro100_instance_init;
+        type_info.insecure = true,
         type_info.interfaces = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 846f6cbc5d..474b941ba5 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -437,6 +437,7 @@ static const TypeInfo etsec_types[] = {
         .instance_size = sizeof(eTSEC),
         .class_init    = etsec_class_init,
         .instance_init = etsec_instance_init,
+        .insecure      = true,
     },
 };
 
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index c41ce889cf..7243ad8a02 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1277,6 +1277,7 @@ static const TypeInfo ftgmac100_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FTGMAC100State),
     .class_init = ftgmac100_class_init,
+    .insecure = true,
 };
 
 /*
diff --git a/hw/net/igb.c b/hw/net/igb.c
index e4c02365d6..2ce8582e76 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -635,6 +635,7 @@ static const TypeInfo igb_info = {
     .instance_size = sizeof(IGBState),
     .class_init = igb_class_init,
     .instance_init = igb_instance_init,
+    .insecure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 31d72c4977..2072b7a169 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -325,6 +325,7 @@ static const TypeInfo igbvf_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(IgbVfState),
     .class_init = igbvf_class_init,
+    .insecure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index e5e34dd1a4..22f20dc048 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1261,12 +1261,14 @@ static const TypeInfo imx_fec_info = {
     .instance_size = sizeof(IMXFECState),
     .instance_init = imx_fec_init,
     .class_init    = imx_eth_class_init,
+    .insecure      = true,
 };
 
 static const TypeInfo imx_enet_info = {
     .name          = TYPE_IMX_ENET,
     .parent        = TYPE_IMX_FEC,
     .instance_init = imx_enet_init,
+    .insecure      = true,
 };
 
 static void imx_eth_register_types(void)
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 3017e12971..f59468aa34 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1325,6 +1325,7 @@ static const TypeInfo lan9118_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(lan9118_state),
     .class_init    = lan9118_class_init,
+    .insecure      = true,
 };
 
 static void lan9118_register_types(void)
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index 4c4e03df11..305c019a68 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -216,6 +216,7 @@ static const TypeInfo types[] = {
         .instance_size = sizeof(Lan9118PhyState),
         .instance_init = lan9118_phy_init,
         .class_init    = lan9118_phy_class_init,
+        .insecure      = true,
     }
 };
 
diff --git a/hw/net/lance.c b/hw/net/lance.c
index dfb855c23a..314d1eeae3 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -161,6 +161,7 @@ static const TypeInfo lance_info = {
     .instance_size = sizeof(SysBusPCNetState),
     .class_init    = lance_class_init,
     .instance_init = lance_instance_init,
+    .insecure      = true,
 };
 
 static void lance_register_types(void)
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 9e1dd21546..56ee1688d1 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -181,6 +181,7 @@ static const TypeInfo lasi_82596_info = {
     .instance_size = sizeof(SysBusI82596State),
     .class_init    = lasi_82596_class_init,
     .instance_init = lasi_82596_instance_init,
+    .insecure      = true,
 };
 
 static void lasi_82596_register_types(void)
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index ae128fa311..20d2bc3fd3 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -681,6 +681,7 @@ static const TypeInfo mcf_fec_info = {
     .instance_size = sizeof(mcf_fec_state),
     .instance_init = mcf_fec_instance_init,
     .class_init    = mcf_fec_class_init,
+    .insecure      = true,
 };
 
 static void mcf_fec_register_types(void)
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index 59045973ab..d92e0bee09 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -581,6 +581,7 @@ static const TypeInfo msf2_emac_info = {
     .instance_size = sizeof(MSF2EmacState),
     .instance_init = msf2_emac_init,
     .class_init    = msf2_emac_class_init,
+    .insecure      = true,
 };
 
 static void msf2_emac_register_types(void)
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index 6f08846c81..56a1e9dff3 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -392,6 +392,7 @@ static const TypeInfo mv88w8618_eth_info = {
     .instance_size = sizeof(mv88w8618_eth_state),
     .instance_init = mv88w8618_eth_init,
     .class_init    = mv88w8618_eth_class_init,
+    .insecure      = true,
 };
 
 static void musicpal_register_types(void)
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 673c785abc..cb3ffc7668 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -142,6 +142,7 @@ static const TypeInfo ne2000_isa_info = {
     .instance_size = sizeof(ISANE2000State),
     .class_init    = isa_ne2000_class_initfn,
     .instance_init = isa_ne2000_instance_init,
+    .insecure      = true,
 };
 
 static void ne2000_isa_register_types(void)
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index ce937e1b61..b1381efb89 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -122,6 +122,7 @@ static const TypeInfo ne2000_info = {
     .instance_size = sizeof(PCINE2000State),
     .class_init    = ne2000_class_init,
     .instance_init = ne2000_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index 9ba35e2c81..b8f7cb9135 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -867,6 +867,7 @@ static const TypeInfo npcm7xx_emc_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(NPCM7xxEMCState),
     .class_init = npcm7xx_emc_class_init,
+    .insecure = true,
 };
 
 static void npcm7xx_emc_register_type(void)
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 5e32cd3edf..bafbee028f 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -933,6 +933,7 @@ static const TypeInfo npcm_gmac_types[] = {
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(NPCMGMACState),
         .class_init = npcm_gmac_class_init,
+        .insecure = true,
     },
 };
 DEFINE_TYPES(npcm_gmac_types)
diff --git a/hw/net/npcm_pcs.c b/hw/net/npcm_pcs.c
index 6aec105271..42ee30382c 100644
--- a/hw/net/npcm_pcs.c
+++ b/hw/net/npcm_pcs.c
@@ -405,6 +405,7 @@ static const TypeInfo npcm_pcs_types[] = {
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(NPCMPCSState),
         .class_init = npcm_pcs_class_init,
+        .insecure = true,
     },
 };
 DEFINE_TYPES(npcm_pcs_types)
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 7e955c0132..3d03f8fd73 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -763,6 +763,7 @@ static const TypeInfo open_eth_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(OpenEthState),
     .class_init    = open_eth_class_init,
+    .insecure      = true,
 };
 
 static void open_eth_register_types(void)
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0ca5bc2193..2ad441e78a 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -280,6 +280,7 @@ static const TypeInfo pcnet_info = {
     .instance_size = sizeof(PCIPCNetState),
     .class_init    = pcnet_class_init,
     .instance_init = pcnet_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index cc49701dd3..5e8ecf1c02 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1498,6 +1498,7 @@ static const TypeInfo rocker_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(Rocker),
     .class_init    = rocker_class_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 324fb932aa..a6147099f3 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3439,6 +3439,7 @@ static const TypeInfo rtl8139_info = {
     .instance_size = sizeof(RTL8139State),
     .class_init    = rtl8139_class_init,
     .instance_init = rtl8139_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 5cd78e334b..89c959234e 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -928,6 +928,7 @@ static const TypeInfo smc91c111_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(smc91c111_state),
     .class_init    = smc91c111_class_init,
+    .insecure      = true,
 };
 
 static void smc91c111_register_types(void)
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index f6f217d632..07b8d125e5 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -873,6 +873,7 @@ static const TypeInfo spapr_vlan_info = {
     .class_init    = spapr_vlan_class_init,
     .instance_init = spapr_vlan_instance_init,
     .instance_finalize = spapr_vlan_instance_finalize,
+    .insecure      = true,
 };
 
 static void spapr_vlan_register_types(void)
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 2fc51e1e16..cb29ba6e02 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -516,6 +516,7 @@ static const TypeInfo stellaris_enet_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(stellaris_enet_state),
     .class_init    = stellaris_enet_class_init,
+    .insecure      = true,
 };
 
 static void stellaris_enet_register_types(void)
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index b405eb89fa..7ca0ab8d46 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1477,6 +1477,7 @@ static const TypeInfo sungem_info = {
     .instance_size = sizeof(SunGEMState),
     .class_init    = sungem_class_init,
     .instance_init = sungem_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index c2f7a8483d..5d601395f3 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -958,6 +958,7 @@ static const TypeInfo sunhme_info = {
     .class_init    = sunhme_class_init,
     .instance_size = sizeof(SunHMEState),
     .instance_init = sunhme_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 319af906c8..4b1645bd27 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1035,6 +1035,7 @@ static const TypeInfo tulip_info = {
     .instance_size = sizeof(TULIPState),
     .class_init    = tulip_class_init,
     .instance_init = tulip_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6b5b5dace3..b34c0f3afc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4259,6 +4259,7 @@ static const TypeInfo virtio_net_info = {
     .instance_size = sizeof(VirtIONet),
     .instance_init = virtio_net_instance_init,
     .class_init = virtio_net_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index af73aa8ef2..29b0efc1db 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2491,6 +2491,7 @@ static const TypeInfo vmxnet3_info = {
     .instance_size = sizeof(VMXNET3State),
     .class_init    = vmxnet3_class_init,
     .instance_init = vmxnet3_instance_init,
+    .insecure      = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 34c6a1d0b0..eae29b4407 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -581,6 +581,7 @@ static const TypeInfo xen_net_type_info = {
     .parent = TYPE_XEN_DEVICE,
     .instance_size = sizeof(XenNetDev),
     .class_init = xen_netdev_class_init,
+    .secure = true,
 };
 
 static void xen_net_register_types(void)
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index d45f872467..1fa2361404 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -432,6 +432,7 @@ static const TypeInfo xgmac_enet_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XgmacState),
     .class_init    = xgmac_enet_class_init,
+    .insecure      = true,
 };
 
 static void xgmac_enet_register_types(void)
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 1f5c748047..1e27bfff3d 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1038,6 +1038,7 @@ static const TypeInfo xilinx_enet_info = {
     .instance_size = sizeof(XilinxAXIEnet),
     .class_init    = xilinx_enet_class_init,
     .instance_init = xilinx_enet_init,
+    .insecure = true,
 };
 
 static const TypeInfo xilinx_enet_data_stream_info = {
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 42b19d07c7..81ed721ad8 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -401,6 +401,7 @@ static const TypeInfo xilinx_ethlite_types[] = {
         .instance_size = sizeof(XlnxXpsEthLite),
         .instance_init = xilinx_ethlite_init,
         .class_init    = xilinx_ethlite_class_init,
+        .insecure      = true,
     },
 };
 
-- 
2.50.1


