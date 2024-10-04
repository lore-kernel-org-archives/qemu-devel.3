Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FE2CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJ2-0003iU-RL; Fri, 04 Oct 2024 12:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlH2-0008Q6-6H
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGy-0006St-W5
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Setl3AJEVs0vHNQj7xHFFLMsRz7zXPg367b8l0cBJ90=;
 b=KYf9zxYYjXy6B8rKwx/UP+elyqfawLD7xFKmOTP3lMEi6tvQWrcB6HyaFd4gPIJ9rTF5KE
 5j6CkIZ9/3KwYJ0JiF503cWQn9Kz3PK8upKn58VGxu+x5lKSMajUjbLMTQOjaCGKYuW15n
 GdC9e4sMPcAxS4Nd2g3f89pbICS/JWA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-4vL_DBguPh-braosBtRBbA-1; Fri, 04 Oct 2024 12:35:19 -0400
X-MC-Unique: 4vL_DBguPh-braosBtRBbA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d002fb48fso1065906f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059717; x=1728664517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Setl3AJEVs0vHNQj7xHFFLMsRz7zXPg367b8l0cBJ90=;
 b=f35s0x2GNKU6PDtpSb0LMzzSollIIaD0Uh1bseN51hRtm6nONYfj1yDEsGOUOkxJta
 mMMUz6RWbiq00LEgWbMgPV+Cy7UgvU2g7PCdoI2efsA8b+DnEuvxyUQmhcxaEv4R+I47
 Roqv+UZ5gQiJySdPPbHCNiKEL1SB7Q1wKg00nX2wKop3/HVxyXOfQM5RFy66zjZWzaA2
 O7Fpkwi795TgsTix9uMeHb2LfR5/+7ojQgQvJKA2ndGKhNga8eAZhFBbfg/k276FqnL0
 r5vIa1Wxk5Sm4LLHz+hyochHO1h5q1ph6ei6BBuRn2cDcYOEhRuwOu2ggihbnMhf/X9x
 sLGg==
X-Gm-Message-State: AOJu0YwgeZZorj+21TuB+Ns4NplSDRDUvvRjvB4fG1ieWncr2c8HsZw0
 q0iPcTrsErAd86Xu1hoagxCWYonIPCsZc3IxKFZ/BEgU5v52pZK+uB1P9tCyhFTOeUdUnEqQM25
 IpuMPaVMqdEp8SiJHxUyB4wHOQVw2PltkpIFJT0ybZnwYSGr/iIqRhknyA4p2eVKo+oQwsM+i7v
 j/xyg7q+U73WxuOELuSzEEX05km+blra1Zds/FYAM=
X-Received: by 2002:a5d:61d2:0:b0:37c:c9b9:3732 with SMTP id
 ffacd0b85a97d-37d0e748d0bmr2071635f8f.21.1728059717589; 
 Fri, 04 Oct 2024 09:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxPhRqM9+Ss3iSXEHgauXPy5dtYAUhUYxZwRTzfRL/212X9bkUoLbQ28Fw52eqX790RAYQfg==
X-Received: by 2002:a5d:61d2:0:b0:37c:c9b9:3732 with SMTP id
 ffacd0b85a97d-37d0e748d0bmr2071617f8f.21.1728059717095; 
 Fri, 04 Oct 2024 09:35:17 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691a56dsm37118f8f.41.2024.10.04.09.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 19/23] kvm: Allow kvm_arch_get/put_registers to accept Error**
Date: Fri,  4 Oct 2024 18:34:11 +0200
Message-ID: <20241004163415.951106-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Julia Suvorova <jusual@redhat.com>

This is necessary to provide discernible error messages to the caller.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240927104743.218468-2-jusual@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h       |  4 ++--
 accel/kvm/kvm-all.c        | 41 +++++++++++++++++++++++++++++---------
 target/arm/kvm.c           |  4 ++--
 target/i386/kvm/kvm.c      |  4 ++--
 target/loongarch/kvm/kvm.c |  4 ++--
 target/mips/kvm.c          |  4 ++--
 target/ppc/kvm.c           |  4 ++--
 target/riscv/kvm/kvm-cpu.c |  4 ++--
 target/s390x/kvm/kvm.c     |  4 ++--
 9 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 613d3f7581f..c3a60b28909 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -359,7 +359,7 @@ int kvm_arch_handle_exit(CPUState *cpu, struct kvm_run *run);
 
 int kvm_arch_process_async_events(CPUState *cpu);
 
-int kvm_arch_get_registers(CPUState *cpu);
+int kvm_arch_get_registers(CPUState *cpu, Error **errp);
 
 /* state subset only touched by the VCPU itself during runtime */
 #define KVM_PUT_RUNTIME_STATE   1
