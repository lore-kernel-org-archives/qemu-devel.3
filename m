Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE86FC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpl2G-0001gc-7L; Wed, 05 Mar 2025 04:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl1y-0001aK-HN
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:27:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl1w-0001J1-9h
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:27:10 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Zq3z6kz6K9Sf;
 Wed,  5 Mar 2025 17:24:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7DC9E140A08;
 Wed,  5 Mar 2025 17:27:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:27:05 +0100
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
 Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
 <vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
 <ajay.opensrc@micron.com>
Subject: [PATCH qemu 4/8] hw/cxl: factor out calculation of sanitize duration
 from cmd_santize_overwrite
Date: Wed, 5 Mar 2025 09:24:55 +0000
Message-ID: <20250305092501.191929-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

From: Vinayak Holikatti <vinayak.kh@samsung.com>

Move the code of calculation of sanitize duration into function
for usability by other sanitize routines

Estimate times based on:
             https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 61 ++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 79b35d1405..9f9d475678 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1640,34 +1640,10 @@ static void __do_sanitization(CXLType3Dev *ct3d)
     cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
-/*
- * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
- *
- * Once the Sanitize command has started successfully, the device shall be
- * placed in the media disabled state. If the command fails or is interrupted
- * by a reset or power failure, it shall remain in the media disabled state
- * until a successful Sanitize command has been completed. During this state:
- *
- * 1. Memory writes to the device will have no effect, and all memory reads
- * will return random values (no user data returned, even for locations that
- * the failed Sanitize operation didn’t sanitize yet).
- *
- * 2. Mailbox commands shall still be processed in the disabled state, except
- * that commands that access Sanitized areas shall fail with the Media Disabled
- * error code.
- */
-static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
-                                         uint8_t *payload_in,
-                                         size_t len_in,
-                                         uint8_t *payload_out,
-                                         size_t *len_out,
-                                         CXLCCI *cci)
+static int get_sanitize_duration(uint64_t total_mem)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-    uint64_t total_mem; /* in Mb */
-    int secs;
+    int secs = 0;
 
-    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
     if (total_mem <= 512) {
         secs = 4;
     } else if (total_mem <= 1024) {
@@ -1696,6 +1672,39 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
         secs = 240 * 60; /* max 4 hrs */
     }
 
+    return secs;
+}
+
+/*
+ * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
+    secs = get_sanitize_duration(total_mem);
+
     /* EBUSY other bg cmds as of now */
     cci->bg.runtime = secs * 1000UL;
     *len_out = 0;
-- 
2.43.0


