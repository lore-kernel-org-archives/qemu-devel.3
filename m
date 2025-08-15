Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492E5CA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 12:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umtWm-00015G-Bc; Fri, 15 Aug 2025 08:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWY-00014P-Fu
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:11 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWW-0007Xq-Fy
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2eb6ce24so1957267b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755260827; x=1755865627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=87lrvQbpY4bv9joZLCnkKnHCeKplsEyfo+kz4OC+lZ8=;
 b=KxzcjYMKlk31kzzjFnPnzp0mp0HbLKF1aUSO5wlAXncIthGH6+rBtmjfkTQm2GRTG8
 UTnfb3GSLAUoJjuBb06g3F36KpOvlAIoUWRpQOd09mHzSc4/rNmuIMHoHqjqiWViX5h3
 O5cXSS1l6h5OOKZhzcwzVuToWtpK81SJ4kKjC80CvDtjOwn7/hu7aphAMuenHPzFSZt8
 IDVaZoR9QX9m3KRAH/5qjl59qvWCmc+dv8i7jZbYzHWlkXCldBAynbBUQ40zzV/tN83+
 i3BItG3lSrEQOEarq6v3Q7PbxSjkQY62VJVh4wCKt/L+zocAIAuhVasV6dFwROY0+GbF
 5icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755260827; x=1755865627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87lrvQbpY4bv9joZLCnkKnHCeKplsEyfo+kz4OC+lZ8=;
 b=I2WxXE+H9C8Kgh1EMgkLZdK5GeHLpxzcWw2DU07Lj0T9WmnUoP2ZaI7jx7l3fJwUy/
 5xz6v9b14HfjNPt65cAQZXzIrfUA2is7/WONpSKgJsPHH5dGAUaaRtqyL9VG2zb1C4FG
 ES0rfv2jRL0r+vr5Mfo+3YN9MPU9rnmi4CPPcJ+fl2AdQpRRil7bGX5iC9tdNxgWpaoA
 7DyYFn2wJEY/dLkz5djoip5SnPQEG9QvOLP9Na6XabfKNDvanNNhXPQeqiCEQEWrLyrb
 oUKTHmD8vx1/3JT42gxnQq6LQtIv8kD+Vn8bhlls1fwv3DpkrtJcmlY3y7eQbCFNMm0N
 2LmQ==
X-Gm-Message-State: AOJu0YymrMQQA5JuYdlUECQOos4Q4E/0HLaIu9ke6f5UUMh/EKWQAt6J
 Ie6zVZIq0vLYYMmj567uWs8g4Dkgh8ESrDR+ExuarJfJPYWgzF3FP8Fi0C+rx17dloTHQzAtVcO
 WOQawfjQ=
X-Gm-Gg: ASbGncs0BOorvMXkBMZM3AG/7wPvJRXNDEasouS3AP5RD9mOt+7nYpiTXnVhUK52s9g
 /p5mp4JSHgz3ZIJe8Yiuz9+YVe4cVMrJkABtpiG1Rm8qk22lm1jdF8UrMHlIjQpQxZGNJ/2q832
 CaeWirzvCsO4H8NsLCRFgJOC4/aL8wFvIHwHkz2myokDiP0S0HQ8AIRfULc4xNkmJJ6pJbE6ChQ
 M7N/L6Z582HTJY77ygtmF3i69EopbHHeoiROoRcqkU9fWINsK03IGS0fefPpEUW4Z2eAix8f5k/
 SkLUWeTx4iOFqLJmtxQb5jyKm0W1q9SCbLQmwKRocMtx1iDxqvxj9srKGxHo9k+jvMKbZvs5phZ
 4wkZEjJYDBLV2mXVU5jjEbPRDroMUXeXYvEbd+4/hnKh/4y0=