@@ -368,7 +368,7 @@ int kvm_arch_get_registers(CPUState *cpu);
 /* full state set, modified during initialization or on vmload */
 #define KVM_PUT_FULL_STATE      3
 
-int kvm_arch_put_registers(CPUState *cpu, int level);
+int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp);
 
 int kvm_arch_get_default_type(MachineState *ms);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e57492fda5c..905fb844e46 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2793,9 +2793,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
-        int ret = kvm_arch_get_registers(cpu);
+        Error *err = NULL;
+        int ret = kvm_arch_get_registers(cpu, &err);
         if (ret) {
-            error_report("Failed to get registers: %s", strerror(-ret));
+            if (err) {
+                error_reportf_err(err, "Failed to synchronize CPU state: ");
+            } else {
+                error_report("Failed to get registers: %s", strerror(-ret));
+            }
+
             cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
@@ -2813,9 +2819,15 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
-    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE);
+    Error *err = NULL;
+    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE, &err);
     if (ret) {
-        error_report("Failed to put registers after reset: %s", strerror(-ret));
+        if (err) {
+            error_reportf_err(err, "Restoring resisters after reset: ");
+        } else {
+            error_report("Failed to put registers after reset: %s",
+                         strerror(-ret));
+        }
         cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
@@ -2830,9 +2842,15 @@ void kvm_cpu_synchronize_post_reset(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
-    int ret = kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE);
+    Error *err = NULL;
+    int ret = kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE, &err);
     if (ret) {
-        error_report("Failed to put registers after init: %s", strerror(-ret));
+        if (err) {
+            error_reportf_err(err, "Putting registers after init: ");
+        } else {
+            error_report("Failed to put registers after init: %s",
+                         strerror(-ret));
+        }
         exit(1);
     }
 
@@ -3022,10 +3040,15 @@ int kvm_cpu_exec(CPUState *cpu)
         MemTxAttrs attrs;
 
         if (cpu->vcpu_dirty) {
-            ret = kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
+            Error *err = NULL;
+            ret = kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE, &err);
             if (ret) {
-                error_report("Failed to put registers after init: %s",
-                             strerror(-ret));
+                if (err) {
+                    error_reportf_err(err, "Putting registers after init: ");
+                } else {
+                    error_report("Failed to put registers after init: %s",
+                                 strerror(-ret));
+                }
                 ret = -1;
                 break;
             }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 849e2e21b30..f1f1b5b375a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2042,7 +2042,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level)
+int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2226,7 +2226,7 @@ static int kvm_arch_get_sve(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs)
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7a1f2bda767..0b03fb0577f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5210,7 +5210,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cpu, int level)
+int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     int ret;
@@ -5298,7 +5298,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs)
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4786cd5efa4..30ec16025d4 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -588,7 +588,7 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
     return ret;
 }
 
-int kvm_arch_get_registers(CPUState *cs)
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     int ret;
 
@@ -616,7 +616,7 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level)
+int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     int ret;
 
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index a631ab544f5..a98798c6691 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1172,7 +1172,7 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
     return ret;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level)
+int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     CPUMIPSState *env = cpu_env(cs);
     struct kvm_regs regs;
@@ -1207,7 +1207,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     return ret;
 }
 
-int kvm_arch_get_registers(CPUState *cs)
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     CPUMIPSState *env = cpu_env(cs);
     int ret = 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 907dba60d1b..3efc28f18b3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -900,7 +900,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_SREGS, &sregs);
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level)
+int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
@@ -1205,7 +1205,7 @@ static int kvmppc_get_books_sregs(PowerPCCPU *cpu)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs)
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f6e3156b8d2..2bfb112be08 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1192,7 +1192,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-int kvm_arch_get_registers(CPUState *cs)
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     int ret = 0;
 
@@ -1237,7 +1237,7 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level)
+int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     int ret = 0;
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 94181d9281f..8ffe0159d82 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -472,7 +472,7 @@ static int can_sync_regs(CPUState *cs, int regs)
 #define KVM_SYNC_REQUIRED_REGS (KVM_SYNC_GPRS | KVM_SYNC_ACRS | \
                                 KVM_SYNC_CRS | KVM_SYNC_PREFIX)
 
-int kvm_arch_put_registers(CPUState *cs, int level)
+int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     CPUS390XState *env = cpu_env(cs);
     struct kvm_fpu fpu = {};
@@ -598,7 +598,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs)
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     CPUS390XState *env = cpu_env(cs);
     struct kvm_fpu fpu;
-- 
2.46.1


