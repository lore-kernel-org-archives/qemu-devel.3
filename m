Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68B1D232E2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve65x-00021R-7w; Fri, 09 Jan 2026 01:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65s-00020w-HM
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65q-0007Nb-DY
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:32 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso35307575e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767940529; x=1768545329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+J5mIPS+jOoqnBN8dMAKPf18ftseLrzM2fMBdN6b1I=;
 b=MjLiCyLo6jV4098iuOydRY3bWzpa/bExt2Hxa6yPoeOohSEeoVZp1KSB7ejJI5NLhz
 zojotOdQ24ightJIOP5dMzMC9AXVWlm5HJaitv3O7/NofZGzgfOwqgNORtdPgvyev2di
 L0mzeLQVdxOnrMk7VnrasEYOsVWtdVu4LKOKfDNrFzpqLxnckmZNiTu4xPhFkoHevdiK
 Gi1Okw7/MtX6mkoZCgJt1IAXqE0AU3Zabdt9Xf8JjDmWXxjENHTapBzGEKVacnk1FypJ
 IzOIc2vQ0+o6zWTWz91y2Oyw5DoEAGvjOms3RjnM4nxKPa7Z99B/6pM6N1TU9DlDNpwZ
 C7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767940529; x=1768545329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T+J5mIPS+jOoqnBN8dMAKPf18ftseLrzM2fMBdN6b1I=;
 b=VbkTmpsSd00Ucbida8P+jVWPQ9nCsHzoHdhVahwuSa7w4rFIFSwBmRoRcW/c83TcFl
 Aq7Pxfifca6cPu8+eUvrBL2kzHp9rlOejklzWeXm1ExYhULKI4Zo8PaEycSm231xsKFm
 1y1lBj+jV70P5rEn78PCZLqjZ17jo7zm8WV4DiQtYmixiVSyqkgRukPcwTGTPf3otLwW
 O8c5JaoFpMyWAhVsqFzdri558mdvpM8Ys3Va3YjayTj50Bhgd/s3L3he26ToYTp3I8w0
 UGnITmNqigO+0OpY6CXIr+6BgBA/Jd+i8VdJnDyQAxNiuBh9X58TZEmdVgPN/hXGyaET
 dT/w==
X-Gm-Message-State: AOJu0YzJQE86pnr+6X3aHX+37lNAHWfaWsVxT+lMLHX/8mKIY7z9DSiS
 13kVvRQleAvq/Y/SuANrBNYRaLIztIXzaY+rfxuksPu8+5pT+t+EvUOQS0q1vQCFj4ehCp9W6mz
 5iHfb7G4=
X-Gm-Gg: AY/fxX6uRLPDIlwqjuIMuosVgU4ODXODEhg5ThFzu8OCdj1SZ5Kwk71Dub1v7prUG6k
 /Fo+y8BGFob/uMcemN/fTKWML54HkZY6VPKfFQ67Eb7Ho1VIgF0xRYwSV+ltoPBCvnIrn7l+ryW
 aZt53zbDkd9vk9dte+quncotTqiHaDIt8w7FkAxsFpcappRRxJifRjOzB9FyfK21Rnq+RxKfWvj
 Tfp0bfh/qnRPVL4VJXME+rxYXsF/FFMNstF1iIR4Ek5dE4EkNj7fUmXY0pwFr1qOd4szvP7mati
 wyjMUpCVQPJcwMNJJRp1D0Rx55YEwkgCuxAvSDNDabREGwZv1wWqj0zn7J2aBr9BMCIp9b7MV2i
 RjL3TKlw6YyfNCq7Ig0erxm340lLr2sGceFlnHAKmIGmSCaxW0FycJ6yC3LeUv/1elhJZlLIHco
 2d8ZAZRKeuXun++suXOuCwYqCS6j7B11HTYwzcvjx2OWzWcVSDjhgtW14im+OF
