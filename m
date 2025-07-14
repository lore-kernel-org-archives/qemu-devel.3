Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79BBC83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH7P-0008FO-BL; Mon, 14 Jul 2025 07:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyy-0000Ze-0V
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyr-0001UV-8r
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e39jO+RRyF8AkAm50fcydu/WLdPgNKhK/oe//9JHPYI=;
 b=D/9yQDpAQYyZzFl7JMgFrsN3xGRYRajAFmWAmzag/ZK8X2+YjOeF0NxzUGhTB7bsXccOfY
 8qNoY6W0L2Z/aMcE5MBToN3/Z/cl+wvl5t7z+NorJKDCuUQ310x57EXxhPWL2QBvqcgEAu
 OEDvpDNu7twLHn6PKt/LLlBy/Msep/Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-bVljncQKMkiq705veVBqKQ-1; Mon, 14 Jul 2025 07:04:11 -0400
X-MC-Unique: bVljncQKMkiq705veVBqKQ-1
X-Mimecast-MFC-AGG-ID: bVljncQKMkiq705veVBqKQ_1752491050
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b5f97cb8fbso576398f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491050; x=1753095850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e39jO+RRyF8AkAm50fcydu/WLdPgNKhK/oe//9JHPYI=;
 b=oJmJSJlZXCrWdOI4KpJ6pKW7/WRpcVDIQwmrDLmNRXiPQEIm35/smZvYfOnZGeSX4r
 0UnL24IB2l4wI6s/irfGrG+TrPS+Eten/LSCcFwEBPLpiCSEDh9KDFBXyvaP2M9rk5yr
 3E9KZnIB44OIv8+pVKvrMxnmLZMT3LzlJYu83vhso5bIHvZ2X5mZ+2p9xWPDVqBJXfpc
 dDYrcYcboDHZVYHs7CUS+Cq+/nqo+zzmrO/P5D/5u8JEW/JikBRNRYygSYkCtjEsHCHl
 nIQxeCq2s1U5g8Jc6OwX9H1n/JCbGBSPuASB5TGYRJXtj9OBM0RQZtfebHQEFp15r47u
 TLCA==
X-Gm-Message-State: AOJu0Yx1ZVHv+dh5qgtmPo3Ah9sXP4Y8Jqz/VRD3sNWJJIxOJymtqzBB
 pMkyF57cyENcQ5/8cDskKSlZSpBrUHx6tLocTZkusksFbNpOYKFmk+nEijG8Eqiw6vvcVZ5PkVZ
 lAZq4SzfU90IQC96AHMeMGsfbnICvwskCWddUSTY/3pjx9hQwjsUzgYsC3wFq0VX3tcpdLQQO0v
 FVm4mvL/ZimihWG4o7vyb/4ZbvD8MZpsOC+ZBM3BNu
X-Gm-Gg: ASbGncvDxYqtByEVOp+Zjy1dWoMtUfMvNIDtH0OzlIK25LOd454ajX2NkFBuCqaed5L
 HCFA4vLvhNbK0ye93t8nXbu4EnE6fEFWK8S4x5/5x48jzh+m5A4uFmRZS3KiVnSHoEwbn0hkTWT
 wb8iiGcNuHz//bUS0ITKuq9Zjj3+ivo0WO5c0HftrpenYCavVZ+vW8g5mjUc7hdvgv8JFzj9QNj
 EQQgS6vJPqWp/LC47WzDOfrQ65C53QV9lWq6TQUlU722UIwrTb5ZtsIlKQ8bkSUBrEx/2CyNDV8
 KROwMHFR5+QL/hunRy6B9KYc9LR2IihDL8GlkWv7Mcw=
X-Received: by 2002:a05:6000:23c4:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3b5f18ead44mr6952748f8f.44.1752491049346; 
 Mon, 14 Jul 2025 04:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFac9NqPDCWeMUEEhmIm+3Ojx4sTHcZF6uV+IMaAZ8MGp82fe0uF+LMI/sqJa8YgFYSCyqMCQ==
X-Received: by 2002:a05:6000:23c4:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3b5f18ead44mr6952704f8f.44.1752491048377; 
 Mon, 14 Jul 2025 04:04:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d70csm12310944f8f.62.2025.07.14.04.04.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/77] Rust, target/i386 changes for QEMU 10.1 soft freeze
