Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B57EC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeIL-00066a-J9; Mon, 26 Feb 2024 11:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeI5-0005j7-9L
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:26 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHl-0007ep-3x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412a3901eaaso10334815e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966616; x=1709571416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDjjTqMhYKHCzkLVMWR5TnRDxMdOCstiIUzTCMYj9VU=;
 b=Z2Drx/rKXrIUAxTxA783obOFNzzdGp1cj+U/tlxfJolWFUIuKqEg99ivYCsLxOJx5V
 PsN8om2PxAcSC5KWMzGpyliipTHQJ2o+59s4eWMssGO1vMUBkukSsqRyknXWxnTqbH6o
 3gxPS6Gxjb1jSauNDWF46dSpzB3eenWFBSZXyBCWUQsh3HVSj/Zek4E7FPvTDaQ47GO0
 Uj2My5inLuckhIuD5htkN//035/kGpmvjDvHAJ2k6nJWp3fwkHBZIZhvi9MQEF+9Offi
 dXVbq4oTHoo+uG/L9U6kY7XhFXmuCcOu1vMcVR54c0rk/IAqLwU5DGOK8mZACvFCWhHC
 pOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966616; x=1709571416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDjjTqMhYKHCzkLVMWR5TnRDxMdOCstiIUzTCMYj9VU=;
 b=bbzWP4cTrRiicpUNuag3lck7TOA+F4ToS34VmEfRfD/UszFqpgfzj87nDa/4cp9OMw
 7oMCRDwjGcyhCra3yuUPWgE8qHqZp2DXIfEDX21DVw+phquMya9c9LVVEsCxskXcG5hx
 RUADXvXrn4N8eOzIWMCF11M8Ht4oaPLdS1U9ASotz7jBKFW7QOzpFaJCsdjuWRLRj8Vd
 YaaCfqkYDc5x7XPejiz7XVT1/NxWlGPa593uKNp326wDGcMtGNDJSvYRVg4mH9kP/NAj
 NZPCBHSetoR6jKccRdy5UmVpC0xLSdxdxCnpfy3aE9CoqaHURjJvjdcGLRYOQjNVhaLN
 /K5w==
X-Gm-Message-State: AOJu0Yyo2x4bfXjMTtec8fLUjvLZSxjPu5KLVRLF7euyNuwdE4Pkt5+N
 OeK4h0VUbJI68F15Qo5EkowVs692u8y1Pf0SR8Vv4Ah+nhQG3OjoIjns83lHKEs=
X-Google-Smtp-Source: AGHT+IHwhtEhBqyRnZQ77L3F8uR0g10M2nnrUcX5OANQdbUczNr6cQiebVaVqoTpER8Ncb0If85XWg==
X-Received: by 2002:a05:6000:402c:b0:33d:b2dd:7585 with SMTP id
 cp44-20020a056000402c00b0033db2dd7585mr7142942wrb.9.1708966616499; 
 Mon, 26 Feb 2024 08:56:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ch12-20020a5d5d0c000000b0033dabeacab2sm8827549wrb.39.2024.02.26.08.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 08:56:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C14E45F911;
 Mon, 26 Feb 2024 16:56:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 10/27] gdbstub: Infer number of core registers from XML
