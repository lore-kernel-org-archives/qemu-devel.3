Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3DDD1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DDO-0008DX-EX; Tue, 05 Nov 2024 01:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DD3-0007U7-NE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:38 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DD1-0001vj-Bi
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788715; x=1762324715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yTZNX+NQ5Q3yptqAX7/efQmRoNrRURBtZaK/2Teq53U=;
 b=QHB5L4XmfGlnU0sRpXAKdEb2awJCbNqlMkrALPT6EvFjhnNCISjEwFLS
 WX4emvncX7I/lKsOGgdV3iDy4YdOB3abuP9J1osHIvuH1OX0TNzaQPvlg
 +4ifuFm17tk8XxelbgKcxm5DgHHhsjWVm8HcwjQ4wJlNZYzubWdmgKHio
 j9swXG0CBShSq5uGuWeSdIxycPSVHcF9tUGn6cVBQFs9yJmIZSn4/MGFb
 tSZ2Pb6zXya+29NWzbBhHI860v7/VTxsp7/1eok0DX5V7dsLQP2f/7qSG
 /V490gypBxk9oD9oKyHcaLBOYKbpUrIsuWb9LN8+gqeayx/r/bikaKuBP A==;
X-CSE-ConnectionGUID: 0ydHHBfaRw6qKh13/+JG4Q==
X-CSE-MsgGUID: Je4kr+MxSsmSe4nL4UQ50A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689613"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689613"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:38:23 -0800
X-CSE-ConnectionGUID: BJdYU1grQeKHRWNJj1QRwA==
X-CSE-MsgGUID: M0YwmNanRkGKH2IyrQ+pEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989093"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:38:19 -0800
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
Subject: [PATCH v6 28/60] i386/tdx: Enable user exit on KVM_HC_MAP_GPA_RANGE
Date: Tue,  5 Nov 2024 01:23:36 -0500
Message-Id: <20241105062408.3533704-29-xiaoyao.li@intel.com>
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

KVM translates TDG.VP.VMCALL<MapGPA> to KVM_HC_MAP_GPA_RANGE, and QEMU
needs to enable user exit on KVM_HC_MAP_GPA_RANGE in order to handle the
memory conversion requested by TD guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
changes in v6:
 - new patch;
---
 target/i386/kvm/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 33d7ed039051..b34707e93f4d 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -20,6 +20,8 @@
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
 
+#include <linux/kvm_para.h>
+
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/tdvf.h"
@@ -362,6 +364,11 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    /* TDX relies on KVM_HC_MAP_GPA_RANGE to handle TDG.VP.VMCALL<MapGPA> */
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
+        return -EOPNOTSUPP;
+    }
+
     qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
 
     tdx_guest = tdx;
-- 
2.34.1


