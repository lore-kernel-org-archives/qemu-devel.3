Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6340AF513ED
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 01:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyKBZ-0008IU-3v; Thu, 05 Mar 2026 20:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBX-0008Hy-Is
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:40:59 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBV-0006ED-Qx
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:40:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B6445596DA4;
 Fri, 06 Mar 2026 02:40:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id YE5wm4bxLcVe; Fri,  6 Mar 2026 02:40:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 834BC596D9B; Fri, 06 Mar 2026 02:40:53 +0100 (CET)
Message-ID: <cf090a57b03b8c21a56772d90f8b1934ae32a64d.1772760714.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772760714.git.balaton@eik.bme.hu>
References: <cover.1772760714.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v8 1/8] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
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
Date: Fri, 06 Mar 2026 02:40:53 +0100 (CET)
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

Use memory_region_init_rom() instead which is what other devices do.
This breaks migration but these devices are only used by sparc Sun
machines which have no migration compatibility guarantee.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/cg3.c | 5 ++---
 hw/display/tcx.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 568d6048a6..61bdb0552e 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -282,8 +282,8 @@ static void cg3_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CG3State *s = CG3(obj);
 
-    memory_region_init_rom_nomigrate(&s->rom, obj, "cg3.prom",
-                                     FCODE_MAX_ROM_SIZE, &error_fatal);
+    memory_region_init_rom(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
+                           &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
 
     memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
@@ -299,7 +299,6 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
     char *fcode_filename;
 
     /* FCode ROM */
-    vmstate_register_ram_global(&s->rom);
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, CG3_ROM_FILE);
     if (fcode_filename) {
         ret = load_image_mr(fcode_filename, &s->rom);
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 36cad82abd..16114b9bb8 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -756,8 +756,8 @@ static void tcx_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     TCXState *s = TCX(obj);
 
-    memory_region_init_rom_nomigrate(&s->rom, obj, "tcx.prom",
-                                     FCODE_MAX_ROM_SIZE, &error_fatal);
+    memory_region_init_rom(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
+                           &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
 
     /* 2/STIP : Stippler */
@@ -822,7 +822,6 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     vram_base = memory_region_get_ram_ptr(&s->vram_mem);
 
     /* 10/ROM : FCode ROM */
-    vmstate_register_ram_global(&s->rom);
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, TCX_ROM_FILE);
     if (fcode_filename) {
         ret = load_image_mr(fcode_filename, &s->rom);
-- 
2.41.3


