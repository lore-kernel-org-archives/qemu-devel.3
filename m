Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C144C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zzv-0004wD-1W; Thu, 10 Sep 2026 04:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzt-0004je-II
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzr-0004wc-Sa
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khbpV+xiZresNyGTZT3mIZWPgj/akniR2wAoczGH8Xs=;
 b=Of3/u39V+k3iaygsoUKYuW/rqJOB3baEzkS40hXO1wN2TeqlFcqT0ilyeLOT3AEBSVMdIp
 FlvWceOOZ5qBt6FuW2OB9QV7c65GJSLP8b9Xu3CDGdEdcSK3eO+6ex9yvVVZs1X55vKyV2
 60lHqgqtCzZVV6Q5H0/6Ik1vxShH4eM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-SHMaM6QaPhKd_5YyP7qcdA-1; Thu,
 10 Sep 2026 04:18:58 -0400
X-MC-Unique: SHMaM6QaPhKd_5YyP7qcdA-1
X-Mimecast-MFC-AGG-ID: SHMaM6QaPhKd_5YyP7qcdA_1789028337
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9F319560A5; Thu, 10 Sep 2026 08:18:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FC2E195608B; Thu, 10 Sep 2026 08:18:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:46 +0400
Subject: [PATCH v4 18/24] virtio-gpu: release dmabuf when switching to a
 surface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-18-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pgJLh95j61L6xCFJ/JYnj7bpQvTkIQF1Ao6BM4GA2P8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeokukma0luU/rP4t9zcnL4BpGVKxBgFDsGH
 rtejOVXAEKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5RmuD/9aHUNUXCNzsXuQH1KtVnZB9QhkWVrHqtVNgmo1cdE7VSKU+rlVumoQsBk/M0qKfP2oGRO
 c9h3PzVCA0lHpq9CKEgzEJJrX9HeAIZ/sWXXEAAV5AKyP22tPtgY/+y2zLI8YTuCh5u39806VBL
 ReeAv2mdgoCUjLZ/GMUKYU+glSKiFVabRhUwuoY5PXY1H+3zWSXoc2PFJLuJdBJGmC12XJkQ2/7
 3B65TK5f9zo8m3ZKSBk1UvAYJ013zQ7Af2ud/Jj7l7RZZj4BGQh/ICuyiHHVqlZL+g2/Qo92q4j
 GcH0IWVdK6hD0XzJ1n6qA7lTJ0aFZUByzVvLWqpJ1mWTifUSH9130g+68SIDgqvZuBBIdE7Kxnj
 EOIeh1oQ53ZF33t3muTjsDrt+W7DN/WJVZlOadKVp0gpdTy4/UI/H9nWYOZyTw6+EJM+mEcWaih
 880ngZVnkLa5n0x+GsrgAHDn5qtbFiZPordCEGRq+iEHNdG4N/ktZFWFr98xe7UpHGRwPfLdR01
 krSKdVWylKa/L/d3v3DlwGPtkmRpsj32m36AgI6bGZI/QncTTllQDbTgNig/aZwANbR5MwS99JY
 JL8XRD1mr9TO70KlGBPt3fqxZBJ1fTfGJiMC76A5bpxOT0UG3ShoNUYsbGZEkU0CQSuxSCmvSk2
 w/dESTU022A4mLw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

A scanout may hold an active QemuDmaBuf when a SET_SCANOUT switches to
CPU-backed display data. Force surface recreation and release the old
buffer in this case.

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6e021b78b890..b2cba26405c5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -704,9 +704,11 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 {
     struct virtio_gpu_scanout *scanout;
     uint32_t bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
+    bool was_dmabuf;
     uint8_t *data;
 
     scanout = &g->parent_obj.scanout[scanout_id];
+    was_dmabuf = scanout->dmabuf != NULL;
 
     if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
                                          fb->width, fb->height, r, error)) {
@@ -733,12 +735,11 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
     if (res->blob) {
         if (qemu_console_has_gl(scanout->con)) {
-            if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
-                virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
-            } else {
+            if (virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
                 *error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
                 return false;
             }
+            virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
             return true;
         }
 
@@ -748,7 +749,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
     }
 
     /* create a surface for this scanout */
-    if ((res->blob && !qemu_console_has_gl(scanout->con)) ||
+    if (was_dmabuf ||
+        (res->blob && !qemu_console_has_gl(scanout->con)) ||
         !scanout->ds ||
         surface_data(scanout->ds) != data + fb->offset ||
         scanout->width != r->width ||
@@ -773,6 +775,9 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         qemu_displaysurface_set_share_handle(scanout->ds, res->share_handle, fb->offset);
 
         pixman_image_unref(rect);
+        if (was_dmabuf) {
+            virtio_gpu_release_scanout_dmabuf(g, scanout_id);
+        }
         qemu_console_set_surface(g->parent_obj.scanout[scanout_id].con,
                                 scanout->ds);
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


