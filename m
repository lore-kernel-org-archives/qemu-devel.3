Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55300C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgOx-0008Q0-Qa; Sun, 04 May 2025 16:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOm-0008L6-NQ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOk-0006vv-GB
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:20 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223fd89d036so41535795ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392237; x=1746997037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmHqHslUT/R30MADH7naEbPJDNCBfrJgNIi18eIVP5E=;
 b=K5u+E651IscuzU6KpLuc0vkrzE1la7iVtoVZoQBUfq9WtxrlZRf0SQMUMIDY8qe00M
 tcU41jJ7LSCCw6oC/1M9anUhOJdwhR7q9jyPTHTIe2t6N1+lo9eNgfh1HuUU2E63nXLV
 1MrnuIf/8GtCZ1NhRfm81HXq2t0i/g15j7zU6e575x+Y1Wkubko1RZ1+n6iXEe/7nJHR
 690kPM5XNq6wPpKxYajxKt/IYn3ASsCk+IX/KN1wyFnuoHBTseFp+eHovFG51pyfpkFo
 08yIyLtUDKANw5gWM5x/KlFcV/aeNPfZp3Fdni20wHJE09yS8f+XH4gZdBg8TonDR9zq
 JMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392237; x=1746997037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmHqHslUT/R30MADH7naEbPJDNCBfrJgNIi18eIVP5E=;
 b=RAzvsYeA9JkrBhBzjNaHmL5EgcKS5gePb1BMovetzZ7KSgvOEMKDP6B7KN2knB2FeU
 8xCLh7QdSwwtgO3P2BzcCKcSZH4NKOAUUUEkxQ17Wb9V7MdbiP1uJ6Iwmp9F+zelyJno
 mFgnvKSqMCMAeL81fPkMWob/LIbZZBtcF0WYv9h4CKLkhRBfI8aO1bgmeGc/n/5U8JG1
 5O9hHY0kTMRKhZKR6e1UKVFrxlm4iDW3pWj+TCc4C9zgUwHSgDxyJMfaKtmb3TxTSma2
 EKkpYncdAxCQDUQflyRkHq0Vg4Jo0M9Wqr5lGulyvqpSsL+e814eIt+6kjLvvgBF7GEJ
 bNpg==
X-Gm-Message-State: AOJu0YybcIQJTmhwfa5TJBjnTz/KFefyHv+4RDp3ArTZCSFh6WsclEHa
 Rv9IQ3TDbIGkWC7yUWg6IRlYtopyo37dvEkbkn+F+GjH3i+nURCuZh69KYF/6tYbTRb8hCKrK+U
 Z
X-Gm-Gg: ASbGncsWV+kFM4No7tJhSfUbrFAKxtI5dCdi0xDmLK0Ak+wrxb21d9VGxX3XTzRzGBE
 nM5CRyUnUOnN9hMIQLLeBMRRZxrNDhB6svQy/kCsQJbhrY01FmWV3KRoaoE9nKv9NWJVRS9/OR0
 4dYvzRjt6ABA9ik+rpdQ/aS5tYklvhD+YLLDy/yQDPCukllkndbYOkhKf+mkEQykDjf3YJxwi9o
 yXsvA3cicCL8mD3cn0HpkWYECVJRm1bbbFMw9IZhRlpm5HrLkwpy1tCFi4i1CKyz6Hp39UZ0xio
 daSYDh/gaDXocl1HzMtwCU3Uoh/BqgEW9izFDPKW9JAVVfeL/VFNkUYLAOejLwBeqoGAeg/sg+I
 =
X-Google-Smtp-Source: AGHT+IH27hLykyp4LuHZrYogvlfS5BJJ7gfQyANfxmmdFMSl942rxAcxblpt6JTcQLbAYVeX8skPEw==
X-Received: by 2002:a17:903:1aab:b0:225:ac99:ae08 with SMTP id
 d9443c01a7336-22e1e8c1fc1mr67896135ad.5.1746392237069; 
 Sun, 04 May 2025 13:57:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 02/12] target: Use cpu_pointer_wrap_notreached for strict
 align targets
Date: Sun,  4 May 2025 13:57:03 -0700
Message-ID: <20250504205714.3432096-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Alpha, HPPA, and SH4 always use aligned addresses,
and therefore never produce accesses that cross pages.

Cc: Helge Deller <deller@gmx.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  5 +++++
 accel/tcg/cputlb.c          | 13 +++++++++++++
 target/alpha/cpu.c          |  1 +
 target/hppa/cpu.c           |  1 +
 target/sh4/cpu.c            |  1 +
 5 files changed, 21 insertions(+)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 83b2c2c864..4f3b4fd3bc 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -322,6 +322,11 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
  */
 int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 
+/*
+ * Common pointer_wrap implementations.
+ */
+vaddr cpu_pointer_wrap_notreached(CPUState *, int, vaddr, vaddr);
+
 #endif
 
 #endif /* TCG_CPU_OPS_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c394293d33..75cd875948 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2932,3 +2932,16 @@ uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
 {
     return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
+
+/*
+ * Common pointer_wrap implementations.
+ */
+
+/*
+ * To be used for strict alignment targets.
+ * Because no accesses are unaligned, no accesses wrap either.
+ */
+vaddr cpu_pointer_wrap_notreached(CPUState *cs, int idx, vaddr res, vaddr base)
+{
+    g_assert_not_reached();
+}
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 890b84c032..2082db45ea 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -261,6 +261,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .record_sigbus = alpha_cpu_record_sigbus,
 #else
     .tlb_fill = alpha_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
     .cpu_exec_halt = alpha_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6465181543..24777727e6 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -269,6 +269,7 @@ static const TCGCPUOps hppa_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
+    .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .cpu_exec_halt = hppa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b35f18e250..4f561e8c91 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -296,6 +296,7 @@ static const TCGCPUOps superh_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
     .cpu_exec_halt = superh_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


