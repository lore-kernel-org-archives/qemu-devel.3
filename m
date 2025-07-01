Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08083C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcD7-0002fU-AD; Tue, 01 Jul 2025 10:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCi-0002BN-BE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCe-00074e-DF
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso32602155e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380996; x=1751985796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=db1O6737cUvXEcrxQJckebve6nRy9MFZBmUtv6n+W3s=;
 b=hkH5NJo0EZC6wScla702E6pUBpk8D+Zfny9biUHupaO7v7IHYDJLpoD8ANakoAJF9v
 yQoWUyr+meapP0X7zm09zePRBISUSwjJMShm+hXQpN+tcI9VEcbjrVrtXQM0Mhvwdj02
 XxXhBCf83MX86ssDM7iQnII85zGmIZ1gP1kzpFnnjL6A83vQATQgu7zgNX6OH1FgXz6E
 CmCYQX+E29FgK3m4oa+2waEQhjx8tsL4CjfhMXS6WW3hbK3XudiTRvL+jKHd8v/eozTU
 116G6/P3AEimlPSEylOf1kqzTA3/Qrsy4pkiPZJ972bZOKHNYvb+5FQNH8ABSp3UDTvh
 nz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380996; x=1751985796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=db1O6737cUvXEcrxQJckebve6nRy9MFZBmUtv6n+W3s=;
 b=v8x/yzrsznhzGrBIy+UENVpqyihrjxX1uKoKN05waVRDrCKFDXE1zDv8omb7XI7Kbj
 6dKhKKejFU0u7mhg6jp7SeODPXDNIShydK1b1NWjNuG5c7qGcGJIKhzD54Gz0DRXp2ng
 C68uFObgRSmsTlgAznHBXlBaTE0YifUbZ+nNzgKzP3Uy2dyN+asTGyEtj5SrYkFrL9Mk
 AaR4jn4/NStwAYDn9/WblmEdcm37iFK8lrcpWmuV7/nxuEOW68yqzbTycKOLxcwEJJGX
 Uqn9UFvBa8JH/JZ8I8Sksa8d7YQjehzP7sqwhQbk053uccSYMeaa4jZ5LvKJWJlAmObO
 dASA==
X-Gm-Message-State: AOJu0Yw3uAKehT7oAmPGnY7K7q6jF58YHu056o+ieCkGWljv/o/MCehm
 xuo+x5fOu0YqQ4Rvqp43tIz7y0PYv8IuC01MPdC1yCm2NDknDghBWXd6F/gFa8MGq/KkxCkJvOt
 cZuQr
X-Gm-Gg: ASbGncu9qN4yfwxbySlXFbt0o5q+byx51oaXUgIzA1n+GQFc2Mgj4Mp2O4MtvFFECB/
 f64vrNye1aEIKGuI+4eOV0vdEvT/oZas67w3IaEkaJmgZ+qNmrB+o+ZJ/rIFS/AsfTHHL5Rji9O
 LsXvpPfud08EtzhWlopUtDtcRird9N1TJGF9FddPKFpRPjN7TABIqjmmjBqWQ3JEwOhzOzQ9bCa
 m7JdTJKvTAxGJ/Tu7O8Z2sn5qsBXcx7gXif7jql7MUy0vHHXQDxxqVuRREkCZ0hAkyIU4K7sgCU
 abzyWd6u5U9Dp9e9myi/EAVycNfa0t+nVZTuyzePlI4xSbx9BpbxvzmpPEFxnC4ivmNJ0hTx0GI
 Wk6KCEIqaO2MJXJqK7xWqHeOBfcq9RUITG0BF
X-Google-Smtp-Source: AGHT+IEq2XxPOyHeLpM/1GRTY6h2ojLqztnC1Y8fjicAkz3Rd39wns4mmkEG6giYM8b+CA/peOWg7Q==
X-Received: by 2002:a05:600c:8112:b0:442:ccfa:1461 with SMTP id
 5b1f17b1804b1-4538ee5d268mr196225945e9.13.1751380996368; 
 Tue, 01 Jul 2025 07:43:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3b3213sm165918405e9.18.2025.07.01.07.43.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 33/68] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Tue,  1 Jul 2025 16:39:41 +0200
Message-ID: <20250701144017.43487-34-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

No need for accel-specific @dirty field when we have
a generic one in CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  |  1 -
 accel/hvf/hvf-accel-ops.c | 10 +++++-----
 target/arm/hvf/hvf.c      |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86hvf.c  |  2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index ea6730f255d..a8ee7c7dae6 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -62,7 +62,6 @@ struct AccelCPUState {
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
-    bool dirty;
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 319c30f703c..c91e18bc3dd 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -79,15 +79,15 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         hvf_get_registers(cpu);
-        cpu->accel->dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
 static void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -96,7 +96,7 @@ static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
     /* QEMU state is the reference, push it to HVF now and on next entry */
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
@@ -156,8 +156,8 @@ static int hvf_init_vcpu(CPUState *cpu)
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
-    cpu->accel->dirty = true;
     assert_hvf_ok(r);
+    cpu->vcpu_dirty = true;
 
     cpu->accel->guest_debug_enabled = false;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3fb0b49df8a..c3876cead18 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -812,9 +812,9 @@ int hvf_put_registers(CPUState *cpu)
 
 static void flush_cpu_state(CPUState *cpu)
 {
-    if (cpu->accel->dirty) {
+    if (cpu->vcpu_dirty) {
         hvf_put_registers(cpu);
-        cpu->accel->dirty = false;
+        cpu->vcpu_dirty = false;
     }
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index bcf30662bec..c893aaac1b0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -738,9 +738,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             hvf_put_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         if (hvf_inject_interrupts(cpu)) {
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 2057314892a..17fce1d3cdd 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -427,7 +427,7 @@ int hvf_process_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cs->accel->dirty) {
+    if (!cs->vcpu_dirty) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
-- 
2.49.0


