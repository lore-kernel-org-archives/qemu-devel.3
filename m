Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC873EA794F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnw5-0002d9-TK; Wed, 04 Feb 2026 20:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnw3-0002br-4k
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:31 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnvy-0002zn-1V
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6DA29596E98;
 Thu, 05 Feb 2026 02:13:23 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id CY6VZU7uCEcA; Thu,  5 Feb 2026 02:13:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A351596ABF; Thu, 05 Feb 2026 02:13:21 +0100 (CET)
Message-ID: <f6eedb528b9c3e6f2d13cf62b4a90a98e310a236.1770253186.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770253186.git.balaton@eik.bme.hu>
References: <cover.1770253186.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 3/8] sun4m,sun4u,tcx: Do not use
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
Date: Thu, 05 Feb 2026 02:13:21 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We could simply convert these to use memory_region_init_ram but that
would be a migration compatibility break so preserve current behaviour
for now and use memory_region_init_ram_flags_nomigrate instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/tcx.c   |  5 +++--
 hw/sparc/sun4m.c   | 15 +++++++++------
 hw/sparc64/sun4u.c |  9 +++++----
 3 files changed, 17 insertions(+), 12 deletions(-)

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
-- 
2.41.3


