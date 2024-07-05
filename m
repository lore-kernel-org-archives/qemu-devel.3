Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC58C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhjE-0007Se-PU; Fri, 05 Jul 2024 08:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhjD-0007Rm-OI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:07:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhjB-0003lx-OZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:07:51 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFsh65v07z6HJcl;
 Fri,  5 Jul 2024 20:07:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 4CC9D140C98;
 Fri,  5 Jul 2024 20:07:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:07:44 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 2/4] hw/cxl/mbox: replace sanitize_running() with
 cxl_dev_media_disabled()
Date: Fri, 5 Jul 2024 13:06:41 +0100
Message-ID: <20240705120643.959422-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
References: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

The spec states that reads/writes should have no effect and a part of
commands should be ignored when the media is disabled, not when the
sanitize command is running.

Introduce cxl_dev_media_disabled() to check if the media is disabled and
replace sanitize_running() with it.

Make sure that the media has been correctly disabled during sanitation
by adding an assert to __toggle_media(). Now, enabling when already
enabled or vice versa results in an assert() failure.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/r/20231222090051.3265307-4-42.hyeyoo@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Fix added to ensure the state sanity check only applies on type3 devices
---
 include/hw/cxl/cxl_device.h | 10 +++++-----
 hw/cxl/cxl-mailbox-utils.c  | 29 +++++++++++++++++------------
 hw/mem/cxl_type3.c          |  4 ++--
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b5beb7f90e..42a622197e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -397,14 +397,14 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
-static inline bool scan_media_running(CXLCCI *cci)
+static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
+    uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
 }
-
-static inline bool sanitize_running(CXLCCI *cci)
+static inline bool scan_media_running(CXLCCI *cci)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
 }
 
 typedef struct CXLError {
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6a60f81794..adeb71071c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2115,6 +2115,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     int ret;
     const struct cxl_cmd *cxl_cmd;
     opcode_handler h;
+    CXLDeviceState *cxl_dstate;
 
     *len_out = 0;
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
@@ -2135,18 +2136,22 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_BUSY;
     }
 
-    /* forbid any selected commands while overwriting */
-    if (sanitize_running(cci)) {
-        if (h == cmd_events_get_records ||
-            h == cmd_ccls_get_partition_info ||
-            h == cmd_ccls_set_lsa ||
-            h == cmd_ccls_get_lsa ||
-            h == cmd_logs_get_log ||
-            h == cmd_media_get_poison_list ||
-            h == cmd_media_inject_poison ||
-            h == cmd_media_clear_poison ||
-            h == cmd_sanitize_overwrite) {
-            return CXL_MBOX_MEDIA_DISABLED;
+    /* forbid any selected commands while the media is disabled */
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+
+        if (cxl_dev_media_disabled(cxl_dstate)) {
+            if (h == cmd_events_get_records ||
+                h == cmd_ccls_get_partition_info ||
+                h == cmd_ccls_set_lsa ||
+                h == cmd_ccls_get_lsa ||
+                h == cmd_logs_get_log ||
+                h == cmd_media_get_poison_list ||
+                h == cmd_media_inject_poison ||
+                h == cmd_media_clear_poison ||
+                h == cmd_sanitize_overwrite) {
+                return CXL_MBOX_MEDIA_DISABLED;
+            }
         }
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 62956a0403..925c88ac5d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1127,7 +1127,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -1149,7 +1149,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         return MEMTX_OK;
     }
 
-- 
2.43.0


