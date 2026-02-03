Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACA5E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAS1-00023e-Ll; Tue, 03 Feb 2026 02:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARv-00020S-6C; Tue, 03 Feb 2026 02:03:47 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARt-0003Dl-6a; Tue, 03 Feb 2026 02:03:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C846660138;
 Tue,  3 Feb 2026 07:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECED3C116D0;
 Tue,  3 Feb 2026 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102215;
 bh=vmBN+yUQkLB6QkQP0CNuVrYUKpcSilmO4j8ztdPGuQk=;
 h=From:Subject:Date:To:Cc:From;
 b=UdQO2CgPfbbhkYBqECYFCjBjoR9QDGY+qJq6SDMvCN2qqy54nDd0+VVpQMSk7Zdim
 zQO2Sa7FsIkUaAuCIyYbtS9YQg3IVHv53lHp4UOXb0keKuULzuZeq66c7NRT/Wn3Pn
 c9AZlqECuKhKQjz6jw/zU80IYsWVcXJ+/yxF+XXNpPSA6k4t6FlcRKtPpXaz3nIx+o
 4POJfFpAJcZ7XS5GAqkfcd05qevQAiXVf3pSKshKVJfPBbGmgxDhJidBI2+tf1LrcZ
 2hzLd5vrvOCjg1CkY3n9Ugu1cx4vRkhjvqFpf4fxsHeNiGKhTsnWvTp3izoNKzZ95A
 4S1IuGZsDkFig==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH RFC 0/7] RISC-V: Add support for ACPI RQSC table
Date: Mon, 02 Feb 2026 23:01:16 -0800
Message-Id: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADydgWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwND3aLM4uQy3aLC4mTdxFQLA7PUVINE88REJaCGgqLUtMwKsGHRSkF
 uzkqxtbUALx+6E2EAAAA=
X-Change-ID: 20260201-riscv-rqsc-ae806ee0a7aa
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Sunil V L <sunilvl@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5339; i=fustini@kernel.org;
 h=from:subject:message-id; bh=vmBN+yUQkLB6QkQP0CNuVrYUKpcSilmO4j8ztdPGuQk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zt0tdcHcdsXsMJ3AA0FiwRknmySmHnrlc+Hv2zjfe
 /fapqsu6ChlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMhDeA4X9IsWL3lmx/T791
 C1ZuOX3I8v+BKKH5c3ZaHwuZbnXijfVPRobtmiUqR/+WrOmbF+JhveL3sq5SK+YLP0PM3b59LfG
 1+cQNAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for the ACPI RISC-V Quality of Service Controller (RQSC)
table [1] which describes the CBQRI controllers present in a system.
This series is based on the v5 series that implements Ssqosid extension
and CBQRI controllers [2]. The patches are also available as the
b4/riscv-rqsc branch [3].

This series is marked as an RFC due to open issues:

 - The "Add cache structure table creation for PPTT table" series [4] by
   Sia Jee Heng is used to generate to the PPTT table with a cache type
   1 structure for a 3-layer cache topology. This series doesn't seem to
   have made progress on landing upstream.

 - cluster_id is not set by the riscv arch, so cores 0-3 are hard-coded
   to be cluster 0 and cores 4-8 are cluster 1. The proper solution is
   for the riscv code to set cluster_id the same way as the arm code.

 - cluster 0 uses the first L2 cache controller and cluster 1 uses the
   second L2 cache controller. A more general solution is to make the L2
   cache private to the cluster and not private to the core.

 - struct CPUCaches is modified to add CPUCacheInfo *l2_cluster1_cache
   and CPUCacheInfo *l2_cluster2_cache. This is a hack to support the
   example configuration used for CBQRI. A solution could make use of
   the flexible approach in the "Specifying cache topology on ARM" patch
   series by Alireza Sanaee [5].

 - Need a solution to correlate bandwidth controllers to the Proximity
   Domain for Memory Affinity Structures in the SRAT table.

There is a Linux kernel patch series [6] and branch [7] that implement
Ssqosid and CBQRI support in resctrl as well as parsing the RQSC to
discover the CBQRI controllers in the system.

This Qemu series was developed and tested with the following
configuration:

  Base addr  Size
  0x4820000  4KB  Cluster 0 L2 cache controller
  0x4821000  4KB  Cluster 1 L2 cache controller
  0x4828000  4KB  Memory controller 0
  0x4829000  4KB  Memory controller 1
  0X482a000  4KB  Memory controller 2
  0X482b000  4KB  Shared LLC cache controller

The example platform is created with the following:

  qemu-system-riscv64 \
	-M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic  \
	-smp cpus=8,sockets=1,clusters=2,cores=4,threads=1 \
	-m 1G \
	-nographic \
	-kernel ${LINUX}/arch/riscv/boot/Image \
	-append "root=/dev/vda rootwait" \
	-blockdev node-name=pflash0,driver=file,read-only=on,filename=${EDK}/RISCV_VIRT_CODE.fd \
	-blockdev node-name=pflash1,driver=file,filename=${EDK}/RISCV_VIRT_VARS.fd \
	-drive if=none,file=${ROOTFS}/rootfs.ext2,format=raw,id=hd0 \
	-device virtio-blk-device,drive=hd0 \
	-device qemu-xhci \
	-device usb-kbd \
	-device virtio-net-pci,netdev=net0 \
	-netdev user,id=net0 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04820000 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04821000 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=16,mmio_base=0x0482B000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04828000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04829000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x0482a000

[1] https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
[2] https://lore.kernel.org/all/20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org/
[3] https://github.com/tt-fustini/qemu/tree/b4/riscv-rqsc
[4] https://lore.kernel.org/all/20240129104039.117671-1-jeeheng.sia@starfivetech.com/
[5] https://lore.kernel.org/all/20250310162337.844-1-alireza.sanaee@huawei.com/
[6] https://lore.kernel.org/all/20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org/
[7] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/ssqosid-cbqri

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
Drew Fustini (4):
      hw/riscv: virt-acpi-build: Adjust RQSC cache properties
      include: acpi: aml-build: Add Cache ID and L2 cache for each cluster
      acpi: aml-build: Add Cache ID to PPTT table and set Cluster ID
      hw/riscv: virt-acpi-build: Build PPTT table before RQSC table

Sia Jee Heng (2):
      acpi: aml-build: Add cache structure table creation for PPTT table
      hw/riscv: virt-acpi-build: Generate PPTT table

Vasudevan Srinivasan (1):
      hw/riscv: Add support for ACPI RQSC table

 hw/acpi/aml-build.c         | 108 ++++++++++++++++++++++++--
 hw/core/sysbus-fdt.c        |   3 +
 hw/riscv/cbqri_bandwidth.c  |  11 +++
 hw/riscv/cbqri_capacity.c   |  11 +++
 hw/riscv/virt-acpi-build.c  | 181 ++++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c             |   1 +
 include/hw/acpi/aml-build.h |  23 +++++-
 include/hw/riscv/cbqri.h    |  12 +++
 8 files changed, 343 insertions(+), 7 deletions(-)
---
base-commit: 117b7aeabad83d437dfa69f2ee2bac75c0e02abe
change-id: 20260201-riscv-rqsc-ae806ee0a7aa

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


