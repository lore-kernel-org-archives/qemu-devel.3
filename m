Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740DDC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyr-0006Oc-MJ; Fri, 30 May 2025 03:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxZ-0003rp-AA
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxX-0007EI-En
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abyc5MGp/p2fy+/nmioc8fkBOfHgpuT306QRexbfTFI=;
 b=QWnkQj5ndp075+gQ4Z9LIxw+qJ8iBedgJV/zv/sR6Pnu3zEZlkhsQ8yL+02SPpRvAteS1s
 lM1JnaTvyhmlk29QZpsE3xL3655eZ40iRYGUHa5pvFL6s4dRDL0hB2xXYr7jcNVhGTEeUB
 CJO+s7ow74a2HGOzSJ9Xqc2OofP5msU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-8LBxSMuoPIOnhHGBzOA0QA-1; Fri, 30 May 2025 03:15:17 -0400
X-MC-Unique: 8LBxSMuoPIOnhHGBzOA0QA-1
X-Mimecast-MFC-AGG-ID: 8LBxSMuoPIOnhHGBzOA0QA_1748589316
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso158785266b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589315; x=1749194115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abyc5MGp/p2fy+/nmioc8fkBOfHgpuT306QRexbfTFI=;
 b=I45fyz5H8+iisPXj5os6B/AGPGIlhVaMMUla3/SRvfl3yfLwoRiLU2FYKDfdbFXhVW
 Gz1of6QnNWdncyLX9l2lc8qqqe5EKt6JV8WCShBLs53GZWTgrhXqfVxxe9go+JBnWr2v
 maq5hXNHIk0dgfy2BZ34RJqO0UXS6zYVDOEyqHSFf5JCxQPJZdTDVPnmG/1XCapY1cd6
 BsGpxttZ/P/JPQdYBNlBp3uU6TgN5HAX5JK7Go//nYpkqcgGEWUybafF7oxCSelY/CQo
 wx091y66klAUadQbLN69F442MAPNV+BfbXer3vwIfUrA2HuGQkIkvl9DtAkeRkus7Kyf
 VLUQ==
X-Gm-Message-State: AOJu0YyLL/5/D+g9NoA1K9dwsBMEj/WNJH/pPZgfEnPC2i99fyOsZTPE
 unDaHJoxlLoPdvdTlZKEumRHXAMa33r5EGRrkixTsWloNL485xhHve0VP0zMaqbcb3kz8lRYpwU
 kQKwf3JjgghKOOE2FKVPzRuw8BdihoTZzlAbY8QL0NAAfpwaAMRXWm3QsyDFNGZpy9AmOrYDYnA
 eq+xL9U8Qgc5PUfKNkFMQmPAB5Ap1WvGcPs3YAFj4U
X-Gm-Gg: ASbGnct8NoFAltebSbDoX0azqOzkoUBs6MS2yoZc3Rb12uiVGgBAfnKzc29euNyelDt
 EtjABP4WHH5wiXRELuSXq3rptKiJQ0jxyeQNObXkHA+bZkBGxBVVln0tIyDL7oFbeeGBB42R6n4
 7sSdtG1O+LWJIp2lpdGjuEZJdA66wbegMKpovUXr6XktK36aewF+94+6G/4fbkk4WX+tbsWUef+
 MyXzWyqka6xyO9i4coZkmNUK1vNNfkpj7i+4DOfUecKDAZSaW3Hsa8mPLdSPeuOHpNNrKGAqMs1
 zLuUQtS0TF6Hyg==
X-Received: by 2002:a17:907:9726:b0:ad8:adf5:f7f2 with SMTP id
 a640c23a62f3a-adb36be2347mr108548966b.31.1748589314845; 
 Fri, 30 May 2025 00:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6gJi0iaX4mZIEKHwXNMovJS5+ablju5w00ZKAi2F9OioPz0xy9naqPdUuhjV8QJR/n29rWg==
X-Received: by 2002:a17:907:9726:b0:ad8:adf5:f7f2 with SMTP id
 a640c23a62f3a-adb36be2347mr108540866b.31.1748589313422; 
 Fri, 30 May 2025 00:15:13 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84e72csm275933366b.76.2025.05.30.00.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 56/77] i386/tdx: Implement adjust_cpuid_features() for TDX
