Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F0FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 04:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6LSk-0007I0-E7; Wed, 08 Oct 2025 00:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LSf-0007G9-SF
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:07:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LSc-0005ri-90
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:07:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so1730801f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 21:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759896448; x=1760501248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38kffkV2lErlC3uVWR4z9asPuoou/DTgCFhX2fGUa90=;
 b=P08/tuJcyRNKnowx6J4jHdByv0z13LfZqAeDmzxxXesv9Gd+WIuOpW9Hf5S93TwHH4
 FyaNPkOKXEqsq8SVh+Cx9mns0z6SZ0226E5HZnS51Ilm9+ubAvdpHWTNbrZENJmckSwn
 EiRp3Rm+FiU7L5XuHhon9feYIiGsAp+tF4YBMzMC936WX0FF80jPlMBjB6++we7Yfnic
 mFwfa0O3FsvUjUes0wXu83IqQJ4dRLajWFOzJr4naPXp3l3P/WwQ/3VTOTnUYx7YeHpb
 V7Vkif2TWDklgne7vCgzdmx/xsxomTTYsPNKjQB9hfBEE66NK15ziddscXFttnn3Fz/0
 AWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759896448; x=1760501248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38kffkV2lErlC3uVWR4z9asPuoou/DTgCFhX2fGUa90=;
 b=Hdn0llSBuda4KZh2N8QPuf3h+QOGMJLnvIRGnzCVO1hGhsfV3wS6W/GG9RhGb6kHFK
 /lDx7kIJ6cF/TVzb46pE82SwymJyHNmN8nwJRtDCzoKDcuYS2sl3xSS7odhdLsTCATYS
 AhNtvnq3l2VQmrZnSFJW0XKFOY53QXYIg5i0lJFrumfYlQfQANJoS3Hzr78aZgTdFiFj
 MnDNmN8+/6k3noqm5Q+wj7K6C6p3Th19Zk8ihYpuIgm1RL3FKhb6phgJSAnTxuMEiMc1
 XWsaoDCj67W5hWaipX+EErZaKK1YysQ+fw8SbsD767cS9t4HEq7I1w93WRaUP2ZGmzdE
 u2Pg==
X-Gm-Message-State: AOJu0YySmjriRlfQ4cKRkLC0n7JpcUH5+KxHC+cBXv1IAywkbF4Hjqux
 i+5GPoUshUuvCrJuypVjP5KIYfqwygMlLI6pEDL/RkWepYsdOJaUTQ+ru2WbjJC1aK+8vcsSIQB
 nniMmH7tOig==
X-Gm-Gg: ASbGncstwNhZgoG2oUTkgzyWA2816NHNN1M7tgQuSXDXPTt6rh7S3L9TjnUfrPy8Ok/
 ey1mAa7Qrp9idxQvDlELqObB1MnQGVs8jyVU+gxRCzTXqvC9gEGrIlJYjd02hqFyOg7MTa645+/
 p9tkXK3lF8yMRY+J/LbmzGxfaos3UxQMhzRq7aP7fmAcS2J0Yq5ZtQyZIHlagJpy5RywGSAEQwd
 0RY/joVSL9tQ5o9i52gPQWIDRCUAxXnPX5gY6UO76LquGsPf9aI++ffoyg/Xxpm/oIzA5C1s99F
 CP9DLOK8UMMI/wGcu13TpDb1ODmbAd8Ptv9u7KT/RnfOuEMyxtUPP47NNq1zFffXk+Vn5BgR9cv
 7MzXs9VBVFCXDMsVyFIOO2hvq1ixOASwNEcVA+Ucb+uaRQNjb1c2z+3o8BgVVGrvpsIcZe9xZR0
 IPvaqaImPZaDo/T3umTNRqikVz
X-Google-Smtp-Source: AGHT+IEjireXPYDFN5r5KL8SDKpNkPNM5DCX9kjzg8yEWglxLdmj8M2IlvqnxmQ39KU5FQlqPqmuOg==
X-Received: by 2002:a05:6000:2c0c:b0:3e0:a5a2:ec9b with SMTP id
 ffacd0b85a97d-4266e8dd3b6mr1013001f8f.52.1759896448280; 
 Tue, 07 Oct 2025 21:07:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8fdsm27584189f8f.15.2025.10.07.21.07.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 21:07:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/3] accel/kvm: Introduce KvmPutState enum
