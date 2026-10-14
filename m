Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10D4CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyWO-00072g-7p; Wed, 14 Oct 2026 08:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu5L-0006Ca-Pj; Wed, 14 Oct 2026 04:11:40 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu5I-0000q8-97; Wed, 14 Oct 2026 04:11:39 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P6j71S4z8R03f;
 Wed, 14 Oct 2026 16:11:25 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8BN84098054;
 Wed, 14 Oct 2026 16:11:23 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140811.69E8BN84098054@mse-fl2.zte.com.cn>
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 69E80DJw079324;
 Wed, 14 Oct 2026 16:00:13 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:15 +0800
X-Zmail-TransId: 3e816acf3687024-0e12b
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 00/14] hw/riscv: Add accelerated (nested) translation
 support to the RISC-V IOMMU
Date: Wed, 14 Oct 2026 15:59:51 +0800
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8BN84098054
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:11:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF392D.000/4j4P6j71S4z8R03f
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:55 -0400
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

Add an "accel" mode to the riscv-iommu device so that the physical RISC-V
IOMMU performs the guest's first-stage translation instead of QEMU
emulating it. The guest IOMMU driver keeps building its own page tables
and device contexts as it would with a physical IOMMU, the host owns the
second stage, and DMA translation runs in hardware. The ARM SMMUv3 accel
support follows the same idea, and so does this work. We are posting it
as an RFC to collect feedback on the design.

Background

The RISC-V IOMMU supports nested translation, and iommufd gained vIOMMU
and nested HWPT objects that let a VMM bind a stage-1 domain owned by
userspace to a stage-2 domain owned by the VMM and have the physical
IOMMU walk both. QEMU does not use this interface for the RISC-V IOMMU
yet, and this work adds the accelerated mode that does.

Design

The guest owns stage-1, which covers the device context and the
first-stage page tables. The host owns stage-2. QEMU mirrors only the
guest state the host hardware needs, and forwards invalidations.

Each accelerated IOMMU owns an iommufd vIOMMU, parented by the stage-2
nesting parent HWPT that the VFIO core allocates for the VM. Each
attached device gets a vDEVICE that maps the guest devid to the host
device, and always has a HWPT attached, so QEMU keeps an abort and a
bypass HWPT for devices the guest does not translate and installs a
nested stage-1 HWPT when its device context does translate. A device
context change is picked up when the guest invalidates the context, and
a missing or invalid context aborts that device's DMA.

Invalidations are forwarded to the host IOMMU, and a RISC-V invalidate
command carries no requester id, so no per device filtering is needed.
The guest capabilities are intersected with what the attached host
IOMMUs support and finalised before the guest can observe them. Every
vfio-pci endpoint behind every accelerated IOMMU is handed the same
shared system address space, so the stage-2 nesting parent is shared
within the VM instead of duplicated per IOMMU.

Patch organization

Patch 1 updates linux-headers, but it is a placeholder. It hand imports
only the RISC-V IOMMU definitions of iommufd.h instead of running
scripts/update-linux-headers.sh. It depends on the RISC-V IOMMU nested
and vIOMMU kernel UAPI, which will be posted soon.

Patches 2 to 5 are preparation, and each is a precondition for the
accel device rather than incidental cleanup. They enable IOMMUFD on the
virt machine, let a PCI IOMMU override its ops, expose RISCVIOMMUSpace
so per device accel state can be embedded in it, and split the device
context fetch out of the cache lookup so the command path can read a
freshly written device context.

Patches 6 to 13 build the accel device, adding the skeleton, the shared
system address space, the endpoint restrictions, get_viommu_flags, the
vIOMMU and proxy HWPTs in the set and unset callbacks, nested device
context install, host invalidation, and host hardware info validation.
Patch 14 adds the accel property last, so the switch only becomes
available once all the supporting pieces are in place.

Testing

The host is a RISC-V machine whose physical IOMMU is provided by an
outer QEMU riscv-iommu model, enabled with the iommu-sys machine
property. An NVMe controller under it is bound to vfio-pci and passed
through to the guest. For simplicity the guest runs the same kernel as
the host, and inside the guest it mainly uses the normal IOMMU driver
and the NVMe driver.

    -object iommufd,id=iommufd0
    -device riscv-iommu-pci,addr=1.0,s-stage=on,g-stage=off,accel=on
    -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0

Add iommu.passthrough=0 iommu.strict=1 to the guest command line so the
guest installs and uses the vIOMMU. The guest's riscv-iommu driver then
probes the vIOMMU, builds its stage-1 tables and programs device
contexts. I/O on the passed through NVMe goes through the combined
stage-1 and stage-2 walk on the physical IOMMU, and device MSIs reach
the vCPU without host software in the data path. Correctness was
checked by running fio against the passed through disk with
verification enabled, including under load.

Known limitations

accel=on supports stage-1 only, and the second stage belongs to the host.
Only vfio-pci endpoints using the iommufd backend are supported, and
emulated endpoints are rejected because supporting them would mean
owning IOTLB invalidation in QEMU again. MSI remapping stays with the
host IOMMU, so the guest sees the base device context format. There is
no ATS or PRI support and no process_id or PDT support. Migration is
blocked while accel=on because the host vIOMMU and HWPT state cannot
be migrated. One accelerated IOMMU instance per VM is assumed for now.

The series is also available from
https://github.com/leaprise/qemu/tree/riscv/iommu-nested-rfc1


Gong Shuai (5):
  linux-headers: Update iommufd.h header for RISC-V IOMMU nested
    translation
  hw/riscv/riscv-iommu: Expose RISCVIOMMUSpace and split its helpers
  hw/riscv/riscv-iommu: Split device context fetch from cache lookup
  hw/riscv/riscv-iommu-accel: Add nested vDC install/uninstall support
  hw/riscv/riscv-iommu-accel: Get host RISC-V IOMMU hw info and validate

Wu Fei (9):
  hw/riscv/Kconfig: Enable IOMMUFD on RISC-V virt machine
  hw/riscv/riscv-iommu: Allow PCI IOMMU ops to be overridden
  hw/riscv/riscv-iommu-accel: Introduce RISC-V IOMMU accel device
  hw/riscv/riscv-iommu-accel: Initialize shared system address space
  hw/riscv/riscv-iommu-accel: Restrict accelerated IOMMU to vfio-pci
    endpoints with iommufd
  hw/riscv/riscv-iommu-accel: Implement get_viommu_flags() callback
  hw/riscv/riscv-iommu-accel: Add set/unset_iommu_device callback
  hw/riscv/riscv-iommu-accel: Add support to issue invalidation cmd to
    host
  hw/riscv/riscv-iommu-accel: Add accel property for iommu device

 hw/riscv/Kconfig              |   6 +
 hw/riscv/meson.build          |   1 +
 hw/riscv/riscv-iommu-accel.c  | 713 ++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-accel.h  |  81 ++++
 hw/riscv/riscv-iommu.c        | 209 +++++++---
 hw/riscv/riscv-iommu.h        |  36 ++
 hw/riscv/trace-events         |   6 +
 linux-headers/linux/iommufd.h |  52 +++
 8 files changed, 1047 insertions(+), 57 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-accel.c
 create mode 100644 hw/riscv/riscv-iommu-accel.h

-- 
2.53.0


