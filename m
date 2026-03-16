Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447F9F506CC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fF-0000kZ-St; Mon, 16 Mar 2026 09:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w27ev-0000i6-FT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w27es-0003Vo-Li
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6ED315969F9;
 Mon, 16 Mar 2026 14:06:53 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id IomEYknnNYeo; Mon, 16 Mar 2026 14:06:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5C8735968DE; Mon, 16 Mar 2026 14:06:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/display/tcx: Init memory regions in realize
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Message-Id: <20260316130651.5C8735968DE@zero.eik.bme.hu>
Date: Mon, 16 Mar 2026 14:06:51 +0100 (CET)
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

Due to aux-ram-share property qemu_ram_alloc_internal dereferences
current_machine which is not set during init when inspecting the
device. This causes the qtest/device-introspect-test to fail since a
recent change to use memory_region_init_rom instead of global vmstate.
Fix it by removing the init method and move memory region creation in
realize.

Fixes: 653c4fa5b0 hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate
Reported by: Thomas Huth <thuth@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/tcx.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index c8a4ac21ca..ea92a48400 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -751,10 +751,15 @@ static const GraphicHwOps tcx24_ops = {
     .gfx_update = tcx24_update_display,
 };
 
-static void tcx_initfn(Object *obj)
+static void tcx_realize(DeviceState *dev, Error **errp)
 {
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    TCXState *s = TCX(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    TCXState *s = TCX(dev);
+    Object *obj = OBJECT(dev);
+    ram_addr_t vram_offset = 0;
+    int size, ret;
+    uint8_t *vram_base;
+    char *fcode_filename;
 
     memory_region_init_rom(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
                            &error_fatal);
@@ -804,16 +809,6 @@ static void tcx_initfn(Object *obj)
     memory_region_init_io(&s->alt, obj, &tcx_dummy_ops, s, "tcx.alt",
                           TCX_ALT_NREGS);
     sysbus_init_mmio(sbd, &s->alt);
-}
-
-static void tcx_realizefn(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    TCXState *s = TCX(dev);
-    ram_addr_t vram_offset = 0;
-    int size, ret;
-    uint8_t *vram_base;
-    char *fcode_filename;
 
     memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
                            s->vram_size * (1 + 4 + 4), &error_fatal);
@@ -887,7 +882,7 @@ static void tcx_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = tcx_realizefn;
+    dc->realize = tcx_realize;
     device_class_set_legacy_reset(dc, tcx_reset);
     dc->vmsd = &vmstate_tcx;
     device_class_set_props(dc, tcx_properties);
@@ -897,7 +892,6 @@ static const TypeInfo tcx_info = {
     .name          = TYPE_TCX,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(TCXState),
-    .instance_init = tcx_initfn,
     .class_init    = tcx_class_init,
 };
 
-- 
2.41.3


