Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC7ED3E797
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaR0-0001wQ-31; Thu, 11 Dec 2025 01:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQh-0001l3-85
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:42 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQf-00067P-Ho
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435534; x=1796971534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j1lNybIRHI6DJw4Z3blCneXAJwSfecOkeUpkRkadyAI=;
 b=aACYaangw5y0RYoyZedNntBsXGx5s/21G/rkV8+/sfm3iijzE2m9FrQ7
 qSmcBeIxBn+2S20RBFlXh95dWL/pOMPcEfVOXLtF99YiIf8if3UrLDrnP
 ZsBHwVPWK+mQraVP7SKrHxlv8XP5Lccm+qZteLnlieqSZ1CFyi0+agj1y
 0tfi5hn6I3lg7bOqgxZRE8QBEnDUfqZDoB1bJqnYKlAXM5Zx8jvbAEyop
 dSSOmfwrYBbQl3zVqWdR6xMZkcTa9iAeEHOQrBJqpdCcdOICKiLyn75OO
 rc/GC9DA9hJ8ULkaw86gCIwEJiMqeM/xxx6tC30GA8OpCeYuLSEqyklzI A==;
X-CSE-ConnectionGUID: Mg5ebthuTBqj/7QNNiiPYQ==
X-CSE-MsgGUID: mcF07EOHQ1WEYbvSSVfu/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67584480"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67584480"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:45:32 -0800
X-CSE-ConnectionGUID: Q2YHT5SBQdOe7je04jo1ZQ==
X-CSE-MsgGUID: gDb1d5ukQtOD7OhQ8nJKJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196495019"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Dec 2025 22:45:29 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 7/9] i386/cpu: Add APX migration support
Date: Thu, 11 Dec 2025 15:09:40 +0800
Message-Id: <20251211070942.3612547-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211070942.3612547-1-zhao1.liu@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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
Changes since v1:
 * Use CPUX86State.regs instead of a new array.
---
 target/i386/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 0882dc3eb09e..df550dec4749 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1741,6 +1741,28 @@ static const VMStateDescription vmstate_cet = {
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
+        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, CPU_NB_REGS,
+                                 CPU_NB_EREGS - CPU_NB_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1892,6 +1914,9 @@ const VMStateDescription vmstate_x86_cpu = {
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


