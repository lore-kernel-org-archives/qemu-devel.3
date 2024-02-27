Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0546C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyhT-0006nB-FT; Tue, 27 Feb 2024 09:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reyhC-0006JS-ES
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygP-00023J-Eg
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:37 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so2785401f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045027; x=1709649827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjr9OC5Xz6b+rRWzYWkX5eP3RARDFcB2hEKUoICFAA0=;
 b=ZyGLX7496vyRzpt0A/YHZBx5xnYIxTQIqWpvfpa8AdSyB7ca3Gg7wcUw6sw48Uw0lc
 5BSQBtuX+H37PIuUEAft9nm0ZnhqAHViBAEMvIMzRfTpald63EX9bjNIu83IsMnjrH/m
 PpOPKWvdyYwKPrBJlJ/Jl/NO0tlRH0FsSRAQn3zmDDb863sRNDQ0luAu+6TaBIcRPCHx
 IRRqk9HKszMPdW/xg4X3kQzkSywuiulf7Z+VewJC0LZloD/jCzKmQS8sL+c4ccvmoWok
 0glYTLuY7MZ29HsfnNipI3aPbQiBGrzwDqFugx8RKCcxo62f3W/IaCEiv4dK4uMVdS4P
 6Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045027; x=1709649827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjr9OC5Xz6b+rRWzYWkX5eP3RARDFcB2hEKUoICFAA0=;
 b=LFfICGA8+lH7wPsEaHZ3WRlldrAd3dyPe5Dg+f5BdAbobAJfSP2NW2O+l7fwfUVFF/
 aOrXH39TSTGe86RlAAwz+5gA4mGgCz6py+BczY3HMSCJ8pgIat0/hA2nwdWuUc4gECmb
 WwU7M/XVgDJ02fIilWK6oU8Ozorw7q0zZbmmV4taWvWiSwipVw0VWdl4qzCtWJl8mRIC
 ah/oB6j3K/3do2rechwTEG33gCoIVEtSXHwH3l8kU2wh6dUQ3YAYoelNaDykRw96QmcS
 2cgIKAXSagE7TeukgVF5s8nyxMZ9dN6SrM0hESZjr7n4bwzOzCIopylA2Up2HVkPXTjZ
 9Wag==
X-Gm-Message-State: AOJu0YygC3JpR6p0h91WyWbZgzkhlDAq+DxwrRmu+ftu0RH/j0TJcOYo
 jCMs7UFholbyhzlOE+WblEUnqHhxvnjTsgZT7jkgJmmuCiBGcI22lNTUXFwpGcQ=
X-Google-Smtp-Source: AGHT+IESLBVX+ktxSUQ/3q2aKkB7lIJ0OJy6ptFNC27eZm8bcNa9A5fGpTzqfk0ya5km35cqo5I82Q==
X-Received: by 2002:adf:ec8d:0:b0:33d:f457:ab55 with SMTP id
 z13-20020adfec8d000000b0033df457ab55mr1099685wrn.52.1709045027198; 
 Tue, 27 Feb 2024 06:43:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bu25-20020a056000079900b0033d8a17a710sm11921316wrb.88.2024.02.27.06.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 351805F904;
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
Subject: [PATCH v4 08/29] gdbstub: Use GDBFeature for gdb_register_coprocessor
Date: Tue, 27 Feb 2024 14:43:14 +0000
Message-Id: <20240227144335.1196131-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

This is a tree-wide change to introduce GDBFeature parameter to
gdb_register_coprocessor(). The new parameter just replaces num_regs
and xml parameters for now. GDBFeature will be utilized to simplify XML
lookup in a following change.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240103173349.398526-30-alex.bennee@linaro.org>
Message-Id: <20231213-gdb-v17-4-777047380591@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h     |  2 +-
 gdbstub/gdbstub.c          | 13 +++++++------
 target/arm/gdbstub.c       | 35 +++++++++++++++++++----------------
 target/hexagon/cpu.c       |  3 +--
 target/loongarch/gdbstub.c |  2 +-
 target/m68k/helper.c       |  6 +++---
 target/microblaze/cpu.c    |  5 +++--
 target/ppc/gdbstub.c       | 11 ++++++-----
 target/riscv/gdbstub.c     | 20 ++++++++++++--------
 target/s390x/gdbstub.c     | 28 +++++++---------------------
 10 files changed, 60 insertions(+), 65 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index d8a3c56fa2b..ac6fce99a64 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -38,7 +38,7 @@ typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
  */
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
-                              int num_regs, const char *xml, int g_pos);
+                              const GDBFeature *feature, int g_pos);
 
 /**
  * gdbserver_start: start the gdb server
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7e73e916bdc..256599c8dfb 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -544,7 +544,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
-                              int num_regs, const char *xml, int g_pos)
+                              const GDBFeature *feature, int g_pos)
 {
     GDBRegisterState *s;
     guint i;
@@ -553,7 +553,7 @@ void gdb_register_coprocessor(CPUState *cpu,
         for (i = 0; i < cpu->gdb_regs->len; i++) {
             /* Check for duplicates.  */
             s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (strcmp(s->xml, xml) == 0) {
+            if (strcmp(s->xml, feature->xmlname) == 0) {
                 return;
             }
         }
