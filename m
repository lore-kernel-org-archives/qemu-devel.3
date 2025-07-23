Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D164C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 18:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uee7H-0005YQ-NW; Wed, 23 Jul 2025 14:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1uee6o-0004jU-F3
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 14:22:32 -0400
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1uee6l-0001pJ-KV
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 14:22:30 -0400
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56NIMBAD1299786
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 23 Jul 2025 11:22:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56NIMBAD1299786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2025072201; t=1753294935;
 bh=RPBt+AF2dCEcK0XM8sYhPFxdEaBCmzbjk0cfLAbZ6nQ=;
 h=From:To:Cc:Subject:Date:From;
 b=KdPdZy8/dNuFuqVX55JlNQ//bbH/FZqKJ7JzM/RWJOUV/6YQ7dzf4aYTlaL6RMVz4
 DXfKaY/OSeislQ39CSugMtXxMg5gfnOmdoYcWOZiI2u1zPK+QK+UjNUu/Mnw5ilDqY
 xpRb+Rahfqk4GyHTaXZFpY5GMJfb8kCgHLgrYZSKaVoJEG8qWrw5lqYqFzRcfNlCns
 vxR2rIw68SVER1CWvw4QMOlo1pUm6zmObdwC4oJqoy6n/QJ89sLgkJDIL8eWz+PZ3A
 LMhQ+YaplKSvVTRD/SgR6RxTS5TpqJs99uhqfjyG1X6iksqGfvvWg6DQt8MRMJqrKg
 e/7GCflNsQRPw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, mtosatti@redhat.com, seanjc@google.com,
 hpa@zytor.com, xin@zytor.com, andrew.cooper3@citrix.com, chao.gao@intel.com
Subject: [PATCH v1 1/1] target/i386: Save/restore the nested flag of an
 exception
Date: Wed, 23 Jul 2025 11:22:11 -0700
Message-ID: <20250723182211.1299776-1-xin@zytor.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::136; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Save/restore the nested flag of an exception during VM save/restore
and live migration to ensure a correct event stack level is chosen
when a nested exception is injected through FRED event delivery.

The event stack level used by FRED event delivery depends on whether
the event was a nested exception encountered during delivery of an
earlier event, because a nested exception is "regarded" as happening
on ring 0.  E.g., when #PF is configured to use stack level 1 in
IA32_FRED_STKLVLS MSR:
  - nested #PF will be delivered on the stack pointed by IA32_FRED_RSP1
    MSR when encountered in ring 3 and ring 0.
  - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP0
    MSR when encountered in ring 3.
  - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP1
    MSR when encountered in ring 0.

As such Qemu needs to track if an event is a nested event during VM
context save/restore and live migration.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 linux-headers/asm-x86/kvm.h |  4 +++-
 linux-headers/linux/kvm.h   |  1 +
 target/i386/cpu.c           |  1 +
 target/i386/cpu.h           |  1 +
 target/i386/kvm/kvm.c       | 35 +++++++++++++++++++++++++++++++++++
 target/i386/kvm/kvm_i386.h  |  1 +
 target/i386/machine.c       |  1 +
 7 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index f0c1a730d9..f494509b94 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -324,6 +324,7 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_SMM		0x00000008
 #define KVM_VCPUEVENT_VALID_PAYLOAD	0x00000010
 #define KVM_VCPUEVENT_VALID_TRIPLE_FAULT	0x00000020
+#define KVM_VCPUEVENT_VALID_NESTED_FLAG	0x00000040
 
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
@@ -361,7 +362,8 @@ struct kvm_vcpu_events {
 	struct {
 		__u8 pending;
 	} triple_fault;
-	__u8 reserved[26];
+	__u8 reserved[25];
+	__u8 exception_is_nested;
 	__u8 exception_has_payload;
 	__u64 exception_payload;
 };
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 32c5885a3c..521ec3af37 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -952,6 +952,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
+#define KVM_CAP_EXCEPTION_NESTED_FLAG 243
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 251d5760a0..4483bf9d10 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8723,6 +8723,7 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
     env->exception_injected = 0;
     env->exception_has_payload = false;
     env->exception_payload = 0;
