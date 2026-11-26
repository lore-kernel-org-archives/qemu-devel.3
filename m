Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633D606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GNFFwwLL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUJH-0006Zp-6B; Thu, 26 Nov 2026 02:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJE-0006Wb-Oc; Thu, 26 Nov 2026 02:54:24 -0500
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJ7-0002VS-Po; Thu, 26 Nov 2026 02:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795679639; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=rpmo3rkU325XHEZ+cz3FYwM/yHFK3SRfWvCwqHYSG/U=;
 b=GNFFwwLLJyyNXHbEmsmKuiQvCV2JoChccFh9v5IvaBMhbwFKLoZSafLIv8xDeiXPBUMNHZTUQWaCynn7mms3PmT/xLEIbsarhVmBlYvlAvaIMAIBqSGiDQ2d2Dtj/YFOQEFzCXDjpr176PJBEi/YR1js3HRVBfeuhqsvB4O6muo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R821e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XFTpGYF_1795679637; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XFTpGYF_1795679637 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:53:58 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 0/6] target/riscv: Fix wrong behavior when G-Stage PMP/PMA
 fails
Date: Thu, 26 Nov 2026 15:53:44 +0800
Message-Id: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When I am working on SMMPT v0.9.0 support, I found some wrong behaviors
when G-Stage translation PMP/PMA fails.

This six-patch series examines physical access-fault propagation during
RISC-V two-stage address translation. It contains three fixes, each
followed by a regression test.

The fixes address three paths:

1. VS PTE reads

   The VS walker invokes G-stage translation before reading a VS PTE.
   PMP and PMA failures from that recursive translation are currently
   converted into G-stage translation failures. Preserve these physical
   access errors so the original guest load, store or instruction fetch
   receives the corresponding access fault.

2. VS PTE A/D updates

   Writing updated A/D bits to a VS PTE requires another G-stage
   translation with store access. This translation can itself require
   updating a G-stage PTE's D bit. Preserve physical access failures
   from this path, while selecting the final exception cause according
   to the original guest operation.

3. Direct G-stage fault metadata

   A PMA failure during direct G-stage translation already produces an
   access fault, but can also populate the guest fault address.
   Exclude both PMP and PMA failures from that address assignment,
   leaving the field zero for trap delivery.

The regression runs on the virt machine with the H extension. It checks
PMP and PMA failures during nested PTE reads, a PMP-denied G-stage D-bit
update during VS A/D handling, and a direct G-stage PMA failure with
VS-stage translation set to Bare. The checks cover exception causes,
the original virtual address in mtval, and zero mtval2 for access faults.
Controls for genuine G-stage mapping failures remain in place, along
with a final successful load after restoring the translation state.

The A/D-update case injects a PMP failure. The direct G-stage case
checks a load and observes mtval2 through the M-mode trap handler;
delegated HS-mode traps and htval are outside this test's coverage.

LIU Zhiwei (6):
  target/riscv: Preserve access faults while translating VS PTE reads
  tests/tcg/riscv64: Add nested-PTE-read access-fault regression
  target/riscv: Preserve access faults during VS PTE A/D translation
  tests/tcg/riscv64: Check access faults during VS A/D updates
  target/riscv: Keep the guest fault address zero for G-stage PMA errors
  tests/tcg/riscv64: Check PMA fault metadata with VS-stage Bare

 target/riscv/tcg/cpu_helper.c                |  15 +-
 tests/tcg/riscv64/system/meson.build         |   7 +
 tests/tcg/riscv64/test-gstage-access-fault.S | 247 +++++++++++++++++++
 3 files changed, 267 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-gstage-access-fault.S


base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
-- 
2.43.0


