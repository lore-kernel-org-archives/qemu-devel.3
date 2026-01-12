Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805E1C9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHtq-0002zx-Fb; Mon, 12 Jan 2026 08:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtY-0002fO-5Y
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtW-0003hU-88
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdnbksSUGyPUrHjkY0R7TYIIf5kvOcbV2JSCja1oOlA=;
 b=QaJnWvIm42Q7zOzaBotThTGc4f20BIU2B74O0DCWIGFP1Ra/4fFbjZanWwhWG+GZY2XJWg
 Xd9xWRknIuPMzwP9I5I+1HTu+5Kcpyo8MdDHofg+3tfvofRscyOWcvVkmNPxs4Rmop3IBL
 e3InPyEHbm57O0Lemj7Cl8IDhFuaPzw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-m_B5IyrGMr6rc7yOH3AkYA-1; Mon, 12 Jan 2026 08:23:40 -0500
X-MC-Unique: m_B5IyrGMr6rc7yOH3AkYA-1
X-Mimecast-MFC-AGG-ID: m_B5IyrGMr6rc7yOH3AkYA_1768224219
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c52779e9e65so1797984a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224219; x=1768829019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdnbksSUGyPUrHjkY0R7TYIIf5kvOcbV2JSCja1oOlA=;
 b=gl1/NvOGVKf2ZNdqeyoqNY0w8mqEBpghM74kzBgchIRpklS5/qIY0HYKEmYnBJ1yTQ
 OAkP2QzO+znPyLbt1eSbp12vxTNgubCjhpzRzYq0dqtWl+vI9FYtnTeU8QnAOtSOCi32
 AmLEa2rPRHlgjjEIoZI93ySV/fRxB8Bo9a63ZiLo05C2FHR4vhvkT09ndUblRccm45bs
 25o7Psu6JqwmhdigqvkKlifCkuNB/T4fYfjlroIpoEAN6N2nsd/EuLa6fHzHKbHD5eTT
 RYOPpyQQtm9cjISxeZxEjSeK49U56mzAf9bEipZfw/W/FubY4sTZ3zWMjJq+kCtUA+KF
 WuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224219; x=1768829019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NdnbksSUGyPUrHjkY0R7TYIIf5kvOcbV2JSCja1oOlA=;
 b=M8yRU+SAuT4NSg9xMqmPTaspDO6nakzc7bOqarr39Iacbwmu1pHoiGl+9UuIIsDSbw
 wMNGuF2hDk6OdvWzgixjHNswxaFwFPxPamRVRtndmQt1435sBz5nTbdHzaThezSVQBJT
 yPlTAvDokOHtZN4RrcQiiGvyP39dIWgaRNT3exUowGH36SpjN1CbB9gCyiu4+Ubh2+Yn
 aXsgGnYL3o3TO1q2HvILZkaBFw9kzCV70hVHyWaJHrDznra80ZYxKNgde9mwOAWs0JHs
 XJl4xwfhk321rhRGXjvT2lJ6wbkXnOd+WlRHhfPl74fy3XhRn90/cVjF/KwKYH/S8AZM
 fsIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBcESZ8JgJVTeLyrIgFmJ1DEXy1fbeaWwuqqomadp06aFbn7w0GMlvO1hs3rPD+86VC+wg62ueCPRg@nongnu.org
X-Gm-Message-State: AOJu0YxYqHkE71UGhQHgSqfYRCEU7Xqagw4E7Td2N218lg7PmxM5BHzT
 chw9rrNiw6ZlRQ6xqQzx4IAG40hDwEg3PRM15q02LKSNSN3iA1WGgoLF/ZZim7L0E1Cj2P67U/o
 rdOwwirVByPS3+uSRzU/v5EDp6NafgGUxbvT3hfhtPOWEnwJx57zJJ0Ji
X-Gm-Gg: AY/fxX78Ozu82soSRF7oWE1Z8eyw/P/dVzzqqmD6PChNov14N1CJ3VyPxa3J9VaY1OU
 iCGhOjeXDXoRLpjn8vii/LdhKE3g+AQZuNz3g7Evy1XPD79enBvvn/zXl1RDiS0J0ZEeAsWRDEZ
 3kWQJnqi9GbNmzOphEG2TBcrtuztla2vR3yhI66sect/fStv1EVuofRK+pdE5SjIR204WT4sNOy
 bMU5gwaROXcum3wHcg7LBchZlPbz2XUuuT4+T3ebtdYjCOuRRNQ0ZtMim0YWFJe4hrOpN/n19w+
 lDDYc+/5dPbX1fdlt+b0M92LetIUhrIRMMawqyAS/lLNQ1ZgdYCQWoLI1XczlgTgvzBXa9U1VTM
 i6u7Ip9kzvq1uFdfB1C2oLFJY8+LQhHiLmeSuPqM56ks=
X-Received: by 2002:a05:6a20:4320:b0:371:5a31:e486 with SMTP id
 adf61e73a8af0-3898f8f5575mr16343788637.6.1768224219110; 
 Mon, 12 Jan 2026 05:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcv47eltF1dqyqoHkRdnfdwpRjEXwbJhJgpR2WonnKMpNVeugyliTsyRBpgsUG9mJ4idnyIg==
X-Received: by 2002:a05:6a20:4320:b0:371:5a31:e486 with SMTP id
 adf61e73a8af0-3898f8f5575mr16343740637.6.1768224218597; 
 Mon, 12 Jan 2026 05:23:38 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:38 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 04/32] accel/kvm: add changes required to support KVM VM
 file descriptor change
