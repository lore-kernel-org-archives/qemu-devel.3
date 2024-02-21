Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FBAC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchBR-0002xC-7j; Wed, 21 Feb 2024 02:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenh@yusur.tech>) id 1rchBO-0002wx-DL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:38:22 -0500
Received: from out28-148.mail.aliyun.com ([115.124.28.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenh@yusur.tech>) id 1rchBI-0002wT-Vz
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:38:22 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608756|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0387159-0.000858882-0.960425;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047211; MF=chenh@yusur.tech; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.WW7h3D7_1708501083; 
Received: from localhost.localdomain(mailfrom:chenh@yusur.tech
 fp:SMTPD_---.WW7h3D7_1708501083) by smtp.aliyun-inc.com;
 Wed, 21 Feb 2024 15:38:04 +0800
From: Hao Chen <chenh@yusur.tech>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com
Subject: [PATCH] hw/virtio: Add support for VDPA network simulation devices
Date: Wed, 21 Feb 2024 15:38:02 +0800
Message-Id: <20240221073802.2888022-1-chenh@yusur.tech>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.148; envelope-from=chenh@yusur.tech;
 helo=out28-148.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This patch adds support for VDPA network simulation devices.
The device is developed based on virtio-net and tap backend,
and supports hardware live migration function.

For more details, please refer to "docs/system/devices/vdpa-net.rst"

Signed-off-by: Hao Chen <chenh@yusur.tech>
---
 MAINTAINERS                                 |   5 +
 docs/system/device-emulation.rst            |   1 +
 docs/system/devices/vdpa-net.rst            | 121 +++++++++++++
 hw/net/virtio-net.c                         |  16 ++
 hw/virtio/virtio-pci.c                      | 189 +++++++++++++++++++-
 hw/virtio/virtio.c                          |  39 ++++
 include/hw/virtio/virtio-pci.h              |   5 +
 include/hw/virtio/virtio.h                  |  19 ++
 include/standard-headers/linux/virtio_pci.h |   7 +
 9 files changed, 399 insertions(+), 3 deletions(-)
 create mode 100644 docs/system/devices/vdpa-net.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d61fb9319..a1bde36bb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2359,6 +2359,11 @@ F: hw/virtio/vhost-user-scmi*
 F: include/hw/virtio/vhost-user-scmi.h
 F: tests/qtest/libqos/virtio-scmi.*
 
+vdpa-net
+M: Hao Chen <chenh@yusur.tech>
+S: Maintained
+F: docs/system/devices/vdpa-net.rst
+
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
 S: Supported
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index f19777411c..e4a27f53c8 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -99,3 +99,4 @@ Emulated Devices
    devices/canokey.rst
    devices/usb-u2f.rst
    devices/igb.rst
+   devices/vdpa-net.rst
diff --git a/docs/system/devices/vdpa-net.rst b/docs/system/devices/vdpa-net.rst
new file mode 100644
index 0000000000..323d8c926a
--- /dev/null
+++ b/docs/system/devices/vdpa-net.rst
@@ -0,0 +1,121 @@
+vdpa net
+============
+
+This document explains the setup and usage of the vdpa network device.
+The vdpa network device is a paravirtualized vdpa emulate device.
+
+Description
+-----------
+
+VDPA net devices support dirty page bitmap mark and vring state saving and recovery.
+
+Users can use this VDPA device for live migration simulation testing in a nested virtualization environment.
+
+Registers layout
+----------------
+
+The vdpa device add live migrate registers layout as follow::
+
+  Offset       Register Name	        Bitwidth     Associated vq
+  0x0          LM_LOGGING_CTRL          4bits
+  0x10         LM_BASE_ADDR_LOW         32bits
+  0x14         LM_BASE_ADDR_HIGH        32bits
+  0x18         LM_END_ADDR_LOW          32bits
+  0x1c         LM_END_ADDR_HIGH         32bits
+  0x20         LM_RING_STATE_OFFSET	32bits       vq0
+  0x24         LM_RING_STATE_OFFSET	32bits       vq1
+  0x28         LM_RING_STATE_OFFSET	32bits       vq2
+  ......
+  0x20+1023*4  LM_RING_STATE_OFFSET     32bits       vq1023
+
+These registers are extended at the end of the notify bar space.
+
+Architecture diagram
+--------------------
+::
+
+  |------------------------------------------------------------------------|
+  | guest-L1-user-space                                                    |
+  |                                                                        |
+  |                               |----------------------------------------|
+  |                               |       [virtio-net driver]              |
+  |                               |              ^  guest-L2-src(iommu=on) |
+  |                               |--------------|-------------------------|
+  |                               |              |  qemu-L2-src(viommu)    |
+  | [dpdk-vdpa]<->[vhost socket]<-+->[vhost-user backend(iommu=on)]        |
+  --------------------------------------------------------------------------
+  --------------------------------------------------------------------------
+  |       ^                             guest-L1-kernel-space              |
+  |       |                                                                |
+  |    [VFIO]                                                              |
+  |       ^                                                                |
+  |       |                             guest-L1-src(iommu=on)             |
+  --------|-----------------------------------------------------------------
+  --------|-----------------------------------------------------------------
+  | [vdpa net device(iommu=on)]        [manager nic device]                |
+  |          |                                    |                        |
+  |          |                                    |                        |
+  |     [tap device]     qemu-L1-src(viommu)      |                        |
+  ------------------------------------------------+-------------------------
+                                                  |
+                                                  |
+                        ---------------------     |
+                        | kernel net bridge |<-----
+                        |     virbr0        |<----------------------------------
+                        ---------------------                                  |
+                                                                               |
+                                                                               |
+  --------------------------------------------------------------------------   |
+  | guest-L1-user-space                                                    |   |
+  |                                                                        |   |
+  |                               |----------------------------------------|   |
+  |                               |       [virtio-net driver]              |   |
+  |                               |              ^  guest-L2-dst(iommu=on) |   |
+  |                               |--------------|-------------------------|   |
+  |                               |              |  qemu-L2-dst(viommu)    |   |
+  | [dpdk-vdpa]<->[vhost socket]<-+->[vhost-user backend(iommu=on)]        |   |
+  --------------------------------------------------------------------------   |
+  --------------------------------------------------------------------------   |
+  |       ^                             guest-L1-kernel-space              |   |
+  |       |                                                                |   |
+  |    [VFIO]                                                              |   |
+  |       ^                                                                |   |
+  |       |                             guest-L1-dst(iommu=on)             |   |
+  --------|-----------------------------------------------------------------   |
+  --------|-----------------------------------------------------------------   |
+  | [vdpa net device(iommu=on)]        [manager nic device]----------------+----
+  |          |                                                             |
+  |          |                                                             |
+  |     [tap device]     qemu-L1-dst(viommu)                               |
+  --------------------------------------------------------------------------
+
+
+Device properties
+-----------------
+
+The Virtio vdpa device can be configured with the following properties:
+
+ * ``vdpa=on`` open vdpa device emulated.
+
+Usages
+--------
+This patch add virtio sriov support and vdpa live migrate support.
+You can open vdpa by set xml file as follow::
+
+  <qemu:commandline  xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
+  <qemu:arg value='-device'/>
+  <qemu:arg value='intel-iommu,intremap=on,device-iotlb=on,aw-bits=48'/>
+  <qemu:arg value='-netdev'/>
+  <qemu:arg value='tap,id=hostnet1,script=no,downscript=no,vhost=off'/>
+  <qemu:arg value='-device'/>
+  <qemu:arg value='virtio-net-pci,netdev=hostnet1,id=net1,mac=56:4a:b7:4f:4d:a9,bus=pci.6,addr=0x0,iommu_platform=on,ats=on,vdpa=on'/>
+  </qemu:commandline>
+
+Limitations
+-----------
+1. Dependent on tap device with param ``vhost=off``.
+2. Nested virtualization environment only supports ``q35`` machines.
+3. Current only support split vring live migrate.
+
+
+
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5a79bc3a3a..443b790f05 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1999,6 +1999,22 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             goto err;
         }
 