Date: Mon, 14 Jul 2025 13:02:49 +0200
Message-ID: <20250714110406.117772-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba336:

  Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging (2025-07-07 09:22:41 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 5d21ee453ad8e3f95f75e542cb3b35c5bb7cf23a:

  i386/cpu: Honor maximum value for CPUID.8000001DH.EAX[25:14] (2025-07-14 10:29:17 +0200)

----------------------------------------------------------------
* rust: miscellaneous fixes
* rust: qemu-api-macros: cleanup and add unit tests for TryInto
* rust: log: implement io::Write, avoid memory allocations
  when logging constant strings
* target/i386: fix usage of properties whenever accelerators
  change the default (e.g. vendor)
* target/i386: add support for TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT
* target/i386: add support for booting an SEV VM from an IGVM file
* target/i386: unify cache model descriptions between CPUID 2,
  CPUID 4 and AMD specific CPUID 0x80000006
* target/i386: introduce cache models for recent Intel CPU models
* target/i386: mark some 0x80000000-0x80000008 bits as reserved on Intel
* target/i386: cleanups

----------------------------------------------------------------
Chuang Xu (1):
      i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]

Ewan Hai (1):
      i386/cpu: Introduce cache model for YongFeng

Manish Mishra (1):
      i386/cpu: Add a "x-force-cpuid-0x1f" property

Manos Pitsidianakis (4):
      rust/qemu-api-macros: use syn::Error directly
      rust/bindings: allow unnecessary_transmutes (1.88)
      rust/qemu-api-macros: normalize TryInto output
      rust/qemu-api-macros: add unit tests

Paolo Bonzini (8):
      rust/qemu-api: log: implement io::Write
      target/i386: move max_features to class
      target/i386: nvmm, whpx: add accel/CPU class that sets host vendor
      target/i386: allow reordering max_x86_cpu_initfn vs accel CPU init
      target/i386: move accel_cpu_instance_init to .instance_init
      target/i386: merge host_cpu_instance_init() and host_cpu_max_instance_init()
      tests/functional: test_x86_cpu_model_versions: remove dead tests
      tests/vm: bump FreeBSD image to 14.3

Qian Wen (2):
      i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
      i386/cpu: Fix overflow of cache topology fields in CPUID.04H

Roy Hopkins (16):
      meson: Add optional dependency on IGVM library
      backends/confidential-guest-support: Add functions to support IGVM
      backends/igvm: Add IGVM loader and configuration
      hw/i386: Add igvm-cfg object and processing for IGVM files
      i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with IGVM
      sev: Update launch_update_data functions to use Error handling
      target/i386: Allow setting of R_LDTR and R_TR with cpu_x86_load_seg_cache()
      i386/sev: Refactor setting of reset vector and initial CPU state
      i386/sev: Implement ConfidentialGuestSupport functions for SEV
      docs/system: Add documentation on support for IGVM
      docs/interop/firmware.json: Add igvm to FirmwareDevice
      backends/confidential-guest-support: Add set_guest_policy() function
      backends/igvm: Process initialization sections in IGVM file
      backends/igvm: Handle policy for SEV guests
      i386/sev: Add implementation of CGS set_guest_policy()
      sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2

Xiaoyao Li (11):
      i386/tdx: Remove enumeration of GetQuote in tdx_handle_get_tdvmcall_info()
      update Linux headers to KVM tree master
      i386/tdx: Set value of <GetTdVmCallInfo> based on capabilities of both KVM and QEMU
      i386/tdx: handle TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT
      i386/cpu: Move the implementation of is_host_cpu_intel() host-cpu.c
      i386/cpu: Use CPUID_MODEL_ID_SZ instead of hardcoded 48
      i386: Cleanup the usage of CPUID_VENDOR_INTEL_1
      i386/kvm-cpu: Fix the indentation inside kvm_cpu_realizefn()
      i386/cpu: Unify family, model and stepping calculation for x86 CPU
      i386/tdx: Remove task->watch only when it's valid
      i386/tdx: Don't mask off CPUID_EXT_PDCM

Zhao Liu (32):
      rust/qemu-api: Fix binding path in source directory
      i386/cpu: Refine comment of CPUID2CacheDescriptorInfo
      i386/cpu: Add descriptor 0x49 for CPUID 0x2 encoding
      i386/cpu: Add default cache model for Intel CPUs with level < 4
      i386/cpu: Present same cache model in CPUID 0x2 & 0x4
      i386/cpu: Consolidate CPUID 0x4 leaf
      i386/cpu: Drop CPUID 0x2 specific cache info in X86CPUState
      i386/cpu: Add x-vendor-cpuid-only-v2 option for compatibility
      i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
      i386/cpu: Rename AMD_ENC_ASSOC to X86_ENC_ASSOC
      i386/cpu: Fix CPUID[0x80000006] for Intel CPU
      i386/cpu: Add legacy_intel_cache_info cache model
      i386/cpu: Add legacy_amd_cache_info cache model
      i386/cpu: Select legacy cache model based on vendor in CPUID 0x2
      i386/cpu: Select legacy cache model based on vendor in CPUID 0x4
      i386/cpu: Select legacy cache model based on vendor in CPUID 0x80000005
      i386/cpu: Select legacy cache model based on vendor in CPUID 0x80000006
      i386/cpu: Select legacy cache model based on vendor in CPUID 0x8000001D
      i386/cpu: Use a unified cache_info in X86CPUState
      i386/cpu: Introduce cache model for SierraForest
      i386/cpu: Introduce cache model for GraniteRapids
      i386/cpu: Introduce cache model for SapphireRapids
      i386/cpu: Enable 0x1f leaf for SierraForest by default
      i386/cpu: Enable 0x1f leaf for SierraForest by default
      i386/cpu: Enable 0x1f leaf for GraniteRapids by default
      i386/cpu: Enable 0x1f leaf for SapphireRapids by default
      i386/cpu: Enable 0x1f leaf for YongFeng by default
      i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as reserved for Intel
      i386/cpu: Mark CPUID 0x80000007[EBX] as reserved for Intel
      i386/cpu: Mark CPUID 0x80000008 ECX bits[0:7] & [12:15] as reserved for Intel/Zhaoxin
      i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()
      i386/cpu: Honor maximum value for CPUID.8000001DH.EAX[25:14]

