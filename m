Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D39C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueY3-0001Ij-HN; Tue, 18 Mar 2025 17:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXq-0001Ei-Kn
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXn-0000j7-Qh
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224019ad9edso4652635ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333533; x=1742938333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/SnGbiJXxdcdsQzFocCM8W+C/HoHgmlhXBwGvsNJIU=;
 b=YtL14j50ljH94QUeNR72+WRSIl7/ybWGj/axI+KwD5N2cnD8+cQXgzp9LUQ3CY3RcF
 2zVgePGRht+45xxvbDvCHSYdFoYnFI2O7FNzc0Qh4c7LOF0FWpyfJFoyXAMr5C/NI7Ud
 BidMji6oS03mq/n56YXJHEv1eA30kR4xyGypzQ6kKTGoqKD9Ml7sY+o95G1mIIyFjmGM
 SkdcfjVDUesz4aOBedc9bDImcKLo2KP78kfy0T+8x9L9wxxAKwewHXc3rbzDf5IuMZ0G
 PM4eEnQLnswkNe9NcTyiZI8WXVaNOWj2SRvF5QVTsSPZJNKg7146Qq2SecjdRtmfdsEw
 k70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333533; x=1742938333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/SnGbiJXxdcdsQzFocCM8W+C/HoHgmlhXBwGvsNJIU=;
 b=H2WZvavH0zozEU1jpDk/G0rpMnp/nZle6e5vE2+2CTVIlAt1WU2fUzE8oFFWlWcRiL
 Lsz6E/zYrkz41hmnmLOk9tan/1c3IsEG0TGTi8vPFe4sb9B7rcTYHD9zD3rZUB6Rqckg
 lxTPWKbEFGwPr5EluFatXcex7Y4xcGZMArsItx0vhAfsinYQSmyqbieJc7xkSPc6LR75
 xtFm6m/ui/UpRbCB3oXA3Z2r8OXbitQLafnyBCZrDnfJzHV63fdW2rps7IcaUsCW5QSL
 2AmotOXU43qeGdAoeLHONaoWeOZy8Z6+W3io7EVSYrp146cr2ujaArZ980Opw3d5sDRJ
 D0NA==
X-Gm-Message-State: AOJu0YyLvBkMaTO4xvpvdHo2GmlsrGFYs52ny8xL5Lux+5vYin3Pc/pb
 JIppPvlUUiecuco7deWomYsi4l1mjfU24Bc2Ol9C848aJr25QotHx0w+MT2NIOOES6CtHiV6DeH
 6
X-Gm-Gg: ASbGncutrPdcrsmtV467QD+RdrJ4H8goBHVvC6HEXOixasSt7ToInvXG0LJ5KVSWTDJ
 WyxfOBdSrm1sj0pg4F4duqbyD94+Dy8YDr4ktGqwGtR+vPLrfU1wZ3iIaJRNXKdJa83VCEzmw2q
 OHXTkQ3ueCbJq7Drzo9ohIaHBrZlq8GcNfZ3DVJrZg0RTfvzBJ72Jr/YqmAH5gS5pD8hMd99s4C
 QFHaQ6VWgpPZ3OtI1YrLWT1NjuCJG4jfseLVk72nI+g/xRZxf5NPV20YNlxm7It5gtUY2XYTcsA
 2YTNL3Udj3YhX7ef5KgqZq+GdFIjAt3lrbMoapLE9fRaA0wfR7yxyg5mdejr+4/RQb0Er2D3BF2
 x
X-Google-Smtp-Source: AGHT+IH+j56b5hYQvfAVLtjpXEW35j8pDxvxg4Ewa0VfMKr7vU82xRvIJaUTh/4fccx8158bkOzB9w==
X-Received: by 2002:a05:6a21:62c2:b0:1f5:80eb:8481 with SMTP id
 adf61e73a8af0-1fbeb7a2128mr362799637.13.1742333533206; 
 Tue, 18 Mar 2025 14:32:13 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 04/42] include/exec: Use vaddr for *_mmu guest memory
 access routines
Date: Tue, 18 Mar 2025 14:31:29 -0700
Message-ID: <20250318213209.2579218-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use vaddr only for the newest api, because it has the least
number of uses and therefore is the easiest to audit.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 629a1c9ce6..dec17435c5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1254,25 +1254,25 @@ uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
     return ret;
 }
 
-uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
+uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra)
 {
     return do_ld1_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
 }
 
-uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
+uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     return do_ld2_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
 }
 
-uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
+uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     return do_ld4_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
 }
 
-uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
+uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     return do_ld8_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
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


