Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E49C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 19:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubOWH-0000WX-DM; Mon, 14 Jul 2025 15:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubNHo-00023Z-Qc
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:48:21 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubNHm-0007sh-UA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:48:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqWq3vddz6M4K7;
 Tue, 15 Jul 2025 01:47:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4E6C11402ED;
 Tue, 15 Jul 2025 01:48:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:48:15 +0200
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
 <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 06/11] hw/mem: cxl_type3: Add DC Region bitmap lock
Date: Mon, 14 Jul 2025 18:45:02 +0100
Message-ID: <20250714174509.1984430-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
References: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Add a lock on the bitmap of each CXLDCRegion in preparation for the next
patch which implements FMAPI Set DC Region Configuration. This command
can modify the block size, which means the region's bitmap must be updated
accordingly.

The lock becomes necessary when commands that add/release extents
(meaning they update the bitmap too) are enabled on a different CCI than
the CCI on which the FMAPI commands are enabled.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 1 +
 hw/mem/cxl_type3.c          | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7e0a66906f..42ae5b7479 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -540,6 +540,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52d3910ed9..a7a1857a0c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -692,6 +692,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        qemu_mutex_init(&region->bitmap_lock);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -1020,6 +1021,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
         return;
     }
 
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
                len / region->block_size);
 }
@@ -1046,6 +1048,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
      * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
      * backed with DC extents, return true; else return false.
      */
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
 }
 
@@ -1067,6 +1070,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
     nr = (dpa - region->base) / region->block_size;
     nbits = len / region->block_size;
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_clear(region->blk_bitmap, nr, nbits);
 }
 
-- 
2.48.1


