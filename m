Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64917606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Xh1Xv0QF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Jp-0006ci-UP; Mon, 16 Nov 2026 15:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Jj-000644-PC; Mon, 16 Nov 2026 15:28:43 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Jh-0001XS-Fc; Mon, 16 Nov 2026 15:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=zNXVTbupPjQbsSjllCruYuZDdN1rmd533t68WmrQUUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Xh1Xv0QFeet/zzMQ3KwqtOmebLLZinbufaG/0zEI3oveqN9fVf4GqTjVs5KeHt6pE
 HTyxh1ReHwvpAu6W/mkCAfDSq2guDJPGiuheHqTKdWxNez7H3586vO2dgTpzywirH4
 tzWNAEi//b33EY9mylLfKOvfpFbHgM7GlDsYW+EHD2pvsscXkLSJEHv8h7o9SsBU55
 X9R/kDr93fn+Daa9HKTbUjO7Igqsu1CyfZQfWlsEN8stcX0RAYkVJwWb1v22AmD+1z
 AqIbBMfY+hn8+YS1Kw0cLgg+zrLfW5x5oaqN+fyIjstg7oIScuPcbTNX6w1Y9JOop7
 xitzCCULQoEKg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 515881E71B2;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4E74E45FBDE;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BE084B8E80; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 29/63] target/arm: For linux-user,
 prioritize PC misalignment fault over insn abort
Date: Mon, 16 Nov 2026 23:25:08 +0300
Message-ID: <20261116202554.535325-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The Arm architecture requires that for PC alignment fault exceptions
take precedence over Instruction Abort exceptions.  We get this wrong
for linux-user mode, because QEMU detects the lack of any backing
memory via probe_access_internal(), and calls
arm_cpu_record_sigsegv(), which always reports either a Translation
or Permission fault:

#3  0x0000649548976b94 in arm_deliver_fault (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, mmu_idx=0, fi=0x7fff87e4c940)
    at ../../target/arm/tcg/tlb_helper.c:274
#4  0x0000649548976d69 in arm_cpu_record_sigsegv (cs=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
    at ../../target/arm/tcg/tlb_helper.c:421
#5  0x0000649548c97650 in cpu_loop_exit_sigsegv (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
    at ../../linux-user/signal.c:761
#6  0x00006495488f8235 in probe_access_internal (env=0x649555ce99a0, addr=1, fault_size=1, access_type=MMU_INST_FETCH, nonfault=false, ra=0)
    at ../../accel/tcg/user-exec.c:790
#7  0x00006495488f850d in get_page_addr_code_hostp (env=0x649555ce99a0, addr=1, hostp=0x7fff87e4ca70) at ../../accel/tcg/user-exec.c:828
#8  0x00006495488e5433 in get_page_addr_code (env=0x649555ce99a0, addr=1) at ../../accel/tcg/internal-common.h:116
#9  0x00006495488e56bd in tb_htable_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:206
#10 0x00006495488e58c8 in tb_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:251
#11 0x00006495488e5d2a in helper_lookup_tb_ptr (env=0x649555ce99a0) at ../../accel/tcg/cpu-exec.c:398
#12 0x00007d973c000270 in code_gen_buffer ()

Make arm_cpu_record_sigsegv() report a PC alignment fault for
MMU_INST_FETCH accesses to non-4-aligned addresses for A64 and A32,
matching the logic used in arm_cpu_tlb_fill_align() for system
emulation.  (Unaligned PC faults can't happen for Thumb.) This is
then passed to the guest binary as SIGBUS rather than SIGSEGV.

(The Fixes tag is for the commit that introduced this function, but
the bug was also present in the previous implementation.  It's an odd
corner case so it's not worth the effort to try to backport the fix
beyond that.)

Cc: qemu-stable@nongnu.org
Fixes: 9b12b6b44250c2 ("target/arm: Implement arm_cpu_record_sigsegv")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4699
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261026140942.2768950-1-peter.maydell@linaro.org
(cherry picked from commit 753e24f55f0f02b648df35b7ecf4831cb952f637)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4c3f16dc2aa..2e84b1cb369 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -418,6 +418,10 @@ void arm_cpu_record_sigsegv(CPUState *cs, vaddr addr,
      * For now, it's easiest to deliver the fault normally.
      */
     cpu_restore_state(cs, ra);
+    if (access_type == MMU_INST_FETCH && !cpu->env.thumb && (addr & 3)) {
+        /* Misaligned PC faults take precedence over insn abort */
+        fi.type = ARMFault_Alignment;
+    }
     arm_deliver_fault(cpu, addr, access_type, MMU_USER_IDX, &fi);
 }
 
-- 
2.47.3


