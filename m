Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86990C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tho-00060x-Vp; Fri, 04 Sep 2026 09:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thn-0005yK-Dy
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thm-0005Ch-03
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Efx/zhWGeDCKFdjtEJc3Lq+2TrEFGjPToQFoP2ihkTk=;
 b=AvYx9GQs/ZwGLxkqMfDBut6B9L2x3aIPGXqDL9M9xk3rz35hehNWhV+9qRjNRxD1Q5A4o3
 tuswTliQFT6I+4zIM9kvQ+vXdf44zGfDGqzRwagaqEZaNxLkZPiZ4cmhf94uXvkP+gm2zq
 8OfHZR2OxAuXDONWY9PrITDwq/AMJN0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-K3JIAV5HNuOeHNqxG9pLJA-1; Fri,
 04 Sep 2026 09:11:38 -0400
X-MC-Unique: K3JIAV5HNuOeHNqxG9pLJA-1
X-Mimecast-MFC-AGG-ID: K3JIAV5HNuOeHNqxG9pLJA_1788527496
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9F05195F14B; Fri,  4 Sep 2026 13:11:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCF7D1800609; Fri,  4 Sep 2026 13:11:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:24 +0400
Subject: [PATCH v2 20/25] virtio-gpu: consolidate disabling scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-20-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/TWjBGhK7kLsr8SXcbZYQUN0FT/lpu0Z0T0eXdCKmKo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMww2hrEXTlaahvY5lG2mNXNHqHTdYhu9qPq
 xJ7LGf8dMaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5VITD/0eTmXuJcuSvkIqP3Cerc9O7QCOlMv54EvXBPomwMjBqvU7y5ifH9HmuhXt5JJw2feH7Nz
 Rf33m6WaGwvS3IgRFAE4qqXEAnlpB3VvY67LaJoMccQNFVpZk09z0d8fPo2d0SGM+Oq4AHV7237
 +SgNElNI2fGRiQT5Y0XBThhJZw8ZLvwKorwTwkctWWbcWsXUnLpvNg1Pn/bcSngpdfqbVOSqZHU
 s0hJFYgd/NkrsUaLD6/NE7chIkEY0OEq0QrMQ/hfkDrdfG3W1/UpLYwYA5BX+9DlzrHiXQKcFn3
 qewgHo/vanLoXPTQ0Bqdf5rUf4XHyFftkgDxJRMpZUa9PWpw33CJn6h5lEyy2HIsgUBbrcoPbQz
 Tpgu5OO/gWwE5QCTErM0LwuT1HoC3nrgQ4YLhtBsJxk1EMH8wnxaZd4flxaIttmGpyfhr62DRh/
 OV1CF0zeSwd64Gxzcdrf5yHL8aisWpkY+GVTsM4XhwbwMAq0Ry4/o32zDmp+xTYtesdogSCiHTF
 wsx5JRgvrK5JtEIk1a1k5hThrb7o2Rj3Ko5q4hOFl1UBCAhoA4qpEtIFjdtxry8h9MD8IBjntKG
 2mlJGI4cJsKCMiO/SYcoga08Yw/Qp+r9+qgRcKIRR01Z61oXQxTVJq7i8RF42r5unxRs+61ILs5
 cqtohdqfx09ZDaw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use the common virtio_gpu_disable_scanout() to reset the scanout state,
including GL state if any.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 4 +---
 hw/display/virtio-gpu-virgl.c    | 6 ++----
 hw/display/virtio-gpu.c          | 7 +++++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 8a82e96b7461..8697dd6936ba 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -312,9 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
-        scanout->resource_id = 0;
-        qemu_console_set_surface(scanout->con, NULL);
-        qemu_console_gl_scanout_disable(scanout->con);
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
         return;
     }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 79d4c0b569fb..87d1fc3d5f65 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -618,8 +618,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             ss.r.x, ss.r.y, ss.r.width, ss.r.height,
             d3d_tex2d);
     } else {
-        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].con, NULL);
-        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scanout_id].con);
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
     }
     g->parent_obj.scanout[ss.scanout_id].resource_id = ss.resource_id;
 }
@@ -1426,8 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
     int i;
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
-        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con);
+        virtio_gpu_disable_scanout(g, i);
     }
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ae1f87ad68b2..cb096cb349cd 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -435,8 +435,11 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
 
-    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
-
+    if (scanout->dmabuf) {
+        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
+    } else {
+        qemu_console_gl_scanout_disable(scanout->con);
+    }
     qemu_console_set_surface(scanout->con, NULL);
     scanout->resource_id = 0;
     scanout->ds = NULL;

-- 
2.55.0.543.g5ebe2ebe4ea8


