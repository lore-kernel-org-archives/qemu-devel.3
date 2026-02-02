Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4EAE7DEF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmuv8-0003Hb-1R; Mon, 02 Feb 2026 09:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vmuub-0003Er-Tz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:26 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vmuuZ-0006Vu-BB
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 67F71596EA1;
 Mon, 02 Feb 2026 15:28:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id xnk-Yc8bkz0q; Mon,  2 Feb 2026 15:28:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4C340596E8D; Mon, 02 Feb 2026 15:28:15 +0100 (CET)
Message-ID: <de8b2a167260576e63165c29a25a40c78d3e5eb9.1770042013.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770042013.git.balaton@eik.bme.hu>
References: <cover.1770042013.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 4/7] memory: Remove memory_region_init_ram_nomigrate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 02 Feb 2026 15:28:15 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This is rarely needed and those cases can use
memory_region_init_ram_flags_nomigrate() instead which is now the only
_nomigrate variant left. (Some of these may better be converted to use
memory_region_init_ram() but I don't know so left them as they are.)

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/devel/memory.rst                         |  8 +++----
 hw/display/tcx.c                              |  5 ++--
 hw/display/vga.c                              |  4 ++--
 hw/sparc/sun4m.c                              | 15 +++++++-----
 hw/sparc64/sun4u.c                            |  9 ++++----
 hw/xtensa/xtfpga.c                            |  4 ++--
 include/system/memory.h                       | 23 -------------------
 .../memory-region-housekeeping.cocci          | 18 +--------------
 system/memory.c                               | 13 ++---------
 9 files changed, 27 insertions(+), 72 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 0bb5acab21..9083b18f08 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -110,11 +110,9 @@ migrated:
 
 For most devices and boards this is the correct thing. If you
 have a special case where you need to manage the migration of
-the backing memory yourself, you can call the functions:
-
-- memory_region_init_ram_nomigrate()
-
-which only initialize the MemoryRegion and leave handling
+the backing memory yourself, you can call the function
+memory_region_init_ram_flags_nomigrate()
+which only initializes the MemoryRegion and leaves handling
 migration to the caller.
 
 The functions:
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 87fe7216ba..d6be297828 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -817,8 +817,9 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     uint8_t *vram_base;
     char *fcode_filename;
 
-    memory_region_init_ram_nomigrate(&s->vram_mem, OBJECT(s), "tcx.vram",
-                           s->vram_size * (1 + 4 + 4), &error_fatal);
+    memory_region_init_ram_flags_nomigrate(&s->vram_mem, OBJECT(s), "tcx.vram",
+                                           s->vram_size * (1 + 4 + 4), 0,
+                                           &error_fatal);
     vmstate_register_ram_global(&s->vram_mem);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
     vram_base = memory_region_get_ram_ptr(&s->vram_mem);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 59a65cbbff..ee7d97b5c2 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2235,8 +2235,8 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
         return false;
     }
 
-    memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
-                                     &local_err);
+    memory_region_init_ram_flags_nomigrate(&s->vram, obj, "vga.vram",
+                                           s->vram_size, 0, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return false;
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0c0d658d30..66a21ae86c 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -587,8 +587,10 @@ static void idreg_realize(DeviceState *ds, Error **errp)
     IDRegState *s = MACIO_ID_REGISTER(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.idreg",
-                                          sizeof(idreg_data), errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(&s->mem, OBJECT(ds),
+                                                "sun4m.idreg",
+                                                sizeof(idreg_data),
+                                                0, errp)) {
         return;
     }
 
@@ -638,8 +640,8 @@ static void afx_realize(DeviceState *ds, Error **errp)
     AFXState *s = TCX_AFX(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx",
-                                          4, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(&s->mem, OBJECT(ds),
+                                                "sun4m.afx", 4, 0, errp)) {
         return;
     }
 
@@ -719,8 +721,9 @@ static void prom_realize(DeviceState *ds, Error **errp)
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4m.prom",
-                                          PROM_SIZE_MAX, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(&s->prom, OBJECT(ds),
+                                                "sun4m.prom", PROM_SIZE_MAX, 0,
+                                                errp)) {
         return;
     }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5d7787fc1a..0da0eef74c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -455,8 +455,9 @@ static void prom_realize(DeviceState *ds, Error **errp)
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
-                                          PROM_SIZE_MAX, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(&s->prom, OBJECT(ds),
+                                                "sun4u.prom", PROM_SIZE_MAX, 0,
+                                                errp)) {
         return;
     }
 
