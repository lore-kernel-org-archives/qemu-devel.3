Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575F2FA3752
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 15:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbhNs-00087d-4b; Fri, 02 Jan 2026 10:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vbhNp-00085Q-AK
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:48:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vbhNn-0002bO-IR
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:48:08 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djSk42V24zJ467w;
 Fri,  2 Jan 2026 23:47:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 0750940569;
 Fri,  2 Jan 2026 23:48:04 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:48:03 +0000
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Vinayak
 Holikatti <vinayak.kh@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
 <venkataravis@micron.com>
Subject: [PATCH qemu 1/2] hw/cxl: Check for overflow on santize media as both
 base and offset 64bit.
Date: Fri, 2 Jan 2026 15:47:30 +0000
Message-ID: <20260102154731.474859-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
References: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)
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

The both the size and base of a media sanitize operation are both provided
by the VM, an overflow is possible which may result in checks on valid
range passing when they should not.  Close that by checking for overflow
on the addition.

Fixes: 40ab4ed10775 ("hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros commands CXL r3.2(8.2.10.9.5.3)")
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA8Rqop+ju0fuxN+0T57NBG+bep80z45f6pY0ci2fz_G3A@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a64b8ba5351f..d8f62a13a8ec 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2411,7 +2411,7 @@ static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
 static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
                              size_t length)
 {
-    uint64_t vmr_size, pmr_size, dc_size;
+    uint64_t vmr_size, pmr_size, dc_size, dpa_end;
 
     if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
         (length % CXL_CACHE_LINE_SIZE)  ||
@@ -2423,7 +2423,12 @@ static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
     pmr_size = get_pmr_size(ct3d, NULL);
     dc_size = get_dc_size(ct3d, NULL);
 
-    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {
+    /* sanitize 64 bit values coming from guest */
+    if (uadd64_overflow(dpa_addr, length, &dpa_end)) {
+        return -EINVAL;
+    }
+
+    if (dpa_end > vmr_size + pmr_size + dc_size) {
         return -EINVAL;
     }
 
-- 
2.48.1


