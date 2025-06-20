Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73300C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfLB-00022Z-35; Fri, 20 Jun 2025 13:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKr-0001jn-My
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKp-0004VV-UJ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453426170b6so19307165e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439726; x=1751044526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OT+fA9vdXRf05/yvixFthnp4JSCJ5dpq1JSwUJW9bU8=;
 b=HbmwtbAqf+rdlVsfgtFq7YkiQHNUbYomB5kwYNvkKlgWC+rYSTg3NgnZ2NmNMipTBz
 6R3HxJPhKFWFj5YtJyVRp6mG3188Jjki7Ie8J6nOYgRxYqLbtJJsQk5NLLP6OdnfOV+N
 4CwaH7kPx3JjWmx8acE1nzp6sUeurpTsFjAMgQZPzyhNHTFa1/uoRcFaC9kUEkZRPaRK
 ehFABoTl43GL2JUgwRIunewG4pala5ObK8SmNoVKc7S78bbr77eUxx3Csmr8XBUa1nIw
 /9VAUlRR+wC1zLZgXbjd9AdlOAqTYWoXcmj3yF91N/AuZRFEH7G+8NV5IG/tRM2qeOjX
 PbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439726; x=1751044526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OT+fA9vdXRf05/yvixFthnp4JSCJ5dpq1JSwUJW9bU8=;
 b=FBfz0WZKKwsNYJ5rwBPrh7Z+3IxZ2zYcUEVSPSRbbnkntwtCQTFZEHnnhPGqCQsQwQ
 QSkoBQWgseQNLtjfw5zxUzhZNWB8Roa3icYJTCD+BilPgLOMyBLG7XeCUtJ9U0ccRv1g
 wF6f7noq95GsOGOzSQTRHqfzEPhadG/lVC6iCslrSnjvZOVHHIRHVpLRN43AghMvYztr
 O5vNnxnDt/ikNkH5ej0Nil5dYYOkaKHSTzgtM8MrgarfvJOcFrnsGqlcB+N3CyhBtRnd
 oGhNUgS3BOlKn3yTzou30SOVgZPR5yDKtHGhnb4ambivrwml2hL617PGJuS+1c6zdn5R
 k3ZA==
X-Gm-Message-State: AOJu0Yxph8q0vcOzBINywFIYUrDrNSiEHADEyw4u/EWiXcZwNZItbR76
 XQG0U4bEsVg3QsE6j+gxyBMwToc750lFIS+xM8QD3CyV7HUa4bzzZ2LFEpU+L5DmUYXJvCJ5Nz9
 FGqIol5I=
X-Gm-Gg: ASbGncsiEmmM+ApD5VsgvIpK2VZRuiaUuREfjm2IfuAsGsw1+rgCHWv/Ph5le6DQVZ7
 MDT7nnQ6XJN50YFuBSw8j1fYrXLV+U3yoP/zkh3AZZxXNiMni15j1v5dTeWAHoB0mKoqQVKIjTq
 KxCLDqbqQ16uaL1Ot1GSukNYvWRfNvvW00TLNZ0kLfzKE0Xkvkgz4ypi0+GHbfmrtMDcp+LxjVB
 fVHDdspPGrXCVNVclQWHzOPAICnoPYDHoQ6ldPlrlXf8PNtfgdjdisxfw+2IkoigS8OqL/i1DWA
 EyL97dXi/+82mZqA4+yxApiHbuOGv5l8e9e0cUkpAID6uoQAP09ES32wtPOiu1nRhaYLDlDthsW
 ZsnsxuV+u8oUqjiMp5EJ7fnKkmHFjqxHZ6Y7k
X-Google-Smtp-Source: AGHT+IGNZFkPaHTPJDUhFjuMOCrJnQFaBlhmdbEJRaqBlewPL/lCBAF/3lsCb993NRdqAZM7xbINcQ==
X-Received: by 2002:a05:6000:bd1:b0:3a4:ce5c:5e8d with SMTP id
 ffacd0b85a97d-3a6d27ec99emr2413057f8f.20.1750439726208; 
 Fri, 20 Jun 2025 10:15:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45366b4d0adsm20630235e9.14.2025.06.20.10.15.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 21/48] accel/hvf: Replace @dirty field by generic
 @hwaccel_synchronized
Date: Fri, 20 Jun 2025 19:13:14 +0200
Message-ID: <20250620171342.92678-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
index d774e58df91..8df0085b9d4 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -60,7 +60,6 @@ struct AccelCPUState {
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
-    bool dirty;
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index bfdfef7c397..78bf0ac6cba 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -207,15 +207,15 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (cpu->hwaccel_synchronized) {
         hvf_get_registers(cpu);
-        cpu->accel->dirty = true;
+        cpu->hwaccel_synchronized = false;
     }
 }
 
 static void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (cpu->hwaccel_synchronized) {
         run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -224,7 +224,7 @@ static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
     /* QEMU state is the reference, push it to HVF now and on next entry */
-    cpu->accel->dirty = true;
+    cpu->hwaccel_synchronized = false;
 }
 
 static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
@@ -420,8 +420,8 @@ static int hvf_init_vcpu(CPUState *cpu)
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
-    cpu->accel->dirty = true;
     assert_hvf_ok(r);
+    cpu->hwaccel_synchronized = false;
 
     cpu->accel->guest_debug_enabled = false;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 48ce83eb8fc..3907ea8791e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -814,9 +814,9 @@ int hvf_put_registers(CPUState *cpu)
 
 static void flush_cpu_state(CPUState *cpu)
 {
-    if (cpu->accel->dirty) {
+    if (!cpu->hwaccel_synchronized) {
         hvf_put_registers(cpu);
-        cpu->accel->dirty = false;
+        cpu->hwaccel_synchronized = true;
     }
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index bcf30662bec..d0000db0299 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -738,9 +738,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->accel->dirty) {
+        if (!cpu->hwaccel_synchronized) {
             hvf_put_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->hwaccel_synchronized = true;
         }
 
         if (hvf_inject_interrupts(cpu)) {
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 2057314892a..1c3d03eafe2 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -427,7 +427,7 @@ int hvf_process_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cs->accel->dirty) {
+    if (cs->hwaccel_synchronized) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
-- 
2.49.0


