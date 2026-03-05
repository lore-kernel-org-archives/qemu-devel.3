Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C0FF33A71
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9Wl-00084d-So; Thu, 05 Mar 2026 09:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vy9We-00083f-Rb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:18:06 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vy9Wc-0000t7-82
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:18:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 14FC1596D94;
 Thu, 05 Mar 2026 15:18:01 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id vO5UYK6h8l1z; Thu,  5 Mar 2026 15:17:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 57E59596DA3; Thu, 05 Mar 2026 15:17:58 +0100 (CET)
Message-ID: <5a9141b551749832964422d3df74045ee04a4ff6.1772719690.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772719690.git.balaton@eik.bme.hu>
References: <cover.1772719690.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 3/9] sun4m,sun4u,tcx: Do not use
 memory_region_init_ram_nomigrate()
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
Date: Thu, 05 Mar 2026 15:17:58 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Convert to use memory_region_init_{ram,rom} instead. This breaks
migration but these machines have no migration compatibility guarantee
and this removes most remaining usages of this nomigrate variant.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/tcx.c   |  3 +--
 hw/sparc/sun4m.c   | 19 +++++--------------
 hw/sparc64/sun4u.c | 10 +++-------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 16114b9bb8..c8a4ac21ca 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -815,9 +815,8 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     uint8_t *vram_base;
     char *fcode_filename;
 
-    memory_region_init_ram_nomigrate(&s->vram_mem, OBJECT(s), "tcx.vram",
+    memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
                            s->vram_size * (1 + 4 + 4), &error_fatal);
-    vmstate_register_ram_global(&s->vram_mem);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
     vram_base = memory_region_get_ram_ptr(&s->vram_mem);
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a17bdb3692..47853e3f76 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -587,13 +587,10 @@ static void idreg_realize(DeviceState *ds, Error **errp)
     IDRegState *s = MACIO_ID_REGISTER(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.idreg",
-                                          sizeof(idreg_data), errp)) {
+    if (!memory_region_init_rom(&s->mem, OBJECT(ds), "sun4m.idreg",
+                                sizeof(idreg_data), errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->mem);
-    memory_region_set_readonly(&s->mem, true);
     sysbus_init_mmio(dev, &s->mem);
 }
 
@@ -638,12 +635,9 @@ static void afx_realize(DeviceState *ds, Error **errp)
     AFXState *s = TCX_AFX(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx",
-                                          4, errp)) {
+    if (!memory_region_init_ram(&s->mem, OBJECT(ds), "sun4m.afx", 4, errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->mem);
     sysbus_init_mmio(dev, &s->mem);
 }
 
@@ -719,13 +713,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4m.prom",
-                                          PROM_SIZE_MAX, errp)) {
+    if (!memory_region_init_rom(&s->prom, OBJECT(ds), "sun4m.prom",
+                                PROM_SIZE_MAX, errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->prom);
-    memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
 }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b8bda1eb81..2e41785b78 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -455,13 +455,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
-                                          PROM_SIZE_MAX, errp)) {
+    if (!memory_region_init_rom(&s->prom, OBJECT(ds), "sun4u.prom",
+                                PROM_SIZE_MAX, errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->prom);
-    memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
 }
 
@@ -498,9 +495,8 @@ static void ram_realize(DeviceState *dev, Error **errp)
     RamDevice *d = SUN4U_RAM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_init_ram_nomigrate(&d->ram, OBJECT(d), "sun4u.ram", d->size,
+    memory_region_init_ram(&d->ram, OBJECT(d), "sun4u.ram", d->size,
                            &error_fatal);
-    vmstate_register_ram_global(&d->ram);
     sysbus_init_mmio(sbd, &d->ram);
 }
 
-- 
2.41.3


