Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089ECC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHK0-00042x-9x; Mon, 14 Jul 2025 07:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzs-00018M-AJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzp-0001sn-Cn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EraEnuG15QUJZaSBHNd845dFPUl1vsqabBZ9Zpw8ues=;
 b=Fe91064qmNJvCwxkR0q8YRA99KXzxz8NDOM56E/CWwWl85UMlU+0naCB9WULc0+C++7FxS
 mS96ssiYEiAev+423OIgwz7aWbTLoxE96Fn1dYlLw/80xUIJj3qgyj9fh6y84pPnkmBj7e
 j9Gm9C9UXeAECNhUjlNVjWAvvbPoACQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-SlM8aBGaNxmpua3oogU2HQ-1; Mon, 14 Jul 2025 07:05:19 -0400
X-MC-Unique: SlM8aBGaNxmpua3oogU2HQ-1
X-Mimecast-MFC-AGG-ID: SlM8aBGaNxmpua3oogU2HQ_1752491118
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a579058758so1669246f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491116; x=1753095916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EraEnuG15QUJZaSBHNd845dFPUl1vsqabBZ9Zpw8ues=;
 b=DzG8SKNd43ccbyeBQJe1KL2H415VSKQ3/xJavsEs6c7T4iFCVjt6xiHmzYi3N5fQ+u
 48CIh9jJq2g/t8+9aLO56Bu3Lbet50Y0KI6yHoyogAFIjACHeHFhqb1WpMVb98+J8DNM
 DzNaV4rS4YJW/dCNkOwRKwU7/hqnwnhvZL1L64qHaKr/y4bjFDcBc/0VmepMauThhsaB
 xsd4uGDpT3EqYqMZA3Bc8Pa/tjpatSgr41vTqyZ6SyeN8/81oDdSDLlfwjHGuCBwDrZm
 5bxzPW/eiT3AWpXk8Kk+YDvlPKM4nkSG70c0lCWWrErwJlgSZM77XDr4ONFfss5wJAzH
 UfCw==
X-Gm-Message-State: AOJu0YyN7YaaERz9iZMv//R4Qyibhd/XJHxpclT26KKzuc4bcg0XWnyr
 mpoGWIG0xH38BL8ueSR+xjoElH1dQi8kM5tUovQrgIMEtZK1emNipxWHgrmbDAVn4y3XR8Vpnxp
 Q5owWRAGpX97bfBq5Qs/7cGtlM5TP5q4w4k97fqfnpQ4oi7wR0TXZa5xKTc4tTXUgeUPFqu/T+K
 kSqypIhGrCieLMsyiacGCRzheXC4hNbLNlb3M9S/kE
X-Gm-Gg: ASbGncuLNwlt64qgSDzFO15WTRcCF0B9eNvi5Wr8bFY/7zMzHbGoVcxP/PeVfqM3nn2
 qhXQdJ4/oj0cjFW37Eq6eQ0WwePTx795D1aUG7QxPGzFbutZBwsU02Zlctivb4WJzjRiJQf5YWT
 7UO4tjLCirIlgCdy55YI2p7KNMNIiC3wJej5yJCpHXxA1pKEU4MwawXL6uCOAoA2O4iF6MoSr6+
 +C+3av1F96mOWglWBP0KuABIFU2jc4jBN82EWTUJi6iCjPVhY0ojR8Za7+Nphhud6FrYpBSSXvc
 2wgzJ2ajJjGf8TueDonCC9SgzLeEFbuRBuu67v3P2PI=
X-Received: by 2002:a05:6000:25fc:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3b5f18dc449mr11467187f8f.38.1752491116191; 
 Mon, 14 Jul 2025 04:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWTPSlS+/tu2naGURDAVma1g4jFnsUJ01SV0iQPtZyWrN6+CI0BvMjBIBx9Tt5Wk3HDgjUrw==
X-Received: by 2002:a05:6000:25fc:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3b5f18dc449mr11467151f8f.38.1752491115612; 
 Mon, 14 Jul 2025 04:05:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14d07sm12278723f8f.66.2025.07.14.04.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 25/77] i386/sev: Implement ConfidentialGuestSupport functions
 for SEV
Date: Mon, 14 Jul 2025 13:03:14 +0200
Message-ID: <20250714110406.117772-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

