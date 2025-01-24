Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEBCC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJsJ-0003kS-EE; Fri, 24 Jan 2025 08:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJs3-0003hy-0W
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:20 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJs1-0003ou-HJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725834; x=1769261834;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BZUvfQp9mnJI50UJFjmIm2ZYfyW4FPAxqgosh1xyGt4=;
 b=nuRqFB0E9DGDUlXG7s2UAF4puV9dcMsqPDIw3C8g82ISZ5E4MC+EBdT2
 scrv3OabzH+atdXEotmodZHvF0REtvFdRRbkskc04pyCaD5svWA1D6LIv
 672uck82/GHnlfnk4H/mBy4KuJ6kfLQpydH1mr/HVellPDTS+cmZJz/vH
 DJBq+uNmKB/0iusZNSadxqos3bru9fczvNBnGuT7DKr+0DWtjxKOjfi84
 8IZkPsMP292v6XzDyxOcZn8nKWwG03AHo8aob46wn+MmCP0FZL8Ap2l/D
 s96voBy/c+P48oNUi/x91e6vqtRUfauBV1q1TxB9tQOZB6SczJY8cDfK9 A==;
X-CSE-ConnectionGUID: dgqxWWXtTQWnrNe9P6R2Pg==
X-CSE-MsgGUID: cKBCpL5aQxGg5qnXekPAMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246196"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246196"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:37:13 -0800
X-CSE-ConnectionGUID: /dzKgrkJSOi+NkXxLcTFyQ==
X-CSE-MsgGUID: jSTFy9RQSH6OtrKHF47l4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804135"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:37:09 -0800
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
Subject: [PATCH v7 03/52] i386/tdx: Implement tdx_kvm_type() for TDX
Date: Fri, 24 Jan 2025 08:19:59 -0500
Message-Id: <20250124132048.3229049-4-xiaoyao.li@intel.com>
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

TDX VM requires VM type to be KVM_X86_TDX_VM. Implement tdx_kvm_type()
as X86ConfidentialGuestClass->kvm_type.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - new added patch;
---
 target/i386/kvm/kvm.c |  1 +
 target/i386/kvm/tdx.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee812..4f1cfb529c19 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -191,6 +191,7 @@ static const char *vm_type_name[] = {
     [KVM_X86_SEV_VM] = "SEV",
     [KVM_X86_SEV_ES_VM] = "SEV-ES",
     [KVM_X86_SNP_VM] = "SEV-SNP",
+    [KVM_X86_TDX_VM] = "TDX",
 };
 
 bool kvm_is_vm_type_supported(int type)
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index ec84ae2947bb..d785c1f6d173 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -12,8 +12,17 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 
+#include "kvm_i386.h"
 #include "tdx.h"
 
+static int tdx_kvm_type(X86ConfidentialGuest *cg)
+{
+    /* Do the object check */
+    TDX_GUEST(cg);
+
+    return KVM_X86_TDX_VM;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -40,4 +49,7 @@ static void tdx_guest_finalize(Object *obj)
 
 static void tdx_guest_class_init(ObjectClass *oc, void *data)
 {
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
+
+    x86_klass->kvm_type = tdx_kvm_type;
 }
-- 
2.34.1


