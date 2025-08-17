Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336A2CA0EE4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Aug 2025 05:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unWMs-00045G-08; Sun, 17 Aug 2025 01:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1unWMq-00044q-28
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 01:55:44 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1unWMm-0006yW-P0
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 01:55:43 -0400
DKIM-Signature: a=rsa-sha256; bh=BBmV2/9+3dABu7WeQUe72uY88hv6kSb52F83d9BRCq0=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1755410136; v=1;
 b=kA2/lf06gqt4SGMrpjpqlHm8twCmOQkW8OIUhcoxPBiS2KI7VvxilVUvHR4ti+Hb+BvFHw4Y
 1i0uzbOF9z697hI5bmsY1+pqfiiUl7dBOWlfpJpVadtr6Z6JgR1gNaGn7+vh9ibrNh7Nhh5xMja
 YB6ETHFV8nbel8ueoQVX5Iovq8mRI+7p/ofDsknAGEpjmp+qmob7t/m4irbpNRwCAygrxQZXA/c
 M7TH9XLMwhRyzgVwIULx52SfC5xNU2gDQmPIX2hAMelFUTnBEaKcjxm7J6UW4aaCRlfBElKTeId
 w2i9DL7D17xlImpS/zgEUDJmBQwcj37JWdV13Uwma7+gQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 5594523036;
 Sun, 17 Aug 2025 05:55:36 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Sun, 17 Aug 2025 05:37:34 +0000
Subject: [PATCH qemu v5 1/1] Honor guest PAT on x86, absent Bochs display
Message-ID: <175541013614.15277.14412479690071783636-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <175541013614.15277.14412479690071783636-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
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
---
 hw/display/bochs-display.c |  4 +++
 include/system/kvm.h       |  1 +
 target/i386/kvm/kvm.c      | 52 ++++++++++++++++++++++++++++++++------
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index ad2821c974..4059373df3 100644
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
@@ -309,6 +311,8 @@ static void bochs_display_realize(PCIDevice *dev, Error *=
*errp)
     }
=20
     memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
+
+    kvm_hack_do_not_enable_guest_pat();
 }
=20
 static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 3c7d314736..c6ba3905dc 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -208,6 +208,7 @@ void kvm_close(void);
  */
 bool kvm_arm_supports_user_irq(void);
=20
+void kvm_hack_do_not_enable_guest_pat(void);
=20
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..0f8af92962 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -188,6 +188,8 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RAN=
GES];
 static RateLimit bus_lock_ratelimit_ctrl;
 static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
=20
+bool kvm_has_bochs_drm =3D false;
+
 static const char *vm_type_name[] =3D {
     [KVM_X86_DEFAULT_VM] =3D "default",
     [KVM_X86_SEV_VM] =3D "SEV",
@@ -2696,13 +2698,13 @@ static bool kvm_rdmsr_pkg_energy_status(X86CPU *cpu,
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
     MemoryRegion *smram =3D
         (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
@@ -2730,6 +2732,44 @@ static void register_smram_listener(Notifier *n, void =
*unused)
                                  &smram_address_space, 1, "kvm-smram");
 }
=20
+void kvm_hack_do_not_enable_guest_pat(void)
+{
+    kvm_has_bochs_drm =3D true;
+}
+
+static bool kvm_x86_smm_enabled(void)
+{
+    return kvm_has_smm() &&
+        object_dynamic_cast(OBJECT(current_machine), TYPE_X86_MACHINE) &&
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
+    if (!kvm_has_bochs_drm && \
+        (kvm_x86_disable_quirsk2_mask() & KVM_X86_QUIRK_IGNORE_GUEST_PAT)) {
+        if (kvm_disable_ignore_guest_pat()) {
+            error_report("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
+                         "modifiable but we failed to disable it\n");
+        }
+    }
+}
+
+
 static void *kvm_msr_energy_thread(void *data)
 {
     KVMState *s =3D data;
@@ -3310,12 +3350,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
=20
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
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

