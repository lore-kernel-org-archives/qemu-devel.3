Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB2BCCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 06:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFKF-0005p7-6q; Tue, 18 Nov 2025 01:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFK2-0005je-JI
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:15 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFK0-0007CC-R3
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763447773; x=1794983773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2EeeRsC/XUg3teXyYaUyiQUeaj5evO6uMb81KhvNQWo=;
 b=WRiWdm/9B7raBVXgYmy3vqGvrYj4EaUrFEAn0f2bncpRaRJvxEuDfzbI
 PK7JYSop4LT60turrJAf1647v7ux/GyqZAOfO0IfHB9U0Y6WP2X5deK22
 jkHXYMU3UR6lp6TvPaNuqK+pgp4X40fQE7vvr/TgnL78U0E6WibnrrVe4
 o/ax/Yk6UdEyjRvJFTeb8JzizkeM8+/do/7USHSPVlULqzcZt4jg7ytnN
 66rUeygH2e+Avm4F5LqDYFvYDXLwK0T7a1ET0atucsSEQvSi1laJlmSNq
 uxi6hkVeABJ6LpbOyt0mForcL0pS78vL2bqiuXH+w1jgiPazLWUYKSlXs A==;
X-CSE-ConnectionGUID: arUxZp78QkuYzVPXHnvqCg==
X-CSE-MsgGUID: s5gkRL6yToKE/HkUIR/nQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82850961"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="82850961"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 22:36:07 -0800
X-CSE-ConnectionGUID: ilqn+WJjQVuS1nRIFuCG7A==
X-CSE-MsgGUID: GmCXOVJZTai3lJ4np4cO6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="189962670"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 17 Nov 2025 22:36:05 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/5] i386/cpu: Add APX migration support
Date: Tue, 18 Nov 2025 14:58:15 +0800
Message-Id: <20251118065817.835017-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118065817.835017-1-zhao1.liu@intel.com>
References: <20251118065817.835017-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

From: Zide Chen <zide.chen@intel.com>

Add a VMStateDescription to migrate APX EGPRs.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/machine.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 265388f1fd36..84faa2f8f8d3 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1744,6 +1744,27 @@ static const VMStateDescription vmstate_cet = {
     },
 };
 
+#ifdef TARGET_X86_64
+static bool apx_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!(env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APX);
+}
+
+static const VMStateDescription vmstate_apx = {
+    .name = "cpu/apx",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = apx_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.egprs, X86CPU, EGPR_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1895,6 +1916,9 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_triple_fault,
         &vmstate_pl0_ssp,
         &vmstate_cet,
+#ifdef TARGET_X86_64
+        &vmstate_apx,
+#endif
         NULL
     }
 };
-- 
2.34.1


