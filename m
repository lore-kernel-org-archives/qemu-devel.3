Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D2606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6CUYq8H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN36x-0000x7-QY; Sat, 31 Oct 2026 03:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36R-0000s0-1X
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36O-0003LN-WA
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793430128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsz+F9N/wLIAOwnVBNqK4k0oivFXLvrTgUdLZvv8jrM=;
 b=i6CUYq8HB/epqitTfq8YqoYTI3lv1z1XCOE6CvHBGlWxpQLdRiaF69YR8Q70esUGoidIlA
 VOQjMg6zQvr/GNkkWYFhehkCVEt1CkVwThnB0fEKkvICvHLI76JnbEn8MupIAaA6RM5zET
 Bq7qfcPMBe5rF0pfoPjbsk4nl2CSLgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-9kbX3xacPlmi8Xdz2amlhQ-1; Sat,
 31 Oct 2026 03:02:04 -0400
X-MC-Unique: 9kbX3xacPlmi8Xdz2amlhQ-1
X-Mimecast-MFC-AGG-ID: 9kbX3xacPlmi8Xdz2amlhQ_1793430123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09CC119560B7; Sat, 31 Oct 2026 07:02:03 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61E941803A40; Sat, 31 Oct 2026 07:02:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Naman Gulati <namangulati@google.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 3/6] vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
Date: Sat, 31 Oct 2026 08:01:49 +0100
Message-ID: <20261031070152.197043-4-clg@redhat.com>
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

Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
backends (such as vfio-user) can parse custom sparse mmap capabilities,
falling back to vfio_region_setup_sparse_mmaps() to process shared
VFIO mmap capabilities.

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Naman Gulati <namangulati@google.com>
Link: https://lore.kernel.org/qemu-devel/20261023223902.1275539-4-namangulati@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-region.h         |  5 +++++
 include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
 hw/vfio/device.c              |  1 +
 hw/vfio/region.c              | 19 ++++++++++++++++---
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 9f6a5cf7d57e7747b3cbfa2c3132357cc3f8de95..abcfbacfff1b5d9d5337f9a8c8de303a5e2d141c 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -46,4 +46,9 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 
+struct vfio_region_info;
+int vfio_region_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp);
+
 #endif /* HW_VFIO_REGION_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8472420d3fac6c56e522a8dd253b6ab6b5ce58ea..3136e152f2ce5e0e736812ff6558c4f5060baa26 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -43,6 +43,7 @@ enum {
 
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIOOps VFIODeviceIOOps;
+typedef struct VFIORegion VFIORegion;
 typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
@@ -218,6 +219,21 @@ struct VFIODeviceIOOps {
     int (*get_region_info)(VFIODevice *vdev,
                            struct vfio_region_info *info, int *fd);
 
+    /**
+     * @setup_sparse_mmaps
+     *
+     * Parse sparse mmap capabilities for a region and initialize region->mmaps.
+     *
+     * @region: #VFIORegion to set up
+     * @info: region info struct containing capabilities
+     * @errp: pointer to Error*, to store an error if it happens
+     *
+     * Returns 0 on success, -ENODEV if not sparse, or negative error code.
+     */
+    int (*setup_sparse_mmaps)(VFIORegion *region,
+                              struct vfio_region_info *info,
+                              Error **errp);
+
     /**
      * @get_irq_info
      *
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4f119596336fdfd3c54741e23f200ad55ad800e7..339c7242ed614b2bb11818f62868f130853b320b 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -662,6 +662,7 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
 
     .device_feature = vfio_device_io_device_feature,
     .get_region_info = vfio_device_io_get_region_info,
+    .setup_sparse_mmaps = vfio_region_setup_sparse_mmaps,
     .get_irq_info = vfio_device_io_get_irq_info,
     .set_irqs = vfio_device_io_set_irqs,
     .region_read = vfio_device_io_region_read,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 16efed2fce6141185e86bb636b3393209ace071a..8de26f3d9b592a4b34578310c76975af8185ddca 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a, const void *b)
     return 0;
 }
 
-static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info,
-                                          Error **errp)
+int vfio_region_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_region_info_cap_sparse_mmap *sparse;
@@ -198,6 +198,19 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 
     region->nr_mmaps = j;
     region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+    return 0;
+}
+
+static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
+                                          struct vfio_region_info *info,
+                                          Error **errp)
+{
+    int ret, i;
+
+    ret = region->vbasedev->io_ops->setup_sparse_mmaps(region, info, errp);
+    if (ret) {
+        return ret;
+    }
 
     /*
      * Sort sparse mmaps by offset to ensure proper handling of gaps
-- 
2.56.0


