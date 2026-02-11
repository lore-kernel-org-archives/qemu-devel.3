Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54C1ECD6C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCl6-00031l-2q; Wed, 11 Feb 2026 11:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqCXr-0007EG-D5
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:27 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqCXp-0003QP-SJ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:27 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id 080DB20B716B;
 Wed, 11 Feb 2026 07:54:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 080DB20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770825264;
 bh=eh+qZ3pav78zuxhcFlBSXV75jt9gIA7420fX9KdU4PU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PMKlSlBGa5z5ezifnKD/QcvRzYq0Hghg32eF6bljI9NNzyHDwrQiw9JrrrG4xQW0E
 YrDNaO3UeQ6kDvyKuGAI4U/4AEUuNPkPkHz/Wki/2YqjJjoQBkvKpWFg+z+HAbibYc
 ASjf+azvPo5tnplfr4fepEyg+v2DZSxXLZ/aM4lo=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 04/10] target/i386/mshv: fix cpuid propagation bug
Date: Wed, 11 Feb 2026 16:54:04 +0100
Message-Id: <20260211155410.203883-5-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Feb 2026 11:07:31 -0500
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

The list argument was missing a pointer and hence e.g. -cpu qemu64 and
-cpu EPYC would produce the same of cpuid leaves.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 586383b882..5c46cd67ec 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -441,7 +441,7 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
-static void add_cpuid_entry(GList *cpuid_entries,
+static void add_cpuid_entry(GList **cpuid_entries,
                             uint32_t function, uint32_t index,
                             uint32_t eax, uint32_t ebx,
                             uint32_t ecx, uint32_t edx)
@@ -456,10 +456,10 @@ static void add_cpuid_entry(GList *cpuid_entries,
     entry->ecx = ecx;
     entry->edx = edx;
 
-    cpuid_entries = g_list_append(cpuid_entries, entry);
+    *cpuid_entries = g_list_append(*cpuid_entries, entry);
 }
 
-static void collect_cpuid_entries(const CPUState *cpu, GList *cpuid_entries)
+static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
@@ -615,7 +615,7 @@ static int set_cpuid2(const CPUState *cpu)
     struct hv_cpuid_entry *entry;
     GList *entries = NULL;
 
-    collect_cpuid_entries(cpu, entries);
+    collect_cpuid_entries(cpu, &entries);
     n_entries = g_list_length(entries);
 
     cpuid_size = sizeof(struct hv_cpuid)
-- 
2.34.1


