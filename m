Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75563E65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgkG-0005QB-7W; Sun, 01 Feb 2026 18:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkE-0005MQ-DN
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:42 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkC-0000LL-QS
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so31964235e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988039; x=1770592839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLtJ/i/Ej2+3rrcoaflUWytYyH2WFju1TAatGa5vnlY=;
 b=j26XsGQGiSZkq9UcLcDr7zDVzhAU/WvK76B/58sTxVBAYheh1d29dCJ7QdudqjX1K7
 H4iCupHFaba3aH8IotWhgTuDMXWzlQanHuIf9A7Y5nO16fuN7XlnjwKV6nGazPP/TWIu
 EI/EMdGISIqhuTaJSf/6eAVNQZFKSYg+zwkFUja0s48F9TDTztnb4TsaTwqHc61IKud7
 7yZPSbOnwd431Ig1YeWHim0kHclhYbsQhEfLV5crwWzKausn++8R7rlfpl/S1PcESXYi
 ii44Cr3LKVwsdSNZ7sSN5dTAY6VN9H3gDQxHtAADcwQmIVcplnrTbIgCHAAo3OhSoYLx
 vi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988039; x=1770592839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qLtJ/i/Ej2+3rrcoaflUWytYyH2WFju1TAatGa5vnlY=;
 b=QP52NFMlEBs43GsuFPc+HfI9XRjvIgVBppWs94HcKtbXUjRtOpwBA6kfcxLcUOekHz
 t0PTEY+Jwl2XTTzaK/hBhdUS9y/1kl0CzboQkOcEimhiwWd2/g6U93ClWZMvfxWzUTu/
 aXvoGCxE0Bqgt5Tucs6DSJNsdIxmZsEonCeexXi2c+okNDqE4Nd+q+FpOvZQ0krtszW0
 j6Aj+ZW5Z3sGUlsajnBzj1dtbPaXq/0WT4PDdbvpl/AAf7RPWbCCa4GOw0SgFwiPiEUB
 a71MfQvlDtl7WrCuJRhG0oUCpSXzgaHrMjPHrohZnry7vNUdfaTE2+wd3Prewmw6/jnF
 IVVA==
X-Gm-Message-State: AOJu0YyYiOMmuV8G8ZUecVBdMGQfhCAqj35OjeTOlH5TZWCTaXkFuWzc
 omXgwKZz3dCvWZiefmKSVaOJT4JDzsFmLWeGpIkHo4qFS5SO2VBso/WPkcMtUC7+bgPWilMY8o/
 ur37KwMo=
X-Gm-Gg: AZuq6aJpLq98JWSGn5UbRgSgCa9ZWseDw/xKD8aYqPSqhvLEePGIc5S4FZ4dIldP0ft
 s+PWQaX3jGnp3E9PiKgmOrBN3EFjcQaI4yuYe5IH/3kkl+s2G7zimiqhmlIk2InlLnvv2ru9aDA
 v+8fsfvn4mXEDYKDtTayaYsA8LO2yx9eESnqpUgn4dClahw9NyelmOyUwhxMNgLbkd5sfQR7uAt
 hI/wi0cTEp4xxlWH1OQ+9Z5B2CK8DedTIj/LOHZjjgxTI0TJ2uCAUVEZTGL+fKPx3BkaKBThqEx
 opsmdPMXs09VCKETF0AWFno52u8WndNkKpz/VJHH8klO6oCDIreVN+OWROXJ6CcK273PDQeSoqo
 1zpc6YVGOkGT300XiuMPc4Ukulwa98CA1mPJj1C7B4g1+Ve74JAxurJQgWhJgHEReLoECo/kDUx
 CRNO9/LAtXTwfc95HxCPTLl275Y88qgYOt1NOTqZvj9a+dTkzIS33abs4VCc2e
X-Received: by 2002:a05:600c:6214:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-482db4973c7mr114254855e9.37.1769988039062; 
 Sun, 01 Feb 2026 15:20:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c37420sm446531005e9.9.2026.02.01.15.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 05/10] hw/virtio: Reduce virtio_access_is_big_endian() scope
Date: Mon,  2 Feb 2026 00:19:54 +0100
Message-ID: <20260201231959.88559-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

virtio_access_is_big_endian() is only used once in virtio_reset().
Make the VirtIODevice argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 22 +---------------------
 hw/virtio/virtio.c                | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index f3b4d0075b5..c6b76979749 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -16,29 +16,9 @@
 #ifndef QEMU_VIRTIO_ACCESS_H
 #define QEMU_VIRTIO_ACCESS_H
 
-#include "exec/hwaddr.h"
+#include "qemu/bswap.h"
 #include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-bus.h"
-
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
-static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
-{
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
-    }
-    return true;
-#else
-    return false;
-#endif
-}
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1dc60d37cb4..627a929b063 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3233,6 +3233,25 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
     return ret;
 }
 
+#if defined(TARGET_PPC64) || defined(TARGET_ARM)
+#define LEGACY_VIRTIO_IS_BIENDIAN 1
+#endif
+
+static bool virtio_access_is_big_endian(const VirtIODevice *vdev)
+{
+#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
+    return virtio_is_big_endian(vdev);
+#elif TARGET_BIG_ENDIAN
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+        return false;
+    }
+    return true;
+#else
+    return false;
+#endif
+}
+
 void virtio_reset(VirtIODevice *vdev)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-- 
2.52.0


