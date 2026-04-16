Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA04CF8A16A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDLZJ-0008OS-IY; Thu, 16 Apr 2026 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDLZB-0008Ng-7v
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:11:29 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDLZ9-0002Ne-Oc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:11:28 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6919320B7128;
 Thu, 16 Apr 2026 05:11:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6919320B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776341486;
 bh=FbXEXuqW8Bve0EgBTU0ARZN82HgvfmY8otXukE5Cjuw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cqg6fdyreB5+iZi/3N8R3Wj5yD8Gj7wp5l6JHGZpXEepfv4S184pgJJnhI6FaNwFg
 /UbRQ/N0VnXWTabGUlqZIxYOyhElUyzCfPVu9/KLgXMZ0MJyDmeWRMllVOmmyHul3/
 V9E2Fd+++vMakqq264jEoiBDu8eosABySsRyMswk=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH v6 2/9] target/i386/mshv: fix cpuid propagation bug
Date: Thu, 16 Apr 2026 14:11:09 +0200
Message-Id: <20260416121116.527927-3-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The list argument was missing a pointer and hence e.g. -cpu qemu64 and
-cpu EPYC would produce the same of cpuid leaves.

Fixes: 4fa04dd1621 ("target/i386: Register CPUID entries with MSHV")

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 target/i386/mshv/mshv-cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2bc978deb2..f1cc4abc5c 100644
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


