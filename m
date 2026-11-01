Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B19606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANurzl3b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc7v-0006ve-75; Sun, 01 Nov 2026 15:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xNc7r-0006tE-SZ; Sun, 01 Nov 2026 15:25:59 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xNc7p-0008Ds-1o; Sun, 01 Nov 2026 15:25:59 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12C33435E1;
 Sun,  1 Nov 2026 20:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B086D1F000C1;
 Sun,  1 Nov 2026 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793564754;
 bh=h9fD36UEiekkID7gS2Mchc0j4sCIhYVFmahZxv1ILG0=;
 h=From:Subject:Date:To:Cc;
 b=ANurzl3b6LeMafJqCXbYO4MzF3Ht8cXgRkYTEp3QP0Gii4lXfdupubEvz/+QnWqQJ
 qfupmp2YCh9dGPH4sx6n3ly65VyhwPgPkWSIBCFx/0NL5o3QcMvfji7QASeDTFfZii
 uVUMGUfI/+2oNfch5phsj7/Mlj/sK0vqxLWZIgCmc/1vTipqkFzoafefZ18RfLu8Bv
 NLuRkH7FpzcB4qW7t17Pk7WsGqALqukYVQM5Vn1glrQHN4gFKkIM96mfTqBntwKRvH
 9hgdeDHtshzPU4crBO9JrspJxlxhCb+1TDgye0/oMxtB8RHIOCM3nSpeyOzQ1SMKIh
 5lIej4cUYOk/A==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v7 0/6] riscv: implement Ssqosid extension and CBQRI
 controllers
Date: Sun, 01 Nov 2026 12:25:32 -0800
Message-Id: <20261101-riscv-ssqosid-cbqri-v7-0-92d1aae43e48@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADyg52oC/23NwQ6CMAyA4VchOzuzdWxTT76H8TBZgUYDsplFQ
 3h3BweNkUMPf5N+HVnEQBjZoRhZwESR+i6H3RSsal3XICefm4EALQH2PFCsEo9x6CN5Xl2GQNw
 hAlipFdQ1y5f3gDU9F/V0zt1SfPThtTxJ5bydPSOk0KteKrnge+etsdJ7tLvjFUOHt20fGjaDS
 X8REHId0RkBq9CVDqQV6g8xH0TmWUdMRqRTxjqlKy/wB5mm6Q0i9TtWQQEAAA==
X-Change-ID: 20251229-riscv-ssqosid-cbqri-aee2271532ff
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14875; i=fustini@kernel.org;
 h=from:subject:message-id; bh=o4lrFOzdz2qFZZT1mngZ5QfePhLXMr/NiCjk84fVA1w=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ9X+DdsYxj1aZeTrbnpz6vzNWs4jzt8qTM013jp8/Ee
 dtrlf93d5SyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmkpbIyLC2Y1Kg9OVDEQeP
 J+xP1l+TyV9pt2nyjV07G2SemFcdfOLJyHD0683Fc/X/R/T/v7tOTVpbQzk731a3df2RK9ayX02
 sN7MAAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series implements the RISC-V Quality-of-Service Identifiers
(Ssqosid) extension [1] which adds the srmcfg register. It also
implements the RISC-V Capacity and Bandwidth QoS Register Interface
(CBQRI) specification [2]. Quality of Service (QoS) in this context is
concerned with shared resources on an SoC such as cache capacity and
memory bandwidth.

Ssqosid srmcfg CSR
------------------
The srmcfg CSR configures a hart with two identifiers:

 - Resource Control ID (RCID)
 - Monitoring Counter ID (MCID)

These identifiers accompany each request issued by the hart to shared
resource controllers. This allows the capacity and bandwidth resources
used by a software workload (e.g. a process or a set of processes) to be
controlled and monitored.

CBQRI controllers
-----------------
CBQRI defines operations to configure resource usage limits, in the form
of capacity or bandwidth, for an RCID. CBQRI also defines operations to
configure counters to track the resource utilization per MCID.

