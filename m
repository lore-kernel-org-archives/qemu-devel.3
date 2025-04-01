Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE70C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbyU-0004xC-FN; Tue, 01 Apr 2025 09:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbvN-00026f-Pm
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:45:06 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbvL-0006XQ-St
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515104; x=1775051104;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Koh+nRw4jmZ1Op1sYV3lYvpDb8Uq9tjL8EWr3Rspt5U=;
 b=YwVOoZ0tCzwRhjA50VHu5uMVFzUB34cpqf4lTf3OUc/EG3/B6y7Bq38t
 jJpoYk9sriWk0uk3fq1AlH64UQocuS/Fb6JSkme66JuQznQzLEtnnpg8G
 JRQfVQfJVcZ9yHpZiIyttC54p9FvFCs+B68gzVHcZ9zgHMVjBSlxcyXVt
 IDuRrubY0QzKVdnHLwjRicIu5rDM5fynu8wXKofdPX0aMLC+Bsw+fCVmh
 ox6tQkcaUNbhf+AaUGSyTIP7/5ph6R/fx084woN4sh6ND3BF6P7OBvFyP
 L9EmFfVZd1m5dyYypSUYSaqGZ9PqdpIJiAZyOTbWjga15Po6voLEUa9ty A==;
X-CSE-ConnectionGUID: tU0QZlniQ7KaRuTn05+RCA==
X-CSE-MsgGUID: +ojHv8EhTKm8f1CqODKOpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433608"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433608"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:27 -0700
X-CSE-ConnectionGUID: 9mN3EbrUSq2Pf/nGt3yShw==
X-CSE-MsgGUID: Mmuf2A6TQmSeLar6DINvkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640302"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:25 -0700
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
Subject: [PATCH v8 54/55] i386/tdx: Validate phys_bits against host value
Date: Tue,  1 Apr 2025 09:02:04 -0400
Message-Id: <20250401130205.2198253-55-xiaoyao.li@intel.com>
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

For TDX guest, the phys_bits is not configurable and can only be
host/native value.

Validate phys_bits inside tdx_check_features().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
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
index 8f075ba5a4de..c8fffa94c7d2 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -25,6 +25,7 @@
 
 #include "cpu.h"
 #include "cpu-internal.h"
+#include "host-cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
@@ -875,6 +876,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
         return -1;
     }
 
+    if (cpu->phys_bits != host_cpu_phys_bits()) {
+        error_report("TDX requires guest CPU physical bits (%u) "
+                     "to match host CPU physical bits (%u)",
+                     cpu->phys_bits, host_cpu_phys_bits());
+        exit(1);
+    }
+
     return 0;
 }
 
-- 
2.34.1


