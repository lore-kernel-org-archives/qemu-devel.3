Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAC9C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpl1l-0001Qf-8s; Wed, 05 Mar 2025 04:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl1X-0001Ee-H1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:26:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl1S-0001HQ-9L
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:26:43 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76YQ3km6z6M4n6;
 Wed,  5 Mar 2025 17:23:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 6DF7E140A34;
 Wed,  5 Mar 2025 17:26:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:26:34 +0100
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
 Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
 <vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
 <ajay.opensrc@micron.com>
Subject: [PATCH qemu 3/8] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands cxl r3.2 (8.2.10.9.5.3)
Date: Wed, 5 Mar 2025 09:24:54 +0000
Message-ID: <20250305092501.191929-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
CXL devices supports media operations discovery command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 125 +++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bd25df033a..79b35d1405 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -89,6 +89,7 @@ enum {
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
+        #define MEDIA_OPERATIONS 0x2
     PERSISTENT_MEM = 0x45,
         #define GET_SECURITY_STATE     0x0
     MEDIA_AND_POISON = 0x43,
@@ -1705,6 +1706,126 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+enum {
+    MEDIA_OP_CLASS_GENERAL  = 0x0,
+        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
+    MEDIA_OP_CLASS_SANITIZE = 0x1,
+        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
+        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
+};
+
+struct media_op_supported_list_entry {
+    uint8_t media_op_class;
+    uint8_t media_op_subclass;
+};
+
+struct media_op_discovery_out_pl {
+    uint64_t dpa_range_granularity;
+    uint16_t total_supported_operations;
+    uint16_t num_of_supported_operations;
+    struct media_op_supported_list_entry entry[];
+} QEMU_PACKED;
+
+static const struct media_op_supported_list_entry media_op_matrix[] = {
+    { MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
+};
+
+static CXLRetCode media_operations_discovery(uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+        struct {
+            uint16_t start_index;
+            uint16_t num_ops;
+        } discovery_osa;
+    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
+    struct media_op_discovery_out_pl *media_out_pl =
+        (struct media_op_discovery_out_pl *)payload_out;
+    int num_ops, start_index, i;
+    int count = 0;
+
+    if (len_in < sizeof(*media_op_in_disc_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
+    start_index = media_op_in_disc_pl->discovery_osa.start_index;
+
+    /*
+     * As per spec CXL r3.2 8.2.10.9.5.3 dpa_range_count should be zero and
+     * start index should not exceed the total number of entries for discovery
+     * sub class command.
+     */
+    if (media_op_in_disc_pl->dpa_range_count ||
+        start_index > ARRAY_SIZE(media_op_matrix)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
+    media_out_pl->total_supported_operations =
+                                     ARRAY_SIZE(media_op_matrix);
+    if (num_ops > 0) {
+        for (i = start_index; i < start_index + num_ops; i++) {
+            media_out_pl->entry[count].media_op_class =
+                    media_op_matrix[i].media_op_class;
+            media_out_pl->entry[count].media_op_subclass =
+                        media_op_matrix[i].media_op_subclass;
+            count++;
+            if (count == num_ops) {
+                break;
+            }
+        }
+    }
+
+    media_out_pl->num_of_supported_operations = count;
+    *len_out = sizeof(*media_out_pl) + count * sizeof(*media_out_pl->entry);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+    uint8_t media_op_cl = 0;
+    uint8_t media_op_subclass = 0;
+
+    if (len_in < sizeof(*media_op_in_common_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    media_op_cl = media_op_in_common_pl->media_operation_class;
+    media_op_subclass = media_op_in_common_pl->media_operation_subclass;
+
+    switch (media_op_cl) {
+    case MEDIA_OP_CLASS_GENERAL:
+        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        return media_operations_discovery(payload_in, len_in, payload_out,
+                                             len_out);
+    default:
+        return CXL_MBOX_UNSUPPORTED;
+    }
+}
+
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -2850,6 +2971,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
          CXL_MBOX_SECURITY_STATE_CHANGE |
          CXL_MBOX_BACKGROUND_OPERATION |
          CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
+    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
+        ~0,
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
-- 
2.43.0


