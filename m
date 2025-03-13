Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0C7C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW0-0004bL-70; Wed, 12 Mar 2025 23:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVu-0004Z9-Sl
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVo-0007at-16
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2240b4de12bso12149945ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837531; x=1742442331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVoMbFg7EbfGAtOBLoOoIBIWJVIAzxoZsRUU0VCamPc=;
 b=Mr4297hRId0k9Tx/QbdVaBcXVSEAzGTqA+z58Z21w9LngBimF9PGWUBPfR4pWXmoDN
 Z82DYYd97vf4wgN+WdWWvUkP5VmBZ9SGU39Sb84KHZ3MHpIKc47hmZmd5U7c5kMFRUPZ
 5TOhBG1wsoPgLlLcJdzPKCzg0sZiQvC/OYjWv67kXt5NI3TKKqCyQB9vHRO1R9EmVu5C
 rUWLgcEnz0ZV9MttlD7ixLiiJj1GBcH2ppcTWmmhb4c0RV737ew3U5CjJTLnGDOLIoSJ
 Omj64g8Kn75jJPttKjTZmeki/J/g1YCE+KD1HdcNTGiogFsm2k1c+g2MIR28cLtoFJH/
 NYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837531; x=1742442331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVoMbFg7EbfGAtOBLoOoIBIWJVIAzxoZsRUU0VCamPc=;
 b=VRXkD/AFglUOzIqTbYDyfSYxpjm8GPMgRaxuBqmo4dt6s2a3ToeFBGaZ+S8ytzFI6C
 sewAg5nk2V4/kuNFM+5iyFDQHK7cuCCjT3RgxWu72qYZgkTdEQMffhRnu/78thHmx4Am
 qU5OURsXFWDjjfsJFvWugBhr3+O1DW56XhtLrJgF21KxuNkiwvbpdIuZwHx/WRik064t
 XHYISXGjosd2sSNktem+3vURjzxHMLHOy2GV/sppJxffLJ3YSw9ayLU+DcHtmpq6sScQ
 jRrxiI6eEOFE/eaBf2lD5T1CIz0AnSVI4y4mdcInDPO+WVl5FoeP5IfJwS2PxFA3knDs
 mNYw==
X-Gm-Message-State: AOJu0YyaY6LJx02aMyezTVIc6hsxpbzJlZUqh2KWW3ERzBgY7phwsOCZ
 XHVwr4MYg1g0vxrsbTfm0yApy3QnweBxCMsegAv1FzZHItWZgrobbBFp4u6zDFDIBGQ6lZM+3xX
 d
X-Gm-Gg: ASbGnctZaIAYJrqqfCDv0JLsMyJre2HkIozw8MPZjq3B2y+FqFBf+vrWtsyRL0ocWEF
 gns6rKKqyfKhQSnAmCqHVu4cP+xxzeOdS6DlCEaOrRc/XqGMU0sO4JDiwGMNpt4ccOTVudMM93W
 twewUF37XSzbh3uXU+qe9xMhnpWj22HdZuhcnVTtepHuPWJs3x5VcS1OSuyly9zswdSaqhSZJs6
 EW8dN3qCpLx4IT0WapTlvENY1PK36ZAIfHv+jUb2mGWH0rBA3JTtndC4T2Ghomv7cJX4dYBts10
 H814bO7XMErT3XmAjGczyP6ps34/VeZuMJPjXs6hwMSNeOXYi7u/vsHp62hRbuUJB1RimgUY10r
 W
X-Google-Smtp-Source: AGHT+IH9wVMUbH+TOWAzeB+xa/o5AbtZCd4Z/0/zVyziPYoKgN5EayS24b6tKA0UACtlvtdYYfqq0w==
X-Received: by 2002:a05:6a21:15cf:b0:1f5:6c94:2cdb with SMTP id
 adf61e73a8af0-1f56c9432a0mr26871501637.18.1741837530974; 
 Wed, 12 Mar 2025 20:45:30 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 06/37] include/exec: Inline *_data_ra memory operations
Date: Wed, 12 Mar 2025 20:44:46 -0700
Message-ID: <20250313034524.3069690-7-richard.henderson@linaro.org>
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

These expand inline to the *_mmuidx_ra api with
a lookup of the target's cpu_mmu_index().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 144 +++++++++++++++++++++++++++++-------
 accel/tcg/ldst_common.c.inc | 108 ---------------------------
 2 files changed, 118 insertions(+), 134 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index b33755169e..963c538176 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -84,17 +84,6 @@ int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
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
@@ -103,21 +92,6 @@ void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
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
@@ -249,6 +223,124 @@ cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
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


