Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4983FC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZVy-0004bH-Fk; Wed, 12 Mar 2025 23:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVv-0004ZF-BI
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVj-0007aA-Dd
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2255003f4c6so9400345ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837528; x=1742442328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibiGjuidp9yYfKMevOqZB9YtgzFUqWPxg+fdMQ9xtnU=;
 b=Os4j1uE3/Z8JgEP9XYhyragazxILRZcneUCW38K0HYgDhC5zZX7dCLjVrR6YBTGn/O
 fZT+ZMUUHQ9YzA4vdW3D2wyot8mPJft/+mwuMg5AI7M7X0cdtXyzqdxrifUp5WAys2X5
 HSKEsNe7KB7hD6hlrfgcDpJ6cuqDAhuLA3AYkZAjuE5BUVALonr68fNYJtBLDeTvk81r
 AsnbW5xf8GpNhN7r2cePt2ClZaAnwzeF0oXV3kSqijUVMOF2OpJwKtGrvYc86JFDk4aX
 yJvlq8XnlPLBwBLvh4ovuIomoTduV2+2FU2TltNxit3E/RhOwrbEOySuyPiqXQaAI4Cn
 lNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837528; x=1742442328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibiGjuidp9yYfKMevOqZB9YtgzFUqWPxg+fdMQ9xtnU=;
 b=OjfWwToCjJN5Gk9Gb0NumPwCN4k5q0VVBLRxo6anrDd63SjjhwH0JaRIYKwYrYQa7J
 mczrAA6+ALwqAhWHAi+QoAVBy4pTQ7WVSXmnC6He6XCMHtH3ajzcc3eCkrOXTkFAi/C1
 +DD2F4q2RugLlQ1wUFJo2bHC7/GU5vPZb3shKDG/UIuypIxntsLtVH3Oc2Gm2adOFpOQ
 YPHwoeFysFJG5N+zmolQJMb61D/bt8oa1xj+w3tbrqANMxrVh7jt4C4w1yjmqlrlXWoj
 U2YKWatNEHXYC4K0zbQ2kSiFrEj4sVZYtq6pqVXSOUuAXKFe478OX1NS7fJS605LkRmi
 q0KA==
X-Gm-Message-State: AOJu0Yzbk5/hG/o3Phg0dxclZYf8ZMyAoMqF2gfcQfAK+0OGc/EVEmVB
 KMV9GPTFdr5IYbecPK85Zeabd4I+OxnR0CrYb3XXk1GGF1Rr/4eSS2vVLyFpI9MJEhHNJEk4Rf7
 F
X-Gm-Gg: ASbGncuGTyE9X1MezitC3srZin6cZITS0vYXPZtqCjB8tMIhc5UFGDiz6ObGhJJXUkb
 P/wMIzawOwuIKb4jcT4/OXXzxnNbuUEmIEFqObxiFKGvRNz6vxPN9jH8JkNPDpBg8LJfT1OkRVh
 wC6xB0A3RIn4Dhazpez659xk7qRwX+QZavVSnMt/MZy2aEgtHEUa1Pwzpm67xIjZ6I7aH+EQZ6M
 Hg0uFlfSwVb7b2p8F+gj0NQD3CvEQo+NjhHY9e2NilJ+xG/XSfR2nPY8viJIf94p0DZ4rpkHIku
 63zWRcd8ZemnYQuLjbk29/KhU1Mh5PhObdKusv0JUWt2UgphBtyxJGT+0IKeodt0q8yOZW/52pa
 s
X-Google-Smtp-Source: AGHT+IFe0W/sEz4LO4GMz+/isLbvGVchpdpB5Elc7b13WPElyWkx30KfIeOsbPpADR8Hf2vI8v8nUQ==
X-Received: by 2002:a05:6a00:2d91:b0:736:a540:c9b5 with SMTP id
 d2e1a72fcca58-736eb87772fmr13324256b3a.22.1741837528550; 
 Wed, 12 Mar 2025 20:45:28 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 03/37] include/exec: Use vaddr for *_mmu guest memory access
 routines
Date: Wed, 12 Mar 2025 20:44:43 -0700
Message-ID: <20250313034524.3069690-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Use vaddr only for the newest api, because it has the least
number of uses and therefore is the easiest to audit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 16 ++++++-------
 include/exec/cpu_ldst.h     | 48 ++++++++++++++++++-------------------
 accel/tcg/cputlb.c          |  8 +++----
 accel/tcg/user-exec.c       |  8 +++----
 accel/tcg/ldst_common.c.inc | 20 ++++++++--------
 5 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 89593b2502..08a475c10c 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -77,7 +77,7 @@
 # define END  _le
 #endif
 
-ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
+ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
@@ -101,7 +101,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
 }
 
 #if DATA_SIZE < 16
-ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
+ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
     DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
@@ -120,7 +120,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 }
 
 #define GEN_ATOMIC_HELPER(X)                                        \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     DATA_TYPE *haddr, ret;                                          \
