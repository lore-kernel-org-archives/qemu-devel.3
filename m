Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8895FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKByU-0002rF-14; Wed, 28 May 2025 04:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvy-00080Q-2Q
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvq-0005H3-LM
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso44903745e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420077; x=1749024877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxuMsIzIEBcwEqybHWtHbk2A32P89CJB8Yk1LV8pWNM=;
 b=L46IYmd6ood/PHyZPBgeccjZSqytJgJbguXLYE3vvAdDhEad7wLGoEOdHAKsG5K6KM
 cv1mML63/xWqTE0Y7rbQ1TjRCFdGqRat/0MSK3EevjKKCjz+XUESXAxqVwHdmUib7yV4
 FFp+rrY4lx4XXdCfF3mlcC9Q6Ks5swfzybuvMef3hKnTsMVrzRatESCZ2YHoNBD0tw7x
 RkFEScUO4kXteS0GtOw1t+6yuDNBANAP7y5qDPjGHNhFOfOdRdnVT0AZn/g79k/EXob8
 ATHxDtMw1kAAWGXMGci/oGAVNtPcXA7OPa3mPYOua5Ex6/Z7AKskyoj4l0YT7fyr66G+
 3wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420077; x=1749024877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxuMsIzIEBcwEqybHWtHbk2A32P89CJB8Yk1LV8pWNM=;
 b=eoLERiigxgk6gBnSWockOncxo3sLG2eBr7HQFQs2l3A1tvNXI2JOBqz2L/DRFeDxGx
 Szw2h6zUCso6nqPmNAvIJiEquw7m5LHhylYI0bRM1EH//XwVQF5R/CHMcdCvWjHArQAm
 IvsLlCTxmIMchecHrzl+6YucOCI2QuvzrJ2ZcNUU1lfNLXt25K6AIg2fHZ77gSdJcl8Q
 hpbTc3dcvwY9nDmjejhYMG1UZ1hdQud5X50b8/EdUbgV88tKHtMwoORTCzzczFXYKt6j
 XgnTiGoXb49PdpcO0SnnZB5uADFTl16J2OPiShJJW44w44ZahvF75QArbJ7m5FiA/sm3
 IiIw==
X-Gm-Message-State: AOJu0YzJw/BRASWE+RSP+ty2sLtkIdmoU1PGPSdOn8U3QKkahiNQPPOs
 PbGAcpfHQoqquu6Nt4SPPkfiAEOTVS/ylymKOm1HSt6cHEYwRd/E/QW9I9EB5wk7BssHKYfhdL2
 E46wH5tI87g==
X-Gm-Gg: ASbGncsFJo+ufXS19pBNobI7NszKXRQA4TJ9DbhJs5+BeliSMXKvnJ4yvI4AbgmCDBr
 4ltp7SYwoLqRenldliF5E3N56Y79lzc57rdFE6xRemGK1Mi+nEqzgFFAJl1FwDVdYo15/Yf3wnF
 BwvfFUaKWyACtH6/uvHd0L2SaWQpvt0r8jTh3ME8ZRWgScXemOTBJ/itGrpkSP29AdHjLDlyuvb
 4Wz0d1sO0Tk28J/lPq5dmAVlgbmk9mEDOImZ2BW28HNuF5JizTS78MmyCskm14NOKit+eYhEVOJ
 lv1y2Wee8xLOMT4WeqQa8asRrkCz1uqvK5hJ+/+4HmNEquzy+FUsEFvI
X-Google-Smtp-Source: AGHT+IEGRCGLJM3ZliT4LicglMJe4isWYSBQNM14ri3eGsImGDrLnR3TbWf0pBMXKrLXw0c57N9MlQ==
X-Received: by 2002:a05:600c:8012:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-44c92d3516cmr140974815e9.22.1748420076629; 
 Wed, 28 May 2025 01:14:36 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/28] target: Use cpu_pointer_wrap_notreached for strict align
 targets
Date: Wed, 28 May 2025 09:14:00 +0100
Message-ID: <20250528081410.157251-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 81ff725cbc..49ec3ee5dc 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2933,3 +2933,16 @@ uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
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


