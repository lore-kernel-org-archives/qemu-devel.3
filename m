Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4035EC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJsC-0003i8-Rf; Fri, 24 Jan 2025 08:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJrw-0003hS-VD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:08 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJru-0003oF-6q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725827; x=1769261827;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=af0DaxV6gEg0cz4KoUno4KNU4bEqf0Z7gl2SqxN9zGQ=;
 b=Pt3CgfVaxG0c+Py7kVnET0i8ScrpDzIhvg953JQVwfPSdpixhfXUZ3zl
 bsdIRfmlRHNLS7hFO9Wr25Ggxqfx+wLWklSrlhQ4U+StqXKYUcDfm0EsN
 v3xWYv+zCwAjZCQI0SHeAXrqASLN4KNqyVnh1b8PDsfT2JuY2s31Z/CPa
 DU608XpQuNLoYeSf3kSQmj8S7gqYA9dWEZ69oIUgctYdT8EU9JaLFS28N
 5R0X/QeRlhhdTcn+B/F/BvuMFR7WKPLCyMcxt4dGmMoGJi8E2S93VLeGs
 demtfDNm6+q78aQm6O2z27w4PqhEAoAhOx7T6SeBI/RYDCL69966lP1WB g==;
X-CSE-ConnectionGUID: Uk2yy5EmTq2DARUVi4y+yA==
X-CSE-MsgGUID: JR+TFh9zQMy8Vy6RpuQNzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246168"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246168"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:37:02 -0800
X-CSE-ConnectionGUID: m1YELRpEQyCroeMZVOOfMg==
X-CSE-MsgGUID: +wRgE7xvQeC2aFaSV889oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804081"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:36:58 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 00/52] QEMU TDX support
Date: Fri, 24 Jan 2025 08:19:56 -0500
Message-Id: <20250124132048.3229049-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is the v7 series of TDX QEMU enabling. The series is also available
in github:
https://github.com/intel-staging/qemu-tdx/tree/tdx-qemu-upstream-v7

To boot TD guest, please always use the latest TDX module (1.5) and OVMF
available.

Note, this series has a dependency on
https://lore.kernel.org/qemu-devel/20241217123932.948789-1-xiaoyao.li@intel.com/

=== future work ===
- CPU model

  It now only supports booting TD VM with "-cpu host". It is the only
  case that not supposed to hit any warning/error.

  When using named CPU model, even the same model as host, it likely
  hits warning like some feature not supported or some feature enforced
  on. It's a future work to decide if needs to introduce TDX specific
  named CPU models.

- Attestation support

  Attestation support is dropped in this version becuase KVM side remove
  the support of the related user exit. Atttestation support will be
  submitted separately when KVM regain the support.

- gdb support

  gdb support to debug a TD in off-debug mode is left as future work.

=== Changes in v7 ===
 - Remove patch 40 and 41. Need to re-think on it and will submit them
   later.
 - Patch 44 in v6 is replaced by patch 38 in v7;
 - Patch 45 in v6 is replaced by patch 39 in v7;
 - Drop patch 58 and 59 in v6, since the variant of them is merged
   already;
 - squash some patches into their user patch;
 - For other, please see individual patch for change history;

v6:
https://lore.kernel.org/qemu-devel/20241105062408.3533704-1-xiaoyao.li@intel.com/

Chao Peng (1):
  i386/tdx: load TDVF for TD guest

Isaku Yamahata (4):
  i386/tdx: Make sept_ve_disable set by default
  i386/tdvf: Introduce function to parse TDVF metadata
  i386/tdx: Add TDVF memory via KVM_TDX_INIT_MEM_REGION
  i386/tdx: Don't synchronize guest tsc for TDs

Xiaoyao Li (47):
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
  i386/cpu: introduce x86_confidential_guest_cpu_instance_init()
  i386/tdx: implement tdx_cpu_instance_init()
  i386/cpu: Introduce enable_cpuid_0x1f to force exposing CPUID 0x1f
  i386/tdx: Force exposing CPUID 0x1f
  i386/tdx: Set kvm_readonly_mem_enabled to false for TDX VM
  i386/tdx: Disable SMM for TDX VMs
  i386/tdx: Disable PIC for TDX VMs
  i386/tdx: Only configure MSR_IA32_UCODE_REV in kvm_init_msrs() for TDs
  i386/apic: Skip kvm_apic_put() for TDX
  cpu: Don't set vcpu_dirty when guest_state_protected
  i386/cgs: Rename *mask_cpuid_features() to *adjust_cpuid_features()
  i386/tdx: Implement adjust_cpuid_features() for TDX
  i386/tdx: Apply TDX fixed0 and fixed1 information to supported CPUIDs
  i386/tdx: Mask off CPUID bits by unsupported TD Attributes
  i386/cpu: Move CPUID_XSTATE_XSS_MASK to header file and introduce
    CPUID_XSTATE_MASK
  i386/tdx: Mask off CPUID bits by unsupported XFAM
  i386/tdx: Mark the configurable bit not reported by KVM as unsupported
  i386/cgs: Introduce x86_confidential_guest_check_features()
  i386/tdx: Fetch and validate CPUID of TD guest
  i386/tdx: Don't treat SYSCALL as unavailable
  i386/tdx: Make invtsc default on
  i386/tdx: Validate phys_bits against host value
  docs: Add TDX documentation

 accel/kvm/kvm-all.c                        |   17 +-
 configs/devices/i386-softmmu/default.mak   |    1 +
 docs/system/confidential-guest-support.rst |    1 +
 docs/system/i386/tdx.rst                   |  156 +++
 docs/system/target-i386.rst                |    1 +
 hw/i386/Kconfig                            |    6 +
 hw/i386/kvm/apic.c                         |    5 +
 hw/i386/meson.build                        |    1 +
 hw/i386/pc.c                               |   29 +-
 hw/i386/pc_sysfw.c                         |    7 +
 hw/i386/tdvf-hob.c                         |  130 +++
 hw/i386/tdvf-hob.h                         |   26 +
 hw/i386/tdvf.c                             |  187 +++
 hw/i386/x86-common.c                       |    6 +-
 include/hw/i386/tdvf.h                     |   45 +
 include/standard-headers/uefi/uefi.h       |  187 +++
 include/system/kvm.h                       |    1 +
 linux-headers/asm-x86/kvm.h                |   70 ++
 linux-headers/linux/kvm.h                  |    1 +
 qapi/qom.json                              |   35 +
 qapi/run-state.json                        |   31 +-
 system/runstate.c                          |   67 ++
 target/arm/kvm.c                           |    5 +
 target/i386/confidential-guest.h           |   44 +-
 target/i386/cpu.c                          |   50 +-
 target/i386/cpu.h                          |   27 +
 target/i386/host-cpu.c                     |    2 +-
 target/i386/host-cpu.h                     |    1 +
 target/i386/kvm/kvm.c                      |  114 +-
 target/i386/kvm/kvm_i386.h                 |   15 +
 target/i386/kvm/meson.build                |    2 +
 target/i386/kvm/tdx-stub.c                 |   20 +
 target/i386/kvm/tdx.c                      | 1213 ++++++++++++++++++++
 target/i386/kvm/tdx.h                      |   65 ++
 target/i386/sev.c                          |    9 +-
 target/loongarch/kvm/kvm.c                 |    5 +
 target/mips/kvm.c                          |    5 +
 target/ppc/kvm.c                           |    5 +
 target/riscv/kvm/kvm-cpu.c                 |    5 +
 target/s390x/kvm/kvm.c                     |    5 +
 40 files changed, 2517 insertions(+), 85 deletions(-)
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