Date: Fri, 30 May 2025 09:12:26 +0200
Message-ID: <20250530071250.2050910-57-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Maintain a TDX specific supported CPUID set, and use it to mask the
common supported CPUID value of KVM. It can avoid newly added supported
features (reported via KVM_GET_SUPPORTED_CPUID) for common VMs being
falsely reported as supported for TDX.

As the first step, initialize the TDX supported CPUID set with all the
configurable CPUID bits. It's not complete because there are other CPUID
bits are supported for TDX but not reported as directly configurable.
E.g. the XFAM related bits, attribute related bits and fixed-1 bits.
They will be handled in the future.

Also, what matters are the CPUID bits related to QEMU's feature word.
Only mask the CPUID leafs which are feature word leaf.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-45-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h          |  1 +
 target/i386/kvm/kvm_i386.h |  1 +
 target/i386/cpu.c          | 16 ++++++++++++++++
 target/i386/kvm/kvm.c      |  2 +-
 target/i386/kvm/tdx.c      | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ad0e3d8cdd0..7ffcf91b014 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2502,6 +2502,7 @@ void cpu_set_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
+bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg);
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index dc696cb7238..484a1de84d5 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -62,6 +62,7 @@ void kvm_update_msi_routes_all(void *private, bool global,
 struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
                                           uint32_t function,
                                           uint32_t index);
+uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg);
 uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                              uint32_t cpuid_i);
 #endif /* CONFIG_KVM */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6a97d7549ec..5aacb62f081 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1678,6 +1678,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     },
 };
 
+bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg)
+{
+    FeatureWordInfo *wi;
+    FeatureWord w;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        wi = &feature_word_info[w];
+        if (wi->type == CPUID_FEATURE_WORD && wi->cpuid.eax == feature &&
+            (!wi->cpuid.needs_ecx || wi->cpuid.ecx == index) &&
+            wi->cpuid.reg == reg) {
+            return true;
+        }
+    }
+    return false;
+}
+
 typedef struct FeatureMask {
     FeatureWord index;
     uint64_t mask;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0d474634312..cd87f5502a3 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -394,7 +394,7 @@ static bool host_tsx_broken(void)
 
 /* Returns the value for a specific register on the cpuid entry
  */
-static uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
+uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
 {
     uint32_t ret = 0;
     switch (reg) {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 68ed3b9f987..e3b7ad6d146 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -45,6 +45,7 @@
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
+static struct kvm_cpuid2 *tdx_supported_cpuid;
 
 /* Valid after kvm_arch_init()->confidential_guest_kvm_init()->tdx_kvm_init() */
 bool is_tdx_vm(void)
@@ -366,6 +367,20 @@ static Notifier tdx_machine_done_notify = {
     .notify = tdx_finalize_vm,
 };
 
+static void tdx_setup_supported_cpuid(void)
+{
+    if (tdx_supported_cpuid) {
+        return;
+    }
+
+    tdx_supported_cpuid = g_malloc0(sizeof(*tdx_supported_cpuid) +
+                    KVM_MAX_CPUID_ENTRIES * sizeof(struct kvm_cpuid_entry2));
+
+    memcpy(tdx_supported_cpuid->entries, tdx_caps->cpuid.entries,
+           tdx_caps->cpuid.nent * sizeof(struct kvm_cpuid_entry2));
+    tdx_supported_cpuid->nent = tdx_caps->cpuid.nent;
+}
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -403,6 +418,8 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    tdx_setup_supported_cpuid();
+
     /* TDX relies on KVM_HC_MAP_GPA_RANGE to handle TDG.VP.VMCALL<MapGPA> */
     if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
         return -EOPNOTSUPP;
@@ -440,6 +457,22 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
     x86cpu->enable_cpuid_0x1f = true;
 }
 
+static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
+                                          uint32_t feature, uint32_t index,
+                                          int reg, uint32_t value)
+{
+    struct kvm_cpuid_entry2 *e;
+
+    if (is_feature_word_cpuid(feature, index, reg)) {
+        e = cpuid_find_entry(tdx_supported_cpuid, feature, index);
+        if (e) {
+            value &= cpuid_entry_get_reg(e, reg);
+        }
+    }
+
+    return value;
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -834,4 +867,5 @@ static void tdx_guest_class_init(ObjectClass *oc, const void *data)
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
+    x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
 }
-- 
2.49.0


