Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F4C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYZ7-0004og-OA; Fri, 23 Feb 2024 11:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYJe-00043k-P1
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:22:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYJO-00065B-EK
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:22:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4127190ad83so6971955e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705329; x=1709310129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkXiF54Supy42kUSUNwcrLqCaotpRPSpuKydB/cG2qA=;
 b=pdBnydNA1NsZZZJbrFRv5WddQ9V/jFd054FDk35YwVRz/hSoLw+4xArbVsBpE1o0qO
 g+E5AWPQnnNqR19hCExyMSTC5EhjQKe/dncq2wmuX0xai6oxtpBaATP26iVmtA35TNOy
 imNqUN2wH5g11m3z7mRBZsSSMP90kZqw1YVbaMHzlj85+hn7WiBUnZNBq+4LXwCNGVjE
 +7NdzesTM2M+dmnDMhYKLDY2Cpa/TIVqZ2TCxwzfUx8IW89O1fAanY8tD6GwTayERbWZ
 cMa4lsqlBeoK5NAfSaj+nWZgimXuw4tpnj3RUBiWRv6uNF+o95os11u6mxjR0Y7cBdm8
 pZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705329; x=1709310129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkXiF54Supy42kUSUNwcrLqCaotpRPSpuKydB/cG2qA=;
 b=FvgSPbPO5ZyPj1zjJ4SUfodc13yUecmw9rrMFQo5a6S3kAKJNEZ9YOUK1CBv1mkYzd
 FNhB1fp8i8KrLzKr4RKODTjtEcZnBWZLFDwukatQoYrFNomzmS6hMfRD7Mr+PQ6e/NSh
 ZVtTgXuIbl/Z4CvPbQeWytMWJdYHvfz9GbUL5i5vsrpQP5hkpVeN6+qrw4H3hWMbI78Y
 0jOIQByHiHlMnO4paylLFE9Pqsn4mjdow9n4gP+OhMKObmnhY4NZTlOnzx/k2XAOTbmk
 P1sPnbCrj6KH50k1cNZV/UOQw2F8lQElE2X1otz/SncbGv9Emoym8OlNUh5BSLzFL/w0
 yElw==
X-Gm-Message-State: AOJu0Yz1cOByAqafUSa7jz96S52ii35jtMMmlLxZF1nXICUieWB/PMiV
 mVUcG4VBahT5GP6iyJuqNnZ6UlwPQgo2KBMKMRHx6FeVneT4SHtq0eKMLINYcJI=
X-Google-Smtp-Source: AGHT+IFqatz0mGGAcRPYioyfvh6J117k3tX9mgW4cT11VmHiQRIql5s5GCxZzZnwdLH+eTWr9caVuQ==
X-Received: by 2002:a05:600c:4e87:b0:412:94a9:eaa8 with SMTP id
 f7-20020a05600c4e8700b0041294a9eaa8mr195488wmq.19.1708705328767; 
 Fri, 23 Feb 2024 08:22:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c468b00b004128812dcb6sm2976921wmo.28.2024.02.23.08.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:22:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 849975F92D;
 Fri, 23 Feb 2024 16:22:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 10/27] gdbstub: Infer number of core registers from XML
Date: Fri, 23 Feb 2024 16:21:45 +0000
Message-Id: <20240223162202.1936541-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223162202.1936541-1-alex.bennee@linaro.org>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index bca776e1fe9..f0ccad3bf98 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7981,10 +7981,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
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
index 8a8392e6945..e228a0b18b2 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -568,7 +568,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
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


