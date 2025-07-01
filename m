Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDF7C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcHS-0002ZL-Py; Tue, 01 Jul 2025 10:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFz-0007v8-U8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFv-0007Wp-SB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso6151320f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381200; x=1751986000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iORnn1JJJLCdwYBCZ/l6c6FvfoDU1dUjDQ64NH+dtBI=;
 b=SdxToHs4/M0GcFEOWGProE9foJcm8nWvl9GDi3I/AFOxV+ZFvaHYxOfL5Q9bq7F0h8
 WM6mQtyBtvM/A0gS+VigFAroT87lT16A11f0C0AbSU2TWGd2V+awxwSujt9Ukcj0mafV
 Hzhuojxt6GyAc+rKzwtEpPn32+cm/r4DPFYgmaekI7+RrxsnKcRCCHrGkFeNBB0rFeVO
 qHaJcVhty3oY6UvBL7GAg5v0VH+Ns3Y+Q0rJewb80IwD4NEPMvHVxmX/uNRZWb5yUk91
 BZ3lXxQKLzf5gj2RCuozaKQlSxMjXjY8IDk8idqPWnaay5l+RWaEn28Hp7MnJ9n76j9a
 yYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381200; x=1751986000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iORnn1JJJLCdwYBCZ/l6c6FvfoDU1dUjDQ64NH+dtBI=;
 b=PrSngU6wcAB9z1zGyC9txKVPJ/NCSZplPYXmwypstWHkSEdi91g0QR0Da+BqOwdul7
 /UMjM48FmHe1qm9/LR7mmaNiSyrEl8UEnKPjnaBgjQtJMzfA4FLsPXZLoC0YVNs3vgMT
 +1qo0zDC7fBmjIyz0azrAwPshEC3DQ784DcyKnMR8HBKjnbkvnh6c9l/2zF5qAqVixYY
 pvRVeJKC9RnRhWXKr21SOCLA94e8bvB4BN4NCfABQ3uoG5NVpqUUKtTyRI5aSMD9xol6
 xun1g2BvdRtpfhrq1U2ohZnCwYt9JoD+2yoKgb9tLshQmCzuy5pL6ZHkI/znkNecm/oA
 RRDA==
X-Gm-Message-State: AOJu0Yy3Og4KbZ/wdkMIDSbhD/OYjwa/C1lIRYNaOVOdvfb34aGMIALG
 szC9GcerfjKeNq1iOpfQB8DqgNf8q0TxxKb4hLz/6+nLhwj8ByujFyiTr3vlBH+/Pto2oO7+G+1
 S30Xp
X-Gm-Gg: ASbGnctj5IBz6epQmqcKeV/Bc5ABeOLbxDQ5qHA/Fp7bNLzuVviKl5QZUaxGawb+Xxi
 Ib1HkKr6nUEDfs7tXi47YWH79QI+qGNkmVaMOia90Z/Gc4JFbBFcYZKQcOgm8vw4hNJX1evwRxS
 PlWE6x9Ps+BQx5vo5DU06CBwymA3ajtGepVMmvYwn6t9Yk+zbD4EHlN5uKt/bdaHTa8BYc4z0GX
 PpWn4HEYpFHZIMxw1a6DjEmxxuouOIRtSRX4PxPYWfxgNuDcalU2D8zWJ6QaQRG757Ti5VnekPY
 nbG9Br24ZcFEG52MiQUujSzrlmx+6P8hl2nY0NIe30J15QnMEV6945XHeLlkgYg5PeZA8i629I4
 BICe4SeD8F7W95HJK+nKn2T7doRHhktx5RkDc
X-Google-Smtp-Source: AGHT+IGAs7TxHwXqt7lLNC5eerYhYUvaR4jfXV0zWONpvIaehy6Rsj5cpIEMUFRBQ+2mO+gEZNw+jg==
X-Received: by 2002:adf:e282:0:b0:3a5:2a24:fbf5 with SMTP id
 ffacd0b85a97d-3a90d69c3ffmr11689974f8f.18.1751381200280; 
 Tue, 01 Jul 2025 07:46:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390d4asm170094995e9.3.2025.07.01.07.46.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:46:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 59/68] accel/tcg: Expose vcpu_[un]register() for RR
Date: Tue,  1 Jul 2025 16:40:07 +0200
Message-ID: <20250701144017.43487-60-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Allocate ForceRcuNotifier on the Heap.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-icount.h |  4 ++--
 include/hw/core/cpu.h            |  2 ++
 accel/tcg/tcg-accel-ops-icount.c |  8 +++----
 accel/tcg/tcg-accel-ops-rr.c     | 36 +++++++++++++++++++++++---------
 4 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.h b/accel/tcg/tcg-accel-ops-icount.h
