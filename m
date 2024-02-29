Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD12C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa6x-0006Dl-FT; Thu, 29 Feb 2024 01:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa69-00052A-A0
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:40:53 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa66-0004pj-Pf
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188850; x=1740724850;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r6CX0MD3a31aAOb2PFTUkMtwVtojPqksFz3dczKEH18=;
 b=BNOmKcTEdmfQ6EB6eteVOP5+nlTL4pUyXF5gn9udp8QRXpp2Bfyj7xyd
 RT+VwxxvTHGOCZka3tSsgT/APtNxBf5n44uUj4w+Ocm7dcFZF94ZVxFrJ
 Ig6McL3ajGc8ty8+hSPnyCe2B6d9GZ4ooMuqUdRPCWCikWrMO99OE5+ga
 g1XAnal74ftfwUGJ1xl83qc0nQsW5bJNaGVglUkqMS4eOQ7PxnKg1i/oZ
 rzr0ptmhQqj1S4xwJ3qZT9yTHmnUrUrYeavV2C8bGdgbgG/MGUbFNJ/Ay
 Yc5VCacMuvD7JOUdyXSF0g/D4n2YB9HfOb3E2xNBi2+z8tA1OWR+jtpUY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802797"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802797"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075551"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:40:38 -0800
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
Subject: [PATCH v5 29/65] i386/tdx: Validate TD attributes
Date: Thu, 29 Feb 2024 01:36:50 -0500
Message-Id: <20240229063726.610065-30-xiaoyao.li@intel.com>
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

Validate TD attributes with tdx_caps that fixed-0 bits must be zero and
fixed-1 bits must be set.

Besides, sanity check the attribute bits that have not been supported by
QEMU yet. e.g., debug bit, it will be allowed in the future when debug
TD support lands in QEMU.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>

---
Changes in v3:
- using error_setg() for error report; (Daniel)
---
 target/i386/kvm/tdx.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 1c12cda002b8..d0ad4f57b5d0 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -32,6 +32,7 @@
                                      (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
                                      (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
 
+#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
 #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
 #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
 #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
@@ -479,13 +480,34 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
-static void setup_td_guest_attributes(X86CPU *x86cpu)
+static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
+{
+    if (((tdx->attributes & tdx_caps->attrs_fixed0) | tdx_caps->attrs_fixed1) !=
+        tdx->attributes) {
+            error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
+                       "(fixed0 0x%llx, fixed1 0x%llx)",
+                       tdx->attributes, tdx_caps->attrs_fixed0,
+                       tdx_caps->attrs_fixed1);
+            return -1;
+    }
+
+    if (tdx->attributes & TDX_TD_ATTRIBUTES_DEBUG) {
+        error_setg(errp, "Current QEMU doesn't support attributes.debug[bit 0] for TDX VM");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int setup_td_guest_attributes(X86CPU *x86cpu, Error **errp)
 {
     CPUX86State *env = &x86cpu->env;
 
     tdx_guest->attributes |= (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS) ?
                              TDX_TD_ATTRIBUTES_PKS : 0;
     tdx_guest->attributes |= x86cpu->enable_pmu ? TDX_TD_ATTRIBUTES_PERFMON : 0;
+
+    return tdx_validate_attributes(tdx_guest, errp);
 }
 
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
@@ -512,7 +534,10 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
         return r;
     }
 
-    setup_td_guest_attributes(x86cpu);
+    r = setup_td_guest_attributes(x86cpu, errp);
+    if (r) {
+        return r;
+    }
 
     init_vm->cpuid.nent = kvm_x86_arch_cpuid(env, init_vm->cpuid.entries, 0);
 
-- 
2.34.1


