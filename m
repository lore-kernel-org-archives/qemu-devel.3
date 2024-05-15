Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BEEC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 10:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7CFj-0003S0-My; Wed, 15 May 2024 06:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7CFi-0003RX-Ed
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7CFa-00074i-Mo
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715770365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F5km/CX2vyf3i5y4wgMjMMOUcSk1QfBQb/FJ5k5YAyU=;
 b=Eq7p3siCOtQCW0qa//cY4YOFbdOct4FQfQXpbCkjOrWy7OOBbbok9WxmGoGRI3ira/SpHH
 a/N8fDdqNi+Lw0ROTBLaXRrXFzNBLFHaaLbB+3rl3e9zXRXdVTdmMKQ6ncAGDBh+8zXU8I
 SHB7Ku42HSlMZInW+lAP/ooDeMDW/+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-zYzgo4CQPEeEzzdUZqg5EQ-1; Wed, 15 May 2024 06:52:41 -0400
X-MC-Unique: zYzgo4CQPEeEzzdUZqg5EQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BBF6185A783;
 Wed, 15 May 2024 10:52:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C01421EE56C;
 Wed, 15 May 2024 10:52:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: dongwon.kim@intel.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3] vhost-user-gpu: fix import of DMABUF
Date: Wed, 15 May 2024 14:52:37 +0400
Message-ID: <20240515105237.1074116-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When using vhost-user-gpu with GL, qemu -display gtk doesn't show output
and prints: qemu: eglCreateImageKHR failed

Since commit 9ac06df8b ("virtio-gpu-udmabuf: correct naming of
QemuDmaBuf size properties"), egl_dmabuf_import_texture() uses
backing_{width,height} for the texture dimension.

Fixes: commit 9ac06df8b ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index e4b398d26c..63c64ddde6 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -281,8 +281,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             modifier = m2->modifier;
         }
 
-        dmabuf = qemu_dmabuf_new(m->fd_width, m->fd_height,
-                                 m->fd_stride, 0, 0, 0, 0,
+        dmabuf = qemu_dmabuf_new(m->width, m->height,
+                                 m->fd_stride, 0, 0,
+                                 m->fd_width, m->fd_height,
                                  m->fd_drm_fourcc, modifier,
                                  fd, false, m->fd_flags &
                                  VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
-- 
2.41.0.28.gd7d8841f67


