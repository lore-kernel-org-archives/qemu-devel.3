Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE46E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtTu-0001lG-Ck; Sun, 28 Dec 2025 11:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtTt-0001ky-5y
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:18:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtTr-0007B9-Ai
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:18:56 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477632b0621so52836645e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766938733; x=1767543533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjlSSs+Ox58K0ihK5K2mz8XcZnBVGiQErIpZp5+utX4=;
 b=ZKCQzvfYGShZjHNGNWPnX4MWYgA3miKJg+OZ3/dxma8x0ceNmE+rFY/A/eY+p7CBjM
 uyyFxWSBZhsu3iljxZ7mxs11X6wEtEuN5e2p87C+42B1MkDpP3JjjZjVc513AGlUaJnJ
 4pLZlOvRDknfygAW6WzaCH1ZF0tu27FON1/Lv50wWnTdYcZQbzpEOP+CSFUGYyQEA8WG
 WEu+wh+8557C2ahDZ5dZ59+A/KE5i3KoahY0iwrBA9tlGvXQfbfg7qFAjHDDolnyZEzu
 g196e5MAEDesdsoECDzBppqhwBasR0KcVNkaU1o67kIbvG851suvxHFY536IZsX4QiSK
 p0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766938733; x=1767543533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjlSSs+Ox58K0ihK5K2mz8XcZnBVGiQErIpZp5+utX4=;
 b=cQt0wGgWIMBR9LrgdWDMN0PnHxaoZtGr7wL9tzlSsG/fKZxU6gX+T/8F11u0qvrib/
 T4WDDM2Uc3O3OCslMXXeZUj0T49EHd/0MC5kG6FJs1h5GFbgJ0XWy/Kd0EamiSA8IhU+
 7zQee0KjL4b1t/cslwsqRAleV+3FETTY8klcyD56BH16kgEavDwKeIvM28KFC+563uR/
 6znVMyISov6ZmT1mMqQL0nemX3wCqCx5Nk9T7PJq98nrf3IFnWSGWsRxjZLg+cg8SKef
 5Z1n9Wv28bHlbgFbbsiK/6Clm1JG+HhIqCAxH4k789/ElfxfnG+AnB5qptdxmUXbIxA8
 5cew==
X-Gm-Message-State: AOJu0YztegD2Umx9Loo+Wb0E8Ftwf059oSvmkRGVMP8yveyRuvMfafeU
 TThSstwS5WdGWm999mHhsOUkfRZYjAWMcY53FO2ZG6F28B7LU5zMm0akf4YbTa+eXTD4mScYVd4
 oYfB+
X-Gm-Gg: AY/fxX7vOcOfwgmrRv9EDD/nYEVlcXaXgRsS1R5Izt5iEKUpRFzYx9thMdKII84kyCx
 5vMN8esHWPQt70eopLHyvt5m1FqndNS6KwrelwEHlCP1YAPC47ouKNa4urSe+lfK/f9mIYIC6rP
 yR1YYBSaUGORvcXV6yYRthZxLsXZbTJNRvE4cgw/i4DCrBkILxwlqU5WDBNqeFR0AQTrcATY3PO
 vcQ/rdX8AdydRuwGNJgXkA32BzQ4mexvBUUnuF0Po7BREOnXv5n1oeshZ515RaLdBH3eXoai5w8
 JHH+Fv2oQFseZQLQvT+vgwMOFhprAlJUZEp18MDYQXjsaO1CW4H6BiuvkkQtnkqj/L6OeqgDgHt
 mWRlPAP2upC37mUi1lkrPGkX1KYVFRQSYxmohm4OZKT8UdngmaE3kksJUPAJMsJJQZ50OA0n4LD
 51LO3n6tyA3ZBS2Icvyzbf2cC6zN0+oJpFH9tk/w41oOl3+vxDDc3HtHt8Kn9i55M=
X-Google-Smtp-Source: AGHT+IES5Mk++6zOANMeCOIyNc41+4Ia3eve1/aQc1eydllDnMW2zJhbAjMTt80y6nIMKl7ZdfQ7Ug==
X-Received: by 2002:a05:600c:4ed2:b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-47d195b3c08mr330378905e9.25.1766938733523; 
 Sun, 28 Dec 2025 08:18:53 -0800 (PST)
