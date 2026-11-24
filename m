Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D3606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rispop.dev header.i=@rispop.dev header.a=rsa-sha256 header.s=protonmail header.b=XLVX5ad8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVknv-0000y2-6g; Tue, 24 Nov 2026 02:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xVkns-0000xF-QT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:19:00 -0500
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xVknq-0006Om-K2
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rispop.dev;
 s=protonmail; t=1795504726; x=1795763926;
 bh=mIhdL/ypndLUnsAlz5F8RrEfAfgnla7lyaO8fWcUYPQ=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=XLVX5ad8c/XTrgG6uNcQCnFbQrdTdpZxP/zM3gR9Mz0Hje1wWHUXpZ+w5K3oOTUlL
 uRmhy1lNmtb6MVohXOf1so6gdBHSV/xruyQm96dMfkEj1Cqlda/XiS5p7741Ra6Ir7
 jCD0WsV8tK6KLpJAYhJI2w6yDiNdbtp5sDcBR1kSY5nfPQFFXv/GAhR81BURuZOhGj
 R7qL0mWMxpSdAuvQv8Zxmsw202nqZRcPb6JpaM6ZxWZaUvrk86CqOmUO5upZc7TUNO
 iaI2iqenW0U/4HM0j6DP3dQsB+i826U0C1JZnAKBfEgipaLFiMhyHNMLqpZzRgGN0T
 2AA5q1uYYYnyg==
X-Pm-Submission-Id: 4jYZ0w5hH8z2ScdK
From: Rishab Pradeep <rishab@rispop.dev>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, tarun.patanjali@utexas.edu,
 christopher.elwood2024@gmail.com, Rishab Pradeep <rishab@rispop.dev>
Subject: [RFC PATCH 0/2] target/riscv: Check store permission before split
 AMOs with Zicfiss
Date: Tue, 24 Nov 2026 01:18:34 -0600
Message-ID: <20261124071836.208740-1-rishab@rispop.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.210.45; envelope-from=rishab@rispop.dev;
 helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With Zicfiss, an ordinary AMO to a shadow-stack page must fault with a
store/AMO access fault (cause 7).  When TCG lowers the AMO to a load
followed by a store (!CF_PARALLEL), the load runs first.  That gives
the wrong cause (15) when the PTE's A bit is clear under Svade, and it
lets the load's side effects (e.g. a read watchpoint) happen when an
earlier load has left a read-permitting TLB entry for the page.

Patch 1 adds probe_access_perm(), a permission-only lookup that takes
the real access size and skips watchpoints, dirty marking and the
plugin slow path.  Patch 2 uses it from the RISC-V AMO/AMOCAS
translation, only for TBs with shadow stacks enabled and !CF_PARALLEL
(the parallel helpers already look up the store first).

Tested on RV64 system emulation (debug, ASan, UBSan build):
 - cold-TLB AMO with A=D=0 on a shadow-stack page gives cause 7
   (cause 15 on baseline), single-thread TCG
 - read watchpoint after a warming load does not stop with the
   series, and stops on baseline, single-thread TCG
 - page-crossing Zama16b, page-crossing PMP and PMP-boundary AMOs,
   single-thread TCG and MTTCG
 - unit and qtest pass
 - check-tcg: rv128-sstatus (UBSan, pmp.c) fails and the
   interruptedmemory plugin test times out, both identically on master
 - check-functional (sanitized build): 4 timeouts, and three pass with
   a longer limit.  sifive_u passes in about 5s on baseline and
   patched builds without sanitizers.  I did not run check-functional
   on a sanitized master build.

Not tested: RV32 at runtime (including the amocas.d path in
gen_cmpxchg64), and the cold-TLB A=D=0 case and the read watchpoint
under MTTCG.  riscv32-softmmu and the linux-user targets compile.

Open questions:
 - Is a permission-only helper in accel/tcg acceptable?  The
   alternative is a RISC-V-local helper built on probe_access_flags(),
   at the cost of early dirty marking.
 - The probe is a store lookup, so with hardware A/D updates it may set
   D before the AMO's load phase runs.  If that load then faults, D is
   set on a page the AMO never accessed.  I have not tested this.
 - The second-page probe for page-crossing Zama16b accesses mirrors
   what the real operation does today.  A page-crossing access
   arguably should fault, since a granule cannot cross a page.
   Enforcing that would be a separate change.

Rishab Pradeep (2):
  accel/tcg: Add probe_access_perm()
  target/riscv: Check store permission before split AMOs with Zicfiss

 accel/tcg/cputlb.c                            | 11 ++++++
 include/accel/tcg/probe.h                     | 20 ++++++++++
 target/riscv/helper.h                         |  5 +++
 .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  |  2 +
 target/riscv/tcg/op_helper.c                  | 37 +++++++++++++++++++
 target/riscv/tcg/translate.c                  | 23 ++++++++++++
 6 files changed, 98 insertions(+)

-- 
2.56.0


