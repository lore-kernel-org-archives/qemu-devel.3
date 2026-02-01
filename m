Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC41FD172AA
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmhKm-0005hF-UD; Sun, 01 Feb 2026 18:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vmhKl-0005g5-3R; Sun, 01 Feb 2026 18:58:27 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vmhKh-0007l8-QU; Sun, 01 Feb 2026 18:58:26 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E246F60008;
 Sun,  1 Feb 2026 23:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131D4C4CEF7;
 Sun,  1 Feb 2026 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769990293;
 bh=UaVzgF3u0n/OEyZHbgmU9AM4dR6+G7QcZIs6cdB+84k=;
 h=From:Subject:Date:To:Cc:From;
 b=CEOqwno59XKsoHJ2EZzyYXb4j0hCkEKEhRoV7KTP+mH49cMxrEIkKz8da29bD0SoD
 +lsHEKnf1y2g8O/ql9HP9FYP0M7pGVLcnYUSr7cjC1tPc3Vuu6TRrTDWLiW7ZXE4YL
 lNftZheLn8CO4SYkLK+WLmC89R+nmtCTsHFGvpDT61MCBaOT5jC0MpSzS4QeQaUiqo
 gdo+x1QoZflrpv9ahcpDmpJJMn1MnYNp77t148a/e/kmEHJrFRmtdpqlE14P+EMx2n
 CAPi65i1Bq2TlPcz7jDOf9Jcm995Jn7tkUtXwMUf2vaOkj3gCtLQPqLeRR3qvBlmqN
 S9AfCUxaVXpzA==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v5 0/6] riscv: implement Ssqosid extension and CBQRI
 controllers
Date: Sun, 01 Feb 2026 15:58:06 -0800
Message-Id: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI7of2kC/22NQQ6CMBBFr0JmbU1bKRVX3sOwQDrARENlxjQaw
 t0trF2+l/z3FxBkQoFLsQBjIqE4ZXCHArqxnQZUFDKD1dYZa2vFJF1SInMUCqq7z0yqRbTWG3e
 yfQ95+WLs6bNXb03mkeQd+bufpHKzW6/SRru/vVQqreo2+MqbENCfrw/kCZ/HyAM067r+AFEL1
 Za3AAAA
X-Change-ID: 20251229-riscv-ssqosid-cbqri-aee2271532ff
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
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13466; i=fustini@kernel.org;
 h=from:subject:message-id; bh=UaVzgF3u0n/OEyZHbgmU9AM4dR6+G7QcZIs6cdB+84k=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTWv5hyRlBQx3LGpwvnD0V3XOG8lqdbGMSbuUNF6k8yS
 4JBerp9RykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAi/aWMDC9Wzf6Zwh6195NI
 hvs5E7ul/XL6ZVzH3rSfu/AodNtDbTaG/34aGRpLGdIzHSwZZlRI9aX9tJ0a5p2bXTfhje7sPYL
 GPAA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This series implements the RISC-V Quality-of-Service Identifiers
(Ssqosid) extension [1] which adds the srmcfg register. It also
implements the RISC-V Capacity and Bandwidth Controller QoS Register
Interface (CBQRI) specification [2]. Quality of Service (QoS) in this
context is concerned with shared resources on an SoC such as cache
capacity and memory bandwidth.

Sssqosid srmcfg CSR
-------------------
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

This series implements an CBQRI capacity controller and an CBQRI
bandwidth controller which can be configured from the command line:

  $ qemu-system-riscv64 -M virt ... \
      -device riscv.cbqri.capacity,mmio_base=0x04828000[,...] \
      -device riscv.cbqri.bandwidth,mmio_base=0x04829000[,...]
    
The mmio_base option is mandatory, the others are optional.
                           
As many -device arguments as wanted can be provided as long as their
mmio regions don't conflict.

To see all possible options:

  $ qemu-system-riscv64 -device riscv.cbqri.capacity,help
  riscv.cbqri.capacity options:
    alloc_op_config_limit=<bool> -  (default: true)
    alloc_op_flush_rcid=<bool> -  (default: true)
    alloc_op_read_limit=<bool> -  (default: true)
    at_code=<bool>         -  (default: true)
    at_data=<bool>         -  (default: true)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)   
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> -  (default: true)
    mon_evt_id_occupancy=<bool> -  (default: true)
    mon_op_config_event=<bool> -  (default: true)
    mon_op_read_counter=<bool> -  (default: true)
    ncblks=<uint16>        -  (default: 16)
    target=<str>
   
  $ qemu-system-riscv64 -device riscv.cbqri.bandwidth,help
  riscv.cbqri.bandwidth options:
    alloc_op_config_limit=<bool> -  (default: true)
    alloc_op_read_limit=<bool> -  (default: true)
    at_code=<bool>         -  (default: true)
    at_data=<bool>         -  (default: true)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> -  (default: true)
    mon_evt_id_rdonly_count=<bool> -  (default: true)
    mon_evt_id_rdwr_count=<bool> -  (default: true)
    mon_evt_id_wronly_count=<bool> -  (default: true)
    mon_op_config_event=<bool> -  (default: true)
    mon_op_read_counter=<bool> -  (default: true)
    nbwblks=<uint16>       -  (default: 1024)
    target=<str>

Boolean options correspond to hardware capabilities that can be disabled
 
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
         portion of the total bandwidth resource. For NWBLKS of 1024,
	 each block represents about 0.1% of the bandwidth resource.
    - Maximum reserved bandwidth blocks (MRBWB): 819 [80% of NBWBLKS]
    - Number of access types: 1 (no code/data differentiation)
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
        -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=16,mmio_base=0x0482B000 \
        -device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04828000 \
        -device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04829000 \
        -device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x0482a000

In addition, please note that this series only implements the register
interface that CBQRI specifies. It does not attempt to emulate the
performance impact of configuring limits on shared resources like cache
and memory bandwidth. Similarly, the code does not attempt to emulate
cache and memory bandwidth utilization, like what would be observed on a
real hardware system implementing CBQRI.

There is a Linux kernel patch series [3] which adds support for Ssqosid
and CBQRI along with resctrl integration. It is also available as a
branch named ssqosid-cbqri-rfc-v1 [4].

RQSC note: my plan is to post a new series on top of this one which
implemenets support for the ACPI RQSC table. There is a work-in-progress
branch named b4/riscv-rqsc [5].

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://lore.kernel.org/all/20260119-ssqosid-cbqri-v1-0-aa2a75153832@kernel.org/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=ssqosid-cbqri-rfc-v1
[5] https://github.com/tt-fustini/qemu/tree/b4/riscv-rqsc

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
   abd cc->cc_alloc_ctl registers are set to 0 simplify the code in
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
 - Add MAINTAINERS enteries
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
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-riscv@nongnu.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: Drew Fustini <fustini@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

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
 hw/riscv/Kconfig                  |   4 +
 hw/riscv/cbqri_bandwidth.c        | 638 +++++++++++++++++++++++++++++++++
 hw/riscv/cbqri_capacity.c         | 733 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build              |   1 +
 hw/riscv/virt.c                   |   3 +
 include/hw/riscv/cbqri.h          |  82 +++++
 target/riscv/cpu.c                |   2 +
 target/riscv/cpu.h                |   3 +
 target/riscv/cpu_bits.h           |   9 +
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/csr.c                |  37 ++
 13 files changed, 1523 insertions(+)
---
base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
change-id: 20251229-riscv-ssqosid-cbqri-aee2271532ff

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


