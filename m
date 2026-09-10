Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9213CC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ngN-0004l4-Gw; Thu, 10 Sep 2026 18:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lSX-0005Ze-AN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lSQ-0002Yq-9T
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5tTG7r4ospJl2zFiWFXBEc0cVcn4tmkTXMIavMez6uQ=;
 b=dqHlFrdJyRuf3K8roxj9vtWZowj7F81EVXowIn46fO7sOqPj8CXt1+cFUmwNLaDJ+VDSHB
 y7w7CyXfv6qcXRGs+JIrepTEekpIM0veg1RD+oCSKSvnM4GL27PVe6RbDtRfscEAE1m8ea
 69biDL+zbpUwe1AWmtCpErgDwa3hoz8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-1gmGK18gMD2cMA8rBIYn0w-1; Thu, 10 Sep 2026 16:11:51 -0400
X-MC-Unique: 1gmGK18gMD2cMA8rBIYn0w-1
X-Mimecast-MFC-AGG-ID: 1gmGK18gMD2cMA8rBIYn0w_1789071110
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482e2541c30so114998f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071110; x=1789675910; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5tTG7r4ospJl2zFiWFXBEc0cVcn4tmkTXMIavMez6uQ=;
 b=KKennPOHpC+m78/sn5UihnwzHDfEk5t2cMssd9K+R1HTbGCMrkHyOB/X95GppP5O59
 DN1lWGc5QhZShTEZF+aO1etDU8BXmZ+qG8fnocMcY9QI3Y8SgMqT+PJCtloJsyvQynLO
 VelTEDhY4f7nH0fsYpVoKPMzJdrThJEUzVet9AdDiOX5vn5pQGrpsj9j2x3fCq3NT3Qp
 5ZDj7eDx8P/8WIVTgr3R0/9KoDP2+I9xzUNVEdxaWPecDj82J8b/3FFMU07wLoAGGEXJ
 5xnZu2PZoyAnc9xU/M4ETWLXPRPmdLy7Ok7Hy5wNkGDmjrJneC6RfR0czOSUxJIaJiT0
 RwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071110; x=1789675910;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5tTG7r4ospJl2zFiWFXBEc0cVcn4tmkTXMIavMez6uQ=;
 b=fIJo5x7yfFFLfGYicxDc/dAVxC3UaT3RoD0zm4GDdEHQWI2w6fO0PZEvUsDfmLPWup
 tEy4bhRJN+S3dB1XYRUFEKJUVXzMZAiS+fArtwL+6rk4LDTbP0l96LVmBn1NV8lctHAV
 tPuFmyhuZCSfTPiNdzB+fxsMJ3ndXJiuB11q+DAV01m+qbXZ5Od0kRh6bN4tJ8bhaC3v
 M1Bb14G8YB4gqJCCMWtqcq+tecbL4fvpfPvBxQXTJ85O1uuthIN5Bw7Jw0noAGvhWDp4
 /Hn8MhuCDCXykKWBrZHUj67LwXea4mAJY5a+byrkriTHIkcvMRerIHWOd38GXdkbI0RQ
 nnGg==
X-Gm-Message-State: AFuF++nh0Pud9DXjYgPWO4UJf46Ri9RyDtLsYlY/krBZ/Vo1gaSCZW+s
 ztUiu3zKCEaE67MsfTu5HR9AJGrHHrh2QopnmAZbVtqVnd7jBAo9LI8JFXlmZV7kc2jTmxIHxb8
 qD03wBeYiluxboRo2r7fP8OTMAt68FzGM22/byjsf7BgwDLeIqPuH+SKws5iHFB5dLjoYP+80ao
 iPz7Av+xMv4NZb45OeEgRO2AtXIEwMIZ2Iww==
X-Gm-Gg: AYBFou3If2ST3/+5XtTlBWzViskjEfV4CUtNncoMLGbiX4VYzOi174mYcpvZcrOPjnz
 W5MWjZZPlAKrCJjLcqvQLjWcaMjQRNOvgjg4PN8+7FQKbMApZxHEtRVXQVnjr/h9saJ7t5oPiOA
 1WKhmXSZmVnJNNBvl+9b3q6+UHHMSp3qFtXqQ435y3C/KQEtbikxgNcNiUFKbVSp4Hv6IhlX/Oo
 Is0AXI5tGZyvNekamGRQH0RX694PcNUbjC8Hgkeh41MDrCUbY25YExyY2NlOt9P0DNbb7a/w2o3
 2E94s5FMmHmbMtWYiqFHYksH4TaZvIhJmrFkS2+2eVR64Eywn4gJFij+Ecnfro8P6MpqBmR3b6B
 T32TwNcZvo6C4gCdzXoexEHI=
X-Received: by 2002:a05:6000:4701:b0:485:8a07:3f0b with SMTP id
 ffacd0b85a97d-486d7309df9mr7516698f8f.0.1789071109884; 
 Thu, 10 Sep 2026 13:11:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4701:b0:485:8a07:3f0b with SMTP id
 ffacd0b85a97d-486d7309df9mr7516665f8f.0.1789071109341; 
 Thu, 10 Sep 2026 13:11:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm841004f8f.9.2026.09.10.13.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:48 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 11/90] vhost: make vhost_dev_cleanup() safe on a partially
 initialized device
Message-ID: <1d6177870c442be537ceaee55c832d3c4eee3464.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-8-andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f9b54c46f9..2bb9a23fee 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1648,7 +1648,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }
-- 
MST