Date: Mon, 26 Feb 2024 16:56:29 +0000
Message-Id: <20240226165646.425600-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226165646.425600-1-alex.bennee@linaro.org>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDBFeature has the num_regs member so use it where applicable to
remove magic numbers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240103173349.398526-34-alex.bennee@linaro.org>
Message-Id: <20231213-gdb-v17-8-777047380591@daynix.com>
[AJB: remove core reg check from microblaze read reg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/cpu.h       | 3 ++-
 target/s390x/cpu.h          | 2 --
 gdbstub/gdbstub.c           | 5 ++++-
 target/arm/cpu.c            | 1 -
 target/arm/cpu64.c          | 1 -
 target/avr/cpu.c            | 1 -
 target/hexagon/cpu.c        | 1 -
 target/i386/cpu.c           | 2 --
 target/loongarch/cpu.c      | 2 --
 target/m68k/cpu.c           | 1 -
 target/microblaze/cpu.c     | 1 -
 target/microblaze/gdbstub.c | 5 -----
 target/riscv/cpu.c          | 1 -
 target/rx/cpu.c             | 1 -
 target/s390x/cpu.c          | 1 -
 15 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4385ce54c99..1bbf21b2201 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -126,7 +126,8 @@ struct SysemuCPUOps;
  * @gdb_adjust_breakpoint: Callback for adjusting the address of a
  *       breakpoint.  Used by AVR to handle a gdb mis-feature with
  *       its Harvard architecture split code and data.
- * @gdb_num_core_regs: Number of core registers accessible to GDB.
+ * @gdb_num_core_regs: Number of core registers accessible to GDB or 0 to infer
+ *                     from @gdb_core_xml_file.
  * @gdb_core_xml_file: File name for core registers GDB XML description.
  * @gdb_stop_before_watchpoint: Indicates whether GDB expects the CPU to stop
  *           before the insn which triggers a watchpoint rather than after it.
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d37a49b4d92..43a46a5a068 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -491,8 +491,6 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 #define S390_R13_REGNUM 15
 #define S390_R14_REGNUM 16
 #define S390_R15_REGNUM 17
-/* Total Core Registers. */
-#define S390_NUM_CORE_REGS 18
 
 static inline void setcc(S390CPU *cpu, uint64_t cc)
 {
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index d573f808d2e..f766ee277a0 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -546,9 +546,12 @@ void gdb_init_cpu(CPUState *cpu)
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
+        cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
     }
 
-    cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
+    if (cc->gdb_num_core_regs) {
+        cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
+    }
 }
 
 void gdb_register_coprocessor(CPUState *cpu,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5fa86bc8d55..84887084d95 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2515,7 +2515,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
-    cc->gdb_num_core_regs = 26;
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8e30a7993ea..869d8dd24ee 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -793,7 +793,6 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
-    cc->gdb_num_core_regs = 34;
     cc->gdb_core_xml_file = "aarch64-core.xml";
     cc->gdb_arch_name = aarch64_gdb_arch_name;
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a40f445af21..a50170bc69a 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -251,7 +251,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = avr_cpu_gdb_read_register;
     cc->gdb_write_register = avr_cpu_gdb_write_register;
     cc->gdb_adjust_breakpoint = avr_cpu_gdb_adjust_breakpoint;
-    cc->gdb_num_core_regs = 35;
     cc->gdb_core_xml_file = "avr-cpu.xml";
     cc->tcg_ops = &avr_tcg_ops;
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index ebe804e2931..a10d87b8220 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -362,7 +362,6 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
     cc->get_pc = hexagon_cpu_get_pc;
     cc->gdb_read_register = hexagon_gdb_read_register;
     cc->gdb_write_register = hexagon_gdb_write_register;
-    cc->gdb_num_core_regs = TOTAL_PER_THREAD_REGS;
     cc->gdb_stop_before_watchpoint = true;
     cc->gdb_core_xml_file = "hexagon-core.xml";
     cc->disas_set_info = hexagon_cpu_disas_set_info;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7f908236767..733254fab57 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7990,10 +7990,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->gdb_arch_name = x86_gdb_arch_name;
 #ifdef TARGET_X86_64
     cc->gdb_core_xml_file = "i386-64bit.xml";
-    cc->gdb_num_core_regs = 66;
 #else
     cc->gdb_core_xml_file = "i386-32bit.xml";
-    cc->gdb_num_core_regs = 50;
 #endif
     cc->disas_set_info = x86_disas_set_info;
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7dc50bf35fc..bc2684179f2 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -815,7 +815,6 @@ static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
 {
     CPUClass *cc = CPU_CLASS(c);
 
-    cc->gdb_num_core_regs = 35;
     cc->gdb_core_xml_file = "loongarch-base32.xml";
     cc->gdb_arch_name = loongarch32_gdb_arch_name;
 }
@@ -829,7 +828,6 @@ static void loongarch64_cpu_class_init(ObjectClass *c, void *data)
 {
     CPUClass *cc = CPU_CLASS(c);
 
-    cc->gdb_num_core_regs = 35;
     cc->gdb_core_xml_file = "loongarch-base64.xml";
     cc->gdb_arch_name = loongarch64_gdb_arch_name;
 }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d5a71c63152..cc6e4537be5 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -570,7 +570,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 #endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
 
-    cc->gdb_num_core_regs = 18;
     cc->tcg_ops = &m68k_tcg_ops;
 }
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 2c62cf048c2..e533e7a95ec 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -444,7 +444,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->sysemu_ops = &mb_sysemu_ops;
 #endif
     device_class_set_props(dc, mb_properties);
-    cc->gdb_num_core_regs = 32 + 25;
     cc->gdb_core_xml_file = "microblaze-core.xml";
 
     cc->disas_set_info = mb_disas_set_info;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 6ffc5ad0752..eb168d10070 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -49,14 +49,9 @@ enum {
 int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUMBState *env = &cpu->env;
     uint32_t val;
 
-    if (n > cc->gdb_num_core_regs) {
-        return 0;
-    }
-
     switch (n) {
     case 1 ... 31:
         val = env->regs[n];
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b62e269b90..dd8a0e94897 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2352,7 +2352,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     cc->get_pc = riscv_cpu_get_pc;
     cc->gdb_read_register = riscv_cpu_gdb_read_register;
     cc->gdb_write_register = riscv_cpu_gdb_write_register;
-    cc->gdb_num_core_regs = 33;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 5205167da17..2f878d08d6d 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -221,7 +221,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
     cc->gdb_write_register = rx_cpu_gdb_write_register;
     cc->disas_set_info = rx_cpu_disas_set_info;
 
-    cc->gdb_num_core_regs = 26;
     cc->gdb_core_xml_file = "rx-core.xml";
     cc->tcg_ops = &rx_tcg_ops;
 }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 49a2341accf..f7194534aeb 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -368,7 +368,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     s390_cpu_class_init_sysemu(cc);
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
-    cc->gdb_num_core_regs = S390_NUM_CORE_REGS;
     cc->gdb_core_xml_file = "s390x-core64.xml";
     cc->gdb_arch_name = s390_gdb_arch_name;
 
-- 
2.39.2


