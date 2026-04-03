Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69793E8536F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fzy-0003bC-Sk; Fri, 03 Apr 2026 10:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w8fzm-0003ZF-47
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:59:39 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w8fzi-0006kl-C2
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:59:36 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 12BFE596A38;
 Fri, 03 Apr 2026 16:59:31 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Ke2oi-FZ7-vm; Fri,  3 Apr 2026 16:59:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 48877596A22; Fri, 03 Apr 2026 16:59:28 +0200 (CEST)
Message-ID: <3f54ff54a873a8f8a0cc5f14660703b4025a69e2.1775228029.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1775228029.git.balaton@eik.bme.hu>
References: <cover.1775228029.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/2] ati-vga: Update mode on CRTC_PITCH change
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 03 Apr 2026 16:59:28 +0200 (CEST)
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

When changing line length we need to update display parameters so call
mode change when changing CRTC_PITCH if the value has changed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 3976f5f01c..07c0961b61 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -758,7 +758,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.crtc_offset_cntl = data; /* FIXME */
         break;
     case CRTC_PITCH:
-        s->regs.crtc_pitch = data & 0x07ff07ff;
+        data &= 0x07ff07ff;
+        if (s->regs.crtc_pitch != data) {
+            s->regs.crtc_pitch = data;
+            ati_vga_switch_mode(s);
+        }
         break;
     case 0xf00 ... 0xfff:
         /* read-only copy of PCI config space so ignore writes */
-- 
2.41.3