This series implements a CBQRI capacity controller and a CBQRI
bandwidth controller which can be configured from the command line:

  $ qemu-system-riscv64 -M virt ... \
      -device riscv.cbqri.capacity,mmio_base=0x04820000[,...] \
      -device riscv.cbqri.bandwidth,mmio_base=0x04829000[,...]

The mmio_base option is mandatory. The others are optional.

As many -device arguments as wanted can be provided as long as their
mmio regions don't conflict.

To see all possible options:

  $ qemu-system-riscv64 -device riscv.cbqri.capacity,help
  riscv.cbqri.capacity options:
    alloc_op_config_limit=<bool> - on/off (default: on)
    alloc_op_flush_rcid=<bool> - on/off (default: on)
    alloc_op_read_limit=<bool> - on/off (default: on)
    at_code=<bool>         - on/off (default: on)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> - on/off (default: on)
    mon_evt_id_occupancy=<bool> - on/off (default: on)
    mon_op_config_event=<bool> - on/off (default: on)
    mon_op_read_counter=<bool> - on/off (default: on)
    ncblks=<uint16>        -  (default: 16)

  $ qemu-system-riscv64 -device riscv.cbqri.bandwidth,help
  riscv.cbqri.bandwidth options:
    alloc_op_config_limit=<bool> - on/off (default: on)
    alloc_op_read_limit=<bool> - on/off (default: on)
    at_code=<bool>         - on/off (default: on)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> - on/off (default: on)
    mon_evt_id_rdonly_count=<bool> - on/off (default: on)
    mon_evt_id_rdwr_count=<bool> - on/off (default: on)
    mon_evt_id_wronly_count=<bool> - on/off (default: on)
    mon_op_config_event=<bool> - on/off (default: on)
    mon_op_read_counter=<bool> - on/off (default: on)
    mrbwb=<uint16>         -  (default: 819)
    nbwblks=<uint16>       -  (default: 1024)

Boolean options correspond to hardware capabilities that can be
disabled.

Example SoC for CBQRI
---------------------
An example SoC with the following CBQRI controller configuration can be
used to test the implementation:

  - L2 cache controllers
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 12
        - In the context of a set-associative cache, the number of
          capacity blocks can be thought of as the number of ways
    - Number of access types: 2 (code and data)
    - Usage monitoring not supported
    - Capacity allocation operations: CONFIG_LIMIT, READ_LIMIT

  - Last-level cache (LLC) controller
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 16
    - Number of access types: 2 (code and data)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Occupancy
    - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID

  - Memory controllers
    - Resource type: Bandwidth
    - Number of bandwidth blocks (NBWBLKS): 1024
        - Bandwidth blocks do not have a unit but instead represent a
          portion of the total bandwidth resource. For NBWBLKS of 1024,
          each block represents about 0.1% of the bandwidth resource.
    - Maximum reserved bandwidth blocks (MRBWB): 819 [80% of NBWBLKS]
    - Number of access types: 2 (code and data)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Total read/write byte count, Total
                           read byte count, Total write byte count
    - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT

The memory map used for the example SoC:

  Base addr  Size
  0x4820000  4KB  Cluster 0 L2 cache controller
  0x4821000  4KB  Cluster 1 L2 cache controller
  0x4828000  4KB  Memory controller 0
  0x4829000  4KB  Memory controller 1
  0x482a000  4KB  Memory controller 2
  0x482b000  4KB  Shared LLC cache controller

This configuration is meant to provide a "concrete" example for software
(like Linux) to test against. It represents just one of many possible
ways for hardware to implement the CBQRI spec.

The example SoC configuration is created with the following:

  qemu-system-riscv64 \
        -M virt \
        -nographic \
        -smp 8 \
        -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04820000 \
        -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04821000 \
        -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=16,mmio_base=0x0482b000 \
        -device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04828000 \
        -device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04829000 \
        -device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x0482a000

The virt machine does not describe the controllers to the guest. No
device tree node or ACPI table is generated for them, so a dtb with the
controller nodes must be passed with -dtb. I plan to add device tree
generation and ACPI RQSC support [7] as follow-up series.

