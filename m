Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E5CD0413
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcsXV-0006Jy-Ox; Mon, 05 Jan 2026 16:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vcsXU-0006I9-Ki; Mon, 05 Jan 2026 16:55:00 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vcsXP-0006CU-2y; Mon, 05 Jan 2026 16:55:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B30D160010;
 Mon,  5 Jan 2026 21:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC74C116D0;
 Mon,  5 Jan 2026 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767650090;
 bh=yGFf0cMrOzP+200faXPFU3TKRXdGaeq1PS50ebauLEQ=;
 h=From:Subject:Date:To:Cc:From;
 b=V1CkwzGhNpG0E2BRa528iOik5TXCko/t4rmuPWyzTlQ6rQFU6aRlIc7fb8AWmA/67
 TyDttwjiVuziyr040FVLqiABHRGk4eEOxlDgFxEO4/3CK+27lVHKSEolj0NYWNSiq0
 luXg27dO7x2o7nnXzC7ibD3WR4D/xWrl8wYXoFqf6jooHakIdPi+fQz4atqSRObzNt
 0dzRe1qas+eX5TVqCFpJt99EziigBP5wgHrxHUohUqnid2gIRNj+OlLr0Yv9UpwIwF
 NxWZE8LacGT2Ns/6x1tanaDy1UISGtld64rlDAcwBtxiqgXYcykxwA3lSeiZbtPC9H
 2yx3uunZ2X2mg==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v4 0/6] riscv: implement Ssqosid extension and CBQRI
 controllers
Date: Mon, 05 Jan 2026 13:54:18 -0800
Message-Id: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAozXGkC/x3MPQqAMAxA4atIZgMaFdGriEOtqWbxJwERSu9uc
 fyG9yIYq7DBWERQfsTkPDLasgC/u2NjlDUbqKKuJhpQxfyDZvdpsqJfbhV0zER93TUUAuTyUg7
 y/tdpTukDsEkczWUAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12851; i=fustini@kernel.org;
 h=from:subject:message-id; bh=yGFf0cMrOzP+200faXPFU3TKRXdGaeq1PS50ebauLEQ=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTGGGt696glrquesvLO4UKX2VaG09aEm9QoWRvqx+hIb
 p19zi2yo5SFQYyLQVZMkWXTh7wLS7xCvy6Y/2IbzBxWJpAhDFycAjCRSYsYGaYJz6n8254tXbeh
 K9CW/6d8wD8vzuLJGycK3GE8cETm4yWG/+XBh8tyuRnKrnS5Tph8cR7LDtUY9mWny77c3f0yTri
 2hhcA
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

There is a branch of Linux [3] which adds support for Ssqosid and CBQRI
along with resctrl integration. I still need to do some more cleanup of
the code and intend to post the Linux patch series soon.

Open issue:
 - Support 32-bit operation as the spec states that "CBQRI registers are
   defined so that software can perform two individual 4 byte accesses."
   The MemoryRegionOps have .valid.min_access_size = 4 but the read and
   write hooks have assert(size == 8). I need to figure out how to
   correctly handle accesses of size 4.

Despite the open issue above, I am sending out this new revision as I
believe I have addressed all the other feedback.

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

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/ssqosid-cbqri

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
 hw/riscv/Kconfig                  |   4 +
 hw/riscv/cbqri_bandwidth.c        | 612 +++++++++++++++++++++++++++++++++
 hw/riscv/cbqri_capacity.c         | 706 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build              |   1 +
 hw/riscv/virt.c                   |   3 +
 include/hw/riscv/cbqri.h          |  82 +++++
 target/riscv/cpu.c                |   2 +
 target/riscv/cpu.h                |   3 +
 target/riscv/cpu_bits.h           |   9 +
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/csr.c                |  37 ++
 13 files changed, 1470 insertions(+)
---
base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
change-id: 20251229-riscv-ssqosid-cbqri-aee2271532ff

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