+        /* Mark dirty page's bitmap of guest memory */
+        if (vdev->lm_logging_ctrl == LM_ENABLE) {
+            uint64_t chunk = elem->in_addr[i] / VHOST_LOG_CHUNK;
+            /* Get chunk index */
+            BitmapMemoryRegionCaches *caches = qatomic_rcu_read(&vdev->caches);
+            uint64_t index = chunk / 8;
+            uint64_t shift = chunk % 8;
+            uint8_t val = 0;
+            address_space_read_cached(&caches->bitmap, index, &val,
+                                      sizeof(val));
+            val |= 1 << shift;
+            address_space_write_cached(&caches->bitmap, index, &val,
+                                       sizeof(val));
+            address_space_cache_invalidate(&caches->bitmap, index, sizeof(val));
+        }
+
         elems[i] = elem;
         lens[i] = total;
         i++;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c..e42ac6e7f9 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1442,6 +1442,155 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
     return virtio_pci_add_mem_cap(proxy, &cap.cap);
 }
 
+/* Called within call_rcu().  */
+static void bitmap_free_region_cache(BitmapMemoryRegionCaches *caches)
+{
+    assert(caches != NULL);
+    address_space_cache_destroy(&caches->bitmap);
+    g_free(caches);
+}
+
+static void lm_disable(VirtIODevice *vdev)
+{
+    BitmapMemoryRegionCaches *caches;
+    caches = qatomic_read(&vdev->caches);
+    qatomic_rcu_set(&vdev->caches, NULL);
+    if (caches) {
+        call_rcu(caches, bitmap_free_region_cache, rcu);
+    }
+}
+
+static void lm_enable(VirtIODevice *vdev)
+{
+    BitmapMemoryRegionCaches *old = vdev->caches;
+    BitmapMemoryRegionCaches *new = NULL;
+    hwaddr addr, end, size;
+    int64_t len;
+
+    addr = vdev->lm_base_addr_low | ((hwaddr)(vdev->lm_base_addr_high) << 32);
+    end = vdev->lm_end_addr_low | ((hwaddr)(vdev->lm_end_addr_high) << 32);
+    size = end - addr;
+    if (size <= 0) {
+        error_report("Invalid lm size.");
+        return;
+    }
+
+    new = g_new0(BitmapMemoryRegionCaches, 1);
+    len = address_space_cache_init(&new->bitmap, vdev->dma_as, addr, size,
+                                   true);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map bitmap");
+        goto err_bitmap;
+    }
+    qatomic_rcu_set(&vdev->caches, new);
+
+    if (old) {
+        call_rcu(old, bitmap_free_region_cache, rcu);
+    }
+
+    return;
+
+err_bitmap:
+    address_space_cache_destroy(&new->bitmap);
+    g_free(new);
+}
+
+static uint64_t virtio_pci_lm_read(void *opaque, hwaddr addr,
+                                       unsigned size)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+    hwaddr offset_end = LM_VRING_STATE_OFFSET +
+                        virtio_pci_queue_mem_mult(proxy) * VIRTIO_QUEUE_MAX;
+    uint32_t val;
+    int qid;
+
+    if (vdev == NULL) {
+        return UINT64_MAX;
+    }
+    switch (addr) {
+    case LM_LOGGING_CTRL:
+        val = vdev->lm_logging_ctrl;
+        break;
+    case LM_BASE_ADDR_LOW:
+        val = vdev->lm_base_addr_low;
+        break;
+    case LM_BASE_ADDR_HIGH:
+        val = vdev->lm_base_addr_high;
+        break;
+    case LM_END_ADDR_LOW:
+        val = vdev->lm_end_addr_low;
+        break;
+    case LM_END_ADDR_HIGH:
+        val = vdev->lm_end_addr_high;
+        break;
+    default:
+        if (addr >= LM_VRING_STATE_OFFSET && addr <= offset_end) {
+            qid = (addr - LM_VRING_STATE_OFFSET) /
+                  virtio_pci_queue_mem_mult(proxy);
+            val = virtio_queue_get_vring_states(vdev, qid);
+        } else
+            val = 0;
+
+        break;
+    }
+
+    return val;
+}
+
+static void virtio_pci_lm_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+    hwaddr offset_end = LM_VRING_STATE_OFFSET +
+                        virtio_pci_queue_mem_mult(proxy) * VIRTIO_QUEUE_MAX;
+    int qid;
+
+    if (vdev == NULL) {
+        return;
+    }
+
+    switch (addr) {
+    case LM_LOGGING_CTRL:
+        vdev->lm_logging_ctrl = val;
+        switch (val) {
+        case LM_DISABLE:
+            lm_disable(vdev);
+            break;
+        case LM_ENABLE:
+            lm_enable(vdev);
+            break;
+        default:
+            virtio_error(vdev, "Unsupport LM_LOGGING_CTRL value: %"PRIx64,
+                         val);
+                break;
+        };
+
+        break;
+    case LM_BASE_ADDR_LOW:
+        vdev->lm_base_addr_low = val;
+        break;
+    case LM_BASE_ADDR_HIGH:
+        vdev->lm_base_addr_high = val;
+        break;
+    case LM_END_ADDR_LOW:
+        vdev->lm_end_addr_low = val;
+        break;
+    case LM_END_ADDR_HIGH:
+        vdev->lm_end_addr_high = val;
+        break;
+    default:
+        if (addr >= LM_VRING_STATE_OFFSET && addr <= offset_end) {
+            qid = (addr - LM_VRING_STATE_OFFSET) /
+                  virtio_pci_queue_mem_mult(proxy);
+            virtio_queue_set_vring_states(vdev, qid, val);
+        } else
+            virtio_error(vdev, "Unsupport addr: %"PRIx64, addr);
+        break;
+    }
+}
+
 static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
                                        unsigned size)
 {
@@ -1823,6 +1972,15 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy,
         },
         .endianness = DEVICE_LITTLE_ENDIAN,
     };
