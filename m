Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35EFCD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyAA-0005jw-9p; Fri, 29 May 2026 10:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyA7-0005cD-EB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyA4-00031i-3X
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so8459860f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064767; x=1780669567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLjO9ILLNjldGaO/XRaKWcElj66Y6w+X8KhGj9XwuEI=;
 b=LdvTD9EUhEJClq2sa8qPAILPlweWo3aU5S8Vi7JVLNKxoe1BYEK8Vo554HWTlkE8ry
 9B4qOrjtXvR8nUhzzZQ9J4NfFRVZkGl3u3TZLXr2uChrJypeP+w4FOWA8Ppu1SbmnKpL
 uiqtT+qXfi6CJXSBNhNudVGsVxzMaTGTh3RTBO+8uRJxOtE2nG2/KoK8yfuUxWDy6cGF
 PUBYwWB+DK9G9OYn+/7dt6cKJeAfdNTcNC5LiKBIAXJGrPUPjDiKXFO44k2liUg9jn+g
 V2CIaE79G5yt6UBKIx4RuGI1PnJjYo1IyhUX45t847aTIVoXIkjzlpNzauuUTe5KxwUs
 J9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064767; x=1780669567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lLjO9ILLNjldGaO/XRaKWcElj66Y6w+X8KhGj9XwuEI=;
 b=sLTyFpEEjOvWnL3NCQMcCXtDL5Ap9FrJ6zgx+6b6Jf7NxCWwTl2KXH6SKXFA+qytEc
 XjZFACFPntFUzRE1Kqdp2CubipqcZVbH9+dBIDukeYGnQtVenydoSxHcNRxQFto5gWN7
 7dlcoXRj5R78iHTUL9TBMdXz7sDj6d11O+2WhEswXOB2LPkRiuzbPw2WPQ71NyxQnJeh
 n6Av7QsSgKwnQI1RaPr/9NCGSoWJQXJpCdsTcy7MKVFjAY3HeJQaLBmgXUDEijMi4VTO
 ATzZYgq1InYV0ruxgofz18AUnstjHG9Ug0COvwRBAiNDA7XARPUYj7Sq+XWlV67FhmBm
 EZqA==
X-Gm-Message-State: AOJu0YyJqwHWD8OVi6+VBQ5/AuNYOXhGG1qukE9SkuXALN+gB6y6Hor2
 TuPkjVr0At7amNyXo/sUiX2yDDsv9j5lCHw3iB1vxlQ0wq+q/3clOm3zjyL+wHHKC4YPnQY3ofs
 nx0914liK3g==
X-Gm-Gg: Acq92OHJ9bvnKRPP8ood+0NVSUawyUQ5ruZNTzbHEFNwUulNu8tg8Jh5vVlC/ipopc1
 /adbDhdryiDDavV/+pVbVDDBdHKn7TSl4fpFb9cYl5nNR3JJdFTIMUnbTVXIwNqN4Ky49IcODrh
 BgCn7xYM4UA0ztJ/YTgtb+RXv9JTqZqpy2obEy03fqhXZIh+2mrBaiRJ2zTto47JU4HL+nrGRBK
 sgm+XObpGO/82yudzCQtQpguUYLojqQn7RZ3A8T1kBHLNQ664Uebu16EQVYC6gSij3+N22EzZq5
 TGt+Rw2ZzhqCr/YkHS2NivD0trhUyUO01aGp2Tyq3S/D6OzaGOrCjmlyN6/VST+SQ+wV4rwiinm
 EbYt64jQ/uzqXzs6vPZjQHWV3LGcxod/N0vtGW352DNsh6R/DIcFyBhc2z1VRqqofe0FWlgc50Y
 NCXvHnDyv3lqkGpk1jUgial1SKMChIeHy4bTLs9A5bZNQRi2ZcVLLv2xan9lE1rBobSQ==
X-Received: by 2002:adf:f2d1:0:b0:45e:f354:8603 with SMTP id
 ffacd0b85a97d-45ef6b6d51cmr4895f8f.22.1780064766603; 
 Fri, 29 May 2026 07:26:06 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3587072sm4066115f8f.34.2026.05.29.07.26.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:26:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/17] accel/tcg: Convert AccelCPUClass -> new
 TCGCPUOps::cpu_instance_init
Date: Fri, 29 May 2026 16:24:27 +0200
Message-ID: <20260529142434.87880-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce a TCGCPUOps::cpu_instance_init hook and call it with
tcg_cpu_instance_init(). Register tcg_cpu_instance_init() as
AccelOpsClass::cpu_instance_init.

At the same time, convert X86 and RISCV AccelCPUClass hooks,
after forward-declaring each target method (to avoid moving
code around).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.h   | 1 +
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cpu-exec.c        | 9 +++++++++
 accel/tcg/tcg-accel-ops.c   | 1 +
 target/i386/tcg/tcg-cpu.c   | 5 +++--
 target/riscv/tcg/tcg-cpu.c  | 4 +++-
 6 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index aecce605d7b..be712c02efd 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,6 +14,7 @@
 
 #include "system/cpus.h"
 
+void tcg_cpu_instance_init(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5950cdcaab1..d7d329e419d 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -48,6 +48,7 @@ struct TCGCPUOps {
      * Called when the first CPU is realized.
      */
     void (*initialize)(void);
+    void (*cpu_instance_init)(CPUState *cpu);
     /**
      * @translate_code: Translate guest instructions to TCGOps
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..ef44c12b601 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1045,6 +1045,15 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
+void tcg_cpu_instance_init(CPUState *cpu)
+{
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+    if (tcg_ops->cpu_instance_init) {
+        tcg_ops->cpu_instance_init(cpu);
+    }
+}
+
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3bd98005042..381f1614923 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -219,6 +219,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
         }
     }
 
+    ops->cpu_instance_init = tcg_cpu_instance_init;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..04bb9787575 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -157,6 +157,8 @@ static vaddr x86_pointer_wrap(CPUState *cs, int mmu_idx,
 }
 #endif
 
+static void x86_tcg_cpu_instance_init(CPUState *cs);
+
 const TCGCPUOps x86_tcg_ops = {
     .mttcg_supported = true,
     .precise_smc = true,
@@ -165,6 +167,7 @@ const TCGCPUOps x86_tcg_ops = {
      */
     .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
     .initialize = tcg_x86_init,
+    .cpu_instance_init = x86_tcg_cpu_instance_init,
     .translate_code = x86_translate_code,
     .get_tb_cpu_state = x86_get_tb_cpu_state,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
@@ -237,8 +240,6 @@ static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 #ifndef CONFIG_USER_ONLY
     acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
-
-    acc->cpu_instance_init = x86_tcg_cpu_instance_init;
 }
 static const TypeInfo x86_tcg_cpu_accel_type_info = {
     .name = ACCEL_CPU_NAME("tcg"),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e22e7ed53d..703c2d9bd0a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,11 +268,14 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
 }
 #endif
 
+static void riscv_tcg_cpu_instance_init(CPUState *cs);
+
 const TCGCPUOps riscv_tcg_ops = {
     .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
+    .cpu_instance_init = riscv_tcg_cpu_instance_init,
     .translate_code = riscv_translate_code,
     .get_tb_cpu_state = riscv_get_tb_cpu_state,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
@@ -1678,7 +1681,6 @@ static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_instance_init = riscv_tcg_cpu_instance_init;
     acc->cpu_target_realize = riscv_tcg_cpu_realize;
 }
 
-- 
2.53.0


