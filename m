Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3A3C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnS-00067M-GV; Tue, 23 Apr 2024 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnC-0004k7-JG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn5-0000HT-Ue
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCkmC6ncCGmLWzxoAtaq5Snlwv3A65GyFxL+8nGOz4o=;
 b=TAll4TfK7JwibBR5L+Fx7yIye8C0cAFHc/OnhHru4CHDfPpqudsbeYxLJz4roN9cT820MB
 Ry1P3u4AUc3i5CBsac+2ks5FYIC3XB0wOS1giqUq4gjsswSs4FwAo28Oo1u/u0/ub7xTPv
 3n4q4l8I0C513cqGewlAvPnV7d/GtJU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-jKSQq2GYM7OyRB-YIXV3gw-1; Tue, 23 Apr 2024 11:10:35 -0400
X-MC-Unique: jKSQq2GYM7OyRB-YIXV3gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E01541827101;
 Tue, 23 Apr 2024 15:10:34 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53F41203397D;
 Tue, 23 Apr 2024 15:10:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/63] KVM: remove kvm_arch_cpu_check_are_resettable
Date: Tue, 23 Apr 2024 17:09:29 +0200
Message-ID: <20240423150951.41600-42-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Board reset requires writing a fresh CPU state.  As far as KVM is
concerned, the only thing that blocks reset is that CPU state is
encrypted; therefore, kvm_cpus_are_resettable() can simply check
if that is the case.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h       | 10 ----------
 accel/kvm/kvm-accel-ops.c  |  2 +-
 accel/kvm/kvm-all.c        |  5 -----
 target/arm/kvm.c           |  5 -----
 target/i386/kvm/kvm.c      |  5 -----
 target/loongarch/kvm/kvm.c |  5 -----
 target/mips/kvm.c          |  5 -----
 target/ppc/kvm.c           |  5 -----
 target/riscv/kvm/kvm-cpu.c |  5 -----
 target/s390x/kvm/kvm.c     |  5 -----
 10 files changed, 1 insertion(+), 51 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 14b1ddb3be1..bd247f3a239 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -525,16 +525,6 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 /* Notify resamplefd for EOI of specific interrupts. */
 void kvm_resample_fd_notify(int gsi);
 
-/**
- * kvm_cpu_check_are_resettable - return whether CPUs can be reset
- *
- * Returns: true: CPUs are resettable
- *          false: CPUs are not resettable
- */
-bool kvm_cpu_check_are_resettable(void);
-
-bool kvm_arch_cpu_check_are_resettable(void);
-
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index f5ac643fca3..94c828ac8da 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -82,7 +82,7 @@ static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
 
 static bool kvm_cpus_are_resettable(void)
 {
-    return !kvm_enabled() || kvm_cpu_check_are_resettable();
+    return !kvm_enabled() || !kvm_state->guest_state_protected;
 }
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d6ebadbf386..5a2fbee32a3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2696,11 +2696,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
     s->coalesced_flush_in_progress = false;
 }
 
-bool kvm_cpu_check_are_resettable(void)
-{
-    return kvm_arch_cpu_check_are_resettable();
-}
-
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ab85d628a8b..21ebbf3b8f8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1598,11 +1598,6 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return (data - 32) & 0xffff;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 static void kvm_arch_get_eager_split_size(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e554075185b..7922edfae8e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5619,11 +5619,6 @@ bool kvm_has_waitpkg(void)
     return has_msr_umwait;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return !sev_es_enabled();
-}
-
 #define ARCH_REQ_XCOMP_GUEST_PERM       0x1025
 
 void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask)
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d630cc39cb2..8224d943331 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -733,11 +733,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
     return true;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 6c52e59f55d..a631ab544f5 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1273,11 +1273,6 @@ int kvm_arch_get_default_type(MachineState *machine)
     return -1;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8231feb2d45..63930d4a77d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2956,11 +2956,6 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
     }
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80f..49d2f3ad58c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1475,11 +1475,6 @@ void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
     }
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 static int aia_mode;
 
 static const char *kvm_aia_mode_str(uint64_t mode)
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4ce809c5d46..4dcd757cdcc 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2622,11 +2622,6 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
     kvm_s390_vcpu_interrupt(cpu, &irq);
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 int kvm_s390_get_zpci_op(void)
 {
     return cap_zpci_op;
-- 
2.44.0