@@ -565,17 +565,18 @@ void gdb_register_coprocessor(CPUState *cpu,
     g_array_set_size(cpu->gdb_regs, i + 1);
     s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
     s->base_reg = cpu->gdb_num_regs;
-    s->num_regs = num_regs;
+    s->num_regs = feature->num_regs;
     s->get_reg = get_reg;
     s->set_reg = set_reg;
-    s->xml = xml;
+    s->xml = feature->xml;
 
     /* Add to end of list.  */
-    cpu->gdb_num_regs += num_regs;
+    cpu->gdb_num_regs += feature->num_regs;
     if (g_pos) {
         if (g_pos != s->base_reg) {
             error_report("Error: Bad gdb register numbering for '%s', "
-                         "expected %d got %d", xml, g_pos, s->base_reg);
+                         "expected %d got %d", feature->xml,
+                         g_pos, s->base_reg);
         } else {
             cpu->gdb_num_g_regs = cpu->gdb_num_regs;
         }
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 5949adfb31a..f2b201d3125 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -483,14 +483,14 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          */
 #ifdef TARGET_AARCH64
         if (isar_feature_aa64_sve(&cpu->isar)) {
-            int nreg = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs)->num_regs;
+            GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
-                                     aarch64_gdb_set_sve_reg, nreg,
-                                     "sve-registers.xml", 0);
+                                     aarch64_gdb_set_sve_reg, feature, 0);
         } else {
             gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
                                      aarch64_gdb_set_fpu_reg,
-                                     34, "aarch64-fpu.xml", 0);
+                                     gdb_find_static_feature("aarch64-fpu.xml"),
+                                     0);
         }
         /*
          * Note that we report pauth information via the feature name
@@ -501,19 +501,22 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
         if (isar_feature_aa64_pauth(&cpu->isar)) {
             gdb_register_coprocessor(cs, aarch64_gdb_get_pauth_reg,
                                      aarch64_gdb_set_pauth_reg,
-                                     4, "aarch64-pauth.xml", 0);
+                                     gdb_find_static_feature("aarch64-pauth.xml"),
+                                     0);
         }
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
-                                     49, "arm-neon.xml", 0);
+                                     gdb_find_static_feature("arm-neon.xml"),
+                                     0);
         } else if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
-                                     33, "arm-vfp3.xml", 0);
+                                     gdb_find_static_feature("arm-vfp3.xml"),
+                                     0);
         } else if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
-                                     17, "arm-vfp.xml", 0);
+                                     gdb_find_static_feature("arm-vfp.xml"), 0);
         }
         if (!arm_feature(env, ARM_FEATURE_M)) {
             /*
@@ -521,29 +524,29 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
              * expose to gdb.
              */
             gdb_register_coprocessor(cs, vfp_gdb_get_sysreg, vfp_gdb_set_sysreg,
-                                     2, "arm-vfp-sysregs.xml", 0);
+                                     gdb_find_static_feature("arm-vfp-sysregs.xml"),
+                                     0);
         }
     }
     if (cpu_isar_feature(aa32_mve, cpu) && tcg_enabled()) {
         gdb_register_coprocessor(cs, mve_gdb_get_reg, mve_gdb_set_reg,
-                                 1, "arm-m-profile-mve.xml", 0);
+                                 gdb_find_static_feature("arm-m-profile-mve.xml"),
+                                 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_feature(cs, cs->gdb_num_regs)->num_regs,
-                             "system-registers.xml", 0);
+                             arm_gen_dynamic_sysreg_feature(cs, cs->gdb_num_regs),
+                             0);
 
 #ifdef CONFIG_TCG
     if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) {
         gdb_register_coprocessor(cs,
             arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
-            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_num_regs)->num_regs,
-            "arm-m-system.xml", 0);
+            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_num_regs), 0);
 #ifndef CONFIG_USER_ONLY
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             gdb_register_coprocessor(cs,
                 arm_gdb_get_m_secextreg, arm_gdb_set_m_secextreg,
-                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_num_regs)->num_regs,
-                "arm-m-secext.xml", 0);
+                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_num_regs), 0);
         }
 #endif
     }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 759ea62814d..ebe804e2931 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -319,8 +319,7 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 
     gdb_register_coprocessor(cs, hexagon_hvx_gdb_read_register,
                              hexagon_hvx_gdb_write_register,
-                             NUM_VREGS + NUM_QREGS,
-                             "hexagon-hvx.xml", 0);
+                             gdb_find_static_feature("hexagon-hvx.xml"), 0);
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 5fc2f19e965..843a869450e 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -118,5 +118,5 @@ static int loongarch_gdb_set_fpu(CPULoongArchState *env,
 void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
     gdb_register_coprocessor(cs, loongarch_gdb_get_fpu, loongarch_gdb_set_fpu,
-                             41, "loongarch-fpu.xml", 0);
+                             gdb_find_static_feature("loongarch-fpu.xml"), 0);
 }
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 14508dfa118..9808d676a22 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -112,10 +112,10 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
 
     if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
         gdb_register_coprocessor(cs, cf_fpu_gdb_get_reg, cf_fpu_gdb_set_reg,
-                                 11, "cf-fp.xml", 18);
+                                 gdb_find_static_feature("cf-fp.xml"), 18);
     } else if (m68k_feature(env, M68K_FEATURE_FPU)) {
-        gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg,
-                                 m68k_fpu_gdb_set_reg, 11, "m68k-fp.xml", 18);
+        gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg, m68k_fpu_gdb_set_reg,
+                                 gdb_find_static_feature("m68k-fp.xml"), 18);
     }
     /* TODO: Add [E]MAC registers.  */
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 2002231a6b4..2c62cf048c2 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -313,8 +313,9 @@ static void mb_cpu_initfn(Object *obj)
     CPUMBState *env = &cpu->env;
 
     gdb_register_coprocessor(CPU(cpu), mb_cpu_gdb_read_stack_protect,
-                             mb_cpu_gdb_write_stack_protect, 2,
-                             "microblaze-stack-protect.xml", 0);
+                             mb_cpu_gdb_write_stack_protect,
+                             gdb_find_static_feature("microblaze-stack-protect.xml"),
+                             0);
 
     set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
 
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index c4c55961083..625ccf96c5b 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -606,23 +606,24 @@ void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *pcc)
 {
     if (pcc->insns_flags & PPC_FLOAT) {
         gdb_register_coprocessor(cs, gdb_get_float_reg, gdb_set_float_reg,
-                                 33, "power-fpu.xml", 0);
+                                 gdb_find_static_feature("power-fpu.xml"), 0);
     }
     if (pcc->insns_flags & PPC_ALTIVEC) {
         gdb_register_coprocessor(cs, gdb_get_avr_reg, gdb_set_avr_reg,
-                                 34, "power-altivec.xml", 0);
+                                 gdb_find_static_feature("power-altivec.xml"),
+                                 0);
     }
     if (pcc->insns_flags & PPC_SPE) {
         gdb_register_coprocessor(cs, gdb_get_spe_reg, gdb_set_spe_reg,
-                                 34, "power-spe.xml", 0);
+                                 gdb_find_static_feature("power-spe.xml"), 0);
     }
     if (pcc->insns_flags2 & PPC2_VSX) {
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
-                                 32, "power-vsx.xml", 0);
+                                 gdb_find_static_feature("power-vsx.xml"), 0);
     }
 #ifndef CONFIG_USER_ONLY
     gdb_gen_spr_feature(cs);
     gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
