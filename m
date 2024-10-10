Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E9ED2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz15H-0004Kn-7T; Thu, 10 Oct 2024 17:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz15E-00042B-7d
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:52:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz15C-0004sC-Ho
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:52:32 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b49ee353cso12103605ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597149; x=1729201949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwCdSOYqDmyr07OGLbU3nyx0DMxm2R388CoaeBSWCr8=;
 b=uhlmVA3zYcjPrRUpQUfi2l39laKU+C6WgMfBzkI28PG5RWktCvcZyQ816pv9XqDiD5
 5huiaIm0U+YQymFHkBm4rdnQmTesOFoHDtXjFB2TwLBQICqIT95mGTc/IpDHr04CSjU9
 OkK4qanGaQ8ONP98wzU2K3ikmc1dh5R4KPz2PwYSwMlQ2sN6Boj9eMzlbtH6JQOX2eo+
 AOUn1YDOaIMahbEif2TjVjzvad47Bgb2TV4jEM93W1JNWnBrq1o1S8XyxN0yFb98gOiy
 G+AM7dZIwQl8SO8253+IAtNYIivnnzQfxbzvVoB+F3uDmk6MQHx5BayAZMAIySpXpB2T
 U2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597149; x=1729201949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwCdSOYqDmyr07OGLbU3nyx0DMxm2R388CoaeBSWCr8=;
 b=I4+jsVPmwOKi16tUCgnJXdlkEINiYeg6KA7frLGlWGbHGZ5K2DmwZZH2A1o6FMb/uY
 2uZ8xbWgBEkaVy45AWvF/HyGZH5115iGdUgQpx5c9gF2pzOyhtKg3hXubvioAb1l7zHe
 nk93g4igccT7HN/3xp5cdv4URlT/3fq1vD4sRAy9M9LqFwTA82/d9iO93Ef7sl0i/Jn1
 8WsC95fdgbrlqeDeTXw8Q5NgyR0KSW1m0icpwtxOaulsj8kstfWSiWhcfklyL3Vw2Hl0
 tP0s39nUN2QIdEmPDsUWojEuX9vzKI4KQ8t9UZo20JO5hccpT+BeaKzPEPdJ/woSsTt6
 ExTw==
X-Gm-Message-State: AOJu0Yy6d/K+WK0xTLyazmj7gRLqIF4i5+fSYXFITmXIld1A+aOJN1Ss
 7LzhfTy05uulVJK1Q85DzFs6B/zi3cpAhFvwkRj/8UO0RSRKDPfLhAr9sAHlUuqWRzO18BgDNF8
 5
X-Google-Smtp-Source: AGHT+IGc5rINJP4Jc+C1zvlo5KWFFvFaOTLjmK2uzDHLMHXJNnOz+3raom/zBETcPAoeGRqp9wVVzw==
X-Received: by 2002:a17:902:ce89:b0:205:5d12:3f24 with SMTP id
 d9443c01a7336-20ca14625femr4727595ad.20.1728597149078; 
 Thu, 10 Oct 2024 14:52:29 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bad341dsm13739105ad.44.2024.10.10.14.52.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:52:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 16/16] hw/mips: Have mips_cpu_create_with_clock() take an
 endianness argument
Date: Thu, 10 Oct 2024 18:50:14 -0300
Message-ID: <20241010215015.44326-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
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
index 070e11fe0da..a4a46ebbe98 100644
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
index 6e4303ba473..7fd8296ccb6 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -229,7 +229,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 33ce51fb09c..d6bc698ef17 100644
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
index a2db98665df..f3b6326cc59 100644
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
index 964d3592da7..198da5ba3d4 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1034,7 +1034,8 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
     int i;
 
     for (i = 0; i < ms->smp.cpus; i++) {
-        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk);
+        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk,
+                                         TARGET_BIG_ENDIAN);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index a07732d3dc5..54cdcd61724 100644
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
index 04bf4b11db2..9724e71a5e0 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -643,12 +643,15 @@ static void mips_cpu_register_types(void)
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


