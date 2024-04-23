Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8F7C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnI-00057b-Ay; Tue, 23 Apr 2024 11:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmm-0004Ou-8E
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmj-00007N-TG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsp+LIRyKEp36ECWTky61fIKHdbp9NieE8/Mzncu1DI=;
 b=FaeEw3+tavQyA0Vg7pA75GM7fuDBkR4AGOPGLsHed9vIsqu4rQXH7OBurD7PXXIo3Dg+N2
 8JFAeAJUwxq+KwCoLEpR1lWbqbVOhXD/Qpg3G1tWi2dBRoU87AB65SjycO01K/eZU4Maji
 wiUv3LMVDqzxFQKs8oANTuvqftAYBI8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-Fh-wHzYyMnq2rKqrPP5MJg-1; Tue,
 23 Apr 2024 11:10:14 -0400
X-MC-Unique: Fh-wHzYyMnq2rKqrPP5MJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34CB03811701
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:14 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCAA9200AFA2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/63] kvm: use configs/ definition to conditionalize debug
 support
Date: Tue, 23 Apr 2024 17:09:09 +0200
Message-ID: <20240423150951.41600-22-pbonzini@redhat.com>
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

If an architecture adds support for KVM_CAP_SET_GUEST_DEBUG but QEMU does not
have the necessary code, QEMU will fail to build after updating kernel headers.
Avoid this by using a #define in config-target.h instead of KVM_CAP_SET_GUEST_DEBUG.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/aarch64-softmmu.mak |  1 +
 configs/targets/i386-softmmu.mak    |  1 +
 configs/targets/ppc-softmmu.mak     |  1 +
 configs/targets/ppc64-softmmu.mak   |  1 +
 configs/targets/s390x-softmmu.mak   |  1 +
 configs/targets/x86_64-softmmu.mak  |  1 +
 include/sysemu/kvm.h                |  2 +-
 include/sysemu/kvm_int.h            |  2 +-
 accel/kvm/kvm-accel-ops.c           |  4 ++--
 accel/kvm/kvm-all.c                 | 10 +++++-----
 10 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index b4338e95680..83c22391a69 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,5 +1,6 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 TARGET_NEED_FDT=y
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 6b3c99fc86c..d61b5076134 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_NEED_FDT=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 774440108f7..f3ea9c98f75 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index ddf0c39617f..1db8d8381d0 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -2,5 +2,6 @@ TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 TARGET_NEED_FDT=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 70d2f9f0ba0..b22218aacc8 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 197817c9434..c5f882e5ba1 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_NEED_FDT=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fad9a7e8ff3..2cba899270c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -224,7 +224,7 @@ void kvm_flush_coalesced_mmio_buffer(void);
  * calling down to kvm_arch_update_guest_debug after the generic
  * fields have been set.
  */
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
 #else
 static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 882e37e12c5..94488d2c1a2 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -78,7 +78,7 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
     int max_nested_state_len;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index b3c946dc4b4..f5ac643fca3 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -85,7 +85,7 @@ static bool kvm_cpus_are_resettable(void)
     return !kvm_enabled() || kvm_cpu_check_are_resettable();
 }
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 static int kvm_update_guest_debug_ops(CPUState *cpu)
 {
     return kvm_update_guest_debug(cpu, 0);
@@ -104,7 +104,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, void *data)
     ops->synchronize_state = kvm_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
     ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 931f74256e8..d58916e33ae 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2360,7 +2360,7 @@ static int kvm_init(MachineState *ms)
     s->sigmask_len = 8;
     accel_blocker_init();
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
 #endif
     QLIST_INIT(&s->kvm_parked_vcpus);
@@ -2544,7 +2544,7 @@ static int kvm_init(MachineState *ms)
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 #endif
@@ -2553,7 +2553,7 @@ static int kvm_init(MachineState *ms)
     if (kvm_has_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
-#if defined KVM_CAP_SET_GUEST_DEBUG2
+#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
@@ -3157,7 +3157,7 @@ bool kvm_arm_supports_user_irq(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
 }
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct kvm_sw_breakpoint *bp;
@@ -3317,7 +3317,7 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
-#endif /* !KVM_CAP_SET_GUEST_DEBUG */
+#endif /* !TARGET_KVM_HAVE_GUEST_DEBUG */
 
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
-- 
2.44.0



