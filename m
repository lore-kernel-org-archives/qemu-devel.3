Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03743CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW9W-0002CQ-7l; Tue, 16 Jun 2026 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9U-0002Bs-Dd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9S-0003p3-B6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781625393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLJZ6XcA8ayCW7/0LWEa3/BF3pKTaWaZXznPUjSJF8Q=;
 b=K6NFh5b/5w9/m+50fip+XdX9bIpkJNeibmVIcC0LY2qCbl6hJTMbpk5VkO65Oa7Sv82Dgo
 8y6KiPB+p60PCloeC2cmUOOKq4TAequG8eB8b/UhGon/7TMYHbJ06GTt4KJTwmdiQGQ+bE
 zwRCFF/Q/Nu3SndttirgQPk8QruRtlg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-HCfVa5-sOaavKt4vJcGtVA-1; Tue,
 16 Jun 2026 11:56:29 -0400
X-MC-Unique: HCfVa5-sOaavKt4vJcGtVA-1
X-Mimecast-MFC-AGG-ID: HCfVa5-sOaavKt4vJcGtVA_1781625387
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE2C71800A7E; Tue, 16 Jun 2026 15:56:26 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1057195419E; Tue, 16 Jun 2026 15:56:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 4/7] system: add memory_region_new / memory_region_new_io
Date: Tue, 16 Jun 2026 16:55:51 +0100
Message-ID: <20260616155554.264412-5-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-1-berrange@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare for the move to dynamically allocated memory regions by
introducing memory_region_new and memory_region_new_io functions
which call through to object_new instead of object_initialize.

