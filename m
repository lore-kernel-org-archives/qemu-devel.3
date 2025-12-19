Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248D2D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdE3-0007kE-0u; Fri, 19 Dec 2025 11:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdE0-0007Xm-V5
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDy-00062z-Pn
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso16643885e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161261; x=1766766061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyS0FnqVUQjt8tSrF+XOt6YbIemfMNcjBOlxEn8CI/U=;
 b=fXdtnBxODWBa2zmmMre48gESPTrNUDcsG7/WisP97NLE0YaQa1Q1SJ/QfUwxtl3hgr
 /+Tocd8XEbmiGx61ulxtPz6dDl3QgPryfQhGblXTGr5ib6f+1OBOocqXqnytDefu0ClF
 VvJpZBJQxWQ1bkP38E0+Ux5tnr8pb1mM4euwv2ROCZ8DhLa6FUCqJ0z3GFKFb3bSuhOf
 KaEXvVhPcEJ8V8x7fczkfy/dbsuRhIky/g2ym7eG5tIfWh8x3itmO4pMHmyKwZ7FIcu+
 n5lmraBLqeq4A/OdELnZfmG809mSGEq/LgjPoXxcoRAKo6Nd/7zyKCILSqCrB/vQLmDx
 AziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161261; x=1766766061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KyS0FnqVUQjt8tSrF+XOt6YbIemfMNcjBOlxEn8CI/U=;
 b=dDAXKnZFisOWgMeeHvq7TzLFHD07H1OLqPSE/NJupNbKw6VDRKmXxav8byOPMNntN5
 /tayInvoJ/TFmzo7oJ6v6gaRMm4uHlHZy14Gwbtn/1+TPAGWZM1GoE7N3Dx7YmrbOXgg
 SjzifjX3fnMde3KYLYD241zodCPUi00wGMi2Dq4RN1ACkimumPWWiNVL2eObwbA7Fzc0
 h58GAIux/KBBwAAm5JnOewQZGIEsix+GKjTF9qeKD+QLvN6gNVQcxjQgDDoat1OWB7ig
 B3t9GXYeSRyMNo8miQezifl4LDEotuH7t6g0ZBhd0kKfLBPITmcG/ZVPJelJOCUR6gzO
 VV4w==
X-Gm-Message-State: AOJu0Yx9lt4/GMvcJ1SAPYLW/Ud2DbawjidfMCtHRxm2TLhN66hOfgho
 FxAXnust2Q7fhCMqqTcP6r7aueoqVRSb+l6farDzpRZZ2G4PKP/cEQ6nOj5JqkyAqJOXr6nR75E
 UD9efd78=
X-Gm-Gg: AY/fxX7UlC0NMxuBrOQoxtMcpnyUqK90tDcvchkKosqc72SDvz+NcT6egf/SpC8ODtG
 mYHlfLeVne2woNnuDeI5RD5/O9c2qNI5TNFLdgMKQVsF+kDnGvNiXvSM81MkLj7L5fPdn0r3wpr
 GfswxYdhFwegibezwe6nfIkebZJy4PRwEr027niYNpTGZXYbVdnl0428S5pD5/OwddPF0zPI7J5
 t2pFyQzpbh4ySHl/cg/hFealqep55sbO6hAcpAr6Ka3AX0h+ToeQ9vT4ijkhYECbk78HFupB4Xj
 HyeJJ79ehLvnvxruR02/x0JtngEVtQnoUb8E4MDsL/e56zKeBOu0HqIrQeAC1eDuv0uHsvKV+IO
 DFCxd9hDEcgXvQYcmLpT2wRjqOiSxctgUVwumE1+oNUCKa/6IcJvPReTTSqsCrnCBvxtk8AiCoZ
 eYfULuEhjFk4hDG9WosTHf6dsup79EkfycxjOWbW8mE4vB+bxE8PuPneenvCmu
X-Google-Smtp-Source: AGHT+IHavcLSua1k8pZUMIO3NXbXubPU526QfxJ4sQ4BR7k2JEZsosUeBLlEdnOyoY3CKIn7/ddANQ==
X-Received: by 2002:a05:600c:8b35:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-47d18b83100mr35115805e9.3.1766161260673; 
 Fri, 19 Dec 2025 08:21:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82e9fsm6084615f8f.26.2025.12.19.08.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/24] system/memory: Define address_space_ldst[L] endian
 variants via template
Date: Fri, 19 Dec 2025 17:19:36 +0100
Message-ID: <20251219161953.72724-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_ldst.h.inc             | 12 ------
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys.h.inc        | 36 -----------------
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++
 system/memory_ldst.c.inc                     | 42 --------------------
 system/memory_ldst_endian.c.inc              | 14 +++++++
 6 files changed, 28 insertions(+), 90 deletions(-)

diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index 73c0366a247..7ccca46f2a9 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
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
diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index 71c2e64ff0f..c3c73419e61 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
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


