Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A6CC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJACT-000203-3g; Sun, 25 May 2025 08:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJABf-0008Ed-Iq; Sun, 25 May 2025 08:10:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJABZ-0003sD-V6; Sun, 25 May 2025 08:10:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 793DC124E64;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 86FAE215FCB;
 Sun, 25 May 2025 15:08:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Ewan Hai <ewanhai-oc@zhaoxin.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 50/59] i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG
 supported
Date: Sun, 25 May 2025 15:08:07 +0300
Message-Id: <20250525120818.273372-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Since commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
x86_cpu_expand_features() instead of cpu_x86_cpuid()") and
commit 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
env->features[FEAT_8000_0001_ECX]"), it gets warnings when booting the
VM with vcpus >= 2 and with tcg:

  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.cmp-legacy [bit 1]

This is because, after the two commits, CPUID_HT and CPUID_EXT3_CMP_LEG
are set in env->features[] when vcpus >=2 (in x86_cpu_expand_features())
later in x86_cpu_filter_features() it will check against the TCG supported
bits. However, current TCG doesn't mark the two bits as supported, hence
the warnings.

Fix it by adding the two bits to the supported bits of TCG since multiple
vcpus are supported by TCG.

Fixes: c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()")
Fixes: 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX]")
Reported-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250514031652.838763-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5979f50fa9fdbb3fb49e2b498f84faa7503c8ed1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3fb1ec62da..5e12cba1b8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -774,11 +774,12 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
           CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
           CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
-          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
+          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE | \
+          CPUID_HT)
           /* partly implemented:
           CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
           /* missing:
-          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
+          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_TM, CPUID_PBE */
 
 /*
  * Kernel-only features that can be shown to usermode programs even if
@@ -846,7 +847,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
-          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES)
+          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES | \
+          CPUID_EXT3_CMP_LEG)
 
 #define TCG_EXT4_FEATURES 0
 
-- 
2.39.5