TBD: add "new" variants for all the other memory_region_init
variants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/system/memory.h | 76 ++++++++++++++++++++++++++++++------
 system/memory.c         | 85 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 136 insertions(+), 25 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..b4c5a185c0 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1300,19 +1300,44 @@ static inline bool memory_region_section_intersect_range(MemoryRegionSection *s,
 
 /**
  * memory_region_init: Initialize a memory region
- *
- * The region typically acts as a container for other memory regions.  Use
- * memory_region_add_subregion() to add subregions.
- *
  * @mr: the #MemoryRegion to be initialized
  * @owner: the object that tracks the region's reference count
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region; any subregions beyond this size will be clipped
+ *
+ * The region typically acts as a container for other memory regions.  Use
+ * memory_region_add_subregion() to add subregions.
+ *
+ * Use of this function is now deprecated. All memory regions must be
+ * allocated using the memory_region_new() family of functions and not
+ * statically embedded in a larger struct.
  */
 void memory_region_init(MemoryRegion *mr,
                         Object *owner,
                         const char *name,
-                        uint64_t size);
+                        uint64_t size)
+    QEMU_DEPRECATED;
+
+
+/**
+ * memory_region_new: Allocate a memory region.
+ * @owner: the object that owns the memory region in the composition tree
+ * @name: used for debugging; not visible to the user or ABI
+ * @size: size of the region; any subregions beyond this size will be clipped
+ *
+ * The region typically acts as a container for other memory regions.  Use
+ * memory_region_add_subregion() to add subregions.
+ *
+ * The returned memory region will have a single reference, which is
+ * held by the @owner object in the QOM composition tree. Thus in the
+ * absence of any further references being acquired, the memory region
+ * will be freed when @owner is freed
+ *
+ * Returns: the newly allocated memory region
+ */
+MemoryRegion *memory_region_new(Object *owner,
+                                const char *name,
+                                uint64_t size);
 
 /**
  * memory_region_ref: Add 1 to a memory region's reference count
@@ -1344,11 +1369,7 @@ void memory_region_ref(MemoryRegion *mr);
 void memory_region_unref(MemoryRegion *mr);
 
 /**
- * memory_region_init_io: Initialize an I/O memory region.
- *
- * Accesses into the region will cause the callbacks in @ops to be called.
- * if @size is nonzero, subregions will be clipped to @size.
- *
+ * memory_region_init_io: Initialize an I/O memory region
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @ops: a structure containing read and write callbacks to be used when
@@ -1356,13 +1377,46 @@ void memory_region_unref(MemoryRegion *mr);
  * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region.
+ *
+ * Accesses into the region will cause the callbacks in @ops to be called.
+ * if @size is nonzero, subregions will be clipped to @size.
+ *
+ * Use of this function is now deprecated. All memory regions must be
+ * allocated using the memory_region_new() family of functions and not
+ * statically embedded in a larger struct.
  */
 void memory_region_init_io(MemoryRegion *mr,
                            Object *owner,
                            const MemoryRegionOps *ops,
                            void *opaque,
                            const char *name,
-                           uint64_t size);
+                           uint64_t size)
+    QEMU_DEPRECATED;
+
+/**
+ * memory_region_new_io: Allocates an I/O memory region
+ * @owner: the object that tracks the region's reference count
+ * @ops: a structure containing read and write callbacks to be used when
+ *       I/O is performed on the region.
+ * @opaque: passed to the read and write callbacks of the @ops structure.
+ * @name: used for debugging; not visible to the user or ABI
+ * @size: size of the region.
+ *
+ * Accesses into the region will cause the callbacks in @ops to be called.
+ * if @size is nonzero, subregions will be clipped to @size.
+ *
+ * The returned memory region will have a single reference, which is
+ * held by the @owner object in the QOM composition tree. Thus in the
+ * absence of any further references being acquired, the memory region
+ * will be freed when @owner is freed
+ *
+ * Returns: the newly allocated memory region
+ */
+MemoryRegion *memory_region_new_io(Object *owner,
+                                   const MemoryRegionOps *ops,
+                                   void *opaque,
+                                   const char *name,
+                                   uint64_t size);
 
 /**
  * memory_region_init_ram_flags_nomigrate:  Initialize RAM memory region.
diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..e8a539e37e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1214,6 +1214,18 @@ static char *memory_region_escape_name(const char *name)
     return escaped;
 }
 
+static char *memory_region_make_child(Object **owner,
+                                      const char *name)
+{
+    g_autofree char *escaped_name = memory_region_escape_name(name);
+
+    if (!*owner) {
+        *owner = machine_get_container("unattached");
+    }
+
+    return g_strdup_printf("%s[*]", escaped_name);
+}
+
 static void memory_region_do_init(MemoryRegion *mr,
                                   Object *owner,
                                   const char *name,
@@ -1227,20 +1239,6 @@ static void memory_region_do_init(MemoryRegion *mr,
     mr->owner = owner;
     mr->dev = (DeviceState *) object_dynamic_cast(mr->owner, TYPE_DEVICE);
     mr->ram_block = NULL;
-
-    if (name) {
-        char *escaped_name = memory_region_escape_name(name);
-        char *name_array = g_strdup_printf("%s[*]", escaped_name);
-
-        if (!owner) {
-            owner = machine_get_container("unattached");
-        }
-
-        object_property_add_child(owner, name_array, OBJECT(mr));
-        object_unref(OBJECT(mr));
-        g_free(name_array);
-        g_free(escaped_name);
-    }
 }
 
 void memory_region_init(MemoryRegion *mr,
@@ -1250,6 +1248,31 @@ void memory_region_init(MemoryRegion *mr,
 {
     object_initialize(mr, sizeof(*mr), TYPE_MEMORY_REGION);
     memory_region_do_init(mr, owner, name, size);
+    if (name) {
+        g_autofree char *childname = memory_region_make_child(&owner, name);
+        object_property_add_child(owner, childname, OBJECT(mr));
+        object_unref(OBJECT(mr));
+    }
+}
+
+MemoryRegion *memory_region_new(Object *owner,
+                                const char *name,
+                                uint64_t size)
+{
+    /*
+     * error_abort is safe, because 'childname' includes a wildcard
+     * for dynamically assigning a unique name. Thus adding the child
+     * property cannot fail
+     */
+    MemoryRegion *mr = MEMORY_REGION(object_new(TYPE_MEMORY_REGION));
+    memory_region_do_init(mr, owner, name, size);
+    if (name) {
+        g_autofree char *childname = memory_region_make_child(&owner, name);
+        object_property_add_child(owner, childname, OBJECT(mr));
+        object_unref(OBJECT(mr));
+
+    }
+    return mr;
 }
 
 static void memory_region_get_container(Object *obj, Visitor *v,
@@ -1574,10 +1597,22 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
                            const char *name, uint64_t size)
 {
     g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init(mr, owner, name, size);
+    QEMU_DEPRECATIONS_ON;
     memory_region_set_ops(mr, ops, opaque);
 }
 
