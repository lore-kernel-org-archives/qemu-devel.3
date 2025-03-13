Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D24C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZVw-0004Zw-6B; Wed, 12 Mar 2025 23:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0004YL-BV
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVk-0007aR-RJ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-219f8263ae0so9601855ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837530; x=1742442330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66Nwe/+SFhs9zP1x34rLgBB7tcriDwmEqicbXY8oWM4=;
 b=rNj2l0NLkqLGi9o7/xOxYhoK0an7RCv25I8ly434KL+iDcEnjl6WKysBHiibp+f0n9
 zbMTceV7qSc5H+SGmOGU9Frs2AMMquuwNw9J1yGUaQPO66B0m7dAtoO8gsng66cf9py0
 kpuyuS1VphkT87TB4gtmceHucKqruStMpQX/uAQ9lFycjLnf3VPd1YoGHnKb3NLemZjo
 VQaJnGSr6P3o31HFdf/YGzo+9r0Vcq8gvgEm8eku9ZR0H8ulWZPE4gLW+cpuRZdZF5qy
 Dgrd0hmyi+PXifvofWBY/yBoMIsRqwC5g/XdPle1rX23cBrTJvLoV/IehjON3w1IBCIK
 Glyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837530; x=1742442330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66Nwe/+SFhs9zP1x34rLgBB7tcriDwmEqicbXY8oWM4=;
 b=HfEpsCfu9N9PTlg4knnyEaaqrBuENblaPuRcxRu6qU+IUzfIh9sI+p1UiGgScw/eXe
 e3w8jtbS1/gLQwXHTyNqRb2M1eibdCEnFGHQNpsQt4ItC+IJyUjhZnZ+UgTKn5V/g1qC
 yF5/vYlXw6sBEOMQhLyER655yVGauU7ZmBjz+/akSvaaK1n0DeuJpifPzIrGuqcTPG4e
 IpinqNV5IokD/TxE6ZcTPrUNaeG7DL0iDy8w8xeou7caG/rsB3PTMLk3kZtJZHYUhGGO
 ff5Eeqm86JCnNBjeR9f8FomGPrM5d/lEUi2yV8Cuamyx/zrYkXC5lpYgWobBChh8w5ad
 koWw==
X-Gm-Message-State: AOJu0YxLru3Z6O/1YVSrT+qmNu0rsonf1xPuwjMXouvIOTE3UEaKcbZJ
 QxE1+2mZisCGMhA3VTIdjNk3Nl+zeCgu9yOS0kukJf1C34z8rOqNuYE54p39r0otPjxWwNV93Qy
 Q
X-Gm-Gg: ASbGnctK30lx45n3lTCSk7ZoGMEVIP47PMYr7h2ReqZJ9GVcH6f/OIGD98kaZQ4kPxk
 lbbTrA/QDW6VjGZ0jAJblQzziQqKXkCOD5ogICHFS413hyrRAsdhh/xkfDz1dj0SOPzZxNa/Q9Z
 j2DmKW2bj/ZoSs7eZ/LWCMKouFM2MYFMo16oJsWUK0wJyDg7b6IjKe3MhwS20FjHxFGXAhNWplq
 56nOf2Z65rpyt7c89qKgfspp9K5klcNIStFw2EuIcz0jFj6om5ajdirmElDTTP1N8/iAAI028FZ
 00mqk1Ts/S/02uEPL8xnuUKMH6o3tneSmr9hBnNls/TXyNtmwsw+gepDHwC16UFRewfVjcOICeF
 r
X-Google-Smtp-Source: AGHT+IH6/qIgVcUI31cfCSKNIlJdEfL2nGoeiL3FWALA73YZ4YOSHIPe9C7tsOyj733hBGzVdKrpqg==
X-Received: by 2002:a05:6a21:7002:b0:1f5:7fcb:397d with SMTP id
 adf61e73a8af0-1f58cb1bea7mr16029737637.16.1741837530231; 
 Wed, 12 Mar 2025 20:45:30 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
Date: Wed, 12 Mar 2025 20:44:45 -0700
Message-ID: <20250313034524.3069690-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

These expand inline to the *_mmu api with trivial
massaging of the arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 163 ++++++++++++++++++++++++++++--------
 accel/tcg/ldst_common.c.inc | 118 --------------------------
 2 files changed, 129 insertions(+), 152 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 1fbdbe59ae..b33755169e 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -118,41 +118,136 @@ void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
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


