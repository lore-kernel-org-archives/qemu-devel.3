Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1CBC0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJuN-0007kd-28; Fri, 24 Jan 2025 08:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJts-0006zr-Hh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:22 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJtq-00042W-S3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725947; x=1769261947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tR1BwcYVrk3irorerAFU49kWmu5J765/vc7Xg99OXgc=;
 b=CPXlOPgkhQaKFMV7jzbjhr2kACn4XgFwyyuAqFVXzjjrDSXRPm9spXPY
 jvb0CzsD+Lukf8bWNvtdxai9eFw5P5kWI3tl+PG5+FKXn4WdPpkHeUlC+
 eB1oLgWwQ67SbrcT3sN6YDthcoyuNMpdu9cEhjAkQFW+3ENwlTyQrY8yO
 A9gsVTIZGTRERt/tdgRC/wH553PNIccWliKkqv6YxhUdq/A/MfHUG/o0q
 b3TPHzwbsb2kF6boYtMdfxcQZgbSy/HfBR1Eu+iwTs5fj0gouxbaygynr
 tkn5WZzx8vUmCVs9m6MaXEPJIU9dsQJgZSJUmAg0R5MpLpLoB3rOgKdik Q==;
X-CSE-ConnectionGUID: vmxkpwsqSfGb1aYwLv+XXA==
X-CSE-MsgGUID: lG4zud6dSEOz3klGJ5kGbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246465"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246465"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:38:52 -0800
X-CSE-ConnectionGUID: sIRdno3xRHSOkSR1B5e4tQ==
X-CSE-MsgGUID: RryqET44Te+aiODkHS5GLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804371"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:38:48 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 29/52] i386/cpu: introduce
 x86_confidential_guest_cpu_instance_init()
Date: Fri, 24 Jan 2025 08:20:25 -0500
Message-Id: <20250124132048.3229049-30-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

To allow execute confidential guest specific cpu init operations.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - new patch;
---
 target/i386/confidential-guest.h | 11 +++++++++++
 target/i386/cpu.c                | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 164be7633a20..a86c42a47558 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -39,6 +39,7 @@ struct X86ConfidentialGuestClass {
 
     /* <public> */
     int (*kvm_type)(X86ConfidentialGuest *cg);
+    void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
     uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
                                     int reg, uint32_t value);
 };
@@ -59,6 +60,16 @@ static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
     }
 }
 
+static inline void x86_confidential_guest_cpu_instance_init(X86ConfidentialGuest *cg,
+                                                            CPUState *cpu)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->cpu_instance_init) {
+        klass->cpu_instance_init(cg, cpu);
+    }
+}
+
 /**
  * x86_confidential_guest_mask_cpuid_features:
  *
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 252a07fe823e..a369cf90f5f6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -36,6 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
+#include "confidential-guest.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "exec/address-spaces.h"
@@ -8156,6 +8157,15 @@ static void x86_cpu_post_initfn(Object *obj)
     }
 
     accel_cpu_instance_init(CPU(obj));
+
+#ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(object_dynamic_cast(qdev_get_machine(),
+                                                   TYPE_MACHINE));
+    if (ms && ms->cgs) {
+        x86_confidential_guest_cpu_instance_init(X86_CONFIDENTIAL_GUEST(ms->cgs),
+                                                 (CPU(obj)));
+    }
+#endif
 }
 
 static void x86_cpu_init_default_topo(X86CPU *cpu)
-- 
2.34.1