index 16a301b6dc0..5f3ebea50ff 100644
--- a/accel/tcg/tcg-accel-ops-icount.h
+++ b/accel/tcg/tcg-accel-ops-icount.h
@@ -11,8 +11,8 @@
 #define TCG_ACCEL_OPS_ICOUNT_H
 
 void icount_handle_deadline(void);
-void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget);
-int64_t icount_percpu_budget(int cpu_count);
+void icount_prepare_for_run(CPUState *cpu);
+void icount_update_percpu_budget(CPUState *cpu, int cpu_count);
 void icount_process_data(CPUState *cpu);
 
 void icount_handle_interrupt(CPUState *cpu, int mask);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 726427449da..952e44587b3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -498,6 +498,8 @@ struct CPUState {
     int singlestep_enabled;
     int64_t icount_budget;
     int64_t icount_extra;
+    int64_t cpu_budget; /* FIXME TCG specific */
+
     uint64_t random_seed;
     sigjmp_buf jmp_env;
 
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index d0f7b410fab..ae1297ff7f3 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -90,7 +90,7 @@ void icount_handle_deadline(void)
 }
 
 /* Distribute the budget evenly across all CPUs */
-int64_t icount_percpu_budget(int cpu_count)
+void icount_update_percpu_budget(CPUState *cpu, int cpu_count)
 {
     int64_t limit = icount_get_limit();
     int64_t timeslice = limit / cpu_count;
@@ -99,10 +99,10 @@ int64_t icount_percpu_budget(int cpu_count)
         timeslice = limit;
     }
 
-    return timeslice;
+    cpu->cpu_budget = timeslice;
 }
 
-void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget)
+void icount_prepare_for_run(CPUState *cpu)
 {
     int insns_left;
 
@@ -116,7 +116,7 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget)
 
     replay_mutex_lock();
 
-    cpu->icount_budget = MIN(icount_get_limit(), cpu_budget);
+    cpu->icount_budget = MIN(icount_get_limit(), cpu->cpu_budget);
     insns_left = MIN(0xffff, cpu->icount_budget);
     cpu->neg.icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 57a4bcab203..f5af7818d51 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -169,6 +169,27 @@ static int rr_cpu_count(void)
     return cpu_count;
 }
 
+static void *rr_vcpu_register(CPUState *cpu)
+{
+    Notifier *force_rcu = g_new(Notifier, 1);
+
+    assert(tcg_enabled());
+    force_rcu->notify = rr_force_rcu;
+    rcu_add_force_rcu_notifier(force_rcu);
+    tcg_register_thread();
+
+    return force_rcu;
+}
+
+static void rr_vcpu_unregister(CPUState *cpu, void *opaque)
+{
+    Notifier *force_rcu = opaque;
+
+    rcu_remove_force_rcu_notifier(force_rcu);
+
+    g_free(force_rcu);
+}
+
 /*
  * In the single-threaded case each vCPU is simulated in turn. If
  * there is more than a single vCPU we create a simple timer to kick
@@ -179,14 +200,11 @@ static int rr_cpu_count(void)
 
 static void *rr_cpu_thread_fn(void *arg)
 {
-    Notifier force_rcu;
+    Notifier *force_rcu;
     CPUState *cpu = arg;
 
-    assert(tcg_enabled());
     rcu_register_thread();
-    force_rcu.notify = rr_force_rcu;
-    rcu_add_force_rcu_notifier(&force_rcu);
-    tcg_register_thread();
+    force_rcu = rr_vcpu_register(cpu);
 
     bql_lock();
     qemu_thread_get_self(cpu->thread);
@@ -217,9 +235,6 @@ static void *rr_cpu_thread_fn(void *arg)
     cpu->exit_request = 1;
 
     while (1) {
-        /* Only used for icount_enabled() */
-        int64_t cpu_budget = 0;
-
         bql_unlock();
         replay_mutex_lock();
         bql_lock();
@@ -235,7 +250,7 @@ static void *rr_cpu_thread_fn(void *arg)
              */
             icount_handle_deadline();
 
-            cpu_budget = icount_percpu_budget(cpu_count);
+            icount_update_percpu_budget(cpu, cpu_count);
         }
 
         replay_mutex_unlock();
@@ -258,7 +273,7 @@ static void *rr_cpu_thread_fn(void *arg)
 
                 bql_unlock();
                 if (icount_enabled()) {
-                    icount_prepare_for_run(cpu, cpu_budget);
+                    icount_prepare_for_run(cpu);
                 }
                 r = tcg_cpu_exec(cpu);
                 if (icount_enabled()) {
@@ -304,6 +319,7 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
+    rr_vcpu_unregister(cpu, force_rcu);
     rcu_unregister_thread();
 
     g_assert_not_reached();
-- 
2.49.0