The ConfidentialGuestSupport object defines a number of virtual
functions that are called during processing of IGVM directives to query
or configure initial guest state. In order to support processing of IGVM
files, these functions need to be implemented by relevant isolation
hardware support code such as SEV.

This commit implements the required functions for SEV-ES and adds
support for processing IGVM files for configuring the guest.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/7145835f729e6195f2fbda308aa90e089a96ae6e.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.h |   2 +
 target/i386/sev.c | 254 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 246 insertions(+), 10 deletions(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 38caa849f5e..d2eb06db321 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -44,6 +44,8 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_SMT      0x10000
 #define SEV_SNP_POLICY_DBG      0x80000
 
+#define SVM_SEV_FEAT_SNP_ACTIVE 1
+
 typedef struct SevKernelLoaderContext {
     char *setup_data;
     size_t setup_size;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index a13f91e615d..1296f4feb62 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -41,7 +41,9 @@
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "system/address-spaces.h"
+#include "hw/i386/e820_memory_layout.h"
 #include "qemu/queue.h"
+#include "qemu/cutils.h"
 
 OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
 OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
@@ -50,6 +52,9 @@ OBJECT_DECLARE_TYPE(SevSnpGuestState, SevCommonStateClass, SEV_SNP_GUEST)
 /* hard code sha256 digest size */
 #define HASH_SIZE 32
 
+/* Hard coded GPA that KVM uses for the VMSA */
+#define KVM_VMSA_GPA 0xFFFFFFFFF000
+
 /* Convert between SEV-ES VMSA and SegmentCache flags/attributes */
 #define FLAGS_VMSA_TO_SEGCACHE(flags) \
     ((((flags) & 0xff00) << 12) | (((flags) & 0xff) << 8))
@@ -480,6 +485,103 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
+static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
+                                Error **errp)
+{
+    struct sev_es_save_area vmsa_check;
+
+    /*
+     * KVM always populates the VMSA at a fixed GPA which cannot be modified
+     * from userspace. Specifying a different GPA will not prevent the guest
+     * from starting but will cause the launch measurement to be different
+     * from expected. Therefore check that the provided GPA matches the KVM
+     * hardcoded value.
+     */
+    if (gpa != KVM_VMSA_GPA) {
+        error_setg(errp,
+                "%s: The VMSA GPA must be %lX but is specified as %lX",
+                __func__, KVM_VMSA_GPA, gpa);
+        return -1;
+    }
+
+    /*
+     * Clear all supported fields so we can then check the entire structure
+     * is zero.
+     */
+    memcpy(&vmsa_check, vmsa, sizeof(struct sev_es_save_area));
+    memset(&vmsa_check.es, 0, sizeof(vmsa_check.es));
+    memset(&vmsa_check.cs, 0, sizeof(vmsa_check.cs));
+    memset(&vmsa_check.ss, 0, sizeof(vmsa_check.ss));
+    memset(&vmsa_check.ds, 0, sizeof(vmsa_check.ds));
+    memset(&vmsa_check.fs, 0, sizeof(vmsa_check.fs));
+    memset(&vmsa_check.gs, 0, sizeof(vmsa_check.gs));
+    memset(&vmsa_check.gdtr, 0, sizeof(vmsa_check.gdtr));
+    memset(&vmsa_check.idtr, 0, sizeof(vmsa_check.idtr));
+    memset(&vmsa_check.ldtr, 0, sizeof(vmsa_check.ldtr));
+    memset(&vmsa_check.tr, 0, sizeof(vmsa_check.tr));
+    vmsa_check.efer = 0;
+    vmsa_check.cr0 = 0;
+    vmsa_check.cr3 = 0;
+    vmsa_check.cr4 = 0;
+    vmsa_check.xcr0 = 0;
+    vmsa_check.dr6 = 0;
+    vmsa_check.dr7 = 0;
+    vmsa_check.rax = 0;
+    vmsa_check.rcx = 0;
+    vmsa_check.rdx = 0;
+    vmsa_check.rbx = 0;
+    vmsa_check.rsp = 0;
+    vmsa_check.rbp = 0;
+    vmsa_check.rsi = 0;
+    vmsa_check.rdi = 0;
+    vmsa_check.r8 = 0;
+    vmsa_check.r9 = 0;
+    vmsa_check.r10 = 0;
+    vmsa_check.r11 = 0;
+    vmsa_check.r12 = 0;
+    vmsa_check.r13 = 0;
+    vmsa_check.r14 = 0;
+    vmsa_check.r15 = 0;
+    vmsa_check.rip = 0;
+    vmsa_check.rflags = 0;
+
+    vmsa_check.g_pat = 0;
+    vmsa_check.xcr0 = 0;
+
+    vmsa_check.x87_fcw = 0;
+    vmsa_check.mxcsr = 0;
+
+    if (sev_snp_enabled()) {
+        if (vmsa_check.sev_features != SVM_SEV_FEAT_SNP_ACTIVE) {
+            error_setg(errp,
+                       "%s: sev_features in the VMSA contains an unsupported "
+                       "value. For SEV-SNP, sev_features must be set to %x.",
+                       __func__, SVM_SEV_FEAT_SNP_ACTIVE);
+            return -1;
+        }
+        vmsa_check.sev_features = 0;
+    } else {
+        if (vmsa_check.sev_features != 0) {
+            error_setg(errp,
+                       "%s: sev_features in the VMSA contains an unsupported "
+                       "value. For SEV-ES and SEV, sev_features must be "
+                       "set to 0.", __func__);
+            return -1;
+        }
+    }
+
+    if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
+        error_setg(errp,
+                "%s: The VMSA contains fields that are not "
+                "synchronized with KVM. Continuing would result in "
+                "either unpredictable guest behavior, or a "
+                "mismatched launch measurement.",
+                __func__);
+        return -1;
+    }
+    return 0;
+}
+
 static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
                                uint32_t ctx_len, hwaddr gpa, Error **errp)
 {
@@ -1491,18 +1593,26 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp->kvm_finish_conf;
 
     /*
-     * To boot the SNP guest, the hypervisor is required to populate the CPUID
-     * and Secrets page before finalizing the launch flow. The location of
-     * the secrets and CPUID page is available through the OVMF metadata GUID.
+     * Populate all the metadata pages if not using an IGVM file. In the case
+     * where an IGVM file is provided it will be used to configure the metadata
+     * pages directly.
      */
-    metadata = pc_system_get_ovmf_sev_metadata_ptr();
-    if (metadata == NULL) {
-        error_report("%s: Failed to locate SEV metadata header", __func__);
-        exit(1);
-    }
+    if (!X86_MACHINE(qdev_get_machine())->igvm) {
+        /*
+         * To boot the SNP guest, the hypervisor is required to populate the
+         * CPUID and Secrets page before finalizing the launch flow. The
+         * location of the secrets and CPUID page is available through the
+         * OVMF metadata GUID.
+         */
+        metadata = pc_system_get_ovmf_sev_metadata_ptr();
+        if (metadata == NULL) {
+            error_report("%s: Failed to locate SEV metadata header", __func__);
+            exit(1);
+        }
 
-    /* Populate all the metadata pages */
-    snp_populate_metadata_pages(sev_snp, metadata);
+        /* Populate all the metadata pages */
+        snp_populate_metadata_pages(sev_snp, metadata);
+    }
 
     QTAILQ_FOREACH(data, &launch_update, next) {
         ret = sev_snp_launch_update(sev_snp, data);
@@ -2290,6 +2400,124 @@ static void sev_common_set_kernel_hashes(Object *obj, bool value, Error **errp)
     SEV_COMMON(obj)->kernel_hashes = value;
 }
 
+static bool cgs_check_support(ConfidentialGuestPlatformType platform,
+                             uint16_t platform_version, uint8_t highest_vtl,
+                             uint64_t shared_gpa_boundary)
+{
+    return (((platform == CGS_PLATFORM_SEV_SNP) && sev_snp_enabled()) ||
+            ((platform == CGS_PLATFORM_SEV_ES) && sev_es_enabled()) ||
+            ((platform == CGS_PLATFORM_SEV) && sev_enabled()));
+}
+
+static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                               ConfidentialGuestPageType memory_type,
+                               uint16_t cpu_index, Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
+
+    if (!sev_enabled()) {
+        error_setg(errp, "%s: attempt to configure guest memory, but SEV "
+                     "is not enabled", __func__);
+        return -1;
+    }
+
+    switch (memory_type) {
+    case CGS_PAGE_TYPE_NORMAL:
+    case CGS_PAGE_TYPE_ZERO:
+        return klass->launch_update_data(sev_common, gpa, ptr, len, errp);
+
+    case CGS_PAGE_TYPE_VMSA:
+        if (!sev_es_enabled()) {
+            error_setg(errp,
+                       "%s: attempt to configure initial VMSA, but SEV-ES "
+                       "is not supported",
+                       __func__);
+            return -1;
+        }
+        if (check_vmsa_supported(gpa, (const struct sev_es_save_area *)ptr,
+                                 errp) < 0) {
+            return -1;
+        }
+        return sev_set_cpu_context(cpu_index, ptr, len, gpa, errp);
+
+    case CGS_PAGE_TYPE_UNMEASURED:
+        if (sev_snp_enabled()) {
+            return snp_launch_update_data(
+                gpa, ptr, len, KVM_SEV_SNP_PAGE_TYPE_UNMEASURED, errp);
+        }
+        /* No action required if not SEV-SNP */
+        return 0;
+
+    case CGS_PAGE_TYPE_SECRETS:
+        if (!sev_snp_enabled()) {
+            error_setg(errp,
+                       "%s: attempt to configure secrets page, but SEV-SNP "
+                       "is not supported",
+                       __func__);
+            return -1;
+        }
+        return snp_launch_update_data(gpa, ptr, len,
+                                      KVM_SEV_SNP_PAGE_TYPE_SECRETS, errp);
+
+    case CGS_PAGE_TYPE_REQUIRED_MEMORY:
+        if (kvm_convert_memory(gpa, len, true) < 0) {
+            error_setg(
+                errp,
+                "%s: failed to configure required memory. gpa: %lX, type: %d",
+                __func__, gpa, memory_type);
+            return -1;
+        }
+        return 0;
+
+    case CGS_PAGE_TYPE_CPUID:
+        if (!sev_snp_enabled()) {
+            error_setg(errp,
+                       "%s: attempt to configure CPUID page, but SEV-SNP "
+                       "is not supported",
+                       __func__);
+            return -1;
+        }
+        return snp_launch_update_cpuid(gpa, ptr, len, errp);
+    }
+    error_setg(errp, "%s: failed to update guest. gpa: %lX, type: %d", __func__,
+               gpa, memory_type);
+    return -1;
+}
+
+static int cgs_get_mem_map_entry(int index,
+                                 ConfidentialGuestMemoryMapEntry *entry,
+                                 Error **errp)
+{
+    struct e820_entry *table;
+    int num_entries;
+
+    num_entries = e820_get_table(&table);
+    if ((index < 0) || (index >= num_entries)) {
+        return 1;
+    }
+    entry->gpa = table[index].address;
+    entry->size = table[index].length;
+    switch (table[index].type) {
+    case E820_RAM:
+        entry->type = CGS_MEM_RAM;
+        break;
+    case E820_RESERVED:
+        entry->type = CGS_MEM_RESERVED;
+        break;
+    case E820_ACPI:
+        entry->type = CGS_MEM_ACPI;
+        break;
+    case E820_NVS:
+        entry->type = CGS_MEM_NVS;
+        break;
+    case E820_UNUSABLE:
+        entry->type = CGS_MEM_UNUSABLE;
+        break;
+    }
+    return 0;
+}
+
 static void
 sev_common_class_init(ObjectClass *oc, const void *data)
 {
@@ -2313,6 +2541,8 @@ static void
 sev_common_instance_init(Object *obj)
 {
     SevCommonState *sev_common = SEV_COMMON(obj);
+    ConfidentialGuestSupportClass *cgs =
+        CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(obj);
 
     sev_common->kvm_type = -1;
 
@@ -2323,6 +2553,10 @@ sev_common_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "reduced-phys-bits",
                                    &sev_common->reduced_phys_bits,
                                    OBJ_PROP_FLAG_READWRITE);
+    cgs->check_support = cgs_check_support;
+    cgs->set_guest_state = cgs_set_guest_state;
+    cgs->get_mem_map_entry = cgs_get_mem_map_entry;
+
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
 
-- 
2.50.0


