Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C87EEF36E7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 06:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUMO-0007wW-RF; Mon, 09 Mar 2026 02:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUMM-0007w7-Sy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:58 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUML-00027W-4K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:58 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-56af6737b4fso1820006e0c.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773038695; x=1773643495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcNC0yip2XrDmFo80yDxRtX2oleYkrUeo7InlE7zv9I=;
 b=m8YXcIuw14YYHEX2r6k0K1Re3Tj6R4p0+w3HNyIHVnsyQVCxgUYEcWgDZANqmYm8Xn
 s26Xyn8yuHKC42qMW2RrtQEGyiK247BE2C+u1K1lhKgbJ12Xt89oBSGywVtSmjg2AizU
 KQ5VAGu9ortC3fzdQga+vkcov+mrlEYq5W3BGTrYU3NsRGP3uCYd2s/AFgYCtK0+xCG3
 eaxM4uY0UE51s4KvKi+5IUNMadjT4ZjuVdRyYH25S4WrUu5Wqa0N9rosEghSKIsp0Cfz
 kKTzpyUfa85LRWrNnrNWjI+6gl+6ZW6rdsA3i18HIixs+7OPHOENVXUuvBEeyFup91AS
 XG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773038695; x=1773643495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OcNC0yip2XrDmFo80yDxRtX2oleYkrUeo7InlE7zv9I=;
 b=mvIHHS0HoNbRA71ailFa+FykOXY99rcPB8ixiCSXg0elh0XDyCt7TndU0/p/OLGy2L
 8TgjEPJmtReTvtTlsEtY4j2pqFrwCeN9RKMaZpjb68J3B1Dl4EZwYRoYSjejMl83zwM6
 vFuKanpIr9hSdOr0k84R0T1iGcfOEBeOfKRxTk4wttpSjnThvJ7GEvNlDS9SFC3nr/SM
 K6XKql+a9flF2EMAM7dbTIpxL7BVsdstGWe2XHVCjSH/wJ16yH+r7suDWmnZTxnzGWGO
 /HBPI5Bh3SE0QdTaCyySbFErmKvq8ftJMkVa6hrX+KubcCyesJYPBjGIepiBKq5mwzSG
 xp3g==
X-Gm-Message-State: AOJu0YyMNemneJgpzE17Vp85k4zDYEAWoaoESft73kiOyHEN+sff3V+Z
 awHbbygTx1kI3tvGYNMtQ/X4j6saVg5NY4CMd7vlhg29Rcpum/9+XErcrHYWWQRW
X-Gm-Gg: ATEYQzwF1aJn6miB9AQOyXSfRrg2xyy05ESOcKlrfZC0eo8doPbaRr28Jy0ezUOC0aE
 5oLsgo0JbWWapyloJtsVpEeEzdk0mbKOr/jk5Vl90NjZHJMQX08T/TNi0Z8a/2/p/k9x/kpP6r+
 sVq8+f5mFO0elw7buTvywVpfKuW8ZtlNGDsrYDO08HXk6wbWZiZE99BeDUAO00zNUU2kK+WjpF0
 cnVso0PJxeNVECql/Kpp+1OSKEH+NHBBnqKxbbtbW1bIo+PL6ZrxhXv5w+BXkCV/qwKDvwp7Iyk
 kR4TTsZ3enSc1YE4ZAJfnEazyfMI4ps0DJ5KDJBHyRVk/YjdcBBWVYmcIoTK/q1boNqyTtq+5sf
 9ilRE0jU5/FNMslOoDLxhEXT9KVwIvlH8uCshO//vrzCeUjNIkapW69LvrPFR4HDgJpv58V2lWR
 Zo20K+Jy0oChSPCXn14fBtH+GvbJLJVn4Ww3hQAupxUyTKlkdvcXYbrqgweg==
X-Received: by 2002:a05:6122:1c0a:b0:567:4722:66a3 with SMTP id
 71dfb90a1353d-56b07da5535mr3763057e0c.8.1773038695019; 
 Sun, 08 Mar 2026 23:44:55 -0700 (PDT)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56b0f889ed2sm7456276e0c.13.2026.03.08.23.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 23:44:54 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: edgar.iglesias@amd.com,
	xen-devel@lists.xenproject.org
