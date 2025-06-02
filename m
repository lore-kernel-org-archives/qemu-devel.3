Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E0C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 16:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7ce-0007fs-04; Mon, 02 Jun 2025 12:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uM7ca-0007dT-Nr
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:02:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uM7cU-0006A7-BC
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:02:44 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20250602160233epoutp0337faecf7613a258d4f8d38b6f5d4d0b5~FRTu7zQrO2181921819epoutp03G
 for <qemu-devel@nongnu.org>; Mon,  2 Jun 2025 16:02:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20250602160233epoutp0337faecf7613a258d4f8d38b6f5d4d0b5~FRTu7zQrO2181921819epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1748880153;
 bh=gNt1A+G1hcdy1aQffIAfDZUX8n3iMKGTaux7QVLHRYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VllU8F+OSZVA+ORS9YvDRLebNGKcWGU7wVT4RXchyDXRjf1Bg/g+wBW5cgqkieT1Y
 DnSGCoMI3tSy2K4M0aaTWaScJkIIEwmnQUpnkRweMK3PIaKqg3HMDL/2RQ2tVjzIum
 Hx3eWS3suxjVW8FIcTlLF979Yx+NNzM98cZ6aBw0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20250602160232epcas5p1a7607190e157d50242c3ef904976c98f~FRTuEtOOj1466514665epcas5p1N;
 Mon,  2 Jun 2025 16:02:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.177]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4b9zBZ71bwz3hhTB; Mon,  2 Jun
 2025 16:02:30 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac~FPpAQUhSw1197711977epcas5p2T;
 Mon,  2 Jun 2025 14:00:18 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250602140017epsmtip2e3958f4716988e307d94f02d38db4166~FPo_11Uii2410424104epsmtip20;
 Mon,  2 Jun 2025 14:00:17 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH 1/3] hw/cxl: Storing physical ports info during enumeration
Date: Mon,  2 Jun 2025 19:29:40 +0530
Message-Id: <20250602135942.2773823-2-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
 <CGME20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Physical ports info is stored for both mailbox cci &
mctp based cci type as per spec CXL r3.2 Table 8-230: Physical Switch

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  28 ++++++
 2 files changed, 194 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a02d130926..680055c6c0 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,64 @@ enum {
         #define GET_MHD_INFO 0x0
 };
 
+/* link state flags */
+#define LINK_STATE_FLAG_LANE_REVERSED    (1 << 0)
+#define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
+#define LINK_STATE_FLAG_PRSNT            (1 << 2)
+#define LINK_STATE_FLAG_POWER_OFF        (1 << 3)
+
+/* physical port control info - CXL r3.2 table 7-19 */
+typedef enum {
+    PORT_DISABLED = 0,
+    BIND_IN_PROGRESS = 1,
+    UNBIND_IN_PROGRESS = 2,
+    DSP = 3,
+    USP = 4,
+    FABRIC_PORT = 5,
+    INVALID_PORT_ID = 15
+} current_port_config_state;
+
+typedef enum {
+    NOT_CXL_OR_DISCONNECTED = 0x00,
+    RCD_MODE = 0x01,
+    CXL_68B_FLIT_AND_VH_MODE = 0x02,
+    STANDARD_256B_FLIT_MODE = 0x03,
+    CXL_LATENCY_OPTIMIZED_256B_FLIT_MODE = 0x04,
+    PBR_MODE = 0x05
+} connected_device_mode;
+
+typedef enum {
+    NO_DEVICE_DETECTED = 0,
+    PCIE_DEVICE = 1,
+    CXL_TYPE_1_DEVICE = 2,
+    CXL_TYPE_2_DEVICE_OR_HBR_SWITCH = 3,
+    CXL_TYPE_3_SLD = 4,
+    CXL_TYPE_3_MLD = 5,
+    PBR_COMPONENT = 6
+} connected_device_type;
+
+typedef enum {
+    CXL_RCD_MODE = 0x00,
+    CXL_68B_FLIT_AND_VH_CAPABLE = 0x01,
+    CXL_256B_FLIT_CAPABLE = 0x02,
+    CXL_LATENCY_OPTIMIZED_256B_FLIT = 0x03,
+    CXL_PBR_CAPABLE = 0x04
+} supported_cxl_modes;
+
+typedef enum {
+    LTSSM_DETECT = 0x00,
+    LTSSM_POLLING = 0x01,
+    LTSSM_CONFIGURATION = 0x02,
+    LTSSM_RECOVERY = 0x03,
+    LTSSM_L0 = 0x04,
+    LTSSM_L0S = 0x05,
+    LTSSM_L1 = 0x06,
+    LTSSM_L2 = 0x07,
+    LTSSM_DISABLED = 0x08,
+    LTSSM_LOOPBACK = 0x09,
+    LTSSM_HOT_RESET = 0x0A
+} LTSSM_State;
+
 /* CCI Message Format CXL r3.1 Figure 7-19 */
 typedef struct CXLCCIMessage {
     uint8_t category;
@@ -3686,6 +3744,112 @@ void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
     cxl_rebuild_cel(cci);
 }
 
