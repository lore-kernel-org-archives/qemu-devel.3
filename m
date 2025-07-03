Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B37C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNql-0000pX-Iw; Thu, 03 Jul 2025 13:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqJ-0000Lr-4U
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNq8-0001fD-Qf
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so609285e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564114; x=1752168914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKkY66WSncDjfDBkQ2PUmi6A59h3Sya1fBXJtO0Vmlo=;
 b=tPdA24ulhZy6CJQaYWic7IFCZwkqghaerONcbKvJ0pPaMNScifPk5ak8TpS3QF0NTw
 RT+A/0H4WyWRgUCV3iM4IlGIKtvHRdTkt5bxeUKD6hBZOPAEm/GFpoRn9cmYSBM5kdYu
 2YhMJ8gE76W0cu3FmwHyoAVjl742LyLYdIE5wEBG2Eq95WpJspmYuI9fJPkubXLR4VCs
 n6gedwWzOk5afLtJ8wqNyRxjjB4APrIvbiJg1/3WVhdW+CqsqTMIp67SlaW0keP5ubdw
 b+11n/ozrjB4EX06VusJbqAoFjcWxz4n3p2CA22Run0XZ123TdgGTj9yHHDLruTB/wXR
 EbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564114; x=1752168914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKkY66WSncDjfDBkQ2PUmi6A59h3Sya1fBXJtO0Vmlo=;
 b=qrw1rc38Ct/108nWRteF42HOVkFnGd2zKA243HSoXlJqRFnkum94SYfIl6cGla34rD
 q4XiiJdaONfYgDN+8f0tLMC/mCscHdtbEVQZHS5DGjx8t91AEZCsz/vKgkzCYXwZTkXO
 d7f7mKykIjE0fMFNM33fB034hRMNo1joX0cKWQtMMBUL//DrWvqqK+5AiFNhkay5Ki0O
 VClYH07aTDTGPhNocM8+bGDDPHVnUx5oH8nsrRTzPz9bISV4R3xjmTY7aCCZ1oG0BZYi
 YhgWeD0RvR0qZWiEgUjUq210FF6xSzCBdadILuG0F3/+6VGlMdHvlB+LrDiE3nVe52F5
 Qc5w==
X-Gm-Message-State: AOJu0YyE2SHEYKmwyKGIA+ocV889h+y3OQgrTiiTrAYA+XLuVNfgb7nW
 eaKfndPFo68/Vd6vZj2YD1/i1GqEatWaVc3Wgz+AkvXAkeyLKCKPYLYaeTjroVaDNIgF7xm9z4t
 4JV3SmJQ=
X-Gm-Gg: ASbGncuK7EsQgxV0t/q3cY6R0v84vxg/sjnPDcvBVQBA2VQmMGm9si5GvvXkUgBn53s
 VkIWJlbCxv6HZyBtYxNkYyjP1mNSet0CuLSi+lDbnFgQ+7I3etxwFndzJC7vsvJxhXEMMJGqov2
 QMJAw+TVMostj3NoogMrlbUsA9WYzLzWnJ495vIxkEajXpmODFPs53EDPz6DjWynJe36lcw37kZ
 o4n/CaKSzv0t6jcZtXdxayd+H2si6J9y7LdWDIqOwI13e2dRIPuJreEyf5+H/rjehd0PAgXPSuo
 E3UjQb9TMiXEQew40pmwvR66Bxzbu3pbbtTHEIdc7s96bftB2eLTnUy3hLLGLBIddQdTRXeOiI6
 xfFAW8g+Z5jpIxwKOy5uKxaQ9HpXcayEbLpYC
X-Google-Smtp-Source: AGHT+IE+oERmztqeh1GValBSAb7xMH8Gnkn6Ou+BXUEMTkBVWQVLxXxIW2RoSLeYtG+owzfK+o46Iw==
X-Received: by 2002:a05:600c:c48f:b0:448:e8c0:c778 with SMTP id
 5b1f17b1804b1-454a370cd65mr74636835e9.22.1751564114470; 
 Thu, 03 Jul 2025 10:35:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0941sm335801f8f.26.2025.07.03.10.35.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 27/39] accel: Pass old/new interrupt mask to
 handle_interrupt() handler
Date: Thu,  3 Jul 2025 19:32:33 +0200
Message-ID: <20250703173248.44995-28-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index 6feeb3f3e9b..6e7c2aae5a8 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -16,7 +16,7 @@
 
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
-void tcg_handle_interrupt(CPUState *cpu, int mask);
+void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 2075691331c..d84eaa376c2 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -61,7 +61,7 @@ struct AccelOpsClass {
     void (*synchronize_pre_loadvm)(CPUState *cpu);
     void (*synchronize_pre_resume)(bool step_pending);
 
-    void (*handle_interrupt)(CPUState *cpu, int mask);
+    void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
 
     /**
      * @get_virtual_clock: fetch virtual clock
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
index f579685a611..eb16a6bf6db 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -91,10 +91,8 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
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
index 4fb764ac880..13535a74e6f 100644
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


