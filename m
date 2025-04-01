Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0CEC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbz5-0006b1-Vu; Tue, 01 Apr 2025 09:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbvA-0001Z1-4j
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:53 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbv8-0006ZP-27
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515090; x=1775051090;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JKMlucssmDcGsanH6kb+uP0DlL1BGA8NocL5uyi4aSQ=;
 b=DxhoRu/n/t5pjBnSlNRaQoLtHE0admoU0CqfvtnVXqBGw4nSHQxvsSgA
 OywNacpb8l7NNx+jFpdvtRhpao/kQpdhEK9M2Y9AdDD/MT6y9UXU+XeW7
 wv6vvGyItmouOHsRN0bfcbSBcfyIO1bU3IT5FuU+O+Y8FraFj5oXk0SMM
 INR+0i5GSMMCp2ta/tTAnyP/UK897Q21lRd/DUecU2QH48l4LLexJQFBD
 oDHOOcfnYkeGPRuoGdqNAexhJXX8kxhIKS4+G0pjjIGSqNEnvWfWLDC5G
 vv/yuAeU4KtYP7n7esWyfYf+iJQ8Mz6evgb+R3mPcdswHque7+hObCWDw Q==;
X-CSE-ConnectionGUID: vpNHQca8RfqfSW77BUIeEg==
X-CSE-MsgGUID: OJuJFXDTTK6UjYsTAvbShw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433572"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433572"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:17 -0700
X-CSE-ConnectionGUID: soV37tHIRrqHZ3XcBXxZZw==
X-CSE-MsgGUID: kODZuYubSb+ZnGe13hBtWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640269"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:15 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 50/55] i386/cgs: Introduce
 x86_confidential_guest_check_features()
Date: Tue,  1 Apr 2025 09:02:00 -0400
Message-Id: <20250401130205.2198253-51-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

To do cgs specific feature checking. Note the feature checking in
x86_cpu_filter_features() is valid for non-cgs VMs. For cgs VMs like
TDX, what features can be supported has more restrictions.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/confidential-guest.h | 13 +++++++++++++
 target/i386/kvm/kvm.c            |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 777d43cc9688..48b88dbd3130 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -42,6 +42,7 @@ struct X86ConfidentialGuestClass {
     void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
     uint32_t (*adjust_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature,
                                       uint32_t index, int reg, uint32_t value);
+    int (*check_features)(X86ConfidentialGuest *cg, CPUState *cs);
 };
 
 /**
@@ -91,4 +92,16 @@ static inline int x86_confidential_guest_adjust_cpuid_features(X86ConfidentialGu
     }
 }
 
+static inline int x86_confidential_guest_check_features(X86ConfidentialGuest *cg,
+                                                        CPUState *cs)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->check_features) {
+        return klass->check_features(cg, cs);
+    }
+
+    return 0;
+}
+
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 17d7bf6ae9aa..27b4a069d194 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2092,6 +2092,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     int r;
     Error *local_err = NULL;
 
+    if (current_machine->cgs) {
+        r = x86_confidential_guest_check_features(
+                X86_CONFIDENTIAL_GUEST(current_machine->cgs), cs);
+        if (r < 0) {
+            return r;
+        }
+    }
+
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
     cpuid_i = 0;
-- 
2.34.1


