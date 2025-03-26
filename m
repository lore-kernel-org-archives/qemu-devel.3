Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E880C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 08:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLYr-00082U-9j; Wed, 26 Mar 2025 03:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYp-0007yT-EO
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYl-0006Gh-Rb
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wG9Mun3oY4gaGFNfnE9ot9Qv8xlpIs9QoxvXpz4Hiis=;
 b=LTxHt9QQFhHSZElWsqjgbgYfBwIW97x2bLx2z3Z5lP1ihn5R2Pzvh4dW4JZ3ykEO2flmI6
 uimKaHFYqyPZRn9zj9QohjufPxuAjtEVyi+g+HtlF+X/UC9si2CAs234MY8CDb5fMZIQGE
 zG0z50U7TX0XOGKfwpI9dgURbE0i2mk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-Hrz4KOINORWvlBZqVLHLZg-1; Wed,
 26 Mar 2025 03:52:19 -0400
X-MC-Unique: Hrz4KOINORWvlBZqVLHLZg-1
X-Mimecast-MFC-AGG-ID: Hrz4KOINORWvlBZqVLHLZg_1742975538
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 795E3180034D; Wed, 26 Mar 2025 07:52:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2541E19560AB; Wed, 26 Mar 2025 07:52:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for VFIORegion
 definitions and declarations
Date: Wed, 26 Mar 2025 08:50:56 +0100
Message-ID: <20250326075122.1299361-12-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Gather all VFIORegion related declarations and definitions into their
own files to reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".
They were introduced for 'vfio-platform' support in commits
db0da029a185 ("vfio: Generalize region support") and a664477db8da
("hw/vfio/pci: Introduce VFIORegion").

To be noted that the 'vfio-platform' devices have been deprecated and
will be removed in QEMU 10.2. Until then, make the declarations
available externally for 'sysbus-fdt.c'.

Cc: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-display.h          |   1 +
 include/hw/vfio/vfio-common.h   |  32 +--
 include/hw/vfio/vfio-platform.h |   2 +
 include/hw/vfio/vfio-region.h   |  47 ++++
 hw/core/sysbus-fdt.c            |   1 +
 hw/vfio/helpers.c               | 363 -----------------------------
 hw/vfio/pci-quirks.c            |   1 +
 hw/vfio/pci.c                   |   1 +
 hw/vfio/platform.c              |   1 +
 hw/vfio/region.c                | 394 ++++++++++++++++++++++++++++++++
 hw/vfio/meson.build             |   1 +
 hw/vfio/trace-events            |  16 +-
 12 files changed, 459 insertions(+), 401 deletions(-)
 create mode 100644 include/hw/vfio/vfio-region.h
 create mode 100644 hw/vfio/region.c

diff --git a/hw/vfio/vfio-display.h b/hw/vfio/vfio-display.h
index 99b8cb67ef7558d3eefe3105a831e3fcb30afc4d..2606c34b396a88cec3e8f884adb158e48e8105f1 100644
--- a/hw/vfio/vfio-display.h
+++ b/hw/vfio/vfio-display.h
@@ -11,6 +11,7 @@
 
 #include "ui/console.h"
 #include "hw/display/ramfb.h"
