Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030B6D6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsac-000278-8R; Wed, 17 Dec 2025 09:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsaa-00025d-7V
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:16 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsaX-0007J5-E0
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:15 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42e2d02a3c9so3612298f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765981990; x=1766586790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Se/V+8BAK4KJDNn9hIaPFGW+dBpbxSjDuDrSzg2IXOc=;
 b=yB6lrN8r+/N9VqRZfhP2emjiloCddgCHFLSnQ9YSsoCpdIoOIBcR6WyvQSF5Z5FdW1
 KfXjpO521rQ05AdU85IAFlH3QuXAXzDBiETam2rwsAgxnRMOtJPiFZzGJFU7hdmKbNLn
 1wo9AaSrUUOEuia9CyvfkmOkX6JC2+HJPNYT67bARdj4F7aKmUlCtlMiSRj6aYJhHgGB
 K81slLMf2mgjnijaJPpsPvQjloORXLSBZUHt0lxAEQ4mTWMd9NGiscyHkTjS5o3hv3Pt
 gmrXQ9c5c+BMxhNdYQXeRFbGBD+xc20BrFj1Lo7wE5V8KlHM6oDtaVITOCkKy6GPuQ2X
 UbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981990; x=1766586790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Se/V+8BAK4KJDNn9hIaPFGW+dBpbxSjDuDrSzg2IXOc=;
 b=h9sRs8BbKaiVKu4CUqUBhvs2ji5Jf622MFRvODEXd8t24MpE35vd0zwlGPvAj9kBAu
 pBNNuv7UE3Ge+UzcCxTwuIJy00fiBK9T2643J6DkSM5cla5Y3tvB4P1FVt11ZtZgrDsb
 6IIVlY+GocVDgm8NtGjMkzFvmeKpUix3BGUSv2S9LkreZgC0VWKMDN1ATqW8hcPzziPA
 87nHDFey5ylx+TBm0q9c9lPyVV50UjK3aoNFA/EG1qBVslE1Rq4KdIdN3PjeCw35bBnF
 IAgq/lUO5sOhb3E7NkIeF32EEBmJ0kY6bKSS172cWuZQdV2+Gqk6UiQ/F0mY/N+p5PCN
 KgkA==
X-Gm-Message-State: AOJu0YxAZMYGzGUCBqAt7gxbiK5+6wiIdO0Cmbf3n+yrEueemfyv16+r
 RXdm1OZUCNpzcMD3mnJ43j1ETRAdNu72EEqGevFXDPIeUPRB3Fs26Tz2OlQpOc6cEXd1XwGK1PU
 N6aRM0oeCaQ==
X-Gm-Gg: AY/fxX6eaq9OV+5F4WLp3SwEh0mtK6iHGHvEhxWpFIuHu8AFvieLGWTYtc9kQOR5ija
 K3yQ+NTEXwywyjpz8Bi6CeKjE2WIiUy3VPXsPbfGB/TLOTVch7z3i8CGj1ajp3fBv33XK6i1SLF
 1MLsUL9g4tZ8UEqiB3Wz4c83OX93TR5OW/H8mkKt3ossSEfZ8yKdIFrvyd4KDj9qRDJxQKKPZJO
 K5pDbSo78X/12aZlB2J4qGHkcxKxUgowVMbbE7IzTCkExwqOid+Oo/ZBO51S5fARbBtsSo1KflN
 nLk8Wk32F0+gU80ApxGbIyrCGCKgElcZ8w0TiUKtxmpwLGHkbHVa/KullgiVeqoeZVz6XLsVQyX
 +kWN60XBrig7tFLM/TOLw+H1Z+nwG18RhEGgf2AEC73uF0xkm5f5mDyKX8eX2hgoCAjVmIyVENX
 3tmAIsWF4M4+ct64hZ2HF0QtfeG1n//EdVPcOOAvO/CVQpvVDo+aMiKdPHLg8U
X-Google-Smtp-Source: AGHT+IEdhSWDIcM3um0Yf2Hnk13xDc4MCzagEKQ0ytuZpPMu9wkN6itBog4ll5aiTeL5cIoSnOJAIQ==
X-Received: by 2002:a05:6000:4212:b0:431:9c5:8c3b with SMTP id
 ffacd0b85a97d-43109c58d6fmr5325582f8f.41.1765981990021; 
 Wed, 17 Dec 2025 06:33:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ada856bsm5070561f8f.3.2025.12.17.06.33.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:33:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 10/14] system/memory: Define address_space_ldst[L] endian
 variants via template
Date: Wed, 17 Dec 2025 15:31:46 +0100
Message-ID: <20251217143150.94463-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory_ldst.h.inc               | 12 ------
 include/exec/memory_ldst_phys.h.inc          | 36 -----------------
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++
 system/memory_ldst.c.inc                     | 42 --------------------
 system/memory_ldst_endian.c.inc              | 14 +++++++
 6 files changed, 28 insertions(+), 90 deletions(-)

diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 73c0366a247..7ccca46f2a9 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -19,30 +19,18 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index 71c2e64ff0f..c3c73419e61 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -19,24 +19,12 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-static inline uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldq, SUFFIX)(ARG1, addr,
                                            MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stl_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
 {
     glue(address_space_stq, SUFFIX)(ARG1, addr, val,
@@ -49,18 +37,6 @@ static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
                                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline uint32_t glue(ldl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline uint32_t glue(ldl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
@@ -79,18 +55,6 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
 {
     glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index 4efd7f19f7e..a3f543a715c 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -16,8 +16,12 @@
 
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result);
+uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
index 6c00edc2148..0ec550979fa 100644
--- a/include/system/memory_ldst_phys_endian.h.inc
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -24,11 +24,21 @@ static inline uint16_t LD_PHYS(uw)(ARG1_DECL, hwaddr addr)
     return ADDRESS_SPACE_LD(uw)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
 {
     ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #undef LD_PHYS
 #undef ST_PHYS
 #undef ADDRESS_SPACE_LD
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index c37a07b4f4a..ab2df6e429b 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -67,27 +67,6 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
-}
-
-uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
-}
-
-uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
-}
-
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
@@ -284,27 +263,6 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(address_space_stl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_NATIVE_ENDIAN);
-}
-
-void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_LITTLE_ENDIAN);
-}
-
-void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_BIG_ENDIAN);
-}
-
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
 {
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 8aa6ebeebb2..5bb59ff3d8e 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -26,6 +26,13 @@ uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                                          DEVICE_ENDIANNESS);
 }
 
+uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, addr, attrs, result,
+                                        DEVICE_ENDIANNESS);
+}
+
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -33,6 +40,13 @@ void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                                  DEVICE_ENDIANNESS);
 }
 
+void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, addr, val, attrs, result,
+                                 DEVICE_ENDIANNESS);
+}
+
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_LD_INTERNAL
 #undef ADDRESS_SPACE_ST
-- 
2.52.0


