Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C3C71151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 15:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6Om-00030n-U5; Fri, 13 Jun 2025 11:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ6Om-00030W-6j
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:32:56 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ6Oi-0005WZ-SO
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:32:55 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.84])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id A7A86401DA;
 Fri, 13 Jun 2025 16:32:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1749828770;
 bh=HsR51g/RYvSxr0PjCbXbzIbeC0wc9IOog+RU+6oMGhY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TRwjekyiidGuq8/k5AXU3Vdcj3ybQmAYKrwmoDStRNDRjeQkqa3iLPqnymSIdhQbl
 /DxUJ4D/cStckJIP64r7LdospqzchjTvnt4fWYywu0vP2LLOyLJHWmm24Lfv+mw3Gx
 Xuj29l5fjdj8niqjOhAfQsCNnHfclLooITfNCw5g=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 1256DA0232;
 Fri, 13 Jun 2025 16:32:46 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v8 16/16] sev: Provide sev_features flags from IGVM VMSA to
 KVM_SEV_INIT2
Date: Fri, 13 Jun 2025 16:32:26 +0100
Message-ID: <dc9525b51a7e5872f96dac0468d2f7816b8c9c01.1749820158.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

IGVM files can contain an initial VMSA that should be applied to each
vcpu as part of the initial guest state. The sev_features flags are
provided as part of the VMSA structure. However, KVM only allows
sev_features to be set during initialization and not as the guest is
being prepared for launch.

This patch queries KVM for the supported set of sev_features flags and
processes the VP context entries in the IGVM file during kvm_init to
determine any sev_features flags set in the IGVM file. These are then
provided in the call to KVM_SEV_INIT2 to ensure the guest state
matches that specified in the IGVM file.

The igvm process() function is modified to allow a partial processing
of the file during initialization, with on the IGVM_VHT_VP_CONTEXT
fields being processed. This means the function is called twice,
firstly to extract the sev_features then secondly to actually
configure the guest.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm.c           |  17 +++-
 backends/igvm.h           |   2 +-
 hw/i386/pc_piix.c         |   2 +-
 hw/i386/pc_q35.c          |   2 +-
 include/system/igvm-cfg.h |   5 +-
 target/i386/sev.c         | 161 +++++++++++++++++++++++++++++++++-----
 6 files changed, 163 insertions(+), 26 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 034f504716..9853ba941e 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -869,7 +869,7 @@ static IgvmHandle qigvm_file_init(char *filename, Error **errp)
 }
 
 int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                       Error **errp)
+                       bool onlyVpContext, Error **errp)
 {
     int32_t header_count;
     QIgvmParameterData *parameter;
@@ -913,11 +913,22 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
          ctx.current_header_index++) {
         IgvmVariableHeaderType type = igvm_get_header_type(
             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
-        if (qigvm_handler(&ctx, type, errp) < 0) {
-            goto cleanup_parameters;
+        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
+            if (qigvm_handler(&ctx, type, errp) < 0) {
+                goto cleanup_parameters;
+            }
         }
     }
 
+    /*
+     * If only processing the VP context then we don't need to process
+     * any more of the file.
+     */
+    if (onlyVpContext) {
+        retval = 0;
+        goto cleanup_parameters;
+    }
+
     header_count =
         igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
     if (header_count < 0) {
diff --git a/backends/igvm.h b/backends/igvm.h
index db02ea9165..a4abab043a 100644
--- a/backends/igvm.h
+++ b/backends/igvm.h
@@ -17,6 +17,6 @@
 #include "qapi/error.h"
 
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
-                      Error **errp);
+                      bool onlyVpContext, Error **errp);
 
 #endif
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3184ea1b37..a3285fbc64 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -371,7 +371,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     /* Apply guest state from IGVM if supplied */
     if (x86ms->igvm) {
         if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
             g_assert_not_reached();
         }
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6990e1c669..cf871cfdad 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -330,7 +330,7 @@ static void pc_q35_init(MachineState *machine)
     /* Apply guest state from IGVM if supplied */
     if (x86ms->igvm) {
         if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
             g_assert_not_reached();
         }
     }
diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 321b3196f0..944f23a814 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -31,11 +31,14 @@ typedef struct IgvmCfgClass {
     /*
      * If an IGVM filename has been specified then process the IGVM file.
      * Performs a no-op if no filename has been specified.
+     * If onlyVpContext is true then only the IGVM_VHT_VP_CONTEXT entries
+     * in the IGVM file will be processed, allowing information about the
+     * CPU state to be determined before processing the entire file.
      *
      * Returns 0 for ok and -1 on error.
      */
     int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                   Error **errp);
+                   bool onlyVpContext, Error **errp);
 
 } IgvmCfgClass;
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2798fe1c38..df55a25a67 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -118,6 +118,8 @@ struct SevCommonState {
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
     bool kernel_hashes;
+    uint64_t sev_features;
+    uint64_t supported_sev_features;
 
     /* runtime state */
     uint8_t api_major;
@@ -485,7 +487,40 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
-static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
+static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
+                              Error **errp)
+{
+    /*
+     * Ensure SEV_FEATURES is configured for correct SEV hardware and that
+     * the requested features are supported. If SEV-SNP is enabled then
+     * that feature must be enabled, otherwise it must be cleared.
+     */
+    if (sev_snp_enabled() && !(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+        error_setg(
+            errp,
+            "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
+            __func__);
+        return -1;
+    } else if (!sev_snp_enabled() &&
+               (sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+        error_setg(
+            errp,
+            "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
+            __func__);
+        return -1;
+    }
+    if (sev_features & ~sev_common->supported_sev_features) {
+        error_setg(errp,
+                   "%s: VMSA contains unsupported sev_features: %lX, "
+                   "supported features: %lX",
+                   __func__, sev_features, sev_common->supported_sev_features);
+        return -1;
+    }
+    return 0;
+}
+
+static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
+                                const struct sev_es_save_area *vmsa,
                                 Error **errp)
 {
     struct sev_es_save_area vmsa_check;
@@ -551,24 +586,10 @@ static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
     vmsa_check.x87_fcw = 0;
     vmsa_check.mxcsr = 0;
 
-    if (sev_snp_enabled()) {
-        if (vmsa_check.sev_features != SVM_SEV_FEAT_SNP_ACTIVE) {
-            error_setg(errp,
-                       "%s: sev_features in the VMSA contains an unsupported "
-                       "value. For SEV-SNP, sev_features must be set to %x.",
-                       __func__, SVM_SEV_FEAT_SNP_ACTIVE);
-            return -1;
-        }
-        vmsa_check.sev_features = 0;
-    } else {
-        if (vmsa_check.sev_features != 0) {
-            error_setg(errp,
-                       "%s: sev_features in the VMSA contains an unsupported "
-                       "value. For SEV-ES and SEV, sev_features must be "
-                       "set to 0.", __func__);
-            return -1;
-        }
+    if (check_sev_features(sev_common, vmsa_check.sev_features, errp) < 0) {
+        return -1;
     }
+    vmsa_check.sev_features = 0;
 
     if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
         error_setg(errp,
@@ -1722,6 +1743,39 @@ static int sev_snp_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_SNP_VM;
 }
 
+static int sev_init_supported_features(ConfidentialGuestSupport *cgs,
+                                       SevCommonState *sev_common, Error **errp)
+{
+    X86ConfidentialGuestClass *x86_klass =
+                               X86_CONFIDENTIAL_GUEST_GET_CLASS(cgs);
+    /*
+     * Older kernels do not support query or setting of sev_features. In this
+     * case the set of supported features must be zero to match the settings
+     * in the kernel.
+     */
+    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) ==
+        KVM_X86_DEFAULT_VM) {
+        sev_common->supported_sev_features = 0;
+        return 0;
+    }
+
+    /* Query KVM for the supported set of sev_features */
+    struct kvm_device_attr attr = {
+        .group = KVM_X86_GRP_SEV,
+        .attr = KVM_X86_SEV_VMSA_FEATURES,
+        .addr = (unsigned long)&sev_common->supported_sev_features,
+    };
+    if (kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr) < 0) {
+        error_setg(errp, "%s: failed to query supported sev_features",
+                   __func__);
+        return -1;
+    }
+    if (sev_snp_enabled()) {
+        sev_common->supported_sev_features |= SVM_SEV_FEAT_SNP_ACTIVE;
+    }
+    return 0;
+}
+
 static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     char *devname;
