Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76769C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JJa-0003WV-81; Tue, 22 Apr 2025 15:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIW-0002WE-Bc
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006D5-33
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af28bc68846so4772743a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350118; x=1745954918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kj/uYgShChkHdccTvFGCpCr1FhgqEsUyeN3aymTPxRo=;
 b=al0lt5ofSHZwHp9fNK7ZoOIwK5I2eDFcGYEW//WNb+1BVW5NeJ9/lqXyjlMpQCJHQC
 CxGzxEENfUgcAgyxoWe+Rcro8R3ycC4vCiVXm5IN9mYBNPjvaAaNXWVGDXGYDToko14z
 PHC+kc36NIbL/5JF4CcFQjwAdQanYre5Atz4pkFINLkQbIDVdJSo93JQwcoeVaHJs9DO
 VSwzrtG2ZH0frUCqcZL6WLSfMmfaVBiAzm37ZaHG7QizR1yuE5VjkiqC3c3FXIDsiVdu
 rngIE9tpNypwlkTdPvWVJQMBic0YZmu6Eu/X8PO22o4CiNEWvwzABKlSlIQThZfrwv44
 ATWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350118; x=1745954918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kj/uYgShChkHdccTvFGCpCr1FhgqEsUyeN3aymTPxRo=;
 b=t9iBj0XjC/6M9ldos+VYIVkZ992IOyu/hwH1UN4kpHp9SSk7Cb976PV2aTb6I8d5Co
 gNuYVX6xWe4zn+KsYcM9OnNHuHM37HMA6us5HtfwUJLjYpYXdpn899Rvu9/OwVfryZef
 SBACT7UsGQ3vCbAX75O20mikFhVBWMeLG2p+32eJNQ0aVC/2gYxkh/6U7wdoo0xEQXYh
 Dyf+iCEirzFQJLkmCPL6OyxTg/EocPVRhin9i/Hnt9sKpBZAvQC83waQMu7WCFwDfCXm
 le5yXJt6OQWHH8qUIsBZUnlh0gBD6dAaf89OvuqUkXbAtH83FOyDsGn15tPmz56sX94X
 N3sA==
X-Gm-Message-State: AOJu0YwCoapuZ4MmrB/L429zwehKS4X9e7H8PippIC48l9GvXM4m3k3c
 RDqsTEAJhFLWttWXOucIpR62x3n7/Bz0jJgBBcdQUy2PnIySgHGzUxRSVMsAeRfevyDxquJ75HU
 q
X-Gm-Gg: ASbGnctERG0RcdsIpbXO4RnfH0v8+J0SwVU7niL14G51XmgAQyVDIY71Kml1mjmuHKi
 wtEGOoeu6oC6fDlsAsMvg9iEoqqyLpXqsYV6t8Or1qdr+FRqQyUs03HNXGnmlZU2uiwNUwHVmhk
 4JeCo9jULJptxi4cluqllo5AYJhYLrpvcggF8Qk3QRXq96OlKg5NMCzUneRJ1slO6VU8T3pNGVu
 55aWB9aZ09sL28ggDr0ak9KEB4N39QqNy9K9dRfLtPfqe4sMDoEchaLrKkm+xOpIabOKge7nwFF
 JRGLG7r0BhgfLcB2jEL7lSen8PsWLtT8bLvwfLNM9us9wqtO1uSqBAwgtX5WjuD5M33OY3OgUSs
 =
X-Google-Smtp-Source: AGHT+IHe+ugXSFANmzKiX4YCJRbzr3VWWVjxda0zigfHlLWfgob/U4m6gLw3H7x+cYNKmAzBoSwgjA==
X-Received: by 2002:a17:90b:51c2:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-3087bb53218mr25611166a91.13.1745350118256; 
 Tue, 22 Apr 2025 12:28:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 027/147] include/exec: Inline *_data memory operations
Date: Tue, 22 Apr 2025 12:26:16 -0700
Message-ID: <20250422192819.302784-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
index 2eda652a38..0054508eda 100644
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