+    env->exception_is_nested = false;
     env->nmi_injected = false;
     env->triple_fault_pending = false;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f977fc49a7..a9116bfd2c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2097,6 +2097,7 @@ typedef struct CPUArchState {
     uint8_t has_error_code;
     uint8_t exception_has_payload;
     uint64_t exception_payload;
+    uint8_t exception_is_nested;
     uint8_t triple_fault_pending;
     uint32_t ins_len;
     uint32_t sipi_vector;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..db4af9ec2d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -174,6 +174,7 @@ static int has_xsave2;
 static int has_xcrs;
 static int has_sregs2;
 static int has_exception_payload;
+static int has_exception_nested_flag;
 static int has_triple_fault_event;
 
 static bool has_msr_mcg_ext_ctl;
@@ -259,6 +260,11 @@ bool kvm_has_exception_payload(void)
     return has_exception_payload;
 }
 
+bool kvm_has_exception_nested_flag(void)
+{
+    return has_exception_nested_flag;
+}
+
 static bool kvm_x2apic_api_set_flags(uint64_t flags)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -3075,6 +3081,21 @@ static int kvm_vm_enable_exception_payload(KVMState *s)
     return ret;
 }
 
+static int kvm_vm_enable_exception_nested_flag(KVMState *s)
+{
+    int ret = 0;
+    has_exception_nested_flag = kvm_check_extension(s, KVM_CAP_EXCEPTION_NESTED_FLAG);
+    if (has_exception_nested_flag) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_NESTED_FLAG, 0, true);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable exception nested flag cap: %s",
+                         strerror(-ret));
+        }
+    }
+
+    return ret;
+}
+
 static int kvm_vm_enable_triple_fault_event(KVMState *s)
 {
     int ret = 0;
@@ -3255,6 +3276,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
+    ret = kvm_vm_enable_exception_nested_flag(s);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = kvm_vm_enable_triple_fault_event(s);
     if (ret < 0) {
         return ret;
@@ -5041,6 +5067,10 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
         events.exception_has_payload = env->exception_has_payload;
         events.exception_payload = env->exception_payload;
     }
+    if (has_exception_nested_flag) {
+        events.flags |= KVM_VCPUEVENT_VALID_NESTED_FLAG;
+        events.exception_is_nested = env->exception_is_nested;
+    }
     events.exception.nr = env->exception_nr;
     events.exception.injected = env->exception_injected;
     events.exception.has_error_code = env->has_error_code;
@@ -5109,6 +5139,11 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         env->exception_pending = 0;
         env->exception_has_payload = false;
     }
+    if (events.flags & KVM_VCPUEVENT_VALID_NESTED_FLAG) {
+        env->exception_is_nested = events.exception_is_nested;
+    } else {
+        env->exception_is_nested = false;
+    }
     env->exception_injected = events.exception.injected;
     env->exception_nr =
         (env->exception_pending || env->exception_injected) ?
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 5f83e8850a..7e765b6833 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -54,6 +54,7 @@ typedef struct KvmCpuidInfo {
 bool kvm_is_vm_type_supported(int type);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
+bool kvm_has_exception_nested_flag(void);
 void kvm_synchronize_all_tsc(void);
 
 void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index dd2dac1d44..a452d2c97e 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -458,6 +458,7 @@ static const VMStateDescription vmstate_exception_info = {
         VMSTATE_UINT8(env.exception_injected, X86CPU),
         VMSTATE_UINT8(env.exception_has_payload, X86CPU),
         VMSTATE_UINT64(env.exception_payload, X86CPU),
+        VMSTATE_UINT8(env.exception_is_nested, X86CPU),
         VMSTATE_END_OF_LIST()
     }
 };

base-commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb
-- 
2.50.1


