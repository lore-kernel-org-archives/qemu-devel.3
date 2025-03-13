Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4663BC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZVx-0004ae-P1; Wed, 12 Mar 2025 23:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVu-0004YV-3S
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:42 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVn-0007j7-NA
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2239aa5da08so9094235ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837532; x=1742442332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p041g2UoyKwgtmRz0D8khAwbcLhJOr7T2aKI8/Q8EC0=;
 b=gGnKWAs7QxCiiiuRBL+nAsnKAQ8cp3m6Wp5dXhO9aUkZTbePNCtJZpYJov3uHXpZ/t
 RQqI4JNpO4vAHr32Vdupx+vx2p6qI/8EAtFWyGq583FZznuv/4T6D+BG6n/w6//d9bvd
 ln41qSKZauOgR8Lceo0PSmJkJ5QOVnennHQyxrf1oEAe/wW3/oZ01E1IlSC7uzJzP+hs
 BKt2Ybt5x6R3MYmBFcu8w7bYk6uWVis9RIYagMTC+v/K8rZIGFNyxGxByyLu4A2NS3I9
 MAtPapUzT7fnuKmThfAbgh9ptkW86cZNXywvvLdJD7dIXkkYH2P+Og8et9eoCyu3L5X/
 6+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837532; x=1742442332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p041g2UoyKwgtmRz0D8khAwbcLhJOr7T2aKI8/Q8EC0=;
 b=LeDAoqPE2ctLeFsenUQT9PPjl8X9M1yjFdwRd3mKkTCgHzcP5iiXtA4huvgNJk7qMo
 ZAdmbuK01rAuEgi5ZbTfiunX2rtGPMYLT7Bdvlw6m0SNkYHfCLkKxOx6klTwDm+w5hY8
 HDFjkbhGt6IQb7IHUNMM2wmAdqlYKz0na7jgMseUpsvcNefgM9DoJkPfB5+5T1ORux28
 Ho2b7XrtEUz0wZa5zWP8mxxVaYMKMW9LZX2FeojHaT6S+5OZppoRdZx2XrL52L7Sh4BX
 S93Drc7qGRY5mlrnF9cE4HZMMY6V9YABeq0OHgccuNS0aqMie4xPdBCCtM6vAu0a3Ffq
 7W+Q==
X-Gm-Message-State: AOJu0YyOENpGKHzZbaFJXLat17Wz3NuTMtOI5eUztaONEheNNVG7yxIT
 SpoDVnDuSZgC/mtkFPqfYQC364NWaMAT721klpTYBGu5HfLmmqQMswrnW3KBSifgVJPMaiv3u1C
 S
X-Gm-Gg: ASbGnctMkW39g3ncNKiOnW6zjRDKQtoacj2ydnEtPbvPNfL2EDGtLVvwOo750iOVSTk
 IdT6UOyK1HMYxcunMhRUawFtTqngtWXp2BAZtEHcY3Q2eBfR4IcZ60aXL4LC2LNZQLK91LAKDhb
 CrEeaboomb4CK5WAkbqmvcovp+4I3xYrGouo3wSh5JUVlE7NERS0ZykJuHyDIUC/Ov9y7pOIoUW
 XI6t1X7rA4+D1KlxgRzGpidC3Br0y9mFx+BzABexWzCxyMzv/VDd1prGyiZrzgDPyUv/1i0tQRo
 a7/HhY+x6RuZFyrnI4KvCX+Op7XVRFbm++7UnA0PErPBgdYwt5h1w8FuNsHAt6WE82F/4pTTqUi
 d
X-Google-Smtp-Source: AGHT+IHvoAbpGY/BHE4VxM0JWlsXqQl2WlFSQ8oaUTdk9Xpgh39Gcm9fhjr/gAIB6w5QpDcTAeTSUw==
X-Received: by 2002:a05:6a00:c95:b0:725:96f2:9e63 with SMTP id
 d2e1a72fcca58-736aab16545mr42138306b3a.24.1741837531818; 
 Wed, 12 Mar 2025 20:45:31 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 07/37] include/exec: Inline *_data memory operations
Date: Wed, 12 Mar 2025 20:44:47 -0700
Message-ID: <20250313034524.3069690-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These expand inline to the *_data_ra api with ra == 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 123 ++++++++++++++++++++++++++++++------
 accel/tcg/ldst_common.c.inc |  89 --------------------------
 2 files changed, 104 insertions(+), 108 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 963c538176..70e98ebc52 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -73,25 +73,6 @@
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
@@ -341,6 +322,110 @@ cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
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


