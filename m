Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935C4C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LuD-0005zi-0d; Tue, 07 May 2024 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LuB-0005wu-RD
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:55 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu9-0002DW-DV
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:55 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2b537cd50f9so1806584a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715092492; x=1715697292;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOivXaF8+A0cro9lsHnsr+8aMQSWWD0uE8YNs35mNaQ=;
 b=NpNSqPspTwZUuiYuqURBdouyPmXGOOho4r27HHqKNdbopqDTCsCi8EYDTerIjB5J8M
 hbdH5kJc3QG1Bb+0A+ii0a4/yQMYSQTPz7+92IIviuO6K/7Fy4FM/+0hvEygQg4IYOC/
 xLaR7v6ECVz8qicuhtcWROO5mjym5T8/e+IWWFlq2Nvjic2v6tXTdpvVKJDxbsfbywz2
 z9shII4ZCkCuBkfM4NRRGKFLsliuGrMG/AeXniBOz7HV6AqaG6FaH+G29B9/FwgUv5PL
 NmMJZkhBg5bZCz+hWb/VhYDvlZAJAEvgM2g2fju7iU8xIFKZvG2ucTEOhPO4G0tm2POD
 qKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092492; x=1715697292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOivXaF8+A0cro9lsHnsr+8aMQSWWD0uE8YNs35mNaQ=;
 b=mWUiqrpqtxghKc4ROpJd9NIoqTDL7fe8xncT1l6G822hb8jLsR/39q9INncMi3M/fh
 1JnraTKKuiarTOVs1Ug6X1/FwX0DoKxCiPV00+g4kAxYuDVPKiKHLSk/tgHtD5BeHLUl
 CdiLzwgc4DPCeVVN2f/iJQVj7e6qhtNmNkwtH/9IHX3I2X1xjczgfogZpVLMDy515V+M
 8Tlr6Y/YjxQumgV25kt4NjInWOFM3XSklYx+2pjhgTy5RoUXYKjEMPtCNNX98brOMsG4
 R9CJW/GVZTKejR+sCD5kcEXUhITzMSZkPP3c0gEtDrD8Ridu44KbrmLTdQ2tk38grDmH
 fL/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKlC1/zoJlJ2JgEWmvIB8ZAvf65uuNEQrYJqWDW8/d6a63w185L4IOU3Y5ZHvE0oyClksosSZlqFL5SfOJ66264wAOkEE=
X-Gm-Message-State: AOJu0YzmcOqZ1woTM8VznZF1PbhjLgXzElwPvrpf828CS0VuYOLdBGG6
 qqc2y89gvfTUGkmH90hl83UE0sGgvIhIeaK7KVWgt47YjY49hA8MuwV/gTQMtq8=
X-Google-Smtp-Source: AGHT+IHmea9p0DOaJ39h4cjqwIrPLUfLxpKURLMYHNkNy5bMSA8YVwx/nNpJPqZPAhG8ya8UwVd2DA==
X-Received: by 2002:a17:90a:f294:b0:2b3:f79a:5552 with SMTP id
 fs20-20020a17090af29400b002b3f79a5552mr10905722pjb.16.1715092491765; 
 Tue, 07 May 2024 07:34:51 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 pq10-20020a17090b3d8a00b002af8056917csm11827206pjb.29.2024.05.07.07.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:34:51 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com, peterx@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v10 4/7] softmmu: Support concurrent bounce buffers
Date: Tue,  7 May 2024 07:34:28 -0700
Message-ID: <20240507143431.464382-5-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=mnissler@rivosinc.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When DMA memory can't be directly accessed, as is the case when
running the device model in a separate process without shareable DMA
file descriptors, bounce buffering is used.

It is not uncommon for device models to request mapping of several DMA
regions at the same time. Examples include:
 * net devices, e.g. when transmitting a packet that is split across
   several TX descriptors (observed with igb)
 * USB host controllers, when handling a packet with multiple data TRBs
   (observed with xhci)

Previously, qemu only provided a single bounce buffer per AddressSpace
and would fail DMA map requests while the buffer was already in use. In
turn, this would cause DMA failures that ultimately manifest as hardware
errors from the guest perspective.

This change allocates DMA bounce buffers dynamically instead of
supporting only a single buffer. Thus, multiple DMA mappings work
correctly also when RAM can't be mmap()-ed.

The total bounce buffer allocation size is limited individually for each
AddressSpace. The default limit is 4096 bytes, matching the previous
maximum buffer size. A new x-max-bounce-buffer-size parameter is
provided to configure the limit for PCI devices.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/pci/pci.c                |  8 ++++
 include/exec/memory.h       | 14 +++----
 include/hw/pci/pci_device.h |  3 ++
 system/memory.c             |  5 ++-
 system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
 5 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 324c1302d2..d6f4944cbd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
+                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1204,6 +1206,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                        "bus master container", UINT64_MAX);
     address_space_init(&pci_dev->bus_master_as,
                        &pci_dev->bus_master_container_region, pci_dev->name);
+    pci_dev->bus_master_as.max_bounce_buffer_size =
+        pci_dev->max_bounce_buffer_size;
 
     if (phase_check(PHASE_MACHINE_READY)) {
         pci_init_bus_master(pci_dev);
@@ -2633,6 +2637,10 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     device_class_set_props(k, pci_props);
+    object_class_property_set_description(
+        klass, "x-max-bounce-buffer-size",
+        "Maximum buffer size allocated for bounce buffers used for mapped "
+        "access to indirect DMA memory");
 }
 
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index d417d7f363..451879efbd 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1117,13 +1117,7 @@ typedef struct AddressSpaceMapClient {
     QLIST_ENTRY(AddressSpaceMapClient) link;
 } AddressSpaceMapClient;
 