-                             pcc->gdb_spr.num_regs, "power-spr.xml", 0);
+                             &pcc->gdb_spr, 0);
 #endif
 }
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index d8da84fa52e..ec1fc6a29da 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -311,28 +311,32 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     CPURISCVState *env = &cpu->env;
     if (env->misa_ext & RVD) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
-                                 32, "riscv-64bit-fpu.xml", 0);
+                                 gdb_find_static_feature("riscv-64bit-fpu.xml"),
+                                 0);
     } else if (env->misa_ext & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
-                                 32, "riscv-32bit-fpu.xml", 0);
+                                 gdb_find_static_feature("riscv-32bit-fpu.xml"),
+                                 0);
     }
     if (env->misa_ext & RVV) {
         gdb_register_coprocessor(cs, riscv_gdb_get_vector,
                                  riscv_gdb_set_vector,
-                                 ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs)->num_regs,
-                                 "riscv-vector.xml", 0);
+                                 ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs),
+                                 0);
     }
     switch (mcc->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
-                                 1, "riscv-32bit-virtual.xml", 0);
+                                 gdb_find_static_feature("riscv-32bit-virtual.xml"),
+                                 0);
         break;
     case MXL_RV64:
     case MXL_RV128:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
-                                 1, "riscv-64bit-virtual.xml", 0);
+                                 gdb_find_static_feature("riscv-64bit-virtual.xml"),
+                                 0);
         break;
     default:
         g_assert_not_reached();
@@ -340,7 +344,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 
     if (cpu->cfg.ext_zicsr) {
         gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                                 riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs)->num_regs,
