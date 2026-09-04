Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB7C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Thf-0005e5-Tp; Fri, 04 Sep 2026 09:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2The-0005Zo-1b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thc-0005As-H3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpR6y0YPua1oePMHs+e2bIlt2sPRGymy4HgKrE81ORM=;
 b=NL86Ug/PN4grDewSgdKjw5K+PSB3jTGhycIwlMa5udcy6oPnh3AIpYUW6atSpCKrNz9820
 GeK4NQ9GS/hAPnmmYfiNMzum01DAr6ELVwDjWF0TFzgIktRKB0naxEkWzQUZ6MJv5CGyEs
 FuleyeX9lzj+KugUTj2vTg7m9H5ncW4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-vs0WJcfFOK2u63fyromsyg-1; Fri,
 04 Sep 2026 09:11:28 -0400
X-MC-Unique: vs0WJcfFOK2u63fyromsyg-1
X-Mimecast-MFC-AGG-ID: vs0WJcfFOK2u63fyromsyg_1788527487
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D09418DEB01; Fri,  4 Sep 2026 13:11:27 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E88A18001D0; Fri,  4 Sep 2026 13:11:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:22 +0400
Subject: [PATCH v2 18/25] virtio-gpu: release dmabuf when switching to a
 surface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-18-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ke8qPQ1kPjfvFQxnwuX6hhLMR1dx8hj/OM/RSRZyxhw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwicrk01vChlKYDR9AmKrP9QddpRS9neLz+
 hOEJQirIFuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5Uc/D/oClVaNCgfAiZkMu8TQ01UcWSt3P5d5DFjdPd2hm02bsGBurhLRZuGY/3MxoKTNlWKi7iV
 Wqu6B/8dvtpLNN5NT62EE00owx1kLZzozjqElREGkO1BZGZa3pnODekXD7j20rmVmMGE8BfhFa6
 Be4jedLl3bQ7E8c9SUFyOFmIpB7kFI3k9it+DuBk4Im5134AcvYiXINJ5PEUQsLsJK5jvPv63Sq
 rgvDGW4XVjDTHw5fZcMS4pH9GH+2PIMzzEhfxkcROBWKprGsB862YLsnVEprX2n7cCn1MwD4Wb5
 0BjEdzRiRGFNj58rDFsWllQ/nKcsgd0egFlTM6EI3xO0DTqVsrz8x9+CzYVmdLRPbQZQBNvqhuj
 +KBujY6rzoHLJgtdVisC0nVEN2A2n3TlUHKPHRhtYGZcgL7qY4Wt5iSSO3ffM5XehE1owsntwpk
 xrepo5YZW5waA0sKklhbav1NsueVNckvFKD9EMp+ipiMXufcPOd+3nv/GBAqBgxiU+lrvT+jzMf
 NN4eHfbiCHtL2Nmc6G31TUyj5SR2O1IarEiwLA11JewbMWVer4JmddhOz6Bho5EuRLgMhyolima
 WZlA4kMrg/MIq/ntPFUxlZzbfydpz2bczao6XIOtATJPJjgshKvt6cTTd/p19dT82Tct0W/rwDf
 M+1m101xVK6G4UA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

A scanout may hold an active QemuDmaBuf when a SET_SCANOUT switches to
CPU-backed display data. Force surface recreation and release the old
buffer in this case.

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b244afb69e4e..5c3cd2fb4616 100644
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


