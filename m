Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DBFE9D41F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngkw-0007cR-C9; Wed, 04 Feb 2026 12:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vngkt-0007Sd-Jt
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:33:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vngkr-0005es-Mg
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:33:31 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5nVZ1RWVzJ46BN;
 Thu,  5 Feb 2026 01:32:38 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 883624056A;
 Thu,  5 Feb 2026 01:33:27 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:33:26 +0000
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Arpit Kumar
 <arpit1.kumar@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
 <venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 2/3] hw/cxl: Get Physical Port State - update for PCIe
 flit mode
Date: Wed, 4 Feb 2026 17:32:22 +0000
Message-ID: <20260204173223.44122-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Recent support for 256B flits, was not accounted for in this FMAPI command
that should be retrieving the current status of Physical Switch Ports.

Note x-flit-mode control is via the downstream devices, so for USPs the
property must be checked to establish support, but for DSPs this mode is
always supported (control is with the next port downstream, typically the
end point.  All cases the linksta2 register may be queried to obtain
current status.  Note the PCI spec is a little confusing as it refers to
this bit only being non 0 if Device Readiness Status (DRS) is in particular
states (basically link trained) but Flit mode is a separate feature and DRS
may not be present. It is not yet emulated in QEMU. So assume that we
should reflect what states DRS would be reporting if it were actually
present.

One small thing to note is that the current link width for a port with
nothing connected reports the same as the capability. This is odd but valid
because the value under these circumstances is undefined (PCIe r6.2 table
7-26 Link Status Register - field Current Link Speed.)

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1c8cbe0f682d..b6ac987ee021 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -627,9 +627,26 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
             port->config_state = CXL_PORT_CONFIG_STATE_DSP;
             if (ds_dev) {
                 if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                    uint16_t lnksta2;
+
+                    if (!port_dev->exp.exp_cap) {
+                        return CXL_MBOX_INTERNAL_ERROR;
+                    }
+
+                    lnksta2 = port_dev->config_read(port_dev,
+                                  port_dev->exp.exp_cap + PCI_EXP_LNKSTA2,
+                                  sizeof(lnksta2));
+
                     /* Assume MLD for now */
                     port->connected_device_type =
                         CXL_PORT_CONNECTED_DEV_TYPE_3_MLD;
+                    if (lnksta2 & PCI_EXP_LNKSTA2_FLIT) {
+                        port->connected_device_mode =
+                            CXL_PORT_CONNECTED_DEV_MODE_256B;
+                    } else {
+                        port->connected_device_mode =
+                            CXL_PORT_CONNECTED_DEV_MODE_68B_VH;
+                    }
                 } else {
                     port->connected_device_type =
                         CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
@@ -642,12 +659,17 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                 port->connected_device_mode =
                     CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
             }
+            /* DSP currently always support modes implemented in QEMU */
+            port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
+                CXL_PORT_SUPPORTS_256B;
             port->supported_ld_count = 3;
         } else if (usp->port == in->ports[i]) { /* USP */
             port_dev = PCI_DEVICE(usp);
             port->config_state = CXL_PORT_CONFIG_STATE_USP;
             port->connected_device_type = 0; /* Reserved for USP */
             port->connected_device_mode = 0; /* Reserved for USP */
+            port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
+                (CXL_USP(usp)->flitmode ? CXL_PORT_SUPPORTS_256B : 0);
         } else {
             return CXL_MBOX_INVALID_INPUT;
         }
@@ -676,8 +698,6 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         /* TODO: Track down if we can get the rest of the info */
         port->ltssm_state = 0x7;
         port->first_lane_num = 0;
-        port->link_state = 0;
-        port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH;
     }
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
-- 
2.51.0


