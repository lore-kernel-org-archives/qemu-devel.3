Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA50AFF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DH2-000153-K5; Mon, 30 Mar 2026 10:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7DGj-000117-DF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:07:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7DGe-0005uA-Kr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:07:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F7DB5969F3;
 Mon, 30 Mar 2026 16:06:57 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 3L3Pt2g-NIfL; Mon, 30 Mar 2026 16:06:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 31EC55968DE; Mon, 30 Mar 2026 16:06:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [RFC PATCH] cirrus-vga: Add property to set frame buffer endianness
 and make it default to little endian
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <20260330140655.31EC55968DE@zero.eik.bme.hu>
Date: Mon, 30 Mar 2026 16:06:55 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

I've tried this but it does not seem to work and leaves default to
auto. Could somebody tell how this should work?

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/core/machine.c                | 2 ++
 hw/display/cirrus_vga.c          | 6 ++++++
 hw/display/cirrus_vga_internal.h | 2 ++
 hw/display/cirrus_vga_isa.c      | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e9..e573ef46bc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,8 @@
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
     { "isa-cirrus-vga", "global-vmstate", "true" },
+    { "isa-cirrus-vga", "x-big-endian-fb", "off" },
+    { "cirrus-vga", "x-big-endian-fb", "off" },
 };
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 629b34fc68..e379f125ae 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2930,6 +2930,10 @@ void cirrus_init_common(CirrusVGAState *s, Object *owner,
     s->vga.cursor_invalidate = cirrus_cursor_invalidate;
     s->vga.cursor_draw_line = cirrus_cursor_draw_line;
 
+    if (s->big_endian_fb != ON_OFF_AUTO_AUTO) {
+        s->vga.big_endian_fb = (s->big_endian_fb == ON_OFF_AUTO_ON);
+    }
+
     qemu_register_reset(cirrus_reset, s);
 }
 
@@ -2987,6 +2991,8 @@ static const Property pci_vga_cirrus_properties[] = {
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
                      cirrus_vga.enable_blitter, true),
+    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct PCICirrusVGAState,
+                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_AUTO),
 };
 
 static void cirrus_vga_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/cirrus_vga_internal.h b/hw/display/cirrus_vga_internal.h
index a78ebbd920..7c07201f18 100644
--- a/hw/display/cirrus_vga_internal.h
+++ b/hw/display/cirrus_vga_internal.h
@@ -26,6 +26,7 @@
 #ifndef CIRRUS_VGA_INTERNAL_H
 #define CIRRUS_VGA_INTERNAL_H
 
+#include "hw/core/qdev-properties.h"
 #include "vga_int.h"
 
 /* IDs */
@@ -94,6 +95,7 @@ typedef struct CirrusVGAState {
     int real_vram_size; /* XXX: suppress that */
     int device_id;
     int bustype;
+    OnOffAuto big_endian_fb;
 } CirrusVGAState;
 
 void cirrus_init_common(CirrusVGAState *s, Object *owner,
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 76034a8860..c2b0b61476 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -75,6 +75,8 @@ static const Property isa_cirrus_vga_properties[] = {
                      cirrus_vga.enable_blitter, true),
     DEFINE_PROP_BOOL("global-vmstate", struct ISACirrusVGAState,
                      cirrus_vga.vga.global_vmstate, false),
+    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct PCICirrusVGAState,
+                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_AUTO),
 };
 
 static void isa_cirrus_vga_class_init(ObjectClass *klass, const void *data)
-- 
2.41.3


