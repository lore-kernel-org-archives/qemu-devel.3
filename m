Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B09C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JJ1-0002tv-5e; Tue, 22 Apr 2025 15:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIV-0002W0-6a
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0006DA-7t
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:46 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2240b4de12bso83019075ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350119; x=1745954919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VfuDyBOkc/7EHQm2vvPTUefKvEeqjpVe/tI2ANIcRc=;
 b=F39T21ZBjwq3sLIacHgZBQlA0Bap6WYoKwIHGv2BcHhgcDi3tyh9n3GKsBToCYBPr0
 zehhf86jeW4I2DVRUR4WonB8WZfVsZUXqt6vH7iNevVAoCyWsDxMdSDinrwLLZlLC596
 dcxjRGwee6AmCiqmpqLHSi8kZaYwiR96+RTbo/KuL3sPaTNZTD1OBEnS5N78h8GRMaxV
 wJO64ICkaCmMnhC5Z96UQJR/TN0NqhByMibWugcxbRJZvj9DXzmGqN3LlobyzpntVmRZ
 HH4Q66HXxyWyCljr5X/4cpE8NcghsDZP0GO/OO4fkWutbbxgGNbM/9jjxphrH1x+Fbim
 /9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350119; x=1745954919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VfuDyBOkc/7EHQm2vvPTUefKvEeqjpVe/tI2ANIcRc=;
 b=GsBr74SR0ti0vFXBpuELYRuTziuvyL95gOE5nJRiiuFsIUtdA1beFn5GtzdJNHIfn0
 6pXu20r+z/4+C+hRkRburszft0TBftdzrUrzBsRdptAb2OSrgF9wOxQJL0338j2WvjDg
 +T9FYYRhT0i6BET1wp4hpegvquysvT0bwlUtgjAULitE8ipQjxPi6am+jnHMIvV+AmNE
 qS1vGaB33vXKNP4mP9hp8Di4mw1FyKK4xsx98lqpyCXzhx2ABg8yTcQrjVUSNuc6rqGp
 pUY6btGigsb0XMxURDzdvAGqBVU3i4nx//Onn4PpSAvRj2zgoaSIlK+Gx9qtoZlni8fB
 BWmg==
X-Gm-Message-State: AOJu0YxV8Z06nLWBH06Z3Wvee53ITaKwh6iDmaRVvf4SK/BMdFi6ncyD
 qz+kUWtMPznzxiMwk5llGhhQMxbMn6qhSSuQxafFzBUz869ssgLJPOtN9o7XY+RwOc7tjSJ6jLG
 C
X-Gm-Gg: ASbGncvgOYzoXYz6xOo+pveQGZ/xu1McR2JkvKe66875BhlvAQlYchcDdbNKqpmupBD
 SU83DYOQHzu3dAaomDnHGxRfUN4HxOdxd+pDQvDv07W/wJ8trEZCFeSsfpHfvgzO/5BKS+iHUJh
 nP1+hHeIOWP0nIxa/vof039JIs6As6gW1D67ZTB/Ck6K/xTitgT0iy2AEqYOqedLOHEobLRXMKY
 P1mowzRXTHORNM2HwEPCLsmlsMFEpLSlt0Wf7pBRivyvFYnZhlK2RetXom/5XVhSz2U6sId+Ft9
 3O7GZLEvjTONj1zzCtnHg394RFWfLfk2dG8MzT0+q3tui3PXV10Bm0VHTm0m9koSnb0iZR57iMf
 vFTEtp6J4KA==
X-Google-Smtp-Source: AGHT+IGyF414h3eDTtB1RQqm5DXsEGEL56AEmDbopIY/qfgbn4zYr1TuBD6N0qtphY47j9qabsndgg==
X-Received: by 2002:a17:902:db0f:b0:215:7421:262 with SMTP id
 d9443c01a7336-22c5357f020mr267068115ad.12.1745350118868; 
 Tue, 22 Apr 2025 12:28:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 028/147] include/exec: Inline *_code memory operations
Date: Tue, 22 Apr 2025 12:26:17 -0700
Message-ID: <20250422192819.302784-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index 0054508eda..77dc5ac61c 100644
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


