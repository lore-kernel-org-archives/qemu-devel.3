Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0AC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7knn-0006ET-RB; Wed, 23 Apr 2025 20:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmu-0005Or-Br
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kms-0004Ml-C1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso385227b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455797; x=1746060597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VfuDyBOkc/7EHQm2vvPTUefKvEeqjpVe/tI2ANIcRc=;
 b=N/2zq7aV8tIAFvxXd5X9WwtO+3Nyz4Omu1kDQ/GGcv36AN/TSuP9Zj7jnlSYA6C2d3
 2NXI2LgmW0zqYBkqwCb81u4zGiUKLr+ic9YXzA0WHXAYs5IAMQJzyL/pQauTk27vaVUR
 bpxbDpnt/mhJ4zOOLzzGvLIwmWfHIvwqMUygwSL3siEWQ7vSM7dN7Nz+Pr7SoqXlXoH2
 GrAHG0MLe44UKorWd1xxYC6nmraAcqNd2XdEmgGSqlUSHcqbKuXpbitv0GwSAEqr+ogS
 7eH/E/1G7sbYU2l2zKZ9ACXc5XtHQjpIETElTm11gas7NyrLA4v3te0KGKlvHucLvGBB
 Krhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455797; x=1746060597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VfuDyBOkc/7EHQm2vvPTUefKvEeqjpVe/tI2ANIcRc=;
 b=oFo5RqUqNhlx5bVFMIJTq/EJwLttqAXvYStIZetaSi3bgpvoTs5u/sC7EkFCLUigH1
 4AMWln4YmphhjzjZwPEqzk+exkn/h7JE7Q9NSErZpSKnlJaeH5/9nY9Knsef2Iuy38AR
 l4SEj8VC6jPHdJghBvTdB6AaaiYEAFFHmI9HBEG2lbmETL6oMQrdrCc295dUNx6TzPIs
 MjEXpdVaDGZ9qq6v1kYdU9sVZJPUXwl0697nx85SK9Yabdql3etkLb7sa7zBEvQNJNJ9
 zeRWur0+vLFpxzCV8ba1QDYLZFxJ9KYMmdjLd5voxDz9w4/7GJDtRTNUpB+Makc7XFTH
 HN8Q==
X-Gm-Message-State: AOJu0YzWVwswM8BVJhlSeev9TKxPxdQXRDARU2yV4RvJHLI+mDvCQBMR
 86PBEpc9tINOYNNZ33HGLX1apzFV6VxGQYlpyafO5zuQ+cpGQhCfZHR2pgxR2txn+OHQdDCzDT7
 z
X-Gm-Gg: ASbGncty/iHYrWS8RGq3qcTBcdoXlO+B74AcLpsd4anVnxCtU1QYyc4yNlQma+7F0n8
 8Il5yh7OjVOyfozWVPZCV4HpWt4IvE6Yxv+flSMlJNNA4bYK5vTO89P8LCHMhHVpkuq0zy8U9DU
 gTWVfeq81aF4TcdtaeUpdWB/qbR/uRbISXf+3b4rs9S+kClcseWICtacqG4H9qOzf6r/zb5mWor
 GoUJgp4JZyNLEwPV3Ipd0ho/54fDouFe59cy3D2oZ+87mkwSdBg58jD2SPrzEE0/UMziqU1fsjU
 1ywIKZFYeVjeYFxLg+mAmtjvrfNEHkIZ9/lQG4n07XdO8y0zsB+6QtaN24vW9qWPAcy8EJlJpTg
 =
X-Google-Smtp-Source: AGHT+IFzGLThPCFqSWJTWRXuJQK+YZabpOe8R3W+fzUkfgIU1g0euhiAQErsyQCgF+iZJeIuP81zCQ==
X-Received: by 2002:a05:6a20:394d:b0:1f5:8f65:a6f5 with SMTP id
 adf61e73a8af0-20444f22e85mr860203637.30.1745455796800; 
 Wed, 23 Apr 2025 17:49:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 028/148] include/exec: Inline *_code memory operations
Date: Wed, 23 Apr 2025 17:47:33 -0700
Message-ID: <20250424004934.598783-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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


