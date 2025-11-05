Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537D4CCFA19
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 22:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGm2n-00022H-Vs; Wed, 05 Nov 2025 17:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vGm2h-00021O-PT
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:31:54 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vGm2e-0007UN-Fm
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:31:50 -0500
DKIM-Signature: a=rsa-sha256; bh=rN5skFE/7t7CivcRFcehEgzgv/YQF41xi+DFhFMhlZc=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1762381904; v=1;
 b=XyYfe42HVuq5sHS6ubQVWZKbis8/IPnIm36tTXBdvZemuS+Gtcqn7TWv0qL3GHOmnc0eCd3C
 pZDEPsGKtnzPIPmC+CWXYfulVQi1GvHxBX/iTX7VBQmbj9808KTI+qAIfkySnCKvsoZCBBgEH9u
 8h3+i2GzbTvQir7zT87dS1Ajmj0T6mHzy4joRzrSpQU7aXadPBjVN4eXDoa3idEwpcvk1DpWCNa
 uiCwI5eYJyh+/2dnMPF/zzZpt7a6/3v/3nf//GU4VUGUV2xgenbhSsi6cQujH5BIfYoXjLYrubq
 syGk5sA0Ui2TW07Rqs93EOG+teGbZ/wuH53gj8m1Sxxsw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id B0EB8240C3;
 Wed, 05 Nov 2025 22:31:44 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Wed, 05 Nov 2025 22:07:10 +0000
Subject: [PATCH qemu v9 1/1] i386/kvm: Honor guest PAT on x86,
 absent Bochs display
Message-ID: <176238190422.23756.12141073071212582632-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <176238190422.23756.12141073071212582632-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: myrslint <qemu.haziness801@passinbox.com>

On x86_64, where most CPUs support self-snoop, it is preferrable to
always honor guest PAT. Not doing so is a quirk. There is a default
enabled KVM quirk flag which enforces not doing so due to a former bug
in Bochs display driver.

The bug has been fixed but not enough has yet passed since so we only
disable said quirk flag if a Bochs display is not configured for the
virtual machine.

This commit also moves around a bit of code that would be called when
the initialization of a VM is done.

Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # intel-ivb
---
 accel/kvm/kvm-all.c        |  1 +
 accel/stubs/kvm-stub.c     |  1 +
 hw/display/bochs-display.c | 17 +++++++++++++++
 include/system/kvm.h       |  9 ++++++++
 target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
 5 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9254ae654..36a12593ee 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -103,6 +103,7 @@ bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
 bool kvm_pre_fault_memory_supported;
+bool kvm_bochs_drm_quirk;
 static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 68cd33ba97..a69c89e1ad 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -24,6 +24,7 @@ bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_msi_use_devid;
+bool kvm_bochs_drm_quirk;
=20
 void kvm_flush_coalesced_mmio_buffer(void)
 {
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index ad2821c974..e8def68b41 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -20,6 +20,8 @@
 #include "ui/qemu-pixman.h"
 #include "qom/object.h"
=20
+#include "system/kvm.h"
+
 typedef struct BochsDisplayMode {
     pixman_format_code_t format;
     uint32_t             bytepp;
@@ -309,6 +311,21 @@ static void bochs_display_realize(PCIDevice *dev, Error =
**errp)
     }
=20
     memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
+
+    /*
+     * On x86_64, where most CPUs support self-snoop, it is preferrable to
+     * always honor guest PAT. Not doing so is a quirk. There is a default
+     * enabled KVM quirk flag which enforces not doing so due to a former bug
+     * in Bochs display driver.
+     *
+     * The bug has been fixed but not enough has yet passed since so we only
+     * disable said quirk flag if a Bochs display is not configured for the
+     * virtual machine.
+     *
+     * The following flag tells KVM initialization code not to disable that
+     * quirk flag.
+     */
+    kvm_bochs_drm_quirk =3D true;
 }
=20
 static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8f9eecf044..123016777c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -43,6 +43,7 @@ extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
 extern bool kvm_msi_use_devid;
 extern bool kvm_pre_fault_memory_supported;
+extern bool kvm_bochs_drm_quirk;
=20
 #define kvm_enabled()           (kvm_allowed)
 /**
@@ -144,6 +145,13 @@ extern bool kvm_pre_fault_memory_supported;
  */
 #define kvm_msi_devid_required() (kvm_msi_use_devid)
=20
+/**
+ * kvm_has_bochs_drm:
+ * Returns: true if KVM is possible and a Bochs DRM driver is
+ * in use for display.
+ */
+#define kvm_has_bochs_drm() (kvm_bochs_drm_quirk)
+
 #else
=20
 #define kvm_enabled()           (0)
@@ -158,6 +166,7 @@ extern bool kvm_pre_fault_memory_supported;
 #define kvm_gsi_direct_mapping() (false)
 #define kvm_readonly_mem_enabled() (false)
 #define kvm_msi_devid_required() (false)
+#define kvm_has_bochs_drm() (false)
=20
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
=20
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c7981138..dd2594f5af 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2709,13 +2709,13 @@ static bool kvm_rdmsr_pkg_energy_status(X86CPU *cpu,
     return true;
 }
=20
-static Notifier smram_machine_done;
+static Notifier kvm_machine_done;
 static KVMMemoryListener smram_listener;
 static AddressSpace smram_address_space;
 static MemoryRegion smram_as_root;
 static MemoryRegion smram_as_mem;
=20
-static void register_smram_listener(Notifier *n, void *unused)
+static void register_smram_listener(void)
 {
     CPUState *cpu;
     MemoryRegion *smram =3D
@@ -2754,6 +2754,37 @@ void kvm_smm_cpu_address_space_init(X86CPU *cpu)
     cpu_address_space_init(CPU(cpu), X86ASIdx_SMM, "cpu-smm", &smram_as_root=
);
 }
=20
+static bool kvm_x86_smm_enabled(void)
+{
+    return object_dynamic_cast(OBJECT(current_machine), TYPE_X86_MACHINE) &&
+        x86_machine_is_smm_enabled(X86_MACHINE(current_machine));
+}
+
+static int kvm_x86_disable_quirsk2_mask(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_DISABLE_QUIRKS2);
+}
+
+static int kvm_disable_ignore_guest_pat(void)
+{
+    return kvm_vm_enable_cap(kvm_state, KVM_CAP_DISABLE_QUIRKS2, 0, \
+                             KVM_X86_QUIRK_IGNORE_GUEST_PAT);
+}
+
+static void handle_machine_done(Notifier *n, void *unused)
+{
+    if (kvm_x86_smm_enabled()) {
+        register_smram_listener();
+    }
+    if (!kvm_has_bochs_drm() && \
+        (kvm_x86_disable_quirsk2_mask() & KVM_X86_QUIRK_IGNORE_GUEST_PAT)) {
+        if (kvm_disable_ignore_guest_pat()) {
+            error_report("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
+                         "modifiable but we failed to disable it");
+        }
+    }
+}
+
 static void *kvm_msr_energy_thread(void *data)
 {
     KVMState *s =3D data;
@@ -3334,11 +3365,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
=20
-    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
-        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
-        smram_machine_done.notify =3D register_smram_listener;
-        qemu_add_machine_init_done_notifier(&smram_machine_done);
-    }
+    kvm_machine_done.notify =3D handle_machine_done;
+    qemu_add_machine_init_done_notifier(&kvm_machine_done);
=20
     if (enable_cpu_pm) {
         ret =3D kvm_vm_enable_disable_exits(s);
--=20
2.49.1

