Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF617C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8iQ-000220-7o; Wed, 03 Jul 2024 18:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iO-00021Q-Fa
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iM-0000sn-RZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=K0VyH5rpSv2qWcn15X/c1ktc8DjuhIzw2bRqKZc5zIzyL0xFp9XbppFbJhEoAzbXvbO7w6
 +SBrX67u36x/1O6ED4Nna8HZqzmGM+AVjdWT9sfAJAzen2s+nDqXi7PZ28YGn5VH+ftT6N
 3lQzZx81SCHa6etp2bgKutGXiyTvCW4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-jUUD6836Pout-wHBxs9P_Q-1; Wed, 03 Jul 2024 18:44:32 -0400
X-MC-Unique: jUUD6836Pout-wHBxs9P_Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-58c859c5d96so1038560a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046669; x=1720651469;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=NToue104VHqhuFnp5biaGZPP9vOhMYlPO8ssNuHI03H6xFFNF1GTKOSf+wYJwOrcoL
 Y4naQ1wBtWye/qekII8hgkSBoby9zrwZF4BofuF4eYc/fD+i1717VBVVJKq2eAPkW8lT
 sVaKN2NPw+1TBo6SGm9T21AgiJX1hH6xWaEqHRvSq9GziaoUo1R/hZhJJungOD8h9lhQ
 z5tJAdxHtg1QLcDGd0EM/B3RBB6BFFXAu3LwvP+C3h5AM5HwZbJhNP8S25VhnkV9a08T
 +Vh+NdBuFRHl6eP++G/OncZ+jSFS3AFIRLtx+h1FzXTesTteePGM2ailDKH5GHeVmeVy
 qC5w==
X-Gm-Message-State: AOJu0YzVISAWFBA2v+Di+m+u8EY0yQqd2Ze7WrOCSL8d/+WxEVjrp4FD
 tq8h/8DSLGnDohSYA+kmhFjzT7Klb0SK491PwVIi4sh/KpE3PibmrTp6GcPmWncFCW3cQQnxV6Q
 2OZJcmOyhRdG1pTexlYnWQCCwjAvsqIA1SbMbcK7m2vuCFqSpCM+7qwJgkIlF4hP2wdioQ67Fx/
 1d73Z3HLfqr021xPb7yF2OwhdJAv9Oow==
X-Received: by 2002:a05:6402:1e8b:b0:586:e6a4:c173 with SMTP id
 4fb4d7f45d1cf-587a0bfc6b1mr8196016a12.28.1720046668963; 
 Wed, 03 Jul 2024 15:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1d1GPAdI2F06sCYFgpvk4JO5xApbuY9Xuo/L8KpkO9Y+sLuGXCWsuVH2M0HkQAJ5YHoeRLw==
X-Received: by 2002:a05:6402:1e8b:b0:586:e6a4:c173 with SMTP id
 4fb4d7f45d1cf-587a0bfc6b1mr8195997a12.28.1720046668391; 
 Wed, 03 Jul 2024 15:44:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58ceee04b51sm1362861a12.71.2024.07.03.15.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:44:27 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:44:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 03/85] vhost-vdpa: check vhost_vdpa_set_vring_ready()
 return value
Message-ID: <9d5a807c4cb56837f11be9a9250f854fab951290.1720046570.git.mst@redhat.com>
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

From: Stefano Garzarella <sgarzare@redhat.com>

vhost_vdpa_set_vring_ready() could already fail, but if Linux's
patch [1] will be merged, it may fail with more chance if
userspace does not activate virtqueues before DRIVER_OK when
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.

So better check its return value anyway.

[1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240322092315.31885-1-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 85e73dd6a7..eda714d1a4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -399,7 +399,10 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        if (ret < 0) {
+            return ret;
+        }
     }
     return 0;
 }
@@ -1238,7 +1241,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    r = vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    if (unlikely(r < 0)) {
+        return r;
+    }
 
     if (v->shadow_vqs_enabled) {
         n = VIRTIO_NET(v->dev->vdev);
@@ -1277,7 +1283,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->vq_index; ++i) {
-        vhost_vdpa_set_vring_ready(v, i);
+        r = vhost_vdpa_set_vring_ready(v, i);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
MST