X-Google-Smtp-Source: AGHT+IFkfZarQyGhpWT4nrnG16vb6Yh04P01ib4eJV6rygPD+PKzQJXerGeZqShosxw9AOak8MGjeA==
X-Received: by 2002:a05:6a00:3997:b0:76b:f1c0:224b with SMTP id
 d2e1a72fcca58-76e4485ae74mr2436132b3a.23.1755260827013; 
 Fri, 15 Aug 2025 05:27:07 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45292c86sm1053475b3a.48.2025.08.15.05.27.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 05:27:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] accel/tcg: Add cpu_atomic_*_mmu for 16-byte xchg,
 fetch_and, fetch_or
Date: Fri, 15 Aug 2025 22:26:49 +1000
Message-ID: <20250815122653.701782-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815122653.701782-1-richard.henderson@linaro.org>
References: <20250815122653.701782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h         | 80 +++++++++++++++++++++++++++--
 include/accel/tcg/cpu-ldst-common.h | 13 +++--
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 08a475c10c..ae5203b439 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -100,7 +100,6 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
     return ret;
 }
 
-#if DATA_SIZE < 16
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
@@ -108,7 +107,11 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                                          DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
+#if DATA_SIZE == 16
+    ret = atomic16_xchg(haddr, val);
+#else
     ret = qatomic_xchg__nocheck(haddr, val);
+#endif
     ATOMIC_MMU_CLEANUP;
     atomic_trace_rmw_post(env, addr,
                           VALUE_LOW(ret),
@@ -119,6 +122,39 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
     return ret;
 }
 
+#if DATA_SIZE == 16
+ABI_TYPE ATOMIC_NAME(fetch_and)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                                MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_and(haddr, val);
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return ret;
+}
+
+ABI_TYPE ATOMIC_NAME(fetch_or)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                               MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_or(haddr, val);
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return ret;
+}
+#else
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
@@ -188,7 +224,7 @@ GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
 GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 
 #undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA SIZE < 16 */
+#endif /* DATA SIZE == 16 */
 
 #undef END
 
@@ -225,7 +261,6 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
     return BSWAP(ret);
 }
 
-#if DATA_SIZE < 16
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
@@ -233,7 +268,11 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                                          DATA_SIZE, retaddr);
     ABI_TYPE ret;
 
+#if DATA_SIZE == 16
+    ret = atomic16_xchg(haddr, BSWAP(val));
+#else
     ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
+#endif
     ATOMIC_MMU_CLEANUP;
     atomic_trace_rmw_post(env, addr,
                           VALUE_LOW(ret),
@@ -244,6 +283,39 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
     return BSWAP(ret);
 }
 
+#if DATA_SIZE == 16
+ABI_TYPE ATOMIC_NAME(fetch_and)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                                MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_and(haddr, BSWAP(val));
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return BSWAP(ret);
+}
+
+ABI_TYPE ATOMIC_NAME(fetch_or)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                               MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_or(haddr, BSWAP(val));
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return BSWAP(ret);
+}
+#else
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
@@ -317,7 +389,7 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef ADD
 
 #undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA_SIZE < 16 */
+#endif /* DATA_SIZE == 16 */
 
 #undef END
 #endif /* DATA_SIZE > 1 */
diff --git a/include/accel/tcg/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
index 8bf17c2fab..17a3250ded 100644
--- a/include/accel/tcg/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -100,9 +100,6 @@ GEN_ATOMIC_HELPER_ALL(umax_fetch)
 
 GEN_ATOMIC_HELPER_ALL(xchg)
 
-#undef GEN_ATOMIC_HELPER_ALL
-#undef GEN_ATOMIC_HELPER
-
 Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
@@ -110,6 +107,16 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
+GEN_ATOMIC_HELPER(xchg, Int128, o_le)
+GEN_ATOMIC_HELPER(xchg, Int128, o_be)
+GEN_ATOMIC_HELPER(fetch_and, Int128, o_le)
+GEN_ATOMIC_HELPER(fetch_and, Int128, o_be)
+GEN_ATOMIC_HELPER(fetch_or, Int128, o_le)
+GEN_ATOMIC_HELPER(fetch_or, Int128, o_be)
+
+#undef GEN_ATOMIC_HELPER_ALL
+#undef GEN_ATOMIC_HELPER
+
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra);
 uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
-- 
2.43.0


