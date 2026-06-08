Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3F9CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbn2-0001vH-UG; Mon, 08 Jun 2026 11:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1wWbn1-0001to-Dx
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:23 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1wWbmz-0007sg-DC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:23 -0400
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de
 [79.254.29.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 9BAFF202947;
 Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org, marcel.apfelbaum@gmail.com, zhao1.liu@intel.com,
 berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 mtosatti@redhat.com, Tom Lendacky <thomas.lendacky@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, coconut-svsm@lists.linux.dev,
 joerg.roedel@amd.com
Subject: [RFC PATCH 06/10] accel/kvm: Handle KVM_PLANE_EVENT_CREATE_CPU event
Date: Mon,  8 Jun 2026 17:21:05 +0200
Message-ID: <20260608152109.356783-7-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.214.250.239; envelope-from=joro@8bytes.org;
 helo=mail.8bytes.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joerg Roedel <joerg.roedel@amd.com>

Implement the plane event handling infrastructure and handle the
KVM_PLANE_EVENT_CREATE_CPU event.

Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c   | 13 +++++++---
 include/system/kvm.h  |  2 +-
 target/i386/kvm/kvm.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index dbfef63a84b0..c5fe6d189e62 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -573,11 +573,17 @@ static void kvm_alloc_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
     cpu->kvm_plane_state[plane_id] = p;
 }
 
-void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
+void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane_id)
 {
-    int vcpu_fd = cpu_kvm_plane(cpu, 0)->kvm_fd;
-    int plane_fd = kvm_vm_plane_ioctl(cpu->kvm_state, plane_id, KVM_CREATE_VCPU, vcpu_fd);
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    int plane_fd;
 
+    if (kvm_get_or_create_plane_fd(cpu->kvm_state, plane_id) < 0) {
+        fprintf(stderr, "Failed to create plane %d\n", plane_id);
+        abort();
+    }
+
+    plane_fd = kvm_vm_plane_ioctl(cpu->kvm_state, plane_id, KVM_CREATE_VCPU, x86_cpu->apic_id);
     if (plane_fd < 0) {
         fprintf(stderr, "Failed to create plane vcpu\n");
         abort();
@@ -586,7 +592,6 @@ void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
     kvm_alloc_vcpu_plane(cpu, plane_id, plane_fd);
 }
 
-
 /**
  * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
  * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 16597333cfa5..24a21915366f 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -221,7 +221,7 @@ int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
 int kvm_vm_plane_ioctl(KVMState *s, unsigned plane_id, unsigned long type, ...);
 
 int kvm_get_or_create_plane_fd(KVMState *s, unsigned id);
-void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane, int kvm_fd);
+void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane);
 
 void kvm_flush_coalesced_mmio_buffer(void);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8c3..30fba9e75016 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6524,6 +6524,60 @@ static int kvm_handle_hypercall(X86CPU *cpu, struct kvm_run *run)
     return -EINVAL;
 }
 
+static CPUState *kvm_get_cpu_by_apicid(CPUState *cpu, unsigned apic_id)
+{
+    CPU_FOREACH(cpu) {
+        X86CPU *x86_cpu = X86_CPU(cpu);
+        if (x86_cpu->apic_id == apic_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+static void create_plane_vcpu_cb(CPUState *cs, run_on_cpu_data data)
+{
+    int plane = data.host_int;
+
+    kvm_create_vcpu_plane(cs, plane);
+}
+
+static int kvm_handle_plane_create_vcpu(CPUState *cpu, struct kvm_run *run)
+{
+    CPUState *target_cpu = NULL;
+    int plane = -EINVAL;
+
+    plane = run->plane_event.plane;
+    if (plane < 0) {
+        return plane;
+    }
+
+    target_cpu = kvm_get_cpu_by_apicid(cpu, run->plane_event.extra[0]);
+    if (target_cpu == NULL) {
+        return -EINVAL;
+    }
+
+    bql_lock();
+    run_on_cpu(target_cpu, create_plane_vcpu_cb, RUN_ON_CPU_HOST_INT(plane));
+    bql_unlock();
+
+    return 0;
+}
+
+static int kvm_handle_plane_event(CPUState *cpu, struct kvm_run *run)
+{
+    switch (run->plane_event.cause) {
+        case KVM_PLANE_EVENT_CREATE_VCPU:
+            return kvm_handle_plane_create_vcpu(cpu, run);
+        default:
+            fprintf(stderr, "KVM: unknown plane event %d\n", run->plane_event.cause);
+            break;
+    }
+
+    return -EINVAL;
+}
+
 #define VMX_INVALID_GUEST_STATE 0x80000021
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
@@ -6648,6 +6702,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             break;
         }
         ret = 0;
+	break;
+    case KVM_EXIT_PLANE_EVENT:
+        ret = kvm_handle_plane_event(cs, run);
         break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
-- 
2.53.0


