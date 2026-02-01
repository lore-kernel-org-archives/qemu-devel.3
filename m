Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C88AE65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgki-0006I7-7C; Sun, 01 Feb 2026 18:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgka-0005xL-F3
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:21:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkY-0000N2-Cn
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:21:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so31490725e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988061; x=1770592861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y8sx2MjjH2xIWfAsCvCax2QQJrx+zY+UiIZh3tX/d0=;
 b=ZxF3MvnMgolGAIMN0vKmPyDffY6bVXzI5YRw6FmoRUKdNQCBn/wiy9R4OweQ9ayRRh
 sh2gom2HfzB0WqwPmCRl4f5oafM9O4jcDamgLqNyBWHe+hmGiK5l2oSvIyDYJD925rmg
 Z11FKP2DWyitq82aIS7csRfWQ4hgn1ekuJtM1eATOEQxxafufPTHwshO1gycpYBCAvcF
 BRVzUoE7jyroh3V9x0jq8VPcC0c5WwCvqUYirM07OWV+GT5FZmV+ScWcEhBtUzzORTdN
 8z+7Y1Iyx2a1wCbniOmDEAEbHNYpD8rARZGX7AQvRlWzloxJZsLEeKZ/REtXHPCfyT6v
 2eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988061; x=1770592861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3y8sx2MjjH2xIWfAsCvCax2QQJrx+zY+UiIZh3tX/d0=;
 b=mpXvBJmflS6ORx+cNh7CbsMCyXcVZUwmcuDMCrKfdL5ZdtZM0E56wHM3pIijU665zh
 gtjwKJxXkDBZeX7mI8n5GgK/lGihxSST4Ru8Pa3zYc4gSddSA7s78aHNpNSY0MQWi+SI
 0oDrrEQQCVGwtPDJW3R/vL0g+Wgh4PGVZayMN+bwcJTJtC531UYzVuLaF8+LGUSwaaWE
 kbqPN/k9BgME/fdhk0LCR8gKw4p64WDsOVb1+3I9yhWMcBXIVZHIVNp2OUsuJUqOdRJu
 K/omt4vljoDwu97jy0/riL/SbOp7wE61J+5rfx/Kj1vfKFlUaaMoVae8Lax69YnNEZBm
 tqvA==
X-Gm-Message-State: AOJu0Yxtgo44ags/jAFGNUL7YHvWcdPwaGjqBHxlktOTjXcqJzEBD0xI
 VGYjVtrtJWJ1xJLadR0H4TPVHaNs2ax/LCfNN5/ZXkXs6bkJh12Z0nEW4mkEEFGaRcsKC4pjfIX
 D+MX+bkQ=
X-Gm-Gg: AZuq6aIiMBW27tcXRZ1Z4iiAf3pbywUsk/QYfqxSR1qblhIZvKfj2q1nxn49TlM2jBE
 jaARLFcTxNIE8aD94HaY0s5V/6Rr9tFy3chrcwX2EN/Bq1pYEznCiI8mrowB87i+AJmKATs027P
 UgIxrsdAl6IeHPdh+8yD8rvRXY9WkvWkYSGc5gStv1u+MBU5RK9jwOMSALqP3tKCj89pq77K+Rr
 kXzNIDDVUP3i1BnN5+E4XLc1edKDV7dzfvZS4Tijxc9zJqnrqDA6D87nABx4mh6gsDGpbgunHX4
 tX6pAKREZhXaF5KNUK8eKKBkk0tWsxIzBbFy4tXuBSNVg81awL7Tl+X/6ylnfA/MtFiUjMe5bCB
 Ep1hYxd3Km+aZiE9sQIXcrk385JeL4t9N9YWLoNpexTPszy/rchT8TjSEf+PlKhVmbR1Slg45Po
 70UxF4fSE0p+PCN34+Z/Anr98a+DgpTwaFrj9ZxF4TNjAJrpQan1EFxoP7WlWe
X-Received: by 2002:a05:600c:4443:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-482db4a0fb8mr140679925e9.30.1769988060668; 
 Sun, 01 Feb 2026 15:21:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c40e04sm428898275e9.13.2026.02.01.15.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 08/10] hw/virtio/vhost-user: make compilation unit common
Date: Mon,  2 Feb 2026 00:19:57 +0100
Message-ID: <20260201231959.88559-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-user.c | 11 ++++-------
 hw/virtio/meson.build  |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 63fa9a1b4b1..c8a004c6d2d 100644
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
@@ -2280,7 +2275,9 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                 return -EINVAL;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
+            const uint64_t vhost_user_max_ram_slots = target_base_ppc() ?
+                SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
+            u->user->memory_slots = MIN(ram_slots, vhost_user_max_ram_slots);
         }
     }
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index affd66887db..ee397aaf196 100644
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


