Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9009CD6E61
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJLm-0000P7-0n; Tue, 02 Jun 2026 03:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wUJLk-0000OZ-3M
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:15:44 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wUJLh-0005Dp-U3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:15:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3582E4373A;
 Tue,  2 Jun 2026 07:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ACC1F00893;
 Tue,  2 Jun 2026 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780384533;
 bh=ZhVVDTgnchGyrV3WSdc01U1Ne0/Vtdh8/NXOHYYb3xU=;
 h=From:To:Cc:Subject:Date;
 b=mE82YREeUkaAfXpqfHFsUFeFOtSrrPtaxSzKDCfr/Dzuq6wNopXYf2ZauS0oJNgRq
 VhFQ6v8xCudi6c87iy+c9BFovyxU/nKamN6t2t+8ZeCVDAJYcKaq+0YvavUhJ2Kxwp
 QIXQB2kvUYnmPmBr/YAVKUwJpXFFfqdwF9+GG+TcRTmBE+Lk21Y2eg5dtBAsFWA1MV
 V1gr69/bRIAOGCsueKULEyX7z1rMOygu9uC7olcl/wAVhXAiCUMOLDYIsTbuP3sOO1
 iN6p/2PlnUCbmFc9JbENPDst2Aa4HsN5Q94fiSn+vG/r7Y9o5HbkMEdHcZUz5dULiX
 WJUioK4SwYLlw==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES guests
Date: Tue,  2 Jun 2026 12:42:13 +0530
Message-ID: <20260602071213.2084388-1-naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

KVM commit 66155de93bcf ("KVM: x86: Disallow read-only memslots for
SEV-ES and SEV-SNP (and TDX)"), and the subsequent commit d30d9ee94cc0
("KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM")
stopped advertising KVM_CAP_READONLY_MEM support for encrypted guests
(KVM_X86_SEV_ES_VM and KVM_X86_SNP_VM), but not for KVM_X86_DEFAULT_VM
type SEV-ES guests. As a result of this, it is no longer possible to
start SEV-ES guests with any SEV feature enabled (in particular,
debug-swap) with pflash devices.

This is an issue since SEV-ES guests have historically used pflash
devices for OVMF. Guests on older KVM+Qemu are able to enable debug-swap
while using pflash devices, so work around the KVM limitation by
switching to using a VMA-based write protection. This allows
well-behaved SEV-ES guests to continue to work with pflash devices and
enable debug-swap. Mis-behaving guests trying to write to the protected
OVMF area will be killed.

Enable VMA protection and set the memory to be RO when adding the KVM
memory slot. Because pflash devices support command-mode, change VMA
protection to RW when tearing down the KVM memory slot. KVM
SEV_LAUNCH_UPDATE also requires memory to be RW, so disable the
protection when calling that.

Print a warning when switching to VMA-based protection so that it is
clear that KVM itself isn't supporting readonly memory, and that a
workaround is in place. Users can plan on switching to using '-bios'.

Finally, drop the check rejecting SEV-ES guests with SEV features so 
that debug-swap can be enabled.


Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
Background discussion on this issue:
http://lore.kernel.org/r/aUq9_cUDWeEW_qli@google.com

This series depends on VMSA features support:
http://lore.kernel.org/r/cover.1779281646.git.naveen@kernel.org


- Naveen


 include/system/kvm.h     |  5 ++++
 include/system/kvm_int.h |  1 +
 accel/kvm/kvm-all.c      | 52 +++++++++++++++++++++++++++++++++++++++-
 hw/i386/pc_sysfw.c       | 19 +++++++++------
 target/i386/sev.c        | 21 +++++++++++-----
 5 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda38..585058bd6f1c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -555,6 +555,8 @@ uint32_t kvm_dirty_ring_size(void);
 
 void kvm_mark_guest_state_protected(void);
 
+void kvm_enable_ro_mem_vma_protection(void);
+
 /**
  * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
  * reported for the VM.
@@ -568,6 +570,9 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
+void kvm_set_memory_readonly(void *addr, size_t len);
+void kvm_set_memory_readwrite(void *addr, size_t len);
+
 /* argument to vmfd change notifier */
 typedef struct VmfdChangeNotifier {
     int vmfd;
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d3..0e083a56ce2a 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -123,6 +123,7 @@ struct KVMState
     OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
     bool guest_state_protected;
+    bool guest_wants_ro_mem_vma_protection;
     uint64_t manual_dirty_log_protect;
     /*
      * Older POSIX says that ioctl numbers are signed int, but in
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb240f..4208df5b25ac 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1629,6 +1629,42 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
     return kvm_set_memory_attributes(start, size, 0);
 }
 
+static void kvm_set_memory_flags(void *addr, size_t len, int flags)
+{
+    if (mprotect(addr, len, flags)) {
+        error_report("failed to apply memory protection "
+                     "(0x%" HWADDR_PRIx "+0x%" PRIx64 ") error '%s'",
+                     (hwaddr)addr, len, strerror(errno));
+        exit(1);
+    }
+}
+
+void kvm_set_memory_readonly(void *addr, size_t len)
+{
+    if (kvm_state->guest_wants_ro_mem_vma_protection) {
+        kvm_set_memory_flags(addr, len, PROT_READ);
+    }
+}
+
+void kvm_set_memory_readwrite(void *addr, size_t len)
+{
+    if (kvm_state->guest_wants_ro_mem_vma_protection) {
+        kvm_set_memory_flags(addr, len, PROT_READ | PROT_WRITE);
+    }
+}
+
+static bool kvm_mem_wants_vma_protection(MemoryRegion *mr)
+{
+    if (!memory_region_is_ram(mr) &&
+        (mr->readonly || mr->rom_device) &&
+        !kvm_readonly_mem_allowed &&
+        kvm_state->guest_wants_ro_mem_vma_protection) {
+            return true;
+    }
+
+    return false;
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
@@ -1642,7 +1678,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     void *ram;
 
     if (!memory_region_is_ram(mr)) {
-        if (writable || !kvm_readonly_mem_allowed) {
+        if (writable || (!kvm_readonly_mem_allowed &&
+                         !kvm_state->guest_wants_ro_mem_vma_protection)) {
             return;
         } else if (!mr->romd_mode) {
             /* If the memory device is not in romd_mode, then we actually want
@@ -1697,6 +1734,10 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                 kvm_slot_sync_dirty_pages(mem);
             }
 
+            if (kvm_mem_wants_vma_protection(mr)) {
+                kvm_set_memory_readwrite(mem->ram, mem->memory_size);
+            }
+
             /* unregister the slot */
             g_free(mem->dirty_bmap);
             mem->dirty_bmap = NULL;
@@ -1746,6 +1787,10 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             }
         }
 
