Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805E6C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxp3-0004vp-Ud; Wed, 03 Jul 2024 07:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxox-0004tk-7a
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxop-0006Xh-Sj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 60E4A21C10;
 Wed,  3 Jul 2024 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3artvIvRGHHQxXWIoCm5dYwF+UZGBq2ffWBQ1XLlO/g=;
 b=Cphn8NiySaJ4OWbI+DpeGHY6o9Wfzsce1CCNPxzpo1clBRYIcPrHTMvX7YXnns7QVOdte2
 RSOP+DaMZ+WmwAzzsl3GbQQIYbwZYxkINoDLTBv7em+9YLVb/OQanZZlydz2qWDubM7qwy
 wxH+KHs5puKdhI+mLYSgKe5K6Xo58D0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3artvIvRGHHQxXWIoCm5dYwF+UZGBq2ffWBQ1XLlO/g=;
 b=Cphn8NiySaJ4OWbI+DpeGHY6o9Wfzsce1CCNPxzpo1clBRYIcPrHTMvX7YXnns7QVOdte2
 RSOP+DaMZ+WmwAzzsl3GbQQIYbwZYxkINoDLTBv7em+9YLVb/OQanZZlydz2qWDubM7qwy
 wxH+KHs5puKdhI+mLYSgKe5K6Xo58D0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A077213A7F;
 Wed,  3 Jul 2024 11:06:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eAoXJbYwhWZ6cgAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Jul 2024 11:06:30 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v4 17/17] sev: Provide sev_features flags from IGVM VMSA to
 KVM_SEV_INIT2
Date: Wed,  3 Jul 2024 12:05:55 +0100
Message-ID: <e997ff9f286cf2688ec7df05104a5dbc175027ac.1720004383.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720004383.git.roy.hopkins@suse.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 R_RATELIMIT(0.00)[to_ip_from(RLm8d31jk6dhzwhww9bgqrb1jt)];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

IGVM files can contain an initial VMSA that should be applied to each
vcpu as part of the initial guest state. The sev_features flags are
provided as part of the VMSA structure. However, KVM only allows
sev_features to be set during initialization and not as the guest is
being prepared for launch.

This patch queries KVM for the supported set of sev_features flags and
processes the IGVM file during kvm_init to determine any sev_features
flags set in the IGVM file. These are then provided in the call to
KVM_SEV_INIT2 to ensure the guest state matches that specified in the
IGVM file.

This does cause the IGVM file to be processed twice. Firstly to extract
the sev_features then secondly to actually configure the guest. However,
the first pass is largely ignored meaning the overhead is minimal.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 target/i386/sev.c | 160 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 141 insertions(+), 19 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c4d0682d75..be64b3f902 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -117,6 +117,8 @@ struct SevCommonState {
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
     bool kernel_hashes;
+    uint64_t sev_features;
+    uint64_t supported_sev_features;
 
     /* runtime state */
     uint8_t api_major;
@@ -492,7 +494,40 @@ static void sev_apply_cpu_context(CPUState *cpu)
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
@@ -558,24 +593,10 @@ static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
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
@@ -1665,6 +1686,39 @@ static int sev_snp_kvm_type(X86ConfidentialGuest *cg)
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
@@ -1745,6 +1799,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    if (sev_init_supported_features(cgs, sev_common, errp) < 0) {
+        return -1;
+    }
+
     trace_kvm_sev_init();
     if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
@@ -1752,6 +1810,39 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
     } else {
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
+                    ->process(x86machine->igvm, machine->cgs, errp) == -1) {
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
     }
@@ -2348,6 +2439,24 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
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
@@ -2367,7 +2476,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
                        __func__);
             return -1;
         }
-        if (check_vmsa_supported(gpa, (const struct sev_es_save_area *)ptr,
+        if (check_vmsa_supported(sev_common, gpa,
+                                 (const struct sev_es_save_area *)ptr,
                                  errp) < 0) {
             return -1;
         }
@@ -2421,6 +2531,12 @@ static int cgs_get_mem_map_entry(int index,
                                  ConfidentialGuestMemoryMapEntry *entry,
                                  Error **errp)
 {
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 1;
+    }
+
     if ((index < 0) || (index >= e820_get_num_entries())) {
         return 1;
     }
@@ -2451,6 +2567,12 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
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


