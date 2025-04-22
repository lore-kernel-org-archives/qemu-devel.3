Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB118C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JId-0002aV-Gu; Tue, 22 Apr 2025 15:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIV-0002W6-BP
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006D1-2m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:47 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so4859083b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350117; x=1745954917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBJ25CW2meY1UvcVJM9MvkFiNWSNHNlPBGliBqgnkKg=;
 b=xDiylsLDoFy/WzdeIg+MQ3iGS4Pntlu37xf2/u4AaoAuRHf3RzqpNU4Zaslvijht40
 VUwejp6FXUR99HPmxv8+XCtXYnQ1lyTiqrYcEQftKcc9TQPUwq4ETKaIzNc6fMzezJLx
 nUScedAGYTutNati7zpS3efwGdT2wz3mRktAMaTcLyExzNZhHjY5x9f+8UYHyHDAUDB/
 9sKLSH2kXo8Ae+tXWRhDglV/GHc6B+AOkEZThdn1moWXFy6i6oYhnaRixwnBRh0+2CQk
 r0U8FLqI2U5oJXs4MzC7ngtKe4l2QcR8yOorjxbNuT5k2XTrL+APjlgWrs36jfwqKsMM
 agUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350117; x=1745954917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBJ25CW2meY1UvcVJM9MvkFiNWSNHNlPBGliBqgnkKg=;
 b=GLoqKGMY6PBgrfmt1WNw+PECtBI4phUU3919FwzexbHFyXCRf5mp3h2QtLRIrJxcqX
 +jrh7UDXDGuAr8IKLcqzphSyln+0Mwe9PShx2LOmgXVGgx5JIq48Fuh31R3DBTB2IkU4
 6n+XbIh0i84s4RWnoRhLl8T0929L20mZzxGy4x95fkowV6J2CXnyS09VCnlTZw8xO+EJ
 t3mO2bl/aTSKuayWhiH2hU56GRr/jtzbHnJx8Jzi/v2qrw9G2tuU4ZYArTTdBD+xIrTg
 HlqOB0DZnJkjKRoJlt3aLQRx9wrtc+cGuuN4nL6CWNBAmQpJoWBVZAQxQ4eLb9czCUST
 8Xuw==
X-Gm-Message-State: AOJu0Yxom99EW+Y/HnJM7u4wxslvTT6KJbNFRvzUjxGb1kEWM81tiIwY
 ulvmbap9hQa5A8qAWpNYJcEdfFmdxGguzffcHtVN0cBJWHi21zZ8qsPZ58wDzwRuoOtGiVf2ho6
 2
X-Gm-Gg: ASbGncuTdCaDXVRbBRcREdmjm/XfcKABGxQ57SZtct/QK2m998iY+q+QTlsgQlmHIgx
 isTF6D5/yv82podcEno0RmVjDExq+AriOBxoCe+x2o26wLF9VHVEU1WDxugUhVZXVBpFMff3+7D
 tPbCSjZo9eI+UdH03BgjPKgJ2TXKIKeMWzsptlB76nWQGb5Yf58NVpg2WHKPu6v737LtHLMnobm
 pnAWGaH8lNQnI2FAqDRojx4rNesj4sYJ2RjYMoz1+QbD4Mmd8AFrp/xjHJOCq0Cz9ya0fyB48WE
 o7Sm8+sAmQ277HxzWoxZ8cULRJ/iRpJYLkUXvR+oRXI+15lGVcGse0oKWD5GZXya1V716Rsex6c
 =
X-Google-Smtp-Source: AGHT+IFPvflrERpoZTsZ6yKf1gL79NXvd9JiSz1/poZgBkuyUCcMJedy7A3LCLtC6hMlgD01YVk/5Q==
X-Received: by 2002:a17:90b:5646:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-3087bcc3a23mr27201413a91.33.1745350117636; 
 Tue, 22 Apr 2025 12:28:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 026/147] include/exec: Inline *_data_ra memory operations
Date: Tue, 22 Apr 2025 12:26:15 -0700
Message-ID: <20250422192819.302784-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