+        if (kvm_mem_wants_vma_protection(mr)) {
+            kvm_set_memory_readonly(mem->ram, mem->memory_size);
+        }
+
         start_addr += slot_size;
         ram_start_offset += slot_size;
         ram += slot_size;
@@ -4771,6 +4816,11 @@ void kvm_mark_guest_state_protected(void)
     kvm_state->guest_state_protected = true;
 }
 
+void kvm_enable_ro_mem_vma_protection(void)
+{
+    kvm_state->guest_wants_ro_mem_vma_protection = true;
+}
+
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     int fd;
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a41a5972bd0..9590458e00c5 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -254,13 +254,18 @@ void pc_system_firmware_init(PCMachineState *pcms,
         }
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
-            /*
-             * Older KVM cannot execute from device memory. So, flash
-             * memory cannot be used unless the readonly memory kvm
-             * capability is present.
-             */
-            error_report("pflash with kvm requires KVM readonly memory support");
-            exit(1);
+            if (sev_es_enabled() && !sev_snp_enabled()) {
+                warn_report("pflash not supported with SEV-ES guests, "
+                            "attempting VMA based protection");
+            } else {
+                /*
+                 * Older KVM cannot execute from device memory. So, flash
+                 * memory cannot be used unless the readonly memory kvm
+                 * capability is present.
+                 */
+                error_report("pflash with kvm requires KVM readonly memory support");
+                exit(1);
+            }
         }
 
         pc_system_flash_map(pcms, rom_memory);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f04ae4e91f3e..82cf2c562729 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -550,12 +550,6 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
             return -1;
         }
     } else {
-        if (sev_features && sev_es_enabled()) {
-            error_setg(errp,
-                       "%s: SEV features are not supported with SEV-ES at this time",
-                       __func__);
-            return -1;
-        }
         if (sev_features & SVM_SEV_FEAT_SNP_ACTIVE) {
             error_setg(errp,
                        "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
@@ -2024,6 +2018,15 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
+    /*
+     * Use VMA-based protection for SEV-ES guests that enable any
+     * SEV feature, since KVM does not advertise readonly memory
+     * support for non-default type SEV guests.
+     */
+    if (sev_es_enabled() && SEV_COMMON(cgs)->sev_features) {
+        kvm_enable_ro_mem_vma_protection();
+    }
+
     if (!cgs->ready) {
         /*
          * SEV uses these notifiers to register/pin pages prior to guest use,
@@ -2111,7 +2114,13 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
         int ret;
 
+        /*
+         * KVM requires these pages to be RW, so remove VMA RO protection
+         * for the duration of SEV_LAUNCH_UPDATE if using SEV features.
+         */
+        kvm_set_memory_readwrite(ptr, len);
         ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
+        kvm_set_memory_readonly(ptr, len);
         if (ret < 0) {
             return ret;
         }

base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
prerequisite-patch-id: dc27ad6297d47d063b04fa797c1b8203ee97d9c8
prerequisite-patch-id: 603eff49233c4b0483e7c405754b95aa455dd38c
prerequisite-patch-id: d4085e72ecfb0fbf977f7358d1edd29951b93784
prerequisite-patch-id: f6f201825b1e56f89a87a26bc457b3e6018aee49
prerequisite-patch-id: 08d79cec4c3f117178be8f6c866ff1be08e971f3
prerequisite-patch-id: c112bccab9ab9cee2d0227516fc857590b99a75b
prerequisite-patch-id: f42fd829d0ea4909537e722477057a4013a247ab
prerequisite-patch-id: 67136368ed1d2fa0ae55fee4368a7bd1fe394368
prerequisite-patch-id: 08349bb1e0e11ee1518a9041771302c97866b5cd
-- 
2.54.0