@@ -498,8 +499,8 @@ static void ram_realize(DeviceState *dev, Error **errp)
     RamDevice *d = SUN4U_RAM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_init_ram_nomigrate(&d->ram, OBJECT(d), "sun4u.ram", d->size,
-                           &error_fatal);
+    memory_region_init_ram_flags_nomigrate(&d->ram, OBJECT(d), "sun4u.ram",
+                                           d->size, 0, &error_fatal);
     vmstate_register_ram_global(&d->ram);
     sysbus_init_mmio(sbd, &d->ram);
 }
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d427d68e50..b025cc53a8 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -163,8 +163,8 @@ static void xtfpga_net_init(MemoryRegion *address_space,
             sysbus_mmio_get_region(s, 1));
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
-                           &error_fatal);
+    memory_region_init_ram_flags_nomigrate(ram, OBJECT(s), "open_eth.ram",
+                                           16 * KiB, 0, &error_fatal);
     vmstate_register_ram_global(ram);
     memory_region_add_subregion(address_space, buffers, ram);
 }
diff --git a/include/system/memory.h b/include/system/memory.h
index 7117699b10..d4793a08a7 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1374,29 +1374,6 @@ void memory_region_init_io(MemoryRegion *mr,
                            const char *name,
                            uint64_t size);
 
-/**
- * memory_region_init_ram_nomigrate:  Initialize RAM memory region.  Accesses
- *                                    into the region will modify memory
- *                                    directly.
- *
- * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
- * @name: Region name, becomes part of RAMBlock name used in migration stream
- *        must be unique within any device
- * @size: size of the region.
- * @errp: pointer to Error*, to store an error if it happens.
- *
- * Note that this function does not do anything to cause the data in the
- * RAM memory region to be migrated; that is the responsibility of the caller.
- *
- * Return: true on success, else false setting @errp with error.
- */
-bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp);
-
 /**
  * memory_region_init_ram_flags_nomigrate:  Initialize RAM memory region.
  *                                          Accesses into the region will
diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 8ec9a06c18..40a8f7beb1 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -26,15 +26,9 @@ symbol true;
 expression E1, E2, E3, E4, E5;
 position p;
 @@
-(
   memory_region_init_ram@p(E1, E2, E3, E4, E5);
   ...
   memory_region_set_readonly(E1, true);
-|
-  memory_region_init_ram_nomigrate@p(E1, E2, E3, E4, E5);
-  ...
-  memory_region_set_readonly(E1, true);
-)
 @script:python@
 p << possible_memory_region_init_rom.p;
 @@
@@ -52,7 +46,7 @@ expression ALIAS, E5, E6, E7, E8;
 -  memory_region_set_readonly(ALIAS, true);
 
 
-// Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
+// Replace by-hand memory_region_init_ram/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
 // We don't try to replace sequences with a non-NULL owner, because
@@ -64,16 +58,6 @@ expression NAME;
 expression SIZE;
 expression ERRP;
 @@
--memory_region_init_ram_nomigrate(MR, NULL, NAME, SIZE, ERRP);
-+memory_region_init_ram(MR, NULL, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-@@
-expression MR;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
 expression MR;
 expression OPS;
 expression OPAQUE;
diff --git a/system/memory.c b/system/memory.c
index b2b00ba7b4..921e96554b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1572,16 +1572,6 @@ void memory_region_init_io(MemoryRegion *mr,
     mr->terminates = true;
 }
 
-bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp)
-{
-    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                  size, 0, errp);
-}
-
 bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
                                             Object *owner,
                                             const char *name,
@@ -3690,7 +3680,8 @@ bool memory_region_init_ram(MemoryRegion *mr,
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
+                                                size, 0, errp)) {
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.3


