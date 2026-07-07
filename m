Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBD6C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0g6-00072n-Fj; Tue, 07 Jul 2026 03:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0g5-00072Y-HQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:57:13 -0400
Received: from web05.whitelabeldomein.nl ([2a09:8b00:300:8::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0g3-0002ez-R9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rclobus.nl; 
 s=x;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FOa9Zlmc8e8g6u6BPY9ef9DGCA6PJZEq8lqhzHeQyuA=; b=CxY1A4Tgc5lb4REQN7KdgCBrDG
 xFXMpLOndoXm+sbABjUStDn930MvLMvMSRSQEa/0nAg4hsqkxvxbq6N7sdkvnsOcsx7pKN0zZ/2E4
 lTupkjP93/dXVhLRs0WdBfgbB4HZPLYlP8IOxWLZdkywAiJgnt8im7qJEKJq/pi0AOpMWe4G9iwYj
 t/NRK78JgGTjPxuhjS/3jwfQGvY6rRLegcQ9C6fXortFHhg5hqBRA11oWQC2I70i6MCtP09IsWtxX
 /PqPGA8WGuXs/5Og4Luuth6gKa/qwfEceWdUd2DpKeu7m3rbb3uRIX+zEtJc7MWk21syrj4W7NDF3
 WfBLvpfA==;
Received: from p4fe11eec.dip0.t-ipconnect.de ([79.225.30.236] helo=silent.lan)
 by web05.whitelabeldomein.nl with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <rclobus@rclobus.nl>) id 1wh0g2-0000000Cnb2-35e0;
 Tue, 07 Jul 2026 09:57:10 +0200
From: Roland Clobus <rclobus@rclobus.nl>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Roland Clobus <rclobus@rclobus.nl>
Subject: [PATCH v2 5/5] DRAFT virtio-gpu: Enable/disable displays
Date: Tue,  7 Jul 2026 09:48:00 +0200
Message-ID: <20260707075536.126865-5-rclobus@rclobus.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707075536.126865-1-rclobus@rclobus.nl>
References: <20260707075536.126865-1-rclobus@rclobus.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: rclobus@rclobus.nl
Received-SPF: pass client-ip=2a09:8b00:300:8::10;
 envelope-from=rclobus@rclobus.nl; helo=web05.whitelabeldomein.nl
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Need help: the viewer only shows 'Display output is not active.' after
either a) the qom-set is issued again or b) the viewer is resized

I think that the communication with viewer and qemu is not correct, the
event 'virtio_notify_config' is perhaps not the correct event, or it is
sent at the wrong moment.

Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
---

Tested with:
-device '{"driver":"virtio-vga-gl", "max_outputs":2, "id":"vga001", "outputs":[ { "vendor": "IVM", "name":"AAA", "serial": "Wow42", "widthmm": 40, "heightmm": 30, "xres": 0, "yres": 0, "xmax": 2048, "ymax": 1536, "refreshrate": 50000 }, { "vendor": "RHT", "name":"BBB", "serial": "43", "widthmm": 1000, "heightmm": 750, "xres": 1024, "yres": 768, "xmax": 800, "ymax": 600, "refreshrate": 60000 } ]}'

And then:
Activate 2 displays:
qom-set -j /machine/peripheral/vga001 outputs [ { "yres": 768, "name": "AAA", "widthmm": 40, "serial": "42", "heightmm": 30, "vendor": "IVM", "xmax": 2048, "ymax": 1536, "refreshrate": 50000, "xres": 1024 }, { "yres": 600, "name": "EEE", "widthmm": 1000, "serial": "43", "heightmm": 750, "vendor": "RHT", "xmax": 1024, "ymax": 768, "refreshrate": 60000, "xres": 800 } ]

Disable display 2:
qom-set -j /machine/peripheral/vga001 outputs [ { "yres": 768, "name": "AAA", "widthmm": 40, "serial": "42", "heightmm": 30, "vendor": "IVM", "xmax": 2048, "ymax": 1536, "refreshrate": 50000, "xres": 1024 }, { "yres": 0, "name": "DDD", "widthmm": 1000, "serial": "43", "heightmm": 750, "vendor": "RHT", "xmax": 1024, "ymax": 768, "refreshrate": 60000, "xres": 0 } ]

Disable display 1:
qom-set -j /machine/peripheral/vga001 outputs [ { "yres": 0, "name": "AAA", "widthmm": 40, "serial": "42", "heightmm": 30, "vendor": "IVM", "xmax": 2048, "ymax": 1536, "refreshrate": 50000, "xres": 0 }, { "yres": 600, "name": "DDD", "widthmm": 1000, "serial": "43", "heightmm": 750, "vendor": "RHT", "xmax": 1024, "ymax": 768, "refreshrate": 60000, "xres": 800 } ]

The displays are correctly enabled/disabled, as can be seen in the
'Displays' settings of GNOME, but the viewer (virt-viewer) only shows
'Displays is not active' after the qom-set is issued for the second
time, or when the display is resized.
---
 hw/display/virtio-gpu-base.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index a55481ec3a..007a40bc42 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -92,15 +92,28 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
         // The provided resolution will be used only once after it has been set.
         // After that, the viewer has precedence over these settings
         // and decides about the resolution.
+        bool resolution_set = false;
         if (node->value->has_xres) {
             info.prefx = node->value->xres;
             g->req_state[scanout].width = node->value->xres;
             node->value->has_xres = 0;
+            resolution_set = true;
         }
         if (node->value->has_yres) {
             info.prefy = node->value->yres;
             g->req_state[scanout].height = node->value->yres;
             node->value->has_yres = 0;
+            resolution_set = true;
+        }
+        if (resolution_set) {
+            // Enable/disable the display if needed
+            if (info.prefx && info.prefy) {
+                g->enabled_output_bitmask |= (1 << scanout);
+            } else {
+                g->enabled_output_bitmask &= ~(1 << scanout);
+                dpy_gfx_replace_surface(g->scanout[scanout].con, NULL);
+                /* NEED HELP: dpy_gfx_replace_surface(g->scanout[scanout].con, NULL); only works after the qom-set is issued again */
+            }
         }
         if (node->value->has_xmax) {
             info.maxx = node->value->xmax;
@@ -151,12 +164,10 @@ static void virtio_gpu_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
     g->req_state[idx].width_mm = info->width_mm;
     g->req_state[idx].height_mm = info->height_mm;
 
-    if (info->width && info->height) {
-        g->enabled_output_bitmask |= (1 << idx);
-    } else {
-        g->enabled_output_bitmask &= ~(1 << idx);
+    if (!(g->enabled_output_bitmask & (1 << idx))) {
+        /* NEED HELP: This only shows that the display is not active, when the viewer is resized */
+        dpy_gfx_replace_surface(g->scanout[idx].con, NULL);
     }
-
     /* send event to guest */
     virtio_gpu_notify_event(g, VIRTIO_GPU_EVENT_DISPLAY);
 }
-- 
2.53.0


