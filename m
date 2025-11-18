Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F7CED245
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCI3-00033B-NT; Mon, 17 Nov 2025 22:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHr-0002TU-PR
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:47 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHg-0004Cz-Lw
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436097; x=1794972097;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Lnoh54IK1xdUE7ReHUApDtVaHR1nAbgq/jys15IExB8=;
 b=cu2ivq/oCFaaMEMv0+dhcbvozQ7qwV4cK8wnfvYABuT/aU88arbDd4oV
 0pn+AL8gPfjSLsOFCbhvYciraGmt73DhMd3/Fn7TunOMz0uc/he/NS0Zv
 1n6LSR0ImLRF3vY+rgCOYp5DUZv2kYanbzimRFscf+K20RZ5AqCRfl2kd
 jrYp1rEXm3EjLtQosP7izyKuREZJIiF08tMl6YSSwwbfU6DlcFcaX+KUg
 ybWMpILbErTHsT4YlUtS5ZR7n8p4Ce+FuHfZzRsrsqhACFTr1K1paajZc
 9gdwFUDJS2npgs/Cs4nIAEDomP7Z3MVszIh37nqhOTv7QpaUz16hfBjmp Q==;
X-CSE-ConnectionGUID: NpqbyXXLTMaMkPmekE21+Q==
X-CSE-MsgGUID: +EmHwkvJTr6Wxo5bCgklUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053905"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053905"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:17 -0800
X-CSE-ConnectionGUID: 2sxYWs5mSRKM+l9YBIWrPA==
X-CSE-MsgGUID: ocOj5Iz7TNGxnJo70sxTfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537340"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:21:13 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 17/23] i386/cpu: Migrate MSR_IA32_PL0_SSP for FRED and
 CET-SHSTK
Date: Tue, 18 Nov 2025 11:42:25 +0800
Message-Id: <20251118034231.704240-18-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: "Xin Li (Intel)" <xin@zytor.com>

Both FRED and CET-SHSTK need MSR_IA32_PL0_SSP, so add the vmstate for
this MSR.

When CET-SHSTK is not supported, MSR_IA32_PL0_SSP keeps accessible, but
its value doesn't take effect. Therefore, treat this vmstate as a
subsection rather than a fix for the previous FRED vmstate.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - New commit.
---
 target/i386/machine.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 45b7cea80aa7..0a756573b6cd 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1668,6 +1668,31 @@ static const VMStateDescription vmstate_triple_fault = {
     }
 };
 
+static bool pl0_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+#ifdef TARGET_X86_64
+    if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
+        return true;
+    }
+#endif
+
+    return !!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK);
+}
+
+static const VMStateDescription vmstate_pl0_ssp = {
+    .name = "cpu/msr_pl0_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl0_ssp_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1817,6 +1842,7 @@ const VMStateDescription vmstate_x86_cpu = {
 #endif
         &vmstate_arch_lbr,
         &vmstate_triple_fault,
+        &vmstate_pl0_ssp,
         NULL
     }
 };
-- 
2.34.1


