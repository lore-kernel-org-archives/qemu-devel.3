Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F98BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBOo-0003dT-RB; Fri, 24 Oct 2025 02:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOn-0003dE-CZ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:41 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOl-0003zH-Hu
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287740; x=1792823740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8+D0ZyMJP774a0QzTHB9HaDDjW9x92tncQIYwGtlWcM=;
 b=bmBbaN6fTO8hIadT68ut3x16pcbjwfK+YmxPA/dR3B3SvJCegyfal/Z+
 0bpLMSsDAyMm2oP+NMAHwn3d3gMjcp3ncm1qytxkTVErvv4ZR9MixYioa
 fApQAs38N1WaLAM94blmGpy44F0D7W/x4lCx5KcVw34ghJf0WuzjiZ0jX
 VHDsoux7mEWd9Y2iIcmdAFWYK6LIwvDXVbApFmNRVJdcjGJ1tHfQoOkVe
 w8XB0JdJ3I2ydOr2qNhoKcnHeQXt//fPkgawwKfV0q+E2/ibm1Vnuxo5Z
 M+Bnip4WmjszPCJbokndT7sIVV74a6t9twosLI8El8GJinGEBfo08nELj Q==;
X-CSE-ConnectionGUID: JcpOqBufSN+z1nFw1VwAPw==
X-CSE-MsgGUID: L9rtiwlPSAWck3p/TbtfGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63170923"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="63170923"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:35:37 -0700
X-CSE-ConnectionGUID: WloA9umMSkm/n6Cz1qupVg==
X-CSE-MsgGUID: LIouHQykSIytxUQS4lRFKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184276114"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:35:33 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v3 15/20] i386/machine: Add vmstate for cet-ss and cet-ibt
Date: Fri, 24 Oct 2025 14:56:27 +0800
Message-Id: <20251024065632.1448606-16-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

From: Yang Weijiang <weijiang.yang@intel.com>

Add vmstates for cet-ss and cet-ibt

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v2:
 - Split a subsection "vmstate_ss" since shstk is user-configurable.
---
 target/i386/machine.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 45b7cea80aa7..3ad07ec82428 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1668,6 +1668,58 @@ static const VMStateDescription vmstate_triple_fault = {
     }
 };
 
+static bool shstk_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK);
+}
+
+static const VMStateDescription vmstate_ss = {
+    .name = "cpu/cet_ss",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = shstk_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl1_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl2_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
+#ifdef TARGET_X86_64
+        /* This MSR is only present on Intel 64 architecture. */
+        VMSTATE_UINT64(env.int_ssp_table, X86CPU),
+#endif
+        VMSTATE_UINT64(env.guest_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cet_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) ||
+              (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT));
+}
+
+static const VMStateDescription vmstate_cet = {
+    .name = "cpu/cet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cet_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.u_cet, X86CPU),
+        VMSTATE_UINT64(env.s_cet, X86CPU),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_ss,
+        NULL,
+    },
+};
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1817,6 +1869,7 @@ const VMStateDescription vmstate_x86_cpu = {
 #endif
         &vmstate_arch_lbr,
         &vmstate_triple_fault,
+        &vmstate_cet,
         NULL
     }
 };
-- 
2.34.1