+    static const MemoryRegionOps lm_ops = {
+        .read = virtio_pci_lm_read,
+        .write = virtio_pci_lm_write,
+        .impl = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+        .endianness = DEVICE_LITTLE_ENDIAN,
+    };
     g_autoptr(GString) name = g_string_new(NULL);
 
     g_string_printf(name, "virtio-pci-common-%s", vdev_name);
@@ -1859,6 +2017,14 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy,
                           proxy,
                           name->str,
                           proxy->notify_pio.size);
+    if (proxy->flags & VIRTIO_PCI_FLAG_VDPA) {
+        g_string_printf(name, "virtio-pci-lm-%s", vdev_name);
+        memory_region_init_io(&proxy->lm.mr, OBJECT(proxy),
+                          &lm_ops,
+                          proxy,
+                          name->str,
+                          proxy->lm.size);
+    }
 }
 
 static void virtio_pci_modern_region_map(VirtIOPCIProxy *proxy,
@@ -2021,6 +2187,10 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->device, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->notify, &notify.cap);
+        if (proxy->flags & VIRTIO_PCI_FLAG_VDPA) {
+            memory_region_add_subregion(&proxy->modern_bar,
+                                        proxy->lm.offset, &proxy->lm.mr);
+        }
 
         if (modern_pio) {
             memory_region_init(&proxy->io_bar, OBJECT(proxy),
@@ -2090,6 +2260,9 @@ static void virtio_pci_device_unplugged(DeviceState *d)
         virtio_pci_modern_mem_region_unmap(proxy, &proxy->isr);
         virtio_pci_modern_mem_region_unmap(proxy, &proxy->device);
         virtio_pci_modern_mem_region_unmap(proxy, &proxy->notify);
+        if (proxy->flags & VIRTIO_PCI_FLAG_VDPA) {
+            memory_region_del_subregion(&proxy->modern_bar, &proxy->lm.mr);
+        }
         if (modern_pio) {
             virtio_pci_modern_io_region_unmap(proxy, &proxy->notify_pio);
         }
@@ -2144,9 +2317,17 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     proxy->notify_pio.type = VIRTIO_PCI_CAP_NOTIFY_CFG;
 
     /* subclasses can enforce modern, so do this unconditionally */
-    memory_region_init(&proxy->modern_bar, OBJECT(proxy), "virtio-pci",
-                       /* PCI BAR regions must be powers of 2 */
-                       pow2ceil(proxy->notify.offset + proxy->notify.size));
+    if (!(proxy->flags & VIRTIO_PCI_FLAG_VDPA)) {
+        memory_region_init(&proxy->modern_bar, OBJECT(proxy), "virtio-pci",
+                           /* PCI BAR regions must be powers of 2 */
+                           pow2ceil(proxy->notify.offset + proxy->notify.size));
+    } else {
+        proxy->lm.offset = proxy->notify.offset + proxy->notify.size;
+        proxy->lm.size = 0x20 + VIRTIO_QUEUE_MAX * 4;
+        memory_region_init(&proxy->modern_bar, OBJECT(proxy), "virtio-pci",
+                           /* PCI BAR regions must be powers of 2 */
+                           pow2ceil(proxy->lm.offset + proxy->lm.size));
+    }
 
     if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
@@ -2301,6 +2482,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_AER_BIT, false),
+    DEFINE_PROP_BIT("vdpa", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_VDPA_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d229755eae..fb6b4ccd83 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3368,6 +3368,18 @@ static uint16_t virtio_queue_split_get_last_avail_idx(VirtIODevice *vdev,
     return vdev->vq[n].last_avail_idx;
 }
 
+static uint32_t virtio_queue_split_get_vring_states(VirtIODevice *vdev,
+                                                      int n)
+{
+    struct VirtQueue *vq = &vdev->vq[n];
+    uint16_t avail, used;
+
+    avail = vq->last_avail_idx;
+    used = vq->used_idx;
+
+    return avail | (uint32_t)used << 16;
+}
+
 unsigned int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
 {
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
@@ -3377,6 +3389,33 @@ unsigned int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
     }
 }
 
+unsigned int virtio_queue_get_vring_states(VirtIODevice *vdev, int n)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return -1;
+    } else {
+        return virtio_queue_split_get_vring_states(vdev, n);
+    }
+}
+
+static void virtio_queue_split_set_vring_states(VirtIODevice *vdev,
+                                                int n, uint32_t idx)
+{
+    struct VirtQueue *vq = &vdev->vq[n];
+    vq->last_avail_idx = (uint16_t)(idx & 0xffff);
+    vq->shadow_avail_idx = (uint16_t)(idx & 0xffff);
+    vq->used_idx = (uint16_t)(idx >> 16);
+}
+
+void virtio_queue_set_vring_states(VirtIODevice *vdev, int n, uint32_t idx)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return;
+    } else {
+        virtio_queue_split_set_vring_states(vdev, n, idx);
+    }
+}
+
 static void virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,
                                                    int n, unsigned int idx)
 {
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 59d88018c1..4d57a9c751 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -43,6 +43,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
+    VIRTIO_PCI_FLAG_VDPA_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -89,6 +90,9 @@ enum {
 #define VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
   (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
 
+/* VDPA supported flags */
+#define VIRTIO_PCI_FLAG_VDPA (1 << VIRTIO_PCI_FLAG_VDPA_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
@@ -140,6 +144,7 @@ struct VirtIOPCIProxy {
         };
         VirtIOPCIRegion regs[5];
     };
+    VirtIOPCIRegion lm;
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
     uint32_t legacy_io_bar_idx;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..b3c74a1bca 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -35,6 +35,9 @@
                                 (0x1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) | \
                                 (0x1ULL << VIRTIO_F_ANY_LAYOUT))
 
+#define LM_DISABLE      0x00
+#define LM_ENABLE       0x01
+
 struct VirtQueue;
 
 static inline hwaddr vring_align(hwaddr addr,
@@ -95,6 +98,11 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+typedef struct BitmapMemoryRegionCaches {
+    struct rcu_head rcu;
+    MemoryRegionCache bitmap;
+} BitmapMemoryRegionCaches;
+
 /**
  * struct VirtIODevice - common VirtIO structure
  * @name: name of the device
@@ -128,6 +136,14 @@ struct VirtIODevice
     uint32_t generation;
     int nvectors;
     VirtQueue *vq;
+    uint8_t lm_logging_ctrl;
+    uint32_t lm_base_addr_low;
+    uint32_t lm_base_addr_high;
+    uint32_t lm_end_addr_low;
+    uint32_t lm_end_addr_high;
+
+    BitmapMemoryRegionCaches *caches;
+
     MemoryListener listener;
     uint16_t device_id;
     /* @vm_running: current VM running state via virtio_vmstate_change() */
@@ -379,8 +395,11 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
 unsigned int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
+unsigned int virtio_queue_get_vring_states(VirtIODevice *vdev, int n);
 void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n,
                                      unsigned int idx);
+void virtio_queue_set_vring_states(VirtIODevice *vdev, int n,
+                                   unsigned int idx);
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index b7fdfd0668..fb5391cef6 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -216,6 +216,13 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_PCI_COMMON_Q_NDATA	56
 #define VIRTIO_PCI_COMMON_Q_RESET	58
 
+#define LM_LOGGING_CTRL                 0
+#define LM_BASE_ADDR_LOW                4
+#define LM_BASE_ADDR_HIGH               8
+#define LM_END_ADDR_LOW                 12
+#define LM_END_ADDR_HIGH                16
+#define LM_VRING_STATE_OFFSET           0x20
+
 #endif /* VIRTIO_PCI_NO_MODERN */
 
 #endif
-- 
2.27.0


