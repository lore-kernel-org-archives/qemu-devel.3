Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C65D1CA3B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DBJ-0004Rb-Dn; Tue, 05 Nov 2024 01:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBE-0004Qa-5E
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:36:44 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBC-0001oZ-0W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788602; x=1762324602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ou+Mdobmm1tQq2ArTm7wdCK4exn2TLAYJgjckbytn0A=;
 b=Mnc2bvJx6BVs4foH90cXKIfNbZSefP6jMWLqTlNHOb/W474326/BrOoL
 Pz8VcHIWm4kg8wlVW68Dxz/pTUevBJLViMlIi+Z/vL85F3yM1JdqKldlm
 gEb0gGwNdGIrATqmVaePunmTDQqCnlEc4u+p8RnjcUaGChUAALuSp6QtZ
 9iJrWI6jYHbPIa4Vp7OA/aHZPgSB3jNPIXXf1ODXpurU5UKsb8Qp2V03C
 Cygle57FeaUW5ISoIUPanLVApqVPpY+29zVhX4drY9kHIRoolC5XBjVx9
 nigHFrCRxlbQPbwHkmiwMZtKv0tA0AYW4qTGuTrVeaZd57EiHChlKhAHs g==;
X-CSE-ConnectionGUID: Ds17qyEvS7S/cgegM6COBw==
X-CSE-MsgGUID: gAvQ3w/7SXywW/kx3Kdh1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689257"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689257"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:36:39 -0800
X-CSE-ConnectionGUID: r1o3UWJtR+OrzWAUBbZ4Gw==
X-CSE-MsgGUID: /2AI0GzRRKefGwjrd6onTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83988607"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:36:34 -0800
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
Subject: [PATCH v6 04/60] i386/tdx: Implement tdx_kvm_init() to initialize TDX
 VM context
Date: Tue,  5 Nov 2024 01:23:12 -0500
Message-Id: <20241105062408.3533704-5-xiaoyao.li@intel.com>
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

Implement TDX specific ConfidentialGuestSupportClass::kvm_init()
callback, tdx_kvm_init().

Mark guest state is proctected for TDX VM.  More TDX specific
initialization will be added later.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - remove Acked-by from Gerd since the patch changed due to use
   ConfidentialGuestSupportClass::kvm_init();
---
 target/i386/kvm/kvm.c | 11 +----------
 target/i386/kvm/tdx.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ed2e89946c44..2bbac603da70 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3204,16 +3204,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     Error *local_err = NULL;
 
     /*
-     * Initialize SEV context, if required
-     *
-     * If no memory encryption is requested (ms->cgs == NULL) this is
-     * a no-op.
-     *
-     * It's also a no-op if a non-SEV confidential guest support
-     * mechanism is selected.  SEV is the only mechanism available to
-     * select on x86 at present, so this doesn't arise, but if new
-     * mechanisms are supported in future (e.g. TDX), they'll need
-     * their own initialization either here or elsewhere.
+     * Initialize confidential guest (SEV/TDX) context, if required
      */
     if (ms->cgs) {
         ret = confidential_guest_kvm_init(ms->cgs, &local_err);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index bf8947549a96..85f006c1d6b4 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -14,9 +14,17 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 
+#include "hw/i386/x86.h"
 #include "kvm_i386.h"
 #include "tdx.h"
 
+static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    kvm_mark_guest_state_protected();
+
+    return 0;
+}
+
 static int tdx_kvm_type(X86ConfidentialGuest *cg)
 {
     /* Do the object check */
@@ -51,7 +59,9 @@ static void tdx_guest_finalize(Object *obj)
 
 static void tdx_guest_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
+    klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
 }
-- 
2.34.1


