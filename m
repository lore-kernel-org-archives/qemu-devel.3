Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAC606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b=kY6NB66f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTbB-0003Ya-Ej; Mon, 23 Nov 2026 07:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhumingjie.123@picoheart.com>)
 id 1xVPyJ-0000Bd-S6
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:04:23 -0500
Received: from va-2-57.ptr.blmpb.com ([209.127.231.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhumingjie.123@picoheart.com>)
 id 1xVPyH-0006zj-Nm
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1795424641; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/cM7r4S7tCPBzN+aFmCmHaJo9HkzCQ7ydYXUmW6aYlc=;
 b=kY6NB66fkgBznIoKpz7sMMs0c+OjauhSLOiN1Y2g1tYaKQwL7IE56lDdOVtBc1QwQC/izP
 67pIUAt94+PFf6lcMhJNdL4gTVx5P4Dl9U21muOzMe17gJ/HNOffuK1PgYTKvZVnM6PWlC
 Ri8rchZRMVpNBZI82Tcj2PJvx8AXxzhszbQzSsV+kakMXYKhyQZkuZdRiMzpuZeKDQ6FoG
 G5qTqskLOBBO8WZox1rVFjSHW2JfwgvzkNAA8q1C+Qrk3tVdP2x31k3DeNO0k0NIP9rHEj
 3Dfgg29Dh+LVSWa7Kgk9RaUWTWVt1DHH3fJumTMEGIPpEsoCEt9u9wFhP6qL6g==
Cc: "Richard Henderson" <richard.henderson@linaro.org>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Mingjie Zhu" <zhumingjie.123@picoheart.com>, 
 "Ziang Wang" <wangziang.ok@picoheart.com>
X-Original-From: Mingjie Zhu <zhumingjie.123@picoheart.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Subject: [PATCH] accel/tcg: Enforce .valid.unaligned for MMIO accesses
Date: Mon, 23 Nov 2026 17:03:55 +0800
X-Lms-Return-Path: <lba+26b04017e+1ab39e+nongnu.org+zhumingjie.123@picoheart.com>
Received: from L67K0VQC6L ([210.22.96.226]) by smtp.feishu.cn with ESMTPS;
 Mon, 23 Nov 2026 17:03:57 +0800
From: "Mingjie Zhu" <zhumingjie.123@picoheart.com>
Message-Id: <20261123090355.30085-1-zhumingjie.123@picoheart.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.127.231.57;
 envelope-from=zhumingjie.123@picoheart.com; helo=va-2-57.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Nov 2026 07:56:42 -0500
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

Devices use MemoryRegionOps .valid.unaligned to declare whether
unaligned accesses are accepted. It defaults to false, and the
comment in memory.h documents that unaligned accesses throw
machine checks in that case. Under TCG this contract is not
enforced.

int_ld_mmio_beN() and int_st_mmio_leN() split an access into
aligned fragments before dispatching them, so
memory_region_access_valid() only ever sees aligned fragments
and its alignment check never fails. As long as every fragment
satisfies min_access_size, one unaligned access reaches the
device as several smaller accesses and the guest gets no
exception.

For example, on the RISC-V virt machine the ACLINT mtimer has
min_access_size = 4 and max_access_size = 8. An 8-byte read at
mtimecmp + 4 is split into two 4-byte reads. An 8-byte write
there becomes two 4-byte writes: the first one modifies the
high 32 bits of mtimecmp, while the second one lands past the
register and is only logged as an invalid write by the device.

Check .valid.unaligned with the offset and size of the whole
access before splitting, in both the read and the write path,
and call cpu_unaligned_access() on violation. On RISC-V this
reports mcause 4 (load address misaligned) for reads and
mcause 6 (store/AMO address misaligned) for writes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3578
Signed-off-by: Ziang Wang <wangziang.ok@picoheart.com>
Signed-off-by: Mingjie Zhu <zhumingjie.123@picoheart.com>
---
Hello,

This issue was reported at
https://gitlab.com/qemu-project/qemu/-/issues/3578 some time ago
but has not been handled yet. I ran into the same behavior with a
device that rejects unaligned MMIO accesses, and prepared this
fix.

The issue only mentions the load path (int_ld_mmio_beN()); the
store path (int_st_mmio_leN()) has the same problem, so this
patch covers both.

Tested on x86_64 Ubuntu 22.04, with upstream master 8f66cb7904
plus this patch, built with --target-list=riscv64-softmmu and
-Werror. The guest runs on -M virt -bios none with a bare-metal
test accessing the ACLINT mtimer at 0x2004000:

- 8-byte read at 0x2004004: without the patch, the device
  receives two 4-byte reads (at 0x2004004 and 0x2004008) and no
  exception is raised; with the patch, the guest traps with
  mcause 4, mtval 0x2004004, and the device sees no access.
- 8-byte write at 0x2004004: without the patch, the device is
  written with two 4-byte writes at the same addresses; with the
  patch, the guest traps with mcause 6, mtval 0x2004004, and the
  device sees no access.
- Aligned 8-byte read at 0x2004000: works as before, with or
  without the patch; the device receives a single 8-byte read.
- Unaligned read from RAM: unaffected, works as before.

Device accesses were observed with -trace
memory_region_ops_read/write, and guest exceptions with -d int.
Without the patch, the device also logs "aclint-mtimer: invalid
read/write" messages, visible with -d guest_errors,unimp.
scripts/checkpatch.pl reports 0 errors and 0 warnings.

The test is a small bare-metal program and is not included in
this submission; if a regression test is wanted, I can prepare
one under tests/tcg/riscv64/ in a follow-up version.

Could you please take a look at this patch when you have a
chance? I would appreciate any feedback or suggestions.

Thank you for your time and consideration.

Best regards,
Mingjie Zhu

 accel/tcg/cputlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d79eae58df..6a174d12a6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1896,6 +1896,10 @@ static uint64_t int_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                 int mmu_idx, MMUAccessType type, uintptr_t ra,
                                 MemoryRegion *mr, hwaddr mr_offset)
 {
+    if (!mr->ops->valid.unaligned && (mr_offset & (size - 1))) {
+        cpu_unaligned_access(cpu, addr, MMU_DATA_LOAD, mmu_idx, ra);
+    }
+
     do {
         MemOp this_mop;
         unsigned this_size;
@@ -2410,6 +2414,10 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
                                 int mmu_idx, uintptr_t ra,
                                 MemoryRegion *mr, hwaddr mr_offset)
 {
+    if (!mr->ops->valid.unaligned && (mr_offset & (size - 1))) {
+        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE, mmu_idx, ra);
+    }
+
     do {
         MemOp this_mop;
         unsigned this_size;
-- 
2.34.1