+#include "hw/vfio/vfio-region.h"
 
 typedef struct VFIODMABuf {
     QemuDmaBuf *buf;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8d48f5300a791d8858fe29d1bb905f814ef11990..3d470d79325526e0508683c445a7635c78a57e34 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -39,25 +39,6 @@ enum {
     VFIO_DEVICE_TYPE_CCW = 2,
     VFIO_DEVICE_TYPE_AP = 3,
 };
-
-typedef struct VFIOMmap {
-    MemoryRegion mem;
-    void *mmap;
-    off_t offset;
-    size_t size;
-} VFIOMmap;
-
-typedef struct VFIORegion {
-    struct VFIODevice *vbasedev;
-    off_t fd_offset; /* offset of region within device fd */
-    MemoryRegion *mem; /* slow, read/write access */
-    size_t size;
-    uint32_t flags; /* VFIO region flags (rd/wr/mmap) */
-    uint32_t nr_mmaps;
-    VFIOMmap *mmaps;
-    uint8_t nr; /* cache the region number for debug */
-} VFIORegion;
-
 struct VFIOGroup;
 
 typedef struct VFIOContainer {
@@ -168,17 +149,7 @@ void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
 bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                             int action, int fd, Error **errp);
-void vfio_region_write(void *opaque, hwaddr addr,
-                           uint64_t data, unsigned size);
-uint64_t vfio_region_read(void *opaque,
-                          hwaddr addr, unsigned size);
-int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name);
-int vfio_region_mmap(VFIORegion *region);
-void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
-void vfio_region_unmap(VFIORegion *region);
-void vfio_region_exit(VFIORegion *region);
-void vfio_region_finalize(VFIORegion *region);
+
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
@@ -194,7 +165,6 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
-extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index c414c3dffcc840a2f40a1b252d0f7b4e309c78d4..3191545717da51abc41d10cd3646cd047b4a676c 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -47,6 +47,8 @@ typedef struct VFIOINTp {
 /* function type for user side eventfd handler */
 typedef void (*eventfd_user_side_handler_t)(VFIOINTp *intp);
 
+typedef struct VFIORegion VFIORegion;
+
 struct VFIOPlatformDevice {
     SysBusDevice sbdev;
     VFIODevice vbasedev; /* not a QOM object */
diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
new file mode 100644
index 0000000000000000000000000000000000000000..9dc0535e7ce46fbb671e70918b93cb115857efe6
--- /dev/null
+++ b/include/hw/vfio/vfio-region.h
@@ -0,0 +1,47 @@
+/*
+ * VFIO region
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_REGION_H
+#define HW_VFIO_REGION_H
+
+#include "exec/memory.h"
+
+typedef struct VFIOMmap {
+    MemoryRegion mem;
+    void *mmap;
+    off_t offset;
+    size_t size;
+} VFIOMmap;
+
+typedef struct VFIODevice VFIODevice;
+
+typedef struct VFIORegion {
+    struct VFIODevice *vbasedev;
+    off_t fd_offset; /* offset of region within device fd */
+    MemoryRegion *mem; /* slow, read/write access */
+    size_t size;
+    uint32_t flags; /* VFIO region flags (rd/wr/mmap) */
+    uint32_t nr_mmaps;
+    VFIOMmap *mmaps;
+    uint8_t nr; /* cache the region number for debug */
+} VFIORegion;
+
+
+void vfio_region_write(void *opaque, hwaddr addr,
+                           uint64_t data, unsigned size);
+uint64_t vfio_region_read(void *opaque,
+                          hwaddr addr, unsigned size);
+int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
+                      int index, const char *name);
+int vfio_region_mmap(VFIORegion *region);
+void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
+void vfio_region_unmap(VFIORegion *region);
+void vfio_region_exit(VFIORegion *region);
+void vfio_region_finalize(VFIORegion *region);
+
+#endif /* HW_VFIO_REGION_H */
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index e85066b905637b1ca34b5965f383df341f3a4eb7..c339a27875cbee8131b064674aa09adf4b9efa25 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -35,6 +35,7 @@
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
+#include "hw/vfio/vfio-region.h"
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 4b255d4f3a9e81f55df00c68fc71da769fd5bd04..89403943a7a219e491b6812d50b27b7f1fd7b4a4 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -147,118 +147,6 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     return false;
 }
 
