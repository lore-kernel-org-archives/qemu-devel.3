Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6B5CF318C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 02:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svpF0-0007s0-Qr; Tue, 01 Oct 2024 22:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1svpEz-0007rj-5I
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 22:37:25 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1svpEx-0002w9-6u
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 22:37:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D6D26A40BCF;
 Wed,  2 Oct 2024 02:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58FBC4CEC6;
 Wed,  2 Oct 2024 02:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727836633;
 bh=y4WQQgNX9iQxJSHq7SBJ345D+/87gDCmZbgc8BcvMjk=;
 h=Date:From:To:Cc:Subject:From;
 b=DzyWsLTu1ALWQFWdl/qscQvGtzk8TW0QZ+7zZBfC01n7HxnjANw7lYaVJNoTf53WW
 p3foB+D10bI6ljQPes+U+FKKRebn182FnJIlSMETaEyPnc350gVyBQ1Z6254VoovGD
 BWknX7aYycmD6gWpxgsSQxa6oMoFJhPqAtfhOo7lHnNe5qS6tG/l10ypdGz3gueISM
 VE6GfdFnzAIdaqDSJqFCWp/6PEf+X6ivHR34+Kg8Bw2LC6omCw6r8rD+74s0d6J5z7
 JhGkJs4e9+ZG+vct4ZTjJUZ85re6xxHOeQXH7ue1C0wGNG4D95OfUOCJ3Z7E+n73Tl
 MWxvKLiMhG8bA==
Date: Wed, 2 Oct 2024 04:37:10 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: linux-parisc@vger.kernel.org
Subject: {PATCH] accel/tcg: Fix CPU specific unaligned behaviour
Message-ID: <Zvyx1kM4JljbzxQW@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When the emulated CPU reads or writes to a memory location
a) for which no read/write permissions exists, *and*
b) the access happens unaligned (non-natural alignment),
then the CPU should either
- trigger a permission fault, or
- trigger an unalign access fault.

In the current code the alignment check happens before the memory
permission checks, so only unalignment faults will be triggered.

This behaviour breaks the emulation of the PARISC architecture, where the CPU
does a memory verification first. The behaviour can be tested with the testcase
from the bugzilla report.

Add the necessary code to allow PARISC and possibly other architectures to
trigger a memory fault instead.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=219339


diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 117b516739..dd1da358fb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1684,6 +1684,26 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
     data->flags = flags;
 }
 
+/* when accessing unreadable memory unaligned, will the CPU issue
+ * a alignment trap or a memory access trap ? */
+#ifdef TARGET_HPPA
+# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  1
+#else
+# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  0
+#endif
+
+static void mmu_check_alignment(CPUState *cpu, vaddr addr,
+                       uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
+{
+    unsigned a_bits;
+
+    /* Handle CPU specific unaligned behaviour */
+    a_bits = get_alignment_bits(l->memop);
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
+    }
+}
+
 /**
  * mmu_lookup: translate page(s)
  * @cpu: generic cpu state
@@ -1699,7 +1719,6 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
 static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
-    unsigned a_bits;
     bool crosspage;
     int flags;
 
@@ -1708,10 +1727,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 
     tcg_debug_assert(l->mmu_idx < NB_MMU_MODES);
 
-    /* Handle CPU specific unaligned behaviour */
-    a_bits = get_alignment_bits(l->memop);
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
+    if (!CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK) {
+        mmu_check_alignment(cpu, addr, ra, type, l);
     }
 
     l->page[0].addr = addr;
@@ -1760,6 +1777,10 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         tcg_debug_assert((flags & TLB_BSWAP) == 0);
     }
 
+    if (CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK) {
+        mmu_check_alignment(cpu, addr, ra, type, l);
+    }
+
     /*
      * This alignment check differs from the one above, in that this is
      * based on the atomicity of the operation. The intended use case is

