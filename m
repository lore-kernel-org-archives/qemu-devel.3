Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C21061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7JPN-0002Ji-3s; Mon, 30 Mar 2026 16:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7JPJ-0002JE-DU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:40:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7JPH-0005bE-KJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:40:21 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A3E685969F9;
 Mon, 30 Mar 2026 22:40:17 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id H5jHS2q5AjBL; Mon, 30 Mar 2026 22:40:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 963A85969EC; Mon, 30 Mar 2026 22:40:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] cirrus-vga: Make frame buffer endianness little endian by
 default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <20260330204015.963A85969EC@zero.eik.bme.hu>
Date: Mon, 30 Mar 2026 22:40:15 +0200 (CEST)
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

VGA is usually little endian but in QEMU frame buffer defaults to
target endianness. Add a property to allow users to override the
default in case this change breaks something and make cirrus-vga
little endian by default to match the real chip. This should be safe
as cirrus-vga is not used by default on any machines.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/core/machine.c                | 2 ++
 hw/display/cirrus_vga.c          | 6 ++++++
 hw/display/cirrus_vga_internal.h | 2 ++
 hw/display/cirrus_vga_isa.c      | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e9..76d3f78a51 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,8 @@
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
     { "isa-cirrus-vga", "global-vmstate", "true" },
+    { "isa-cirrus-vga", "x-big-endian-fb", "auto" },
+    { "cirrus-vga", "x-big-endian-fb", "auto" },
 };
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 629b34fc68..d56ca01e6d 100644
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
+                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_OFF),
 };
 
 static void cirrus_vga_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/cirrus_vga_internal.h b/hw/display/cirrus_vga_internal.h
index a78ebbd920..4813c40de3 100644
--- a/hw/display/cirrus_vga_internal.h
+++ b/hw/display/cirrus_vga_internal.h
@@ -26,6 +26,7 @@
 #ifndef CIRRUS_VGA_INTERNAL_H
 #define CIRRUS_VGA_INTERNAL_H
 
+#include "qapi/qapi-types-common.h"
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
index 76034a8860..01144bb9e9 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -75,6 +75,8 @@ static const Property isa_cirrus_vga_properties[] = {
                      cirrus_vga.enable_blitter, true),
     DEFINE_PROP_BOOL("global-vmstate", struct ISACirrusVGAState,
                      cirrus_vga.vga.global_vmstate, false),
+    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct ISACirrusVGAState,
+                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_OFF),
 };
 
 static void isa_cirrus_vga_class_init(ObjectClass *klass, const void *data)
-- 
2.41.3