-                                 "riscv-csr.xml", 0);
+                                 riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs),
+                                 0);
     }
 }
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index f02fa316e53..256f1c7c6db 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -67,8 +67,6 @@ int s390_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 /* the values represent the positions in s390-acr.xml */
 #define S390_A0_REGNUM 0
 #define S390_A15_REGNUM 15
-/* total number of registers in s390-acr.xml */
-#define S390_NUM_AC_REGS 16
 
 static int cpu_read_ac_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
@@ -96,8 +94,6 @@ static int cpu_write_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_FPC_REGNUM 0
 #define S390_F0_REGNUM 1
 #define S390_F15_REGNUM 16
-/* total number of registers in s390-fpr.xml */
-#define S390_NUM_FP_REGS 17
 
 static int cpu_read_fp_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
@@ -130,8 +126,6 @@ static int cpu_write_fp_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_V15L_REGNUM 15
 #define S390_V16_REGNUM 16
 #define S390_V31_REGNUM 31
-/* total number of registers in s390-vx.xml */
-#define S390_NUM_VREGS 32
 
 static int cpu_read_vreg(CPUS390XState *env, GByteArray *buf, int n)
 {
@@ -170,8 +164,6 @@ static int cpu_write_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* the values represent the positions in s390-cr.xml */
 #define S390_C0_REGNUM 0
 #define S390_C15_REGNUM 15
-/* total number of registers in s390-cr.xml */
-#define S390_NUM_C_REGS 16
 
 #ifndef CONFIG_USER_ONLY
 static int cpu_read_c_reg(CPUS390XState *env, GByteArray *buf, int n)
@@ -204,8 +196,6 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_VIRT_CPUTM_REGNUM  1
 #define S390_VIRT_BEA_REGNUM    2
 #define S390_VIRT_PREFIX_REGNUM 3
-/* total number of registers in s390-virt.xml */
-#define S390_NUM_VIRT_REGS 4
 
 static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
 {
@@ -252,8 +242,6 @@ static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_VIRT_KVM_PFT_REGNUM    1
 #define S390_VIRT_KVM_PFS_REGNUM    2
 #define S390_VIRT_KVM_PFC_REGNUM    3
-/* total number of registers in s390-virt-kvm.xml */
-#define S390_NUM_VIRT_KVM_REGS 4
 
 static int cpu_read_virt_kvm_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
 {
@@ -301,8 +289,6 @@ static int cpu_write_virt_kvm_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_GS_GSD_REGNUM      1
 #define S390_GS_GSSM_REGNUM     2
 #define S390_GS_GSEPLA_REGNUM   3
-/* total number of registers in s390-gs.xml */
-#define S390_NUM_GS_REGS 4
 
 static int cpu_read_gs_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
@@ -320,33 +306,33 @@ void s390_cpu_gdb_init(CPUState *cs)
 {
     gdb_register_coprocessor(cs, cpu_read_ac_reg,
                              cpu_write_ac_reg,
-                             S390_NUM_AC_REGS, "s390-acr.xml", 0);
+                             gdb_find_static_feature("s390-acr.xml"), 0);
 
     gdb_register_coprocessor(cs, cpu_read_fp_reg,
                              cpu_write_fp_reg,
-                             S390_NUM_FP_REGS, "s390-fpr.xml", 0);
+                             gdb_find_static_feature("s390-fpr.xml"), 0);
 
     gdb_register_coprocessor(cs, cpu_read_vreg,
                              cpu_write_vreg,
-                             S390_NUM_VREGS, "s390-vx.xml", 0);
+                             gdb_find_static_feature("s390-vx.xml"), 0);
 
     gdb_register_coprocessor(cs, cpu_read_gs_reg,
                              cpu_write_gs_reg,
-                             S390_NUM_GS_REGS, "s390-gs.xml", 0);
+                             gdb_find_static_feature("s390-gs.xml"), 0);
 
 #ifndef CONFIG_USER_ONLY
     gdb_register_coprocessor(cs, cpu_read_c_reg,
                              cpu_write_c_reg,
-                             S390_NUM_C_REGS, "s390-cr.xml", 0);
+                             gdb_find_static_feature("s390-cr.xml"), 0);
 
     gdb_register_coprocessor(cs, cpu_read_virt_reg,
                              cpu_write_virt_reg,
-                             S390_NUM_VIRT_REGS, "s390-virt.xml", 0);
+                             gdb_find_static_feature("s390-virt.xml"), 0);
 
     if (kvm_enabled()) {
         gdb_register_coprocessor(cs, cpu_read_virt_kvm_reg,
                                  cpu_write_virt_kvm_reg,
-                                 S390_NUM_VIRT_KVM_REGS, "s390-virt-kvm.xml",
+                                 gdb_find_static_feature("s390-virt-kvm.xml"),
                                  0);
     }
 #endif
-- 
2.39.2


