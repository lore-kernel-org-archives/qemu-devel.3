Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D96606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TyhB6w1L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN36U-0000or-BQ; Sat, 31 Oct 2026 03:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36N-0000kC-Ov
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36L-0003LD-9F
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793430124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmeH2URBMvT4KV7ecm5Jkl5McJb9uzkwB0YMd+Tkx1g=;
 b=TyhB6w1LH51ubplJztF/ckG9PcggkbIkfT5rBjSbAizhHbf0tg68gPzvwhyU5URdrPJBZg
 DOVfDInJa5D2FcXN2boFg1KD/QPDH0fo3szQbjXdDsmxr94KsRyMsJcpI+bXXiuQU0/04A
 vlYygspNck9kRSBVHyrnFCiR5ZoCzpc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-6WUza2bJOayqk4wfP3LK5Q-1; Sat,
 31 Oct 2026 03:02:02 -0400
X-MC-Unique: 6WUza2bJOayqk4wfP3LK5Q-1
X-Mimecast-MFC-AGG-ID: 6WUza2bJOayqk4wfP3LK5Q_1793430121
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DDA1956079; Sat, 31 Oct 2026 07:02:00 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4441F1800495; Sat, 31 Oct 2026 07:01:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Naman Gulati <namangulati@google.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 2/6] vfio: add 'fd' and 'fd_offset' to VFIOMmap
Date: Sat, 31 Oct 2026 08:01:48 +0100
Message-ID: <20261031070152.197043-3-clg@redhat.com>
In-Reply-To: <20261031070152.197043-1-clg@redhat.com>
References: <20261031070152.197043-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Naman Gulati <namangulati@google.com>

Allow each sparse mmap subregion to specify its own file descriptor and
file offset for the mmap call.

Add 'fd' (set to -1 when the region fd should be used) and 'fd_offset'
to VFIOMmap, and update vfio_region_mmap() to use them.

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Naman Gulati <namangulati@google.com>
Link: https://lore.kernel.org/qemu-devel/20261023223902.1275539-3-namangulati@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-region.h |  4 +++-
 hw/vfio/pci.c         |  2 ++
 hw/vfio/region.c      | 26 +++++++++++++++++++-------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 58b236f1133e7e7f6c99b440d9125e96e6529085..9f6a5cf7d57e7747b3cbfa2c3132357cc3f8de95 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -14,8 +14,10 @@
 typedef struct VFIOMmap {
     MemoryRegion mem;
     void *mmap;
-    off_t offset;
+    off_t offset;       /* offset within the region */
     size_t size;
+    int fd;             /* per-mmap fd, or -1 to use the region fd */
+    uint64_t fd_offset; /* offset within fd for the mmap call */
 } VFIOMmap;
 
 typedef struct VFIODevice VFIODevice;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ad13f2306f12bc960231a01ea1458ed34753ac1e..0da2e143b88a37b4be2dca17622d87b7486cf924 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1626,6 +1626,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
                                   vdev->msix->table_bar, 0, 0);
         } else {
             region->mmaps[0].offset = end;
+            region->mmaps[0].fd_offset += end;
             region->mmaps[0].size = region->size - end;
             trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[0].offset,
@@ -1652,6 +1653,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
                               region->mmaps[0].offset + region->mmaps[0].size);
 
         region->mmaps[1].offset = end;
+        region->mmaps[1].fd_offset += end;
         region->mmaps[1].size = region->size - end;
         trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[1].offset,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 54ad11a6c8ed8e04fa365262ccb8bd694bdb45f7..16efed2fce6141185e86bb636b3393209ace071a 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -189,6 +189,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                             sparse->areas[i].size - 1);
             region->mmaps[j].offset = sparse->areas[i].offset;
             region->mmaps[j].size = sparse->areas[i].size;
+            region->mmaps[j].fd = -1;
+            region->mmaps[j].fd_offset = region->fd_offset +
+                                         sparse->areas[i].offset;
             j++;
         }
     }
@@ -262,6 +265,8 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                 region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
                 region->mmaps[0].offset = 0;
                 region->mmaps[0].size = region->size;
+                region->mmaps[0].fd = -1;
+                region->mmaps[0].fd_offset = region->fd_offset;
             } else if (ret) {
                 return ret;
             }
@@ -354,7 +359,6 @@ int vfio_region_mmap(VFIORegion *region)
     off_t map_offset = 0;
     size_t align;
     char *name;
-    int fd;
 
     if (!region->mem || !region->nr_mmaps) {
         return 0;
@@ -391,8 +395,6 @@ int vfio_region_mmap(VFIORegion *region)
         return ret;
     }
 
-    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
-
     map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
     munmap(map_base, map_align - map_base);
     munmap(map_align + region->size,
@@ -404,12 +406,22 @@ int vfio_region_mmap(VFIORegion *region)
      * offsets being in ascending order.
      */
     for (i = 0; i < region->nr_mmaps; i++) {
+        int fd = region->mmaps[i].fd;
+
+        if (fd < 0) {
+            fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
+        }
+        if (fd < 0) {
+            ret = -EINVAL;
+            munmap(map_align + map_offset, region->size - map_offset);
+            goto no_mmap;
+        }
+
         munmap(map_align + map_offset, region->mmaps[i].offset - map_offset);
         region->mmaps[i].mmap = mmap(map_align + region->mmaps[i].offset,
                                      region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED, fd,
-                                     region->fd_offset +
-                                     region->mmaps[i].offset);
+                                     region->mmaps[i].fd_offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
             ret = -errno;
             /*
@@ -454,8 +466,8 @@ int vfio_region_mmap(VFIORegion *region)
 
 no_mmap:
     trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
-                                 region->fd_offset + region->mmaps[i].offset,
-                                 region->fd_offset + region->mmaps[i].offset +
+                                 region->mmaps[i].fd_offset,
+                                 region->mmaps[i].fd_offset +
                                  region->mmaps[i].size - 1, ret);
 
     region->mmaps[i].mmap = NULL;
-- 
2.56.0