Zhenzhong Duan (1):
      i386/tdx: Fix the report of gpa in QAPI

 docs/devel/rust.rst                             |   11 +-
 docs/interop/firmware.json                      |   30 +-
 docs/system/i386/amd-memory-encryption.rst      |    2 +
 docs/system/igvm.rst                            |  173 ++++
 docs/system/index.rst                           |    1 +
 meson.build                                     |    8 +
 qapi/qom.json                                   |   17 +
 backends/igvm.h                                 |   22 +
 include/hw/i386/x86.h                           |    3 +
 include/qemu/log.h                              |    2 +
 include/system/confidential-guest-support.h     |   88 ++
 include/system/igvm-cfg.h                       |   49 +
 linux-headers/asm-x86/kvm.h                     |    8 +-
 linux-headers/linux/kvm.h                       |    4 +
 target/i386/cpu.h                               |   69 +-
 target/i386/host-cpu.h                          |    1 +
 target/i386/kvm/tdx.h                           |    7 +-
 target/i386/kvm/vmsr_energy.h                   |    1 -
 target/i386/sev.h                               |  124 +++
 backends/confidential-guest-support.c           |   43 +
 backends/igvm-cfg.c                             |   51 +
 backends/igvm.c                                 |  988 +++++++++++++++++++
 hw/i386/pc.c                                    |   17 +-
 hw/i386/pc_piix.c                               |   10 +
 hw/i386/pc_q35.c                                |   10 +
 hw/i386/pc_sysfw.c                              |   31 +-
 target/i386/cpu.c                               | 1145 +++++++++++++++++------
 target/i386/host-cpu.c                          |   44 +-
 target/i386/hvf/hvf-cpu.c                       |    5 +-
 target/i386/kvm/kvm-cpu.c                       |    9 +-
 target/i386/kvm/kvm.c                           |    5 +-
 target/i386/kvm/tdx-quote-generator.c           |    4 +-
 target/i386/kvm/tdx-stub.c                      |    4 +
 target/i386/kvm/tdx.c                           |   69 +-
 target/i386/kvm/vmsr_energy.c                   |    9 -
 target/i386/nvmm/nvmm-all.c                     |   25 +
 target/i386/sev.c                               |  854 +++++++++++++++--
 target/i386/whpx/whpx-all.c                     |   25 +
 util/log.c                                      |   12 +
 target/i386/tcg/decode-new.c.inc                |    4 +-
 backends/meson.build                            |    5 +
 meson_options.txt                               |    2 +
 qemu-options.hx                                 |   28 +
 rust/qemu-api-macros/meson.build                |    3 +
 rust/qemu-api-macros/src/bits.rs                |   58 +-
 rust/qemu-api-macros/src/lib.rs                 |   93 +-
 rust/qemu-api-macros/src/tests.rs               |  137 +++
 rust/qemu-api-macros/src/utils.rs               |   26 -
 rust/qemu-api/build.rs                          |   12 +-
 rust/qemu-api/src/bindings.rs                   |    1 +
 rust/qemu-api/src/log.rs                        |   92 +-
 scripts/meson-buildoptions.sh                   |    3 +
 target/i386/meson.build                         |    2 +
 tests/functional/test_x86_cpu_model_versions.py |  110 +--
 tests/vm/freebsd                                |    4 +-
 55 files changed, 3927 insertions(+), 633 deletions(-)
 create mode 100644 docs/system/igvm.rst
 create mode 100644 backends/igvm.h
 create mode 100644 include/system/igvm-cfg.h
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c
 create mode 100644 rust/qemu-api-macros/src/tests.rs
 delete mode 100644 rust/qemu-api-macros/src/utils.rs
-- 
2.50.0


