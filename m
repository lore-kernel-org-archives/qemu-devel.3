Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A5D232E2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve669-000253-L6; Fri, 09 Jan 2026 01:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve664-00022h-54
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:45 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve660-0007OH-0j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so34076265e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767940537; x=1768545337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeH0QpT/0zOGE77kvIWm/QtqUPhGnAr2X/Dda2LE5sk=;
 b=issl074JgnPcUC71BxnadUMC0pJeMCirrWv2EQzu0IYSCp68wK7eXSor/N9oTCkeIl
 tKmshRmdi9JtIwqT+tLm+1Tzgg8gDxfPz73sSR00bg5Y2t3J69OCVGzf3e6PxSUvm4nd
 CpFFXzYxG6XKTlxT7mFwSZmNhKa0uOCddEcr7jtbqNDi6i0OOXz17gNgmG85sZwm+jk8
 6qtd+ER43MVGzX8x0OsOomvekf/eZEYJbP5wD3VQx/NSu/fJZAEwDrXgNhEb7OryWp/c
 TjvGcFVt+zMvoVn0BU/IlqVihjIPavfHuk4smlnj15lVgxrqo1Kl4vb3zlyRaXJV9Awl
 eYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767940537; x=1768545337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NeH0QpT/0zOGE77kvIWm/QtqUPhGnAr2X/Dda2LE5sk=;
 b=K4FgdrBNsJxxpqupQoawxoFIjO1w8ZP2yyzrf2v1qfjvDxOS3tC1jiAapUKaNGRkMB
 vGfCzgi/xrRds9P1TeRXrlK6j+Ry6ofmksszSN4wpqU1VVQa58mAhquTjOY44ZYevJW9
 5KSBFce6nPk75fF4d53IuwpSePYJMUuvIsZwTFP18pzlzTCCcY+EuJx47X1mA1xTngWQ
 0iPaP1zdp1KLdNJZpcOF20ho0SHyUxBsw3nosp9/nGdTSQIlT/jk5ZdK8Rxc6NWtaATl
 EflqTPnQc1uemQ04F2NYTcxpWVj9pBEYcxHrnuSGpTvZt0gGzHbt9sFuwGMdSwttw6Au
 QP/g==
X-Gm-Message-State: AOJu0YwbbtsR/Pt+Jsy+a+A3ACkgA6y+WZnwH/Y4Rk/MpTjTznHXp0RI
 FcERhI7TQT+Voe8lHS9aba0rWXxBmwOCsNae+ClvSeR6d06+0Z8G+cRizFoN/dvVisN7hlEo1Rj
 fbeyC7r4=
X-Gm-Gg: AY/fxX5PtL6f4Lg0ldROsQpWskslsjwcRz/dZNwKn+NKgZ/GIMEQqkIWGOySvBwwahk
 Dh8IErYxWcYcriqXk1k7OxxSIR8ekUUayEBrPJP/LENbfj4KWODRubfJ2IEenkyIqcQEuPhnezk
 0cIw9ga1e3IFAXSSOY8S/R1u5L1oFHrCJ3gB73z5WMVXujrDuADlYKiHR02n9UC9ity+TiZEpIL
 CRpVzgTEdedLN2UQjp4kNmo4YmxTt1wJap3O/B8BTHLC8+p+x2lM3Xx5bMvIItiVrRodiB3SYmq
 GWkK3l7d+6d+xQk772bhZjwGkpyX6lcWJojiBFEdFKS1XF6OPu/s2/uQEk4O+/zmHGVv4WTVknY
 Ur1/oe3TT88ukMiBdnmUBywqih5sLKlpT1WtO3eFhShMqRHEJDyPSXyi+mZf0XYX/hZPIpFmkFy
 hjQbdKWqWwThI5AsJiqBPswGZYYOEo3Kq2r2zAUeKAcPMlaPTQq9e4TfzoN3pC
X-Google-Smtp-Source: AGHT+IHLSrhuD1cZzrK6WoucFJf0ozMGTX6PaJXDGTeKGvZF4nk36YWALO7MhvedCYU0fc2t77P5Qw==
X-Received: by 2002:a05:600c:3b90:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-47d84b39890mr96653655e9.26.1767940537029; 
 Thu, 08 Jan 2026 22:35:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8636c610sm54776085e9.0.2026.01.08.22.35.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 22:35:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 4/4] system/memory: Rename unaligned load/store API
