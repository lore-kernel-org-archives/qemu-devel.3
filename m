Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F63ACF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCSH-00047B-4r; Mon, 30 Sep 2024 05:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCS7-0003NJ-5F
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:25 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCS5-0004fk-D2
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so4486685e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687539; x=1728292339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b77I1JPh4FFui3m8ARcyeS7xVA2tnhUm1eKsfIObl9M=;
 b=PdNt4p/RdUVDbUtNy0KaPTGMBnjdXXJuB8xM8vil4//+bNgExELSuC/Qw1b3UMwwvC
 Z8IqTQUfNp73c1jD6lGaUU29vTIClLijH0c9Zoz/O4iPzuK/tCjP4oEeZZicXyu/IyT1
 wByZ+xCtxNSi5dQ4PKJ5Q3VonlgoGK562gyxRkhD38R7X10O3+yvGzHOcHC6OSoZJZfy
 y9Vjwgx4y1O7YzmTElyIgsqp0VEppqs9ovIXl6OIwDnDgEOss+7Hn+FER+M93jzZwAFN
 TYn6seKVSR/121tLHKJIOLmygbMxfuKKPEXqyD+HCyNpRjo2e6pRIEuOaxWwAKOLIxkp
 7ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687539; x=1728292339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b77I1JPh4FFui3m8ARcyeS7xVA2tnhUm1eKsfIObl9M=;
 b=K0npIrWfUU01EroetKwb0TCwFECVIyzGwPoOp5A8Q42PSSKzD1GoQeNEUepOJCdNyQ
 9FpIC62xWI8g1yEWgq3JY+rHvMo86T5zAZwklXvuQDCO9j/uaVh7ld+daduoBKERWrKa
 lUR+O+Z5Hq+i4Uq1gc2PQD39hgPRISTVVCiNRDSLUUU9nwFtecm4dSIzxuE/t40K5nLF
 hN+/VcUbyZHIZ7HW4lZ6nBdjFuGsXG5/n0PDF7TT0kiZ1oF3QOptsURLyLvZeYx6OqVA
 6Csj1KpyLhfMWHbwST8PFqPFyfCQcjwatbklgWZjLpM6f4zZQ4yU6yuTsJP+sKrzxclD
 Bj+A==
X-Gm-Message-State: AOJu0Yw3W33IIqsUUMkpe61qGmI813LVx+KoSeXRju9SscXtA/fu9Ie2
 U84exW9j66+6LTv7kEFKmcXhuQYrGv4chmuWGo/tCEz3OQt9V7VVIUssYsuLAjcWVkvY7w/DzNX
 c
X-Google-Smtp-Source: AGHT+IFwxcPXPCcwzJxfDAGB6L56t56fLXhjD9Oy/3J9Aq658n/SIKQz75HLX0iq+yh/L4uBikgyNg==
X-Received: by 2002:a05:600c:3b8c:b0:42c:be90:fa1b with SMTP id
 5b1f17b1804b1-42f584335f0mr86822345e9.14.1727687538838; 
 Mon, 30 Sep 2024 02:12:18 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd565de3asm8524894f8f.29.2024.09.30.02.12.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:12:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 10/12] hw/mips: Have mips_cpu_create_with_clock() take an
 endianness argument
Date: Mon, 30 Sep 2024 11:10:59 +0200
Message-ID: <20240930091101.40591-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

mips_cpu_create_with_clock() creates a vCPU. Pass it the vCPU
endianness requested by argument. Update the board call sites.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h        | 4 +++-
 hw/mips/fuloong2e.c      | 2 +-
 hw/mips/jazz.c           | 2 +-
 hw/mips/loongson3_virt.c | 2 +-
 hw/mips/malta.c          | 3 ++-
 hw/mips/mipssim.c        | 2 +-
 target/mips/cpu.c        | 5 ++++-
 7 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 070e11fe0d..a4a46ebbe9 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1376,12 +1376,14 @@ static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
  * mips_cpu_create_with_clock:
  * @typename: a MIPS CPU type.
  * @cpu_refclk: this cpu input clock (an output clock of another device)
+ * @is_big_endian: whether this CPU is configured in big endianness
  *
  * Instantiates a MIPS CPU, set the input clock of the CPU to @cpu_refclk,
  * then realizes the CPU.
  *
  * Returns: A #CPUState or %NULL if an error occurred.
  */
-MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk);
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
+                                    bool is_big_endian);
 
 #endif /* MIPS_CPU_H */
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 4fe5108845..50a3f06723 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -230,7 +230,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 0d44e19707..812e8cbcab 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -212,7 +212,7 @@ static void mips_jazz_init(MachineState *machine,
                          * ext_clk[jazz_model].pll_mult);
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, TARGET_BIG_ENDIAN);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 2067b4fecb..25fa94ee68 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -567,7 +567,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         int ip;
 
         /* init CPUs */
-        cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+        cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index a0757f251a..71cc11fc45 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1035,7 +1035,8 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
     int i;
 
     for (i = 0; i < ms->smp.cpus; i++) {
-        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk);
+        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk,
+                                         TARGET_BIG_ENDIAN);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 9170d6c474..80b4a2c00d 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -160,7 +160,7 @@ mips_mipssim_init(MachineState *machine)
 #endif
 
     /* Init CPUs. */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, TARGET_BIG_ENDIAN);
     env = &cpu->env;
 
     reset_info = g_new0(ResetData, 1);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 982f5bb4e2..02e2e72f2d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -646,12 +646,15 @@ static void mips_cpu_register_types(void)
 type_init(mips_cpu_register_types)
 
 /* Could be used by generic CPU object */
-MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
+                                    bool is_big_endian)
 {
     DeviceState *cpu;
 
     cpu = DEVICE(object_new(cpu_type));
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
+    object_property_set_bool(OBJECT(cpu), "big-endian", is_big_endian,
+                             &error_abort);
     qdev_realize(cpu, NULL, &error_abort);
 
     return MIPS_CPU(cpu);
-- 
2.45.2


