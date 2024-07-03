Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5022C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8j7-0002Sl-J7; Wed, 03 Jul 2024 18:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8j5-0002PG-GQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8j3-0001CM-Pj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=cAwpix/5+B+evUegPzVHBxaRn3FjYXpFENSdgo2qXM9QCxUeQJ7UjvGiHS5SXqpTh8DRxT
 vq37YKa1D4aXbt3r1wt1xf6CLZLeCIGQnfbjOxk0G5dSoqVsNoR6T17HQqeyQT6dHIw5wz
 rkOc/QXAiOXUGkAGMFhZ3hkMXoCzccM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-EfRyHZmqNsq0eodr1D2z8g-1; Wed, 03 Jul 2024 18:45:19 -0400
X-MC-Unique: EfRyHZmqNsq0eodr1D2z8g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e9345073aso2058518e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046718; x=1720651518;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=br6cGoc3RO/JjTOOQTHiKqJVeZ1v8h3Butb0xjqyVEFM1bDbUilN1bLFEpjHNgjCsV
 AI6dLgEbx4V0x6v5ShZxxa5cik0YGxK+ptCLRziLP1xHj63OcQFv9UWuhxR+vCRXoaym
 0cXYBGkEa5owF+fUYB6SYjEG9FQrGW3YY966Z8vIIgkUzzVRFtSInuhO6aCdedb6FdRT
 SJWqpe+6mx53bNcLAbMQQd7VTVvVimmXMQ7FySivElYV1XW0xRjGF1luTY/KxVGSeU6S
 dNswBVu0r/PkKLUg7vCOnmKoQAaCrAK44V7Pvhjn0kPe4fDGsXsuNyMRabazP4OFhqZO
 Hrzg==
X-Gm-Message-State: AOJu0YyeX9gbclwX44/6pZXWLwKwGazdD8zuuiR3xzBbkyux2JG6qw+B
 39xl4oykSIEdZkxJCygOCC5flfCiLzuReID7KtIotew8JO1/faYm926rR5qM6NDIO7bzqaS9OX3
 SHDdWAm9K+HNOzdmY2cdP6SB4h3OWfGOHGTEtEGWLJg4ottfHdJRc5BfNnWKPZE2yWIAcHSPlyl
 fncY5Eqb3rAtZwySsG8jZAcdk/mPJmzA==
X-Received: by 2002:a05:6512:3e28:b0:52c:a5cb:69e4 with SMTP id
 2adb3069b0e04-52e826f12d1mr8789741e87.54.1720046717957; 
 Wed, 03 Jul 2024 15:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm1y1ODxOBNU/ryGMbozUFLY20+fUNub+N3ibywlpMDzs+QpQSYKKEK8Gx3+D+rVXzzsGseQ==
X-Received: by 2002:a05:6512:3e28:b0:52c:a5cb:69e4 with SMTP id
 2adb3069b0e04-52e826f12d1mr8789726e87.54.1720046716940; 
 Wed, 03 Jul 2024 15:45:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab09028dsm553241466b.179.2024.07.03.15.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:16 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL v3 13/85] vhost-user-gpu: fix import of DMABUF
Message-ID: <80c8a26de5f1b7d67d4594957c0d82a0c47626be.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Fixes: 9ac06df8b ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240515105237.1074116-1-marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


