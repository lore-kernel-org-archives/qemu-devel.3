Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6234CC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLAc-0006VN-5t; Fri, 26 Jan 2024 07:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTLAO-0006OH-9o
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:18:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTLAM-0005GX-9k
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:18:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLxVC0P0bz6JBFK;
 Fri, 26 Jan 2024 20:15:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 026E2140CF4;
 Fri, 26 Jan 2024 20:18:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:18:36 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] hw/cxl: Update mailbox status registers.
Date: Fri, 26 Jan 2024 12:16:35 +0000
Message-ID: <20240126121636.24611-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126121636.24611-1-Jonathan.Cameron@huawei.com>
References: <20240126121636.24611-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Whilst the reported version was 1 so there should be no changes,
a couple of fields (where the value 0 was valid) were not
defined. Make those explicit and update references to be based
on CXL r3.1.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
 include/hw/cxl/cxl_device.h | 17 ++++++++++-------
 hw/cxl/cxl-device-utils.c   |  6 +++++-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 31d2afcd3d..9f51c586d7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -189,7 +189,7 @@ typedef struct cxl_device_state {
         };
     };
 
-    /* mmio for the mailbox registers 8.2.8.4 */
+    /* CXL r3.1 Section 8.2.8.4: Mailbox Registers */
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
@@ -310,39 +310,42 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
 REG64(CXL_DEV_EVENT_STATUS, 0)
     FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
 
-/* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
+#define CXL_DEV_MAILBOX_VERSION 1
+/* CXL r3.1 Section 8.2.8.4.3: Mailbox Capabilities Register */
 REG32(CXL_DEV_MAILBOX_CAP, 0)
     FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
     FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
     FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
     FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
+    FIELD(CXL_DEV_MAILBOX_CAP, MBOX_READY_TIME, 11, 8)
+    FIELD(CXL_DEV_MAILBOX_CAP, TYPE, 19, 4)
 
-/* CXL 2.0 8.2.8.4.4 Mailbox Control Register */
+/* CXL r3.1 Section 8.2.8.4.4: Mailbox Control Register */
 REG32(CXL_DEV_MAILBOX_CTRL, 4)
     FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
     FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
     FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
 
-/* CXL 2.0 8.2.8.4.5 Command Register */
+/* CXL r3.1 Section 8.2.8.4.5: Command Register */
 REG64(CXL_DEV_MAILBOX_CMD, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, COMMAND, 0, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, COMMAND_SET, 8, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, LENGTH, 16, 20)
 
-/* CXL 2.0 8.2.8.4.6 Mailbox Status Register */
+/* CXL r3.1 Section 8.2.8.4.6: Mailbox Status Register */
 REG64(CXL_DEV_MAILBOX_STS, 0x10)
     FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
     FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
     FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
 
-/* CXL 2.0 8.2.8.4.7 Background Command Status Register */
+/* CXL r3.1 Section 8.2.8.4.7: Background Command Status Register */
 REG64(CXL_DEV_BG_CMD_STS, 0x18)
     FIELD(CXL_DEV_BG_CMD_STS, OP, 0, 16)
     FIELD(CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP, 16, 7)
     FIELD(CXL_DEV_BG_CMD_STS, RET_CODE, 32, 16)
     FIELD(CXL_DEV_BG_CMD_STS, VENDOR_RET_CODE, 48, 16)
 
-/* CXL 2.0 8.2.8.4.8 Command Payload Registers */
+/* CXL r3.1 Section 8.2.8.4.8: Command Payload Registers */
 REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
 
 REG64(CXL_MEM_DEV_STS, 0)
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 40b619ffd9..9df8738f86 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -366,6 +366,10 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      MSI_N, msi_n);
     cxl_dstate->mbox_msi_n = msi_n;
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     MBOX_READY_TIME, 0); /* Not reported */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     TYPE, 0); /* Inferred from class code */
 }
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
@@ -392,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
     device_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
     mailbox_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
-- 
2.39.2


