Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F31E87847
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJAS-00049p-Bs; Tue, 03 Feb 2026 11:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnJAQ-00048m-FB
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:22:18 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnJAO-0008F2-F3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:22:18 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CA2CF596A13;
 Tue, 03 Feb 2026 17:22:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Ku-yqt5JREMP; Tue,  3 Feb 2026 17:22:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B9E9D5969FA; Tue, 03 Feb 2026 17:22:11 +0100 (CET)
Message-ID: <0cf39eb5f0feff66c9a775b3502a4e0ba4cf63cc.1770131168.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770131168.git.balaton@eik.bme.hu>
References: <cover.1770131168.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 1/7] hw/display/{cg3,tcx}: Do not use
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
Date: Tue, 03 Feb 2026 17:22:11 +0100 (CET)
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

We could simply convert these to use memory_region_init_rom but that
would be a migration compatibility break so preserve current behaviour
for now.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/cg3.c | 6 ++++--
 hw/display/tcx.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 568d6048a6..44966e7586 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -282,8 +282,10 @@ static void cg3_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CG3State *s = CG3(obj);
 
-    memory_region_init_rom_nomigrate(&s->rom, obj, "cg3.prom",
-                                     FCODE_MAX_ROM_SIZE, &error_fatal);
+    memory_region_init_ram_flags_nomigrate(&s->rom, obj, "cg3.prom",
+                                           FCODE_MAX_ROM_SIZE, 0,
+                                           &error_fatal);
+    memory_region_set_readonly(&s->rom, true);
     sysbus_init_mmio(sbd, &s->rom);
 
     memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 36cad82abd..87fe7216ba 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -756,8 +756,10 @@ static void tcx_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     TCXState *s = TCX(obj);
 
-    memory_region_init_rom_nomigrate(&s->rom, obj, "tcx.prom",
-                                     FCODE_MAX_ROM_SIZE, &error_fatal);
+    memory_region_init_ram_flags_nomigrate(&s->rom, obj, "tcx.prom",
+                                           FCODE_MAX_ROM_SIZE, 0,
+                                           &error_fatal);
+    memory_region_set_readonly(&s->rom, true);
     sysbus_init_mmio(sbd, &s->rom);
 
     /* 2/STIP : Stippler */
-- 
2.41.3


