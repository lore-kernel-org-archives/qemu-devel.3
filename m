Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E2606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rispop.dev header.i=@rispop.dev header.a=rsa-sha256 header.s=protonmail header.b=FUDUroO7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVknw-0000z3-K3; Tue, 24 Nov 2026 02:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xVknv-0000yD-2w
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:19:03 -0500
Received: from mail-244107.protonmail.ch ([109.224.244.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xVknt-0006Su-9T
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rispop.dev;
 s=protonmail; t=1795504730; x=1795763930;
 bh=k9wdRrkS6t2Q+FQIYvqTZaiZS/JXJKxtiqiOwRCiDWQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FUDUroO7cRcGCrajU0k62/CSt9WjP1HOdLdCzvA91HfhoYirTEOm59ybQdaVDQ59Y
 tAZpnIi2J54a8BxUNTmjRDNV3R/SMMvcOZdJVEqnla2qrO1ne25LkyXKvv9po9bDzY
 s+b/uTzjXKIyLQbXsJZpHbVR5+XNPEDfDkjtcSmIauOil1+SVyBm/aunWBgc5kGK1a
 IkAm4fnMv84+e9xFK7ec8b2Bc1J4Wzn6tSA4DPxm38sBcv655P+5QaoN/P4qIb5aMK
 Vp1Di6gwYKGhVnydP6+FOSAmU8NJY+xxgKyG8N+B8hK4NqCq2vVvoVLHRcQL9XqcyT
 olGGhUOCrlV2A==
X-Pm-Submission-Id: 4jYZ106RV4z2Scm6
From: Rishab Pradeep <rishab@rispop.dev>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, tarun.patanjali@utexas.edu,
 christopher.elwood2024@gmail.com, Rishab Pradeep <rishab@rispop.dev>
Subject: [RFC PATCH 1/2] accel/tcg: Add probe_access_perm()
Date: Tue, 24 Nov 2026 01:18:35 -0600
Message-ID: <20261124071836.208740-2-rishab@rispop.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124071836.208740-1-rishab@rispop.dev>
References: <20261124071836.208740-1-rishab@rispop.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=109.224.244.107; envelope-from=rishab@rispop.dev;
 helo=mail-244107.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a permission-only variant of probe_access() for callers that need
a faulting translation check without the side effects of an access.
The first user is the RISC-V Zicfiss AMO check in the next patch.

After a successful lookup it does not process watchpoints, mark clean
RAM dirty, or request the plugin slow path.  It also does not assert
that (addr, size) stays within one page: a caller probing the first
page of a page-crossing access should pass the full size, so that
target hooks (e.g. RISC-V PMP) see the same range as the real access,
and then probe the second page itself.

Side effects of the target's tlb_fill hook still apply, for example a
page walk updating guest PTE A/D bits.

Co-developed-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Signed-off-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Co-developed-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Rishab Pradeep <rishab@rispop.dev>
---
 accel/tcg/cputlb.c        | 11 +++++++++++
 include/accel/tcg/probe.h | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d79eae58df..6144a4efb0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1435,6 +1435,17 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
     return flags;
 }
 
+void probe_access_perm(CPUArchState *env, vaddr addr, int fault_size,
+                       MMUAccessType access_type, int mmu_idx,
+                       uintptr_t retaddr)
+{
+    CPUTLBEntryFull *full;
+    void *host;
+
+    probe_access_internal(env_cpu(env), addr, fault_size, access_type,
+                          mmu_idx, false, &host, &full, retaddr, false);
+}
+
 void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
index 0b788901ba..4233aa9489 100644
--- a/include/accel/tcg/probe.h
+++ b/include/accel/tcg/probe.h
@@ -71,6 +71,26 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
 #ifndef CONFIG_USER_ONLY
 
+/**
+ * probe_access_perm:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @fault_size: size passed to the target's tlb_fill (not asserted to
+ *              stay within one page; the caller splits page crossings)
+ * @access_type: read, write or execute permission
+ * @mmu_idx: MMU index to use for lookup
+ * @retaddr: return address for unwinding
+ *
+ * Permission-only lookup.  Raise an exception if the page does not
+ * satisfy @access_type.  Unlike probe_access, after a successful lookup
+ * do not process watchpoints or mark clean RAM dirty, and do not request
+ * plugin slow-path.  Side effects of the target's tlb_fill hook still
+ * apply, for example a page walk updating guest PTE A/D bits.
+ */
+void probe_access_perm(CPUArchState *env, vaddr addr, int fault_size,
+                       MMUAccessType access_type, int mmu_idx,
+                       uintptr_t retaddr);
+
 /**
  * probe_access_full:
  * Like probe_access_flags, except also return into @pfull.
-- 
2.56.0


