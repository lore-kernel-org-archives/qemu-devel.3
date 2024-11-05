Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45840D1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DBN-0004SR-16; Tue, 05 Nov 2024 01:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBJ-0004Re-Rg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:36:49 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBH-0001pq-Pe
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788608; x=1762324608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7SB8aGVRHq3cVcRCjG983qVZg5U5xF0U5N0nc3brUHY=;
 b=KsRWxI/WLyGEs/yj/KDHntMNQirVXImY1qMu525UFreznrWmE9sgvgsG
 Zh827NPHvc6NWBEfIqZRKTVWvE4NhM8EhMvgUUqN2orhskBOaORVg+H/2
 rV6dS67fbwvUUoeTCcAXDjevFZNHKdI7KA4FEDWr5vq7dAOdNlGjQHPH5
 Pkt63kmyQV1zepgZc5Lgf2bLUwL6IkuZSYIToW0sE8OaDyp7mskL6NkQb
 Eqi8wVVqNoI1U9ACXlXYpilxfQlKYYyb2iXswhCL+W8N5bUVICndvonOE
 /sbW+qoo3yyf2b3xbggbRLB2yt42c9iWK1bYKw9T2so/+jLE+vunkZL+v Q==;
X-CSE-ConnectionGUID: xbSja+cSQmKtSdEXwAXiwQ==
X-CSE-MsgGUID: AlrywSEwT6aTrnbtt8dzpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689288"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:36:47 -0800
X-CSE-ConnectionGUID: CGPXOm3fS/i5ivZLDU97xA==
X-CSE-MsgGUID: d6NqJKe+RIiI+IpNuhCdLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83988631"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:36:43 -0800
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
Subject: [PATCH v6 06/60] i386/tdx: Introduce is_tdx_vm() helper and cache
 tdx_guest object
Date: Tue,  5 Nov 2024 01:23:14 -0500
Message-Id: <20241105062408.3533704-7-xiaoyao.li@intel.com>
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
index 907044910fec..ff3ef9bd8657 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -20,8 +20,16 @@
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
@@ -105,15 +113,20 @@ static int get_tdx_capabilities(Error **errp)
 
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
index de687457cae6..bca19c833e18 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -1,6 +1,10 @@
 #ifndef QEMU_I386_TDX_H
 #define QEMU_I386_TDX_H
 
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES /* CONFIG_TDX */
+#endif
+
 #include "confidential-guest.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
@@ -16,4 +20,10 @@ typedef struct TdxGuest {
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


