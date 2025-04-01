Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B8AC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbs7-0005A1-DF; Tue, 01 Apr 2025 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbrk-00057z-QN
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:22 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbrg-0006Wn-TP
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514877; x=1775050877;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7tRJxnr6+P/XTLyo1Qa4ZKqinrVzK624PTeR8ybQ1fI=;
 b=dnJt+p112iQevFgPJmcJNdQNXe9K7FbL7pABZwaikTQY9DEWTFT9Troz
 jLrTpyTKYT4dkJQ84ktF38zgvIbzM4IwQWeDf/ia/TtzyBTMZIMcXYG70
 sayLcxWzwrZMP41xSnqohaJVBX5+J6DZfI6650A+mm2OyKtxnsmSW739k
 FO3sQikpoyoEOSm6ST1IF/HZUxtxbhI0jwrjg1PkfECQf/oP3Ije/123d
 AtFupGjiDxL/DQpFS3gqCTEnS/wt6rTlfvA3ZeBatFXrfFDC/QnwEZTz5
 2D43geqJo7/KZ0qPM4ErIqHcQPGRrM95CoDj1OHxjcZf+nEvjSipsMePW g==;
X-CSE-ConnectionGUID: b2lryNygQD2g/q2SGbYIAg==
X-CSE-MsgGUID: pI027Ie4TDi6CfkebhqYNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433115"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433115"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:10 -0700
X-CSE-ConnectionGUID: Pc+Gb4WzQx6VF0V0mXNedQ==
X-CSE-MsgGUID: D7tvkbbOQtS3gI8CvxqcLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639834"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:08 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH for 10.1 v8 00/55] QEMU TDX support
Date: Tue,  1 Apr 2025 09:01:10 -0400
Message-Id: <20250401130205.2198253-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is the v8 series of TDX QEMU enabling and the series is also available
at github:
https://github.com/intel-staging/qemu-tdx/tree/tdx-qemu-upstream-v8

To boot TD guest, please always use the latest TDX module (1.5) and OVMF
available.

Note, this series has a dependency on
https://lore.kernel.org/qemu-devel/20241217123932.948789-1-xiaoyao.li@intel.com/

=============
Changes in v8

- Address the comments from Francesco Lavra;
- Add a patch to check KVM_CAP_MAX_VCPUS at vm level;
- Make the default kernel_irqchip to split mode for TDX and refuse to
  boot when other mode requested; (Daniel)
- Drop the manually adjustment of supported CPUID for TDX, which turns
  to be not forward compatible since any newly enabled feature for common KVM
  will automatically be treated as supported for TDX as well. Instead,
  implement TDX's supported CPUID by combining the information from
  directly configurable bits, fixed1 bits, XFAM controlled bits and
  attributes controlled bits. 

===========
future work

- CPU model

  It now only supports booting TD VM with "-cpu host". It is the only
  case that not supposed to hit any warning/error.

  When using named CPU model, even the same model as host, it likely
  hits warning like some feature not supported or some feature enforced
  on. It's a future work to decide if needs to introduce TDX specific
  named CPU models.

- Attestation support

  Atttestation support will be submitted separately after KVM side
  patches being submitted.

- gdb support

  gdb support to debug a TD in off-debug mode is left as future work.

=======
history

v7: https://lore.kernel.org/qemu-devel/20250124132048.3229049-1-xiaoyao.li@intel.com/

v6: https://lore.kernel.org/qemu-devel/20241105062408.3533704-1-xiaoyao.li@intel.com/

Chao Peng (1):
  i386/tdx: load TDVF for TD guest

Isaku Yamahata (5):
  i386/tdx: Make sept_ve_disable set by default
  i386/tdx: Support user configurable mrconfigid/mrowner/mrownerconfig
  i386/tdvf: Introduce function to parse TDVF metadata
  i386/tdx: Add TDVF memory via KVM_TDX_INIT_MEM_REGION
  i386/tdx: Don't synchronize guest tsc for TDs

