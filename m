Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779BFE8784C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 18:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnKzw-00083F-9y; Tue, 03 Feb 2026 13:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1vnKzu-000830-EA
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:19:34 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1vnKzr-0002jw-5k
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770142771; x=1801678771;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=l22a5oe1mNUs96P/dWE4w90GjFwTlVKZXSrjiX8hfFo=;
 b=J5c9E/VBzxQL/4KYwqU9VXiVQ1DaY/hFmnSBlTAm9e+4AWvKlopEuVZx
 y6yRftMsP3Z+/BDLoKo5yh1NmQczsETsHLFRk8/HBakA9BvPr8xZWRbM6
 NyCnb1nqHBP5Ot5MRYXqM28IwVrnW8wvrot1Cye9eaJrV0qE1y1rFc0qt
 ACjZLOAn8ZtHV+FzpjXCbLt2UhuWpUo9Z3w8KynWFYz9Ektvxg1r4nnnT
 3Piptw/m+3rD7P/15SV4fzcfaf2ky7Ck3LAimjoNfD9l0AdxKag94q80D
 OVGBvj31GhyPrZrTwAlX19iNzMftSD60JKnFNEN3dUY2MJm+vneoTtsLL A==;
X-CSE-ConnectionGUID: XXal63gbTgOaSNKzjL7phQ==
X-CSE-MsgGUID: 5oP0OjhsQtqqy0h2R7Mztg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70523241"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; d="scan'208";a="70523241"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 10:19:24 -0800
X-CSE-ConnectionGUID: N0vYvOQ6QnGs//hQtFl67A==
X-CSE-MsgGUID: bW63XZYmRQuLOe76lXbkKg==
X-ExtLoop1: 1
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost)
 ([10.124.221.188])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 10:19:24 -0800
From: isaku.yamahata@intel.com
To: qemu-devel@nongnu.org
Cc: isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: [PATCH 1/2] target/i386: Add definition of VMX proc based tertiary
 controls
Date: Tue,  3 Feb 2026 10:19:18 -0800
Message-ID: <e41ffc4af96b8b4ee3a65f8da1f52dac7f3f4913.1770116952.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

As APIC timer virtualization is supported for KVM nested VMX, support the
related feature bits for it.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 target/i386/cpu.c | 31 ++++++++++++++++++++++++++++++-
 target/i386/cpu.h |  5 +++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 45f0b80deb02..5b8d8298b404 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1638,7 +1638,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, "vmx-hlt-exit",
             NULL, "vmx-invlpg-exit", "vmx-mwait-exit", "vmx-rdpmc-exit",
             "vmx-rdtsc-exit", NULL, NULL, "vmx-cr3-load-noexit",
-            "vmx-cr3-store-noexit", NULL, NULL, "vmx-cr8-load-exit",
+            "vmx-cr3-store-noexit", "vmx-tertiary-ctls", NULL, "vmx-cr8-load-exit",
             "vmx-cr8-store-exit", "vmx-flexpriority", "vmx-vnmi-pending", "vmx-movdr-exit",
             "vmx-io-exit", "vmx-io-bitmap", NULL, "vmx-mtf",
             "vmx-msr-bitmap", "vmx-monitor-exit", "vmx-pause-exit", "vmx-secondary-ctls",
@@ -1665,6 +1665,31 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         }
     },
 
+    [FEAT_VMX_TERTIARY_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "apic-timer-virt", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_PROCBASED_CTLS3,
+        }
+    },
+
     [FEAT_VMX_PINBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -1979,6 +2004,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VMFUNC },
         .to = { FEAT_VMX_VMFUNC,            ~0ull },
     },
+    {
+        .from = { FEAT_VMX_PROCBASED_CTLS,  VMX_CPU_BASED_ACTIVATE_TERTIARY_CONTROLS },
+        .to = { FEAT_VMX_TERTIARY_CTLS,    ~0ull },
+    },
     {
         .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
         .to = { FEAT_SVM,                   ~0ull },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index da5161fc1a50..f073ffce620a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -592,6 +592,7 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
+#define MSR_IA32_VMX_PROCBASED_CTLS3    0x00000492
 
 #define MSR_APIC_START                  0x00000800
 #define MSR_APIC_END                    0x000008ff
@@ -693,6 +694,7 @@ typedef enum FeatureWord {
     FEAT_PERF_CAPABILITIES,
     FEAT_VMX_PROCBASED_CTLS,
     FEAT_VMX_SECONDARY_CTLS,
+    FEAT_VMX_TERTIARY_CTLS,
     FEAT_VMX_PINBASED_CTLS,
     FEAT_VMX_EXIT_CTLS,
     FEAT_VMX_ENTRY_CTLS,
@@ -1370,6 +1372,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_CPU_BASED_RDTSC_EXITING                 0x00001000
 #define VMX_CPU_BASED_CR3_LOAD_EXITING              0x00008000
 #define VMX_CPU_BASED_CR3_STORE_EXITING             0x00010000
+#define VMX_CPU_BASED_ACTIVATE_TERTIARY_CONTROLS    0x00020000
 #define VMX_CPU_BASED_CR8_LOAD_EXITING              0x00080000
 #define VMX_CPU_BASED_CR8_STORE_EXITING             0x00100000
 #define VMX_CPU_BASED_TPR_SHADOW                    0x00200000
@@ -1405,6 +1408,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
 #define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
 
+#define VMX_TERTIARY_EXEC_APIC_TIMER_VIRT           0x0000000000000100ull
+
 #define VMX_PIN_BASED_EXT_INTR_MASK                 0x00000001
 #define VMX_PIN_BASED_NMI_EXITING                   0x00000008
 #define VMX_PIN_BASED_VIRTUAL_NMIS                  0x00000020

base-commit: b377abc220fc53e9cab2aac3c73fc20be6d85eea
-- 
2.45.2


