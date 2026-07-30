Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE8FC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 05:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpJI4-0001SS-AN; Thu, 30 Jul 2026 01:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1wpJI1-0001RQ-WD; Thu, 30 Jul 2026 01:26:42 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1wpJHz-0000dJ-VE; Thu, 30 Jul 2026 01:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=aD/jTdD9MOdSu+muF3Xz3s07Z4no17P22D
 SZQ2ngdyQ=; b=h33NtVucEredpKHi0QsHTHJsSzjosnGxZYRmbcDFtm5H9o0mkR
 eH2dvPLPNrtCIiM3ogXIio0BChjw84eU7OCobmJki1/ZRt5wdUNFiD1WLYyKXK5z
 HXiWe9azNFHTH6TL2WHRy72Yp2d8yoxF6FhcofLS5MR5COaUinTvkfYDA=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwA3cUL63mpqEscVAA--.18165S2; 
 Thu, 30 Jul 2026 13:20:05 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, xb@ultrarisc.com
Subject: [PATCH v10 0/2] target/riscv: Fix riscv64 KVM migration
Date: Thu, 30 Jul 2026 13:19:24 +0800
Message-ID: <20260730051926.7322-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250915070811.3422578-1-xb@ultrarisc.com>
References: <20250915070811.3422578-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3cUL63mpqEscVAA--.18165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xKw4xXrW7CFy5XrWfAFb_yoW8tr4rpr
 4rW3yFgFnFqFy7Gw1fJr43GFyYvr4fKF45twsrtr10v398JrWqgrs2qFyUXFZxCFyIgr1a
 vr1qy3sxCF1DAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
 8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
 xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
 AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
 cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
 4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQATB2pkMtIAAQAZsj
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
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

This series revives v9, which was applied to riscv-to-apply.next but did
not reach QEMU master.

RISC-V KVM migration currently loses two pieces of vCPU state: the
privilege mode core register and KVM MP state. The latter leaves secondary
vCPUs in their reset STOPPED state on the destination.

Synchronize the privilege mode through the existing generic CPU VMState,
and carry MP state in a capability-gated KVM-only subsection. Keeping MP
state in a subsection avoids changing the generic RISC-V CPU VMState
version or adding KVM state to TCG migration streams.

Migration streams from older QEMU versions that lack the subsection can
still be loaded, retaining their previous destination reset behavior.
When KVM_CAP_MP_STATE is available, streams produced by this series require
a destination that recognizes the new subsection; an older destination
rejects the stream instead of silently losing MP state.

Changes from v9:
- Rebase on QEMU master at e1705a25aff3.
- Drop the reset-to-S-mode change that is already present upstream.
- Keep the generic RISC-V CPU VMState version unchanged.
- Save MP state in a KVM-only subsection and restore it only when the
  subsection was loaded.
- Reset the subsection-loaded flag in the parent VMState pre-load callback.

Testing on a native riscv64 host with Linux 6.6.20 and GCC 13.3.0:
- KVM build: riscv64-softmmu, --enable-kvm.
- Non-KVM build: riscv64-softmmu, --disable-kvm.
- Four-vCPU KVM migration on unmodified master: all vCPUs failed to run
  after migration and the guest reported RCU stalls.
- The same migration with this series: CPU0 through CPU3 all ran after
  migration.
- Four user-mode busy workers, one pinned to each vCPU, all made forward
  progress across migration to exercise privilege-mode restoration.

Xie Bo (2):
  target/riscv/kvm: Synchronize privilege mode
  target/riscv/kvm: Preserve MP state across migration

 target/riscv/cpu.h           |  4 +++
 target/riscv/kvm/kvm-cpu.c   | 62 ++++++++++++++++++++++++++----------
 target/riscv/kvm/kvm_riscv.h |  2 +-
 target/riscv/machine.c       | 45 ++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 17 deletions(-)

-- 
2.17.1