@@ -1802,6 +1856,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    if (sev_init_supported_features(cgs, sev_common, errp) < 0) {
+        return -1;
+    }
+
     trace_kvm_sev_init();
     switch (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common))) {
     case KVM_X86_DEFAULT_VM:
@@ -1813,6 +1871,40 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     case KVM_X86_SEV_ES_VM:
     case KVM_X86_SNP_VM: {
         struct kvm_sev_init args = { 0 };
+        MachineState *machine = MACHINE(qdev_get_machine());
+        X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
+
+        /*
+         * If configuration is provided via an IGVM file then the IGVM file
+         * might contain configuration of the initial vcpu context. For SEV
+         * the vcpu context includes the sev_features which should be applied
+         * to the vcpu.
+         *
+         * KVM does not synchronize sev_features from CPU state. Instead it
+         * requires sev_features to be provided as part of this initialization
+         * call which is subsequently automatically applied to the VMSA of
+         * each vcpu.
+         *
+         * The IGVM file is normally processed after initialization. Therefore
+         * we need to pre-process it here to extract sev_features in order to
+         * provide it to KVM_SEV_INIT2. Each cgs_* function that is called by
+         * the IGVM processor detects this pre-process by observing the state
+         * as SEV_STATE_UNINIT.
+         */
+        if (x86machine->igvm) {
+            if (IGVM_CFG_GET_CLASS(x86machine->igvm)
+                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
+                -1) {
+                return -1;
+            }
+            /*
+             * KVM maintains a bitmask of allowed sev_features. This does not
+             * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
+             * itself. Therefore we need to clear this flag.
+             */
+            args.vmsa_features = sev_common->sev_features &
+                                 ~SVM_SEV_FEAT_SNP_ACTIVE;
+        }
 
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
         break;
@@ -2417,6 +2509,24 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        if ((cpu_index == 0) && (memory_type == CGS_PAGE_TYPE_VMSA)) {
+            const struct sev_es_save_area *sa =
+                (const struct sev_es_save_area *)ptr;
+            if (len < sizeof(*sa)) {
+                error_setg(errp, "%s: invalid VMSA length encountered",
+                           __func__);
+                return -1;
+            }
+            if (check_sev_features(sev_common, sa->sev_features, errp) < 0) {
+                return -1;
+            }
+            sev_common->sev_features = sa->sev_features;
+        }
+        return 0;
+    }
+
     if (!sev_enabled()) {
         error_setg(errp, "%s: attempt to configure guest memory, but SEV "
                      "is not enabled", __func__);
@@ -2436,7 +2546,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
                        __func__);
             return -1;
         }
-        if (check_vmsa_supported(gpa, (const struct sev_es_save_area *)ptr,
+        if (check_vmsa_supported(sev_common, gpa,
+                                 (const struct sev_es_save_area *)ptr,
                                  errp) < 0) {
             return -1;
         }
@@ -2493,6 +2604,12 @@ static int cgs_get_mem_map_entry(int index,
     struct e820_entry *table;
     int num_entries;
 
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 1;
+    }
+
     num_entries = e820_get_table(&table);
     if ((index < 0) || (index >= num_entries)) {
         return 1;
@@ -2524,6 +2641,12 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                                 uint32_t policy_data1_size, void *policy_data2,
                                 uint32_t policy_data2_size, Error **errp)
 {
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 0;
+    }
+
     if (policy_type != GUEST_POLICY_SEV) {
         error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
         __func__, policy_type);
-- 
2.43.0


