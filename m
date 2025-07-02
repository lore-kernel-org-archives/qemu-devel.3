Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92E9C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hQ-0007vx-Sj; Wed, 02 Jul 2025 15:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ge-0006gc-5U
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gb-0003FM-LA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so1454335e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482799; x=1752087599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kv+3eABLjDWkuIjt/EEQUuT2EYyux5ATDXpfAYp2as0=;
 b=ZZIFq+irdaVPeEG3WhNAS50XA7PyCWBLFohS/ODmDQ2ttVOGxCfIZWgX6WQgA3hZyb
 a6Z5I3CLch/PzthMGhJcSmehkAC/6RYBfFntNMoFx+mh3v9FsjMGKMgEhd0BOMe7Udo+
 rh6WvTYe9V+WwEBPXeB+K2JdlpRwJ1o7chY6esrksQsCnRevDfQcXFQNW3SxR/BOyqFb
 qQgxCIzFAFCPv5UXDSlbF5TYO8hL8kuWLKf4Jh/jIptwVVIkWdYVdvKC763yhXGa3mpk
 mCanmcGhebe5/6Xepg4hlpEWBfOiX/YLUNbpjNfUOI5gePTLnKLVGNuWXi2oFZu6gzQU
 WXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482799; x=1752087599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kv+3eABLjDWkuIjt/EEQUuT2EYyux5ATDXpfAYp2as0=;
 b=W0RafisHYxnw6QYFXZxFDeifmwqss5ErrZm8+284TEetUpotBMAKO2ArLnO0HjKStK
 SR9kCm6Cn03EmxRL8aLo90EepPWJIFIMQ3J5AnUtM2m6UJuXjNUhfiSY5o7oCxDj7GH0
 +/DptVZ0XpdGkp9wDHC1y6koKG1R3HMjLAz29C1+VI4+WmAqYSOKAMNxU7dGmCCOfEyn
 x299JMuO/CD4Dn0rOl+Cy53S7oNVIcDVAccbdlMJ5J0lopDZVnu5qO/yZdfKTijitXpu
 gaDUmf2diHvlXnFuQCt5x3cMSN+j+XbF43HU0PGpDRSMRf1tRpWozEVhLBgbJO25r29c
 nDHg==
X-Gm-Message-State: AOJu0Yyzv9qrXpe4bRWx5hXTn8/ynvRslRuMMujARJL0ZNL/QXXbG2WN
 V38JtHLTs8EkQQSex5lf9NtZF4VhHXNs2n20mBVg0eLqykQMDJ/d60k8F26BUWFW2H4cGfiZ2WP
 H5hxT
X-Gm-Gg: ASbGnct9iAROPdv5KVf1LrE1zU40X5zIatTiQzVj9GF9rsJ6sCxhxs/LETJxFz0pGKU
 e12P++jafXbMc/cENS/sk9n9FqG+WdG0gjBLWcST2zxrvInweWbDer9icbRabbz/vW/hV6Y5QyI
 /Id4Qrn9DXLpH97xYthMSwxA6POlK3pzY7K3ADpdwAPl7SzbJBEcB29QoQCuCeS4zqQYw+TC82f
 sN8q92gGMFNZFM6envU5esvznVLY+/LSHnzl2VHgYQZXn0hPPh1iUBiL5fnH8pemnugvBZVXVUR
 Nlb5PUXAFdGituBtyEAddQxsxJHr5rl675aHIGv5nzHcYPBhfkQW5N2yPSv5W5n7Ra0bH6e5Ehf
 9qfCBmegjcFRoJW/NPLEqRDfGEgvFntBI/d1p
X-Google-Smtp-Source: AGHT+IH2vfIjk+Tc/Vi6vgS0ILXqs9L+GinfsSoYO3nuNrhq+KS1ory1IPW4kjynzYVup2aPTzMU8A==
X-Received: by 2002:a05:600c:a011:b0:453:79e8:e92d with SMTP id
 5b1f17b1804b1-454ab30b775mr305745e9.5.1751482799343; 
 Wed, 02 Jul 2025 11:59:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f44dsm16545501f8f.87.2025.07.02.11.59.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 55/65] accel: Pass old/new interrupt mask to
 handle_interrupt() handler
