Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D125C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa4X-0002Uf-FD; Thu, 29 Feb 2024 01:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa4T-0002Nc-48
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:39:09 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa4Q-0004LA-SR
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188746; x=1740724746;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mU0otVJn1bEwIQ9Zyr9mBs1D769YAuu9+hQHU1VV6MY=;
 b=n7/hMX/EnL/CpPXHoTEateD2te9U30tvZGJSAagZlmdGqlwgeYzmcqpy
 iWrx5Cq1qVKowr0d1KD1AnCcXKLnzQF8MlVFmvGBDMJuwXfeD53Jlgbsc
 U+kAcwv5m6sWE8UhSmOqTwFY1qd/HRfFBF65ihvAcR0VUFJ6WuKZabVDQ
 3xtsv8e9e8yGDvGCJz4/AMp4xiXBiS4wPJ6d58HXtpT+spUGoZom2r+2O
 B2ObqGE0BNxGMctuZVL7W3+VHg3Xz9M/HmaiUBhwV1llcsBm8CE3BFhY5
 pUeQgeik5B2FnIMFCE8xj85pj4c0uEJRVUD9x9V8GtXmnKts9yKpaKfQf Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802598"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802598"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075059"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:39:00 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 14/65] i386/tdx: Implement tdx_kvm_init() to initialize TDX
 VM context
Date: Thu, 29 Feb 2024 01:36:35 -0500
Message-Id: <20240229063726.610065-15-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Set ms->require_guest_memfd to true to require private guest memfd
allocation for any memory backend.

More TDX specific initialization will be added later.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v5:
 - remove Acked-by from Gerd since the patch changed due to use
   ConfidentialGuestSupportClass::kvm_init();
---
 target/i386/kvm/kvm.c | 11 +----------
 target/i386/kvm/tdx.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 898f8fb30c61..52d99d30bdc8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2550,16 +2550,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
index d3792d4a3d56..d9a1dd46dc69 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -14,8 +14,18 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 
+#include "hw/i386/x86.h"
 #include "tdx.h"
 
+static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    ms->require_guest_memfd = true;
+
+    return 0;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -37,4 +47,7 @@ static void tdx_guest_finalize(Object *obj)
 
 static void tdx_guest_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = tdx_kvm_init;
 }
-- 
2.34.1


