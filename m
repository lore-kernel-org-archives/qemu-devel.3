Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40856C8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcH5-0000b3-AB; Tue, 01 Jul 2025 10:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGp-00006q-J2
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGi-0007b2-B4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so27885595e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381250; x=1751986050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvhTwPfnhU/OldPu14yfTguJeL+N42mB2yTgapZUbe0=;
 b=vbJI5qh6hlLl/LJlwMX1RUbecZDhj3yby1Ak3r/1UXAabCrPjHaKF8akroxEH2Y8hQ
 I4PIh4VLl/poFbarCQMAedoaEzHcb6GUah9Z4dp/GipOofgTHjXjub13b4FEvXJLKQfP
 JEAY5bgKHcNBkFSs4w6UU7oJ6IAf7+yLOCrPndMJCjDaEKJl/PyWK/Rdi3jLcgdmokXD
 mCGhd3y9yM92kRaa+MuiOx+olzxSG0K6VHywZnYJAQJh9//x4m3365y+bBGl8jQf+e8L
 htUaeAkENV1YFgpMC3LpIprR/8xm3YdVFmSlIEwxfT5XBligHTYzeaeNbhg+FD49DbQz
 cpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381250; x=1751986050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvhTwPfnhU/OldPu14yfTguJeL+N42mB2yTgapZUbe0=;
 b=fEGLom+4QcjNOmN3ls1pacY1wgu1OMnGq/TuFT/iVInTtIIK0A2v6j2bcKV2hU1na9
 6M1hd9KaQMzuwEtJJa8TaLJy8OVyEr7ZzJROzqOW8P1RlJAXsOdcxswgTNO+5a19LEtc
 bIwt587LkMMIRAx7lrsaSF5xonu6nC+O3qtNNVcHd2K3H7ufTXKJIP9jhG/v/zNe0UZk
 DSeszWdAcjUFdVEvF7TGBwfSKHmMFOdyZwX17bcecPdfkFB8sN6xddcTbR4p2wgOUJ8h
 O/+JOTRjjCbuhR6BcgL5SJLTnND1OrnNTX0CJC2OBOUymyaLD3LDqaZimZvy9k6cyEwD
 ieFw==
X-Gm-Message-State: AOJu0YxBz5iK/U4OiSeMFMq5NKzb0I5dT/EDfZx7kxuT/pM69sRbYVOK
 6POTKMflr35jVHHj8OSu1fSQ3t5v2cm9ZaRvIdFWPW7+AQU9dR7S+E9Ys5NvMbgcuWHa5aS3Y2O
 lYtCP
X-Gm-Gg: ASbGncv1XgohlFoeNjCfe//4oDTMJji91fooAPS6GB/waYb5zCv52AV6soAy+nyduZy
 Cl8+/cozOKxTLNwvYv8ypdjfSnFcwLKzbCA+RaQbMkeEGUyruBqWCxk1cELnHTGColBNbtDBAmj
 VvPcS5VRQWT4rDWs7l50SilxfLmK+CWBB25gri4SCb8U/SZ1btYqibZ9I3Ki7tgJ2Jf3bgC3UL2
 i1V8DCL55sQwbP0ujXZhuRlbOrEymXNzuCmM5TYt5fFnJZoCVzNwU6YMeW1Q6Zmmzo5TlLoFQjR
 LtH1f4u3vp9vC7i+OEJdCnOb2nfC748ArDHyjDUy849qYpyPt9uIZhMzw9rejQPW7CcWJHkc6Jt
 RpjxMB+UKudcX8JsjlTLt5tHsFy3+LSBnLV/c
X-Google-Smtp-Source: AGHT+IFrG1D2CL3zpSdpdVFYsDWfFOMuatqsJFB23DiTTLTYL4XpkWWCuVfIofBeMZd2P6tLYIsEiw==
X-Received: by 2002:a05:600c:4e8b:b0:453:8a63:b484 with SMTP id
 5b1f17b1804b1-4538ee75d5emr204229315e9.30.1751381249819; 
 Tue, 01 Jul 2025 07:47:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fb20esm13701993f8f.36.2025.07.01.07.47.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:47:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 66/68] accel/system: Pass old/new interrupt mask to
 handle_interrupt() handler
Date: Tue,  1 Jul 2025 16:40:14 +0200
Message-ID: <20250701144017.43487-67-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 accel/tcg/tcg-accel-ops-icount.h |  2 +-
 accel/tcg/tcg-accel-ops.h        |  2 +-
 include/system/accel-ops.h       |  2 +-
 accel/tcg/tcg-accel-ops-icount.c |  8 +++-----
 accel/tcg/tcg-accel-ops.c        |  4 +---
 system/cpus.c                    | 12 +++++++-----
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.h b/accel/tcg/tcg-accel-ops-icount.h
index 5f3ebea50ff..ddd53cc1e4f 100644
--- a/accel/tcg/tcg-accel-ops-icount.h
+++ b/accel/tcg/tcg-accel-ops-icount.h
@@ -15,6 +15,6 @@ void icount_prepare_for_run(CPUState *cpu);
 void icount_update_percpu_budget(CPUState *cpu, int cpu_count);
 void icount_process_data(CPUState *cpu);
 
-void icount_handle_interrupt(CPUState *cpu, int mask);
+void icount_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 
 #endif /* TCG_ACCEL_OPS_ICOUNT_H */
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 1263a666774..a95d97fca29 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -17,7 +17,7 @@
 void tcg_vcpu_thread_precreate(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
-void tcg_handle_interrupt(CPUState *cpu, int mask);
+void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
 int tcg_vcpu_init(CPUState *cpu);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index f98a1c9b662..9d2577fe67f 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -70,7 +70,7 @@ struct AccelOpsClass {
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
-    void (*handle_interrupt)(CPUState *cpu, int mask);
+    void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
 
     void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
 
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index ae1297ff7f3..d02b319951c 100644
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
index c6b5a567f9d..e7716dbc8da 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -109,10 +109,8 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
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


