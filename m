Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB06CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkCi-0004Ja-7d; Mon, 07 Oct 2024 05:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sxkCg-0004JR-Ax
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:38:58 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sxkCe-0004jL-7p
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:38:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so43379315e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728293933; x=1728898733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G3mJuy9MTqHJcFdzPUes48FstkLHUlT+3qihXQ71yXY=;
 b=nIVguD8BFvZXhnVd5QohpHTF+d/Jf28urfJNHGhgLvF7O1119kiy2cSkVEDhp5hYPk
 wJiRtMjxN5lEeaZAOUz0YO6ekiwz6W0TnyccTLw9i15lwD0D5Xg1v/Fu4o+KFw71dRrB
 vsyzepfvO7hpA1577ZRtpohp9/UBQfnsyk5JmfOtzEr28PXS5/1Vs11wqSeMA2LEfrBl
 iymVMyXPFP010Hgr38R3SYyiO4y55VR6Dj2fC2s6D2qaQnUbXojxuh328EM7noWq3s7+
 MXhYzBZ9JJ8KsYVVycHvClxCz5lMi6wMQz4D+jX921rGrt05lZQS+59tiFi7Nlo20cc8
 GIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728293933; x=1728898733;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G3mJuy9MTqHJcFdzPUes48FstkLHUlT+3qihXQ71yXY=;
 b=mF/SqiwzfondSNIho5q56c5/A8bzC5m0rzQv6gEzwX8a0+P31GYzyWG8UzAFcDq5lr
 +phYXXNESxC+/JlttlUjuAa/c4Pfv/vd9dy5Z2F95EUxOl+ldBe+j8wJpreMAKOPKkuO
 fKQ8b+QFPyJoyoSlrxG8xbeEaHMbauHjfebFeFsE/zr+gll1EqpgF6Q4zIQd7lDVAo4t
 PARFInLlBJKjOI65STBd0UuqF2P9RBLox/iUtGulbvoxmwm/hbMdO0b0rb3eyrEWnxzf
 awVg3jAR/VveeY8RuG6vA6nhVIunD5kaFHnJYWcBVSKBZSTtAPionXHN1/oikCXOWKRk
 kSkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCU+oZro6WTcOgFuvWsn7PaoyLMqL0eLuNBdbmDkbsS0s7ajIrZxyKajxd/k8oALGMC0sjIM+EWFfF@nongnu.org
X-Gm-Message-State: AOJu0YxfqwNSKIkH6DOEDlsaWltoPoAeuUBjmH5IgyxK/gUZhNOPzvs9
 cqQlZooqaM0QTHPvscCRXQlzGQPJRMdY1ULj31XmEH1TbIXh0vuRn+fy9lSgH6k=
X-Google-Smtp-Source: AGHT+IG3VFU6vGB8Erka6qoRXJPNBqaVtOfweO4uFnygl+6sZ3+Qef3mCesCTDZmzuzlOYVzDaUPDA==
X-Received: by 2002:a05:600c:46c6:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-42f85ab7cbbmr86053615e9.16.1728293933073; 
 Mon, 07 Oct 2024 02:38:53 -0700 (PDT)
Received: from meli-email.org (adsl-74.37.6.1.tellas.gr. [37.6.1.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89ed9d4bsm69292445e9.42.2024.10.07.02.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 02:38:52 -0700 (PDT)
Date: Mon, 07 Oct 2024 12:38:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mhrica@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: Re: [PATCH v2] virtio-gpu: Add definition for resource_uuid feature
User-Agent: meli 0.8.7
References: <20241007070013.3350752-1-dbassey@redhat.com>
In-Reply-To: <20241007070013.3350752-1-dbassey@redhat.com>
Message-ID: <kzc4r.rllf43ejqjs@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 07 Oct 2024 10:00, Dorinda Bassey <dbassey@redhat.com> wrote:
>Add the VIRTIO_GPU_F_RESOURCE_UUID feature to enable the assignment
>of resources UUIDs for export to other virtio devices.
>
>Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>---
> hw/display/vhost-user-gpu.c    | 4 ++++
> hw/display/virtio-gpu-base.c   | 3 +++
> include/hw/virtio/virtio-gpu.h | 3 +++
> 3 files changed, 10 insertions(+)
>
>diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
>index 14548f1a57..aa6c6416fa 100644
>--- a/hw/display/vhost-user-gpu.c
>+++ b/hw/display/vhost-user-gpu.c
>@@ -631,6 +631,10 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
>         error_report("EDID requested but the backend doesn't support it.");
>         g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLED);
>     }
>+    if (virtio_has_feature(g->vhost->dev.features,
>+        VIRTIO_GPU_F_RESOURCE_UUID)) {
>+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
>+    }
> 
>     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
>         return;
>diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
>index 4fc7ef8896..7827536ac4 100644
>--- a/hw/display/virtio-gpu-base.c
>+++ b/hw/display/virtio-gpu-base.c
>@@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>     if (virtio_gpu_context_init_enabled(g->conf)) {
>         features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
>     }
>+    if (virtio_gpu_resource_uuid_enabled(g->conf)) {
>+        features |= (1 << VIRTIO_GPU_F_RESOURCE_UUID);
>+    }
> 
>     return features;
> }
>diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>index 7a59379f5a..f12869376c 100644
>--- a/include/hw/virtio/virtio-gpu.h
>+++ b/include/hw/virtio/virtio-gpu.h
>@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
>     VIRTIO_GPU_FLAG_BLOB_ENABLED,
>     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>+    VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
> };
> 
> #define virtio_gpu_virgl_enabled(_cfg) \
>@@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
> #define virtio_gpu_rutabaga_enabled(_cfg) \
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
>+#define virtio_gpu_resource_uuid_enabled(_cfg) \
>+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED))
> #define virtio_gpu_hostmem_enabled(_cfg) \
>     (_cfg.hostmem > 0)
> 
>-- 
>2.46.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

