Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981D4C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIb-0002Yy-Bb; Tue, 22 Apr 2025 15:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIV-0002W2-9H
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006Cx-2F
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:46 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-308702998fbso5010934a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350117; x=1745954917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5ZBESgZTecJR5yHsh6hj9Vd3EM7w2X/AFWoGjqfiC8=;
 b=GRjQRfEqCbAP2K3U3YuuaCbaNxiSwqOfnfByNGKgJBYR7XeF5I+dyfpcjQKo0pgA8Q
 eEiRxZuc6Y7SjNBhHyTA7GBEVLUiIIhAE780bQ6zIOoIXW2J8L8TzpHPV7mCE/TWS+wN
 sWH4/25B472ySBkNoVg9mQ2vvkEu7BPxL+G7QZ7Ig38zjkuGjvoNuS1yZOEucrvDbMPn
 pZQOmsVpwuH7CR4CmLH3N6rAprVTfx/MhR1R05hEfIP7pfWehN3SXlQW2kc6Duh5AZ/y
 wGQ+RQ33teBaYYYJN5sHlL+/jT1W9ttniqDPXHg7Z+dKY87br0cRE6GZg6iMktaXPtwv
 rcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350117; x=1745954917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5ZBESgZTecJR5yHsh6hj9Vd3EM7w2X/AFWoGjqfiC8=;
 b=Ao3hGvtf4VXCuSOpjiyqO4CaBaozp10oKU9/LvEg6VDABdoIz1w+1OH4eblwFYpp2g
 133BdPVqEAohvlfBGTl1ttG+ZRbKnZ7HvDZzG1Exd21/OnYOGLjwBA5Wc+DQUOasUhWz
 8RLG0rOW9A3/xbrbYpoOTF4pH8GzFo9Hf8kITRZsy40P3ROrM+85+LtfQrhFajCHc5wq
 aEJDBoUc1PfSQ7hVW6O/1tQR0/6Dt0VZuDY+PWlrz9guL9RqZypyM92NKyiOgl7/7QcM
 tzPGf/DgZydYG1Nbedv1y9w+bpK6fXwPTtXiCxXl7XCBrmuKG08HCQjxpw2uqFVuNxjO
 Xq/w==
X-Gm-Message-State: AOJu0YwFdmXFRDd2A3nF9E0c6m92cMOdYYUV0yL5dF+UtMdCB/3iVwfX
 nfY4ql0tanyuTYIvQb0OMkZXfEFH9JUY+eYK61Pr/B0yj66tmAEEUNQCGA7XKvxP4Eb/ZwWtvlV
 2
X-Gm-Gg: ASbGncv2FMRCL7lL2XJ+LhxgySoUi4G04Pu6SEvIMQjGJ1AwNeyE8XH2eKUV4YtVTqX
 dOXdeZkIK60IjhLh6y7/VDlVmCAOpOtAzY5arbltqTPyissvF7EWv3c4smitHkb7io3OGmKBytg
 Jb3l8LKJbxM2OQhsMXQqwfGaBC+IKmHEhApAbL+u4+RRpydSayig38qZ6YoV8VxJ6kNsfzWQeiX
 kQvDi97SGMHOh1RRLY6wzmvW4qdi1DlMF34VUW1Hfcw7h5FiXOBjbpVLBAyfIbiWKBxeXgR6ura
 3mPB0gtlHaf8ABazNTPSEWhr3eS7Z1Vrfs8411Vb5z5HSks4E7G+53EZIITcOll53twC9Le8fFw
 =
X-Google-Smtp-Source: AGHT+IFhx60RJClnYMoHo7fsEk/PcivatXI3xAKYMUaVgo5Opr19xujRozgLxpX+zSr9MvDdGxcjEQ==
X-Received: by 2002:a17:90b:3d50:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-3087bb69fa6mr27181478a91.18.1745350117041; 
 Tue, 22 Apr 2025 12:28:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 025/147] include/exec: Inline *_mmuidx_ra memory operations
Date: Tue, 22 Apr 2025 12:26:14 -0700
Message-ID: <20250422192819.302784-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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


