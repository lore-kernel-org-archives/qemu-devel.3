Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011CDC5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsz-0007zN-UK; Mon, 27 Jul 2026 07:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsu-0007a7-41
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJss-0003mz-La
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDbGts2Qj/e3weoWlViViYkpfzH+enItTpsc+fYe5EM=;
 b=gkHojkeIBm0yrJWkrho0iWSc1KF0G5O9J+f6Ty8XQgzx1xgfSb5l0Cms1RCf0Yps3+q8XB
 k11H9f0UAhglrktvSGSd7CQAjYy+jQxRV/ArXTndzz4PqR9lnIVyqhXdykLr7oemoCxH3i
 F/SmCAxq0vDwBvM6EuT0DitgHA7nMKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-MheDuLj_PUewXxkMeKtjZA-1; Mon,
 27 Jul 2026 07:52:36 -0400
X-MC-Unique: MheDuLj_PUewXxkMeKtjZA-1
X-Mimecast-MFC-AGG-ID: MheDuLj_PUewXxkMeKtjZA_1785153155
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 658AE1944D2B; Mon, 27 Jul 2026 11:52:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 295F01800480; Mon, 27 Jul 2026 11:52:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:20 +0400
Subject: [GIT PULL 11/23] hw/display/virtio-gpu: Avoid leaking migration
 blocker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-11-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3088;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e8YKTUPX8S1llzMY0wj2VebqiGgtbCyfgI/ryqSqL/k=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGpnRj+iVZO5nN+cVNRAVqrXLX6epcSoRePlRah6Na+49d1pD
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqZ0Y/AAoJENro4Ql1lpzlqD4QAJPl
 flbIl8XBNN1BwRZvRnZlOEzOrmUtudw/EVvD5yIGwA7mUqdBqcopP3P9r1lMx6F0d7uRuv2ANAs
 cN759sZQVoREckytnlICyRjPGeBSZLimwmMH2Dv899hEUzQkPNydSwADkn8505IkupZRfAlaDU1
 2RsHl692dTg6/X7OJ6QYA0G2JPcZQDiH+iJ7ghsMcj7P7QUF2755yx2S5tF6JGgj97r7YZT8s5E
 6bW5akQEmOUjUkY85qBUJ44aC+iYPFhRvhLkzKC14ZnvJLdjLPdN2ClIZTE0GkjWztFElnBW2b+
 pvPIkxYiTh9DYSBfbcWxrgLvPfFhEHzMxZ3RPC8pspTOorAWZEFPiENCslqJ3Z2bsqOIsR8xRrN
 siFreIzcuTCvi93+8NAA/syDcaoTlbqGhFi1S0LSgk6/r9HJch+OV1Qb+CdxfuDex2h8NTfmrkD
 XkA+oQ6PZtC6dyZUyWQpSjwjJBZO0O0UMBShmRiAy3pFak5N36oKKnwJxWfA0aCy2KAVAqbZf3D
 6TJAWXKaI12dReZ6xqwhaaQwsSlzvPtjZjL4mFXvjLZhJZNZ22xc7m2EZl56APUf3TVkvHhYPKI
 Erzi87DtFNjRlcDoKaH0R6GKG4H7UX/SlBPG1E4U67aIo8vyY877bsV8E6eDRL3M8tZ5k8Flx3/
 mflG4
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

-- 
2.55.0


