Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E4FEA7950
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnw5-0002d7-RT; Wed, 04 Feb 2026 20:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnw3-0002bs-5L
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:31 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnvy-000303-1Y
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 72C4C596EA1;
 Thu, 05 Feb 2026 02:13:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Ot4PTj9ryf0W; Thu,  5 Feb 2026 02:13:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 756AA596E8E; Thu, 05 Feb 2026 02:13:22 +0100 (CET)
Message-ID: <6529db430b0d928813d54e976b81c61e06bfc530.1770253186.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770253186.git.balaton@eik.bme.hu>
References: <cover.1770253186.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 4/8] memory: Remove memory_region_init_ram_nomigrate()
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
Date: Thu, 05 Feb 2026 02:13:22 +0100 (CET)
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

This is rarely needed and we can use
memory_region_init_ram_flags_nomigrate() instead which is now the only
nomigrate variant left.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/devel/memory.rst                         |  8 +++----
 hw/display/vga.c                              |  4 ++--
 hw/xtensa/xtfpga.c                            |  4 ++--
 include/system/memory.h                       | 23 -------------------
 .../memory-region-housekeeping.cocci          | 19 ---------------
 system/memory.c                               | 13 ++---------
 6 files changed, 9 insertions(+), 62 deletions(-)

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
index e45703141a..b23647a3d8 100644
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
@@ -52,23 +46,10 @@ expression ALIAS, E5, E6, E7, E8;
 -  memory_region_set_readonly(ALIAS, true);
 
 
-// Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
-// code sequences with use of the new memory_region_init_ram function.
-// Similarly for the _rom and _rom_device functions.
 // We don't try to replace sequences with a non-NULL owner, because
 // there are none in the tree that can be automatically converted
 // (and only a handful that can be manually converted).
 @@
-expression MR;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
--memory_region_init_ram_nomigrate(MR, NULL, NAME, SIZE, ERRP);
-+memory_region_init_ram(MR, NULL, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-@@
 typedef DeviceState;
 identifier device_fn, dev, obj;
 expression E1, E2, E3, E4, E5;
diff --git a/system/memory.c b/system/memory.c
index 65042bd9fa..e15f931a8a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1579,16 +1579,6 @@ void memory_region_init_io(MemoryRegion *mr,
     memory_region_set_ops(mr, ops, opaque);
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
@@ -3695,7 +3685,8 @@ bool memory_region_init_ram(MemoryRegion *mr,
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


