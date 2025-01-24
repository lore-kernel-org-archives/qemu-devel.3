Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7B0C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvi-0005BL-LF; Fri, 24 Jan 2025 08:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJvU-0003jk-QX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:49 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJvS-00041c-Qv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737726047; x=1769262047;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OqgpOogLszpg5BDG/eo1xK00WrrRCqKOdIeFumdWFTk=;
 b=SRWOnhkXfIABUIpzz1xqIXY5fQQCjk00aWibRtvtrK45vLKY8k28FaQr
 V6iNDxil8ydrBLVlpnl/SwCsTl9OPG9wF7n4r1y5cozeHxupGlAD6yw40
 OzSMhR7RZBi/ZiPi91ByTN4w9xjmmyrHM7WBLC+aoo8R7K1CPzgouUow1
 2Gw+nI+q/l9WmEMPseJbZg+cOj4tWpD4xqF06pETwyp6cKjM5OBG/WAkY
 iA9J9XyPFpcN+dZ/JqXEpgLLbLjLfqWe0mCeEYRCFO5vhWnSjW3/d5Cr1
 gEi2xnVSks8X0yuOMOg0+WMmABEaZAMn8h0ZM9XFaLISiHdplWoobQ502 A==;
X-CSE-ConnectionGUID: Xr9v+zZfQBqxOk7if1mbhw==
X-CSE-MsgGUID: gHGVMj+jSzamZJdQl0xbVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246663"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246663"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:40:13 -0800
X-CSE-ConnectionGUID: Rka8XYisTLCFKxcHr0WtQg==
X-CSE-MsgGUID: T4TiYUwjRJGLYlDfunmQiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804494"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:40:09 -0800
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
Subject: [PATCH v7 51/52] i386/tdx: Validate phys_bits against host value
Date: Fri, 24 Jan 2025 08:20:47 -0500
Message-Id: <20250124132048.3229049-52-xiaoyao.li@intel.com>
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
index bb75eb06dad9..c906a76c4c0e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -24,6 +24,7 @@
 
 #include "cpu.h"
 #include "cpu-internal.h"
+#include "host-cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/tdvf.h"
@@ -838,6 +839,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
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


