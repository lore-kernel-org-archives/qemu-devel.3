Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D76C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zzx-00051x-Q7; Thu, 10 Sep 2026 04:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzv-0004xD-CB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzt-0004wr-Rl
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qzuszcrbg6cohD5Tu05YF9g7VRkT6a8sFno1QxC857s=;
 b=EE2P+evt7gU0+3whnOrdY+/bnd+519kFmw06ovMGURfzPkquDZLDW0WMCDGV/oEZDBCn6i
 hGkeFd7ZGQ1xVFIuoIX0wjoPMxhnJynlzrpYveHUGN+FuuExIsrHTpneeML45IsWr8gfmw
 afVIo4ekAzqOviB0FlPxOxFNolw7MeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-5oNWGusKNvCp8tRYXUagPQ-1; Thu,
 10 Sep 2026 04:19:01 -0400
X-MC-Unique: 5oNWGusKNvCp8tRYXUagPQ-1
X-Mimecast-MFC-AGG-ID: 5oNWGusKNvCp8tRYXUagPQ_1789028340
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 954761800589; Thu, 10 Sep 2026 08:19:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8AE9195608C; Thu, 10 Sep 2026 08:18:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:47 +0400
Subject: [PATCH v4 19/24] virtio-gpu/virgl: release dmabuf when a texture
 replaces a scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-19-7d623714bd71@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1ZzvdpWhDv1qIdQGLav3DavQ9DdkXg1Nj4VP5JBHZlI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeoQgpct7O/gE+X2nQD2aboAAVji/qQgpy3l
 mcFRPInk7KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5SVGEACkuXtEVoKu71nb/6duoBi1diRM/KluG2UnbEd8515eCY2mgCjzxz3iw5K71lqkit+phl3
 Vh392PbD3AESULvPVMJxSP6XtBmplvR8TuR7TYV1GMKC7qSEYrsq1l+GgCalj5c9PiZRsC+KlSJ
 aHlSTx/z2B8hsi9wMFZGwGz1r25Hh+QGPZ7eht8j9NuCGdABqRaXqfbKXov5q1LqT8PSIyJhsd7
 8w0MrN4rzLpaGutfSgRAUb/U5ZGsX75meQmav8/HG9GyLbW0dRzvZ4usRrqrWxCUQbujW/3IE5n
 2MVAY1CI42/6IIa+EokJlQ8jAOyGXn7VJaJhx7zuDRGZ9e2Bq2ADya7g5wxNGqPPLw/HthufYuB
 4v0z+lYLi69QIT4RutJwhawunTIIWA3J/W41SZntv3r8/v2kR6AXQvzSHKRC05XrlSn63v5HycK
 712p0eKEjzMsBia26ELdfWlos3lrmj1uTHgei5EB+oTUxvV9zctYJAz3vBsQkU7BuyuA33Uikcd
 aO+Aa5dnci1uglSNC8PAZ00hQFC3QEwqtVF5N3qlfgyS0om/izb6CkZ1MB4MH6HeW0w0pCUQZ6f
 4rT1dt3mv+MbzXc2W3zkfmajByGvuh8NC9gX1cjG3G1KxE1Ju/Yq1XA+m+/JTLW8ldUtV5NGMhf
 ZahhMAuF13Zi0MQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 0e43eacca406..07349c5c5502 100644
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


