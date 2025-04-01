Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A164C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsL-0005Ht-G0; Tue, 01 Apr 2025 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbrs-000595-PU
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:29 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbrr-0006Yg-4Z
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514887; x=1775050887;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GCKkTbMWJ/L51uaR1qNqwPtA9GBaTmcFf+PDNy5n8SU=;
 b=H0/nxeJpyrmLSw4WEwSrXBk+0uqCrIHNV8igziG9aNtrIIYtfTR+dznv
 jwwJfK27V4luUy9lDkHhiXtF+ucTJaNe7Z5aTeSJtbuSMlfw6BE2UrEl4
 6voaJJpnTIjWks1BOiEyodAMCfUlYOY59aogrO1bbvrQhtOki4sIFjfVB
 Uu75FcKRgCdrlTUcAG/1mIcFnPcWeZJZv3E1HmB9NFSkwokJovmzd6uIC
 HNbwVtfkXLhknVcP8SXRYl8TOalNzyH3wcEEv0MfPNXjsx1i16Bp8ybl0
 RZJY/RTlzJPpz0aMhaHKvCVPWKNLpoy3cv2EkJcPsjZzA3BTVMpF0wfR8 w==;
X-CSE-ConnectionGUID: bSMp07QHR6GOiX8PmSNrmw==
X-CSE-MsgGUID: byd00LmVTqqip/xRBHyXDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433174"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433174"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:25 -0700
X-CSE-ConnectionGUID: rDAC95d2Rv+O6hrMPECjtw==
X-CSE-MsgGUID: bUCjn05VQ0qC/+alpOKizA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639908"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:23 -0700
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
Subject: [PATCH v8 06/55] i386/tdx: Introduce is_tdx_vm() helper and cache
 tdx_guest object
Date: Tue,  1 Apr 2025 09:01:16 -0400
Message-Id: <20250401130205.2198253-7-xiaoyao.li@intel.com>
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

It will need special handling for TDX VMs all around the QEMU.
Introduce is_tdx_vm() helper to query if it's a TDX VM.

Cache tdx_guest object thus no need to cast from ms->cgs every time.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
changes in v3:
- replace object_dynamic_cast with TDX_GUEST();
---
 target/i386/kvm/tdx.c | 15 ++++++++++++++-
 target/i386/kvm/tdx.h | 10 ++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index c67be5e618e2..16f67e18ae78 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,8 +18,16 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+static TdxGuest *tdx_guest;
+
 static struct kvm_tdx_capabilities *tdx_caps;
 
+/* Valid after kvm_arch_init()->confidential_guest_kvm_init()->tdx_kvm_init() */
+bool is_tdx_vm(void)
+{
+    return !!tdx_guest;
+}
+
 enum tdx_ioctl_level {
     TDX_VM_IOCTL,
     TDX_VCPU_IOCTL,
@@ -117,15 +125,20 @@ static int get_tdx_capabilities(Error **errp)
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
+    TdxGuest *tdx = TDX_GUEST(cgs);
     int r = 0;
 
     kvm_mark_guest_state_protected();
 
     if (!tdx_caps) {
         r = get_tdx_capabilities(errp);
+        if (r) {
+            return r;
+        }
     }
 
-    return r;
+    tdx_guest = tdx;
+    return 0;
 }
 
 static int tdx_kvm_type(X86ConfidentialGuest *cg)
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index f3b725336161..de8ae9196163 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -3,6 +3,10 @@
 #ifndef QEMU_I386_TDX_H
 #define QEMU_I386_TDX_H
 
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES /* CONFIG_TDX */
+#endif
+
 #include "confidential-guest.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
@@ -18,4 +22,10 @@ typedef struct TdxGuest {
     uint64_t attributes;    /* TD attributes */
 } TdxGuest;
 
+#ifdef CONFIG_TDX
+bool is_tdx_vm(void);
+#else
+#define is_tdx_vm() 0
+#endif /* CONFIG_TDX */
+
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


