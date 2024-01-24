Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA20AC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScbz-00050r-RH; Wed, 24 Jan 2024 07:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rScbw-0004za-6j
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:44:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rScbu-0007TH-4Z
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:44:07 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKk8f6hSPz6K8xv;
 Wed, 24 Jan 2024 20:41:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CDB9140517;
 Wed, 24 Jan 2024 20:44:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:44:02 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Huai-Cheng Kuo
 <hchkuo@avery-design.com.tw>, Dave Jiang <dave.jiang@intel.com>, Peter
 Maydell <peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/12] hw/cxl/device: read from register values in
 mdev_reg_read()
Date: Wed, 24 Jan 2024 12:40:54 +0000
Message-ID: <20240124124100.8218-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

In the current mdev_reg_read() implementation, it consistently returns
that the Media Status is Ready (01b). This was fine until commit
25a52959f99d ("hw/cxl: Add support for device sanitation") because the
media was presumed to be ready.

However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
during sanitation, the Media State should be set to Disabled (11b). The
mentioned commit correctly sets it to Disabled, but mdev_reg_read()
still returns Media Status as Ready.

To address this, update mdev_reg_read() to read register values instead
of returning dummy values.

Note that __toggle_media() managed to not only write something
that no one read, it did it to the wrong register storage and
so changed the reported mailbox size which was definitely not
the intent. That gets fixed as a side effect of allocating
separate state storage for this register.

Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Patch description expanded to cover the overwrite bug fixed almost
by accident in this patch.
---
 include/hw/cxl/cxl_device.h |  9 +++++++--
 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index befb5f884b..31d2afcd3d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -202,6 +202,9 @@ typedef struct cxl_device_state {
         };
     };
 
+    /* Stash the memory device status value */
+    uint64_t memdev_status;
+
     struct {
         bool set;
         uint64_t last_set;
@@ -353,8 +356,10 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
     uint64_t dev_status_reg;
 
-    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
-    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
+    dev_status_reg = cxl_dstate->memdev_status;
+    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
+                                val);
+    cxl_dstate->memdev_status = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
         do { __toggle_media((cxlds), 0x3); } while (0)
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 61a3c4dc2e..40b619ffd9 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval = 0;
-
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+    CXLDeviceState *cxl_dstate = opaque;
 
-    return retval;
+    return cxl_dstate->memdev_status;
 }
 
 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n = msi_n;
 }
 
-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
+                                   MBOX_READY, 1);
+    cxl_dstate->memdev_status = memdev_status_reg;
+}
 
 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
-- 
2.39.2


