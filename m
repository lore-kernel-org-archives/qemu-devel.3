Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E74C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ley-0000N1-CK; Wed, 16 Sep 2026 05:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6leM-0008FG-4h; Wed, 16 Sep 2026 05:09:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6leK-0007Yi-5K; Wed, 16 Sep 2026 05:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=PG3TvUVR4tubUTpD72iZ53uuSa8dyY4xQJy+FDxdsWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PIxhUqDOFF0/ox1C0vVAJ1IycARmxLRYiqD1tNFPkubrD5UzOYpHFQULksEA9ENlA
 TmpStbyPQhrmgjZ59CdD0IzSY0Yp9epE8vMEee/AgXJH2O5+Mfl8lTOUJZ1gAMzR7w
 CH4TAZ9gGOYyssiKRdZrIUO9CmVNmQtcEVBbzQ0Gey90mj4k5H2osqjBsNG03hj5TT
 OW6VtYEEMQ7+QZd4YnAMuyABqTuKqgk/Zz77f/0UnhJivIubqtzYHMxozfeDhkpabm
 c1DqwQ2KXKzfPA8C4pPIWESiBP1jUQeofmfLzyZy3tixgyCWcAPanA0uCVTl6VMm8K
 42D7XTFjsY1/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 412851D56E3;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E10F1429E3F;
 Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D2F0C5A7B5; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jia Jia <physicalmtea@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 46/57] hw/virtio: reject inverted virtio-iommu IOVA
 ranges
Date: Wed, 16 Sep 2026 12:04:10 +0300
Message-ID: <20260916090516.677749-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jia Jia <physicalmtea@gmail.com>

Guest MAP and UNMAP requests can set virt_end below virt_start. Since
virt_end is inclusive, this is not a valid interval. MAP nevertheless
stores it in domain->mappings, but interval_cmp() assumes low <= high.
For an inverted key, interval_cmp(key, key) returns -1. A covering UNMAP
can therefore find the key but fail to remove it and repeat forever while
holding s->mutex.

Reject inverted request ranges with VIRTIO_IOMMU_S_INVAL and make the
notifier range decomposition skip invalid ranges. Keep the existing
notifier-before-remove ordering, but return VIRTIO_IOMMU_S_DEVERR if
g_tree_remove() fails.

Fixes: fe2cacae2438 ("virtio-iommu: Implement map/unmap")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729131953.1720567-1-physicalmtea@gmail.com>
(cherry picked from commit 15dcee9195550ffcce90594554a22fd4b63c0d7e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index f70d942ff7b..edf35726a74 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -213,6 +213,10 @@ static void virtio_iommu_notify_map_unmap(IOMMUMemoryRegion *mr,
 {
     uint64_t delta = virt_end - virt_start;
 
+    if (virt_end < virt_start) {
+        return;
+    }
+
     event->entry.iova = virt_start;
     event->entry.addr_mask = delta;
 
@@ -808,6 +812,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
         return VIRTIO_IOMMU_S_INVAL;
     }
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -858,6 +866,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
 
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -880,7 +892,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
                 virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
                                           current_high);
             }
-            g_tree_remove(domain->mappings, iter_key);
+            if (!g_tree_remove(domain->mappings, iter_key)) {
+                ret = VIRTIO_IOMMU_S_DEVERR;
+                break;
+            }
             trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
         } else {
             ret = VIRTIO_IOMMU_S_RANGE;
-- 
2.47.3


