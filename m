Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93395C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnT-0006Hb-VA; Tue, 23 Apr 2024 11:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnC-0004k8-Ik
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn7-0000HG-TN
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pk99K/zTrVRxPz+P8bURNxdcIAFJCpNOuMmTg+GIdgo=;
 b=dyN9ZqINAUfPQS6DUj6IyuzxWODhlCdipKIM45rQm1ZosgM100pRKCYYoaB3FM4enx7qNw
 SpsFKFuiAs2jP12vmSGLuhBNWj3sFOfyES6l3bWqvB3Rs/appN/EKobOQvJIeJnzpuP7vg
 Xu0bongCXOHrV9bMS4kqNkRsDq7eaQo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-S0GDEyXgO_S0i4n7xsOe1Q-1; Tue,
 23 Apr 2024 11:10:34 -0400
X-MC-Unique: S0GDEyXgO_S0i4n7xsOe1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1551829AC013;
 Tue, 23 Apr 2024 15:10:34 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80C6820128F3;
 Tue, 23 Apr 2024 15:10:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/63] KVM: track whether guest state is encrypted
Date: Tue, 23 Apr 2024 17:09:28 +0200
Message-ID: <20240423150951.41600-41-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

So far, KVM has allowed KVM_GET/SET_* ioctls to execute even if the
guest state is encrypted, in which case they do nothing.  For the new
API using VM types, instead, the ioctls will fail which is a safer and
more robust approach.

The new API will be the only one available for SEV-SNP and TDX, but it
is also usable for SEV and SEV-ES.  In preparation for that, require
architecture-specific KVM code to communicate the point at which guest
state is protected (which must be after kvm_cpu_synchronize_post_init(),
though that might change in the future in order to suppor migration).
From that point, skip reading registers so that cpu->vcpu_dirty is
never true: if it ever becomes true, kvm_arch_put_registers() will
fail miserably.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h     |  2 ++
 include/sysemu/kvm_int.h |  1 +
 accel/kvm/kvm-all.c      | 17 ++++++++++++++---
 target/i386/sev.c        |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 2cba899270c..14b1ddb3be1 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -539,6 +539,8 @@ bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
 
+void kvm_mark_guest_state_protected(void);
+
 /**
  * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
  * reported for the VM.
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 94488d2c1a2..227b61fec3d 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -87,6 +87,7 @@ struct KVMState
     bool kernel_irqchip_required;
     OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
+    bool guest_state_protected;
     uint64_t manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
      * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d58916e33ae..d6ebadbf386 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2703,7 +2703,7 @@ bool kvm_cpu_check_are_resettable(void)
 
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
         int ret = kvm_arch_get_registers(cpu);
         if (ret) {
             error_report("Failed to get registers: %s", strerror(-ret));
@@ -2717,7 +2717,7 @@ static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 
 void kvm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
         run_on_cpu(cpu, do_kvm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -2752,7 +2752,13 @@ static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 
 void kvm_cpu_synchronize_post_init(CPUState *cpu)
 {
-    run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+    if (!kvm_state->guest_state_protected) {
+        /*
+         * This runs before the machine_init_done notifiers, and is the last
+         * opportunity to synchronize the state of confidential guests.
+         */
+        run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+    }
 }
 
 static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
@@ -4099,3 +4105,8 @@ void query_stats_schemas_cb(StatsSchemaList **result, Error **errp)
         query_stats_schema_vcpu(first_cpu, &stats_args);
     }
 }
+
+void kvm_mark_guest_state_protected(void)
+{
+    kvm_state->guest_state_protected = true;
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index b8f79d34d19..c49a8fd55eb 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -755,6 +755,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
         if (ret) {
             exit(1);
         }
+        kvm_mark_guest_state_protected();
     }
 
     /* query the measurement blob length */
-- 
2.44.0



