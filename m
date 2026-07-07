Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADE2C44502
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0fy-00071R-N7; Tue, 07 Jul 2026 03:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fw-00071D-MP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:57:04 -0400
Received: from web05.whitelabeldomein.nl ([2a09:8b00:300:8::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fv-0002eU-7H
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rclobus.nl; 
 s=x;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=92dcM35brlxyjaSQlzwJ14FX8eHjidXEe8ezfnOPVHo=; b=RmJQcrcNw1QM0NBkRtUrDJtdni
 J4pDscl/GtTELqHs8udjR2WbZvaVg9msSVsztlKD20RG7xnBxDz/HXEprQEBLqMBhpm70og28hZJR
 A7QoXttMEOt5O7fy0wfrYY2RJjAFJlphPdl3Hv5MmXErv2ay3KKABRHpmxpVfhctwI1eS5la2yEy/
 ++P4J2+0+3QAx/rYhYjooXVVRBmiDBpVtZjchEjRO9kdK8OhPcMVzSVOlNvdBVWAHFNTexqmTi/r0
 xZjlwVtQi7diw25YrrkKgcZkg1YiB8AbB5t+4QFPV5xCyO9vBDvxnjsniEStGyLAJoXbSxb32maaX
 lp91+5aw==;
Received: from p4fe11eec.dip0.t-ipconnect.de ([79.225.30.236] helo=silent.lan)
 by web05.whitelabeldomein.nl with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <rclobus@rclobus.nl>) id 1wh0ft-0000000Cnb2-4BXq;
 Tue, 07 Jul 2026 09:57:02 +0200
From: Roland Clobus <rclobus@rclobus.nl>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Roland Clobus <rclobus@rclobus.nl>
Subject: [PATCH v2 4/5] virtio-gpu: Allow the first display to be disabled
Date: Tue,  7 Jul 2026 09:47:59 +0200
Message-ID: <20260707075536.126865-4-rclobus@rclobus.nl>
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

Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
---

Tested with
-device '{"driver":"virtio-vga-gl", "max_outputs":2, "id":"vga001", "outputs":[ { "vendor": "IVM", "name":"AAA", "serial": "Wow42", "widthmm": 40, "heightmm": 30, "xres": 0, "yres": 0, "xmax": 2048, "ymax": 1536, "refreshrate": 50000 }, { "vendor": "RHT", "name":"BBB", "serial": "43", "widthmm": 1000, "heightmm": 750, "xres": 1024, "yres": 768, "xmax": 800, "ymax": 600, "refreshrate": 60000 } ]}'
---

 hw/display/virtio-gpu-base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 41f69a6ca7..a55481ec3a 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -257,8 +257,6 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
         virtio_add_queue(vdev, 16, cursor_cb);
     }
 
-    g->enabled_output_bitmask = 1;
-
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
@@ -270,7 +268,9 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
             g->req_state[output_idx].height_mm = node->value->heightmm;
         }
         if (node->value->has_xres && node->value->has_yres) {
-            g->enabled_output_bitmask |= (1 << output_idx);
+            if (node->value->xres != 0 && node->value->yres != 0) {
+                g->enabled_output_bitmask |= (1 << output_idx);
+            }
             g->req_state[output_idx].width = node->value->xres;
             g->req_state[output_idx].height = node->value->yres;
         }
@@ -279,6 +279,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
         }
     }
 
+    if (!g->enabled_output_bitmask) {
+        g->enabled_output_bitmask = 1;
+    }
+
     g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =
-- 
2.53.0


