Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EF3C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXK-0004kR-Ft; Wed, 07 Feb 2024 13:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXH-0004hy-3S
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXF-00087u-Fp
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:38 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5616B619D7;
 Wed,  7 Feb 2024 18:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3419EC43390;
 Wed,  7 Feb 2024 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330036;
 bh=98mbO8TIJY8H/aHyk2tyxWud+0ypEkYGWnHIB/+v55o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J33HycEiFoJvFiphlurxfoPMYFzYlTto+n2J+NkvCYNXlK8CYfvryhXfqxuNRVBSy
 zJgcpeUJQmtLQR1pxVE2jkzplqPa6SaVDB0ypZTebP9w21ko+kUVvlBWqNH/K8vyTY
 sDusbKOLLHYLWqisAmSgiA/zJFSFDh7dwF7byJ1ZPQz6GVeGiVhsuHtjE70FgH9l4Q
 KWFoxGM9+zkgKSpSZ2YCaxXc6TbOZg8PdxBWHqE1pdf5tNAZeKIE/IKQd53VaPba9z
 ofArXS0Tq5r9fJjV/lIavEVCd70Hhp5yjWh08NwYLOhg7lNLEu9NyTu5uoRka0XsOH
 H0e95FmarA3nw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 07/13] target/hppa: Implement do_transaction_failed handler
 for I/O errors
Date: Wed,  7 Feb 2024 19:20:17 +0100
Message-ID: <20240207182023.36316-8-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Add the do_transaction_failed() handler to tigger a HPMC to the CPU
in case of I/O transaction errors.

This is a preparation commit.
We still lack implementation for some registers, so do not yet enable sending
HPMCs.  Having this hunk here now nevertheless helps for the further
development, so that it can easily be enabled later on.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.c        |  1 +
 target/hppa/cpu.h        |  5 +++++
 target/hppa/mem_helper.c | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5f87c1b12a..afe73d4474 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -191,6 +191,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
+    .do_transaction_failed = hppa_cpu_do_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
 };
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 06b65f2258..5a4b56c975 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -383,6 +383,11 @@ bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot,
                               HPPATLBEntry **tlb_entry);
+void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr);
 extern const MemoryRegionOps hppa_io_eir_ops;
 extern const VMStateDescription vmstate_hppa_cpu;
 void hppa_cpu_alarm_timer(void *);
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 629a9d90ef..676c0b3003 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -353,6 +353,25 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
+void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr)
+{
+    CPUHPPAState *env = cpu_env(cs);
+
+    qemu_log_mask(LOG_GUEST_ERROR, "HPMC at " TARGET_FMT_lx ":" TARGET_FMT_lx
+                " while accessing I/O at %#08" HWADDR_PRIx "\n",
+                env->iasq_f, env->iaoq_f, physaddr);
+
+    /* FIXME: Enable HPMC exceptions when firmware has clean device probing */
+    if (0) {
+        raise_exception_with_ior(env, EXCP_HPMC, retaddr, addr,
+                                 MMU_IDX_MMU_DISABLED(mmu_idx));
+    }
+}
+
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                        MMUAccessType type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
-- 
2.43.0


