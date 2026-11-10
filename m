Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90D606A93F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MiwOov1W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQiao-0003l3-BA; Tue, 10 Nov 2026 04:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xQiae-0003k3-RW
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:32 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xQiac-0004oJ-7E
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:31 -0500
Received: from laptop.localdomain (unknown [81.196.141.39])
 by linux.microsoft.com (Postfix) with ESMTPSA id 80FCC20B716A;
 Tue, 10 Nov 2026 01:56:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80FCC20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794304586;
 bh=no+9d5177Y6rlSGXUP2mWc7YHhZJhKDbXw2eYZHQUQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MiwOov1Wd8V/JJ8/0E5r+282C3WWL5vRiBeHW3vS711PCxu9MVKnRqa+ZQzHiPlK1
 sKNJ6yeh78cjYGrM54c1gG+ttvZ1VAYjVNEgUYJH0xRYniZy7VP/GA+fxVCrfVHn/n
 xgBA5hmcURpberd8tyGcIXc/RYA709mXoVc9z8bI=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH v2 2/3] mshv/mshv-cpu.c: Collect all Intel topology subleaves
 and AMD cache subleaves
Date: Tue, 10 Nov 2026 11:56:16 +0200
Message-ID: <20261110095617.50713-3-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
References: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.54.0


