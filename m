Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CDBC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHid-0004jG-P4; Thu, 03 Jul 2025 07:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfZ-0006he-1F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHel-0003L7-IN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so4774132f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540345; x=1752145145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbpcjy4o5ZUQnpuXjuYjR5B0wNodIi5DdAoNAkyy2SM=;
 b=GQr4UVVZRwcbQ2nRqhl9BVjBPdKusMoE/izuzTVl/dZQiKCG3rYERe/xZNrs/2coS3
 8czvanN/RyxFb+cP51BzjNT6L1/+UxkbGL/exPsYbpl2FJRfaFixm5+nK/xOPO8W/fiW
 AfwU0guZa9T0YBZ+hhuaAUVGHEu59D08BBk0qKT53Rnf5vskWVcc1rpYOi4ZqRE13CWW
 50VWSuuCJgnVC9GpH0bI8aLblHq2gq9SExiv8DQ1o3AHxxRxHXqDE5f3Q8MENULCYRqA
 ogGs3+5xlVX/IesrCrq7JqZ9coi1w5/1xMiMcpBdrsiPND2Aqq9dtCqQ2a+OjyI8p2wI
 GTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540345; x=1752145145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbpcjy4o5ZUQnpuXjuYjR5B0wNodIi5DdAoNAkyy2SM=;
 b=TvUoTFNHx9J/8yUUREK7TyVnblU29aaMWbc1ASyY0NJm62dxSGNXcebwykFL5TzEI6
 MLy3JsAMxuIG97v7DzlAGlS1Zc/0IlWDaZebxnKBSjaAXXxVl6dawm71G4gqU10Psg4b
 DkYS1HqqYVzsR/AnC1gNCNE0jiP/vK12cN7vasUSi9z1xBYQiVzoj14bMZM9OspDpAgp
 1w1neR4UzDMczJ9g3QWZx9zYIXITaqb7o/EzYus2+hrRFUyYiyOwXfXPfOrlmXeLCTBl
 fHGy/gY6kwCqabedOarqeAL1BXtYkluLwu+ujRgbDgOnnQVpIfEkZBa2FZ+esIzLJN5i
 tKHQ==
X-Gm-Message-State: AOJu0YxF27Gan7lA+bgNXFF6LtXjV7aUm83w4o4hhPH5lcVp4B2g+FeL
 CsyG977/YlhCC0dk6qF8i3cHjQebzffFMxVpIlgB0n/rT0mASjKzrhUeujt8afMGogoZkf/h3bv
 +V32VrsA=
X-Gm-Gg: ASbGncu1MNAhR7u++16S2+tqYSV3OaJV7XP3GR63HVibfaYaP2qyLzqzuE4t1jSM5mK
 LBalhNd/sFPW7C9MZqpY+lUYWydpKV9aF0MoaYoyWsX6H6OnvCNqmoqkxSv65aQprYOGqPOYcR/
 aP6t1XxZ7vFG3KbX/4t1dakwzccnoZgAFT+itJj82qWEM25mZAycB/2rZDFP83sTb+mIwtv5wyk
 OR4bD9RO3r7n8prtjWljl0rML/S120UDP/BE4NVW19BEFRjl+WPG+oRkz5JX/p9ZRllX4bcvsdV
 nsuHxZ3EBdoFp0kbuVtQk3NYZ2L8hm1W7VhjW/vu08uFNEcxooKlBy7icz+ykBLNslAxeVwWFyL
 Qo41F3wIFQ9A=
X-Google-Smtp-Source: AGHT+IGYxtS1oEgE+wPV64Af3YSVbtZnoBNIR61h6tPaEQk84SaFj2CgxdVoLgHbVl+oBToAAhLlkA==
X-Received: by 2002:a5d:5f4e:0:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3b200b4673amr4801917f8f.41.1751540344516; 
 Thu, 03 Jul 2025 03:59:04 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3aba76e40c0sm14278820f8f.59.2025.07.03.03.59.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH v5 38/69] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 12:55:04 +0200
Message-ID: <20250703105540.67664-39-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index bd19a9f475d..44a831d004f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -813,9 +813,9 @@ int hvf_put_registers(CPUState *cpu)
 
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