Date: Mon, 12 Jan 2026 18:52:17 +0530
Message-ID: <20260112132259.76855-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This change adds common kvm specific support to handle KVM VM file descriptor
change. KVM VM file descriptor can change as a part of confidential guest reset
mechanism. A new function api kvm_arch_vmfd_change_ops() per
architecture platform is added in order to implement architecture specific
changes required to support it. A subsequent patch will add x86 specific
implementation for kvm_arch_vmfd_change_ops as currently only x86 supports
confidential guest reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c        | 80 ++++++++++++++++++++++++++++++++++++--
 accel/kvm/trace-events     |  1 +
 include/system/kvm.h       |  2 +
 target/arm/kvm.c           | 10 +++++
 target/i386/kvm/kvm.c      | 10 +++++
 target/loongarch/kvm/kvm.c | 10 +++++
 target/mips/kvm.c          | 10 +++++
 target/ppc/kvm.c           | 10 +++++
 target/riscv/kvm/kvm-cpu.c | 10 +++++
 target/s390x/kvm/kvm.c     | 10 +++++
 10 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f85eb42d78..762f302551 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2415,11 +2415,9 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void kvm_irqchip_create(KVMState *s)
+static void do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
-
-    assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
         ;
     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
@@ -2452,7 +2450,13 @@ static void kvm_irqchip_create(KVMState *s)
         fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
         exit(1);
     }
+}
 
+static void kvm_irqchip_create(KVMState *s)
+{
+    assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
+
+    do_kvm_irqchip_create(s);
     kvm_kernel_irqchip = true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)
@@ -2607,6 +2611,75 @@ static int kvm_setup_dirty_ring(KVMState *s)
     return 0;
 }
 
+static int kvm_reset_vmfd(MachineState *ms)
+{
+    KVMState *s;
+    KVMMemoryListener *kml;
+    int ret = 0, type;
+    Error *err = NULL;
+
+    /*
+     * bail if the current architecture does not support VM file
+     * descriptor change.
+     */
+    if (!kvm_arch_supports_vmfd_change()) {
+        error_report("This target architecture does not support KVM VM "
+                     "file descriptor change.");
+        return -EOPNOTSUPP;
+    }
+
+    s = KVM_STATE(ms->accelerator);
+    kml = &s->memory_listener;
+
+    memory_listener_unregister(&kml->listener);
+    memory_listener_unregister(&kvm_io_listener);
+
+    if (s->vmfd >= 0) {
+        close(s->vmfd);
+    }
+
+    type = find_kvm_machine_type(ms);
+    if (type < 0) {
+        return -EINVAL;
+    }
+
+    ret = do_kvm_create_vm(s, type);
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->vmfd = ret;
+
+    kvm_setup_dirty_ring(s);
+
+    /* rebind memory to new vm fd */
+    ret = ram_block_rebind(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
+    ret = kvm_arch_vmfd_change_ops(ms, s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (s->kernel_irqchip_allowed) {
+        do_kvm_irqchip_create(s);
+    }
+
+    /* these can be only called after ram_block_rebind() */
+    memory_listener_register(&kml->listener, &address_space_memory);
+    memory_listener_register(&kvm_io_listener, &address_space_io);
+
+    /*
+     * kvm fd has changed. Commit the irq routes to KVM once more.
+     */
+    kvm_irqchip_commit_routes(s);
+    trace_kvm_reset_vmfd();
+    return ret;
+}
+
 static int kvm_init(AccelState *as, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -4014,6 +4087,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "KVM";
     ac->init_machine = kvm_init;
+    ac->reset_vmfd = kvm_reset_vmfd;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e43d18a869..e4beda0148 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -14,6 +14,7 @@ kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
 kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
 kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu %s"
 kvm_irqchip_commit_routes(void) ""
+kvm_reset_vmfd(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8f9eecf044..a5ab22421d 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -358,6 +358,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s);
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
+bool kvm_arch_supports_vmfd_change(void);
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s);
 
 #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
 void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 48f853fff8..10cd94a57d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1569,6 +1569,16 @@ void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
 
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 int kvm_arch_irqchip_create(KVMState *s)
 {
     if (kvm_kernel_irqchip_split()) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 3fdb2a3f62..6aa17cecba 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3253,6 +3253,16 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index ef3359ced9..9d5c73f3a3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1312,6 +1312,16 @@ int kvm_arch_irqchip_create(KVMState *s)
     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
 }
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index a85e162409..fbef498bd7 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -44,6 +44,16 @@ unsigned long kvm_arch_vcpu_id(CPUState *cs)
     return cs->cpu_index;
 }
 
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     /* MIPS has 128 signals */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3b2f1077da..7cdc0d09f4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -180,6 +180,16 @@ int kvm_arch_irqchip_create(KVMState *s)
     return 0;
 }
 
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 static int kvm_arch_sync_sregs(PowerPCCPU *cpu)
 {
     CPUPPCState *cenv = &cpu->env;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5d792563b9..548ea3aeab 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1545,6 +1545,16 @@ int kvm_arch_irqchip_create(KVMState *s)
     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 int kvm_arch_process_async_events(CPUState *cs)
 {
     return 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bd6c440aef..6374246416 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -393,6 +393,16 @@ int kvm_arch_irqchip_create(KVMState *s)
     return 0;
 }
 
+int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 {
     return cpu->cpu_index;
-- 
2.42.0


