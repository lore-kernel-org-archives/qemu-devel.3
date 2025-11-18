Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3291FCED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCIE-0003pX-9x; Mon, 17 Nov 2025 22:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHv-0002cm-7b
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:51 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHs-0004Cz-5F
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436108; x=1794972108;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4vj3rkIIm3fua4GI9Ec2JhmAZvhM0BpAu+/cVsnfP9Q=;
 b=QoQ8YdrlxJ0aQN3wjpjEuVGCkd5VJNWu98yFuEjaAoZOTcrTdXzjvzje
 NcPSskzzYUCsj5hJKP3nlpF0MYzi8nP/Npw0ARB+TObrHT8OjZbE56+MN
 0P1y0a2IcwuErUb12eYP2kRXq5jeODQtzyL6STd6bVilItWKdqacwgW83
 LT6LH+vqj3IuxsjVWdfS4zOOK07MlAdHZlYTezuI9Dm6uL0grxdUxmsHb
 hh6D9ydIfutBCXpXIIKgA8AaKuRHA3vLZ2k5zwL5LQ1X/XZZmfIo4Z1XS
 iTeeC4DkBMamEb2asfy39MWXeV8h9777b/f8P0d3Ex8JdPy7nYsx25/Aa Q==;
X-CSE-ConnectionGUID: opVDdUQAS8WSTPO+SwirDQ==
X-CSE-MsgGUID: 1GVmT9jnRY+URHr7Kk4Swg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053931"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053931"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:28 -0800
X-CSE-ConnectionGUID: xCTmfrJJTi2+2N0h9sQ0dg==
X-CSE-MsgGUID: 3QO/yUuuQHKPVb9FKysCmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537395"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:21:23 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v4 20/23] i386/cpu: Advertise CET related flags in feature
 words
Date: Tue, 18 Nov 2025 11:42:28 +0800
Message-Id: <20251118034231.704240-21-zhao1.liu@intel.com>
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

Add SHSTK and IBT flags in feature words with entry/exit
control flags.

CET SHSTK and IBT feature are enumerated via CPUID(EAX=7,ECX=0)
ECX[bit 7] and EDX[bit 20]. CET states load/restore at vmentry/
vmexit are controlled by VMX_ENTRY_CTLS[bit 20] and VMX_EXIT_CTLS[bit 28].
Enable these flags so that KVM can enumerate the features properly.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v2:
 - Rename "shstk"/"ibt" to "cet-ss"/"cet-ibt" to match feature names
   in SDM & APM.
 - Rename "vmx-exit-save-cet-ctl"/"vmx-entry-load-cet-ctl" to
   "vmx-exit-save-cet"/"vmx-entry-load-cet".
 - Define the feature mask macro for easier double check.
---
 target/i386/cpu.c | 8 ++++----
 target/i386/cpu.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 848e3ccbb8e3..a65fd4111c31 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1221,7 +1221,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
+            NULL /* ospke */, "waitpkg", "avx512vbmi2", "cet-ss",
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -1244,7 +1244,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
             "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
-            NULL, NULL, "amx-bf16", "avx512-fp16",
+            "cet-ibt", NULL, "amx-bf16", "avx512-fp16",
             "amx-tile", "amx-int8", "spec-ctrl", "stibp",
             "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
         },
@@ -1666,7 +1666,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
+            "vmx-exit-save-cet", "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -1681,7 +1681,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
+            "vmx-entry-load-cet", NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c4412012c780..d8bdf342f98d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1373,6 +1373,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_EXIT_CLEAR_BNDCFGS                   0x00800000
 #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
 #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
+#define VMX_VM_EXIT_SAVE_CET                        0x10000000
 #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
 #define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
 
@@ -1386,6 +1387,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_ENTRY_LOAD_BNDCFGS                   0x00010000
 #define VMX_VM_ENTRY_PT_CONCEAL_PIP                 0x00020000
 #define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
+#define VMX_VM_ENTRY_LOAD_CET                       0x00100000
 #define VMX_VM_ENTRY_LOAD_IA32_PKRS                 0x00400000
 
 /* Supported Hyper-V Enlightenments */
-- 
2.34.1


