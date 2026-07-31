Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04A1C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFb-0002fc-3k; Fri, 31 Jul 2026 01:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM5-0005qq-69; Thu, 30 Jul 2026 23:56:17 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002Hb-Cx; Thu, 30 Jul 2026 23:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470153; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=iCbluQ1czlbmeT5UGG/tEPF6mhjIdObmQgw83HWv/Ps=;
 b=qlEGEXxaCVOqvqDho3xIWBUxsAcJLfkVY+yCiXZDlP6HLnhaq7tpFO8UjWSfPe5+Vt6HliRFJ1MMaWGvObF7C531X1ubg71BoCoUkP/baKnKMwLxZQJBceSjZVSEnV+O2zecuG8cm1BbBEFTHqSnDf8HdAS2Jl6n6oeTu1Hnm+Y=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwN0_1785469832; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwN0_1785469832 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:33 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 00/17] target/riscv: Add KVM CoVE confidential VM
 support
Date: Fri, 31 Jul 2026 11:49:54 +0800
Message-Id: <20260731035011.4178103-1-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=blduan@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:32 -0400
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

This series adds RISC-V CoVE (Confidential VM Extension) support to the
virt machine when running with KVM acceleration.

CoVE is the RISC-V equivalent of AMD SEV / Intel TDX, defined by the
RISC-V AP-TEE specification [1].  A CoVE guest is a TEE VM (TVM) whose
memory and vCPU state are owned by the TEE Security Manager (TSM),
making them inaccessible to the host.

The series adds a "cove-vm" machine property to the virt board and adapts
the boot flow, interrupt routing, memory registration and device model to
the constraints of a confidential guest:

  - kernel, initrd and device tree are measured before the guest starts
  - interrupts are MSI-only (IMSIC mandatory, APLIC emulated by QEMU)
  - virtio uses modern PCI transport with VIRTIO_F_ACCESS_PLATFORM
  - vhost is disabled (host kernel has no access to guest memory)
  - vCPU threads are pinned (TSM binds vCPUs to harts)

The KVM interface used here (KVM_VM_TYPE_RISCV_COVE and
KVM_RISCV_COVE_MEASURE_REGION) is not yet part of an upstream Linux
release.  The definitions are kept locally and will be replaced by a
linux-headers update once the kernel side has been merged.

Patches 15 and 17 contain known workarounds and explicitly ask for design
guidance:

  - Patch 15 pins vCPU threads and adds a yield after KVM_RUN to avoid
    host RCU stalls.  Thread placement should be left to the user or
    management layer.

  - Patch 17 converts system_reset into a shutdown because a TVM cannot be
    recreated.  The proper approach may be to implement
    ConfidentialGuestSupport and use the existing can_rebuild_state()
    machinery.

Tested with QEMU TCG emulating a CoVE-capable Xuantie C930 platform.

[1] https://github.com/riscv-non-isa/riscv-ap-tee

Baolong Duan (17):
  docs/system/riscv/virt: document the cove-vm machine option
  hw/riscv/virt: add the cove-vm machine property
  target/riscv/kvm: create and measure a CoVE TEE VM
  accel/kvm: add kvm_gpa_to_userspace_addr()
  hw/riscv/boot: load and measure the images of a CoVE guest
  hw/riscv/virt: measure the device tree of a CoVE guest
  hw/riscv: adapt the device tree of a CoVE guest
  hw/riscv/virt: use MSIs only for a CoVE guest
  hw/intc/riscv_aplic: emulate the APLIC for a CoVE guest
  target/riscv/kvm: skip unsupported KVM requests for a CoVE guest
  hw/virtio: force modern virtio for a CoVE guest
  hw/net/virtio-net: do not use vhost for a CoVE guest
  accel/kvm: only register the DRAM slot of a CoVE guest
  accel/kvm: skip MSI route updates for a CoVE guest
  accel/kvm: pin the vCPU threads of a CoVE guest
  accel/kvm: terminate on a system event of a CoVE guest
  hw/core/machine-qmp-cmds: shut down a CoVE guest on reset

 MAINTAINERS                  |   6 ++
 accel/kvm/kvm-accel-ops.c    |  16 +++++
 accel/kvm/kvm-all.c          |  60 +++++++++++++++++
 docs/system/riscv/virt.rst   |  39 +++++++++++
 hw/core/machine-qmp-cmds.c   |  10 +++
 hw/core/machine.c            |  18 +++++
 hw/intc/riscv_aplic.c        |   9 +++
 hw/net/virtio-net.c          |   9 +++
 hw/riscv/boot.c              |  91 +++++++++++++++++++++++++
 hw/riscv/fdt-common.c        |   4 +-
 hw/riscv/trace-events        |   4 ++
 hw/riscv/virt.c              | 125 +++++++++++++++++++++++++++++------
 hw/virtio/virtio-bus.c       |  12 ++++
 hw/virtio/virtio-pci.c       |   9 ++-
 include/hw/riscv/cove.h      |  24 +++++++
 include/hw/riscv/virt.h      |   1 +
 include/system/kvm.h         |  18 +++++
 target/riscv/kvm/kvm-cpu.c   |  67 ++++++++++++++++++-
 target/riscv/kvm/kvm_riscv.h |  10 +++
 19 files changed, 508 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/riscv/cove.h

-- 
2.34.1