Xiaoyao Li (49):
  *** HACK *** linux-headers: Update headers to pull in TDX API changes
  i386: Introduce tdx-guest object
  i386/tdx: Implement tdx_kvm_type() for TDX
  i386/tdx: Implement tdx_kvm_init() to initialize TDX VM context
  i386/tdx: Get tdx_capabilities via KVM_TDX_CAPABILITIES
  i386/tdx: Introduce is_tdx_vm() helper and cache tdx_guest object
  kvm: Introduce kvm_arch_pre_create_vcpu()
  i386/tdx: Initialize TDX before creating TD vcpus
  i386/tdx: Add property sept-ve-disable for tdx-guest object
  i386/tdx: Wire CPU features up with attributes of TD guest
  i386/tdx: Validate TD attributes
  i386/tdx: Set APIC bus rate to match with what TDX module enforces
  i386/tdx: Implement user specified tsc frequency
  i386/tdx: Parse TDVF metadata for TDX VM
  i386/tdx: Don't initialize pc.rom for TDX VMs
  i386/tdx: Track mem_ptr for each firmware entry of TDVF
  i386/tdx: Track RAM entries for TDX VM
  headers: Add definitions from UEFI spec for volumes, resources, etc...
  i386/tdx: Setup the TD HOB list
  i386/tdx: Call KVM_TDX_INIT_VCPU to initialize TDX vcpu
  i386/tdx: Finalize TDX VM
  i386/tdx: Enable user exit on KVM_HC_MAP_GPA_RANGE
  i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
  i386/tdx: Wire TDX_REPORT_FATAL_ERROR with GuestPanic facility
  kvm: Check KVM_CAP_MAX_VCPUS at vm level
  i386/cpu: introduce x86_confidential_guest_cpu_instance_init()
  i386/tdx: implement tdx_cpu_instance_init()
  i386/cpu: Introduce enable_cpuid_0x1f to force exposing CPUID 0x1f
  i386/tdx: Force exposing CPUID 0x1f
  i386/tdx: Set kvm_readonly_mem_enabled to false for TDX VM
  i386/tdx: Disable SMM for TDX VMs
  i386/tdx: Disable PIC for TDX VMs
  i386/tdx: Set and check kernel_irqchip mode for TDX
  i386/tdx: Only configure MSR_IA32_UCODE_REV in kvm_init_msrs() for TDs
  i386/apic: Skip kvm_apic_put() for TDX
  cpu: Don't set vcpu_dirty when guest_state_protected
  i386/cgs: Rename *mask_cpuid_features() to *adjust_cpuid_features()
  i386/tdx: Implement adjust_cpuid_features() for TDX
  i386/tdx: Add TDX fixed1 bits to supported CPUIDs
  i386/tdx: Add supported CPUID bits related to TD Attributes
  i386/tdx: Add supported CPUID bits relates to XFAM
  i386/tdx: Add XFD to supported bit of TDX
  i386/tdx: Define supported KVM features for TDX
  i386/cgs: Introduce x86_confidential_guest_check_features()
  i386/tdx: Fetch and validate CPUID of TD guest
  i386/tdx: Don't treat SYSCALL as unavailable
  i386/tdx: Make invtsc default on
  i386/tdx: Validate phys_bits against host value
  docs: Add TDX documentation

 accel/kvm/kvm-all.c                        |   11 +-
 configs/devices/i386-softmmu/default.mak   |    1 +
 docs/system/confidential-guest-support.rst |    1 +
 docs/system/i386/tdx.rst                   |  156 +++
 docs/system/target-i386.rst                |    1 +
 hw/i386/Kconfig                            |    6 +
 hw/i386/kvm/apic.c                         |    5 +
 hw/i386/meson.build                        |    1 +
 hw/i386/pc.c                               |   29 +-
 hw/i386/pc_sysfw.c                         |    7 +
 hw/i386/tdvf-hob.c                         |  130 ++
 hw/i386/tdvf-hob.h                         |   26 +
 hw/i386/tdvf.c                             |  184 +++
 hw/i386/x86-common.c                       |    6 +-
 include/hw/i386/tdvf.h                     |   45 +
 include/standard-headers/uefi/uefi.h       |  187 +++
 include/system/kvm.h                       |    1 +
 linux-headers/asm-x86/kvm.h                |   69 ++
 linux-headers/linux/kvm.h                  |    1 +
 qapi/qom.json                              |   35 +
 qapi/run-state.json                        |   31 +-
 system/runstate.c                          |   65 +
 target/arm/kvm.c                           |    5 +
 target/i386/confidential-guest.h           |   44 +-
 target/i386/cpu.c                          |   73 +-
 target/i386/cpu.h                          |   40 +
 target/i386/host-cpu.c                     |    2 +-
 target/i386/host-cpu.h                     |    1 +
 target/i386/kvm/kvm.c                      |  114 +-
 target/i386/kvm/kvm_i386.h                 |   15 +
 target/i386/kvm/meson.build                |    2 +
 target/i386/kvm/tdx-stub.c                 |   20 +
 target/i386/kvm/tdx.c                      | 1273 ++++++++++++++++++++
 target/i386/kvm/tdx.h                      |   65 +
 target/i386/sev.c                          |    9 +-
 target/loongarch/kvm/kvm.c                 |    4 +
 target/mips/kvm.c                          |    5 +
 target/ppc/kvm.c                           |    5 +
 target/riscv/kvm/kvm-cpu.c                 |    5 +
 target/s390x/kvm/kvm.c                     |    5 +
 40 files changed, 2592 insertions(+), 93 deletions(-)
 create mode 100644 docs/system/i386/tdx.rst
 create mode 100644 hw/i386/tdvf-hob.c
 create mode 100644 hw/i386/tdvf-hob.h
 create mode 100644 hw/i386/tdvf.c
 create mode 100644 include/hw/i386/tdvf.h
 create mode 100644 include/standard-headers/uefi/uefi.h
 create mode 100644 target/i386/kvm/tdx-stub.c
 create mode 100644 target/i386/kvm/tdx.c
 create mode 100644 target/i386/kvm/tdx.h

-- 
2.34.1


