Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106D4C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNhP-0006MF-Bz; Mon, 27 Jan 2025 06:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhN-0006L8-S1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:37 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhL-0006ph-6v
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso27833005e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978873; x=1738583673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sZoopH8al3/3onc9yLxoFWuzvX6JEuGgczZIUbC+S4=;
 b=abIzd0B60RSfWdG/DHBbanvWN1kf9hY0GLO9GakUEkZMWDWL5/9SxvtZa+gVKzN/B7
 02fFc8llIecH4V/cF6v+Cvn77cNMkIIH3dcPJNzh4mpuhYf3tZHrgnzTo+iu0HdteN0u
 1xqpwzJmE9+wDL9Szgu+lsqffmnVx/6fS1XXrwQZqKIz00O0uXYcgPxPgousZmH1uFpo
 LFy9uGdM+q74VeTK470KcyK+egv/NA23KXfLGZ+FzqiGDU18Yk48BQMy9xHYEd3OPINx
 R1BBGYESZaE2VqIUglmvvtEoZ/14S9Xk4EEF2wrs730iAlR9jB9U4guBEkjQcQEXDR5G
 tkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978873; x=1738583673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7sZoopH8al3/3onc9yLxoFWuzvX6JEuGgczZIUbC+S4=;
 b=r5wCf9gvgx+aXz/x3mV1kdHI6n63E3DPQQicFX8BwyF+AVV2Ck/pYfb6BQoHLQS3x5
 YG7yPAU9G0q+/6mMse7Ej/xLjQbpfx9NCaF/5c3kcODkTIJuLDhTDpLPWmFcRo8zpxWb
 vNraKGWZYItIB5fNxsZTSgZE+qqjmkimUc5IK+U7IkebRzDZiWJXSUrIqWOa2Y9wi6gh
 bM2V7qnT75MKyVFHma/jmKx2r0PpclUIJ3uwbPxNXLtejjzfYJHINLa3IhnJ22EUmFkz
 9dSR5QkReOC0mthfQbSzKu3/p/+we4H0V/DeZhg/1MF0HDE8NpG5408QuQc02DsOpZX4
 NL+w==
X-Gm-Message-State: AOJu0YzVlrrScUAfLHaku9Al3oz5mjeWksBGfT6kRHzru52IIlCWBI4L
 pfcvyZuSNZyrpE0Nk8CF7qjvQQCx/9aY1YKNeU9j5OOeJ4yCBpX8nMDu4M1/uCTq5LDp7h005j2
 E33k=
X-Gm-Gg: ASbGnctpOtdnT6b8fzCkPYfmiQ57pIJYu5QS2IcUTSFy7BTKqRn+218dp8ButbYvGzM
 P5rQaZMaGrgIYt3j9/lNcc7IoQLINRsyl5ANhdd3XHaNPMrvzb9/AZZc9eSLqhxDWCpYvw7BDP8
 n0RW4WKR41hAe9FpZzwbawyi/Y/YGOj/MHNu+S/rXLZ0a4dzaOV0EOemIQMMrjzIEDTikHP93m9
 xqYQF6+MJpGPzruJV4a442YliLmuiya9t2Zj5DWmamp+OP+1BX/rTc81lJmVLOLpdwoRNvcIh1A
 DUNdOp3Kd1zh0q8nLw1x1YBv1LXQ+lLi4ilnG9zFRBlAXnDow3h1VXw=
X-Google-Smtp-Source: AGHT+IHxUZ8h05DGJm8h13ii6qJuyU/lf3cQ1mrWJMYlEb5HIf8MszFsdlUHfKEAQHHpau+bDefSZA==
X-Received: by 2002:a5d:588f:0:b0:385:e961:6589 with SMTP id
 ffacd0b85a97d-38bf565f8b9mr33866086f8f.20.1737978873298; 
 Mon, 27 Jan 2025 03:54:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bbd93sm10882117f8f.76.2025.01.27.03.54.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:54:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/10] target: Set disassemble_info::endian value for
 little-endian targets
Date: Mon, 27 Jan 2025 12:54:17 +0100
Message-ID: <20250127115426.51355-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field for little-endian targets.

Note, there was no disas_set_info() handler registered
for the TriCore target, so we implement one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.c     | 1 +
 target/avr/cpu.c       | 1 +
 target/hexagon/cpu.c   | 1 +
 target/i386/cpu.c      | 1 +
 target/loongarch/cpu.c | 1 +
 target/rx/cpu.c        | 1 +
 target/tricore/cpu.c   | 6 ++++++
 7 files changed, 12 insertions(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index da21f99a6ac..acf81fda371 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -85,6 +85,7 @@ static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
 
 static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_alpha_ev6;
     info->print_insn = print_insn_alpha;
 }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 5a0e21465e5..2871d30540a 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -102,6 +102,7 @@ static void avr_cpu_reset_hold(Object *obj, ResetType type)
 
 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_arch_avr;
     info->print_insn = avr_print_insn;
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 238e63bcea4..a9beb9a1757 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -293,6 +293,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     info->print_insn = print_insn_hexagon;
+    info->endian = BFD_ENDIAN_LITTLE;
 }
 
 static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b9c11022c4..eecb6f54d9e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8343,6 +8343,7 @@ static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = (env->hflags & HF_CS64_MASK ? bfd_mach_x86_64
                   : env->hflags & HF_CS32_MASK ? bfd_mach_i386_i386
                   : bfd_mach_i386_i8086);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 227870e2856..cb9b9f909f3 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -617,6 +617,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 
 static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->print_insn = print_insn_loongarch;
 }
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index d237d007023..f283315474c 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -160,6 +160,7 @@ static void rx_cpu_set_irq(void *opaque, int no, int request)
 
 static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_rx;
     info->print_insn = print_insn_rx;
 }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index eb794674c8d..49c18a0cd92 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -35,6 +35,11 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
     return "tricore";
 }
 
+static void tricore_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    info->endian = BFD_ENDIAN_LITTLE;
+}
+
 static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 {
     cpu_env(cs)->PC = value & ~(target_ulong)1;
@@ -201,6 +206,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_num_core_regs = 44;
     cc->gdb_arch_name = tricore_gdb_arch_name;
 
+    cc->disas_set_info = tricore_cpu_disas_set_info;
     cc->dump_state = tricore_cpu_dump_state;
     cc->set_pc = tricore_cpu_set_pc;
     cc->get_pc = tricore_cpu_get_pc;
-- 
2.47.1