Date: Fri,  9 Jan 2026 07:35:04 +0100
Message-ID: <20260109063504.71576-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109063504.71576-1-philmd@linaro.org>
References: <20260109063504.71576-1-philmd@linaro.org>
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

Rename the API methods using the explicit 'unaligned'
description instead of 'he' which stands for 'host
endianness'.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst    | 19 +++++++++----------
 include/qemu/bswap.h           | 34 +++++++++++++++++-----------------
 include/qemu/ldst_unaligned.h  | 16 ++++++++--------
 accel/tcg/translator.c         |  6 +++---
 hw/display/ati_2d.c            |  2 +-
 hw/display/sm501.c             | 19 +++++++++++--------
 hw/remote/vfio-user-obj.c      |  4 ++--
 hw/vmapple/virtio-blk.c        |  2 +-
 net/checksum.c                 |  6 +++---
 system/memory.c                |  4 ++--
 system/physmem.c               |  8 ++++----
 ui/vnc-enc-tight.c             |  2 +-
 util/bufferiszero.c            |  6 +++---
 accel/tcg/ldst_atomicity.c.inc | 10 +++++-----
 14 files changed, 70 insertions(+), 68 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 3582814c580..cb6f73b0b13 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -24,9 +24,9 @@ potentially unaligned pointer values.
 
 Function names follow the pattern:
 
-load: ``ld{sign}{size}_{endian}_p(ptr)``
+load: ``ld{sign}{size}_{unaligned|endian}_p(ptr)``
 
-store: ``st{size}_{endian}_p(ptr, val)``
+store: ``st{size}_{unaligned|endian}_p(ptr, val)``
 
 ``sign``
  - (empty) : for 32 or 64 bit sizes
@@ -41,7 +41,6 @@ store: ``st{size}_{endian}_p(ptr, val)``
  - ``q`` : 64 bits
 
 ``endian``
- - ``he`` : host endian
  - ``be`` : big endian
  - ``le`` : little endian
 
@@ -52,23 +51,23 @@ files which are built per-target.
 
 There are also functions which take the size as an argument:
 
-load: ``ldn_{endian}_p(ptr, sz)``
+load: ``ldn_{unaligned|endian}_p(ptr, sz)``
 
 which performs an unsigned load of ``sz`` bytes from ``ptr``
 as an ``{endian}`` order value and returns it in a uint64_t.
 
-store: ``stn_{endian}_p(ptr, sz, val)``
+store: ``stn_{unaligned|endian}_p(ptr, sz, val)``
 
 which stores ``val`` to ``ptr`` as an ``{endian}`` order value
 of size ``sz`` bytes.
 
 
 Regexes for git grep -G:
- - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
- - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
- - ``\<st24\(_[hbl]e\)\?_p\>``
- - ``\<ldn\(_[hbl]e\)\?_p\>``
- - ``\<stn\(_[hbl]e\)\?_p\>``
+ - ``\<ld[us]\?[bwlq]\(_unaligned\|_[bl]e\)\?_p\>``
+ - ``\<st[bwlq]\(_unaligned\|_[bl]e\)\?_p\>``
+ - ``\<st24\(_unaligned\|_[bl]e\)\?_p\>``
+ - ``\<ldn\(_unaligned\|_[bl]e\)\?_p\>``
+ - ``\<stn\(_unaligned\|_[bl]e\)\?_p\>``
 
 ``cpu_{ld,st}*_mmu``
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index e70452b425a..dc31d48fd13 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -237,82 +237,82 @@ static inline void stb_p(void *ptr, uint8_t v)
 
 static inline int lduw_le_p(const void *ptr)
 {
-    return (uint16_t)le_bswap(lduw_he_p(ptr), 16);
+    return (uint16_t)le_bswap(lduw_unaligned_p(ptr), 16);
 }
 
 static inline int ldsw_le_p(const void *ptr)
 {
-    return (int16_t)le_bswap(lduw_he_p(ptr), 16);
+    return (int16_t)le_bswap(lduw_unaligned_p(ptr), 16);
 }
 
 static inline int ldl_le_p(const void *ptr)
 {
-    return le_bswap(ldl_he_p(ptr), 32);
+    return le_bswap(ldl_unaligned_p(ptr), 32);
 }
 
 static inline uint64_t ldq_le_p(const void *ptr)
 {
-    return le_bswap(ldq_he_p(ptr), 64);
+    return le_bswap(ldq_unaligned_p(ptr), 64);
 }
 
 static inline void stw_le_p(void *ptr, uint16_t v)
 {
-    stw_he_p(ptr, le_bswap(v, 16));
+    stw_unaligned_p(ptr, le_bswap(v, 16));
 }
 
 static inline void st24_le_p(void *ptr, uint32_t v)
 {
-    st24_he_p(ptr, le_bswap24(v));
+    st24_unaligned_p(ptr, le_bswap24(v));
 }
 
 static inline void stl_le_p(void *ptr, uint32_t v)
 {
-    stl_he_p(ptr, le_bswap(v, 32));
+    stl_unaligned_p(ptr, le_bswap(v, 32));
 }
 
 static inline void stq_le_p(void *ptr, uint64_t v)
 {
-    stq_he_p(ptr, le_bswap(v, 64));
+    stq_unaligned_p(ptr, le_bswap(v, 64));
 }
 
 static inline int lduw_be_p(const void *ptr)
 {
-    return (uint16_t)be_bswap(lduw_he_p(ptr), 16);
+    return (uint16_t)be_bswap(lduw_unaligned_p(ptr), 16);
 }
 
 static inline int ldsw_be_p(const void *ptr)
 {
-    return (int16_t)be_bswap(lduw_he_p(ptr), 16);
+    return (int16_t)be_bswap(lduw_unaligned_p(ptr), 16);
 }
 
 static inline int ldl_be_p(const void *ptr)
 {
-    return be_bswap(ldl_he_p(ptr), 32);
+    return be_bswap(ldl_unaligned_p(ptr), 32);
 }
 
 static inline uint64_t ldq_be_p(const void *ptr)
 {
-    return be_bswap(ldq_he_p(ptr), 64);
+    return be_bswap(ldq_unaligned_p(ptr), 64);
 }
 
 static inline void stw_be_p(void *ptr, uint16_t v)
 {
-    stw_he_p(ptr, be_bswap(v, 16));
+    stw_unaligned_p(ptr, be_bswap(v, 16));
 }
 
 static inline void st24_be_p(void *ptr, uint32_t v)
 {
-    st24_he_p(ptr, be_bswap24(v));
+    st24_unaligned_p(ptr, be_bswap24(v));
 }
 
 static inline void stl_be_p(void *ptr, uint32_t v)
 {
-    stl_he_p(ptr, be_bswap(v, 32));
+    stl_unaligned_p(ptr, be_bswap(v, 32));
 }
 
 static inline void stq_be_p(void *ptr, uint64_t v)
 {
-    stq_he_p(ptr, be_bswap(v, 64));
+    stq_unaligned_p(ptr, be_bswap(v, 64));
 }
 
 static inline unsigned long leul_to_cpu(unsigned long v)
@@ -363,7 +363,7 @@ static inline unsigned long leul_to_cpu(unsigned long v)
         }                                                               \
     }
 
-DO_STN_LDN_P(he)
+DO_STN_LDN_P(unaligned)
 DO_STN_LDN_P(le)
 DO_STN_LDN_P(be)
 
diff --git a/include/qemu/ldst_unaligned.h b/include/qemu/ldst_unaligned.h
index 201e32d0734..63a091ad401 100644
--- a/include/qemu/ldst_unaligned.h
+++ b/include/qemu/ldst_unaligned.h
@@ -16,50 +16,50 @@
  * of good performance.
  */
 
