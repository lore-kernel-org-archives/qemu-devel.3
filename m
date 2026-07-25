Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43103C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnWal-0001sF-4f; Sat, 25 Jul 2026 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWah-0001rt-KM
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:14:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWaf-0002OC-Ng
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:14:35 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66P7EMeq073196
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 25 Jul 2026 16:14:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jzllCQhS4WJPY8ipU+vwB9wT5P63DfYDBo3FwGouLFs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784963667; v=1;
 b=JFXduTf8eFdJ80IRer83vvaFHhth2zmkHLG5IaPDrVwBciYuynwVoM+4C1Um4rcd
 5jCHqY5O6kmEuINp6iMqL1uEV3pnrOYqVkNLonIb8eM2WGlY1sYQOkujIaR7614v
 Q1TqKODtaFaHbR26hjhapOTjQZCKx0IkCrdHR1uHMZt84WS/vdWIs52GO5QvpZPy
 FjyWMGbcZgZeVVfOuh2EEy5K/mcVp0rR5XsfKtCP6/O4XLwiHLKBMdQPo7aFF4J9
 6IOV7MkyzyFKBfInd3QQckExuy/p8eVk/3oFeyOTJtxeoa+C8bXCc2dIR1CHrZny
 YR6UXT9AerUa1jdVL0zVeg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 25 Jul 2026 16:14:21 +0900
Subject: [PATCH] hw/display/virtio-gpu: Avoid leaking migration blocker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-virgl-v1-1-58bb51e60da5@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNT3bLMovQcXQMz02QTkyTzpBSTNCWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQDaELIwaQAAAA==
X-Change-ID: 20260725-virgl-065c44b7bd4f
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3110;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=ND5sZt1CTwLMqIIhAakW3nB1wwoxwYJx+STGS6xZY+g=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZKUuC6YNsT6w83sSnzbjMs2q/1mHfL9NgU1b/XN2XuW
 HvGcZF7RykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwETixBgZFl5Zo2T1yazOXrjX
 dc2vKnOj05HTP815v+3+th02s87fV2X4Z3P5+AIX7vUqDzWUC8Jv3J/HuEy4ZvnGkr02v3bPd/3
 VyQYA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

virtio_gpu_base_device_realize() leaks a migration blocker if a
check of the output list fails after adding one. Perform the check
before adding a migration blocker to avoid the leak. This also
simplifies the code by merging two loops.

Fixes: d3a4969dc5ac ("Support per-head resolutions with virtio-gpu")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-base.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index a68b18482956..946e56b42f61 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -195,6 +195,11 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
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
@@ -207,6 +212,17 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
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
@@ -229,27 +245,6 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
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

---
base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
change-id: 20260725-virgl-065c44b7bd4f

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


