Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4831CC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WLa-0008Ng-L5; Thu, 17 Apr 2025 17:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5WLY-0008NE-JS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:00:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5WLW-00015o-Gf
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:00:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso9696355e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744923628; x=1745528428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tZRqZAbHaWpbVQa+7TmhBDdgzxaTipSJDVdnXD3spG8=;
 b=yS4GPkh1fHWd3MkDBsQAeZNPZNpPxpNfLCxrBhE8l2wTgqulOv6KjyrfsTpYMzNrBf
 Zdn9LG8RONXZrWVsRRyvVyf3ZjkBUNzegCK7oIrHmvoTJgmIjGHdGJgi8KtbY5Pax1Zu
 qs/PsBXxBYurmylXbTAXhk0xTOwesyX5QUILiB1eUOS4Az7XQ9+SONib82AhoSOL2e49
 jE6cZF1seFes3yEv1Vzw7JGSbm1segoXAj+WnIOPlhwguFD9fHWmuLmalTM8ZzF/+4OM
 omP6u4O1c9RBzBJmq20SWEr+pkbnGC0AOXZxBaz2PVwApeP/rc1ruN61IL/RV87egfEK
 R0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744923628; x=1745528428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZRqZAbHaWpbVQa+7TmhBDdgzxaTipSJDVdnXD3spG8=;
 b=p72a0nQKg5Y/cJGMYcnlyMXEDoDMdjwtQBIlAWwO3p6/XGYlejIZEcezjRUK/gUU/k
 yJx6NxhcRzBWJU/6ohn9TPCg5u9AnNNvh1IPtlKkxPoCZh5n9ZUc15ka+DHHpkbeok3p
 kJVf36Le7oqWiuBjMan/0KCGRY4ejDKypVNomB/od1Wm5djuoZTWveC2sMkQxBWQKH3h
 Iqr9ON7E2Ex0pj3yHJ87Zp7+MqVL3MP1IX51BGfSRtdjgcxd7aBN8kC9eYhqgxLCq1SW
 zbCsgOLDZ228EGdT9vx+rGyk/nG34pwT0d6b/YC4aZ3Qfa97FWpnTAlBs/XiKdtcM0pa
 JEqQ==
X-Gm-Message-State: AOJu0Yz/4jE5B6qPML2/wy+nOhN/OO4ljUPKPBthz5t7KdxspsojMbdo
 Lekfpx3MMJJKj0iiWmoV1FdSf8UHvnyR6sUMP4wCSBbf4ILy5I5FCX2QkmxwP6a/yM7RWd5TKdu
 L
X-Gm-Gg: ASbGncuymD7aBzprwMg1Jsl3bJEu+6NV84G9/+kKzT6Px+MfrhOaXSKD2sRUb6dg2SZ
 lH3pDS+PEtZb6VRhDNEj9b1/DkzLRZMXMFGtfwf/JC4APxbH6W5t/34VWxEM+dt5MWMEkWEFPsl
 OFDicqWXCsuuuVweSHKm5dxJdSao+bcDiAQxwVu3iM/wqMPWVZ+q01OLgOYMGORt+6os0eOCFOY
 D2Q+hab5i407p6EFHX9ja6Lmaui2bfbMpbUDE1D6FbVLLK9k1xqqR4lITj8FUeR+M6heGAzSKwq
 VN/Um5tVe7OQqTGvz/N/duBvOqpKT/yQkp6AHAtFK8qnacD8IjZdgaOU7yPCg4PhOUa+EMVIrNk
 YplVByY/EW7Y7aq0=
X-Google-Smtp-Source: AGHT+IFCW8+ZibqLgZHZzA8eo/mEb7y4eDsEV+ysdUp1R8tV3GaXJa4gQEkb4AhfYqBnHJWD9qVXYg==
X-Received: by 2002:a05:600c:138d:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-4406ab98f54mr2700175e9.8.1744923628221; 
 Thu, 17 Apr 2025 14:00:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406abfff1asm3386545e9.27.2025.04.17.14.00.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 14:00:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] exec: Rename target_words_bigendian() -> target_big_endian()
