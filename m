Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E6AE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLezH-0004Kr-DC; Thu, 12 Dec 2024 03:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tLezF-0004Ke-5w
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:55:57 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tLezC-0003YG-Oh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1733993754; x=1765529754;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4evv+U15xH0JVrWpF1XQPkmVwCETnRKT4wl7je67gg4=;
 b=jgDovG6uv9iEbgUxP88TNAQIJmsu9ETYC0YzK/wahOSlkkhyVejdvz30
 tD+0gmaNxWyJtTkLXZd3y6VQvi3vB8k2z7AOPvF0HJl/xchBKE5g/MPBe
 tKNdZVGX2bgoV8aDSAfGYL+/2IP+FQAabaMfw9+UTcOAG58M3eJkL8K+f
 BmMlDScEo9MDJqAH8rKbsnZ9QjlLQyazL6LOI0OcTT9sxzxfe+wf58io8
 rZqOPYnZL5JBMcHztVOMBba4bheYlEDGxmow4DORV3DzVbUVH+GRZbm7R
 VLqYq4OS5uIO2ry710jr9M1p7XjMUq6rFcAuGLl5XongmepZgTi9fQ016 A==;
X-CSE-ConnectionGUID: vOLqvmLRSA23VNnZHprcDg==
X-CSE-MsgGUID: A0eGHIvjTIqB+2OzsnzZgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="171834621"
X-IronPort-AV: E=Sophos;i="6.12,228,1728918000"; d="scan'208";a="171834621"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 17:55:47 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2BC86D8E1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 17:55:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id EE751D5075
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 17:55:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 738C96BD63
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 17:55:44 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A68121A0003;
 Thu, 12 Dec 2024 16:55:43 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Date: Thu, 12 Dec 2024 16:55:33 +0800
Message-ID: <20241212085534.2669377-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28854.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28854.006
X-TMASE-Result: 10--1.719600-10.000000
X-TMASE-MatchedRID: pfKaEBrCt3LCVJdexVBqdn1zro62qhdCLL6mJOIs/vZGQgIVrmBL5G7l
 BX/37R4p+xFlvZshf1aUrbS7Rz/s6duWQuISDK/k9k5nZzZVBSAE9jhJ6ArePCsrtFRYD/6QPlA
 WwfVA2w7wx1fpYFo1NLXYdqC9vAOOL/tBTZzO5Q0D2WXLXdz+AaGD6ovXqA23Cb7y9s8XSuQTgt
 4grpaSCs2ghO0gXEiIq55sJBkGMyKkD6PdvhyWwrrbxxduc6FPPRMmeAtBYdvMtotGtpF5VoVrk
 544tkDY4vM1YF6AJbbCCfuIMF6xLSdET58jp62SqBM7+ZLn8druAudpF/ll2JfxsyEKVT7IXNTs
 qTX2Gk8mezWG7OSchvnR0BHEa2IassaVc7c9CmpIvIKWGhYem93JoLj0uAhKwGC8e6520fKw0PJ
 t06oJaHpaQl5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=lizhijian@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Expand the device's MSIX to 10 and introduce the `request_msix_number()`
helper function to dynamically request an available MSIX number.

Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/cxl/cxl-device-utils.c   |  3 ++-
 hw/mem/cxl_type3.c          | 15 ++++++++++++++-
 include/hw/cxl/cxl_device.h |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6d..8e52af6813 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -354,8 +354,9 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    const uint8_t msi_n = 9;
+    uint8_t msi_n = cxl_request_msi_number();
 
+    assert(msi_n > 0);
     /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..dbb1368736 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -835,6 +835,19 @@ static DOEProtocol doe_cdat_prot[] = {
     { }
 };
 
+#define CT3_MSIX_NUM 10
+unsigned short cxl_request_msi_number(void)
+{
+    const unsigned short start = 6;
+    static unsigned short next = start;
+
+    if (next + 1 >= CT3_MSIX_NUM) {
+        return -1;
+    }
+
+    return ++next;
+}
+
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -843,7 +856,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 6;
+    unsigned short msix_num = CT3_MSIX_NUM;
     int i, rc;
     uint16_t count;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc8..622265f50e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -680,4 +680,6 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+unsigned short cxl_request_msi_number(void);
+
 #endif
-- 
2.41.0


