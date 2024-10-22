Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C149CDD0E1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LBR-0006OA-Tl; Tue, 22 Oct 2024 16:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3LBQ-0006Nk-3s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3LBN-00052r-D9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729627724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjXUWWxqKefABmnRtvtp/C21y4hhrcofJb4rJ5cy4bg=;
 b=FJ7/Kab7NFRVU8nE0aFOupUwzHmxjMvS8jWIJj60U7VciGTovrTysHKiPTibvqXaKpmkj1
 uXOfArYUXTRIhnNxO+JHv4j8Ry1ltvecqKPpmoZpJCmYRvxMw1s8jCZ2qhcvNZBns+aLUK
 LI8QNbFCSeR7a4B+4vUWEgFuUJkPmBQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-vzIJvMtlM7avtbXA9B6iyg-1; Tue,
 22 Oct 2024 16:08:39 -0400
X-MC-Unique: vzIJvMtlM7avtbXA9B6iyg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C3FF1955F54
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:08:38 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.64.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3ECBC19560A2; Tue, 22 Oct 2024 20:08:36 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, clg@redhat.com,
 peterx@redhat.com
Subject: [PATCH 2/2] vfio/helpers: Align mmaps
Date: Tue, 22 Oct 2024 14:08:29 -0600
Message-ID: <20241022200830.4129598-3-alex.williamson@redhat.com>
In-Reply-To: <20241022200830.4129598-1-alex.williamson@redhat.com>
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thanks to work by Peter Xu, support is introduced in Linux v6.12 to
allow pfnmap insertions at PMD and PUD levels of the page table.  This
means that provided a properly aligned mmap, the vfio driver is able
to map MMIO at significantly larger intervals than PAGE_SIZE.  For
example on x86_64 (the only architecture currently supporting huge
pfnmaps for PUD), rather than 4KiB mappings, we can map device MMIO
using 2MiB and even 1GiB page table entries.

Typically mmap will already provide PMD aligned mappings, so devices
with moderately sized MMIO ranges, even GPUs with standard 256MiB BARs,
will already take advantage of this support.  However in order to better
support devices exposing multi-GiB MMIO, such as 3D accelerators or GPUs
with resizable BARs enabled, we need to manually align the mmap.

There doesn't seem to be a way for userspace to easily learn about PMD
and PUD mapping level sizes, therefore this takes the simple approach
to align the mapping to the power-of-two size of the region, up to 1GiB,
which is currently the maximum alignment we care about.

Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/helpers.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b9e606e364a2..913796f437f8 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -27,6 +27,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "monitor/monitor.h"
 
 /*
@@ -406,8 +407,35 @@ int vfio_region_mmap(VFIORegion *region)
     prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
 
     for (i = 0; i < region->nr_mmaps; i++) {
-        region->mmaps[i].mmap = mmap(NULL, region->mmaps[i].size, prot,
-                                     MAP_SHARED, region->vbasedev->fd,
+        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
+        void *map_base, *map_align;
+
+        /*
+         * Align the mmap for more efficient mapping in the kernel.  Ideally
+         * we'd know the PMD and PUD mapping sizes to use as discrete alignment
+         * intervals, but we don't.  As of Linux v6.12, the largest PUD size
+         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
+         * on x86_64).  Align by power-of-two size, capped at 1GiB.
+         *
+         * NB. qemu_memalign() and friends actually allocate memory, whereas
+         * the region size here can exceed host memory, therefore we manually
+         * create an oversized anonymous mapping and clean it up for alignment.
+         */
+        map_base = mmap(0, region->mmaps[i].size + align, PROT_NONE,
+                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        if (map_base == MAP_FAILED) {
+            ret = -errno;
+            goto no_mmap;
+        }
+
+        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
+        munmap(map_base, map_align - map_base);
+        munmap(map_align + region->mmaps[i].size,
+               align - (map_align - map_base));
+
+        region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
+                                     MAP_SHARED | MAP_FIXED,
+                                     region->vbasedev->fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
-- 
2.46.2


