Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADF6CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxmE-0001JI-Er; Mon, 01 Sep 2025 02:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlc-0000mg-DL; Mon, 01 Sep 2025 02:11:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlY-0002aX-9O; Mon, 01 Sep 2025 02:11:48 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5816ACAk076640
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 15:10:31 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=iGdH8z3BWY4aeVno3WKHTvunvaA5O+8C3rxcrDsvFq4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756707031; v=1;
 b=hz2SAbXoQZZT8aXOmqDyWHr13ytqPcjT8zJ8FejEmllqZCELnflCBKUW7WS5HCdU
 nsdjd+76Z8RO/uqlytEOfDkQAjxJr0JdJtVQnLAdNdKOs/kDDHueyQeLnsVEyJjt
 4Ga8xCzehcInGpDBIaJ098lS/Q1M0ORhVOD7Y7dF590xMKGWPh+KtfhgGskOpu8n
 i9njeWtMgKoLB8NXObF6IbMp/nYOjn3KxKJMj+pMcXu3RwNZDhGMLYwcQPkyPDrF
 uKshBgiIsc6m4paxGjH9lEBpYiVgKPBI0x0BUhd/RURcDcWpXX5jg8MElr6d/Sil
 Dz9WnTzl2h2x9bF9HZdkqQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 01 Sep 2025 15:10:14 +0900
Subject: [PATCH 16/16] memory: Stop piggybacking on memory region owners
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mr-v1-16-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
References: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

MemoryRegions used to "piggyback" on their owners instead of using their
own reference counters due to the circular dependencies between them,
which caused a few problems. Stop piggybacking, showing that the
circular dependencies are actually broken.

Problems with piggybacking
==========================

Piggybacking obscured the fact that a MemoryRegion used memory allocated
to its owner, as it didn't take a reference to the owner.

It also created another circular reference when an owner referred to its
MemoryRegion via memory_region_ref(). This could happen in two
scenarios:

- A subregion and its container had the same owner. In this case, the
  container would use memory_region_ref() to take a reference to the
  subregion.

- An owner called address_space_map() with a guest-controlled address
  that points back to its MemoryRegion. This scenario is similar to what
  MemReentrancyGuard handles.

Avoiding such a circular reference required checking if the referrer is
the owner, complicating the code further.

Insight
=======

This change challenges the underlying assumption that circulare
dependencies exist and can be tolerated. The deletable MemoryRegions are
of hotpluggable devices. A device and its MemoryRegion have the
following dependencies:

QOM tree -> Device
Container -> MemoryRegion
Device <-> MemoryRegion

Techniques like piggybacking or a hypothetical garbage collector can
finalize the device and the MemoryRegion once the QOM tree and container
lose their dependencies. However, these methods are fundamentally
insufficient because the MemoryRegion and the device have finalizers,
and they do not respect the dependencies these objects may have during
finalization.

As long as the object model based on the device and the MemoryRegion is
correct, one of them should lose its dependency on the first,
establishing a valid finalization order. Understanding this allows using
standard reference counting, which is immune to the problems of
piggybacking.

Analysis reveals that the device no longer depends on the
MemoryRegion after unrealization. The device needs the MemoryRegion to
add it to a container and expose it to an AddressSpace. Once unrealized,
the device is hidden from the AddresSpaces and thus no longer needs the
MemoryRegion.

This suggests that the circular dependencies are broken and that the
device should be finalized *after*:

- It is unrealized.
- The MemoryRegion is finalized.

Solution
========

Fortunately, this requirement can be coded with minimal complexity.
Hotpluggable devices already explicitly call
memory_region_del_subregion() to stop accepting new accesses to its
MemoryRegions after unrealization. This change lets object_unparent()
calls follow that, permitting the MemoryRegions to be finalized earlier
than the device.

This enforces a valid finalization order, allows MemoryRegions to rely
on standard reference counting, and eliminates the entire class of
memory leaks caused by piggybacking.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 MAINTAINERS             |  1 +
 docs/devel/memory.rst   | 32 +++++++++++++++----------------
 include/system/memory.h | 51 ++++++++++++++++++++++++-------------------------
 hw/core/qdev.c          | 25 +++++++++++++++++++-----
 stubs/memory.c          |  9 +++++++++
 system/memory.c         | 11 +++--------
 stubs/meson.build       |  1 +
 7 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8147fff3523eaa45c4a0d2c21d40b4ade3f419ff..4665f0a4b7a513c5863f6d5227a0173c836505e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3212,6 +3212,7 @@ F: include/system/memory.h
 F: include/system/ram_addr.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
+F: stubs/memory.c
 F: system/dma-helpers.c
 F: system/ioport.c
 F: system/memory.c
diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 749f11d8a4ddc80f2d44b66fa41fb12c0fa54006..c7bb5602e9c20e19dd8dfe4a814e958cc0518598 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -158,30 +158,31 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
 as soon as the region is made visible.  This can be immediately, later,
 or never.
 