@@ -156,7 +156,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
  * of CF_PARALLEL's value, we'll trace just a read and a write.
  */
 #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     XDATA_TYPE *haddr, cmp, old, new, val = xval;                   \
@@ -202,7 +202,7 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 # define END  _be
 #endif
 
-ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
+ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
@@ -226,7 +226,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
 }
 
 #if DATA_SIZE < 16
-ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
+ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
     DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
@@ -245,7 +245,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 }
 
 #define GEN_ATOMIC_HELPER(X)                                        \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     DATA_TYPE *haddr, ret;                                          \
@@ -278,7 +278,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
  * of CF_PARALLEL's value, we'll trace just a read and a write.
  */
 #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
-ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     XDATA_TYPE *haddr, ldo, ldn, old, new, val = xval;              \
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 769e9fc440..ddd8e0cf48 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -157,48 +157,48 @@ void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
 void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
                           int mmu_idx, uintptr_t ra);
 
-uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
-Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra);
+uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
 
-void cpu_stb_mmu(CPUArchState *env, abi_ptr ptr, uint8_t val,
+void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
                  MemOpIdx oi, uintptr_t ra);
-void cpu_stw_mmu(CPUArchState *env, abi_ptr ptr, uint16_t val,
+void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
                  MemOpIdx oi, uintptr_t ra);
-void cpu_stl_mmu(CPUArchState *env, abi_ptr ptr, uint32_t val,
+void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
                  MemOpIdx oi, uintptr_t ra);
-void cpu_stq_mmu(CPUArchState *env, abi_ptr ptr, uint64_t val,
+void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
                  MemOpIdx oi, uintptr_t ra);
-void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
+void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
                   MemOpIdx oi, uintptr_t ra);
 
-uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
                                  uint32_t cmpv, uint32_t newv,
                                  MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
                                     uint64_t cmpv, uint64_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
                                     uint32_t cmpv, uint32_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
                                     uint64_t cmpv, uint64_t newv,
                                     MemOpIdx oi, uintptr_t retaddr);
 
 #define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
 TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
-    (CPUArchState *env, abi_ptr addr, TYPE val, \
+    (CPUArchState *env, vaddr addr, TYPE val, \
      MemOpIdx oi, uintptr_t retaddr);
 
 #ifdef CONFIG_ATOMIC64
@@ -244,10 +244,10 @@ GEN_ATOMIC_HELPER_ALL(xchg)
 #undef GEN_ATOMIC_HELPER_ALL
 #undef GEN_ATOMIC_HELPER
 
-Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, abi_ptr addr,
+Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
-Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
+Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
@@ -297,13 +297,13 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
 
-uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
+uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
+uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
 
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876..b03998f926 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2925,25 +2925,25 @@ uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
 }
 
-uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
+uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t retaddr)
 {
     return do_ld1_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
 
-uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
+uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t retaddr)
 {
     return do_ld2_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
 
-uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t retaddr)
 {
     return do_ld4_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
 
-uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t retaddr)
 {
     return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2322181b15..3f63b194bb 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1254,7 +1254,7 @@ uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
     return ret;
 }
 
-uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
+uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
@@ -1266,7 +1266,7 @@ uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
+uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
@@ -1281,7 +1281,7 @@ uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
@@ -1296,7 +1296,7 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index ebbf380d76..0447c0bb92 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -135,7 +135,7 @@ static void plugin_load_cb(CPUArchState *env, abi_ptr addr,
     }
 }
 
-uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
+uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra)
 {
     uint8_t ret;
 
@@ -145,7 +145,7 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
     return ret;
 }
 
-uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
+uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr addr,
                      MemOpIdx oi, uintptr_t ra)
 {
     uint16_t ret;
@@ -156,7 +156,7 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr addr,
                      MemOpIdx oi, uintptr_t ra)
 {
     uint32_t ret;
@@ -167,7 +167,7 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr addr,
                      MemOpIdx oi, uintptr_t ra)
 {
     uint64_t ret;
@@ -178,7 +178,7 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
     return ret;
 }
 
-Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
+Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr,
                     MemOpIdx oi, uintptr_t ra)
 {
     Int128 ret;
@@ -205,14 +205,14 @@ static void plugin_store_cb(CPUArchState *env, abi_ptr addr,
     }
 }
 
-void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
+void cpu_stb_mmu(CPUArchState *env, vaddr addr, uint8_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     helper_stb_mmu(env, addr, val, oi, retaddr);
     plugin_store_cb(env, addr, val, 0, oi);
 }
 
-void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
+void cpu_stw_mmu(CPUArchState *env, vaddr addr, uint16_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
@@ -220,7 +220,7 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
     plugin_store_cb(env, addr, val, 0, oi);
 }
 
-void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
+void cpu_stl_mmu(CPUArchState *env, vaddr addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
@@ -228,7 +228,7 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
     plugin_store_cb(env, addr, val, 0, oi);
 }
 
-void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
+void cpu_stq_mmu(CPUArchState *env, vaddr addr, uint64_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
@@ -236,7 +236,7 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
     plugin_store_cb(env, addr, val, 0, oi);
 }
 
-void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
+void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
                   MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-- 
2.43.0