-/*
- * IO Port/MMIO - Beware of the endians, VFIO is always little endian
- */
-void vfio_region_write(void *opaque, hwaddr addr,
-                       uint64_t data, unsigned size)
-{
-    VFIORegion *region = opaque;
-    VFIODevice *vbasedev = region->vbasedev;
-    union {
-        uint8_t byte;
-        uint16_t word;
-        uint32_t dword;
-        uint64_t qword;
-    } buf;
-
-    switch (size) {
-    case 1:
-        buf.byte = data;
-        break;
-    case 2:
-        buf.word = cpu_to_le16(data);
-        break;
-    case 4:
-        buf.dword = cpu_to_le32(data);
-        break;
-    case 8:
-        buf.qword = cpu_to_le64(data);
-        break;
-    default:
-        hw_error("vfio: unsupported write size, %u bytes", size);
-        break;
-    }
-
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
-                     __func__, vbasedev->name, region->nr,
-                     addr, data, size);
-    }
-
-    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
-
-    /*
-     * A read or write to a BAR always signals an INTx EOI.  This will
-     * do nothing if not pending (including not in INTx mode).  We assume
-     * that a BAR access is in response to an interrupt and that BAR
-     * accesses will service the interrupt.  Unfortunately, we don't know
-     * which access will service the interrupt, so we're potentially
-     * getting quite a few host interrupts per guest interrupt.
-     */
-    vbasedev->ops->vfio_eoi(vbasedev);
-}
-
-uint64_t vfio_region_read(void *opaque,
-                          hwaddr addr, unsigned size)
-{
-    VFIORegion *region = opaque;
-    VFIODevice *vbasedev = region->vbasedev;
-    union {
-        uint8_t byte;
-        uint16_t word;
-        uint32_t dword;
-        uint64_t qword;
-    } buf;
-    uint64_t data = 0;
-
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
-                     __func__, vbasedev->name, region->nr,
-                     addr, size);
-        return (uint64_t)-1;
-    }
-    switch (size) {
-    case 1:
-        data = buf.byte;
-        break;
-    case 2:
-        data = le16_to_cpu(buf.word);
-        break;
-    case 4:
-        data = le32_to_cpu(buf.dword);
-        break;
-    case 8:
-        data = le64_to_cpu(buf.qword);
-        break;
-    default:
-        hw_error("vfio: unsupported read size, %u bytes", size);
-        break;
-    }
-
-    trace_vfio_region_read(vbasedev->name, region->nr, addr, size, data);
-
-    /* Same as write above */
-    vbasedev->ops->vfio_eoi(vbasedev);
-
-    return data;
-}
-
-const MemoryRegionOps vfio_region_ops = {
-    .read = vfio_region_read,
-    .write = vfio_region_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-    },
-};
-
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
 {
     vbmap->pages = REAL_HOST_PAGE_ALIGN(size) / qemu_real_host_page_size();
@@ -306,257 +194,6 @@ vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id)
     return vfio_get_cap((void *)info, info->cap_offset, id);
 }
 
