Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDD2C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmz-0005Vc-Ee; Wed, 23 Apr 2025 20:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kms-0005KI-Hy
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmq-0004MI-1x
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so335697b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455795; x=1746060595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5ZBESgZTecJR5yHsh6hj9Vd3EM7w2X/AFWoGjqfiC8=;
 b=dqYqtkVY/G6W+8LHdnhrf4XHlhjYu/+xys4hnp4IP99ie2dCF0HgbCoh84qvTR3S4L
 +04W/fJGXK1SmzNZTnTgI52PerOazfWNCUy0kHhpzDvuZU/avSDrIATsVvh522qpDBVY
 82JWK9qQYSFY4T4dRTX1xV68ivQVUL+iFkOvwGGXrz3kNXZ635iAQfs3mlORb5QolZuL
 vkY4MFgQofyMmPiwAO90QJshofWwtF54NAviAuJsW40/nL+pMeAIp3lpsd/KqCefR4d0
 rAk+HJy+7qL4wnp2xoEy3DuDH14g0wOWxQn/ZoGA/Bdnie3EhY4Aq4mvRxKl37nVSaBm
 YiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455795; x=1746060595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5ZBESgZTecJR5yHsh6hj9Vd3EM7w2X/AFWoGjqfiC8=;
 b=YP+ercboBNWLqGROExirroApTnZCSygF/gMFczjinfZKTDyDHBBYhr2JbHqkECBeKf
 3FXsbIU/MxlaE/EGu3Gw9CEZfs4UYgwU0YRIyOgPM8sjM3XNNhUjcV7scZ7dkzwI1EpZ
 xBJ7iyT6nEreSiOPrx9+kykf6dHJBaff28gEGaduApcqv+RNU81LwSrFIZEDb4xLh+wP
 2jEtNLegF++6S1HG5z5gbijy/Bq58NZ0U93j2NSHiD5u9EJvfRFV/C5pyxns8ETF0AQp
 DLiGZXp2plHEotkIioljg0g+Ys6AKt2fvPf79zsdBjZlKzc39oiKjxKtcUw8W7hZB++B
 jOVA==
X-Gm-Message-State: AOJu0Yyjjaz5bROZfABEFDl3zrapM6dJCMfhqEkaAbDbHYkntGlzxTmr
 qWDvAalMrXfndgOfMKU2IrSt6WVB1+Xn8TnKkqoVEkQddhTAR3oArb7fWS26+YdvJYZRqGRYjaY
 j
X-Gm-Gg: ASbGncsQRsfONm6y5yBn93jBEufkZvtCSjzo0J1TThw2+/xbjLcDuO0MBTHtxDA+lfR
 jPXBOJ3Va5hKD/cXn2SDdKVf1JNu2VhuOgBwssmo5cfu/uOj+zZr3ev5940kDxLaiz5NdwMyySI
 eu8xjl4p88qc8yljQdgEUBDi3EyRrWONz6GIBv1jMlqvJDJTRy2EFy6/NqeAX1wi45XLXhyBSS4
 0hDe2gEhKEEuGr16vIbrlVksL9a7gf8Q7B0vOEwrml4zdt0Gee/8umCGawhveRk7ssSd0VQb1rJ
 dVdfuqqWrWzBJSp45j9Ee3cdXAJZAgsc6PM78ofxwwjSgyhrw+kgxdqIgygPUBfblpAGRwqX9Uw
 =
X-Google-Smtp-Source: AGHT+IEIObktUWkMzA2Nq/BFsJlmuqX+nRlJMh1nPePLLl3praqojhrviYroambKKO49YoBVJ4AYXg==
X-Received: by 2002:a05:6a00:acb:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-73e24af4b04mr1089990b3a.20.1745455794790; 
 Wed, 23 Apr 2025 17:49:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 025/148] include/exec: Inline *_mmuidx_ra memory operations