Subject: [PULL v1 5/5] hw/xen: xenpvh: Add prop to enable/disable the mapcache
Date: Mon,  9 Mar 2026 07:44:35 +0100
Message-ID: <20260309064436.51860-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309064436.51860-1-edgar.iglesias@gmail.com>
References: <20260309064436.51860-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add a machine property to enable/disable the mapcache.
Default it to enabled for backwards compatibility.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-pvh-common.c         | 133 +++++++++++++++++++++++++++++---
 include/hw/xen/xen-pvh-common.h |   2 +
 2 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 4fade017bb..cca37202ff 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -29,6 +29,69 @@ static const MemoryListener xen_memory_listener = {
     .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
+/*
+ * Map foreign RAM in bounded chunks so we don't build a PFN array for the
+ * entire guest size (which can be huge for large guests). We reserve a VA
+ * range once and then MAP_FIXED each chunk into place.
+ */
+#define XEN_PVH_MAP_CHUNK_PAGES 65535
+
+static void *xen_map_guest_ram(XenPVHMachineState *s,
+                               uint64_t addr, uint64_t size)
+{
+    size_t total_pages = size >> XC_PAGE_SHIFT;
+    size_t chunk_pages = MIN(XEN_PVH_MAP_CHUNK_PAGES, total_pages);
+    g_autofree xen_pfn_t *pfns = NULL;
+    void *base = NULL;
+    size_t offset;
+
+    if (!total_pages) {
+        goto done;
+    }
+
+    base = mmap(NULL, size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (base == MAP_FAILED) {
+        base = NULL;
+        goto done;
+    }
+
+    pfns = g_new0(xen_pfn_t, chunk_pages);
+    if (!pfns) {
+        munmap(base, size);
+        base = NULL;
+        goto done;
+    }
+
+    for (offset = 0; offset < total_pages; offset += chunk_pages) {
+        size_t num_pages = MIN(chunk_pages, total_pages - offset);
+        void *mapped;
+        size_t i;
+
+        for (i = 0; i < num_pages; i++) {
+            pfns[i] = (addr >> XC_PAGE_SHIFT) + offset + i;
+        }
+
+        mapped = xenforeignmemory_map2(
+            xen_fmem, xen_domid,
+            (uint8_t *)base + (offset << XC_PAGE_SHIFT),
+            PROT_READ | PROT_WRITE, MAP_FIXED,
+            num_pages, pfns, NULL);
+        if (!mapped) {
+            munmap(base, size);
+            base = NULL;
+            goto done;
+        }
+    }
+done:
+    if (!base) {
+        /* We can't recover from this.  */
+        error_report("FATAL: Failed to foreign-map %" PRIx64 " - %" PRIx64,
+                     addr, addr + size);
+        exit(EXIT_FAILURE);
+    }
+    return base;
+}
+
 static void xen_pvh_init_ram(XenPVHMachineState *s,
                              MemoryRegion *sysmem)
 {
@@ -45,22 +108,42 @@ static void xen_pvh_init_ram(XenPVHMachineState *s,
         block_len = s->cfg.ram_high.base + ram_size[1];
     }
 
-    memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len,
-                           &error_fatal);
+    if (s->cfg.mapcache) {
+        memory_region_init_ram(&xen_memory, NULL, "xen.ram",
+                               block_len, &error_fatal);
+        memory_region_init_alias(&s->ram.low, NULL, "xen.ram.lo", &xen_memory,
+                                 s->cfg.ram_low.base, ram_size[0]);
+        if (ram_size[1] > 0) {
+            memory_region_init_alias(&s->ram.high, NULL, "xen.ram.hi",
+                                     &xen_memory,
+                                     s->cfg.ram_high.base, ram_size[1]);
+        }
+    } else {
+        void *p;
+
+        p = xen_map_guest_ram(s, s->cfg.ram_low.base, ram_size[0]);
+        memory_region_init_ram_ptr(&s->ram.low, NULL, "xen.ram.lo",
+                                   ram_size[0], p);
+        if (ram_size[1] > 0) {
+            p = xen_map_guest_ram(s, s->cfg.ram_high.base, ram_size[1]);
+            memory_region_init_ram_ptr(&s->ram.high, NULL, "xen.ram.hi",
+                                       ram_size[1], p);
+        }
+    }
 
-    memory_region_init_alias(&s->ram.low, NULL, "xen.ram.lo", &xen_memory,
-                             s->cfg.ram_low.base, ram_size[0]);
+    /* Map them onto QEMU's address-space.  */
     memory_region_add_subregion(sysmem, s->cfg.ram_low.base, &s->ram.low);
     if (ram_size[1] > 0) {
-        memory_region_init_alias(&s->ram.high, NULL, "xen.ram.hi", &xen_memory,
-                                 s->cfg.ram_high.base, ram_size[1]);
         memory_region_add_subregion(sysmem, s->cfg.ram_high.base, &s->ram.high);
     }
 
-    /* Setup support for grants.  */
-    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
-                           &error_fatal);
-    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
+    /* Grants are only supported when the mapcache is on.  */
+    if (s->cfg.mapcache) {
+        /* Setup support for grants.  */
+        memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
+                &error_fatal);
+        memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
+    }
 }
 
 static void xen_set_irq(void *opaque, int irq, int level)
