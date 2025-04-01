Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD92C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsK-0005Gq-LS; Tue, 01 Apr 2025 09:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbro-00058O-Ia
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:26 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbrm-0006X0-7e
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514882; x=1775050882;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i9LA0fuEWyXT3xhCEP6n86n3NtpzUzrXs/78mYcqsME=;
 b=NLsqHaW0UWby1UHb3qiTdIBWf6u8n1Ktwu2J1PVk2aJJy1O23ygJXmx4
 x4BR6LzS9Kr1BNXMay4LgOQR9wZfzxfkYy50ZXU+6Jt39TlQE4hKw98Th
 e4+zpN9dDKnL+TBsf6Jx5h5OoqcH1FdguMUYIm1DsElOIH5AtO3hM4AdU
 Sqv8gOA8F7YrOFs0OoU22KR8elg9kB5dv1ygoIXJPAuXjwfg6b7eogAoC
 ZA0UEyyZZosRDPyrZTK2+clNBuoFAQ4NdYD7pMtzjuAHh9g+BD12zZjQB
 A3M9TMdTHrXpWdgB82m+gSmUOsYaI3mR537IsUxaazkUbwYi586a7Pshm A==;
X-CSE-ConnectionGUID: OmsCjFgVS3SJfMZXgu0+2Q==
X-CSE-MsgGUID: Z+9eNUkrS/et3AqyGQplTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433158"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433158"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:20 -0700
X-CSE-ConnectionGUID: vn0hOqBhTDSfHtohqswcNw==
X-CSE-MsgGUID: b5K6H5e4T/OM8zToeGW7iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639879"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:18 -0700
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
Subject: [PATCH v8 04/55] i386/tdx: Implement tdx_kvm_init() to initialize TDX
 VM context
Date: Tue,  1 Apr 2025 09:01:14 -0400
Message-Id: <20250401130205.2198253-5-xiaoyao.li@intel.com>
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
index 4f1cfb529c19..1af4710556ad 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3206,16 +3206,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
index d785c1f6d173..4ff94860815d 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -12,9 +12,17 @@
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
@@ -49,7 +57,9 @@ static void tdx_guest_finalize(Object *obj)
 
 static void tdx_guest_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
+    klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
 }
-- 
2.34.1


