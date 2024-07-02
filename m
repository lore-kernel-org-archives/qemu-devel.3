Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6C5C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxu-0006By-Cq; Tue, 02 Jul 2024 16:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjx7-0004l6-Sk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjx2-00008p-2I
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6iaejVuyK6cotgddPWIYQA8dIBm4KoXB6zsOD2vQwU=;
 b=gz4CyTkXu6NFTBCyTcOutvCrpA36d7ncHg9UGi7fPZfgJ1J5A6bV4KLnEY2rM+dDS19rpA
 zCpeQp+tCwr3c5LiOMKg55CCCn5O3z6bVqCgM5nFvrNBHWvvz5gG5DZJtfUv7BpRBUbDVA
 HP8bzE99NPNjVQd46blP0gMvaP8LZjs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-9PLUARK1MwuIK2BDPi0fNw-1; Tue, 02 Jul 2024 16:18:04 -0400
X-MC-Unique: 9PLUARK1MwuIK2BDPi0fNw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e6e454663so5143131e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951482; x=1720556282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6iaejVuyK6cotgddPWIYQA8dIBm4KoXB6zsOD2vQwU=;
 b=oqbSI7gUQbP3EKXahaxoSHExu7ENpgudhdkyxpeG7KFnQL/JmooUjL26ud/1JblDfX
 440tXVouShKGOms5pJj0WoSxN0YZqKyM1skGRsL/erOYOHdi8wClHidmWQQ4s6Umi+Cr
 r+U3lTqYf04EPDKvbdPZVZpz1+51JkqSgDA+MSrOBM4xOFNGrT58QxRdiCruYaL1eBfc
 8GAJbshG4j+ogBzHN0SnDT1yd06QYD7Da6Y8IFzuJeve/wCE7XVNKpTBFZ+IIg7pzj3Q
 Q7doKl0QdwI/vKFTCasP2oC3ZV+GMS5UNG+lc7uDsyEPBgXqO8qZmkwuOZJlppAOJyg3
 eg/w==
X-Gm-Message-State: AOJu0YxCWaENVevNQKX3AX1b4OEW8UWRBXfEO4WYRslS71xOTbeCWQZH
 xjWyZKYrhGMnT2ZByKBpzULZuKqCsmmMFxTrjvFqYmiZymnMXOuGaaPBcI2iY+F9BTvcpDBDVpM
 tP8H88lrwlfv2+CMyWZm7+ySeZBqiFeRaX1AoxIrtyUZfX3Hz4VO6ROqRryVnJuiFa7VSHF9zWe
 BJwgfY5BruqUQLtSgz6F54SS6zz5dC1g==
X-Received: by 2002:a05:6512:3b22:b0:52c:e054:4149 with SMTP id
 2adb3069b0e04-52e8266126bmr7225050e87.15.1719951481800; 
 Tue, 02 Jul 2024 13:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI6GGzaQcQC3IYyIpMnGjN7/+7qQYaiTuwSi243O0DLiqTfHVDIGPiLQ1+OcbiSJ5EN7AFmQ==
X-Received: by 2002:a05:6512:3b22:b0:52c:e054:4149 with SMTP id
 2adb3069b0e04-52e8266126bmr7225036e87.15.1719951481197; 
 Tue, 02 Jul 2024 13:18:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b91bsm212132365e9.20.2024.07.02.13.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:00 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 42/88] hw/virtio: Free vqs after vhost_dev_cleanup()
Message-ID: <25b8a0f40c7f408442c5fd4da195fce9997cfb78.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-san-v2-7-750bb0946dbd@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 11e72b1e3b..2bc3423326 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -223,6 +223,7 @@ static void vub_disconnect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
 
     if (!vub->connected) {
         goto done;
@@ -231,6 +232,7 @@ static void vub_disconnect(DeviceState *dev)
 
     vub_stop(vdev);
     vhost_dev_cleanup(&vub->vhost_dev);
+    g_free(vhost_vqs);
 
 done:
     /* Re-instate the event handler for new connections */
-- 
MST


