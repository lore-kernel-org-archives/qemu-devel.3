Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47409C982DF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7XK4-0000OT-FT; Fri, 18 Sep 2026 08:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqL-0006tq-9W; Fri, 18 Sep 2026 05:25:17 -0400
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqE-0002I7-Ij; Fri, 18 Sep 2026 05:25:15 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=RZPggeewNGadYGNHBWcQvQw/jek6pKr9cwphr//zn0Y=;
 b=L6ClZnfZo8rxwHi4ENO95rMEqI7GAzRPHLMOv/6hO7zgp2mCUbqOUJY9BVU6Bw2yDfpEzH4Qc
 2yXRhkLg0de637Ap/TOtfqpC2VWtoXaZscxGo2/+WbTlWZF2nC9VdvbzVEhOvFwy2qpf4O5v9Dq
 D00xOokS1BPVVWc75Epyx6E=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hmRkr2qCYzLlSh;
 Fri, 18 Sep 2026 17:13:56 +0800 (CST)
Received: from dggpemr200003.china.huawei.com (unknown [7.185.36.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 4FC974058E;
 Fri, 18 Sep 2026 17:24:56 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemr200003.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 17:24:55 +0800
From: Yize Wang <wangyize7@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <zhengchuan@huawei.com>,
 <jiangjiacheng@huawei.com>, <wangyize7@huawei.com>, <yize_w1110@163.com>
Subject: [PATCH 0/4] Batch register access for live migration optimization
Date: Fri, 18 Sep 2026 17:18:52 +0800
Message-ID: <20260918092120.370805-1-wangyize7@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr200003.china.huawei.com (7.185.36.25)
Received-SPF: pass client-ip=113.46.200.222; envelope-from=wangyize7@huawei.com;
 helo=canpmsgout07.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2026 08:02:27 -0400
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

This series adds batch register access support to QEMU's KVM GICv3
register synchronization path, reducing syscall overhead during
ARM64 live migration.

Currently, QEMU issues one ioctl per register when saving/restoring VGIC
state. On large VM configurations this means tens of thousands of syscalls,
where lock acquisition and context switch overhead dominates migration
downtime. Thus, we provide a batch register method to allow userspace
read/write multiple distributor and redistributor registers in a single call.
In this way, we can significantly reduce syscalls and migration downtime.

All batch paths probe kernel capability at runtime and fall back to the
original one-by-one path when the kernel does not support batch access,
ensuring backward compatibility.

This series depends on the corresponding kernel patches that add
KVM_DEV_ARM_VGIC_GRP_BATCH_REGS support.

Test the VM migration time under pressure conditions.
The VM specifications for migration are as follows:
- VM use 4-K page;
- the number of VCPU is 160;
- the total memory is 320Gigabit;
- use 'Redis SET-benchmark' to pressurize VM;

Performance results (3-run average, ms):

    | Metric              | Without patch | With patch | Improvement |
    |---------------------|---------------|------------|-------------|
    | Migration downtime  |        536    |     321    |     40%     |
    | Source (total)      |        344    |     230    |     33%     |
    |   - VGIC put        |        158    |      40    |     75%     |
    |   - VGIC get        |        120    |      19    |     84%     |
    | Destination (total) |        192    |      91    |     53%     |
    |   - VGIC put        |        132    |      27    |     80%     |

Yize Wang (4):
  Sync KVM ARM VGIC batch register UAPI to QEMU headers
  hw/intc/arm_gicv3_kvm: Add batch helper structures and functions
  hw/intc/arm_gicv3_kvm: Refactor kvm_arm_gicv3_put for batch register access
  hw/intc/arm_gicv3_kvm: Refactor kvm_arm_gicv3_get for batch register access

 hw/intc/arm_gicv3_kvm.c       | 1087 ++++++++++++++++++++++++++++++++++-------
 linux-headers/asm-arm64/kvm.h |    9 +
 2 files changed, 925 insertions(+), 171 deletions(-)

References:
[1] [PATCH 0/2] Batch register access for live migration optimization
    https://lore.kernel.org/kvmarm/20260918081930.4014735-1-wangyize7@huawei.com/T/#t


