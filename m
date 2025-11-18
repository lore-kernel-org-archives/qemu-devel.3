Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F71CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCI1-00030X-Lo; Mon, 17 Nov 2025 22:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHu-0002Z8-Kn
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHj-0004Hi-4M
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436099; x=1794972099;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jyuv1slaPKAV+w4F0aJEddngoY9lcGquMMXzXgXMpc4=;
 b=Z2gB9UB8gUsIKJjFVKkw2G1eCWZ+MRV5JoXYg4af6bwYppktLIzQxT8J
 Hsf5Yi2NovoyxO9fHYNJGtCrhLrz/aap8sz7xnHvwjtrj6GHPDB3+NfEG
 7tjXFhxNeIGRKip98dA2cADoNR2wQ/myquvnlAbrNpJH9lk3siG50506p
 SC54D4cqTKfeLDfAVWh7V/jHdfC9WAOmueuB+yDv+pbfFrHxYhwkkpgGf
 2juGOQzw/Ft5vRaBFMVH6fporSWDXlRbZOKWZ45tn3MaNzYhb+QogS238
 Pp9Bdks4bbn6miHYCshvtas6yvzPnjoPmoEg2F6wwphU+3+Jfu2GihJLk A==;
X-CSE-ConnectionGUID: J4DdENNSQJKueD2QpO/wnA==
X-CSE-MsgGUID: 7pSl7GDESKmjd4wLkyVpEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053912"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053912"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:20 -0800
X-CSE-ConnectionGUID: bpQZXi/8Q6qs4/MvhT6veg==
X-CSE-MsgGUID: UuyFg7lLR/GWc64cBHO2ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537350"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:21:16 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v4 18/23] i386/machine: Add vmstate for cet-shstk and cet-ibt
Date: Tue, 18 Nov 2025 11:42:26 +0800
Message-Id: <20251118034231.704240-19-zhao1.liu@intel.com>
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

From: Yang Weijiang <weijiang.yang@intel.com>

Add vmstates for cet-shstk and cet-ibt

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - Rename vmstate_ss to vmstate_shstk.
 - Split pl0_ssp into a seperate vmstate in another patch.

Changes Since v2:
 - Split a subsection "vmstate_ss" since shstk is user-configurable.
---
 target/i386/machine.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 0a756573b6cd..265388f1fd36 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1693,6 +1693,57 @@ static const VMStateDescription vmstate_pl0_ssp = {
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
+static const VMStateDescription vmstate_shstk = {
+    .name = "cpu/cet_shstk",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = shstk_needed,
+    .fields = (VMStateField[]) {
+        /* pl0_ssp has been covered by vmstate_pl0_ssp. */
+        VMSTATE_UINT64(env.pl1_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl2_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
+#ifdef TARGET_X86_64
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
+        &vmstate_shstk,
+        NULL,
+    },
+};
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1843,6 +1894,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_arch_lbr,
         &vmstate_triple_fault,
         &vmstate_pl0_ssp,
+        &vmstate_cet,
         NULL
     }
 };
-- 
2.34.1


