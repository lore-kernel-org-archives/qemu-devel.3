Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9875C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueY6-0001LQ-Uu; Tue, 18 Mar 2025 17:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXt-0001F1-22
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:21 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXq-0000kH-FZ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224341bbc1dso118071315ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333537; x=1742938337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auoZ5sagChoUoImtq+fRnexF2VfkXuVWg9ycaR6Q+kM=;
 b=zVP+cfuY6ib4ilho+327OYcV6Wi7X51rcxoRgqm8fFxKLEgS5C50SBNa/zkeNwH/d2
 D8PUX0wz71rBrT4atyQw3qYOIwxBeBlaFkAC/wBF6zdGcB19rORPrFXSxzuKF+JVom23
 j4rE5A7d4u0g1yy7YScbdXE7AmZ4Uc9Xbznakrgp67z53CoueEQZ7wwP9sBsPo65/1vT
 3IS18t81dwBboJBvATmcoad2j55CtcGsRGXHHdCzaAsWw3taZVIhC8QaT4f46ATHGXAD
 D2/igHcZGat9GBdmlMzqcWvbimeT+lHM6PZ6vmlV9ENuGbnWISycmKtqpZoXt7r7xDpB
 IM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333537; x=1742938337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auoZ5sagChoUoImtq+fRnexF2VfkXuVWg9ycaR6Q+kM=;
 b=qBh+CLg8Rrq3cUKn7tpruChlFt3LWvjhBcgzVPfTv07RNOqx+dGpuWx8I3FBvurMLO
 H+P9a4SMIcEefEiou+GtTJpgCcYDIwYpgEck1rydz/PPD4f354/LV8Rqw52Jrs6Ep+VP
 UUzqeukS3KCjaWcpBGhqg8fuIA6g6wFU5TICVkqOzG0DAAa/WYpWwgcjFw7HaZZeyHPz
 4Ez1dbBql+8dyAs57AV7d5hS9SJofdLpEc3mp9l+WMtyreWYjdC6hH9GMGw/IdlCmomB
 YZRgkd46O8T5cnoy/RGxjL7RkVdOAtaBkWa77qQWBfvovqa+NNew82+qsDEnD4aqRE89
 yVDQ==
X-Gm-Message-State: AOJu0YwZUTNCjYWnIVOQFCwo8BdeLbvJg+y24uOkD1tT87QcoTF1FJT6
 2+Lwk3cuKIzApotC4oXsp9M48keqS7EcIb5vnxEHumumsqhaOnb/eXd2l8huwcAUrRBk7g8OkJn
 d
X-Gm-Gg: ASbGncsJwVnuaZNTbiqaCGh780w4EET4oS6Tye877l92oecVHyZuJ/FPwtZPqt83akI
 6soLp7J1kHn2YB2MqC20/Xx1nI9MebljS/vZjNCOjprcARzmxsuwHVrkbOv9JC/4SqTybx7g0yl
 91cL3UZVKP5s1d31zDkyob39V2ih19XL2OSvY3YMZYzporTYNKaxbCJ6U6hSUz4xCyZhnHdGb3T
 oZvGJBo4CgPSmvOWC67aJLSLbKNO0lBeeiU5QxBx32d+mqg/kDQQv9MnNlaEzZhjEhdN04CAllO
 ThiVSDXyPA5IkRyw4xoFP5iKp1iyd43SFsu4r2dI/17OGMmc6IrRmjHDzOZ5CW9hBSFVXW7iHkD
 40FMwmnZ3L74=
X-Google-Smtp-Source: AGHT+IGMtZRVoVgOFxujexGkt53o7+nugoNMnbm+d0TiNNIY8bAWDNjgmfAIcrhMcgAkbsng8mR3ZA==
X-Received: by 2002:a05:6a20:9f0a:b0:1f5:56fe:b437 with SMTP id
 adf61e73a8af0-1fbed31338dmr303264637.32.1742333537084; 
 Tue, 18 Mar 2025 14:32:17 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 09/42] include/exec: Inline *_data memory operations
