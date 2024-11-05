Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71541D1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DG2-0003wI-Ad; Tue, 05 Nov 2024 01:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEO-0002gD-2m
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:00 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEL-0001vj-7w
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788797; x=1762324797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8SBCXjeKuMoMULo/dUKnjmMZB22IpUgmloGXn6p/MT4=;
 b=mx+IZt1N+waJSvcn1QzbKrXX7+XqjB5+7q4ZRc2GE4Gc0836QC/n8nyb
 zJV7NeJKj3/vXIWBZ6+n8HJNs4ROrWUqoC4WcnozGZohMrFkp1UsihSX2
 9uD26QXKdhgpCJIg/PpxvSni488M0o9kfBj+RQKjXxVfiwr8ljQeQ0pYt
 OpLXf38Kh1v4dgExTYKH9Dr4SQNFwM/tO7u0F73V5WC1YUZwhELDXEW93
 NBvu3ZMPmijcLO6ylO9czoGUzOGv2rDbIyqcfMUSMl6xqIXBJVptN9QQR
 FrkRmCPtddjeeRgnDBbENH8PO4IT70vGScGzl0o7QBsn4GlsexWO8Dz7D A==;
X-CSE-ConnectionGUID: SjTKgVkiQzuM3jkK3YT8qw==
X-CSE-MsgGUID: qk9B9KSOTuG7T2NJ0IU+dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689821"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:39:40 -0800
X-CSE-ConnectionGUID: 02jwTyEjT4W7WgQAzjU8Tg==
X-CSE-MsgGUID: bd629gL+QAag3jRWFrdaqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989718"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:39:35 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 46/60] i386/cgs: Rename *mask_cpuid_features() to
 *adjust_cpuid_features()
Date: Tue,  5 Nov 2024 01:23:54 -0500
Message-Id: <20241105062408.3533704-47-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

Because for TDX case, there are also fixed-1 bits that enfored by TDX
module.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/confidential-guest.h | 20 ++++++++++----------
 target/i386/kvm/kvm.c            |  2 +-
 target/i386/sev.c                |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 4b7ea91023dc..2dde29889c23 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -41,8 +41,8 @@ struct X86ConfidentialGuestClass {
     int (*kvm_type)(X86ConfidentialGuest *cg);
     void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
     void (*cpu_realizefn)(X86ConfidentialGuest *cg, CPUState *cpu, Error **errp);
-    uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
-                                    int reg, uint32_t value);
+    uint32_t (*adjust_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature,
+                                      uint32_t index, int reg, uint32_t value);
 };
 
 /**
@@ -83,21 +83,21 @@ static inline void x86_confidenetial_guest_cpu_realizefn(X86ConfidentialGuest *c
 }
 
 /**
- * x86_confidential_guest_mask_cpuid_features:
+ * x86_confidential_guest_adjust_cpuid_features:
  *
- * Removes unsupported features from a confidential guest's CPUID values, returns
- * the value with the bits removed.  The bits removed should be those that KVM
- * provides independent of host-supported CPUID features, but are not supported by
- * the confidential computing firmware.
+ * Adjust the supported features from a confidential guest's CPUID values,
+ * returns the adjusted value.  There are bits being removed that are not
+ * supported by the confidential computing firmware or bits being added that
+ * are forcibly exposed to guest by the confidential computing firmware.
  */
-static inline int x86_confidential_guest_mask_cpuid_features(X86ConfidentialGuest *cg,
+static inline int x86_confidential_guest_adjust_cpuid_features(X86ConfidentialGuest *cg,
                                                              uint32_t feature, uint32_t index,
                                                              int reg, uint32_t value)
 {
     X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
 
-    if (klass->mask_cpuid_features) {
-        return klass->mask_cpuid_features(cg, feature, index, reg, value);
+    if (klass->adjust_cpuid_features) {
+        return klass->adjust_cpuid_features(cg, feature, index, reg, value);
     } else {
         return value;
     }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e47aa32233e6..f067961fba43 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -576,7 +576,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     }
 
     if (current_machine->cgs) {
-        ret = x86_confidential_guest_mask_cpuid_features(
+        ret = x86_confidential_guest_adjust_cpuid_features(
             X86_CONFIDENTIAL_GUEST(current_machine->cgs),
             function, index, reg, ret);
     }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1a4eb1ada624..4e6582c6a666 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -946,7 +946,7 @@ out:
 }
 
 static uint32_t
-sev_snp_mask_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
+sev_snp_adjust_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
                             int reg, uint32_t value)
 {
     switch (feature) {
@@ -2404,7 +2404,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     klass->launch_finish = sev_snp_launch_finish;
     klass->launch_update_data = sev_snp_launch_update_data;
     klass->kvm_init = sev_snp_kvm_init;
-    x86_klass->mask_cpuid_features = sev_snp_mask_cpuid_features;
+    x86_klass->adjust_cpuid_features = sev_snp_adjust_cpuid_features;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
     object_class_property_add(oc, "policy", "uint64",
-- 
2.34.1


