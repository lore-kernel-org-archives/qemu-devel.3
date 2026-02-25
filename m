Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99BCF55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6Nu-0005iZ-AY; Tue, 24 Feb 2026 23:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6Ns-0005fD-NB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:25 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6Nq-0004va-Uy
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:24 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4398ebdf520so197916f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993221; x=1772598021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k79VTLfU5Oa87plgJB989pAwTzMW5t41mAFF8XhFDE4=;
 b=wk7ploge/aBXI353DpltErVG3bvu8FKUnZ/9Bj8F/YHhjuvd1+kaI2gAX3EwTPQFB/
 6FvSQ4Sv2S0DN3PhEcyg1CL2hL7KhONZclZXquW6nU0oM6MglOUJfqMKNRGQ1ALP8s0i
 wYn4NtmBUTS4ufLa0rTHucSGFmwCr4apHgkgqVFFDA5HfEXvDtV2DwwWVCrQefiwzlnH
 1Ixd5cf3FFdIwLCMhR/NjDgCpRUZDw8hnUjsIEkoTAU5zpMKAvjsK3y0Oi+/jaL88SyJ
 siRYRATzrGLzRfmcI/W+i0Hc9uRzX/J4Dge6jNvuzU4fy9JGCJixVFduEZlZV7YNRKIq
 FOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993221; x=1772598021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k79VTLfU5Oa87plgJB989pAwTzMW5t41mAFF8XhFDE4=;
 b=bnp7jwl5b/oZhzla7t8SUuj9XHfpIdcg/sDy+N36xDVzR2xeOYxVr3WSarIcXd6E3M
 WYfFtZCqSpw0W95VppriRwxQvXZ4TrxTDOU448pbPi7ojBrUPYotaaMwqC3tHjPXMhoS
 dn52Im33BjC5ARHuyDYhJsk85ugDqmxmnmxMy7nkNrmCkyPnY3S8wgT82MnHvVQKO6TN
 oomrpkydKcKFiWs1SC8g17AuEBZK/UD6SCvEwWdd655J7Xob66eM7ovWFs3k2/1n/+o4
 PEFzg7sK1qelsSZsNMxRs20iolZBCzn5UhvBPPV7/pi7CUFNDKQooCC8LyuiPa4Z7F+2
 TZ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4gJMkczZ+mAzY9szIBzay7WBC4Z2jSdKu/4lETfGNYbRMjOfsJtetNAl9mmI2uYtbfiGapwjjhUhl@nongnu.org
X-Gm-Message-State: AOJu0Yx1TDp2saCU3mJN/TQy3Q765aP9j0IVtb9gZC0Ur/Qi0SODX7sQ
 WxjXHpFvW7qSxoU0xER2dpRb+8wR/XP2dEoq5kIrhSRmGFYC8AUqNjotfsh2Yost2ik=
X-Gm-Gg: ATEYQzxDstg2iLvuyWUj4aVloFia1Sr6EFOe2iesHFWPhVksAJFnkHertE4XmPwnhYo
 AMQ1qnmkQTpFO5Wx7lvPHT+P/7NjLb4q49upHWv6Y/PC3ue9EuI5V89PfTqQZ6zmCUvAWcO9TRM
 7XPyEumLYzAH//dHBWJjvLIyh4tMSjjWRemqEikn7q45POOdu1fYypUe/Bhz6OnzapDb5i3l4KJ
 6NpA/l2ADoNs420djIyln29YsaaD2x4eZ7HeAWT3Tc8VrYcMhbc25bwPqV+RtfhNxd2CW74r81+
 K0Hs6Rx72fcbJzwKrEOgvpnZb3o+D14j1cwOz9Xheh7eqWU63QYOvnNIPrGD9+x+RwWDeU1cBG2
 fHu595YT5Ic3v48wdxcHtQm23G6XTckcNxLkosHWpodOHWN09E7oJCM7hAo7MLvJUx9v3wTdZsH
 DdEFgqVwDvwQE9e+N5dF+D6A6s8Zmo+P0tSNzjQRqEFk42OJbOVXBo7T2aOkom/QTiO/jqzryO
X-Received: by 2002:a05:600c:530d:b0:483:78e7:ce15 with SMTP id
 5b1f17b1804b1-483bd76b9e1mr33624425e9.13.1771993221119; 
 Tue, 24 Feb 2026 20:20:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c09897sm31982953f8f.17.2026.02.24.20.20.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 20:20:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/6] hw/virtio/vhost-user: make compilation unit common
Date: Wed, 25 Feb 2026 05:19:45 +0100
Message-ID: <20260225041948.52929-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225041948.52929-1-philmd@linaro.org>
References: <20260225041948.52929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
instead of 512).

vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
define stack allocated buffers. To avoid changing all functions to use
heap allocated buffers, we keep this max, and simply add a
target_base_ppc() conditional for the single place where size really
matters.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-user.c | 11 ++++-------
 hw/virtio/meson.build  |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index bb8f8eab77e..a8907cca74e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -44,13 +44,8 @@
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_BACKEND_MAX_FDS     8
 
-#if defined(TARGET_PPC) || defined(TARGET_PPC64)
-#include "hw/ppc/spapr.h"
-#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
-
-#else
+#include "hw/ppc/spapr_common.h"
 #define VHOST_USER_MAX_RAM_SLOTS 512
-#endif
 
 /*
  * Maximum size of virtio device config space
@@ -2287,7 +2282,9 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                 return -EINVAL;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
+            const uint64_t vhost_user_max_ram_slots = target_base_ppc() ?
+                SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
+            u->user->memory_slots = MIN(ram_slots, vhost_user_max_ram_slots);
         }
     }
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 3af34ef9321..4cc8c208a45 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -17,8 +17,7 @@ if have_vhost
   system_virtio_ss.add(files('vhost.c'))
   system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
-    # fixme - this really should be generic
-    specific_virtio_ss.add(files('vhost-user.c'))
+    system_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
 
     # MMIO Stubs
-- 
2.52.0


