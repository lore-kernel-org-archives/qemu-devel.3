Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05737106286C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0HqX-0006aN-1h; Wed, 11 Mar 2026 07:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w0HqU-0006ZF-Bd
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:35:22 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w0HqS-0006Ep-RZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:35:22 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.53])
 by linux.microsoft.com (Postfix) with ESMTPSA id DBCF320B7129;
 Wed, 11 Mar 2026 04:35:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBCF320B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1773228919;
 bh=iOL+n46cLKhORko9nhgf+iEAjALxz9Rv3YzT/yKIKlk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WZkgXmt2lpNOe3AVkchvhGQgFDsfmSdeRV5LdV7KByQSE4KWtOm3nx6A7ZGpDUkfc
 tLJps3KaEHEi4AjW6GLPHNBZj9+ZuOalolege/wOHM2QzftpNJUE2XBKIcDMsNdKt/
 nqhgW14v0VR4J5K7di99bfSFtGsZ+ROMNLquhAf0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 2/9] target/i386/mshv: fix cpuid propagation bug
Date: Wed, 11 Mar 2026 12:34:58 +0100
Message-Id: <20260311113505.1177878-3-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
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


