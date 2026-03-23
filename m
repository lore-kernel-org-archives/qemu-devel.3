Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCD1EC01CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4duS-0000KX-B4; Mon, 23 Mar 2026 07:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4duP-0000I6-A6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:57:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4duN-0003e5-Df
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:57:25 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id DCE0120B7129;
 Mon, 23 Mar 2026 04:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCE0120B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774267042;
 bh=ItrHOC5nPemd66dEK2NgZsgS7P6ajPcgEYGrhuuCrYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DptyRsTEo1WwaFePrC8rerBu1dyjI+vHErQHzknt4LDChCBrTtlGN1KD8kpI22K0R
 8pTkPRlLw/UwGwV1pku9HDM5IcAYkreGoLKp6a7TmqPprG6320T8i4kZO/Mg/033Ig
 TNeD+3hOFUXgwZn0ghYzwZLwcMQn+iZCaEddbaPI=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 3/9] target/i386/mshv: fix various cpuid traversal bugs
Date: Mon, 23 Mar 2026 12:57:05 +0100
Message-Id: <20260323115711.353793-4-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- Hardcoded max_leaf was not accurate. We query leaf 0x0 and 0x80000000 to
  get the actual max leaves

- On all 0 zeroes on leaf 0x0d, we register 0-63 subleaves with zeros
  indicating XSAVE is disabled

- Subleaf 0 was hardcoded, so the Hypervisor returned defaults for other
  subleaves

- Subleaf 0 was hardcoded, so we were passing 0 instead of actual subleaf
  when adding entries. We now pass the correct subleaf value to
  add_cpuid_entry()

- Leaves 0x04,0x07,0d,0f,10 weren't marked as subleaf-specific

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 target/i386/mshv/mshv-cpu.c | 88 +++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f1cc4abc5c..4183727a86 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -465,14 +465,17 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
     CPUX86State *env = &x86_cpu->env;
     uint32_t eax, ebx, ecx, edx;
     uint32_t leaf, subleaf;
-    size_t max_leaf = 0x1F;
-    size_t max_subleaf = 0x20;
-
-    uint32_t leaves_with_subleaves[] = {0x4, 0x7, 0xD, 0xF, 0x10};
+    uint32_t max_basic_leaf, max_extended_leaf;
+    uint32_t max_subleaf = 0x20;
+    uint32_t leaves_with_subleaves[] = {0x04, 0x07, 0x0d, 0x0f, 0x10};
     int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
 
-    /* Regular leaves without subleaves */
-    for (leaf = 0; leaf <= max_leaf; leaf++) {
+    /* Get maximum basic and and extended CPUID leaves */
+    cpu_x86_cpuid(env, 0, 0, &max_basic_leaf, &ebx, &ecx, &edx);
+    cpu_x86_cpuid(env, 0x80000000, 0, &max_extended_leaf, &ebx, &ecx, &edx);
+
+    /* Collect basic leaves (0x0 to max_basic_leaf) */
+    for (leaf = 0; leaf <= max_basic_leaf; leaf++) {
         bool has_subleaves = false;
         for (int i = 0; i < n_subleaf_leaves; i++) {
             if (leaf == leaves_with_subleaves[i]) {
@@ -483,27 +486,40 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
 
         if (!has_subleaves) {
             cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
-            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
-                /* all zeroes indicates no more leaves */
-                continue;
-            }
-
             add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
             continue;
         }
 
+        /*
+         * Valid XSAVE components can exist at a higher index se we need to set
+         * all subleaves for leaf 0x0d, even if we encounter an empty one.
+         */
+        if (leaf == 0x0d) {
+            for (subleaf = 0; subleaf <= 63; subleaf++) {
+                cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
+                add_cpuid_entry(cpuid_entries, leaf, subleaf,
+                                eax, ebx, ecx, edx);
+            }
+            continue;
+        }
+
         subleaf = 0;
         while (subleaf < max_subleaf) {
             cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
 
             if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
-                /* all zeroes indicates no more leaves */
                 break;
             }
-            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            add_cpuid_entry(cpuid_entries, leaf, subleaf, eax, ebx, ecx, edx);
             subleaf++;
         }
     }
+
+    /* Collect extended leaves (0x80000000 to max_extended_leaf) */
+    for (leaf = 0x80000000; leaf <= max_extended_leaf; leaf++) {
+        cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
+        add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+    }
 }
 
 static int register_intercept_result_cpuid_entry(const CPUState *cpu,
@@ -576,22 +592,40 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
         subleaf_specific = 0;
         always_override = 1;
 
-        /* Intel */
-        /* 0xb - Extended Topology Enumeration Leaf */
-        /* 0x1f - V2 Extended Topology Enumeration Leaf */
-        /* AMD */
-        /* 0x8000_001e - Processor Topology Information */
-        /* 0x8000_0026 - Extended CPU Topology */
-        if (entry->function == 0xb
-            || entry->function == 0x1f
-            || entry->function == 0x8000001e
-            || entry->function == 0x80000026) {
+        /*
+         * Intel
+         * 0xb - Extended Topology Enumeration Leaf
+         * 0x1f - V2 Extended Topology Enumeration Leaf
+         * AMD
+         * 0x8000_001e - Processor Topology Information
+         * 0x8000_0026 - Extended CPU Topology
+         */
+        if (entry->function == 0xb ||
+            entry->function == 0x1f ||
+            entry->function == 0x8000001e ||
+            entry->function == 0x80000026) {
+            subleaf_specific = 1;
+            always_override = 1;
+        /*
+         * Feature enumeration leaves (subleaf-specific)
+         * 0x04: Deterministic Cache Parameters
+         * 0x07: Structured Extended Feature Flags
+         * 0x0D: Processor Extended State Enumeration
+         * 0x0F: Platform QoS Monitoring
+         * 0x10: Platform QoS Enforcement
+         */
+        } else if (entry->function == 0x04 ||
+                   entry->function == 0x07 ||
+                   entry->function == 0x0d ||
+                   entry->function == 0x0f ||
+                   entry->function == 0x10) {
             subleaf_specific = 1;
             always_override = 1;
-        } else if (entry->function == 0x00000001
-            || entry->function == 0x80000000
-            || entry->function == 0x80000001
-            || entry->function == 0x80000008) {
+        /* Basic feature leaves (no subleaves) */
+        } else if (entry->function == 0x00000001 ||
+                   entry->function == 0x80000000 ||
+                   entry->function == 0x80000001 ||
+                   entry->function == 0x80000008) {
             subleaf_specific = 0;
             always_override = 1;
         }
-- 
2.34.1