-Destruction of a memory region happens automatically when the owner
-object dies.
+You should call object_unparent() if the memory region becomes
+unnecessary for its owner. If its owner is a device, object_unparent()
+will be called automatically after unrealization.
 
-You must not destroy a memory region as long as it may be in use by a
-device or CPU.  In order to do this, as a general rule do not create or
-destroy memory regions dynamically during a device's lifetime.
+You must not free a memory region as long as it may be in use by a
+device or CPU.  In order to do this, as a general rule do not allocate or
+free memory regions dynamically during a device's lifetime.
 The dynamically allocated data structure that contains the
 memory region should be freed in the instance_finalize callback.
 
 If you break this rule, the following situation can happen:
 
-- the memory region's owner had a reference taken via memory_region_ref
+- the memory region had a reference taken via memory_region_ref
   (for example by address_space_map)
 
-- the region is unparented, and has no owner anymore
+- the region is freed
 
-- when address_space_unmap is called, the reference to the memory region's
-  owner is leaked.
+- when the mapped memory is used, the use of the memory region
+  results in use-after-free.
 
 
-There is an exception to the above rule: it is okay to call
-object_unparent at any time for an alias or a container region.  It is
-therefore also okay to create or destroy alias and container regions
-dynamically during a device's lifetime.
+There is an exception to the above rule: it is okay to free at any time
+for an alias or a container region.  It is therefore also okay to
+allocate or free alias and container regions dynamically during a
+device's lifetime.
 
 This exceptional usage is valid because aliases and containers only help
 QEMU building the guest's memory map; they are never accessed directly.
@@ -191,9 +192,8 @@ this exception is rarely necessary, and therefore it is discouraged,
 but nevertheless it is used in a few places.
 
 For regions that "have no owner" (NULL is passed at creation time), the
-machine object is actually used as the owner.  You must never call
-object_unparent on regions that have no owner, unless they are aliases
-or containers.
+machine object is actually used as the owner.  You must never free
+regions that have no owner, unless they are aliases or containers.
 
 
 Overlapping regions and priority
