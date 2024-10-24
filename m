Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1262DD0BB5E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 05:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3qSh-0003cZ-5w; Thu, 24 Oct 2024 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSN-0003aT-HP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSL-0004Ir-3n
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729747938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+souKmcZN+Lo+w+ANXk5mddlUb65rie89cG9hWlfyN4=;
 b=M9S8vp3F2Jn0V2lDJvYSa0iMDi4hoQmxDTp/t4D3HSIxc0QyDKMzL9cBllX76FBZTlPao7
 iLLKKfC0MzJdWztbY5MTTVVPNNNV71D0XMaU/O0V6JeGgQm29p/vWoaPF8TAiLj3alcIyT
 ZHnOtV8s8KkC7yUYefgYTJjPNEwCY6Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-K2jo41xvP7CTikE85_7kNg-1; Thu,
 24 Oct 2024 01:32:16 -0400
X-MC-Unique: K2jo41xvP7CTikE85_7kNg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D53819560A2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:32:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38A0F1956056; Thu, 24 Oct 2024 05:32:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/4] vfio/helpers: Align mmaps
Date: Thu, 24 Oct 2024 07:32:03 +0200
Message-ID: <20241024053203.1559456-5-clg@redhat.com>
In-Reply-To: <20241024053203.1559456-1-clg@redhat.com>
References: <20241024053203.1559456-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alex Williamson <alex.williamson@redhat.com>

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
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b9e606e364a2dd267bacd63094cdedae5dd7d8b2..913796f437f84eece8711cb4b4b654a44040d17c 100644
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
2.47.0


