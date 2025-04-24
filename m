Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB1CC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l0K-0002VA-VY; Wed, 23 Apr 2025 21:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwy-0005RM-40
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwv-0005XR-3B
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so484574b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456419; x=1746061219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JULegdjF4TEWKbMa1RsDi++XULImatCldLbzXwzcxYs=;
 b=QQPLpXCpB2A7iMYQZVAEu2+OcPb4gHQOUcmotjHEWpXRn4FIyzEvGObTwnfl2L7l9d
 ltbpanYqBNvIxXXS1R60NcC/eUItFAYzvGJVn6GRU19LuyUmjcOkTsKxu4bN5Wgj0FP1
 ksxdKPWTfZtbuXiptBNY635YwmR2JQAlWYJ/YiCxocSfe4h9NP9yZnzBmOsq2YnJhopH
 ux2YOMViHimZCfNeBeGjMhX1PIdOoVfgFQ63rFrG/C4KIrmGfQPzdRFXkND0iDOIphsD
 OExQ6kpyWI1iBvlxqNGMdtj/GwYCAsqdxrbA1m3u0IuwS4zYfiV4ay39Xh2p8a99weBV
 v7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456419; x=1746061219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JULegdjF4TEWKbMa1RsDi++XULImatCldLbzXwzcxYs=;
 b=iQ+JXI3WszFLAqyp2uYco3ms9RGw4OtvFKys4icx5e5SmBkffyPRdraxiGDq6xar+O
 EW8qQtvY0M7mMkUnrEVgZ9Kb963s1J2U5ji6AW2BQ+svJi8cTgTGmKPXT+0Pj15jGxr3
 UkT3f1lEW2QpZWnjkHLHqwuOzvE0NHG+sKOvsXQehfy2TUc26DLxpL/MJeeLFeHRDWXz
 +41R57bglPtAAoKvjGpe0bpZSdgWaJPgtZALsWO9XAMQwwIHh+7+7x/0fWQZLwXMqtII
 I7VwnnWWQGDofLWBsB4J4Ft/Kline7cC/pOqVnjCg1VGT/iAWPEjhbsfbujgzw77Kix1
 iElg==
X-Gm-Message-State: AOJu0YyqyEdhcM39jSQ25BrrjRfVCmquAi30eWU+zLfj8HjONYqrSVf0
 ZYvZOneIl+RsRWjjd9Rjl06eOMpcCqvJTLrKawZD0E92EzO+haNSzPfDgmhoT9EJLAQ5YznGRGi
 x
X-Gm-Gg: ASbGncuPKkgj3n708oxgf3SAyxOHJ2/sSHn6hgaGsGqCJsywPWoURtZlNscmxxhmxIA
 hq5gyU159jSDqZsfbnO4ptWBvuhmFqK8lsU22waMSsr+ul9/NB3d0wYpqB6y5/0aGmk56ouChKA
 lPOPyRc4NSuRTgln9OpKl5+j5Z7c9qv6/tWDhMHYFG1OKIdnyZiSyThc4O9aYqqcCArfZD8lJsL
 9ofiQTxn9018tPQMvTuQNxt3Or6VT3tUYc3fpZbhrL7FpbNxcLqyKsqZlVMOA96SqIwR6fu7i+p
 Qj12JUl7MreHiZKPXXvPdLasQARInnzmTecoS1QHYaMkgzbxHWMAOi4E9WW9MF7+ZHg3UfamMMr
 PePSESUXw9g==
X-Google-Smtp-Source: AGHT+IFl0MCBNNs8odxicN1paDkjSp0ho1re5HMDBgEFDFPfbxrvT7fOzlWj6dtC2LhEj5/C1FFzqw==
X-Received: by 2002:a05:6a20:6a1f:b0:1f3:2c55:8d8a with SMTP id
 adf61e73a8af0-20444ec8881mr825442637.12.1745456419040; 
 Wed, 23 Apr 2025 18:00:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 141/148] tcg: Pass max_threads not max_cpus to tcg_init
Date: Wed, 23 Apr 2025 17:49:26 -0700
Message-ID: <20250424004934.598783-142-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

In effect, hoist the check for mttcg from tcg_n_regions()
to tcg_init_machine().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/startup.h |  6 +++---
 tcg/tcg-internal.h    |  2 +-
 accel/tcg/tcg-all.c   | 14 ++++++++------
 tcg/region.c          | 27 ++++++++++++---------------
 tcg/tcg.c             | 14 +++++++-------
 5 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/include/tcg/startup.h b/include/tcg/startup.h
index f71305765c..95f574af2b 100644
--- a/include/tcg/startup.h
+++ b/include/tcg/startup.h
@@ -29,12 +29,12 @@
  * tcg_init: Initialize the TCG runtime
  * @tb_size: translation buffer size
  * @splitwx: use separate rw and rx mappings
- * @max_cpus: number of vcpus in system mode
+ * @max_threads: number of vcpu threads in system mode
  *
  * Allocate and initialize TCG resources, especially the JIT buffer.
- * In user-only mode, @max_cpus is unused.
+ * In user-only mode, @max_threads is unused.
  */
