Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88352E6B27C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6rZz-0006mK-Dt; Fri, 01 Nov 2024 09:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t6rZx-0006m1-26
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:20:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t6rZv-0006GZ-KL
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:20:40 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg1dB4k3nz6K6Vb;
 Fri,  1 Nov 2024 21:18:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2CA3C1400D3;
 Fri,  1 Nov 2024 21:20:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:20:37 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 1/2] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Date: Fri, 1 Nov 2024 13:20:04 +0000
Message-ID: <20241101132005.26633-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101132005.26633-1-Jonathan.Cameron@huawei.com>
References: <20241101132005.26633-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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

From: Fan Ni <fan.ni@samsung.com>

In the function cmd_firmware_update_get_info for handling Get FW info
command (0x0200h), the vmem, pmem and DC capacity size check were
incorrect. The size should be aligned to 256MiB, not smaller than
256MiB.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5f63099724..8bb0d2dd29 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
+    if (!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER) ||
+        !QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER) ||
+        !QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-- 
2.43.0