Date: Tue, 18 Mar 2025 14:31:34 -0700
Message-ID: <20250318213209.2579218-10-richard.henderson@linaro.org>
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
the *_data_ra api with ra == 0.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 123 ++++++++++++++++++++++++++++++------
 accel/tcg/ldst_common.c.inc |  89 --------------------------
 2 files changed, 104 insertions(+), 108 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a2a90c7554..d084da0b5f 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -74,25 +74,6 @@
 #include "user/guest-host.h"
 #endif /* CONFIG_USER_ONLY */
 
-uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
-int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr ptr);
-int cpu_ldsw_be_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr ptr);
-uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr ptr);
-int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
-uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
-
-void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stq_be_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
-void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
-
 static inline uint32_t
 cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
 {
@@ -342,6 +323,110 @@ cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
     cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
+/*--------------------------*/
+
+static inline uint32_t
+cpu_ldub_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldub_data_ra(env, addr, 0);
+}
+
+static inline int
+cpu_ldsb_data(CPUArchState *env, abi_ptr addr)
+{
+    return (int8_t)cpu_ldub_data(env, addr);
+}
+
+static inline uint32_t
+cpu_lduw_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_lduw_be_data_ra(env, addr, 0);
+}
+
+static inline int
+cpu_ldsw_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return (int16_t)cpu_lduw_be_data(env, addr);
+}
+
+static inline uint32_t
+cpu_ldl_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldl_be_data_ra(env, addr, 0);
+}
+
+static inline uint64_t
+cpu_ldq_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldq_be_data_ra(env, addr, 0);
+}
+
+static inline uint32_t
+cpu_lduw_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_lduw_le_data_ra(env, addr, 0);
+}
+
+static inline int
+cpu_ldsw_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return (int16_t)cpu_lduw_le_data(env, addr);
+}
+
+static inline uint32_t
+cpu_ldl_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldl_le_data_ra(env, addr, 0);
+}
+
+static inline uint64_t
+cpu_ldq_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldq_le_data_ra(env, addr, 0);
+}
+
+static inline void
+cpu_stb_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stb_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stw_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stw_be_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stl_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stl_be_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stq_be_data(CPUArchState *env, abi_ptr addr, uint64_t val)
+{
+    cpu_stq_be_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stw_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stw_le_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stl_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stl_le_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
+{
+    cpu_stq_le_data_ra(env, addr, val, 0);
+}
+
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 2f203290db..9791a4e9ef 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -243,92 +243,3 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
     do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, int128_getlo(val), int128_gethi(val), oi);
 }
-
-/*
- * Wrappers of the above
- */
-
-uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldub_data_ra(env, addr, 0);
-}
-
-int cpu_ldsb_data(CPUArchState *env, abi_ptr addr)
-{
-    return (int8_t)cpu_ldub_data(env, addr);
-}
-
-uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_lduw_be_data_ra(env, addr, 0);
-}
-
-int cpu_ldsw_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return (int16_t)cpu_lduw_be_data(env, addr);
-}
-
-uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldl_be_data_ra(env, addr, 0);
-}
-
-uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldq_be_data_ra(env, addr, 0);
-}
-
-uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_lduw_le_data_ra(env, addr, 0);
-}
-
-int cpu_ldsw_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return (int16_t)cpu_lduw_le_data(env, addr);
-}
-
-uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldl_le_data_ra(env, addr, 0);
-}
-
-uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldq_le_data_ra(env, addr, 0);
-}
-
-void cpu_stb_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stb_data_ra(env, addr, val, 0);
-}
-
-void cpu_stw_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stw_be_data_ra(env, addr, val, 0);
-}
-
-void cpu_stl_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stl_be_data_ra(env, addr, val, 0);
-}
-
-void cpu_stq_be_data(CPUArchState *env, abi_ptr addr, uint64_t val)
-{
-    cpu_stq_be_data_ra(env, addr, val, 0);
-}
-
-void cpu_stw_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stw_le_data_ra(env, addr, val, 0);
-}
-
-void cpu_stl_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stl_le_data_ra(env, addr, val, 0);
-}
-
-void cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
-{
-    cpu_stq_le_data_ra(env, addr, val, 0);
-}
-- 
2.43.0


