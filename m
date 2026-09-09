Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF52C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G6k-0006Ni-JW; Wed, 09 Sep 2026 07:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6j-0006JM-04
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6h-0005MC-8f
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st5ek0kTObO0ESvhhzSIcwXFA2FNe+7z8NziAK39hvo=;
 b=Wd9jhApORh1GrF8p5UeLi+l7r5b2scDD7B6tX+4uDrmgglID59mYIVfk/lZIHfD6nBec21
 RTWUPPdj+a3VNh75sQ3whbOWhONMcfnSZilp/9X/vcrv4v92pEA+O4X+nnIgI+bP0/+SrX
 Wzyi9kyY25iityp1h9RN4L6bFlW6rfU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-yknHd8VdMviOeHr0FcEldA-1; Wed,
 09 Sep 2026 07:04:41 -0400
X-MC-Unique: yknHd8VdMviOeHr0FcEldA-1
X-Mimecast-MFC-AGG-ID: yknHd8VdMviOeHr0FcEldA_1788951880
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63EB8195419C; Wed,  9 Sep 2026 11:04:40 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9EDB81800370; Wed,  9 Sep 2026 11:04:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:24 +0400
Subject: [PATCH v3 19/24] virtio-gpu/virgl: release dmabuf when a texture
 replaces a scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-19-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NSO9nQ7qd+66AiIBNWyR/6HEioFSD0pajYBA2cH3wnA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzzdpKfhyH5rnOC004Tmlet+qbIVlknKaJWb
 6spMO/UO96JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88wAKCRDa6OEJdZac
 5YdXEACWgkU14Eyt51jGy9y4YtUWi0pQb1yiwYF757g2Q2uwnzSlHPEuedNUIQgWlaKSOCiDNLx
 6CQGsZigzj1w60g/UTmGdxkPmdqRXJhFjVegZ/Q7kg4P29YACEhH387xqakX9fn4Dn/lxQAsDlt
 vtBBmYem55UYH8aMgK0z9H98mzVi0y84UdrOlObsk4K4TpxNbopSJr/ArBY5NcyffbQCueY2QuF
 SAyg8hrpyee2F3bb88bpIB5CUSLqQi/klIt5O0tjAzkOKTp8rQknUqjR3IIRLSH4ZPYanDD0RFA
 NUajHp1jR2eF2MYUCgb+YPqqZGbmrKuYUz40S/7L98rI+a5BHiL3e+b+j82zlH8paamm/GqP27G
 926/QY/NP7M4zsJdtMFWYszSwaxaA+p/ZYmNak6GtoMI6sSAuHdg59t9+mngstTus9iP3ruw6hy
 Cgq0H87mp3Q7mtImIbsQSZ+44bZIbX/BB+9q2pNGqHVHlBmZFCBS9JyNza+tA3z0Mjgvjv5jZJe
 jbT3kPERUjRHi2EftWoPysE7ytR+wq79PZ4lc+djYilyXt8YJvoPjoj8bRjvoTgyyP540AVHRTq
 n+yrnETCG20Rk1fZsivShg4Dowdfa5uwzXbuEGTIgCI56le3u0yUbIIDeO9f17s8zcPBQGzd+sg
 Mf1KavlNuJwWCHw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Release the scanout dmabuf before installing the texture. A full
virtio_gpu_disable_scanout() is not used because the scanout is
reassigned immediately afterwards.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c  | 3 +++
 hw/display/virtio-gpu.c        | 2 +-
 include/hw/virtio/virtio-gpu.h | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 7f1d1e0c3276..79d4c0b569fb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -605,6 +605,9 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
                                              &cmd->error)) {
             return;
         }
+
+        virtio_gpu_release_scanout_dmabuf(g, ss.scanout_id);
+
         qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
                             ss.r.width, ss.r.height);
         virgl_renderer_force_ctx_0();
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b2cba26405c5..f9083e9577c3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -418,7 +418,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
-static void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
+void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     g_autoptr(QemuDmaBuf) dmabuf = scanout->dmabuf;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 071cbbb6113e..2f18d839ccd3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -371,6 +371,8 @@ bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
                                      const struct virtio_gpu_rect *r,
                                      uint32_t *error);
 
+void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id);
+
 /**
  * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
  * fb: the frame-buffer descriptor to fill out

-- 
2.55.0.543.g5ebe2ebe4ea8