+static CXLRetCode cxl_set_port_type(struct phy_port *ports, int pnum,
+                                    CXLCCI *cci)
+{
+    PCIDevice *port_dev;
+    uint16_t lnkcap, lnkcap2, lnksta;
+    int i = pnum;
+    if (!cci) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    port_dev = pcie_find_port_by_pn(bus, i);
+
+    if (port_dev) { /* DSP */
+        PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
+            ->devices[0];
+        ports->pport_info[i].port_id = i;
+        ports->pport_info[i].current_port_config_state = DSP;
+        ports->active_port_bitmask[i / 8] |= (1 << i % 8);
+        if (ds_dev) {
+            if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                ports->pport_info[i].connected_device_type = CXL_TYPE_3_MLD;
+            } else {
+                ports->pport_info[i].connected_device_type = PCIE_DEVICE;
+            }
+        } else {
+            ports->pport_info[i].connected_device_type = NO_DEVICE_DETECTED;
+        }
+        ports->pport_info[i].supported_ld_count = 3;
+    } else if (usp->port == i) { /* USP */
+        port_dev = PCI_DEVICE(usp);
+        ports->pport_info[i].port_id = i;
+        ports->pport_info[i].current_port_config_state = USP;
+        ports->pport_info[i].connected_device_type = NO_DEVICE_DETECTED;
+        ports->active_port_bitmask[i / 8] |= (1 << i % 8);
+    } else {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (!port_dev->exp.exp_cap) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    lnksta = port_dev->config_read(port_dev,
+                                   port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
+                                   sizeof(lnksta));
+    lnkcap = port_dev->config_read(port_dev,
+                                   port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
+                                   sizeof(lnkcap));
+    lnkcap2 = port_dev->config_read(port_dev,
+                                    port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
+                                    sizeof(lnkcap2));
+
+    ports->pport_info[i].max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+    ports->pport_info[i].negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
+    ports->pport_info[i].supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
+    ports->pport_info[i].max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
+    ports->pport_info[i].current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
+
+    ports->pport_info[i].ltssm_state = LTSSM_L2;
+    ports->pport_info[i].first_negotiated_lane_num = 0;
+    ports->pport_info[i].link_state_flags = 0;
+    ports->pport_info[i].supported_cxl_modes = CXL_256B_FLIT_CAPABLE;
+    ports->pport_info[i].connected_device_mode = STANDARD_256B_FLIT_MODE;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
+{
+    uint8_t phy_port_num;
+    if (!cci) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    struct phy_port *ports = &cci->pports;
+    int num_phys_ports = pcie_count_ds_ports(bus) + 1;
+    if (num_phys_ports < 0) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    ports->num_ports = num_phys_ports;
+    phy_port_num =  usp->port;
+
+    cxl_set_port_type(ports, phy_port_num, cci); /* usp */
+
+    for (int devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *dev = bus->devices[devfn];
+
+        if (dev) {
+            phy_port_num = PCIE_PORT(dev)->port;
+            const char *typename = object_get_typename(OBJECT(dev));
+
+            if ((strcmp(typename, "cxl-downstream") == 0)) {
+                cxl_set_port_type(ports, phy_port_num, cci);
+            } else {
+                return CXL_MBOX_INTERNAL_ERROR;
+            }
+        }
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
@@ -3693,6 +3857,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci); /* store port info */
 }
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
@@ -3797,4 +3962,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci); /* store port info */
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..9eb128a1e8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -127,6 +127,31 @@
                   CXL_NUM_CHMU_INSTANCES * (1 << 16),                   \
                   (1 << 16))
 
+/* CXL r3.2 Table 7-19: Port Info */
+struct cxl_phy_port_info {
+    uint8_t port_id;
+    uint8_t current_port_config_state;
+    uint8_t connected_device_mode;
+    uint8_t rsv1;
+    uint8_t connected_device_type;
+    uint8_t supported_cxl_modes;
+    uint8_t max_link_width;
+    uint8_t negotiated_link_width;
+    uint8_t supported_link_speeds_vector;
+    uint8_t max_link_speed;
+    uint8_t current_link_speed;
+    uint8_t ltssm_state;
+    uint8_t first_negotiated_lane_num;
+    uint16_t link_state_flags;
+    uint8_t supported_ld_count;
+} QEMU_PACKED;
+
+struct phy_port {
+    uint8_t num_ports;
+    uint8_t active_port_bitmask[0x20];
+    struct cxl_phy_port_info pport_info[PCI_DEVFN_MAX];
+};
+
 /* CXL r3.1 Table 8-34: Command Return Codes */
 typedef enum {
     CXL_MBOX_SUCCESS = 0x0,
@@ -223,6 +248,9 @@ typedef struct CXLCCI {
     /* get log capabilities */
     const CXLLogCapabilities *supported_log_cap;
 
+    /*physical ports information */
+    struct phy_port pports;
+
     /* background command handling (times in ms) */
     struct {
         uint16_t opcode;
-- 
2.34.1


