Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C774C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbuh-0000q6-Ou; Tue, 01 Apr 2025 09:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtm-0000PU-Sy
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:35 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtj-0006Zf-NS
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515003; x=1775051003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yR1VutMQOXp5BiJF+ixz4pbVn5zV1cZoi3SnvuhcpA4=;
 b=iKTMkcmSi2/b1qqbh+7gwbRtSgXhxLm9Qwdyi2WWi7SQn9jF0tVe4vq+
 68Qt/3aSYZlhROc2jYUr6do1jfFgAJKQwEPGkiScEahuslrHKZOEH84Di
 AgT8ZHp5idYPpK59u3nfZnHFnraovmy7ZVlwXoqZz7oGVMDadRS4/LcbD
 zFTxEomYmQrX1sesJIXnRJmNnCgor1krE9p9rirQRcuMA59wBi2sr5BdG
 C9ZPeh0lSnXjaxXnTZXV0n4+YYjATepdhMOOi8r+LVUagU6c4W/JUU0As
 Vkizj3tQNTaIOnmRyTwLTtc9JsQiQeb/amNB2/mBQFH6AESCppC9Z03w5 w==;
X-CSE-ConnectionGUID: YD5e1j5YT4G5O0dTDvvaKg==
X-CSE-MsgGUID: rdiZXMbvSlWy1SYCSO+nKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433420"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433420"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:30 -0700
X-CSE-ConnectionGUID: +0ESDZeRSLqFhvyOb6SbpA==
X-CSE-MsgGUID: z+VsphhUT3m/c3sBZDbKkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640096"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:28 -0700
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
Subject: [PATCH v8 31/55] i386/cpu: introduce
 x86_confidential_guest_cpu_instance_init()
Date: Tue,  1 Apr 2025 09:01:41 -0400
Message-Id: <20250401130205.2198253-32-xiaoyao.li@intel.com>
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
index add6430f7edd..5c69d1489365 100644
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
@@ -8504,6 +8505,15 @@ static void x86_cpu_post_initfn(Object *obj)
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


