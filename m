Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163EC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reygu-0005nE-4T; Tue, 27 Feb 2024 09:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygs-0005er-Qy
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygL-00021n-NN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412a9a61545so10577545e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045024; x=1709649824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDjjTqMhYKHCzkLVMWR5TnRDxMdOCstiIUzTCMYj9VU=;
 b=WKvCDqEj873VlxGMmasluT6QWjIlPX3Xe3u0B743mLkH4caWX6mLHD3D3nbngv7hXt
 DtR0B0bT3nbmJ687LGXjIaZGKk1BoDE1rvcaYVC+5vI/d5eENk+5FI5XsBWklBC2f9Ev
 45W9BJA3XxSMJvzgGzt+zwK8FlSA18m/7v0KpdTQXlTD82W7m56QBZmBrk4HiNlBrWNB
 fs6Q/XR8k2zvtuhSLCInRFTP7e60KnA8mWc2shsJK0nmIh/XsXwe4n5CSgs1wzjmfRg7
 oDZXiauxKOV91636Kc3X+TvJfJUM0QPaxFN8yP0BxEJePoD+949T/WoIKfmjI8GeTR/s
 LVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045024; x=1709649824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDjjTqMhYKHCzkLVMWR5TnRDxMdOCstiIUzTCMYj9VU=;
 b=mRjOApTizPVsNvqBGsIfQlLl9zlM+vBvHCQmIgKqq7IPo6RH7k6NGmCJc4QIJOGy0/
 +85yG+980ohtmzmVqmqlcAcWe/H9y3LapwLRlHjYiRJ8gMyx54UPTMvSEQMZBdxkx/Xp
 5DAdQhoTJHkASrZ8MtN2SmtwEs6WKU0SH+sHncjgjlrVVH36hBlNPU8b0DyDgGMCikYV
 cMkE/qDfXrUxoDA0BgHyK3qhhafI//0n8s/e52nEj3x25W1KHD29cJfycd7YFg7AcdtC
 W0lFgjVVfSea6anXNcxmWNmuVOqtmKbpTc4dG5XNSpBNTfCg8KhKnON6nXZGRu8tkwdK
 wSHQ==
X-Gm-Message-State: AOJu0Yw3hlKQUvaXb6pWzST/JJubrSKaIWosaH+8FzIBmeKCz8vLY2Pm
 Fo1B0JAnjUxJnPa7u25XmQ1Gq6Iv1iVDdfYwUpEsNrguTHFJM2XY6aFgKxJ1lL4=
X-Google-Smtp-Source: AGHT+IHsA5Bz/phvju6tzTpA7Td3fqaLqq/dwwrSnQInb9Zk43rrXTSyRsUGn9mWuS0Mk4ipHtX2zg==
X-Received: by 2002:a05:600c:5021:b0:412:a451:d32f with SMTP id
 n33-20020a05600c502100b00412a451d32fmr4837977wmr.20.1709045024263; 
 Tue, 27 Feb 2024 06:43:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y9-20020a7bcd89000000b00412706c3ddasm14924278wmj.18.2024.02.27.06.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADD4C5F8FC;
 Tue, 27 Feb 2024 14:43:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 12/29] gdbstub: Infer number of core registers from XML
Date: Tue, 27 Feb 2024 14:43:18 +0000
Message-Id: <20240227144335.1196131-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