Date: Wed,  2 Jul 2025 20:53:17 +0200
Message-ID: <20250702185332.43650-56-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Update CPUState::interrupt_request once in cpu_interrupt().
Pass the old and new masks along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-icount.h |  2 +-
 accel/tcg/tcg-accel-ops.h        |  2 +-
 include/system/accel-ops.h       |  2 +-
 accel/tcg/tcg-accel-ops-icount.c |  8 +++-----
 accel/tcg/tcg-accel-ops.c        |  4 +---
 system/cpus.c                    | 12 +++++++-----
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.h b/accel/tcg/tcg-accel-ops-icount.h
index 16a301b6dc0..1d9d66f0707 100644
--- a/accel/tcg/tcg-accel-ops-icount.h
+++ b/accel/tcg/tcg-accel-ops-icount.h
@@ -15,6 +15,6 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget);
 int64_t icount_percpu_budget(int cpu_count);
 void icount_process_data(CPUState *cpu);
 
-void icount_handle_interrupt(CPUState *cpu, int mask);
+void icount_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 
 #endif /* TCG_ACCEL_OPS_ICOUNT_H */
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 129af89c3e7..3f8eccb7a7f 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -17,7 +17,7 @@
 void tcg_vcpu_thread_precreate(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
-void tcg_handle_interrupt(CPUState *cpu, int mask);
+void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index d4bd9c02d14..6d0791d73a4 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -67,7 +67,7 @@ struct AccelOpsClass {
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
-    void (*handle_interrupt)(CPUState *cpu, int mask);
+    void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
 
     /* get_vcpu_stats: Append statistics of this @cpu to @buf */
     void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index d0f7b410fab..500b5dd4942 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -147,14 +147,12 @@ void icount_process_data(CPUState *cpu)
     replay_mutex_unlock();
 }
 
-void icount_handle_interrupt(CPUState *cpu, int mask)
+void icount_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
 {
-    int old_mask = cpu->interrupt_request;
-
-    tcg_handle_interrupt(cpu, mask);
+    tcg_handle_interrupt(cpu, old_mask, new_mask);
     if (qemu_cpu_is_self(cpu) &&
         !cpu->neg.can_do_io
-        && (mask & ~old_mask) != 0) {
+        && (new_mask & ~old_mask) != 0) {
         cpu_abort(cpu, "Raised interrupt while not in I/O function");
     }
 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 4931e536beb..a8c24cf8a4c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -99,10 +99,8 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 }
 
 /* mask must never be zero, except for A20 change call */
-void tcg_handle_interrupt(CPUState *cpu, int mask)
+void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
 {
-    cpu->interrupt_request |= mask;
-
     /*
      * If called from iothread context, wake the target cpu in
      * case its halted.
diff --git a/system/cpus.c b/system/cpus.c
index c2ad640980c..8c2647f5f19 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -246,10 +246,8 @@ int64_t cpus_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
-static void generic_handle_interrupt(CPUState *cpu, int mask)
+static void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
 {
-    cpu->interrupt_request |= mask;
-
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     }
@@ -257,12 +255,16 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    int old_mask = cpu->interrupt_request;
+
     g_assert(bql_locked());
 
+    cpu->interrupt_request |= mask;
+
     if (cpus_accel->handle_interrupt) {
-        cpus_accel->handle_interrupt(cpu, mask);
+        cpus_accel->handle_interrupt(cpu, old_mask, cpu->interrupt_request);
     } else {
-        generic_handle_interrupt(cpu, mask);
+        generic_handle_interrupt(cpu, old_mask, cpu->interrupt_request);
     }
 }
 
-- 
2.49.0


