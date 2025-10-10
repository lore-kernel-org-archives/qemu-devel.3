Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAF8CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DPz-0002eo-Vw; Fri, 10 Oct 2025 09:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DPp-0002X3-3o
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:44:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOx-0008CY-6H
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:44:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso22403795e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103793; x=1760708593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEHpoi3UcJ1d9mK9rygYrDQXxzIPGGRGzqCX4yQQSa0=;
 b=dmeNUJ+9eo3l31jh8ljJPM2HNJ9PPcqFqI1JP08q8y01nYGHCkAo1mu8I0FBK7WTuP
 j7uI9AKrp5BULjVhfXngRWB0ly65GysS3jgWAu7QnWzpBkrXTxz8ToqKRxTkZ5l2Bmua
 IaJ8C/Qrp7QdOn/HUsGnsDS0DMlmr6BOIkzQgrZzl8rP2jU/d6KJ90gTXWHobITHEQ3h
 mlIgm4IiyLPGA68qDLZH0jcDH1m9UqJ2MlG74tmT2X8vidac7BgAlRz1LHL2CgQbh5Of
 nZyFDWUmEBItZqLr46YKNVf5PkWQhUXkyUuawaqoejnzeBl8ODx1/cqU5ggy4+TeI3fi
 vYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103793; x=1760708593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEHpoi3UcJ1d9mK9rygYrDQXxzIPGGRGzqCX4yQQSa0=;
 b=NTlRRM/FnkQCpZjDkE8CLSl/k5qS6D9YEh+iKiXqPeI8Y61XauTFGStGbbs9pZVR9d
 fCHdWZoB1aNxFPTYfUonxXeXVnVU2LwDFj53JmH8wRtNTT+vL+xyKiHssvZYsnDyyiVt
 N3gOYlBPbYmTU4aZ8m8VBZKKO5AXQHcMZAUmDSjA3N2tygZrmyoJ7DNU8gbzUEO9niIW
 BbbNeW8f5kzwgIIqgP6GIrDTqcOxGhHlc8UASb2x50/reLtAe6o6tuY+WxbdC+9dR9Iw
 MIAhES0yhHxhVGRPPcAp9hh2Vpj6MHnsuVb0WfO1d0X5BCwGhmMEeRvaqOHgifOXasVZ
 tgng==
X-Gm-Message-State: AOJu0YwX4gfafXv7nTThR7Uff7ZEB0K/AKKEaWRU1zKVLVzLfrtOvOyC
 fUjxXIMd+GvqNE6u/PM9oZa9h2SFuNc2dvVfJCGmGhXTSA1Oc39zSySbHyN60pEUYJ3w7f0C/Hh
 6RXvHIhhIpA==
X-Gm-Gg: ASbGncuyRHFACHji412TnGkl1OEKIjLsWjsEcM4ZyoZS4Ib1pL7Ly0aVRLdSxJqk2Nv
 0coATLkXLuYdwZQHqwRB+nNwk1MOO4/OXnhskWO32PaKbisVQAEXIxaaQhdxd8xmQqC6v1bl8jG
 pcE85ujEcDgztqSFQE51+ool2YkFi41gyODHGdVTc5XLCYIrtTjn/A7t68LAwYN63T356/U9gT4
 oe9ZsdLYOPH3KTIcY/NKGLCeAqRDksLwT9x1OM+WvDNags3nt66Fqe+8kfebOEHixr57ZJHV58V
 jYc7BWjEhQGT0sA7Fx/ieCUQYU82WVfcLuols2H/8CYLCRtAQT1kO8Udl/ZwV6dWf/D+dg3w9rL
 bvhxKLP0lbzJg7H+mT6Lyxb8/tIWq9h+e4WiAVHkccvH3/xbkSZJCb96a+WqtIaXDuzg/PXo6XX
 6ANCD5JlW0ZFxT6i7g3CM=
X-Google-Smtp-Source: AGHT+IGMyuXiXr2hhS5RrEBqHmkNz7q+JdBDAhdMbSHh7UARDHiDg+5JVxi3RtV8WP/bCBvAXMkyAQ==
X-Received: by 2002:a05:6000:2410:b0:401:a3d5:5687 with SMTP id
 ffacd0b85a97d-4267260e17emr7032365f8f.49.1760103792680; 
 Fri, 10 Oct 2025 06:43:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm4549912f8f.10.2025.10.10.06.43.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:43:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 08/16] hw/virtio: Replace HOST_BIG_ENDIAN #ifdef with runtime
 if() check
Date: Fri, 10 Oct 2025 15:42:17 +0200
Message-ID: <20251010134226.72221-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 6 +-----
 hw/virtio/vhost.c                 | 7 +++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 07aae69042a..80328912ad3 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -149,11 +149,7 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 
 static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
 {
-#if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
-#else
-    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
-#endif
+    return HOST_BIG_ENDIAN ^ virtio_access_is_big_endian(vdev) ? s : bswap16(s);
 }
 
 static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a1..6343477b42f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1168,11 +1168,10 @@ static inline bool vhost_needs_vring_endian(VirtIODevice *vdev)
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         return false;
     }
-#if HOST_BIG_ENDIAN
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE;
-#else
+    if (HOST_BIG_ENDIAN) {
+        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE;
+    }
     return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
-#endif
 }
 
 static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *dev,
-- 
2.51.0