@@ -203,7 +286,7 @@ static void xen_pvh_init(MachineState *ms)
     xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
                        xpc->handle_bufioreq,
                        &xen_memory_listener,
-                       true);
+                       s->cfg.mapcache);
 
     if (s->cfg.virtio_mmio_num) {
         xen_create_virtio_mmio_devices(s);
@@ -285,6 +368,20 @@ XEN_PVH_PROP_MEMMAP(pci_ecam)
 XEN_PVH_PROP_MEMMAP(pci_mmio)
 XEN_PVH_PROP_MEMMAP(pci_mmio_high)
 
+static void xen_pvh_set_mapcache(Object *obj, bool value, Error **errp)
+{
+    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
+
+    xp->cfg.mapcache = value;
+}
+
+static bool xen_pvh_get_mapcache(Object *obj, Error **errp)
+{
+    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
+
+    return xp->cfg.mapcache;
+}
+
 static void xen_pvh_set_pci_intx_irq_base(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
@@ -338,6 +435,12 @@ do {                                                                      \
         OC_MEMMAP_PROP_SIZE(c, prop_name, name);                          \
 } while (0)
 
+    object_class_property_add_bool(oc, "mapcache", xen_pvh_get_mapcache,
+                                   xen_pvh_set_mapcache);
+    object_class_property_set_description(oc, "mapcache",
+                                      "Set on/off to enable/disable the "
+                                      "mapcache");
+
     /*
      * We provide memmap properties to allow Xen to move things to other
      * addresses for example when users need to accomodate the memory-map
@@ -377,6 +480,13 @@ do {                                                                      \
 #endif
 }
 
+static void xen_pvh_instance_init(Object *obj)
+{
+    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
+
+    xp->cfg.mapcache = true;
+}
+
 static void xen_pvh_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -395,6 +505,7 @@ static const TypeInfo xen_pvh_info = {
     .parent = TYPE_MACHINE,
     .abstract = true,
     .instance_size = sizeof(XenPVHMachineState),
+    .instance_init = xen_pvh_instance_init,
     .class_size = sizeof(XenPVHMachineClass),
     .class_init = xen_pvh_class_init,
 };
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index 0ed07c5694..0209b798f3 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -84,6 +84,8 @@ struct XenPVHMachineState {
         /* PCI */
         MemMapEntry pci_ecam, pci_mmio, pci_mmio_high;
         uint32_t pci_intx_irq_base;
+
+        bool mapcache;
     } cfg;
 };
 
-- 
2.43.0


