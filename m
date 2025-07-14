Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D9C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEEz-0007jN-TN; Mon, 14 Jul 2025 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDub-0004eP-1i
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:50 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDuW-0007Nw-5M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479260; x=1784015260;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rAK1cNES//VTulXNgnL3pRWZtHvlKpyYfxsqm/cm01E=;
 b=KyYgqkl7IhUA2DK0p2/a6AiQ/2HBw3cfOJja0GOZzukkB8jYi+l+H+Nc
 RW7V28ANRdp7jzW/dhCZKpmbth1nKS+1F1Iwn8z+NOzFK7gkXUBQs+abF
 +e3qwqf0ry6ztV+LSpNfsYLDjMWumgt6XuQBFBQzSo7egF+t+lkUxP6Kg
 j/Comhv61/OS3WrKTz3NRNTeQfuaF2cfI95ufvl0Qx2loBkD4IrpTLTeL
 cVFjov8BlndFc11ivF+LWKA+f71ZtWVpdwMYgLoaOTGgT2gnYdB4iX/IH
 FkfGTPtgOmbThKzynSA08VRlhfI95GGjxKa4Fph0Va921JK/YoySIXm62 w==;
X-CSE-ConnectionGUID: btqI5TFzQRCaMVjEy4XlYQ==
X-CSE-MsgGUID: lHHaq7/LQdiXsLLGCIyeEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324645"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324645"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:36 -0700
X-CSE-ConnectionGUID: e50Lk58dQFOxAl+J24uy5Q==
X-CSE-MsgGUID: HMSFVuL6QoCea0EqMfWzew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952190"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:34 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Tao Su <tao1.su@linux.intel.com>
Subject: [PATCH v2 1/7] i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as
 reserved for Intel
Date: Mon, 14 Jul 2025 16:08:53 +0800
Message-Id: <20250714080859.1960104-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

Per SDM,

80000000H EAX Maximum Input Value for Extended Function CPUID Information.
          EBX Reserved.
          ECX Reserved.
          EDX Reserved.

EBX/ECX/EDX in CPUID 0x80000000 leaf are reserved. Intel and Zhaoxin are
already using 0x0 leaf to encode vendor.

Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Consider Zhaoxin CPU. (Ewan)
---
 target/i386/cpu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8d67cadec2f2..37e4bf51d890 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8278,9 +8278,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000000:
         *eax = env->cpuid_xlevel;
-        *ebx = env->cpuid_vendor1;
-        *edx = env->cpuid_vendor2;
-        *ecx = env->cpuid_vendor3;
+
+        if (cpu->vendor_cpuid_only_v2 &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *ebx = *ecx = *edx = 0;
+        } else {
+            *ebx = env->cpuid_vendor1;
+            *edx = env->cpuid_vendor2;
+            *ecx = env->cpuid_vendor3;
+        }
         break;
     case 0x80000001:
         *eax = env->cpuid_version;
-- 
2.34.1


