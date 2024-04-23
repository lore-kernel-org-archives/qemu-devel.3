Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A55C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnD-0004lg-Hf; Tue, 23 Apr 2024 11:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHml-0004O4-Pe
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmj-00007M-TU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SadQhGVyBNGCc2yb4bNQuwqA8RB/KCwIQ9JEK7fOvIg=;
 b=QGGm8uYrl6nI0YGkSIZoJwn6TPD1RapeY9oEb4t3VouY2pcazVT2+LZFOICITzrza4V3VO
 c96ZU+TsN+wj/gIL6cTvL2YTHTmja31sDNiHd2KOcqwJROYODLzSJdnlSpIgtvWRC4NwcB
 R8aS1XkxNcnvMJ+OZR1/NGUKcPgiTgc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Hl4l0pYFMuGH13w2Oe3HiQ-1; Tue,
 23 Apr 2024 11:10:13 -0400
X-MC-Unique: Hl4l0pYFMuGH13w2Oe3HiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C613E3C23FCD
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:12 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D03B2026D0A
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/63] vga: optimize computation of dirty memory region
Date: Tue, 23 Apr 2024 17:09:07 +0200
Message-ID: <20240423150951.41600-20-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The depth == 0 and depth == 15 have to be special cased because
width * depth / 8 does not provide the correct scanline length.
However, thanks to the recent reorganization of vga_draw_graphic()
the correct value of VRAM bits per pixel is available in "bits".

Use it (via the same "bwidth" computation that is used later in
the function), thus restricting the slow path to the wraparound case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 77f59e8c113..77d709a3d69 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1574,22 +1574,16 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     /* Horizontal pel panning bit 3 is only used in text mode.  */
     hpel = bits <= 8 ? s->params.hpel & 7 : 0;
+    bwidth = DIV_ROUND_UP(width * bits, 8); /* scanline length */
+    if (hpel) {
+        bwidth += 4;
+    }
 
     region_start = (s->params.start_addr * 4);
-    region_end = region_start + (ram_addr_t)s->params.line_offset * height;
-    region_end += width * depth / 8; /* scanline length */
-    region_end -= s->params.line_offset;
-    if (hpel) {
-        region_end += 4;
-    }
-    if (region_end > s->vbe_size || depth == 0 || depth == 15) {
+    region_end = region_start + (ram_addr_t)s->params.line_offset * (height - 1) + bwidth;
+    if (region_end > s->vbe_size) {
         /*
-         * We land here on:
-         *  - wraps around (can happen with cirrus vbe modes)
-         *  - depth == 0 (256 color palette video mode)
-         *  - depth == 15
-         *
-         * Take the safe and slow route:
+         * On wrap around take the safe and slow route:
          *   - create a dirty bitmap snapshot for all vga memory.
          *   - force shadowing (so all vga memory access goes
          *     through vga_read_*() helpers).
@@ -1667,10 +1661,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
            s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
     addr1 = (s->params.start_addr * 4);
-    bwidth = DIV_ROUND_UP(width * bits, 8);
-    if (hpel) {
-        bwidth += 4;
-    }
     y_start = -1;
     d = surface_data(surface);
     linesize = surface_stride(surface);
-- 
2.44.0



