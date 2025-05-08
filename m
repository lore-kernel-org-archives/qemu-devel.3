Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA78C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2qp-000079-EH; Thu, 08 May 2025 11:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qj-0008G0-Pj
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:50 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qg-0007cp-Jg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716867; x=1778252867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5S1CixiYB970hm+ZoGlLSx+MtTlVqYPQqy4udp+5eeY=;
 b=ZRCpTkuLY0qS+6MFC3ePgOtMPWlzt1GeysVkM+tGtdp/7sPUU7Ixm8fS
 L3ZUBafCJ3C6CMmYmcAgrpUC2MeiDssnw5Kh+zpVNJfTSYtyJ7sncKZ69
 mKr7Wu0klSDohV8sbEfnJw/ZHtAvRXZT8xA36J/NJwkreVJZuVc5GjSDd
 o5wSeJsk4jfNiWRci212ycj63CXJxprEsn+2SNn0XGGsCNSlgIUYqbqA3
 6+7fsdElBn0oDJZF2Xnch3VEzIhNQ+KJxqcmplq14USiEjbO3u2AkZiu/
 QEQ0F9b1xlk1a55JAYEy3xGotvP454vxbfkjE5/463uaLr24HFjNWQohh A==;
X-CSE-ConnectionGUID: dNoBr/4SQymhSuePjfVjFA==
X-CSE-MsgGUID: U0AuR88NSCaDCJAe50vCLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58716575"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="58716575"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:42 -0700
X-CSE-ConnectionGUID: m8oDDevrShqjg1U+3XTEWQ==
X-CSE-MsgGUID: JIMIeQtWRqifm4Ahxf+zXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440582"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:07:38 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 54/55] i386/tdx: Validate phys_bits against host value
Date: Thu,  8 May 2025 11:00:00 -0400
Message-ID: <20250508150002.689633-55-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

For TDX guest, the phys_bits is not configurable and can only be
host/native value.

Validate phys_bits inside tdx_check_features().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v9:
 - return -EINVAL instead of exit(1); (Zhao Liu)
---
 target/i386/host-cpu.c | 2 +-
 target/i386/host-cpu.h | 1 +
 target/i386/kvm/tdx.c  | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 3e4e85e729c8..8a15af458b05 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -15,7 +15,7 @@
 #include "system/system.h"
 
 /* Note: Only safe for use on x86(-64) hosts */
-static uint32_t host_cpu_phys_bits(void)
+uint32_t host_cpu_phys_bits(void)
 {
     uint32_t eax;
     uint32_t host_phys_bits;
diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index 6a9bc918baa4..b97ec01c9bec 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -10,6 +10,7 @@
 #ifndef HOST_CPU_H
 #define HOST_CPU_H
 
+uint32_t host_cpu_phys_bits(void);
 void host_cpu_instance_init(X86CPU *cpu);
 void host_cpu_max_instance_init(X86CPU *cpu);
 bool host_cpu_realizefn(CPUState *cs, Error **errp);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 6aeb4fcc4975..b6b938fcccaa 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -25,6 +25,7 @@
 
 #include "cpu.h"
 #include "cpu-internal.h"
+#include "host-cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
@@ -886,6 +887,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
         return -EINVAL;
     }
 
+    if (cpu->phys_bits != host_cpu_phys_bits()) {
+        error_report("TDX requires guest CPU physical bits (%u) "
+                     "to match host CPU physical bits (%u)",
+                     cpu->phys_bits, host_cpu_phys_bits());
+        return -EINVAL;
+    }
+
     return 0;
 }
 
-- 
2.43.0


