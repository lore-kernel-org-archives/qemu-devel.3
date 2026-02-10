Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521E3EA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmhv-0007Ai-C2; Tue, 10 Feb 2026 07:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmhE-0005jr-LU; Tue, 10 Feb 2026 07:18:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmhC-0001HS-JA; Tue, 10 Feb 2026 07:18:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 849CF187DC4;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 216C7360CE9;
 Tue, 10 Feb 2026 15:15:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 92/95] hw/cxl: Check for overflow on santize media as
 both base and offset 64bit.
Date: Tue, 10 Feb 2026 15:15:14 +0300
Message-ID: <20260210121526.68598-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260210151454@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260210151454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The both the size and base of a media sanitize operation are both provided
by the VM, an overflow is possible which may result in checks on valid
range passing when they should not.  Close that by checking for overflow
on the addition.

Fixes: 40ab4ed10775 ("hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros commands CXL r3.2(8.2.10.9.5.3)")
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA8Rqop+ju0fuxN+0T57NBG+bep80z45f6pY0ci2fz_G3A@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260102154731.474859-2-Jonathan.Cameron@huawei.com>
(cherry picked from commit 87f8e5a71d061964c9bfa4d6e02db47f54dd61f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 68c7cc9891..03fbc9a9d1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1875,7 +1875,7 @@ static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
 static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
                              size_t length)
 {
-    uint64_t vmr_size, pmr_size, dc_size;
+    uint64_t vmr_size, pmr_size, dc_size, dpa_end;
 
     if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
         (length % CXL_CACHE_LINE_SIZE)  ||
@@ -1887,7 +1887,12 @@ static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
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
2.47.3