-static inline int lduw_he_p(const void *ptr)
+static inline int lduw_unaligned_p(const void *ptr)
 {
     uint16_t r;
     __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
-static inline int ldsw_he_p(const void *ptr)
+static inline int ldsw_unaligned_p(const void *ptr)
 {
     int16_t r;
     __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
-static inline void stw_he_p(void *ptr, uint16_t v)
+static inline void stw_unaligned_p(void *ptr, uint16_t v)
 {
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
-static inline void st24_he_p(void *ptr, uint32_t v)
+static inline void st24_unaligned_p(void *ptr, uint32_t v)
 {
     __builtin_memcpy(ptr, &v, 3);
 }
 
-static inline int ldl_he_p(const void *ptr)
+static inline int ldl_unaligned_p(const void *ptr)
 {
     int32_t r;
     __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
-static inline void stl_he_p(void *ptr, uint32_t v)
+static inline void stl_unaligned_p(void *ptr, uint32_t v)
 {
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
-static inline uint64_t ldq_he_p(const void *ptr)
+static inline uint64_t ldq_unaligned_p(const void *ptr)
 {
     uint64_t r;
     __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
-static inline void stq_he_p(void *ptr, uint64_t v)
+static inline void stq_unaligned_p(void *ptr, uint64_t v)
 {
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index d767e5dff24..a2ec3a35c38 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -342,14 +342,14 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
     case 2:
         if (QEMU_IS_ALIGNED(pc, 2)) {
             uint16_t t = qatomic_read((uint16_t *)host);
-            stw_he_p(dest, t);
+            stw_unaligned_p(dest, t);
             return true;
         }
         break;
     case 4:
         if (QEMU_IS_ALIGNED(pc, 4)) {
             uint32_t t = qatomic_read((uint32_t *)host);
-            stl_he_p(dest, t);
+            stl_unaligned_p(dest, t);
             return true;
         }
         break;
@@ -357,7 +357,7 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
     case 8:
         if (QEMU_IS_ALIGNED(pc, 8)) {
             uint64_t t = qatomic_read__nocheck((uint64_t *)host);
-            stq_he_p(dest, t);
+            stq_unaligned_p(dest, t);
             return true;
         }
         break;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 08f722cd63e..ad546f10ace 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -222,7 +222,7 @@ void ati_2d_blt(ATIVGAState *s)
             for (y = 0; y < s->regs.dst_height; y++) {
                 i = dst_x * bypp + (dst_y + y) * dst_pitch;
                 for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+                    stn_unaligned_p(&dst_bits[i], bypp, filler);
                 }
             }
         }
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 1c38b17b04c..93f6a1097cd 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -768,7 +768,7 @@ static void sm501_2d_operation(SM501State *s)
             for (y = 0; y < height; y++) {
                 i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
                 for (x = 0; x < width; x++, i += bypp) {
-                    stn_he_p(&d[i], bypp, ~ldn_he_p(&d[i], bypp));
+                    stn_unaligned_p(&d[i], bypp, ~ldn_unaligned_p(&d[i], bypp));
                 }
             }
         } else if (!rop_mode && rop == 0x99) {
@@ -781,8 +781,9 @@ static void sm501_2d_operation(SM501State *s)
                 i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
                 j = (src_x + (src_y + y) * src_pitch) * bypp;
                 for (x = 0; x < width; x++, i += bypp, j += bypp) {
-                    stn_he_p(&d[i], bypp,
-                             ~(ldn_he_p(&sp[j], bypp) ^ ldn_he_p(&d[i], bypp)));
+                    stn_unaligned_p(&d[i], bypp,
+                                    ~(ldn_unaligned_p(&sp[j], bypp)
+                                      ^ ldn_unaligned_p(&d[i], bypp)));
                 }
             }
         } else if (!rop_mode && rop == 0xee) {
@@ -795,8 +796,9 @@ static void sm501_2d_operation(SM501State *s)
                 i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
                 j = (src_x + (src_y + y) * src_pitch) * bypp;
                 for (x = 0; x < width; x++, i += bypp, j += bypp) {
-                    stn_he_p(&d[i], bypp,
-                             ldn_he_p(&sp[j], bypp) | ldn_he_p(&d[i], bypp));
+                    stn_unaligned_p(&d[i], bypp,
+                                    ldn_unaligned_p(&sp[j], bypp)
+                                    | ldn_unaligned_p(&d[i], bypp));
                 }
             }
         } else {
@@ -818,8 +820,9 @@ static void sm501_2d_operation(SM501State *s)
             if (width == 1 && height == 1) {
                 unsigned int si = (src_x + src_y * src_pitch) * bypp;
                 unsigned int di = (dst_x + dst_y * dst_pitch) * bypp;
-                stn_he_p(&s->local_mem[dst_base + di], bypp,
-                         ldn_he_p(&s->local_mem[src_base + si], bypp));
+                stn_unaligned_p(&s->local_mem[dst_base + di], bypp,
+                                ldn_unaligned_p(&s->local_mem[src_base + si],
+                                                bypp));
                 break;
             }
             /* If reverse blit do simple check for overlaps */
@@ -917,7 +920,7 @@ static void sm501_2d_operation(SM501State *s)
                 for (y = 0; y < height; y++) {
                     i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
                     for (x = 0; x < width; x++, i += bypp) {
-                        stn_he_p(&d[i], bypp, color);
+                        stn_unaligned_p(&d[i], bypp, color);
                     }
                 }
             }
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 8d99b78245d..aa13f14949c 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -392,7 +392,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
         access_size = memory_access_size(mr, size, offset);
 
         if (is_write) {
-            val = ldn_he_p(ptr, access_size);
+            val = ldn_unaligned_p(ptr, access_size);
 
             result = memory_region_dispatch_write(mr, offset, val,
                                                   size_memop(access_size),
@@ -402,7 +402,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
                                                  size_memop(access_size),
                                                  MEMTXATTRS_UNSPECIFIED);
 
-            stn_he_p(ptr, access_size, val);
+            stn_unaligned_p(ptr, access_size, val);
         }
 
         if (release_lock) {
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 3acb29eea88..ae4fa2cc511 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -79,7 +79,7 @@ static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t *config)
     g_assert(dev->parent_obj.config_size >= endof(struct virtio_blk_config, zoned));
 
     /* Apple abuses the field for max_secure_erase_sectors as type id */
-    stl_he_p(&blkcfg->max_secure_erase_sectors, dev->apple_type);
+    stl_unaligned_p(&blkcfg->max_secure_erase_sectors, dev->apple_type);
 }
 
 static void vmapple_virtio_blk_class_init(ObjectClass *klass, const void *data)
diff --git a/net/checksum.c b/net/checksum.c
index ea55b468060..b27f22c4da8 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -110,7 +110,7 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
 
     /* Calculate IP checksum */
     if (csum_flag & CSUM_IP) {
-        stw_he_p(&ip->ip_sum, 0);
+        stw_unaligned_p(&ip->ip_sum, 0);
         csum = net_raw_checksum((uint8_t *)ip, IP_HDR_GET_LEN(ip));
         stw_be_p(&ip->ip_sum, csum);
     }
@@ -142,7 +142,7 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
         }
 
         /* Set csum to 0 */
