Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACC606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ06-00076e-FA; Thu, 29 Oct 2026 01:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzk-00072Y-Fh; Thu, 29 Oct 2026 01:48:12 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzg-0000dJ-Ib; Thu, 29 Oct 2026 01:48:12 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYDH2qVnz5PkGr;
 Thu, 29 Oct 2026 13:47:59 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 69T5lpAO079232;
 Thu, 29 Oct 2026 13:47:51 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 29 Oct 2026 13:47:52 +0800
X-Zmail-TransId: 3e816ae2de02027-e62ff
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
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 00/14] hw/riscv: Add accelerated (nested) translation
 support to the RISC-V IOMMU
Date: Thu, 29 Oct 2026 13:47:37 +0800
Message-ID: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69T5lpAO079232
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 13:47:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2DE0F.000/4jFYDH2qVnz5PkGr
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU's RISC-V IOMMU model currently has no way to offload guest
stage 1 translation to a physical IOMMU. For guests with assigned PCI
devices, QEMU must handle the virtual IOMMU configuration itself
instead of allowing hardware to walk the guest's device contexts and
page tables. This leaves the nested translation support of RISC-V
hardware unused.

Add an "accel" mode to the RISC-V IOMMU that connects the virtual
IOMMU to the physical IOMMU through iommufd. The guest continues to
manage its own device contexts and stage 1 page tables, while the host
retains control of stage 2 translation. QEMU supplies the device
contexts and forwards cache invalidations through iommufd. The physical
IOMMU can then perform both stages of DMA translation for assigned
devices.

This allows the guest to keep managing its own DMA mappings while
hardware performs nested translation for assigned devices. The design
follows the existing ARM SMMUv3 accelerated vIOMMU support. We are
posting it as an RFC to collect feedback on the design and its kernel
uAPI dependency.

Patch organization

Patch 1 temporarily imports the RISC-V IOMMU iommufd definitions
needed by this series. A regular header update can replace this import
after the kernel uAPI is merged.

Patches 2 to 5 prepare the virt machine and the existing RISC-V IOMMU
code for an alternate accelerated implementation.

Patches 6 to 13 add that implementation. They create the iommufd
objects, manage host page table attachments, handle device context
updates and invalidations, and validate host capabilities. Patch 14
exposes the accel property and blocks migration when it is enabled.

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
probes the vIOMMU, builds its stage 1 tables and programs device
contexts. I/O on the passed through NVMe goes through the combined
stage 1 and stage 2 walk on the physical IOMMU, and device MSIs reach
the vCPU without host software in the data path. Correctness was
checked by running fio against the passed through disk with
verification enabled, including under load.

Known limitations

With accel=on, the guest controls stage 1 translation while the host
owns stage 2. Only vfio-pci endpoints using the iommufd backend are
supported, and emulated endpoints are rejected because supporting them
would mean owning IOTLB invalidation in QEMU again. MSI remapping stays
with the host IOMMU, so the guest sees the base device context format.
There is no ATS or PRI support and no process_id or PDT support.
Migration is blocked while accel=on because the host vIOMMU and HWPT
state cannot be migrated. One accelerated IOMMU instance per VM is
assumed for now.

The series is also available from:
https://github.com/leaprise/qemu/tree/riscv/iommu-nested-rfc-v2


Changes in v2:
There are no functional changes in this version.

- Rebased the series on master at 73294d096cc
- Imported the RISC-V IOMMU uAPI definitions revised during review
  and adapted QEMU accordingly.
- Link to v1:
  https://lore.kernel.org/qemu-devel/202610140811.69E8BqaU098670@mse-fl2.zte.com.cn/


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
 hw/riscv/riscv-iommu-accel.c  | 715 ++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-accel.h  |  81 ++++
 hw/riscv/riscv-iommu.c        | 209 +++++++---
 hw/riscv/riscv-iommu.h        |  36 ++
 hw/riscv/trace-events         |   6 +
 linux-headers/linux/iommufd.h |  81 ++++
 8 files changed, 1078 insertions(+), 57 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-accel.c
 create mode 100644 hw/riscv/riscv-iommu-accel.h

-- 
2.53.0


