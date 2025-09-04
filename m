Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D76CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9sw-0005ff-SG; Thu, 04 Sep 2025 09:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uu9sm-0005aY-Ji
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:20:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uu9sY-0007iQ-5J
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:20:05 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250904131946epoutp0463cbd6cee9aae6ba42c8110fcc6c1336~iFuc3nq-s1284312843epoutp04d
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 13:19:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250904131946epoutp0463cbd6cee9aae6ba42c8110fcc6c1336~iFuc3nq-s1284312843epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1756991986;
 bh=VCwBX32WHRi4ZOQ9C5otad+45Y/sWCmU13qBrvXGpQQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XqM9b0DBVbmfTZFA36Hxt5N02k96R21L77HS/M512ZLm/6huJUa6zdhLxgYNBRjdh
 dedVuFRKbZnseNa3hJ0JSILigCe75oxXXLMgNZxEVk3gbrlqJKWcA6bQ8acyF76V4d
 KaZ6a03aTsTyBE/5jAmpNLfJaP5EKZBjnipPXNqE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20250904131945epcas5p188e513089881b35221c3faeb9728d5e7~iFubsO-op2631826318epcas5p1E;
 Thu,  4 Sep 2025 13:19:45 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4cHg7N56mmz3hhT3; Thu,  4 Sep
 2025 13:19:44 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3~iFuaST_Jq1316413164epcas5p3C;
 Thu,  4 Sep 2025 13:19:44 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250904131942epsmtip261cb787df2b76cbe6aba6d0682c43ae8~iFuY6T1YV0295002950epsmtip2d;
 Thu,  4 Sep 2025 13:19:42 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, dave@stgolabs.net,
 Jonathan.Cameron@huawei.com, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, cpgs@samsung.com, Arpit
 Kumar <arpit1.kumar@samsung.com>
Subject: [PATCH v3 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Date: Thu,  4 Sep 2025 18:49:04 +0530
Message-Id: <20250904131904.725758-3-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904131904.725758-1-arpit1.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3
References: <20250904131904.725758-1-arpit1.kumar@samsung.com>
 <CGME20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

-added assert-deassert PERST implementation
 for physical ports (both USP and DSP's).
-assert PERST involves bg operation for holding 100ms.
-reset PPB implementation for physical ports.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c                | 138 ++++++++++++++++++++++
 include/hw/cxl/cxl_device.h               |   9 ++
 include/hw/cxl/cxl_mailbox.h              |   1 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 4 files changed, 149 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cb36880f0b..a0b76946a2 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -540,6 +540,120 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void *bg_assertcb(void *opaque)
+{
+    CXLPhyPortPerst *perst = opaque;
+
+    /* holding reset phase for 100ms */
+    while (perst->asrt_time--) {
+        usleep(1000);
+    }
+    perst->issued_assert_perst = true;
+    return NULL;
+}
+
+static CXLRetCode deassert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
+{
+    if (!pp->pports.perst[pn].issued_assert_perst) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&pp->pports.perst[pn].lock);
+    resettable_release_reset(obj, RESET_TYPE_COLD);
+    pp->pports.perst[pn].issued_assert_perst = false;
+    pp->pports.pport_info[pn].link_state_flags &=
+        ~LINK_STATE_FLAG_PERST_ASSERTED;
+    pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode assert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
+{
+    if (pp->pports.perst[pn].issued_assert_perst ||
+        pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&pp->pports.perst[pn].lock);
+    pp->pports.pport_info[pn].link_state_flags |=
+        LINK_STATE_FLAG_PERST_ASSERTED;
+    resettable_assert_reset(obj, RESET_TYPE_COLD);
+    qemu_thread_create(&pp->pports.perst[pn].asrt_thread, "assert_thread",
+        bg_assertcb, &pp->pports.perst[pn], QEMU_THREAD_DETACHED);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static struct PCIDevice *cxl_find_port_dev(uint8_t pn, CXLCCI *cci)
+{
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+
+    if (pp->pports.pport_info[pn].current_port_config_state ==
+        CXL_PORT_CONFIG_STATE_USP) {
+        return pci_bridge_get_device(bus);
+    }
+
+    if (pp->pports.pport_info[pn].current_port_config_state ==
+        CXL_PORT_CONFIG_STATE_DSP) {
+        return pcie_find_port_by_pn(bus, pn);
+    }
+    return NULL;
+}
+
+/* CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h) */
+static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+   CXLUpstreamPort *pp = CXL_USP(cci->d);
+   PCIDevice *dev;
+   uint8_t pn;
+   uint8_t ret = CXL_MBOX_SUCCESS;
+
+   struct cxl_fmapi_get_physical_port_control_req_pl {
+        uint8_t ppb_id;
+        uint8_t ports_op;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    pn = in->ppb_id;
+    if (pp->pports.pport_info[pn].port_id != pn) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    dev = cxl_find_port_dev(pn, cci);
+    if (!dev) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    switch (in->ports_op) {
+    case 0:
+        ret = assert_perst(OBJECT(&dev->qdev), pn, pp);
+        break;
+    case 1:
+        ret = deassert_perst(OBJECT(&dev->qdev), pn, pp);
+        break;
+    case 2:
+        if (pp->pports.perst[pn].issued_assert_perst ||
+            pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        device_cold_reset(&dev->qdev);
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    return ret;
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -4781,6 +4895,8 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
@@ -4791,6 +4907,28 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
     cci->d = d;
     cci->intf = intf;
+    CXLUpstreamPort *pp;
+    int pn = 0;
     cxl_init_cci(cci, payload_max);
     cxl_set_phy_port_info(cci);
+    /* physical port control */
+    pp = CXL_USP(cci->d);
+    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
+         byte_index++) {
+        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
+
+        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
+            if (((byte) & (1 << bit_index)) != 0) {
+                qemu_mutex_init(&pp->pports.perst[pn].lock);
+                pp->pports.perst[pn].issued_assert_perst = false;
+                /*
+                 * Assert PERST involves physical port to be in
+                 * hold reset phase for minimum 100ms. No other
+                 * physcial port control requests are entertained
+                 * until Deassert PERST command.
+                 */
+                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
+            }
+        }
+    }
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9fc720ec10..033d9bf11a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -130,6 +130,7 @@
                   (1 << 16))
 
 #define CXL_MAX_PHY_PORTS 256
+#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
 
 /* physical port control info - CXL r3.2 table 7-19 */
 #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
@@ -196,6 +197,14 @@ typedef struct CXLPhyPortInfo {
     uint8_t supported_ld_count;
 } QEMU_PACKED CXLPhyPortInfo;
 
+/* Assert - Deassert PERST */
+typedef struct CXLPhyPortPerst {
+    bool issued_assert_perst;
+    QemuMutex lock; /* protecting assert-deassert reset request */
+    uint64_t asrt_time;
+    QemuThread asrt_thread; /* thread for 100ms delay */
+} CXLPhyPortPerst;
+
 /* CXL r3.1 Table 8-34: Command Return Codes */
 typedef enum {
     CXL_MBOX_SUCCESS = 0x0,
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 5c918c53a9..5c31023590 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -88,6 +88,7 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+        #define PHYSICAL_PORT_CONTROL       0X2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index 3b7e72bfe0..4b9da87d77 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -30,6 +30,7 @@ typedef struct CXLUpstreamPort {
         uint8_t num_ports;
         uint8_t active_port_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
         CXLPhyPortInfo pport_info[CXL_MAX_PHY_PORTS];
+        CXLPhyPortPerst perst[CXL_MAX_PHY_PORTS];
     } pports;
 } CXLUpstreamPort;
 
-- 
2.34.1


