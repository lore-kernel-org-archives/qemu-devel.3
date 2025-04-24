Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED70C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7knN-0005t5-Fw; Wed, 23 Apr 2025 20:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kms-0005Ki-VO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:59 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmq-0004MP-PG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:58 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1419882b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455795; x=1746060595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBJ25CW2meY1UvcVJM9MvkFiNWSNHNlPBGliBqgnkKg=;
 b=A5hG/Ey0nXpC8POnKSt5goCze04ZGpH6UqxuDe5xe5AsZW+OC6KbMeOLddfoiodFNV
 KooD9J4gb7G0iaHzL+WWMjID5GQegJsXoK+d/3VGanGGt3YnZHkLRKn0iO1qGifTEl5l
 Sd654RCleBAjtYnCVaH5OWbq5yIOHHOUA02f9l9e9VmZIiNdIJ/Cp24QftxKAingOIh6
 0vTVau9hFTa6NjBgobJWssj+zYJOc0au+RqaqjbomxWqzPXY5NzSfbLT8k50DbTh5o6j
 y6hITT951kp9tzyqJgCrJsKl5AFZ9citntpIXbtFiBgKbr1U5X4cujst5SlG7D52kMCH
 jEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455795; x=1746060595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBJ25CW2meY1UvcVJM9MvkFiNWSNHNlPBGliBqgnkKg=;
 b=Aq8BXlRj2wXbedIfShRNftRRor6KqSHljpcrPV9nrhymCs2ZGVVaHxkSLwAN+saDG/
 R5FGvhck6NTwVyxCuiE0qyvVN0Dfelw+PbjdZ58dF462+1OLOVVQ9YSQ9xEOk3XeILcl
 KnpLgKBzhnxEmfga9jyCGhNpYJWcn/9HBou2+zvYCQ8LaZGDlOm5l1ygmt8g8PYw8mis
 xY70M/UaGfeeMYv/017wmzUtQtnZVNnorlY6+Dbofa1J6Hr4dr9KrzVN6b9mK06GEV0P
 O14yIpTIZrwq1Yx1c+cuKPPLdVrOh+SsfscGYCK0+C4xQvDNsdKor9XZ4+Xounxnldbd
 Aofw==
X-Gm-Message-State: AOJu0Yzm8pPEuiImGDXtOq5aNk1jmxlhuyIY1eOWYoMT4FQyDc8yRFgY
 uLxH1teWgcEad16d9iyJr9r8wmL/yoY071B+5rhI8OhK+si8ipAJYVjSeHuzk7JCoDZzpkSNuVJ
 A
X-Gm-Gg: ASbGncuVjnyMWpXPzpUNgofR9esjvqe1mKrdtQyO8T+GeHk63DFQ/7l0QxqDcHxFPQr
 FGxJZla1tvRHEmeULg0gojpAn1tl44tZ4OEXfTpTD3MnPqhI2cbu4Y5eWkz276ZLVcMmnLE2eNO
 YyT0Anhz+5JVCUUkFbDkV7fWpUadQtvWNrEDY5X6a56x0G1/eREwSBQVBdpHNwpRo8aft0byEgl
 +xiYxJFjrsFY7qfdDnaMydHD6bjKzyvDdJs7fhtJOkDNnY3/ogIy71vywafmH6W56D6exPvh4Mk
 b0QGljetJ5zTc2CqiKHNm7+nIpdMY6iwuL04n8ncNnUvU5XDs1tlBoeQVgCEcuWStXuHH4acg/E
 =
X-Google-Smtp-Source: AGHT+IFRqGDOpBlZIzKk5oOj3pP7R/KDOgZ2iEQki7hjVOqLkNwWT7dAgW7AKbMbI5WhJfktiqEcjw==
X-Received: by 2002:a05:6a00:3a93:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-73e267e0e5dmr620407b3a.5.1745455795413; 
 Wed, 23 Apr 2025 17:49:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 026/148] include/exec: Inline *_data_ra memory operations
Date: Wed, 23 Apr 2025 17:47:31 -0700
Message-ID: <20250424004934.598783-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
the *_mmuidx_ra api with a lookup of the target's cpu_mmu_index().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 144 +++++++++++++++++++++++++++++-------
 accel/tcg/ldst_common.c.inc | 108 ---------------------------
 2 files changed, 118 insertions(+), 134 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 8e8b9b53f7..2eda652a38 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -85,17 +85,6 @@ int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
 uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
 uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
 
-uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-
 void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
@@ -104,21 +93,6 @@ void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
 
-void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint32_t val, uintptr_t ra);
-void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint64_t val, uintptr_t ra);
-void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint64_t val, uintptr_t ra);
-
 static inline uint32_t
 cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
 {
@@ -250,6 +224,124 @@ cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
     cpu_stq_mmu(env, addr, val, oi, ra);
 }
 
+/*--------------------------*/
+
+static inline uint32_t
+cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline int
+cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
+}
+
+static inline uint32_t
+cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline int
+cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
+}
+
+static inline uint32_t
+cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline uint64_t
+cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline uint32_t
+cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline int
+cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
+}
+
+static inline uint32_t
+cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline uint64_t
+cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline void
+cpu_stb_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 99a56df3fb..2f203290db 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -248,114 +248,6 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
  * Wrappers of the above
  */
 
-uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
-}
-
-uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
-}
-
-uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
-}
-
-uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-void cpu_stb_data_ra(CPUArchState *env, abi_ptr addr,
-                     uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint64_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint64_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-/*--------------------------*/
-
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr addr)
 {
     return cpu_ldub_data_ra(env, addr, 0);
-- 
2.43.0


