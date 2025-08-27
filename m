Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4964CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHkM-0007zB-5K; Wed, 27 Aug 2025 11:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHiD-00057e-6N; Wed, 27 Aug 2025 11:05:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHiB-0005DY-57; Wed, 27 Aug 2025 11:05:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F5B314C540;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F2BF7269848;
 Wed, 27 Aug 2025 18:03:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 24/59] intel_iommu: Allow both Status Write and
 Interrupt Flag in QI wait
Date: Wed, 27 Aug 2025 18:02:29 +0300
Message-ID: <20250827150323.2694101-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

FreeBSD does both, and this appears to be perfectly valid. The VT-d
spec even talks about the ordering (the status write should be done
first, unsurprisingly).

We certainly shouldn't assert() and abort QEMU if the guest asks for
both.

Fixes: ed7b8fbcfb88 ("intel-iommu: add supports for queued invalidation interface")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3028
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit e8145dcd311b58921f3a45121792cbfab38fd2f6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dffd7ee885..a117a0b6b1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2830,6 +2830,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
     uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
                         VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+    bool ret = true;
 
     if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
                                      __func__, "wait")) {
@@ -2841,8 +2842,6 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         uint32_t status_data = (uint32_t)(inv_desc->lo >>
                                VTD_INV_DESC_WAIT_DATA_SHIFT);
 
-        assert(!(inv_desc->lo & VTD_INV_DESC_WAIT_IF));
-
         /* FIXME: need to be masked with HAW? */
         dma_addr_t status_addr = inv_desc->hi;
         trace_vtd_inv_desc_wait_sw(status_addr, status_data);
@@ -2851,18 +2850,22 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
                              &status_data, sizeof(status_data),
                              MEMTXATTRS_UNSPECIFIED)) {
             trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc->lo);
-            return false;
+            ret = false;
         }
-    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
+    }
+
+    if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
         /* Interrupt flag */
         vtd_generate_completion_event(s);
-    } else {
+    }
+
+    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW))) {
         error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc->hi,
                           inv_desc->lo);
         return false;
     }
-    return true;
+    return ret;
 }
 
 static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
-- 
2.47.2


