Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36531C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqQU-0004QX-Jw; Wed, 24 Jan 2024 22:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqQQ-0004PS-8j
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:29:10 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqQO-0001Dr-Du
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153348; x=1737689348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JfGUcuOqvX1gvpeBZDSWHAWcHnEaLXwhlY5j9qFdGlg=;
 b=FMuZuMQn4Gfb1DDUEuc6sUI5xnfiTS4mWQ/C1gbzHHemQVGB8Qz2t3/Z
 AfuMi/HcHDo9tDKyDMxMZsrtYK7ByvzjVB4H9kjQziXlfgiXhLPvUhytD
 jRlJ+KkbR9SvBu92mn3MTrlEOqOG9vx6uxDpbj2qRNT27zeI+IxGr6Ozo
 pAwbMawxxUsBQH5PFqUK2KlT51luq9a4V4l/mFwnW/j++aEZ43yZZIP5M
 A3L4JLOBfMWNqQXxiLLGm/9zVBQ8bwwpZybii+aLsMkiD4nf+FMXoCMnZ
 bY+1U987ikFZ8tWygyYLDlCg+zFm+VQ9v24LnkcZbbmDhwKFcUTX8Fzbl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9428605"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9428605"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2085502"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:25:28 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v4 21/66] i386/tdx: Integrate tdx_caps->attrs_fixed0/1 to
 tdx_cpuid_lookup
Date: Wed, 24 Jan 2024 22:22:43 -0500
Message-Id: <20240125032328.2522472-22-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032328.2522472-1-xiaoyao.li@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Some bits in TD attributes have corresponding CPUID feature bits. Reflect
the fixed0/1 restriction on TD attributes to their corresponding CPUID
bits in tdx_cpuid_lookup[] as well.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v4:
 - reverse the meaning of tdx_caps->attr_fixed0, because value 0 of bit
   means the bit must be fixed 0.
---
 target/i386/cpu-internal.h |  9 +++++++++
 target/i386/cpu.c          |  9 ---------
 target/i386/cpu.h          |  2 ++
 target/i386/kvm/tdx.c      | 21 +++++++++++++++++++++
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 9baac5c0b450..e980f6e3147f 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -20,6 +20,15 @@
 #ifndef I386_CPU_INTERNAL_H
 #define I386_CPU_INTERNAL_H
 
+typedef struct FeatureMask {
+    FeatureWord index;
+    uint64_t mask;
+} FeatureMask;
+
+typedef struct FeatureDep {
+    FeatureMask from, to;
+} FeatureDep;
+
 typedef enum FeatureWordType {
    CPUID_FEATURE_WORD,
    MSR_FEATURE_WORD,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 160ba8c940a2..39b07f8e1204 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1442,15 +1442,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     },
 };
 
-typedef struct FeatureMask {
-    FeatureWord index;
-    uint64_t mask;
-} FeatureMask;
-
-typedef struct FeatureDep {
-    FeatureMask from, to;
-} FeatureDep;
-
 static FeatureDep feature_dependencies[] = {
     {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 23d187d7cc5f..2091451a140e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -876,6 +876,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_0_ECX_MAWAU             (31U << 17)
 /* Read Processor ID */
 #define CPUID_7_0_ECX_RDPID             (1U << 22)
+/* KeyLocker */
+#define CPUID_7_0_ECX_KeyLocker         (1U << 23)
 /* Bus Lock Debug Exception */
 #define CPUID_7_0_ECX_BUS_LOCK_DETECT   (1U << 24)
 /* Cache Line Demote Instruction */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4c8455783e36..6caefb27d90a 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -32,6 +32,13 @@
                                      (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
                                      (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
 
+#define TDX_ATTRIBUTES_MAX_BITS      64
+
+static FeatureMask tdx_attrs_ctrl_fields[TDX_ATTRIBUTES_MAX_BITS] = {
+    [30] = { .index = FEAT_7_0_ECX, .mask = CPUID_7_0_ECX_PKS },
+    [31] = { .index = FEAT_7_0_ECX, .mask = CPUID_7_0_ECX_KeyLocker},
+};
+
 typedef struct KvmTdxCpuidLookup {
     uint32_t tdx_fixed0;
     uint32_t tdx_fixed1;
@@ -383,6 +390,8 @@ static void update_tdx_cpuid_lookup_by_tdx_caps(void)
     FeatureWordInfo *fi;
     uint32_t config;
     FeatureWord w;
+    FeatureMask *fm;
+    int i;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         fi = &feature_word_info[w];
@@ -408,6 +417,18 @@ static void update_tdx_cpuid_lookup_by_tdx_caps(void)
         entry->tdx_fixed1 &= ~config;
     }
 
+    for (i = 0; i < ARRAY_SIZE(tdx_attrs_ctrl_fields); i++) {
+        fm = &tdx_attrs_ctrl_fields[i];
+
+        if (~(tdx_caps->attrs_fixed0 & (1ULL << i))) {
+            tdx_cpuid_lookup[fm->index].tdx_fixed0 |= fm->mask;
+        }
+
+        if (tdx_caps->attrs_fixed1 & (1ULL << i)) {
+            tdx_cpuid_lookup[fm->index].tdx_fixed1 |= fm->mask;
+        }
+    }
+
     /*
      * Because KVM gets XFAM settings via CPUID leaves 0xD,  map
      * tdx_caps->xfam_fixed{0, 1} into tdx_cpuid_lookup[].tdx_fixed{0, 1}.
-- 
2.34.1


