Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ADEC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2oR-0001Ll-IZ; Thu, 08 May 2025 11:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2oQ-0001L4-7d
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:26 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2oN-0007RF-GU
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716723; x=1778252723;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oFZQqpDNFHH2b1vDaIjPFpNVtZre5LHwzMWRdwDhm8o=;
 b=etStJYSolw3XOwKt6iWZO9fQk9J3Bj9qAlidBcbkx9VoY68eiy1iprtS
 reipIEg3TcgaFFAhX/2NIPd0guZX4kk3C1U6kQueB8YqfcBQYl2FAla1m
 HnwWA08cKHFzuGNr/sTpKHI8pOFzS+PkMrPpuRVbGlW1dDfe9Gphm23/3
 EOpE+v17dbkyj1BQcwj/F3yXVCcSdRmyKMu2IOVLEO8ViZwWIPPHC2Yf4
 xjMAsvEfnIojqGqxb/BkX+/6CGyOKKtr0Htc7r5HtBcf0N90u2DPHW6vq
 Nz9WbR2JjtIdUa8pps6rYbQi5BC9UYvs0aVtj7KqGWyUzmOX3gMUuqf9W A==;
X-CSE-ConnectionGUID: q46CaMB3Q8iNL4duriBzlg==
X-CSE-MsgGUID: zrvAbro8TOattYKPNoQrxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888056"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888056"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:05:22 -0700
X-CSE-ConnectionGUID: pxRpgHDYRjmXtpGf6DR3Jg==
X-CSE-MsgGUID: j26A5cH1RC6d82Jqoeb9pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141439845"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:05:18 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 09/55] i386/tdx: Add property sept-ve-disable for tdx-guest
 object
Date: Thu,  8 May 2025 10:59:15 -0400
Message-ID: <20250508150002.689633-10-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
EPT violation conversion to #VE on guest TD access of PENDING pages.

Some guest OS (e.g., Linux TD guest) may require this bit as 1.
Otherwise refuse to boot.

Add sept-ve-disable property for tdx-guest object, for user to configure
this bit.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v4:
- collect Acked-by from Markus

Changes in v3:
- update the comment of property @sept-ve-disable to make it more
  descriptive and use new format. (Daniel and Markus)
---
 qapi/qom.json         |  8 +++++++-
 target/i386/kvm/tdx.c | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index c0b61df964ef..f229bb07aaec 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1055,10 +1055,16 @@
 # @attributes: The 'attributes' of a TD guest that is passed to
 #     KVM_TDX_INIT_VM
 #
+# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
+#     of EPT violation conversion to #VE on guest TD access of PENDING
+#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
+#     be set, otherwise they refuse to boot.
+#
 # Since: 10.1
 ##
 { 'struct': 'TdxGuestProperties',
-  'data': { '*attributes': 'uint64' } }
+  'data': { '*attributes': 'uint64',
+            '*sept-ve-disable': 'bool' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 8f02c762495c..370bd86f2ca7 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,6 +18,8 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
+
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
@@ -252,6 +254,24 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
+static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return !!(tdx->attributes & TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE);
+}
+
+static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    if (value) {
+        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
+    } else {
+        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
+    }
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -272,6 +292,9 @@ static void tdx_guest_init(Object *obj)
 
     object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
                                    OBJ_PROP_FLAG_READWRITE);
+    object_property_add_bool(obj, "sept-ve-disable",
+                             tdx_guest_get_sept_ve_disable,
+                             tdx_guest_set_sept_ve_disable);
 }
 
 static void tdx_guest_finalize(Object *obj)
-- 
2.43.0