-typedef struct {
-    MemoryRegion *mr;
-    void *buffer;
-    hwaddr addr;
-    hwaddr len;
-    bool in_use;
-} BounceBuffer;
+#define DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4096)
 
 /**
  * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
@@ -1143,8 +1137,10 @@ struct AddressSpace {
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 
-    /* Bounce buffer to use for this address space. */
-    BounceBuffer bounce;
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    size_t max_bounce_buffer_size;
+    /* Total size of bounce buffers currently allocated, atomically accessed */
+    size_t bounce_buffer_size;
     /* List of callbacks to invoke when buffers free up */
     QemuMutex map_client_list_lock;
     QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..253b48a688 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -160,6 +160,9 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
+
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    uint32_t max_bounce_buffer_size;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/system/memory.c b/system/memory.c
index 642a449f8c..c288ed354a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3174,7 +3174,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
-    as->bounce.in_use = false;
+    as->max_bounce_buffer_size = DEFAULT_MAX_BOUNCE_BUFFER_SIZE;
+    as->bounce_buffer_size = 0;
     qemu_mutex_init(&as->map_client_list_lock);
     QLIST_INIT(&as->map_client_list);
     as->name = g_strdup(name ? name : "anonymous");
@@ -3184,7 +3185,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
-    assert(!qatomic_read(&as->bounce.in_use));
+    assert(qatomic_read(&as->bounce_buffer_size) == 0);
     assert(QLIST_EMPTY(&as->map_client_list));
     qemu_mutex_destroy(&as->map_client_list_lock);
 
diff --git a/system/physmem.c b/system/physmem.c
index 62758202cf..242e8f27e7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3046,6 +3046,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
                                      NULL, len, FLUSH_CACHE);
 }
 
+/*
+ * A magic value stored in the first 8 bytes of the bounce buffer struct. Used
+ * to detect illegal pointers passed to address_space_unmap.
+ */
+#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
+
+typedef struct {
+    uint64_t magic;
+    MemoryRegion *mr;
+    hwaddr addr;
+    size_t len;
+    uint8_t buffer[];
+} BounceBuffer;
+
 static void
 address_space_unregister_map_client_do(AddressSpaceMapClient *client)
 {
@@ -3071,9 +3085,9 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
     QEMU_LOCK_GUARD(&as->map_client_list_lock);
     client->bh = bh;
     QLIST_INSERT_HEAD(&as->map_client_list, client, link);
-    /* Write map_client_list before reading in_use.  */
+    /* Write map_client_list before reading bounce_buffer_size. */
     smp_mb();
-    if (!qatomic_read(&as->bounce.in_use)) {
+    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
         address_space_notify_map_clients_locked(as);
     }
 }
@@ -3200,28 +3214,40 @@ void *address_space_map(AddressSpace *as,
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&as->bounce.in_use, true)) {
+        size_t used = qatomic_read(&as->bounce_buffer_size);
+        for (;;) {
+            hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
+            size_t new_size = used + alloc;
+            size_t actual =
+                qatomic_cmpxchg(&as->bounce_buffer_size, used, new_size);
+            if (actual == used) {
+                l = alloc;
+                break;
+            }
+            used = actual;
+        }
+
+        if (l == 0) {
             *plen = 0;
             return NULL;
         }
-        /* Avoid unbounded allocations */
-        l = MIN(l, TARGET_PAGE_SIZE);
-        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        as->bounce.addr = addr;
-        as->bounce.len = l;
 
+        BounceBuffer *bounce = g_malloc0(l + sizeof(BounceBuffer));
+        bounce->magic = BOUNCE_BUFFER_MAGIC;
         memory_region_ref(mr);
-        as->bounce.mr = mr;
+        bounce->mr = mr;
+        bounce->addr = addr;
+        bounce->len = l;
+
         if (!is_write) {
             flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
-                          as->bounce.buffer, l);
+                          bounce->buffer, l);
         }
 
         *plen = l;
-        return as->bounce.buffer;
+        return bounce->buffer;
     }
 
-
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
@@ -3236,12 +3262,11 @@ void *address_space_map(AddressSpace *as,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len)
 {
-    if (buffer != as->bounce.buffer) {
-        MemoryRegion *mr;
-        ram_addr_t addr1;
+    MemoryRegion *mr;
+    ram_addr_t addr1;
 
-        mr = memory_region_from_host(buffer, &addr1);
-        assert(mr != NULL);
+    mr = memory_region_from_host(buffer, &addr1);
+    if (mr != NULL) {
         if (is_write) {
             invalidate_and_set_dirty(mr, addr1, access_len);
         }
@@ -3251,15 +3276,22 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         memory_region_unref(mr);
         return;
     }
+
+
+    BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
+    assert(bounce->magic == BOUNCE_BUFFER_MAGIC);
+
     if (is_write) {
-        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
-                            as->bounce.buffer, access_len);
-    }
-    qemu_vfree(as->bounce.buffer);
-    as->bounce.buffer = NULL;
-    memory_region_unref(as->bounce.mr);
-    /* Clear in_use before reading map_client_list.  */
-    qatomic_set_mb(&as->bounce.in_use, false);
+        address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
+                            bounce->buffer, access_len);
+    }
+
+    qatomic_sub(&as->bounce_buffer_size, bounce->len);
+    bounce->magic = ~BOUNCE_BUFFER_MAGIC;
+    memory_region_unref(bounce->mr);
+    g_free(bounce);
+    /* Write bounce_buffer_size before reading map_client_list. */
+    smp_mb();
     address_space_notify_map_clients(as);
 }
 
-- 
2.43.2