-        stw_he_p(&tcp->th_sum, 0);
+        stw_unaligned_p(&tcp->th_sum, 0);
 
         csum = net_checksum_tcpudp(ip_len, ip->ip_p,
                                    (uint8_t *)&ip->ip_src,
@@ -166,7 +166,7 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
         }
 
         /* Set csum to 0 */
-        stw_he_p(&udp->uh_sum, 0);
+        stw_unaligned_p(&udp->uh_sum, 0);
 
         csum = net_checksum_tcpudp(ip_len, ip->ip_p,
                                    (uint8_t *)&ip->ip_src,
diff --git a/system/memory.c b/system/memory.c
index 4bf00d82bcf..4625cf9e5ae 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1365,7 +1365,7 @@ static uint64_t memory_region_ram_device_read(void *opaque,
                                               hwaddr addr, unsigned size)
 {
     MemoryRegion *mr = opaque;
-    uint64_t data = ldn_he_p(mr->ram_block->host + addr, size);
+    uint64_t data = ldn_unaligned_p(mr->ram_block->host + addr, size);
 
     trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
 
@@ -1379,7 +1379,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 
     trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
 
-    stn_he_p(mr->ram_block->host + addr, size, data);
+    stn_unaligned_p(mr->ram_block->host + addr, size, data);
 }
 
 static const MemoryRegionOps ram_device_mem_ops = {
diff --git a/system/physmem.c b/system/physmem.c
index 0105e88058d..be0c8094736 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3275,7 +3275,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
 
         /*
          * Assure Coverity (and ourselves) that we are not going to OVERRUN
-         * the buffer by following ldn_he_p().
+         * the buffer by following ldn_unaligned_p().
          */
 #ifdef QEMU_STATIC_ANALYSIS
         assert((*l == 1 && len >= 1) ||
@@ -3283,7 +3283,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
                (*l == 4 && len >= 4) ||
                (*l == 8 && len >= 8));
 #endif
-        val = ldn_he_p(buf, *l);
+        val = ldn_unaligned_p(buf, *l);
         result = memory_region_dispatch_write(mr, mr_addr, val,
                                               size_memop(*l), attrs);
         if (release_lock) {
@@ -3370,7 +3370,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
 
         /*
          * Assure Coverity (and ourselves) that we are not going to OVERRUN
-         * the buffer by following stn_he_p().
+         * the buffer by following stn_unaligned_p().
          */
 #ifdef QEMU_STATIC_ANALYSIS
         assert((*l == 1 && len >= 1) ||
@@ -3378,7 +3378,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
                (*l == 4 && len >= 4) ||
                (*l == 8 && len >= 8));
 #endif
-        stn_he_p(buf, *l, val);
+        stn_unaligned_p(buf, *l, val);
 
         if (release_lock) {
             bql_unlock();
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 78ac7a2eacc..2f22c0057ef 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -912,7 +912,7 @@ static void tight_pack24(VncState *vs, uint8_t *buf, size_t count, size_t *ret)
     }
 
     while (count--) {
-        pix = ldl_he_p(buf8);
+        pix = ldl_unaligned_p(buf8);
         *buf++ = (char)(pix >> rshift);
         *buf++ = (char)(pix >> gshift);
         *buf++ = (char)(pix >> bshift);
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index ca38606032d..7357fe9c7f4 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -38,10 +38,10 @@ static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
      * the beginning and end of the buffer.
      */
     if (unlikely(len <= 8)) {
-        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
+        return (ldl_unaligned_p(buf) | ldl_unaligned_p(buf + len - 4)) == 0;
     }
 
-    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+    t = ldq_unaligned_p(buf) | ldq_unaligned_p(buf + len - 8);
     p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
     e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
 
@@ -58,7 +58,7 @@ static bool buffer_is_zero_int_ge256(const void *buf, size_t len)
      * Use unaligned memory access functions to handle
      * the beginning and end of the buffer.
      */
-    uint64_t t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+    uint64_t t = ldq_unaligned_p(buf) | ldq_unaligned_p(buf + len - 8);
     const uint64_t *p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
     const uint64_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
 
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index c735add2615..eeb18c716c0 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -415,7 +415,7 @@ static uint16_t load_atom_2(CPUState *cpu, uintptr_t ra,
     atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
-        return lduw_he_p(pv);
+        return lduw_unaligned_p(pv);
     case MO_16:
         /* The only case remaining is MO_ATOM_WITHIN16. */
         if (!HAVE_al8_fast && (pi & 3) == 1) {
@@ -512,7 +512,7 @@ static uint64_t load_atom_8(CPUState *cpu, uintptr_t ra,
     }
     switch (atmax) {
     case MO_8:
-        return ldq_he_p(pv);
+        return ldq_unaligned_p(pv);
     case MO_16:
         return load_atom_8_by_2(pv);
     case MO_32:
@@ -875,7 +875,7 @@ static void store_atom_2(CPUState *cpu, uintptr_t ra,
 
     atmax = required_atomicity(cpu, pi, memop);
     if (atmax == MO_8) {
-        stw_he_p(pv, val);
+        stw_unaligned_p(pv, val);
         return;
     }
 
@@ -928,7 +928,7 @@ static void store_atom_4(CPUState *cpu, uintptr_t ra,
     atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
-        stl_he_p(pv, val);
+        stl_unaligned_p(pv, val);
         return;
     case MO_16:
         store_atom_4_by_2(pv, val);
@@ -996,7 +996,7 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,
     atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
-        stq_he_p(pv, val);
+        stq_unaligned_p(pv, val);
         return;
     case MO_16:
         store_atom_8_by_2(pv, val);
-- 
2.52.0


