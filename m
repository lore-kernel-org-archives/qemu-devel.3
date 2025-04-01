Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53437C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbvh-0002o0-Kw; Tue, 01 Apr 2025 09:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuY-0000jL-2E
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:18 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuU-0006XQ-On
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515051; x=1775051051;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XivRqsU75f1UeqvfNnKISLROmXQcU9CQq1uW4OiP9Sw=;
 b=MGhedKX0sMV6pa/0v9H24EShiLq6/3XQFxup683bQ1L9H+aBv6rmOeG0
 JNrSvhVkz4NTKuxWMzWhBA5rOiQq07iKPSearvphN0IKR2qupTuY/Nc4T
 +XnuzVXLkoUja+UxmaI9f4ioZ4eGaMJ1tI6aicVDJer+Ng/wnEbq0SuzY
 R1dwPGB2grhPxXY2+S5SejQDHL5PmbKHnOv7oTUciURmDJE6i0wjc/ZtB
 ImJ0SS6BEN2EvJHn1wGcpgfaJiJbgPLgnSxZdT3ZcmeUgi1weNe268cMM
 BfHZ6U7XcixBi+Ifc+YeZbjih+I7Rg3Kp5W0c8eY8C//Zfx9urmP68as4 w==;
X-CSE-ConnectionGUID: DZNiyhvGS2SQp9pd3UtfFA==
X-CSE-MsgGUID: bUDI57fSR5ud6YnWdKt/WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433502"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433502"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:55 -0700
X-CSE-ConnectionGUID: Psx4vOG5SZKGPo8x3TRaFA==
X-CSE-MsgGUID: WPN9Q/hgQhKr3ThsmXGcoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640171"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:52 -0700
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
Subject: [PATCH v8 41/55] i386/apic: Skip kvm_apic_put() for TDX
Date: Tue,  1 Apr 2025 09:01:51 -0400
Message-Id: <20250401130205.2198253-42-xiaoyao.li@intel.com>
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

KVM neithers allow writing to MSR_IA32_APICBASE for TDs, nor allow for
KVM_SET_LAPIC[*].

Note, KVM_GET_LAPIC is also disallowed for TDX. It is called in the path

  do_kvm_cpu_synchronize_state()
  -> kvm_arch_get_registers()
     -> kvm_get_apic()

and it's already disllowed for confidential guest through
guest_state_protected.

[*] https://lore.kernel.org/all/Z3w4Ku4Jq0CrtXne@google.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v8:
- Fix the coding style; (Francesco)
---
 hw/i386/kvm/apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 757510600098..cb65fca49586 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -17,6 +17,7 @@
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
                                     int reg_id, uint32_t val)
@@ -141,6 +142,10 @@ static void kvm_apic_put(CPUState *cs, run_on_cpu_data data)
     struct kvm_lapic_state kapic;
     int ret;
 
+    if (is_tdx_vm()) {
+        return;
+    }
+
     kvm_put_apicbase(s->cpu, s->apicbase);
     kvm_put_apic_state(s, &kapic);
 
-- 
2.34.1


