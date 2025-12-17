Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3E6D6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsaj-0002DG-4z; Wed, 17 Dec 2025 09:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsag-0002Al-Aj
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsae-0007LL-Bw
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:22 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso2759820f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765981998; x=1766586798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGtVi4FJTCWPT5ULhRnfu9tg9XpQ523eSmroDWOUFuQ=;
 b=LckkI9Uj2WGDyKgagJtgDxyAsXAtgLSsXtkgFEtha0SHz0sDOW/DSBjSHBweKiYR/0
 ACv0oiIS8IazAx2ZnzBk7+oLSYfCsAZhONuw58VNtB9MQjGUyWsTRi1jBOeTVZYjr+rw
 1EzRtpgy7Ey6XHXbgW9gOuCLgCRyQ4juCKi6aKavGlq37g7e+0VkueL7u7/OW3xqOzeO
 hp31sCG5ATe9bWYEUwjMq4CtNyLcf4zelGw7Z4IJdRirA5CqronUl+OXlOUddR32J6aU
 WftMlAV/7tT1BojS06cFB9Y1YFyD0s8dorvG7B31IuzjdEG/BFP22WTRpgC68TN26+7P
 AS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981998; x=1766586798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tGtVi4FJTCWPT5ULhRnfu9tg9XpQ523eSmroDWOUFuQ=;
 b=gVl0s7MD+lvGwtICNnZ8jd9f/JXyXrhpJbdwhGYhDUr84M0etp/etNf8kb4l8QpqCB
 k1eITRKYxki4bSiW7pZRTgoJi9d8/QPnNjMvDGBwBUUojKq2CsAuRewrsW+flMPegJpN
 iAs/g2cPFbClfLi/qpA2dnNLB5k6yiWxWK0sO0B5IpHAElJmRKR5ltSdLe4rwSeDSv3h
 6+DxNafII7WVE2ETHVlls/UEwv1TlIM/glRebuuI58fPrKVA/Az4gdEbUfUz0byJ7MD0
 3EjW4GWu6BUPFuAT+JXFWCSgE8UeJno80huwcTFHdbZYGGiIG10vn4cGfxHsqFJGquGw
 zRjw==
X-Gm-Message-State: AOJu0Yz4I5L7K0LK3KBgTCAvf0JCPeVRcidOgb/uh3PA9vhbssIoSzBm
 xzxXpynSrCM5n5cMipEoAdzp8mOdaHjYd2kTMFuk/NkUpyskLhfxiYKgebpKFuDvJ0PULd78u28
 836nbBeS/4Q==
X-Gm-Gg: AY/fxX77kY2yt3cviwYwTZaCZlpgLNLYIxXXisMBc8TzjYyu0D/t48h4bjpTkjca96Z
 7VPDcF25yB6DN6wjjAk52mx0qDT8Nfk2/lA1TXoK4zszGQBtq7DSDga1L6G9+vz8OfgW2C0FhQ2
 TOlYkWrVGbhAAuDUrpniMzj7pbZnsUmHu89IybyNJOz4f8DCLliUS90KuY+w3LRL9TSAgxU0iEY
 VuSwMeXv5eNVGouBWl8y3tpD12m0/pYbiUhWOqaRcsIURGW2JmvKgWEdcAVxZ7egFaAzTU54TOD
 ZQTW/H212x/ayb+n0+b8qW+aIwkFjTfScEPetdfRbdrpEtgqdm3jZh/aMyeOxKoB7X1HDwWL8QV
 dMzhu1/A+wVDBtx4fnYER2u2317DBxP68Wu1wRujpCmXIpPwlQCOC+LwryzScT7xx2Upxb6H1sy
 9/rDM2q3luO1wWQc67xhbSVLtq1a6aEIB23vwGVfX9NOQ7LhtBmqyBE52NSteU
X-Google-Smtp-Source: AGHT+IH3wD0jf3vBt3nc1C3rifjOoYh+5dgzgRaMjiIvq9zK3lw1hFLZCdXPyHuSWfJgwBRpABOCyA==
X-Received: by 2002:a05:6000:18a3:b0:431:9f1:e4c7 with SMTP id
 ffacd0b85a97d-43109f1e649mr4225119f8f.21.1765981997656; 
 Wed, 17 Dec 2025 06:33:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade8063sm5091612f8f.23.2025.12.17.06.33.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:33:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 11/14] system/memory: Define address_space_ldst[Q] endian
 variants via template
Date: Wed, 17 Dec 2025 15:31:47 +0100
Message-ID: <20251217143150.94463-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
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
 include/exec/memory_ldst.h.inc               | 17 ++------
 include/exec/memory_ldst_phys.h.inc          | 36 -----------------
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++
 system/memory_ldst.c.inc                     | 42 --------------------
 system/memory_ldst_endian.c.inc              | 14 +++++++
 6 files changed, 31 insertions(+), 92 deletions(-)

diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 7ccca46f2a9..dd1fb482eac 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -19,22 +19,11 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+             hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
+          hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index c3c73419e61..f4c91dc7a91 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -19,54 +19,18 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldub, SUFFIX)(ARG1, addr,
                                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
 {
     glue(address_space_stb, SUFFIX)(ARG1, addr, val,
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
 
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index a3f543a715c..ec86e42afbc 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -18,10 +18,14 @@ uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result);
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
index 0ec550979fa..9603d886867 100644
--- a/include/system/memory_ldst_phys_endian.h.inc
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -29,6 +29,11 @@ static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint64_t LD_PHYS(q)(ARG1_DECL, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(q)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
 {
     ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
@@ -39,6 +44,11 @@ static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void ST_PHYS(q)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    ADDRESS_SPACE_ST(q)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #undef LD_PHYS
 #undef ST_PHYS
 #undef ADDRESS_SPACE_LD
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index ab2df6e429b..823fc3a7561 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -115,27 +115,6 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
-}
-
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
@@ -381,27 +360,6 @@ static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
-}
-
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_LITTLE_ENDIAN);
-}
-
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_BIG_ENDIAN);
-}
-
 #define ENDIANNESS
 #define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
 #include "memory_ldst_endian.c.inc"
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 5bb59ff3d8e..16d686b50f7 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -33,6 +33,13 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                                         DEVICE_ENDIANNESS);
 }
 
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
+                                        DEVICE_ENDIANNESS);
+}
+
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -47,6 +54,13 @@ void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                                  DEVICE_ENDIANNESS);
 }
 
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
+                                 DEVICE_ENDIANNESS);
+}
+
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_LD_INTERNAL
 #undef ADDRESS_SPACE_ST
-- 
2.52.0