Date: Wed,  8 Oct 2025 06:07:13 +0200
Message-ID: <20251008040715.81513-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008040715.81513-1-philmd@linaro.org>
References: <20251008040715.81513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Join the 3 KVM_PUT_*_STATE definitions in a single enum.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/system/kvm.h       | 16 +++++++++-------
 target/i386/kvm/kvm.c      |  6 +++---
 target/loongarch/kvm/kvm.c |  4 ++--
 target/mips/kvm.c          |  6 +++---
 target/ppc/kvm.c           |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/s390x/kvm/kvm.c     |  2 +-
 7 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 4fc09e38910..8f9eecf044c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -340,14 +340,16 @@ int kvm_arch_process_async_events(CPUState *cpu);
 
 int kvm_arch_get_registers(CPUState *cpu, Error **errp);
 
-/* state subset only touched by the VCPU itself during runtime */
-#define KVM_PUT_RUNTIME_STATE   1
-/* state subset modified during VCPU reset */
-#define KVM_PUT_RESET_STATE     2
-/* full state set, modified during initialization or on vmload */
-#define KVM_PUT_FULL_STATE      3
+typedef enum kvm_put_state {
+    /* state subset only touched by the VCPU itself during runtime */
+    KVM_PUT_RUNTIME_STATE = 1,
+    /* state subset modified during VCPU reset */
+    KVM_PUT_RESET_STATE = 2,
+    /* full state set, modified during initialization or on vmload */
+    KVM_PUT_FULL_STATE = 3,
+} KvmPutState;
 
-int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp);
+int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 
 int kvm_arch_get_default_type(MachineState *ms);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6a3a1c1ed8e..d06f55938cd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3911,7 +3911,7 @@ static void kvm_init_msrs(X86CPU *cpu)
     assert(kvm_buf_set_msrs(cpu) == 0);
 }
 
-static int kvm_put_msrs(X86CPU *cpu, int level)
+static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
 {
     CPUX86State *env = &cpu->env;
     int i;
@@ -5031,7 +5031,7 @@ static int kvm_get_apic(X86CPU *cpu)
     return 0;
 }
 
-static int kvm_put_vcpu_events(X86CPU *cpu, int level)
+static int kvm_put_vcpu_events(X86CPU *cpu, KvmPutState level)
 {
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
@@ -5274,7 +5274,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 45292edcb1c..32cd7c5d003 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -325,7 +325,7 @@ static int kvm_loongarch_get_csr(CPUState *cs)
     return ret;
 }
 
-static int kvm_loongarch_put_csr(CPUState *cs, int level)
+static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 {
     int ret = 0;
     CPULoongArchState *env = cpu_env(cs);
@@ -763,7 +763,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret;
     static int once;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 450947c3fa5..912cd5dfa0e 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -590,7 +590,7 @@ static void kvm_mips_update_state(void *opaque, bool running, RunState state)
     }
 }
 
-static int kvm_mips_put_fpu_registers(CPUState *cs, int level)
+static int kvm_mips_put_fpu_registers(CPUState *cs, KvmPutState level)
 {
     CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
@@ -749,7 +749,7 @@ static int kvm_mips_get_fpu_registers(CPUState *cs)
 }
 
 
-static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
+static int kvm_mips_put_cp0_registers(CPUState *cs, KvmPutState level)
 {
     CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
@@ -1177,7 +1177,7 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     CPUMIPSState *env = cpu_env(cs);
     struct kvm_regs regs;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2521ff65c6c..cd60893a17d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -907,7 +907,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_SREGS, &sregs);
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 187c2c9501e..75ca3fb9fd9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1369,7 +1369,7 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret = 0;
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 491cc5f9756..916dac1f14e 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -468,7 +468,7 @@ static int can_sync_regs(CPUState *cs, int regs)
 #define KVM_SYNC_REQUIRED_REGS (KVM_SYNC_GPRS | KVM_SYNC_ACRS | \
                                 KVM_SYNC_CRS | KVM_SYNC_PREFIX)
 
-int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     CPUS390XState *env = cpu_env(cs);
     struct kvm_fpu fpu = {};
-- 
2.51.0