-void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
+void tcg_init(size_t tb_size, int splitwx, unsigned max_threads);
 
 /**
  * tcg_register_thread: Register this thread with the TCG runtime
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index a648ee7a0e..ff85fb23fa 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -34,7 +34,7 @@ extern TCGContext **tcg_ctxs;
 extern unsigned int tcg_cur_ctxs;
 extern unsigned int tcg_max_ctxs;
 
-void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus);
+void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
 bool tcg_region_alloc(TCGContext *s);
 void tcg_region_initial_alloc(TCGContext *s);
 void tcg_region_prologue_set(TCGContext *s);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a5a1fd6a11..3efc7350eb 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -103,18 +103,20 @@ bool one_insn_per_tb;
 static int tcg_init_machine(MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_accel());
-#ifdef CONFIG_USER_ONLY
-    unsigned max_cpus = 1;
-#else
-    unsigned max_cpus = ms->smp.max_cpus;
-#endif
+    unsigned max_threads = 1;
 
     tcg_allowed = true;
     mttcg_enabled = s->mttcg_enabled;
 
     page_init();
     tb_htable_init();
-    tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_cpus);
+
+#ifndef CONFIG_USER_ONLY
+    if (mttcg_enabled) {
+        max_threads = ms->smp.max_cpus;
+    }
+#endif
+    tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_threads);
 
 #if defined(CONFIG_SOFTMMU)
     /*
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4..7ea0b37a84 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -422,7 +422,7 @@ void tcg_region_reset_all(void)
     tcg_region_tree_reset_all();
 }
 
-static size_t tcg_n_regions(size_t tb_size, unsigned max_cpus)
+static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
 {
 #ifdef CONFIG_USER_ONLY
     return 1;
@@ -431,24 +431,25 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_cpus)
 
     /*
      * It is likely that some vCPUs will translate more code than others,
-     * so we first try to set more regions than max_cpus, with those regions
+     * so we first try to set more regions than threads, with those regions
      * being of reasonable size. If that's not possible we make do by evenly
      * dividing the code_gen_buffer among the vCPUs.
+     *
+     * Use a single region if all we have is one vCPU thread.
      */
-    /* Use a single region if all we have is one vCPU thread */
-    if (max_cpus == 1 || !qemu_tcg_mttcg_enabled()) {
+    if (max_threads == 1) {
         return 1;
     }
 
     /*
-     * Try to have more regions than max_cpus, with each region being >= 2 MB.
+     * Try to have more regions than threads, with each region being >= 2 MB.
      * If we can't, then just allocate one region per vCPU thread.
      */
     n_regions = tb_size / (2 * MiB);
-    if (n_regions <= max_cpus) {
-        return max_cpus;
+    if (n_regions <= max_threads) {
+        return max_threads;
     }
-    return MIN(n_regions, max_cpus * 8);
+    return MIN(n_regions, max_threads * 8);
 #endif
 }
 
@@ -731,11 +732,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
  * and then assigning regions to TCG threads so that the threads can translate
  * code in parallel without synchronization.
  *
- * In system-mode the number of TCG threads is bounded by max_cpus, so we use at
- * least max_cpus regions in MTTCG. In !MTTCG we use a single region.
- * Note that the TCG options from the command-line (i.e. -accel accel=tcg,[...])
- * must have been parsed before calling this function, since it calls
- * qemu_tcg_mttcg_enabled().
+ * In system-mode the number of TCG threads is bounded by max_threads,
  *
  * In user-mode we use a single region.  Having multiple regions in user-mode
  * is not supported, because the number of vCPU threads (recall that each thread
@@ -749,7 +746,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
  * in practice. Multi-threaded guests share most if not all of their translated
  * code, which makes parallel code generation less appealing than in system-mode
  */
-void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
+void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
 {
     const size_t page_size = qemu_real_host_page_size();
     size_t region_size;
@@ -787,7 +784,7 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
      * As a result of this we might end up with a few extra pages at the end of
      * the buffer; we will assign those to the last region.
      */
-    region.n = tcg_n_regions(tb_size, max_cpus);
+    region.n = tcg_n_regions(tb_size, max_threads);
     region_size = tb_size / region.n;
     region_size = QEMU_ALIGN_DOWN(region_size, page_size);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dfd48b8264..ec7f6743d7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1499,7 +1499,7 @@ static void process_constraint_sets(void);
 static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
                                             TCGReg reg, const char *name);
 
-static void tcg_context_init(unsigned max_cpus)
+static void tcg_context_init(unsigned max_threads)
 {
     TCGContext *s = &tcg_init_ctx;
     int n, i;
@@ -1538,15 +1538,15 @@ static void tcg_context_init(unsigned max_cpus)
      * In user-mode we simply share the init context among threads, since we
      * use a single region. See the documentation tcg_region_init() for the
      * reasoning behind this.
-     * In system-mode we will have at most max_cpus TCG threads.
+     * In system-mode we will have at most max_threads TCG threads.
      */
 #ifdef CONFIG_USER_ONLY
     tcg_ctxs = &tcg_ctx;
     tcg_cur_ctxs = 1;
     tcg_max_ctxs = 1;
 #else
-    tcg_max_ctxs = max_cpus;
-    tcg_ctxs = g_new0(TCGContext *, max_cpus);
+    tcg_max_ctxs = max_threads;
+    tcg_ctxs = g_new0(TCGContext *, max_threads);
 #endif
 
     tcg_debug_assert(!tcg_regset_test_reg(s->reserved_regs, TCG_AREG0));
@@ -1554,10 +1554,10 @@ static void tcg_context_init(unsigned max_cpus)
     tcg_env = temp_tcgv_ptr(ts);
 }
 
-void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus)
+void tcg_init(size_t tb_size, int splitwx, unsigned max_threads)
 {
-    tcg_context_init(max_cpus);
-    tcg_region_init(tb_size, splitwx, max_cpus);
+    tcg_context_init(max_threads);
+    tcg_region_init(tb_size, splitwx, max_threads);
 }
 
 /*
-- 
2.43.0


