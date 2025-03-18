Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B99C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueY6-0001KV-0Y; Tue, 18 Mar 2025 17:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXr-0001Eu-QX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXo-0000jU-Vb
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224171d6826so23860765ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333535; x=1742938335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vm0/nE2CjM27q+FxSsNB0we+deYSuG4Jg/ZtoddLVow=;
 b=UFn4eWldOVVjy/fCfVSTLg8ZPFuDA2q7ErnhQWTrelz3WVD3eG04XVp7kNlAT63B83
 EneyL2SecKANbvIa1LKbViR+BQOHS9lIcHgUtI76huXg+4Wh9Vi80sc8HDleCcihLLlq
 5qP58FbaH71XjzgLJ5f+FzlyFHRG04meGaf7wqIMKbi2c5SOqu24/EoJFqG3/aXHOmeC
 wmu1Ah8TF61v+pMDG7aG7cREnKQnjpMTVLFXeCCMQuC9X3zfdIYBG70Wg1VQUOjL1OCf
 WEbp9cZI99xA8J9q2RTwO7fAzaLnTWtb64EZp02toniy0VoQ/ZBUQBWB+h/EZ+fBsg3q
 /Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333535; x=1742938335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vm0/nE2CjM27q+FxSsNB0we+deYSuG4Jg/ZtoddLVow=;
 b=gnm9QZIv5/WNTgcW849CbHyPscF4njz4bGWKdfAk/kgCYm2SCCmEPvd4XXiHF73Xj3
 Ah2Ak6yGOsh/o9cOFKtWNG0zWdgtXX0U/4hxcnjCSX7zocs0VBeODhuq3t6luK6qcBGO
 mfALfeT87SJ62itdfwRkdlZ7AjMRErxbQTo8c6tbRMWPKOvq66lw9UTak5V9PU6Rf9lE
 AUr4MoVljKB0gdkdTkx4Hn+kymx4PlO0b3GE+6xC7/FmAvVj5vhYpb6wW8lhmTXQTnGq
 H/M4DJdZsQog1cZg1uunt682PgmytH6dyap2hW50uZnKBU58UEV5BqdZ75RyGa8AJpGG
 IEmA==
X-Gm-Message-State: AOJu0YzHKTInXeZCGivrtyl/TAOkttsDQhkAyu+D7cV42wJK4Q7ja/wP
 3B71yD41LC0+AwL9i/vxj9oJ9Bi7i0l6aEyAr0EmPNbAjkaFTCVxqhBJn4xU1AZFjLjBcNLPW4S
 F
X-Gm-Gg: ASbGncsdD0Z4WLPn+kKHZbECVdNrjNnWXVrJDP+ibuGXSd0Nm1mHdbZ1yt280ssYhe0
 NLg3HT7ZAQKuMsX1o7Z5zE+zWPjKR0X1aKlyyFDid6BS1L+IqGicVOWk5uioUSMtlqiJGw7RoZN
 hMYeHaHT64drhkx2ynFMln4G4lZLPHzMQuhSzAHwvnwa2pWNXfns7UtUxcGhBhFIKqzZpsxHLJx
 amwF1xFvzK4otWcgtlmuJVhlrPvERHmoxYz4bnBhaBFUQqLf9RaL+DET0HeaASJlcH3T1yWdNwA
 i80ocxe6lL4hZ3YTqbhWHxpHedwrbp+GyPFi3f6cGLWq89R9ad2JhEIvjqkWljy6pPy3dU6n+7b
 J
X-Google-Smtp-Source: AGHT+IFjt/KiMf/9EJQ5M7Yce2UGcqJ5URlBCC0UMpVFr9p04rrUwV/Unc4s1ABhJ88UCifJtkKsfg==
X-Received: by 2002:a05:6a21:3947:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-1fbed40d102mr305000637.38.1742333535449; 
 Tue, 18 Mar 2025 14:32:15 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 07/42] include/exec: Inline *_mmuidx_ra memory operations
Date: Tue, 18 Mar 2025 14:31:32 -0700
Message-ID: <20250318213209.2579218-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index 0b10d840fe..4149f04368 100644
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


