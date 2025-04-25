Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14075C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1E-0002qy-OP; Fri, 25 Apr 2025 11:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L16-0002FZ-Pz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L13-00040d-RI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c14016868so2261532f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595060; x=1746199860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5593o39LnJ2IIl75zg3C5QbK7Ueu2k/Gp8rxSp+WVQ=;
 b=rqymRwNw3l6gRvwmrEN3PufE8FQSWRPf+oKUtUFXxej/riRlYMr1tRLgG02TnWF/qg
 7D1oxrED9/fD4p+WQn9advWKXRJCoy7vLHBuD/gn56Nj0G64sldCdc0xSgSkHH08u8lo
 D5Ve0LLhEvdJVWmXui3VCUTAStEkhlPZJ+C5r8hiCdVX4hw4w0I6LcZ/KS7Jgd+lytcc
 jw/kr5sRI+mYQj6ZZVIgre09/zUVPdUUt42qskaR9urX2qivUDmja2DRw/xeiA4F6fea
 7a9SEDYvEI+veUUiNIm7rnceBpcYF0xkNKkHQlj1pheTFpbzel/M9KsKkWrYdeRXQswG
 5NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595060; x=1746199860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5593o39LnJ2IIl75zg3C5QbK7Ueu2k/Gp8rxSp+WVQ=;
 b=on8MgrV9Lj3uNZppQkhLHV700ofS7QVrvZ48gF8QiOjeWemjC+Z4qTrgMHWU14CbZG
 wvpLeggeW0gB+P8YtTXp9uj2JaQWDeQ1lS8fMEDQnYVCHorHc3XqLPNGZ06J6ECYvOKW
 XzjjPE/0WlE1XT9sw2Ckexc2MGcXE0KDY5kJ+2aDnVskxFNTa5cdhjHAT3iywU6PTQj5
 tyzsSHxdAHnYlCg9O/zP1VCa4Y1smBYl7y+yL9LryAAiQV+Pe9We9OSeUt0CRmapR08a
 JhNZZQIbdK08b18ROQMyrSq6wevcM3nS1gngXjW2+GSQChOU23YVf4eUm04LjdJ7oHYh
 b8WA==
X-Gm-Message-State: AOJu0YyUys9bSb6HrQXfCNsSxVPbBBbY/jpsBibjnBa/mVsYNSeOGpMp
 TUFlts9CyQiMJehjVREzVJNZ8B8kw/KTwBITzbbTPI3e2tdbLoKIQMHeILZqgVVhND8yQsYxBIm
 e
X-Gm-Gg: ASbGncuvhGTQmsC0WMAyQqWlC7A7MY4aF7g1rbsDcZvo6M8DhnO5gWfCW7B+a2h8Cti
 SS+6wYdsvoUV5hme7EJyTeJAkVlffqXtTktgG9rrXr333BglY31r4oRlHqvJzDsgfxdgwLzZGsr
 9vrX4FiL9LDPT1edzWkBZEheSRXcP+z7bypI2gecUmpB6IhqYonsX4pOWiMbgU1vaNKeRBUzs+0
 +Byl1aNy0tSI4FpNqMweZIz2keK7YpyoJByNPG9un5j3GuJR0Qn/72bKwo8oy7CXAkmL3O4PP/Y
 v0h6Isd43YkEYTykOZXCVJ2m+n3a5hCNt8orXMsytmf8vkD0z8hr+Bu3duKAwP3tpldknH40hDl
 Rg/c/9R6H5axH4qU=
X-Google-Smtp-Source: AGHT+IHrsgkJNfWu422DLg6XkJhsCD1U1X89RydkWbs2OMHFCIPbZHzTtC04wmRgXQgxFaLpttlJPw==
X-Received: by 2002:a5d:588a:0:b0:39c:1ef5:ff8b with SMTP id
 ffacd0b85a97d-3a074f653abmr2406023f8f.48.1745595059490; 
 Fri, 25 Apr 2025 08:30:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46c23sm2619021f8f.75.2025.04.25.08.30.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 27/58] exec: Rename target_words_bigendian() ->
 target_big_endian()
Date: Fri, 25 Apr 2025 17:28:11 +0200
Message-ID: <20250425152843.69638-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

In commit 98ed8ecfc9d ("exec: introduce target_words_bigendian()
helper") target_words_bigendian() was matching the definition it
was depending on (TARGET_WORDS_BIGENDIAN). Later in commit
ee3eb3a7ce7 ("Replace TARGET_WORDS_BIGENDIAN") the definition was
renamed as TARGET_BIG_ENDIAN but we didn't update the helper.
Do it now mechanically using:

  $ sed -i -e s/target_words_bigendian/target_big_endian/g \
        $(git grep -wl target_words_bigendian)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250417210025.68322-1-philmd@linaro.org>
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
index c99d208a7c4..d68cbab5da9 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -160,8 +160,8 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
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
index f0fa36f8ce8..480c2e50365 100644
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
index ade3eb32212..301b03be2d3 100644
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