Date: Wed, 23 Apr 2025 17:47:30 -0700
Message-ID: <20250424004934.598783-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

These need to be per-target for 'abi_ptr'.  Expand inline to
the *_mmu api with trivial massaging of the arguments.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 163 ++++++++++++++++++++++++++++--------
 accel/tcg/ldst_common.c.inc | 118 --------------------------
 2 files changed, 129 insertions(+), 152 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 740f5d937f..8e8b9b53f7 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -119,41 +119,136 @@ void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
 void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
                         uint64_t val, uintptr_t ra);
 
-uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                            int mmu_idx, uintptr_t ra);
-int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                       int mmu_idx, uintptr_t ra);
-uint32_t cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                               int mmu_idx, uintptr_t ra);
-int cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                          int mmu_idx, uintptr_t ra);
-uint32_t cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                              int mmu_idx, uintptr_t ra);
-uint64_t cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                              int mmu_idx, uintptr_t ra);
-uint32_t cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                               int mmu_idx, uintptr_t ra);
-int cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                          int mmu_idx, uintptr_t ra);
-uint32_t cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                              int mmu_idx, uintptr_t ra);
-uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
-                              int mmu_idx, uintptr_t ra);
+static inline uint32_t
+cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
+    return cpu_ldb_mmu(env, addr, oi, ra);
+}
 
-void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
-                       int mmu_idx, uintptr_t ra);
-void cpu_stw_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
-                          int mmu_idx, uintptr_t ra);
-void cpu_stl_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
-                          int mmu_idx, uintptr_t ra);
-void cpu_stq_be_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
-                          int mmu_idx, uintptr_t ra);
-void cpu_stw_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
-                          int mmu_idx, uintptr_t ra);
-void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
-                          int mmu_idx, uintptr_t ra);
-void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
-                          int mmu_idx, uintptr_t ra);
+static inline int
+cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
+{
+    return (int8_t)cpu_ldub_mmuidx_ra(env, addr, mmu_idx, ra);
+}
+
+static inline uint32_t
+cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                      int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_BEUW | MO_UNALN, mmu_idx);
+    return cpu_ldw_mmu(env, addr, oi, ra);
+}
+
+static inline int
+cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                      int mmu_idx, uintptr_t ra)
+{
+    return (int16_t)cpu_lduw_be_mmuidx_ra(env, addr, mmu_idx, ra);
+}
+
+static inline uint32_t
+cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_BEUL | MO_UNALN, mmu_idx);
+    return cpu_ldl_mmu(env, addr, oi, ra);
+}
+
+static inline uint64_t
+cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_BEUQ | MO_UNALN, mmu_idx);
+    return cpu_ldq_mmu(env, addr, oi, ra);
+}
+
+static inline uint32_t
+cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                      int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_LEUW | MO_UNALN, mmu_idx);
+    return cpu_ldw_mmu(env, addr, oi, ra);
+}
+
+static inline int
+cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                      int mmu_idx, uintptr_t ra)
+{
+    return (int16_t)cpu_lduw_le_mmuidx_ra(env, addr, mmu_idx, ra);
+}
+
+static inline uint32_t
+cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_LEUL | MO_UNALN, mmu_idx);
+    return cpu_ldl_mmu(env, addr, oi, ra);
+}
+
+static inline uint64_t
+cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_LEUQ | MO_UNALN, mmu_idx);
+    return cpu_ldq_mmu(env, addr, oi, ra);
+}
+
+static inline void
+cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                  int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
+    cpu_stb_mmu(env, addr, val, oi, ra);
+}
+
+static inline void
+cpu_stw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_BEUW | MO_UNALN, mmu_idx);
+    cpu_stw_mmu(env, addr, val, oi, ra);
+}
+
+static inline void
+cpu_stl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_BEUL | MO_UNALN, mmu_idx);
+    cpu_stl_mmu(env, addr, val, oi, ra);
+}
+
+static inline void
+cpu_stq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_BEUQ | MO_UNALN, mmu_idx);
+    cpu_stq_mmu(env, addr, val, oi, ra);
+}
+
+static inline void
+cpu_stw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_LEUW | MO_UNALN, mmu_idx);
+    cpu_stw_mmu(env, addr, val, oi, ra);
+}
+
+static inline void
+cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_LEUL | MO_UNALN, mmu_idx);
+    cpu_stl_mmu(env, addr, val, oi, ra);
+}
+
+static inline void
+cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
+                     int mmu_idx, uintptr_t ra)
+{
+    MemOpIdx oi = make_memop_idx(MO_LEUQ | MO_UNALN, mmu_idx);
+    cpu_stq_mmu(env, addr, val, oi, ra);
+}
 
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 0447c0bb92..99a56df3fb 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -248,124 +248,6 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
  * Wrappers of the above
  */
 
-uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                            int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
-    return cpu_ldb_mmu(env, addr, oi, ra);
-}
-
-int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                       int mmu_idx, uintptr_t ra)
-{
-    return (int8_t)cpu_ldub_mmuidx_ra(env, addr, mmu_idx, ra);
-}
-
-uint32_t cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                               int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_BEUW | MO_UNALN, mmu_idx);
-    return cpu_ldw_mmu(env, addr, oi, ra);
-}
-
-int cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                          int mmu_idx, uintptr_t ra)
-{
-    return (int16_t)cpu_lduw_be_mmuidx_ra(env, addr, mmu_idx, ra);
-}
-
-uint32_t cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                              int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_BEUL | MO_UNALN, mmu_idx);
-    return cpu_ldl_mmu(env, addr, oi, ra);
-}
-
-uint64_t cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                              int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_BEUQ | MO_UNALN, mmu_idx);
-    return cpu_ldq_mmu(env, addr, oi, ra);
-}
-
-uint32_t cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                               int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_LEUW | MO_UNALN, mmu_idx);
-    return cpu_ldw_mmu(env, addr, oi, ra);
-}
-
-int cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                          int mmu_idx, uintptr_t ra)
-{
-    return (int16_t)cpu_lduw_le_mmuidx_ra(env, addr, mmu_idx, ra);
-}
-
-uint32_t cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                              int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_LEUL | MO_UNALN, mmu_idx);
-    return cpu_ldl_mmu(env, addr, oi, ra);
-}
-
-uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                              int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_LEUQ | MO_UNALN, mmu_idx);
-    return cpu_ldq_mmu(env, addr, oi, ra);
-}
-
-void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
-                       int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
-    cpu_stb_mmu(env, addr, val, oi, ra);
-}
-
-void cpu_stw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
-                          int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_BEUW | MO_UNALN, mmu_idx);
-    cpu_stw_mmu(env, addr, val, oi, ra);
-}
-
-void cpu_stl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
-                          int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_BEUL | MO_UNALN, mmu_idx);
-    cpu_stl_mmu(env, addr, val, oi, ra);
-}
-
-void cpu_stq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
-                          int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_BEUQ | MO_UNALN, mmu_idx);
-    cpu_stq_mmu(env, addr, val, oi, ra);
-}
-
-void cpu_stw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
-                          int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_LEUW | MO_UNALN, mmu_idx);
-    cpu_stw_mmu(env, addr, val, oi, ra);
-}
-
-void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
-                          int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_LEUL | MO_UNALN, mmu_idx);
-    cpu_stl_mmu(env, addr, val, oi, ra);
-}
-
-void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
-                          int mmu_idx, uintptr_t ra)
-{
-    MemOpIdx oi = make_memop_idx(MO_LEUQ | MO_UNALN, mmu_idx);
-    cpu_stq_mmu(env, addr, val, oi, ra);
-}
-
-/*--------------------------*/
-
 uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
     int mmu_index = cpu_mmu_index(env_cpu(env), false);
-- 
2.43.0


