Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799B1D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdEh-0000lE-Ck; Fri, 19 Dec 2025 11:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEU-00009z-Lz
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:35 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdER-00066l-HC
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so14713735e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161290; x=1766766090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5+tFX7MDSEvo8TlX3aoId7uaPwr1ONHpDvHVnXNwsA=;
 b=a66tGDhfREK36KDMS5LiCroVN1Z6tCsUkZ1qcQx1rpYTh3lW2W2GhHTGhrxJzTKTvU
 5FZYmYrP866jKxXl1A7p2Hukm+omwN0IZO6BkGDxfdm6sYvcXocbXIRPOw+SxbKNvblQ
 oWMwK4So87Q9xe/TT7PaBUUmmUCNiBnCCvVBs7KQy9BhsxtyILp0xJ6CmzgPZIeTD/sM
 KD+QysdLHhOqpbDh4oFvA2s91T/8I6njb1DKW4/YxATkbbIya0C1IPLCTcgG3X/4J1Vn
 CNaCfFhqeFCujYSwvwyyvag6WeQmod5LhNwvJkXuTmoXg/bfhE8rJFQV8E4K5q2DRYHc
 qrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161290; x=1766766090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O5+tFX7MDSEvo8TlX3aoId7uaPwr1ONHpDvHVnXNwsA=;
 b=f64L1Rjbc1n2Nf28SIIH0rUXhgFxmm9zwNClpGn5OC1P/ScwbMzgg9hwsPIWfxreaS
 BzvDZ+fF2sNz3rEVWxij9RelYYUVyotqZNPg5cbjCbar9o4ygc8aFx8dk4uZAMP4jSdu
 ok1Y4om2efid3fLfDK25DRlY4dkI6EoQbYkknCQV8TAuri/a/5w6gKT+YjwTMYnRHj/b
 5HZBTNxC49dH31XYm8vnggswv/wMnOz2Jtoq6WHsnoE5K6ezM+owXq9l2+MgtyTpuYGz
 rbklT2Uz2PdN7ocsf8chMCde9lZU4NApTJx1fMcVRwFHB45lQR9t2NJIxtLKOEPHJati
 JNXw==
X-Gm-Message-State: AOJu0Yyywg+Jy+tAdVQii5+OV0sgzZNHoQb6c7c5vMjXCK6A6kJ4Gvou
 +R9bb5huv0lgB3lUWqsDCwuptQBLPlFHaH36OBB1tZXFmA9ZMP9FP7md1zS3Sd83m0pN2PNi7/9
 ZwV5BQH0=
X-Gm-Gg: AY/fxX4N6W0QyNpU/Ld9dbFBzFRa5t4aqzT5d/Oc2b/+b6Vn8o8UVw5YbUK8Q939xzJ
 w9Pl3t9Z1FbgW90+4hYH+RXXYEdM1sJJKuVLQRmFAqoYBZH8rnTF8Y8qFrvsjlXxstCI3PUVfx/
 ghY84GaQV0fMMcERUO85rwaXNyHFDvmg1Jrarp99OlYhE2PM/7e9zDCNcSfMXxIvypY4RTF57tb
 dSRyQp3N4E+qBEajoUQRu+NZUK5gPW2bb9D5uVgGgLoayUOZHmjvaaBAgCn7959Le+y8kb3b2kg
 Emj3ubsvJ3Zw1HyCOvrODMcGY0+uTbYYWDywSHmCNW26lVMWPmsnhfG04ahxfo4yumMlW1+B4bv
 XN7RYjVXOPY11oKX5DjxPkLxcvwRH4aKJuCIUKlU5antR0+4jkR7NK1PbmmexM8r06JAp7cVZ+5
 VVqwaQiLx90Qhu0EL389mlKcR6GbYYAu0IwWwj102RD66hDI+4mZgNPUhsIoPa
X-Google-Smtp-Source: AGHT+IGfi2/sfAbSI261p8kQDkvcMhiM9zZzCa/NPEZScInVSa+4ZkRkIDqZa+H7v7fzJvkWYW0zdg==
X-Received: by 2002:a05:600c:c83:b0:479:3876:22a8 with SMTP id
 5b1f17b1804b1-47d19555940mr35606995e9.16.1766161289605; 
 Fri, 19 Dec 2025 08:21:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27c2260sm99443575e9.15.2025.12.19.08.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:21:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/24] system/memory: Directly call
 address_space_ldst[M]_internal() helper
Date: Fri, 19 Dec 2025 17:19:40 +0100
Message-ID: <20251219161953.72724-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
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

Inline internal address_space_ld/st[L,D,Q] helpers,
directly calling address_space_ldst[M]_internal().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory_ldst.c.inc        | 47 ---------------------------------
 system/memory_ldst_endian.c.inc | 12 ++++-----
 2 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 5c8299e0cdc..20a2784e234 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -63,22 +63,6 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     return val;
 }
 
-/* warning: addr must be aligned */
-static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_32, addr,
-                                                    attrs, result);
-}
-
-/* warning: addr must be aligned */
-static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_64, addr,
-                                                    attrs, result);
-}
-
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -86,14 +70,6 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                                     attrs, result);
 }
 
-/* warning: addr must be aligned */
-static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_16, addr,
-                                                    attrs, result);
-}
-
 /* warning: addr must be aligned */
 static inline
 void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
@@ -134,14 +110,6 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     RCU_READ_UNLOCK();
 }
 
-/* warning: addr must be aligned */
-static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_32, addr, val,
-                                             attrs, result);
-}
-
 void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                      MemTxAttrs attrs, MemTxResult *result)
 {
@@ -149,21 +117,6 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
-/* warning: addr must be aligned */
-static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_16, addr, val,
-                                             attrs, result);
-}
-
-static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_64, addr, val,
-                                             attrs, result);
-}
-
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 29100c02f80..7078666dcfc 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -22,42 +22,42 @@
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_16,
                                         addr, attrs, result);
 }
 
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_32,
                                         addr, attrs, result);
 }
 
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_64,
                                         addr, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_16,
                                  addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_32,
                                  addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_64,
                                  addr, val, attrs, result);
 }
 
-- 
2.52.0