-static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info)
-{
-    struct vfio_info_cap_header *hdr;
-    struct vfio_region_info_cap_sparse_mmap *sparse;
-    int i, j;
-
-    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP);
-    if (!hdr) {
-        return -ENODEV;
-    }
-
-    sparse = container_of(hdr, struct vfio_region_info_cap_sparse_mmap, header);
-
-    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
-                                         region->nr, sparse->nr_areas);
-
-    region->mmaps = g_new0(VFIOMmap, sparse->nr_areas);
-
-    for (i = 0, j = 0; i < sparse->nr_areas; i++) {
-        if (sparse->areas[i].size) {
-            trace_vfio_region_sparse_mmap_entry(i, sparse->areas[i].offset,
-                                            sparse->areas[i].offset +
-                                            sparse->areas[i].size - 1);
-            region->mmaps[j].offset = sparse->areas[i].offset;
-            region->mmaps[j].size = sparse->areas[i].size;
-            j++;
-        }
-    }
-
-    region->nr_mmaps = j;
-    region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
-
-    return 0;
-}
-
-int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name)
-{
-    g_autofree struct vfio_region_info *info = NULL;
-    int ret;
-
-    ret = vfio_get_region_info(vbasedev, index, &info);
-    if (ret) {
-        return ret;
-    }
-
-    region->vbasedev = vbasedev;
-    region->flags = info->flags;
-    region->size = info->size;
-    region->fd_offset = info->offset;
-    region->nr = index;
-
-    if (region->size) {
-        region->mem = g_new0(MemoryRegion, 1);
-        memory_region_init_io(region->mem, obj, &vfio_region_ops,
-                              region, name, region->size);
-
-        if (!vbasedev->no_mmap &&
-            region->flags & VFIO_REGION_INFO_FLAG_MMAP) {
-
-            ret = vfio_setup_region_sparse_mmaps(region, info);
-
-            if (ret) {
-                region->nr_mmaps = 1;
-                region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
-                region->mmaps[0].offset = 0;
-                region->mmaps[0].size = region->size;
-            }
-        }
-    }
-
-    trace_vfio_region_setup(vbasedev->name, index, name,
-                            region->flags, region->fd_offset, region->size);
-    return 0;
-}
-
-static void vfio_subregion_unmap(VFIORegion *region, int index)
-{
-    trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
-                            region->mmaps[index].offset,
-                            region->mmaps[index].offset +
-                            region->mmaps[index].size - 1);
-    memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
-    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
-    object_unparent(OBJECT(&region->mmaps[index].mem));
-    region->mmaps[index].mmap = NULL;
-}
-
-int vfio_region_mmap(VFIORegion *region)
-{
-    int i, ret, prot = 0;
-    char *name;
-
-    if (!region->mem) {
-        return 0;
-    }
-
-    prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
-    prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
-        void *map_base, *map_align;
-
-        /*
-         * Align the mmap for more efficient mapping in the kernel.  Ideally
-         * we'd know the PMD and PUD mapping sizes to use as discrete alignment
-         * intervals, but we don't.  As of Linux v6.12, the largest PUD size
-         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
-         * on x86_64).  Align by power-of-two size, capped at 1GiB.
-         *
-         * NB. qemu_memalign() and friends actually allocate memory, whereas
-         * the region size here can exceed host memory, therefore we manually
-         * create an oversized anonymous mapping and clean it up for alignment.
-         */
-        map_base = mmap(0, region->mmaps[i].size + align, PROT_NONE,
-                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-        if (map_base == MAP_FAILED) {
-            ret = -errno;
-            goto no_mmap;
-        }
-
-        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
-        munmap(map_base, map_align - map_base);
-        munmap(map_align + region->mmaps[i].size,
-               align - (map_align - map_base));
-
-        region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
-                                     MAP_SHARED | MAP_FIXED,
-                                     region->vbasedev->fd,
-                                     region->fd_offset +
-                                     region->mmaps[i].offset);
-        if (region->mmaps[i].mmap == MAP_FAILED) {
-            ret = -errno;
-            goto no_mmap;
-        }
-
-        name = g_strdup_printf("%s mmaps[%d]",
-                               memory_region_name(region->mem), i);
-        memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
-                                          memory_region_owner(region->mem),
-                                          name, region->mmaps[i].size,
-                                          region->mmaps[i].mmap);
-        g_free(name);
-        memory_region_add_subregion(region->mem, region->mmaps[i].offset,
-                                    &region->mmaps[i].mem);
-
-        trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
-                               region->mmaps[i].offset,
-                               region->mmaps[i].offset +
-                               region->mmaps[i].size - 1);
-    }
-
-    return 0;
-
-no_mmap:
-    trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
-                                 region->fd_offset + region->mmaps[i].offset,
-                                 region->fd_offset + region->mmaps[i].offset +
-                                 region->mmaps[i].size - 1, ret);
-
-    region->mmaps[i].mmap = NULL;
-
-    for (i--; i >= 0; i--) {
-        vfio_subregion_unmap(region, i);
-    }
-
-    return ret;
-}
-
-void vfio_region_unmap(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            vfio_subregion_unmap(region, i);
-        }
-    }
-}
-
-void vfio_region_exit(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
-        }
-    }
-
-    trace_vfio_region_exit(region->vbasedev->name, region->nr);
-}
-
-void vfio_region_finalize(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            munmap(region->mmaps[i].mmap, region->mmaps[i].size);
-            object_unparent(OBJECT(&region->mmaps[i].mem));
-        }
-    }
-
-    object_unparent(OBJECT(region->mem));
-
-    g_free(region->mem);
-    g_free(region->mmaps);
-
-    trace_vfio_region_finalize(region->vbasedev->name, region->nr);
-
-    region->mem = NULL;
-    region->mmaps = NULL;
-    region->nr_mmaps = 0;
-    region->size = 0;
-    region->flags = 0;
-    region->nr = 0;
-}
-
-void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            memory_region_set_enabled(&region->mmaps[i].mem, enabled);
-        }
-    }
-
-    trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
-                                        enabled);
-}
-
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info)
 {
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 3f002252acfb7ac809107c99bdbdbaf66d56a50d..4591ec68da877b307f43ea1a830c315721b57e9e 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "pci.h"
 #include "pci-quirks.h"
+#include "hw/vfio/vfio-region.h"
 #include "trace.h"
 
 /*
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 158deca06cb240622a254f5059c47873e5fcc7de..7457e81cdb07bc6657bb1514349c172a152cb540 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -45,6 +45,7 @@
 #include "migration/qemu-file.h"
 #include "system/iommufd.h"
 #include "vfio-migration-internal.h"
+#include "hw/vfio/vfio-region.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 67bc57409c1f5a6978690c3dc07d249ea0248aa0..83b53d57149a343a00eb6d6f78c1cbea004dbaa2 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -37,6 +37,7 @@
 #include "hw/platform-bus.h"
 #include "hw/qdev-properties.h"
 #include "system/kvm.h"
+#include "hw/vfio/vfio-region.h"
 
 /*
  * Functions used whatever the injection method
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
new file mode 100644
index 0000000000000000000000000000000000000000..08cd69e7047ab950151832864a14af7af774ff3b
--- /dev/null
+++ b/hw/vfio/region.c
@@ -0,0 +1,394 @@
+/*
+ * VFIO regions
+ *
+ * Copyright Red Hat, Inc. 2012
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Based on qemu-kvm device-assignment:
+ *  Adapted for KVM by Qumranet.
+ *  Copyright (c) 2007, Neocleus, Alex Novik (alex@neocleus.com)
+ *  Copyright (c) 2007, Neocleus, Guy Zana (guy@neocleus.com)
+ *  Copyright (C) 2008, Qumranet, Amit Shah (amit.shah@qumranet.com)
+ *  Copyright (C) 2008, Red Hat, Amit Shah (amit.shah@redhat.com)
+ *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/pci.h"
+#include "hw/hw.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "monitor/monitor.h"
+
+/*
+ * IO Port/MMIO - Beware of the endians, VFIO is always little endian
+ */
+void vfio_region_write(void *opaque, hwaddr addr,
+                       uint64_t data, unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    union {
+        uint8_t byte;
+        uint16_t word;
+        uint32_t dword;
+        uint64_t qword;
+    } buf;
+
+    switch (size) {
+    case 1:
+        buf.byte = data;
+        break;
+    case 2:
+        buf.word = cpu_to_le16(data);
+        break;
+    case 4:
+        buf.dword = cpu_to_le32(data);
+        break;
+    case 8:
+        buf.qword = cpu_to_le64(data);
+        break;
+    default:
+        hw_error("vfio: unsupported write size, %u bytes", size);
+        break;
+    }
+
+    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
+                     ",%d) failed: %m",
+                     __func__, vbasedev->name, region->nr,
+                     addr, data, size);
+    }
+
+    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
+
+    /*
+     * A read or write to a BAR always signals an INTx EOI.  This will
+     * do nothing if not pending (including not in INTx mode).  We assume
+     * that a BAR access is in response to an interrupt and that BAR
+     * accesses will service the interrupt.  Unfortunately, we don't know
+     * which access will service the interrupt, so we're potentially
+     * getting quite a few host interrupts per guest interrupt.
+     */
+    vbasedev->ops->vfio_eoi(vbasedev);
+}
+
+uint64_t vfio_region_read(void *opaque,
+                          hwaddr addr, unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    union {
+        uint8_t byte;
+        uint16_t word;
+        uint32_t dword;
+        uint64_t qword;
+    } buf;
+    uint64_t data = 0;
+
+    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+                     __func__, vbasedev->name, region->nr,
+                     addr, size);
+        return (uint64_t)-1;
+    }
+    switch (size) {
+    case 1:
+        data = buf.byte;
+        break;
+    case 2:
+        data = le16_to_cpu(buf.word);
+        break;
+    case 4:
+        data = le32_to_cpu(buf.dword);
+        break;
+    case 8:
+        data = le64_to_cpu(buf.qword);
+        break;
+    default:
+        hw_error("vfio: unsupported read size, %u bytes", size);
+        break;
+    }
+
+    trace_vfio_region_read(vbasedev->name, region->nr, addr, size, data);
+
+    /* Same as write above */
+    vbasedev->ops->vfio_eoi(vbasedev);
+
+    return data;
+}
+
+static const MemoryRegionOps vfio_region_ops = {
+    .read = vfio_region_read,
+    .write = vfio_region_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
+                                          struct vfio_region_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_region_info_cap_sparse_mmap *sparse;
+    int i, j;
+
+    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP);
+    if (!hdr) {
+        return -ENODEV;
+    }
+
+    sparse = container_of(hdr, struct vfio_region_info_cap_sparse_mmap, header);
+
+    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
+                                         region->nr, sparse->nr_areas);
+
+    region->mmaps = g_new0(VFIOMmap, sparse->nr_areas);
+
+    for (i = 0, j = 0; i < sparse->nr_areas; i++) {
+        if (sparse->areas[i].size) {
+            trace_vfio_region_sparse_mmap_entry(i, sparse->areas[i].offset,
+                                            sparse->areas[i].offset +
+                                            sparse->areas[i].size - 1);
+            region->mmaps[j].offset = sparse->areas[i].offset;
+            region->mmaps[j].size = sparse->areas[i].size;
+            j++;
+        }
+    }
+
+    region->nr_mmaps = j;
+    region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+
+    return 0;
+}
+
+int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
+                      int index, const char *name)
+{
+    g_autofree struct vfio_region_info *info = NULL;
+    int ret;
+
+    ret = vfio_get_region_info(vbasedev, index, &info);
+    if (ret) {
+        return ret;
+    }
+
+    region->vbasedev = vbasedev;
+    region->flags = info->flags;
+    region->size = info->size;
+    region->fd_offset = info->offset;
+    region->nr = index;
+
+    if (region->size) {
+        region->mem = g_new0(MemoryRegion, 1);
+        memory_region_init_io(region->mem, obj, &vfio_region_ops,
+                              region, name, region->size);
+
+        if (!vbasedev->no_mmap &&
+            region->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+
+            ret = vfio_setup_region_sparse_mmaps(region, info);
+
+            if (ret) {
+                region->nr_mmaps = 1;
+                region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
+                region->mmaps[0].offset = 0;
+                region->mmaps[0].size = region->size;
+            }
+        }
+    }
+
+    trace_vfio_region_setup(vbasedev->name, index, name,
+                            region->flags, region->fd_offset, region->size);
+    return 0;
+}
+
+static void vfio_subregion_unmap(VFIORegion *region, int index)
+{
+    trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
+                            region->mmaps[index].offset,
+                            region->mmaps[index].offset +
+                            region->mmaps[index].size - 1);
+    memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
+    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
+    object_unparent(OBJECT(&region->mmaps[index].mem));
+    region->mmaps[index].mmap = NULL;
+}
+
+int vfio_region_mmap(VFIORegion *region)
+{
+    int i, ret, prot = 0;
+    char *name;
+
+    if (!region->mem) {
+        return 0;
+    }
+
+    prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
+    prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
+
+    for (i = 0; i < region->nr_mmaps; i++) {
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
+                                     region->fd_offset +
+                                     region->mmaps[i].offset);
+        if (region->mmaps[i].mmap == MAP_FAILED) {
+            ret = -errno;
+            goto no_mmap;
+        }
+
+        name = g_strdup_printf("%s mmaps[%d]",
+                               memory_region_name(region->mem), i);
+        memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
+                                          memory_region_owner(region->mem),
+                                          name, region->mmaps[i].size,
+                                          region->mmaps[i].mmap);
+        g_free(name);
+        memory_region_add_subregion(region->mem, region->mmaps[i].offset,
+                                    &region->mmaps[i].mem);
+
+        trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
+                               region->mmaps[i].offset,
+                               region->mmaps[i].offset +
+                               region->mmaps[i].size - 1);
+    }
+
+    return 0;
+
+no_mmap:
+    trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
+                                 region->fd_offset + region->mmaps[i].offset,
+                                 region->fd_offset + region->mmaps[i].offset +
+                                 region->mmaps[i].size - 1, ret);
+
+    region->mmaps[i].mmap = NULL;
+
+    for (i--; i >= 0; i--) {
+        vfio_subregion_unmap(region, i);
+    }
+
+    return ret;
+}
+
+void vfio_region_unmap(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            vfio_subregion_unmap(region, i);
+        }
+    }
+}
+
+void vfio_region_exit(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
+        }
+    }
+
+    trace_vfio_region_exit(region->vbasedev->name, region->nr);
+}
+
+void vfio_region_finalize(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            munmap(region->mmaps[i].mmap, region->mmaps[i].size);
+            object_unparent(OBJECT(&region->mmaps[i].mem));
+        }
+    }
+
+    object_unparent(OBJECT(region->mem));
+
+    g_free(region->mem);
+    g_free(region->mmaps);
+
+    trace_vfio_region_finalize(region->vbasedev->name, region->nr);
+
+    region->mem = NULL;
+    region->mmaps = NULL;
+    region->nr_mmaps = 0;
+    region->size = 0;
+    region->flags = 0;
+    region->nr = 0;
+}
+
+void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            memory_region_set_enabled(&region->mmaps[i].mem, enabled);
+        }
+    }
+
+    trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
+                                        enabled);
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index a8939c838657b09c38f93ad69d541df5aea30a6f..07010c7c9e01a39ae3449c54d2027a2cdd0a7a4d 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'migration.c',
   'migration-multifd.c',
   'cpr.c',
+  'region.c',
 ))
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9347e3a5f6607ec6907f9b426da9ab90553292cf..81f4130100c48012c15b5b4858446149a7eaf5b6 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -90,8 +90,6 @@ vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 
 # common.c
-vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
-vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
 vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_skip(const char *name, uint64_t start, uint64_t end) "SKIPPING %s 0x%"PRIx64" - 0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
@@ -107,6 +105,15 @@ vfio_disconnect_container(int fd) "close container->fd=%d"
 vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
 vfio_put_base_device(int fd) "close vdev->fd=%d"
+vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
+vfio_legacy_dma_unmap_overflow_workaround(void) ""
+vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
+vfio_reset_handler(void) ""
+
+# region.c
+vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
+vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
 vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
 vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
 vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
@@ -116,11 +123,6 @@ vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps e
 vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Region %s unmap [0x%lx - 0x%lx]"
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
-vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
-vfio_legacy_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
-vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
-vfio_reset_handler(void) ""
 
 # platform.c
 vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
-- 
2.49.0


