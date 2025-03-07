Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF994C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZU5-0007hq-GA; Fri, 07 Mar 2025 10:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQy-0005s1-R5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:27 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQw-00047t-1d
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:20 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so1120644f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360570; x=1741965370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7c3iP1EwbjahBsBwJBDuZ0vBFhZFt0AdLkeHdIl4iU=;
 b=I+AqqkYRu7/BYHT85Yd6zARaMRV6QX/mfoN2+rzXjt4TbPKmXN5wYnnlr8HO3tef63
 xnS8AgudIH3YnVSU4GDI4luyxNFQzT4VOxWzqbkwGW3PZzv1IwlQtBbiGfjQxb98udFy
 uwwAZB9xvu29+oFn1wbWDvWja9p2elbOFbOKR73P4Ab6+7wO+oDLkaedW1pU0q0I+DLH
 s/79x3DLtXXpXG2ApNYVitnSS3XEE8mVn+DSbZdV6KjZOPHXN0QAK8+c8lDlqdKWGmjE
 k5T2H8KVuItbKLfHijW1jI0SQ0QHSc4D01D6yb6fn6Ku7BYNq9n2D/qf8kBA4tv6vBDm
 RJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360570; x=1741965370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7c3iP1EwbjahBsBwJBDuZ0vBFhZFt0AdLkeHdIl4iU=;
 b=VOYzrOYuNqVseZgJhH66apPbJWa9yjfBJYZpl8nUYzesr+IJwK2/yn42EV5f8JZdku
 jK3OqkTW6bPhzdX/0W7BpYW2rdVQmaWN5MmgjDstvpa+Qr8PMjKci3dAwN46ja1gOLwo
 1pjj/cWYzkSXUW19UmQ0rtjUdmAbnHrVL7hxljVCpLiN23l51RhEVoIEwprqNkSaba+e
 AO9hW4UR67R87azpMfvXhCy3Ty2QdfIqLKMwzWKeFo1wWNVds2LecJTN9F38xlIr5bzv
 1mbET9aM5zdynmMFywC0YYVtWp7xUV0osI39rGVuwoixRfvYy2jQmo5MvyZ1VF0mWl9/
 KNOA==
X-Gm-Message-State: AOJu0YzQkl96L4MK7LSGFGpwOCJbVHKDYD3BXJshyukmai4V7tRSoYUy
 tk67b4N2Dx6d9AKYl1FlEkDJPOgnbHtc/niGxOyPWTOx59xZFqOdiN/Pjacv4eF5x4N0LBaF39A
 3X+M=
X-Gm-Gg: ASbGncv9eUATy4BYr9VjVd5xKSCQXr7wh49KZfnN4MYcWzWsP1/PP/K2M6QWo3ZHAej
 fvk+RkOHSP3DbbARNDvyEwIgkuu0i7HUUVZvfQmr+n5R00jW3qW08rguXvQVIpnbf96EqNgBEiP
 A6o4UPQdGLP50I2WthCJnWjt5Gd5TavemiiyczVlv/PLqa8dlInMpB+j9Tx7f+b4VPiDkqP/ZVp
 kLInsh4TCkEMtl7XYd2SUQCCcNhaqmxnEDSNvSLGpAnF2SoWaMUtE2SIUuZCcm8Ig6eepBkamaf
 x0zWfiLES8oHUVt4ANYkXvsdK/ks8Q4j4vUa7W1XrG810brNPAQYdm1ogT4aJIYX3VeDM8fMqvz
 37TofKp0j51CKzvYLPSg=
X-Google-Smtp-Source: AGHT+IEQ9AsODO0s8uUfgeCwXHYIRH2k5VUAdyvIY55SzExhVfTQUW9bIRUNoXYaHt5n+3D/D+y7YA==
X-Received: by 2002:a05:6000:1564:b0:38d:d666:5457 with SMTP id
 ffacd0b85a97d-39132da24cfmr3211167f8f.42.1741360570445; 
 Fri, 07 Mar 2025 07:16:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdff72sm5699359f8f.36.2025.03.07.07.16.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 07:16:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT to
 runtime
Date: Fri,  7 Mar 2025 16:15:41 +0100
Message-ID: <20250307151543.8156-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307151543.8156-1-philmd@linaro.org>
References: <20250307151543.8156-1-philmd@linaro.org>
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

Use qemu_arch_available() to check at runtime if a target
architecture is built in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 5f57eccbb66..8c40042108c 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "system/arch_init.h"
 #include "system/numa.h"
 #include "system/system.h"
 #include "system/reset.h"
@@ -170,13 +171,16 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  * necessary (as the section size can change). But it's more likely that the
  * section size will rather get smaller and not bigger over time.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
-#elif defined(TARGET_ARM)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
-#else
-#error VIRTIO_MEM_USABLE_EXTENT not defined
-#endif
+static uint64_t virtio_mem_usable_extent_size(void)
+{
+    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
+        return 2 * 128 * MiB;
+    } else if (qemu_arch_available(QEMU_ARCH_ARM)) {
+        return 2 * 512 * MiB;
+    } else {
+        g_assert_not_reached();
+    }
+}
 
 static bool virtio_mem_is_busy(void)
 {
@@ -721,7 +725,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
                                             bool can_shrink)
 {
     uint64_t newsize = MIN(memory_region_size(&vmem->memdev->mr),
-                           requested_size + VIRTIO_MEM_USABLE_EXTENT);
+                           requested_size + virtio_mem_usable_extent_size());
 
     /* The usable region size always has to be multiples of the block size. */
     newsize = QEMU_ALIGN_UP(newsize, vmem->block_size);
-- 
2.47.1