Date: Thu, 17 Apr 2025 23:00:25 +0200
Message-ID: <20250417210025.68322-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In commit 98ed8ecfc9d ("exec: introduce target_words_bigendian()
helper") target_words_bigendian() was matching the definition it
was depending on (TARGET_WORDS_BIGENDIAN). Later in commit
ee3eb3a7ce7 ("Replace TARGET_WORDS_BIGENDIAN") the definition was
renamed as TARGET_BIG_ENDIAN but we didn't update the helper.
Do it now mechanically using:

  $ sed -i -e s/target_words_bigendian/target_big_endian/g \
        $(git grep -wl target_words_bigendian)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tswap.h     | 12 ++++++------
 system/memory-internal.h |  2 +-
 cpu-target.c             |  4 ++--
 hw/core/cpu-system.c     |  2 +-
 hw/display/vga.c         |  2 +-
 hw/virtio/virtio.c       |  2 +-
 system/memory.c          |  4 ++--
 system/qtest.c           |  2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 84060a49994..49511f26117 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -11,15 +11,15 @@
 #include "qemu/bswap.h"
 
 /**
- * target_words_bigendian:
+ * target_big_endian:
  * Returns true if the (default) endianness of the target is big endian,
  * false otherwise. Common code should normally never need to know about the
  * endianness of the target, so please do *not* use this function unless you
  * know very well what you are doing!
  */
-bool target_words_bigendian(void);
+bool target_big_endian(void);
 #ifdef COMPILING_PER_TARGET
-#define target_words_bigendian()  TARGET_BIG_ENDIAN
+#define target_big_endian()   TARGET_BIG_ENDIAN
 #endif
 
 /*
@@ -29,7 +29,7 @@ bool target_words_bigendian(void);
 #ifdef COMPILING_PER_TARGET
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
 #else
-#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_words_bigendian())
+#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
 #endif /* COMPILING_PER_TARGET */
 
 static inline uint16_t tswap16(uint16_t s)
@@ -83,7 +83,7 @@ static inline void tswap64s(uint64_t *s)
 /* Return ld{word}_{le,be}_p following target endianness. */
 #define LOAD_IMPL(word, args...)                    \
 do {                                                \
-    if (target_words_bigendian()) {                 \
+    if (target_big_endian()) {                      \
         return glue(glue(ld, word), _be_p)(args);   \
     } else {                                        \
         return glue(glue(ld, word), _le_p)(args);   \
@@ -120,7 +120,7 @@ static inline uint64_t ldn_p(const void *ptr, int sz)
 /* Call st{word}_{le,be}_p following target endianness. */
 #define STORE_IMPL(word, args...)           \
 do {                                        \
-    if (target_words_bigendian()) {         \
+    if (target_big_endian()) {              \
         glue(glue(st, word), _be_p)(args);  \
     } else {                                \
         glue(glue(st, word), _le_p)(args);  \
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 085e81a9fe4..29717b3c58f 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -45,7 +45,7 @@ static inline bool devend_big_endian(enum device_endian end)
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
     if (end == DEVICE_NATIVE_ENDIAN) {
-        return target_words_bigendian();
+        return target_big_endian();
     }
     return end == DEVICE_BIG_ENDIAN;
 }
diff --git a/cpu-target.c b/cpu-target.c
index e018acbf71a..b5645ff0dbb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -86,8 +86,8 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     abort();
 }
 
-#undef target_words_bigendian
-bool target_words_bigendian(void)
+#undef target_big_endian
+bool target_big_endian(void)
 {
     return TARGET_BIG_ENDIAN;
 }
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 82b68b8927d..3c84176a0c5 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -133,7 +133,7 @@ bool cpu_virtio_is_big_endian(CPUState *cpu)
     if (cpu->cc->sysemu_ops->virtio_is_big_endian) {
         return cpu->cc->sysemu_ops->virtio_is_big_endian(cpu);
     }
-    return target_words_bigendian();
+    return target_big_endian();
 }
 
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
diff --git a/hw/display/vga.c b/hw/display/vga.c
index b01f67c65fb..20475ebbd31 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2264,7 +2264,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
      * into a device attribute set by the machine/platform to remove
      * all target endian dependencies from this file.
      */
-    s->default_endian_fb = target_words_bigendian();
+    s->default_endian_fb = target_big_endian();
     s->big_endian_fb = s->default_endian_fb;
 
     vga_dirty_log_start(s);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce374..8fbf1716b88 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2248,7 +2248,7 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 
 static enum virtio_device_endian virtio_default_endian(void)
 {
-    if (target_words_bigendian()) {
+    if (target_big_endian()) {
         return VIRTIO_DEVICE_ENDIAN_BIG;
     } else {
         return VIRTIO_DEVICE_ENDIAN_LITTLE;
diff --git a/system/memory.c b/system/memory.c
index 7e2f16f4e95..67e433095b4 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2575,7 +2575,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        MemOp mop = (target_big_endian() ? MO_BE : MO_LE) | size_memop(size);
         adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
@@ -2611,7 +2611,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        MemOp mop = (target_big_endian() ? MO_BE : MO_LE) | size_memop(size);
         adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
diff --git a/system/qtest.c b/system/qtest.c
index 523a0479959..c675fa2cb30 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -693,7 +693,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "endianness") == 0) {
-        if (target_words_bigendian()) {
+        if (target_big_endian()) {
             qtest_sendf(chr, "OK big\n");
         } else {
             qtest_sendf(chr, "OK little\n");
-- 
2.47.1