In addition, please note that this series only implements the register
interface that CBQRI specifies. It does not attempt to emulate the
performance impact of configuring limits on shared resources like cache
and memory bandwidth. Similarly, the code does not attempt to emulate
cache and memory bandwidth utilization, like what would be observed on a
real hardware system implementing CBQRI.

Linux support for the srmcfg CSR from the Ssqosid extension has been
upstream since v7.3. There is a Linux kernel patch series [3] which adds
CBQRI cache allocation with resctrl integration. It is also available as
a branch named cbqri-cache-alloc-dt [4]. That series only supports
capacity controllers. Linux support for bandwidth controllers was last
posted as an RFC [5], and I plan to rebase it on the resctrl generic
schema v2 proof-of-concept [6].

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://lore.kernel.org/all/20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=cbqri-cache-alloc-dt
[5] https://lore.kernel.org/all/20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org/
[6] https://lore.kernel.org/all/d258a32f-12d5-464d-abe9-4720fb3e44b3@intel.com/
[7] https://lore.kernel.org/all/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/

Changes since v6:
 - Rebase on riscv-to-apply.next
 - Add SMSTATEEN0_SRMCFG to the mstateen0 and mstateen0h write masks so
   that M-mode can enable S-mode access to srmcfg.
 - Remove the at_data property because the spec says that unsupported AT
   values behave as AT 0.
 - Add vmstate for srmcfg
 - Mark both controllers unmigratable
 - Remove the unused target property and unused bc_bw_alloc field
 - Use an integer helper to size the bandwidth allocation table instead
   of pointer arithmetic on NULL.
 - Move MonitorCounter to cbqri.h
 - Add note to the cover letter about plans for device tree generation
 - Link to v6: https://lore.kernel.org/qemu-devel/20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org

Changes since v5:
 - Rebase on riscv-to-apply.next
 - Report version 1.0 in cc_capabilities and bc_capabilities
 - Use MAKE_64BIT_MASK() and QEMU_ALIGN_DOWN() instead of UL constants
 - Check that the sum of Rbwb across all RCIDs doesn't exceed MRBWB
 - Set the mrbwb property in riscv_cbqri_bc_create()
 - Add comments that the counter is marked INVALID
 - Link to v5: https://lore.kernel.org/qemu-devel/20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org

Changes since v4:
 - Add read and write wrappers to support 32-bit access size as the spec
   states that "CBQRI registers are defined so that software can perform
   two individual 4 byte accesses". Thanks to Radim for suggesting this
   solution.
 - Link to v4: https://lore.kernel.org/qemu-devel/20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org

Changes since v3:
 - NOTE: I should have used version v3 for the previous version posted
   on Nov 19, 2025 given there was already v1/v2 back in 2023. Therefore
   I am using v4 in this new revision.
 - Rebase on current master as of Dec 29 (942b0d378a1d) and update
   include paths for qdev-properties.h and sysbus.h
 - Add Rb tags from Daniel
 - Squash the Kconfig and meson.build patches together per Daniel
 - Use riscv_cpu_cfg() instead of env_archcpu() in check_srmcfg()
 - Add check for mstateen0.SRMCFG in check_srmcfg()
 - Increase ISA_EXT_DATA_ENTRY() for ssqosid from PRIV_VERSION_1_12_0
   to PRIV_VERSION_1_13_0 as it was added in Privileged Arch 1.13
 - Calculate the size of the capacity controller MMIO space based on
   on cc->ncblks and roundup to be aligned to the 4KB page boundary.
 - Remove rpfx, p and cunits properties that were added in the previous
   revision as I have decided to not support those optional features in
   this capacity controller implementation.
 - Update riscv_cbqri_cc_read to set 0 for RPFX, P and CUNITS in
   cc_capabilities. This indicates that this capacity controller
   implementation does not support RCID-prefixed mode and nor does it
   support capacity unit limits.
 - Add cc_cunits register after cc_block_mask register in the
   alloc_blockmasks array and adjust logic in get_blockmask_offset,
   riscv_cbqri_cc_read, riscv_cbqri_cc_write. Since capacity units is
   not supported, the cc_cunits register will always be 0.
 - Only assign capacity for rcid 0 in riscv_cbqri_cc_reset and do not
   touch allocation for other rcid values as they are unspecified
   following a reset.
 - Change CC_ALLOC_OP_FLUSH_RCID to be a no-op instead of calling
   alloc_blockmask_init() as the spec states that the configured
   capacity block allocation or the capacity unit limit is not
   changed by the flush operation.
 - Add comment to explain that, while the spec only requires the busy
   field to be reset to 0, the entire contents of the cc->cc_mon_ctl
   and cc->cc_alloc_ctl registers are set to 0 simplify the code in
   riscv_cbqri_cc_reset().
 - Simplify the access type logic for blockmask initialization in
   riscv_cbqri_cc_reset().
 - Add static inline helpers get_bmw() and get_slots().
 - Add check to bandwidth_config() that rbwb is not greater than mrbwb.
 - Link to v3: https://lore.kernel.org/qemu-devel/20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org

