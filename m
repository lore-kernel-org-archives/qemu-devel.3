Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B05E88D80
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 11:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ywU-0005jJ-9I; Sat, 04 Apr 2026 07:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w8ywR-0005iw-BY
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:13:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w8ywO-0005Be-ND
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:13:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 93117596A24;
 Sat, 04 Apr 2026 13:13:20 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id de0JMRN6WmMP; Sat,  4 Apr 2026 13:13:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8334E596A22; Sat, 04 Apr 2026 13:13:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ati-vga: Fix pitch and offset registers mask
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260404111318.8334E596A22@zero.eik.bme.hu>
Date: Sat, 04 Apr 2026 13:13:18 +0200 (CEST)
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

Remove the Radeon specific masks for offset and pitch registers. While
the documentation is not clear about it I believe it is a copy&paste
error from the combined DST_PITCH_OFFSET register that has less bits
so more constrained than the individual registers which should not
have this mask.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 07c0961b61..5ca1912340 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -835,18 +835,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         ati_cursor_define(s);
         break;
     case DST_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.dst_offset = data & 0xfffffff0;
-        } else {
-            s->regs.dst_offset = data & 0xfffffc00;
-        }
         break;
     case DST_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.dst_pitch = data & 0x3fff;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.dst_tile = (data >> 16) & 1;
-        } else {
-            s->regs.dst_pitch = data & 0x3ff0;
         }
         break;
     case DST_TILE:
@@ -956,18 +950,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dst_height = (data >> 16) & 0x3fff;
         break;
     case SRC_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.src_offset = data & 0xfffffff0;
-        } else {
-            s->regs.src_offset = data & 0xfffffc00;
-        }
         break;
     case SRC_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.src_pitch = data & 0x3fff;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.src_tile = (data >> 16) & 1;
-        } else {
-            s->regs.src_pitch = data & 0x3ff0;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.41.3


