Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A2CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbmz-0001st-SX; Mon, 08 Jun 2026 11:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1wWbmy-0001s8-D8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:20 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1wWbmv-0007rd-UC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:20 -0400
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de
 [79.254.29.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 8F74120243E;
 Mon,  8 Jun 2026 17:21:14 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org, marcel.apfelbaum@gmail.com, zhao1.liu@intel.com,
 berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 mtosatti@redhat.com, Tom Lendacky <thomas.lendacky@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, coconut-svsm@lists.linux.dev,
 joerg.roedel@amd.com
Subject: [RFC PATCH 00/10] QEMU Support for KVM Planes
Date: Mon,  8 Jun 2026 17:20:59 +0200
Message-ID: <20260608152109.356783-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joerg Roedel <joerg.roedel@amd.com>

Hi,

here are the required QEMU changes to make use of the KVM Planes
interface posted here[1].

The patches are based on QEMU v11.0.0 and can be used to launch an AMD
SEV-SNP VM with COCONUT-SVSM + a Linux guest.

To make this work a change to the QEMU command line is required to
tell QEMU which plane to target external IRQs to. this is done with
the new device-plane property to the machine specification, e.g:

$ qemu-system-x86_64 \
  -enable-kvm \
  -cpu EPYC-v4 \
  -machine q35,confidential-guest-support=sev0,memory-backend=ram1,igvm-cfg=igvm0,kernel-irqchip=split,device-plane=2 \
  -object memory-backend-memfd,id=ram1,size=32G,share=true \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
  -object igvm-cfg,id=igvm0,file=$IGVM_FILE \
  ...

Any feedback appreciated.

-Joerg

[1] https://lore.kernel.org/kvm/20260608144252.351443-1-joro@8bytes.org/T/#t

Joerg Roedel (10):
  Update Linux Header for KVM Planes Support
  accel/kvm: Extend KVMState to carry fds for planes
  accel/kvm: Extend CPUState to handle Planes
  accel: Add nr_planes() op
  accel/kvm: Support nr_planes call-back
  accel/kvm: Handle KVM_PLANE_EVENT_CREATE_CPU event
  hw/core/machine: Add device-plane property
  qdev: Add plane property
  MSI: Inject into correct plane
  KVM: Set GSI routes for default plane

 accel/accel-system.c                          |  13 +
 accel/kvm/kvm-all.c                           | 247 ++++++++--
 accel/kvm/trace-events                        |   2 +
 dtc                                           |   1 +
 hw/core/machine.c                             |  22 +
 hw/core/qdev.c                                |  26 +
 hw/i386/kvm/apic.c                            |   6 +-
 hw/pci/msi.c                                  |   3 +
 hw/pci/msix.c                                 |   3 +
 include/accel/accel-ops.h                     |   3 +
 include/hw/core/boards.h                      |   3 +
 include/hw/core/cpu.h                         |  17 +-
 include/hw/core/qdev.h                        |   5 +
 include/hw/pci/msi.h                          |   1 +
 include/qemu/accel.h                          |   7 +
 include/standard-headers/drm/drm_fourcc.h     |  28 +-
 include/standard-headers/linux/const.h        |  18 +
 include/standard-headers/linux/ethtool.h      |  28 +-
 .../linux/input-event-codes.h                 |  13 +
 include/standard-headers/linux/pci_regs.h     |  71 ++-
 include/standard-headers/linux/typelimits.h   |   8 +
 include/standard-headers/linux/virtio_ring.h  |   3 +-
 include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
 include/standard-headers/linux/vmclock-abi.h  |  20 +
 include/system/kvm.h                          |   7 +
 include/system/kvm_int.h                      |  30 +-
 linux-headers/asm-arm64/kvm.h                 |   1 +
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   5 +-
 linux-headers/asm-loongarch/kvm.h             |   5 +
 linux-headers/asm-loongarch/kvm_para.h        |   1 +
 linux-headers/asm-loongarch/unistd_64.h       |   2 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |  11 +-
 linux-headers/asm-riscv/ptrace.h              |  37 ++
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |  21 +-
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/const.h                   |  18 +
 linux-headers/linux/iommufd.h                 |  48 ++
 linux-headers/linux/kvm.h                     |  64 ++-
 linux-headers/linux/mshv.h                    |   4 +-
 linux-headers/linux/psp-sev.h                 |   2 +-
 linux-headers/linux/stddef.h                  |   4 +
 linux-headers/linux/vduse.h                   |  85 +++-
 linux-headers/linux/vfio.h                    |  30 +-
 target/arm/kvm.c                              |   2 +-
 target/i386/kvm/kvm.c                         |  57 +++
 tests/unit/test-qdev-global-props.c           |   5 +
 tests/unit/test-qdev.c                        |   5 +
 ui/keycodemapdb                               |   1 +
 60 files changed, 1150 insertions(+), 538 deletions(-)
 create mode 160000 dtc
 create mode 100644 include/standard-headers/linux/typelimits.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 delete mode 100644 linux-headers/asm-s390/unistd_32.h
 create mode 160000 ui/keycodemapdb

-- 
2.53.0


