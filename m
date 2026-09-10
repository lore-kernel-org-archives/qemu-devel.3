Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA02C88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4esf-0005UW-7Q; Thu, 10 Sep 2026 09:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esd-0005OH-8x
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esb-0003q2-Qb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qzuszcrbg6cohD5Tu05YF9g7VRkT6a8sFno1QxC857s=;
 b=SwGwx1uCLknUX6l7NK0eK3Cqs3VqlNR8NbkMop02IsO6G9vkucXRr0TN3mSFdGK852kh8a
 QeOo6bh3jLDs9jKagwee8Gbs2B62aomkC1rPXuSzY/kamwBaHWFswEENfHYCU7Txr/diAs
 3dEpODVYpNbjVtDWKaMvHS2y46Ny5aA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-HQHLI3S9MHSfZGBFEDOkrw-1; Thu,
 10 Sep 2026 09:31:50 -0400
X-MC-Unique: HQHLI3S9MHSfZGBFEDOkrw-1
X-Mimecast-MFC-AGG-ID: HQHLI3S9MHSfZGBFEDOkrw_1789047109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8199D19540D3; Thu, 10 Sep 2026 13:31:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73EAB1955F19; Thu, 10 Sep 2026 13:31:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:14 +0400
Subject: [GIT PULL 19/24] virtio-gpu/virgl: release dmabuf when a texture
 replaces a scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-19-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1ZzvdpWhDv1qIdQGLav3DavQ9DdkXg1Nj4VP5JBHZlI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDdgf9hqR8F67p26zPvZHHcJo1IBpFnC21Ru
 RTnyPA4rbWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3QAKCRDa6OEJdZac
 5Y5DD/0WhvJ0V+MpVFALK4VRA4KjHr7ZpLHsTd+0C8c8nhqHSV+qddOq/Wkvtn96zkFjOyH9biV
 4daM0lv+Ge5HtW8T7ojDXccZhi4aIWgsHvaBtD0IjbAbSSTTTp9HC+iWAYIDvYsXdFaQWfhDwKH
 jidHbtWAq+oGQ8dT/J99m2rYcpaFW8fazTBrZOCXc5NnpIMwI5IxhjoGzoEwPCcvwtr81zhgyEM
 cBjNRkmpW2U32Tf/2Gg3dNfrOvzwRr2vBfENJjSllMIpb6bt4hbHtDf8fKAuMSXdMr9Iyg9qfUh
 J8Ific9aHRWKY6zdN2ANlL/QYJ6DKJ2xVZD9pojZk80RbRxqiHsLv4IOFxIvvuKbQoH1/b3I/DX
 PkMFru+3H8jbMv131dEhAOt2Gjpxn9J5s/NpYA2TjWu8xjwpSw8s+AVnzQL3H/Ye3LYCfxK6nUQ
 L4ITraJIaq4tu3Mab6QuOsRv2rd91Y1A+5KkfxBMzC/KSQlkciO4hGgD29mXRQA++RYhKi71gUB
 rnZGf1XI/TVYkXXkCAR32j/zOj3mGJN8ID1juMhN85+4lL1N2rL2vfqSJcfLdLIo8w1IpFCKkT7
 ymCTdD3RER/1DOVKlkGaMV0PKpP8ctIDXzu6sC6JOQqbSbO0yzJykNVL7RPCWmhDfZSJMPn/Hqq
 MHxdtjolPdmYzwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


