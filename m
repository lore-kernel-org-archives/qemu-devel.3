Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B28F43858
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD3c0-0006eI-TU; Wed, 15 Apr 2026 13:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wD3bh-0006aX-6x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:00:56 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wD3bY-0005y3-1M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:00:48 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id C15B320B712B;
 Wed, 15 Apr 2026 10:00:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C15B320B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776272436;
 bh=OoWA/l83V5921S6Aaii2fi8kk8wsUhPlqdFKGh7bggY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ORqVd955DvcP3OwPVOhXqMJFmOqZYGVZYs+/39CeT0E0mmY7ndm8t4De76Tv7non+
 vt4mi3UqL8EascKlxd8c7baUNW0sYv2yuhKBAmrcxt8PVxJ5tUgl0lhoPzfrX34C8o
 4h/HrpMvmgbp2VZ56kSWzyEUzwe/G4+uKS7+nYMQ=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v5 8/9] target/i386/mshv: use hv-provided [0xD,1+2].EBX
Date: Wed, 15 Apr 2026 19:00:11 +0200
Message-Id: <20260415170012.520934-9-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170012.520934-1-magnuskulke@linux.microsoft.com>
References: <20260415170012.520934-1-magnuskulke@linux.microsoft.com>
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

We cannot statically set the responses for CPUID[0xD,{1,2}].EBX, b/c
those are dynamic, dependent on which features the guest enables.

Hence we mask EBX when registering answers for those subleaves at the
hypervisor, which will result in the hypervisor providing us answers,
considering XCR0 and XSS.

The reported size now reflects the field masks properly (without the
mask they were 576 and 10728, which is wrong):

$ cpuid -l 0xd -s 0
CPU 0:
   XSAVE features (0xd/0):
      XCR0 valid bit field mask               = 0x00000000000600e7
      ...
      bytes required by fields in XCR0        = 0x00002b00 (11008)
      bytes required by XSAVE/XRSTOR area     = 0x00002b00 (11008)

$ cpuid -l 0xd -s 1
CPU 0:
   XSAVE features (0xd/1):
      ...
      SAVE area size in bytes                     = 0x000029c0 (10688)
      IA32_XSS lower 32 bits valid bit field mask = 0x00001800
      IA32_XSS upper 32 bits valid bit field mask = 0x00000000

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index ee25eb5f6f..5360a9e190 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -528,6 +528,7 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
 static int register_intercept_result_cpuid_entry(const CPUState *cpu,
                                                  uint8_t subleaf_specific,
                                                  uint8_t always_override,
+                                                 uint32_t ebx_mask,
                                                  struct hv_cpuid_entry *entry)
 {
     int ret;
@@ -543,11 +544,12 @@ static int register_intercept_result_cpuid_entry(const CPUState *cpu,
         /*
          * Masks specify which bits to override. Set to 0xFFFFFFFF to
          * override all bits with the values from the QEMU CPU model.
+         * A mask of 0 lets the hypervisor supply its own value.
          */
         .result.eax = entry->eax,
         .result.eax_mask = 0xFFFFFFFF,
         .result.ebx = entry->ebx,
-        .result.ebx_mask = 0xFFFFFFFF,
+        .result.ebx_mask = ebx_mask,
         .result.ecx = entry->ecx,
         .result.ecx_mask = 0xFFFFFFFF,
         .result.edx = entry->edx,
@@ -582,6 +584,7 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
     int ret = 0, entry_ret;
     struct hv_cpuid_entry *entry;
     uint8_t subleaf_specific, always_override;
+    uint32_t ebx_mask;
 
     for (size_t i = 0; i < cpuid->nent; i++) {
         entry = &cpuid->entries[i];
@@ -589,6 +592,7 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
         /* set defaults */
         subleaf_specific = 0;
         always_override = 1;
+        ebx_mask = 0xFFFFFFFF;
 
         /*
          * Intel
@@ -628,8 +632,22 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
             always_override = 1;
         }
 
-        entry_ret = register_intercept_result_cpuid_entry(cpu, subleaf_specific,
+        /*
+         * CPUID[0xD,0].EBX and CPUID[0xD,1].EBX report the XSAVE area
+         * size based on features currently enabled in XCR0/XSS. These
+         * values are dynamic and must not be overridden with static
+         * results from the QEMU CPU model. Setting ebx_mask to 0 lets
+         * the hypervisor supply EBX based on the guest's actual state.
+         */
+        if (entry->function == 0x0d &&
+           (entry->index == 0 || entry->index == 1)) {
+            ebx_mask = 0;
+        }
+
+        entry_ret = register_intercept_result_cpuid_entry(cpu,
+                                                          subleaf_specific,
                                                           always_override,
+                                                          ebx_mask,
                                                           entry);
         if ((entry_ret < 0) && (ret == 0)) {
             ret = entry_ret;
@@ -1663,6 +1681,11 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
     if (func == 0x01       && reg == R_ECX) {
         ret &= ~CPUID_EXT_VMX;
     }
+
+    if (func == 0x07 && idx == 0 && reg == R_ECX) {
+        ret &= ~CPUID_7_0_ECX_CET_SHSTK;
+    }
+
     return ret;
 }
 
-- 
2.34.1


