Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696DBE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM25x-0000UW-BR; Fri, 13 Dec 2024 04:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tM25r-0000Ty-Cf
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:36:20 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tM25o-0005Gk-T8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734082577; x=1765618577;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6NrpNnngy2DN9FFMrEyRuXx+lmv5gqBPAayUJXmUL/M=;
 b=JH6+92H/7fEQ9Nc3nOeVwzM2VAxLz6NlXoY6zT+rhC2w46dhqY9vC0Uy
 hRg9CjC70KU4kMXvdA3N/shORrJwNNS2iy1rnbzd6o5dhTa9tPPhJOq6T
 M93aFxeNW+8ClRRnNlERxgjG2E0/M1mQF6Vhtw5J82t3eh/Z+EBfnzEJ8
 xj8NSv2Y9MehB3RzDZVV7QQafEmjJyoADiKBWSxLfy0dmHhBG7q4NGDQd
 WmnZHo7kJm5zec8V8lon6NqM3uvv5sB4QSRJ+aw9AwNWj5S3dl7AmonyR
 hfJH1AVYVixUdKI2BIWi+DmrJFBMEUyD/G6zqjiYzqCuurusQc+jWkayk g==;
X-CSE-ConnectionGUID: 5Yl8VDdZTum7XBnavF3dCg==
X-CSE-MsgGUID: WZdWg6XbQrSEeocPTzL8Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="170951169"
X-IronPort-AV: E=Sophos;i="6.12,230,1728918000"; d="scan'208";a="170951169"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2024 18:36:09 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id AA3F8D480A
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 18:36:07 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F5CBD8B30
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 18:36:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D40E6BD4B
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 18:36:07 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3E0031A006C;
 Fri, 13 Dec 2024 17:36:06 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Date: Fri, 13 Dec 2024 17:36:02 +0800
Message-ID: <20241213093602.3248246-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28856.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28856.006
X-TMASE-Result: 10--8.981400-10.000000
X-TMASE-MatchedRID: IVNJzyZeXh7CVJdexVBqdn1zro62qhdCLL6mJOIs/vZGQgIVrmBL5G7l
 BX/37R4p+xFlvZshf1aUrbS7Rz/s6duWQuISDK/klTsGW3DmpUsWUg/hm489yFy92pa0KjKSZ28
 gEzxS4tKPfJJz7Ia9+rXYdqC9vAOOL/tBTZzO5Q0D2WXLXdz+AaGD6ovXqA23Cb7y9s8XSuQTgt
 4grpaSCs2ghO0gXEiI8ypyOLdjkCpAh0h+ieLkqGe0R3NAF/chGB9/bxS68hM0DNPwjqLncDzdD
 +58t9bI7foLApH+eB4kZf7JZKlNJtgW4k6aveo4uLt50vtxBA4HyFMDF+j4Apsoi2XrUn/Jn6Kd
 MrRsL14qtq5d3cxkNYLH5oQAcCkqRf3IpRODLzw/eYK5BWAtfKcn2QlF2WYhxKtXrSwh7t8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This assertion always happens when we sanitize the CXL memory device.
$ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize

It is incorrect to register an MSIX number beyond the device's capability.

Expand the device's MSIX number and use the enum to maintain the *USED*
and MAX MSIX number

Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: just increase msix number and add enum to maintainer their values #
Jonathan
---
 hw/cxl/cxl-device-utils.c   |  6 ++----
 hw/mem/cxl_type3.c          | 10 +++++-----
 include/hw/cxl/cxl_device.h |  7 +++++++
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6d..bc2171e3d4 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -354,8 +354,6 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    const uint8_t msi_n = 9;
-
     /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
@@ -364,8 +362,8 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      BG_INT_CAP, 1);
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
-                     MSI_N, msi_n);
-    cxl_dstate->mbox_msi_n = msi_n;
+                     MSI_N, CXL_MSIX_MBOX);
+    cxl_dstate->mbox_msi_n = CXL_MSIX_MBOX;
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      MBOX_READY_TIME, 0); /* Not reported */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..f2f060ed9e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,7 +843,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 6;
     int i, rc;
     uint16_t count;
 
@@ -884,16 +883,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_MSIX_MAX, 4, NULL);
     if (rc) {
         goto err_address_space_free;
     }
-    for (i = 0; i < msix_num; i++) {
+    for (i = 0; i < CXL_MSIX_MAX; i++) {
         msix_vector_use(pci_dev, i);
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
+                  CXL_MSIX_PCIE_DOE);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
@@ -908,7 +908,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
-    cxl_event_init(&ct3d->cxl_dstate, 2);
+    cxl_event_init(&ct3d->cxl_dstate, CXL_MSIX_EVENT_START);
 
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc8..3f89b041ce 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,13 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+enum {
+    CXL_MSIX_PCIE_DOE = 0,
+    CXL_MSIX_EVENT_START = 2,
+    CXL_MSIX_MBOX = CXL_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
+    CXL_MSIX_MAX
+};
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
-- 
2.41.0


