Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633A5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYG-0001Q5-4V; Tue, 18 Mar 2025 17:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXu-0001FQ-1x
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXr-0000kQ-EG
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2260c91576aso49622005ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333538; x=1742938338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JU8wqJZNcN7ysbw8CBh8AnFHtEMmgB8RIMM8bAnUnEQ=;
 b=Bj3fnud7yzZ9F+6Qdycvg2xnbzeg8rXCkYQHBbp4EGZxGGxHVQobZyaSq00aIdOEse
 K1GSTC1t6xf96wJzuC/M2XENHe//9AO2+wLucAnx8rPacH4bTrsVRJYhI26zefIMOm7o
 xOin25jANW9Dz1DaWtvON3J0jzPbDxDunQhdl8zRjhBGRt7cBxFuKYD/VeOySG6FrMCK
 ubU6ymdNM1eMNy3BSkgtUZMQnxW/eF35TBsBVJChelh++gmMboyx+OztNK4UmaRX+llO
 oNXKYaMcChWm8WYRbPEqq89YiFhYck43JS49VyCTfgVLGDYhYBqWcsJ0sIJspu3UnZ1z
 0Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333538; x=1742938338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JU8wqJZNcN7ysbw8CBh8AnFHtEMmgB8RIMM8bAnUnEQ=;
 b=jStKBVjViPetr7TUphnfPeWMpEM1rzaMuOiPDR+Tc3UTfiwzOZBLYiDUAqmO9a0+0r
 gFeDwd4kgc5c5WQIvLmgYw7VhILyVOz3LZcoKjCN87oaiiQJgxWzxOz1NYI0JRymaDz/
 CanA4lHwgcVl5KVQZyqWrBJCCuh47a05R6UcjiGiL6PGJaxITJw6I9zBY1eOuS1jmMRB
 ljcWSpOY0Mp0LOFciEBJCOVH4TK7co6VKXxOVmZ0cE/mlLGnU3czyAHK0H0VdBWQlloh
 84iUlPjsMgMpR4OdrVL/9jojzk61eOH5g3USEr0aaikRpPZQyF47B+rmfoCqJQP4WPS6
 F5bw==
X-Gm-Message-State: AOJu0YxGnffN2oHq73w2bAe60MawhexwGFhCsxuEKxEi22QU4CEQnavI
 4r6a3fmCKpXTpWO3uYuvpPTavViIoMUQ+nl4904ecDiaim84hUEPALUgqkjjfGKePJwfH8zKxdc
 4
X-Gm-Gg: ASbGncvstdPVTCyLdyQ4eEGiJCI1EDgofbgAsb1kCoNYzXtxIDQqYcUp0WWGeb0a8DP
 37nLSmGdDPbatuk1SVPWbn9HJWoSNhLURbNP6n1bacvBUuw8MEx1u6nEXOkReSZkfakA0AO8/rV
 BGADV+lNN7EEUxY/ezi4sbGAWaaMvcCdk3lcGZ/MTVlnLzFMmcX93VqM+JPosoTS903bGkbxLq7
 ePCArTAjfv9y4OsqlxO/UivZgq341/+Y7CP7037rNDBY3kgMAzlnnYkk3b8n4SPwVH5u+L/nsOm
 sxdDw03pF8zX8TlYJWX3Y6GlqaKDajY2VjxRe/gHDYZe7rxrNhL+WKq2Eyf1jMlR4SjVIWyZF5B
 I
X-Google-Smtp-Source: AGHT+IG/V4TNaw9AVPo4+MblDce2L5/6JcQ98eeo7jyZAMPvgUgbuHjMPc+yQhdSBdGrlOWRs19iEg==
X-Received: by 2002:a05:6a20:1590:b0:1f1:432:f4a3 with SMTP id
 adf61e73a8af0-1fbebc870a8mr274860637.23.1742333537669; 
 Tue, 18 Mar 2025 14:32:17 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 10/42] include/exec: Inline *_code memory operations
Date: Tue, 18 Mar 2025 14:31:35 -0700
Message-ID: <20250318213209.2579218-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
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

These need to be per-target for 'abi_ptr' and endianness.
These expand inline to the *_mmu api with a lookup of the
target's cpu_mmu_index() and ra == 0.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 31 +++++++++++++++++++++++++++----
 accel/tcg/cputlb.c      | 28 ----------------------------
 accel/tcg/user-exec.c   | 40 ----------------------------------------
 3 files changed, 27 insertions(+), 72 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index d084da0b5f..82e67eff68 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -473,10 +473,33 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
 
-uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
-uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
-uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
-uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
+static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
+    return cpu_ldb_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
+    return cpu_ldw_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
+    return cpu_ldq_code_mmu(env, addr, oi, 0);
+}
 
 /**
  * tlb_vaddr_to_host:
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b03998f926..2817c9dbdd 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2897,34 +2897,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
 
 /* Code access functions.  */
 
-uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
-    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
-uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
-    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
-uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
-    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
-uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
-    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t retaddr)
 {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index dec17435c5..ebc7c3ecf5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1214,46 +1214,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     clear_helper_retaddr();
 }
 
-uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint32_t ret;
-
-    set_helper_retaddr(1);
-    ret = ldub_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
-uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint32_t ret;
-
-    set_helper_retaddr(1);
-    ret = lduw_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
-uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint32_t ret;
-
-    set_helper_retaddr(1);
-    ret = ldl_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
-uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint64_t ret;
-
-    set_helper_retaddr(1);
-    ret = ldq_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra)
 {
-- 
2.43.0


