Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B9CCFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB7v-0004Wq-Ux; Thu, 20 Nov 2025 15:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB7u-0004Wc-0j
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB7q-0001P8-QM
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so10543435e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763669968; x=1764274768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EctDLYXHneCSbnit9AgBWHWi2e7ESBxD60JGtambQRU=;
 b=iynHmzRRie4uWeZGOMDf9W4kQgOU8zuojWgyZosA9JbhLBz9luIKMRlJZqjg4ssQQ4
 SlMhAuKMfnYBQoDFmMn3S72VPLvI2gE57CFRb1f5c3JSHyUAHtFutq1SXUU+nF412dmB
 wxMwJHCJzXm8Kv0bbbX2LVk57KBhIHPUoNSOSjrPwWBuVL9nJjdPcuCbpo6+yqFfh1wR
 v9H1LqDpuG3XMjCARshI9IYnAcUfLfid4AQjbKP9G7LDO2q/bG5Js6mXan0NtthSxasj
 tikLlDBCo71c1mOn8vyQvPV4akLMbQ2HBY3ri768zgS0GrCBhMSILRYIqlffF0cO0UcW
 mqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763669968; x=1764274768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EctDLYXHneCSbnit9AgBWHWi2e7ESBxD60JGtambQRU=;
 b=LhGJGIpPXs/TmWaCod5QhtbdBNssL3yy6h0H1SYWClA4FxYL3zoNLlsMfb48eGKrZ6
 wKXOET66YFBH/X1H/ID6U+o9EzVXSXDEoDZHVZlLTvkfw2k9PJyZn39A+vO5lRmqMeb0
 6q7s0pzR409TVoRr4FEAoB9EOVBzsAe/EDm+Wquhf+SfJv8MIh1knj4aaVGhSicbL+j+
 rkbNY3D/p2MspdzETcC5aEwPxy93+oDWLq+VkAmyW/3bVKMbv8E5Nut2UbiehZFXVg02
 606Bo5SNhqzpCMdt55Hyz96GJ29vAtCuZ9SI/OqLbgOO1fQdp7jnDfXLB4R4YRxHUPg1
 IDUw==
X-Gm-Message-State: AOJu0Yy2wx5BpIjn5RWCoosg5Gf6NGggF0pfumITtcUTJHoZqrwyuabi
 j/fHlqr+zwd3Z704uGhAZ1F1AUdnOYEEF3kvJN8oDQloA1KX1JEJhiDmwCRywKZ4xpmXLB5IdwT
 BYb766n2DNA==
X-Gm-Gg: ASbGncsvHFcoVxzcet8Mi1ONTlRFsiUhw2bLr3yILyoTzOTU3+qI/rHJWmI3HCEwToQ
 tZFiJ2JMNyUwi9KcdHwGvLAYV1v6XqL4U2LH25PduK6adfIUe7lry4DSQbR+Q73+jccj1sO0Naw
 dcWtj3JXCLxulbNq7yi0HlAD5kd4lFaYxdpJRkUeZPLcaxmxLHWHHIr//4rBrDwxwgvs28GxEaz
 8O5mq4XCKQWXHnbhSJ3BuEQzd/PWMX10B/EJR7rN6t3aWrjpvF44yP0i0i7p3Qpn7uu4V7hlgMh
 +zv+rwe2nILnhvLaPWhca7EotncMBI/YNCN6SShy+O7cGZSHSRjKyPMRacESSjsjLLlpMGRIXgM
 GRj7Lv5tpDJcj43TqBmZ8+TIxoZBxNNTOWVtZheGrXVj1xETFZfnYhu2Ca3blArKoQZHBs6JG3O
 e/rySV5HMkNRRqWpFzu0s3ql8j477hy2ajdOjsmszAsKWDYUVQqH6q5tmMbxgd
X-Google-Smtp-Source: AGHT+IFCk+grptEwh4dTQRZIeo3tfRmz5VEVnmJ9vNYxYC9iYCq8g3qf6BPneUDITJxbyg76Pa4zsg==
X-Received: by 2002:a05:600c:3553:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-477c0174840mr106815e9.6.1763669968335; 
 Thu, 20 Nov 2025 12:19:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf35f976sm6346195e9.4.2025.11.20.12.19.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:19:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 1/8] accel/tcg: Add endianness variants of
 cpu_ld{uw, l, q}_code()
Date: Thu, 20 Nov 2025 21:19:12 +0100
Message-ID: <20251120201919.8460-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Allow target with fixed-endianness to not use the MO_TE definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 43 +++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..e4ec4e7d367 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -481,25 +481,56 @@ static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
     return cpu_ldb_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
+static inline uint32_t cpu_lduw_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUW, cpu_mmu_index(cs, true));
     return cpu_ldw_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
+static inline uint32_t cpu_ldl_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
     return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
+static inline uint64_t cpu_ldq_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
+static inline uint32_t cpu_lduw_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUW, cpu_mmu_index(cs, true));
+    return cpu_ldw_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint32_t cpu_ldl_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint64_t cpu_ldq_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUQ, cpu_mmu_index(cs, true));
+    return cpu_ldq_code_mmu(env, addr, oi, 0);
+}
+
+#if TARGET_BIG_ENDIAN
+# define cpu_lduw_code        cpu_lduw_be_code
+# define cpu_ldl_code         cpu_ldl_be_code
+# define cpu_ldq_code         cpu_ldq_be_code
+#else
+# define cpu_lduw_code        cpu_lduw_le_code
+# define cpu_ldl_code         cpu_ldl_le_code
+# define cpu_ldq_code         cpu_ldq_le_code
+#endif
+
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.51.0