diff --git a/include/system/memory.h b/include/system/memory.h
index e2cd6ed126144abaed6f3035e3ef091d747b4c34..1fc773ca49e26d605a4e152b5b41426ad7666912 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1307,7 +1307,7 @@ static inline bool memory_region_section_intersect_range(MemoryRegionSection *s,
  * memory_region_add_subregion() to add subregions.
  *
  * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region; any subregions beyond this size will be clipped
  */
@@ -1320,14 +1320,14 @@ void memory_region_init(MemoryRegion *mr,
  * memory_region_ref: Add 1 to a memory region's reference count
  *
  * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function adds a reference to the owner.
+ * preserved against hot-unplug. This function adds a reference to the
+ * memory region.
  *
- * All MemoryRegions must have an owner if they can disappear, even if the
- * device they belong to operates exclusively under the BQL.  This is because
- * the region could be returned at any time by memory_region_find, and this
- * is usually under guest control.
+ * We do not ref/unref memory regions without an owner because it slows
+ * down DMA sensibly. All MemoryRegions must have an owner if they can
+ * disappear, even if the device they belong to operates exclusively
+ * under the BQL.  This is because the region could be returned at any
+ * time by memory_region_find, and this is usually under guest control.
  *
  * @mr: the #MemoryRegion
  */
@@ -1337,9 +1337,8 @@ void memory_region_ref(MemoryRegion *mr);
  * memory_region_unref: Remove 1 to a memory region's reference count
  *
  * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function removes a reference to the owner and possibly destroys it.
+ * preserved against hot-unplug. This function removes a reference to
+ * the memory and possibly destroys it.
  *
  * @mr: the #MemoryRegion
  */
@@ -1352,7 +1351,7 @@ void memory_region_unref(MemoryRegion *mr);
  * if @size is nonzero, subregions will be clipped to @size.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @ops: a structure containing read and write callbacks to be used when
  *       I/O is performed on the region.
  * @opaque: passed to the read and write callbacks of the @ops structure.
@@ -1372,7 +1371,7 @@ void memory_region_init_io(MemoryRegion *mr,
  *                                    directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1395,7 +1394,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
  *                                          modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1425,7 +1424,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
  *                                     canceled.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: used size of the region.
@@ -1454,7 +1453,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *                                    mmap-ed backend.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1487,7 +1486,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  *                                  mmap-ed backend.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: the name of the region.
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
@@ -1518,7 +1517,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
  *                              region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1546,7 +1545,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
  * skip_dump flag.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: the name of the region.
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
@@ -1566,7 +1565,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
  *                           part of another memory region.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: used for debugging; not visible to the user or ABI
  * @orig: the region to be referenced; @mr will be equivalent to
  *        @orig between @offset and @offset + @size - 1.
@@ -1592,7 +1591,7 @@ void memory_region_init_alias(MemoryRegion *mr,
  * of the caller.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1615,7 +1614,7 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
  * of the caller.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @ops: callbacks for write access handling (must not be NULL).
  * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
@@ -1651,7 +1650,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
  * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
  * @instance_size: the IOMMUMemoryRegion subclass instance size
  * @mrtypename: the type name of the #IOMMUMemoryRegion
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region.
  */
@@ -1667,7 +1666,7 @@ void memory_region_init_iommu(void *_iommu_mr,
  *                          region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count (must be
+ * @owner: the object that provides the region's storage (must be
  *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
  * @name: name of the memory region
  * @size: size of the region in bytes
@@ -1713,7 +1712,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
  * If you pass a non-NULL non-device @owner then we will assert.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1744,7 +1743,7 @@ bool memory_region_init_rom(MemoryRegion *mr,
  * If you pass a non-NULL non-device @owner then we will assert.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that provides the region's storage
  * @ops: callbacks for write access handling (must not be NULL).
  * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8fdf6774f87ec8424348e8c9652dc4c99a2faeb5..3b1a01cdeec5b6823217fbc2d611ec94ac1ccf51 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -451,17 +451,32 @@ static bool check_only_migratable(Object *obj, Error **errp)
     return true;
 }
 
-static int del_memory_region(Object *child, void *opaque)
+static int collect_memory_region(Object *child, void *opaque)
 {
     MemoryRegion *mr = (MemoryRegion *)object_dynamic_cast(child, TYPE_MEMORY_REGION);
 
-    if (mr && mr->container) {
-        memory_region_del_subregion(mr->container, mr);
+    if (mr) {
+        if (mr->container) {
+            memory_region_del_subregion(mr->container, mr);
+        }
+
+        g_array_append_val(opaque, child);
     }
 
     return 0;
 }
 
+static void del_memory_regions(DeviceState *dev)
+{
+    g_autoptr(GArray) array = g_array_new(FALSE, FALSE, sizeof(Object *));
+
+    object_child_foreach(OBJECT(dev), collect_memory_region, array);
+
+    for (gsize i = 0; i < array->len; i++) {
+        object_unparent(g_array_index(array, Object *, i));
+    }
+}
+
 static void device_set_realized(Object *obj, bool value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -593,7 +608,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (dc->unrealize) {
             dc->unrealize(dev);
         }
-        object_child_foreach(OBJECT(dev), del_memory_region, NULL);
+        del_memory_regions(dev);
         dev->pending_deleted_event = true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
     }
@@ -618,7 +633,7 @@ post_realize_fail:
     }
 
 fail:
-    object_child_foreach(OBJECT(dev), del_memory_region, NULL);
+    del_memory_regions(dev);
 
     error_propagate(errp, local_err);
     if (unattached_parent) {
diff --git a/stubs/memory.c b/stubs/memory.c
new file mode 100644
index 0000000000000000000000000000000000000000..9c36531ae542d804dc19ed2a3c657005881a2bca
--- /dev/null
+++ b/stubs/memory.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/memory.h"
+
+void memory_region_del_subregion(MemoryRegion *mr,
+                                 MemoryRegion *subregion)
+{
+}
diff --git a/system/memory.c b/system/memory.c
index 56465479406f4a264bfe13e6a2bc7d9b6565410f..f81c634bcca4c4f32dea6796e5f98f6e2baaa94c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1222,7 +1222,7 @@ static void memory_region_do_init(MemoryRegion *mr,
         mr->size = int128_2_64();
     }
     mr->name = g_strdup(name);
-    mr->owner = owner;
+    mr->owner = object_ref(owner);
     mr->dev = (DeviceState *) object_dynamic_cast(mr->owner, TYPE_DEVICE);
     mr->ram_block = NULL;
 
@@ -1816,6 +1816,7 @@ static void memory_region_finalize(Object *obj)
     memory_region_clear_coalescing(mr);
     g_free((char *)mr->name);
     g_free(mr->ioeventfds);
+    object_unref(mr->owner);
 }
 
 Object *memory_region_owner(MemoryRegion *mr)
@@ -1826,13 +1827,7 @@ Object *memory_region_owner(MemoryRegion *mr)
 
 void memory_region_ref(MemoryRegion *mr)
 {
-    /* MMIO callbacks most likely will access data that belongs
-     * to the owner, hence the need to ref/unref the owner whenever
-     * the memory region is in use.
-     *
-     * The memory region is a child of its owner.  As long as the
-     * owner doesn't call unparent itself on the memory region,
-     * ref-ing the owner will also keep the memory region alive.
+    /*
      * Memory regions without an owner are supposed to never go away;
      * we do not ref/unref them because it slows down DMA sensibly.
      */
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e6854ddaa9f12714c317a541ea75b8d412..b4df4e60a1af89c9354d5b92449ce5409095b9f1 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -95,5 +95,6 @@ if have_system or have_user
 
   # Also included in have_system for tests/unit/test-qdev-global-props
   stub_ss.add(files('hotplug-stubs.c'))
+  stub_ss.add(files('memory.c'))
   stub_ss.add(files('sysbus.c'))
 endif

-- 
2.51.0