+MemoryRegion *memory_region_new_io(Object *owner,
+                                   const MemoryRegionOps *ops, void *opaque,
+                                   const char *name, uint64_t size)
+{
+    g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    memory_region_set_ops(mr, ops, opaque);
+    return mr;
+}
+
 static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
 {
     mr->terminates = true;
@@ -1597,7 +1632,9 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
 {
     RAMBlock *rb;
 
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init(mr, owner, name, size);
+    QEMU_DEPRECATIONS_ON;
     mr->ram = true;
     rb = qemu_ram_alloc(size, ram_flags, mr, errp);
     return memory_region_set_ram_block(mr, rb);
@@ -1615,7 +1652,9 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
 {
     RAMBlock *rb;
 
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init(mr, owner, name, size);
+    QEMU_DEPRECATIONS_ON;
     mr->ram = true;
     rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
     return memory_region_set_ram_block(mr, rb);
@@ -1630,7 +1669,9 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
 {
     RAMBlock *rb;
 
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init(mr, owner, name, size);
+    QEMU_DEPRECATIONS_ON;
     mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
     mr->align = align;
@@ -1645,7 +1686,9 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
 {
     RAMBlock *rb;
 
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init(mr, owner, name, size);
+    QEMU_DEPRECATIONS_ON;
     mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
     rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
@@ -1667,7 +1710,9 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
                                 const char *name, uint64_t size,
                                 void *ptr)
 {
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init(mr, owner, name, size);
+    QEMU_DEPRECATIONS_ON;
     mr->ram = true;
     memory_region_set_ram_ptr(mr, size, ptr);
 }
@@ -1676,7 +1721,9 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
 {
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
+    QEMU_DEPRECATIONS_ON;
     mr->ram = true;
     mr->ram_device = true;
     memory_region_set_ram_ptr(mr, size, ptr);
@@ -1686,7 +1733,9 @@ void memory_region_init_alias(MemoryRegion *mr, Object *owner,
                               const char *name, MemoryRegion *orig,
                               hwaddr offset, uint64_t size)
 {
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init(mr, owner, name, size);
+    QEMU_DEPRECATIONS_ON;
     mr->alias = orig;
     mr->alias_offset = offset;
 }
@@ -1704,6 +1753,12 @@ void memory_region_init_iommu(void *_iommu_mr,
     object_initialize(_iommu_mr, instance_size, mrtypename);
     mr = MEMORY_REGION(_iommu_mr);
     memory_region_do_init(mr, owner, name, size);
+    if (name) {
+        g_autofree char *childname = memory_region_make_child(&owner, name);
+        object_property_add_child(owner, childname, OBJECT(mr));
+        object_unref(OBJECT(mr));
+    }
+
     iommu_mr = IOMMU_MEMORY_REGION(mr);
     mr->terminates = true;  /* then re-forwards */
     QLIST_INIT(&iommu_mr->iommu_notify);
@@ -3703,7 +3758,9 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
     RAMBlock *rb;
 
     assert(ops);
+    QEMU_DEPRECATIONS_OFF;
     memory_region_init_io(mr, owner, ops, opaque, name, size);
+    QEMU_DEPRECATIONS_ON;
     rb = qemu_ram_alloc(size, 0, mr, errp);
     if (memory_region_set_ram_block(mr, rb)) {
         mr->rom_device = true;
-- 
2.54.0