Received: from m1.home (alyon-655-1-564-32.w80-9.abo.wanadoo.fr. [80.9.105.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm58910416f8f.10.2025.12.28.08.18.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Dec 2025 08:18:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH 2/3] system/memory: Extract 'qemu/memory_ldst_unaligned.h'
 header
Date: Sun, 28 Dec 2025 17:18:35 +0100
Message-ID: <20251228161837.12413-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228161837.12413-1-philmd@linaro.org>
References: <20251228161837.12413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Unaligned memcpy API is buried within 'qemu/bswap.h',
supposed to be related to endianness swapping. Extract
to a new header to clarify.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/bswap.h                 | 62 +------------------------
 include/qemu/memory_ldst_unaligned.h | 67 ++++++++++++++++++++++++++++
 accel/tcg/translator.c               |  1 +
 hw/display/ati_2d.c                  |  1 +
 hw/display/sm501.c                   |  2 +-
 hw/remote/vfio-user-obj.c            |  1 +
 hw/vmapple/virtio-blk.c              |  1 +
 net/checksum.c                       |  1 +
 ui/vnc-enc-tight.c                   |  1 +
 util/bufferiszero.c                  |  2 +-
 10 files changed, 76 insertions(+), 63 deletions(-)
 create mode 100644 include/qemu/memory_ldst_unaligned.h

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index b77ea955de5..e8b944988c3 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -1,6 +1,7 @@
 #ifndef BSWAP_H
 #define BSWAP_H
 
+#include "qemu/memory_ldst_unaligned.h"
 #include "qemu/target-info.h"
 
 #undef  bswap16
@@ -173,8 +174,6 @@ CPU_CONVERT(le, 64, uint64_t)
 # define const_le16(_x) (_x)
 #endif
 
-/* unaligned/endian-independent pointer access */
-
 /*
  * the generic syntax is:
  *
@@ -201,7 +200,6 @@ CPU_CONVERT(le, 64, uint64_t)
  *   q: 64 bits
  *
  * endian is:
- *   he   : host endian
  *   be   : big endian
  *   le   : little endian
  *   te   : target endian
@@ -237,64 +235,6 @@ static inline void stb_p(void *ptr, uint8_t v)
     *(uint8_t *)ptr = v;
 }
 
-/*
- * Any compiler worth its salt will turn these memcpy into native unaligned
- * operations.  Thus we don't need to play games with packed attributes, or
- * inline byte-by-byte stores.
- * Some compilation environments (eg some fortify-source implementations)
- * may intercept memcpy() in a way that defeats the compiler optimization,
- * though, so we use __builtin_memcpy() to give ourselves the best chance
- * of good performance.
- */
-
-static inline int lduw_he_p(const void *ptr)
-{
-    uint16_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
-
-static inline int ldsw_he_p(const void *ptr)
-{
-    int16_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
-
-static inline void stw_he_p(void *ptr, uint16_t v)
-{
-    __builtin_memcpy(ptr, &v, sizeof(v));
-}
-
-static inline void st24_he_p(void *ptr, uint32_t v)
-{
-    __builtin_memcpy(ptr, &v, 3);
-}
-
-static inline int ldl_he_p(const void *ptr)
-{
-    int32_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
-
-static inline void stl_he_p(void *ptr, uint32_t v)
-{
-    __builtin_memcpy(ptr, &v, sizeof(v));
-}
-
-static inline uint64_t ldq_he_p(const void *ptr)
-{
-    uint64_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
-
-static inline void stq_he_p(void *ptr, uint64_t v)
-{
-    __builtin_memcpy(ptr, &v, sizeof(v));
-}
-
 static inline int lduw_le_p(const void *ptr)
 {
     return (uint16_t)le_bswap(lduw_he_p(ptr), 16);
diff --git a/include/qemu/memory_ldst_unaligned.h b/include/qemu/memory_ldst_unaligned.h
new file mode 100644
index 00000000000..f6b64e8fe9c
--- /dev/null
+++ b/include/qemu/memory_ldst_unaligned.h
@@ -0,0 +1,67 @@
+/*
+ * QEMU unaligned/endian-independent pointer access
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+*/
+#ifndef QEMU_MEMORY_LDST_UNALIGNED_H
+#define QEMU_MEMORY_LDST_UNALIGNED_H
+
+/*
+ * Any compiler worth its salt will turn these memcpy into native unaligned
+ * operations.  Thus we don't need to play games with packed attributes, or
+ * inline byte-by-byte stores.
+ * Some compilation environments (eg some fortify-source implementations)
+ * may intercept memcpy() in a way that defeats the compiler optimization,
+ * though, so we use __builtin_memcpy() to give ourselves the best chance
+ * of good performance.
+ */
+
+static inline int lduw_he_p(const void *ptr)
+{
+    uint16_t r;
+    __builtin_memcpy(&r, ptr, sizeof(r));
+    return r;
+}
+
+static inline int ldsw_he_p(const void *ptr)
+{
+    int16_t r;
+    __builtin_memcpy(&r, ptr, sizeof(r));
+    return r;
+}
+
+static inline void stw_he_p(void *ptr, uint16_t v)
+{
+    __builtin_memcpy(ptr, &v, sizeof(v));
+}
+
+static inline void st24_he_p(void *ptr, uint32_t v)
+{
+    __builtin_memcpy(ptr, &v, 3);
+}
+
+static inline int ldl_he_p(const void *ptr)
+{
+    int32_t r;
+    __builtin_memcpy(&r, ptr, sizeof(r));
+    return r;
+}
+
+static inline void stl_he_p(void *ptr, uint32_t v)
+{
+    __builtin_memcpy(ptr, &v, sizeof(v));
+}
+
+static inline uint64_t ldq_he_p(const void *ptr)
+{
+    uint64_t r;
+    __builtin_memcpy(&r, ptr, sizeof(r));
+    return r;
+}
+
+static inline void stq_he_p(void *ptr, uint64_t v)
+{
+    __builtin_memcpy(ptr, &v, sizeof(v));
+}
+
+#endif
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 034f2f359ef..86cdd70c47f 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
+#include "qemu/memory_ldst_unaligned.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "accel/tcg/cpu-ldst-common.h"
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 309bb5ccb6c..24a3c3e942f 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "ati_int.h"
 #include "ati_regs.h"
+#include "qemu/memory_ldst_unaligned.h"
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index bc091b3c9fb..51efe2ad41f 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/memory_ldst_unaligned.h"
 #include "qemu/module.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/char/serial-mm.h"
@@ -40,7 +41,6 @@
 #include "hw/display/i2c-ddc.h"
 #include "qemu/range.h"
 #include "ui/pixel_ops.h"
-#include "qemu/bswap.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 216b4876e24..9c9ac8b0d92 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -49,6 +49,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-events-misc.h"
+#include "qemu/memory_ldst_unaligned.h"
 #include "qemu/notify.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 9de9aaae0bf..f5e8e92df75 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -19,6 +19,7 @@
 #include "hw/vmapple/vmapple.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-pci.h"
+#include "qemu/memory_ldst_unaligned.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/net/checksum.c b/net/checksum.c
index 537457d89d0..18be31c26e5 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/memory_ldst_unaligned.h"
 #include "net/checksum.h"
 #include "net/eth.h"
 
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 9dfe6ae5a24..b645aebccef 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -42,6 +42,7 @@
 #include <jpeglib.h>
 #endif
 
+#include "qemu/memory_ldst_unaligned.h"
 #include "qemu/bswap.h"
 #include "vnc.h"
 #include "vnc-enc-tight.h"
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 522146dab97..9548dd3ad1b 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "qemu/bswap.h"
+#include "qemu/memory_ldst_unaligned.h"
 #include "host/cpuinfo.h"
 
 typedef bool (*biz_accel_fn)(const void *, size_t);
-- 
2.52.0