Changes since v2:
 - NOTE: I should have used version v3 for this version posted on Nov 19
   as there were already v1 and v2 back in 2023.
 - Rebase on master which is currently at version v10.1.50
 - Add fields that were not in the draft used for the proof of concept
   and introduced in final CBQRI 1.0 spec: capacity units (cunits) and
   RCID-prefixed mode (RPFX) along with parameter P (prefixed bits)
 - Fix check_srmcfg() to check if virtualization is enabled, and if so,
   return virt instruction fault, otherwise return smode()
 - Fix indentation in read_srmcfg()
 - Add SPDX headers
 - Add MAINTAINERS entries
 - Link to v2: https://lore.kernel.org/qemu-devel/20230425203834.1135306-1-dfustini@baylibre.com/

Changes since v1:
 - Rebase on current master (8.0.50) instead of 8.0.0-rc4
 - Configure CBQRI controllers based on device properties in command
   line arguments instead of a fixed example SoC configuration.
 - Move TYPE_RISCV_CBQRI_BC and TYPE_RISCV_CBQRI_CC into header so that
   machines may use it (suggested by Alistair).
 - Change 'select RISC_CBQRI' to 'imply RISCV_CBQRI' for RISCV_VIRT.
 - Patches 8/9 could be dropped as they are not needed for the CBQRI
   proof-of-concept to work. They are only meant to serve as an example
   for those implementing new machines.
 - Link to v1: https://lore.kernel.org/qemu-devel/20230416232050.4094820-1-dfustini@baylibre.com/

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
Kornel Dulęba (1):
      riscv: implement Ssqosid extension and srmcfg CSR

Nicolas Pitre (5):
      hw/riscv: define capabilities of CBQRI controllers
      hw/riscv: implement CBQRI capacity controller
      hw/riscv: implement CBQRI bandwidth controller
      hw/riscv: add CBQRI to Kconfig and build if enabled
      hw/riscv: add CBQRI controllers to virt machine

 MAINTAINERS                       |   9 +
 disas/riscv.c                     |   1 +
 hw/core/sysbus-fdt.c              |   4 +
 hw/riscv/Kconfig                  |   4 +
 hw/riscv/cbqri_bandwidth.c        | 650 ++++++++++++++++++++++++++++++++++
 hw/riscv/cbqri_capacity.c         | 715 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build              |   2 +
 hw/riscv/virt.c                   |   3 +
 include/hw/riscv/cbqri.h          |  74 ++++
 target/riscv/cpu.c                |   3 +
 target/riscv/cpu.h                |   3 +
 target/riscv/cpu_bits.h           |   9 +
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/machine.c            |  19 +
 target/riscv/tcg/csr.c            |  45 +++
 15 files changed, 1542 insertions(+)
---
base-commit: bf67d56f282c1ee25b67dfda3f8ca54d2bd4648e
change-id: 20251229-riscv-ssqosid-cbqri-aee2271532ff

Best regards,
--  
Drew Fustini <fustini@kernel.org>


