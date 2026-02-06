Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25991EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAj-000688-Bq; Fri, 06 Feb 2026 17:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAe-00064b-6y
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:24 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAc-0007Ct-JF
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a7b23dd036so5747235ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416361; x=1771021161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wR8eQ5ZxxmM/HWX8a067tu8BKTDOb21TMqDSCE6svOU=;
 b=YmTYRJ1bVOMoxdga5Lqf4Ea6h0jGcjRLBjmJVS43iTPGM6+GZqpHCCrKZEGMW0BdYm
 lyW2S59rdHGLVzgfzQ8eBu+rtrGUoSLm+7uI/4OhwuGvlqxsXmmoVz4Tj24tJEuiJpX6
 AZYhUdqNKOalQ/sYC3bDwmj8F1r717o7Sz9eVyr7mTTCrJSrjp4dk000qFw+HvP25dZH
 rPnK8fQh3p6mAoFgeZ4MxefXUykCJFJDrfQ0BrGZFFTFP0bEatuA6yw9TqOWfm8Bis1f
 8LKFKomSTFb0ohkMOz8Upj4TZXjRwFZaNWUiFeA1aQdt1qNToM5p0L0VR77y+OfmvZ58
 HNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416361; x=1771021161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wR8eQ5ZxxmM/HWX8a067tu8BKTDOb21TMqDSCE6svOU=;
 b=Ds4zO3DioAOxVDxPNF1ojjJpKL6mVwa7NXiFcmcqd/yMn10S2B8zZY1M7d5qGtVvjY
 1LhWu/UJjN8DzDv2HN7iWyIvJroT9FnovqUHuoHfjjcn3V8aMdH9m2GxnCJO/RhUF2lN
 5gaWfZtgiuAtzBt6yr4vrCZ/WA4AyN3ubeVz9bzwZ9mBtDlXT8HdG5OWe957UNpzRHzq
 yF9y5CBgAe/oHNgmQ0Bt4xShZ7ZQFPWauWS4/bcoD4uhcMbIffn8UZFfwp3fhLZhN9SW
 HLK3VIyHk7n+HQT9/PclXM6l42Sthd/jR2uL2zPaXdoswk+/3K267fo7hOkfcBAPvh1O
 O7pA==
X-Gm-Message-State: AOJu0Yy+liu3lLosZxwZOwfcnaKoHstaMFFg5lyfqe6LOSykkoehHQ4j
 v2m06vn7SCVGncmNMxji7I4u55RkSTFumX6m5n4JsrW3q8XB9Zba3m+IJoa3esVU/Q5oqfL8twj
 M7zu1
X-Gm-Gg: AZuq6aJLlyeEBnH/Re/aqdvhtfN4EJAY3D+FU1Kpvg+o9JEXAKGMgz2V9tCYtdGHL4a
 uPnD4mXPtyOT6Xo0yqyNAat+IBNhoVglCo5v2S/up8KLNo+lpmRFidsHavE/8yA63bxkMw7iUR4
 Gqvoxnk3HSwb52rJ+qVSHZeF9reBPjfWvzf2YfV8+VuNTC0BGBezATZOPPMyr4eN+36mL1RRb/j
 FduV55pvtQ6ou12lChLZLdvOxLVacRdvr1ARvM8x6lrp8GWqEdhVRTJ8gQVTxgl8aUmbo+76sS9
 3qp7eqa0lV1eHFZmLRXOsQl00UECdmPDfDsB0bYdKumhCCddaI2sJFM6hUdnWp6+yIM7pOV0v7m
 wUxXvyxFz/aNt7pb+XIm8zEykw+kGdehSD0Gf9YQIYhDNcatIVI1UnRc16ErLCRjAVC09LeSZg0
 8R7GOIcRGt7KCyM7ER/jihyXhpzx5XJsbCn6MrqsDPRgsSNGnytRWcrUOyQ5T00HFPG0oo0J/RP
 mdu
X-Received: by 2002:a17:902:ffcb:b0:2a0:e94e:5df6 with SMTP id
 d9443c01a7336-2a95192ba16mr33199035ad.50.1770416361138; 
 Fri, 06 Feb 2026 14:19:21 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 7/9] hw/virtio/vhost-user: make compilation unit common
Date: Fri,  6 Feb 2026 14:19:06 -0800
Message-ID: <20260206221908.1451528-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
instead of 512).

vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
define stack allocated buffers. To avoid changing all functions to use
heap allocated buffers, we keep this max, and simply add a
target_base_ppc() conditional for the single place where size really
matters.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 6675b63ce65..ae33d403cf7 100644
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
2.47.3


