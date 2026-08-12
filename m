Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42691C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAM0-0001Lz-9x; Wed, 12 Aug 2026 10:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALH-0007fF-Sk; Wed, 12 Aug 2026 10:54:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALE-0007LE-Uh; Wed, 12 Aug 2026 10:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=pfPDvsxrBjk1+eHGRNmnYN8pjxUpUBTL1gQEooEzi5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kPinISBt3zUS4QIH5AFC8rrdcbtEJPH5JSA0IUIyjY5CdULmta4nU503qoNnx0G7p
 3FsA+obAjBz6Nn8+DT+czAytSFfHlYl4k67FWm78VCp+qDCbvKjHjEtmps4UHfg2hw
 Hk64abzqY1r+75A9lRT1axupjKj8ZXfVkZtl0Jl7IC+hN3kfjngfQX/WOLTEFpj5wm
 FSywr7Yy7ZAeFKIq3ad1mtrdf4M6mFpMhgeBwpHRnoy6vWL7cc7Uf8XZIWOEkvCHxC
 kvUM0Tij0EziH9DMgHiYfIXjL+CioTKhxXj/y/L9XBwN34D7Xdnd5xAoc7Pp644A0s
 bYCvd108w1Wvg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D704A1CA62E;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3DD88409D70;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9C1072F9B7; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 042/120] hw/display/virtio-gpu: Avoid leaking
 migration blocker
Date: Wed, 12 Aug 2026 17:48:25 +0300
Message-ID: <20260812144955.649205-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

virtio_gpu_base_device_realize() leaks a migration blocker if a
check of the output list fails after adding one. Perform the check
before adding a migration blocker to avoid the leak. This also
simplifies the code by merging two loops.

Fixes: d3a4969dc5ac ("Support per-head resolutions with virtio-gpu")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725-virgl-v1-1-58bb51e60da5@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 8dc8449a678f56ea0746e1c002f3c671ef9c456d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index cb76302e2d8..e32c1932af0 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -194,6 +194,11 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
         return false;
     }
 
+    g->enabled_output_bitmask = 1;
+
+    g->req_state[0].width = g->conf.xres;
+    g->req_state[0].height = g->conf.yres;
+
     for (output_idx = 0, node = g->conf.outputs;
          node; output_idx++, node = node->next) {
         if (output_idx == g->conf.max_outputs) {
@@ -206,6 +211,17 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
                        node->value->name, EDID_NAME_MAX_LENGTH);
             return false;
         }
+        if (node->value->has_xres != node->value->has_yres) {
+            error_setg(errp,
+                       "must set both outputs[%zd].xres and outputs[%zd].yres",
+                       output_idx, output_idx);
+            return false;
+        }
+        if (node->value->has_xres && node->value->has_yres) {
+            g->enabled_output_bitmask |= (1 << output_idx);
+            g->req_state[output_idx].width = node->value->xres;
+            g->req_state[output_idx].height = node->value->yres;
+        }
     }
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
@@ -228,27 +244,6 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
         virtio_add_queue(vdev, 16, cursor_cb);
     }
 
-    g->enabled_output_bitmask = 1;
-
-    g->req_state[0].width = g->conf.xres;
-    g->req_state[0].height = g->conf.yres;
-
-    for (output_idx = 0, node = g->conf.outputs;
-         node && output_idx < g->conf.max_outputs;
-         output_idx++, node = node->next) {
-        if (node->value->has_xres != node->value->has_yres) {
-            error_setg(errp,
-                       "must set both outputs[%zd].xres and outputs[%zd].yres",
-                       output_idx, output_idx);
-            return false;
-        }
-        if (node->value->has_xres && node->value->has_yres) {
-            g->enabled_output_bitmask |= (1 << output_idx);
-            g->req_state[output_idx].width = node->value->xres;
-            g->req_state[output_idx].height = node->value->yres;
-        }
-    }
-
     g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =
-- 
2.47.3


