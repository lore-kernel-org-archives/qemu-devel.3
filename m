Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86A9CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGID1-00073S-E7; Mon, 12 Oct 2026 11:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xGICx-00072r-55
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:44:59 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xGICs-0004bB-TK
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:44:57 -0400
Received: from laptop.localdomain (unknown [81.196.141.65])
 by linux.microsoft.com (Postfix) with ESMTPSA id BD7B820B7169;
 Mon, 12 Oct 2026 08:44:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD7B820B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791819890;
 bh=m0/6LBaTSZBurt5DrWgHDAFzsGIP5qxDVOvdE1hOpJI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XItWYoXQ3nyF6XQVC1D1Ztp1jQxrnv7pEjMLaMD5NhHxca2YCqtRLKQIDO4ONEdHs
 cfPgBqabOBvvFuolJuN5tvqo1MwtyG5Cj4dcv5CbbHMuj3pAEwg/jfpbOfYn8lXuhc
 xdlZPmJyPJGceG8+8mgYHY3kXIlDqr0Xm8VDhWQA=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH 2/2] mshv/mshv-cpu.c: Collect all Intel topology subleaves and
 AMD cache subleaves
Date: Mon, 12 Oct 2026 18:44:42 +0300
Message-ID: <20261012154442.306511-3-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012154442.306511-1-dblanzeanu@linux.microsoft.com>
References: <20261012154442.306511-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

This fix makes AMD cache overrides subleaf-specific, makes 0x8000_001E
apply regardless of ECX (not subleaf specific) and collects Intel
topology subleaves (0x0b, 0x1f).

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 41 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4df73bb497..25670667f0 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1093,6 +1093,21 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
     /* Collect basic leaves (0x0 to max_basic_leaf) */
     for (leaf = 0; leaf <= max_basic_leaf; leaf++) {
         bool has_subleaves = false;
+
+        if (leaf == 0x0b || leaf == 0x1f) {
+            for (subleaf = 0; subleaf < max_subleaf; subleaf++) {
+                cpu_x86_cpuid(env, leaf, subleaf,
+                              &eax, &ebx, &ecx, &edx);
+                add_cpuid_entry(cpuid_entries, leaf, subleaf,
+                                eax, ebx, ecx, edx);
+
+                if (!(ecx & 0xff00)) {
+                    break;
+                }
+            }
+            continue;
+        }
+
         for (int i = 0; i < n_subleaf_leaves; i++) {
             if (leaf == leaves_with_subleaves[i]) {
                 has_subleaves = true;
@@ -1150,6 +1165,20 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
 
     /* Collect extended leaves (0x80000000 to max_extended_leaf) */
     for (leaf = 0x80000000; leaf <= max_extended_leaf; leaf++) {
+        if (leaf == 0x8000001d) {
+            for (subleaf = 0; subleaf < max_subleaf; subleaf++) {
+                cpu_x86_cpuid(env, leaf, subleaf,
+                              &eax, &ebx, &ecx, &edx);
+
+                add_cpuid_entry(cpuid_entries, leaf, subleaf,
+                                eax, ebx, ecx, edx);
+                if ((eax & 0x1f) == 0) {
+                    break;
+                }
+            }
+            continue;
+        }
+
         cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
         add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
     }
@@ -1229,12 +1258,10 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
          * 0xb - Extended Topology Enumeration Leaf
          * 0x1f - V2 Extended Topology Enumeration Leaf
          * AMD
-         * 0x8000_001e - Processor Topology Information
          * 0x8000_0026 - Extended CPU Topology
          */
         if (entry->function == 0xb ||
             entry->function == 0x1f ||
-            entry->function == 0x8000001e ||
             entry->function == 0x80000026) {
             subleaf_specific = 1;
             always_override = 1;
@@ -1245,12 +1272,14 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
          * 0x0D: Processor Extended State Enumeration
          * 0x0F: Platform QoS Monitoring
          * 0x10: Platform QoS Enforcement
+         * 0x8000_001D: AMD Cache Topology
          */
         } else if (entry->function == 0x04 ||
                    entry->function == 0x07 ||
                    entry->function == 0x0d ||
                    entry->function == 0x0f ||
-                   entry->function == 0x10) {
+                   entry->function == 0x10 ||
+                   entry->function == 0x8000001d) {
             subleaf_specific = 1;
             always_override = 1;
         /* Basic feature leaves (no subleaves) */
@@ -2339,11 +2368,6 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     header = (X86XSaveHeader *)(env->xsave_buf + sizeof(X86LegacyXSaveArea));
     header->xcomp_bv = header->xstate_bv | (1ULL << 63);
 
-    /*
-     * TODO: populate topology info:
-     * X86CPUTopoInfo *topo_info = &env->topo_info;
-     */
-
     ret = init_cpuid2(cpu);
     assert(ret == 0);
 
@@ -2394,6 +2418,7 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
     /* Disable nested virtualization features not yet supported by MSHV */
     if (func == 0x80000001 && reg == R_ECX) {
         ret &= ~CPUID_EXT3_SVM;
+        ret |= CPUID_EXT3_TOPOEXT;
     }
     if (func == 0x01       && reg == R_ECX) {
         ret &= ~CPUID_EXT_VMX;
-- 
2.53.0


