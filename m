Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD62C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAZg-0003t6-Lm; Fri, 11 Jul 2025 06:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYt-0001yw-TC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:01 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYr-0005KY-RI
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228058; x=1783764058;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=whdrh4f2CvSh7ztiRXZ9xAUTYQf/ppVVjSzuT5hVdFw=;
 b=aKvkmAWpsayv86BUJOxv85ilk4l17nbj0QWQ1cKjWrQCT2U1qH+UQMXd
 HrKqpop4OnVrcgh37r+4wcmesFzvNsxAkq659KB7Q/FMLEuj3ZSVfkLC2
 /l3uvwYHij8XGtzOuZu/iL83iYlDfVeL3v3nOn9krIuimYhqz9a7qp6xK
 TyyMc8guyp4cpgE+nwe/XbWm+A6jv/kF1eCSNv0mO193g6lpy1qaq+l6t
 U2igS9US51SweTZ/ygKrlpNEb3Zf1OHjMmRwjhK63q27MvgQYks/oQj4w
 5YJ/0QtvbYxM/ahrb6o6aBbc7hG2JebU0cXItFsx3hd9x0sCAuS0Q/CEM g==;
X-CSE-ConnectionGUID: nbSzpyCnT9y+I2tl4ZD/XA==
X-CSE-MsgGUID: tGNtNTyXR365V6ukG/H1KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496285"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:00:56 -0700
X-CSE-ConnectionGUID: QSkNiVqjRvm2Mkffpmntrg==
X-CSE-MsgGUID: aHq+KBnZS3yXnjLhhjM1EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662056"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:00:51 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/18] i386/cpu: Add x-vendor-cpuid-only-v2 option for
 compatibility
Date: Fri, 11 Jul 2025 18:21:32 +0800
Message-Id: <20250711102143.1622339-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711102143.1622339-1-zhao1.liu@intel.com>
References: <20250711102143.1622339-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a compat property "x-vendor-cpuid-only-v2" (for PC machine v10.0
and older) to keep the original behavior. This property will be used
to adjust vendor specific CPUID fields.

Make x-vendor-cpuid-only-v2 depend on x-vendor-cpuid-only. Although
x-vendor-cpuid-only and v2 should be initernal only, QEMU doesn't
support "internal" property. To avoid any other unexpected issues, check
the dependency.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Split the x-vendor-cpuid-only-v2 support into a seperate pacth
   and make sure it depends on x-vendor-cpuid-only.
---
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 10 ++++++++++
 target/i386/cpu.h | 11 ++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ad2d6495ebde..9ec3f4db31f3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,6 +83,7 @@
 
 GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
+    { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index af67f12e939d..b6d41aa110a2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8749,6 +8749,16 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     tcg_cflags_set(cs, CF_PCREL);
 #endif
 
+    /*
+     * x-vendor-cpuid-only and v2 should be initernal only. But
+     * QEMU doesn't support "internal" property.
+     */
+    if (!cpu->vendor_cpuid_only && cpu->vendor_cpuid_only_v2) {
+        error_setg(errp, "x-vendor-cpuid-only-v2 property "
+                   "depends on x-vendor-cpuid-only");
+        return;
+    }
+
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
         error_setg(errp, "apic-id property was not initialized properly");
         return;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9adba8fdf773..03a7b735d090 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2282,9 +2282,18 @@ struct ArchCPU {
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
-    /* Only advertise CPUID leaves defined by the vendor */
+    /*
+     * Compatibility bits for old machine types (PC machine v6.0 and older).
+     * Only advertise CPUID leaves defined by the vendor.
+     */
     bool vendor_cpuid_only;
 
+    /*
+     * Compatibility bits for old machine types (PC machine v10.0 and older).
+     * Only advertise CPUID leaves defined by the vendor.
+     */
+    bool vendor_cpuid_only_v2;
+
     /* Only advertise TOPOEXT features that AMD defines */
     bool amd_topoext_features_only;
 
-- 
2.34.1