X-Google-Smtp-Source: AGHT+IEAUeSmNz0nV9uLT8W7iQw/ofFYJWxeU28ichZTS1aqLyfrQXVAUX5ofjuyOCqmZM5NnoiY1g==
X-Received: by 2002:a05:600c:4747:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-47d84b18a7dmr121215555e9.16.1767940528564; 
 Thu, 08 Jan 2026 22:35:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8718c610sm54550455e9.15.2026.01.08.22.35.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 22:35:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 3/4] system/memory: Extract 'qemu/ldst_unaligned.h' header
Date: Fri,  9 Jan 2026 07:35:03 +0100
Message-ID: <20260109063504.71576-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109063504.71576-1-philmd@linaro.org>
References: <20260109063504.71576-1-philmd@linaro.org>
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
 MAINTAINERS                   |  1 +
 include/qemu/bswap.h          | 62 +-------------------------------
 include/qemu/ldst_unaligned.h | 67 +++++++++++++++++++++++++++++++++++
 accel/tcg/translator.c        |  1 +
 hw/display/ati_2d.c           |  1 +
 hw/display/sm501.c            |  2 +-
 hw/remote/vfio-user-obj.c     |  1 +
 hw/vmapple/virtio-blk.c       |  1 +
 net/checksum.c                |  1 +
 ui/vnc-enc-tight.c            |  1 +
 util/bufferiszero.c           |  2 +-
 11 files changed, 77 insertions(+), 63 deletions(-)
 create mode 100644 include/qemu/ldst_unaligned.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a55b649e8b..6602c9891db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3257,6 +3257,7 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
+F: include/qemu/ldst_unaligned.h
 F: include/system/ram_addr.h
 F: include/system/memory.h
 F: include/system/physmem.h
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 39ba64046a6..e70452b425a 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -1,6 +1,7 @@
 #ifndef BSWAP_H
 #define BSWAP_H
 
+#include "qemu/ldst_unaligned.h"
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
diff --git a/include/qemu/ldst_unaligned.h b/include/qemu/ldst_unaligned.h
new file mode 100644
index 00000000000..201e32d0734
--- /dev/null
+++ b/include/qemu/ldst_unaligned.h
@@ -0,0 +1,67 @@
+/*
+ * QEMU unaligned/endian-independent host pointer access
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_LDST_UNALIGNED_H
+#define QEMU_LDST_UNALIGNED_H
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
index 034f2f359ef..d767e5dff24 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
+#include "qemu/ldst_unaligned.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "accel/tcg/cpu-ldst-common.h"
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 309bb5ccb6c..08f722cd63e 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "ati_int.h"
 #include "ati_regs.h"
+#include "qemu/ldst_unaligned.h"
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index a07aa9886f9..1c38b17b04c 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/ldst_unaligned.h"
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
index 4eb036a5469..8d99b78245d 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -49,6 +49,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-events-misc.h"
+#include "qemu/ldst_unaligned.h"
 #include "qemu/notify.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 9de9aaae0bf..3acb29eea88 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -19,6 +19,7 @@
 #include "hw/vmapple/vmapple.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-pci.h"
+#include "qemu/ldst_unaligned.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/net/checksum.c b/net/checksum.c
index 537457d89d0..ea55b468060 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/ldst_unaligned.h"
 #include "net/checksum.h"
 #include "net/eth.h"
 
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 9dfe6ae5a24..78ac7a2eacc 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -42,6 +42,7 @@
 #include <jpeglib.h>
 #endif
 
+#include "qemu/ldst_unaligned.h"
 #include "qemu/bswap.h"
 #include "vnc.h"
 #include "vnc-enc-tight.h"
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 522146dab97..ca38606032d 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "qemu/bswap.h"
+#include "qemu/ldst_unaligned.h"
 #include "host/cpuinfo.h"
 
 typedef bool (*biz_accel_fn)(const void *, size_t);
-- 
2.52.0


