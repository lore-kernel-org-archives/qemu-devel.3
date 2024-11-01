Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13484E6B27C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6rv7-000667-VO; Fri, 01 Nov 2024 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t6rv1-0005q8-Il
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:42:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t6rv0-0001K5-45
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:42:27 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg26K0qkxz6K6jx;
 Fri,  1 Nov 2024 21:39:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A67E1140C72;
 Fri,  1 Nov 2024 21:42:24 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:42:24 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
 Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 06/10] hw/cxl: Avoid accesses beyond the end of cel_log.
Date: Fri, 1 Nov 2024 13:39:13 +0000
Message-ID: <20241101133917.27634-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add a check that the requested offset + length does not go beyond the end
of the cel_log.

Whilst the cci->cel_log is large enough to include all possible CEL
entries, the guest might still ask for entries beyond the end of it.
Move the comment to this new check rather than before the check on the
type of log requested.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2aa7ffed84..5e571955b6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -937,24 +937,28 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
 
     get_log = (void *)payload_in;
 
+    if (get_log->length > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
     /*
      * CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h)
      *   The device shall return Invalid Input if the Offset or Length
      *   fields attempt to access beyond the size of the log as reported by Get
-     *   Supported Logs.
+     *   Supported Log.
      *
-     * The CEL buffer is large enough to fit all commands in the emulation, so
-     * the only possible failure would be if the mailbox itself isn't big
-     * enough.
+     * Only valid for there to be one entry per opcode, but the length + offset
+     * may still be greater than that if the inputs are not valid and so access
+     * beyond the end of cci->cel_log.
      */
-    if (get_log->length > cci->payload_max) {
+    if ((uint64_t)get_log->offset + get_log->length >= sizeof(cci->cel_log)) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
-        return CXL_MBOX_INVALID_LOG;
-    }
-
     /* Store off everything to local variables so we can wipe out the payload */
     *len_out = get_log->length;
 
-- 
2.43.0


