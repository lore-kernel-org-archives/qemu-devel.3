Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BFACAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuMn-0000K7-Md; Tue, 09 Sep 2025 05:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1uvuMf-0000I4-6L; Tue, 09 Sep 2025 05:10:14 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1uvuMb-0006ZG-If; Tue, 09 Sep 2025 05:10:12 -0400
Received: from ur-dp1000.. (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDnYNAE779o6nwsAA--.43713S2; 
 Tue, 09 Sep 2025 17:10:38 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 anup@brainfault.org, alistair.francis@wdc.com, rkrcmar@ventanamicro.com,
 palmer@dabbelt.com, xiamy@ultrarisc.com, Xie Bo <xb@ultrarisc.com>
Subject: [PATCH v5 for v10.0.0 0/2] target/riscv：Fix riscv64 kvm migration
Date: Tue,  9 Sep 2025 17:09:15 +0800
Message-ID: <20250909090917.21301-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818-e7e56e26bbf62a23417c2567@orel>
References: <20250818-e7e56e26bbf62a23417c2567@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDnYNAE779o6nwsAA--.43713S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4rCFyUGF4Dtr48CF4DArb_yoWDKFX_CF
 W0gFy8G3yjga1DtFW2qw45J3srKayrJw1jka18JrsYk347WrWfJwsYkF1Sv34UZr4xJFnY
 yr13JFWfCw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
 Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
 1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
 IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
 6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
 AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
 s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
 0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2i0+W4AYAAisD
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series(v5) replaces the earlier single patch "[PATCH v4 for v10.0.0] target/riscv/kvm/kvm-cpu: Fixed the issue of resume after QEMU+KVM migration".

Changes since v4:
- Split the patch into 2 patches
- Fix formatting issues
- Vmstate version bump

 Patch 1 sets the initial value of the vCPU to S-mode in KVM mode and add mp_state.
 Patch 2 adds saving and restoring of the vCPU's privilege mode and running states, fixing the migration functionality in KVM mode.
 The functionality of Patch 2 depends on Patch 1 to take effect.

 Based on these two patches, we have successfully performed live migration of virtual machines between two physical machines.

Xie Bo (2):
  target/riscv：Set KVM initial privilege mode and mp_state
  target/riscv/kvm：Fixed the issue of resume after QEMU+KVM migration

 target/riscv/cpu.c           | 11 ++++++-
 target/riscv/cpu.h           |  2 ++
 target/riscv/kvm/kvm-cpu.c   | 59 ++++++++++++++++++++++++++++--------
 target/riscv/kvm/kvm_riscv.h |  3 +-
 target/riscv/machine.c       |  5 +--
 5 files changed, 63 insertions(+), 17 deletions(-)

-- 
2.43.0


