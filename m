Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DC1C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLBm-00081U-HW; Tue, 20 May 2025 07:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLBh-00080d-Aq
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:15 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLBe-000178-0y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:12 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2C7712067864;
 Tue, 20 May 2025 04:31:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C7712067864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740667;
 bh=0eWhcyGT2SZdhe1ztMyfEKgEFMQEciLPDh0RAorlKR4=;
 h=From:To:Cc:Subject:Date:From;
 b=OluYBvhHRAAvOxdtxnBYVM56IIH1hEA/m7swgfw4by+TccO82OYyLnVTEog3SRcnr
 N8QYdqut5wa1apvYm0ZBTxFLuqMqzmelm0wS11p6kBGNoHcUufJWgqAhZlJTxNLDfX
 BdTkVT7LpcE3l2ryCe6xcAjw7R7tc+n30YxAecls=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 00/25] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Date: Tue, 20 May 2025 13:29:53 +0200
Message-Id: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello all,

as previously announced here, we are working on an integration that will
expose the HyperV hypervisor to QEMU on Linux hosts. HyperV is a Type 1
hypervisor with a layered architecture that features a "root partition"
alongside VMs as "child partitions" that will interface with the
hypervisor and has access to the hardware. (https://aka.ms/hypervarch)

The effort to run Linux on such a Root Partition and expose HyperV to
such a management partition is called "MSHV". Sometimes we refer to the
root partition as "Dom0 Linux". Today we are targetting nested
virtualization, that is: the creation + management of L2 VMs on an L1
VM (L0 would indicate bare metal).

+-------------+ +----------------+ +--------------+
|             | |                | |              |
| Azure Host  | | L1 Linux Dom0  | | L2 Guest VM  |
|             | |                | |              |
|     OS      | |                | |              |
|             | | +------------+ | |              |
|             | | |  Qemu VMM  | | |              |
|             | | +------------+ | |              |
|             | | +------------+ | |              |
|             | | |   Kernel   | | |              |
|             | | +-----+------+ | |              |
|             | +-------|--------+ +--------------+
|             | +-------v-------------------------+
|             | |    Microsoft Hypervisor (L1)    |
+-------------+ +-------+-------------------------+
                        |
+-----------------------v-------------------------+
|            Microsoft Hypervisor (L0)            |
+-------------------------------------------------+

+-------------------------------------------------+
|                                                 |
|                    Hardware                     |
|                                                 |
+-------------------------------------------------+

This submission is a port of the existing MSHV integration that is
shipped in Cloud-Hypervisor and MSHV-specific rust-crates in rust-vmm.
There are various products like AKS Pod Sandboxing and AKS Confidential
Pods built on MSHV and Cloud-Hypervisor. We hope to achieve a seamless
integration into the QEMU accelerator framework, similar to existing
integrations like KVM, HVF or WHPX.

The patch set has been split into chunks that should be applicable and
buildable individually, but only the full set of commits will allow
launching MSHV-accelerated guests on supported kernels and environments.

The toggle to enable the feature at build time would be: `./configure
--enable-mshv`.

When launching a VM, the accelerator `mshv` can be enabled via

`-accel mshv` or `-machine q35,accel=mshv`.

We concluded the porting, but we haven't performed any comprehensive
testing yet. We opted to send our submission early to receive feedback
about the general structure and potential problems of our integration.
Most likely we will uncover problems during testing and address those in
upcoming revisions of the patch set.

The configuration we are using during development:

machine q35 + OVMF + various recent linux distros as guests (fedora
42, ubuntu 22.04)

We would welcome any feedback around the structure and integration
points that we chose, so we can incorporate them into upcoming
revisions.

Some notes/caveats about the initial submission:

- The relevant MSHV kernel code has been accepted for inclusion in the
  upcoming 6.15 release, which should be released shortly. To allow
  building it on older kernel we vendored the kernel headers that define
  the MSHV ABI into the patch set. We might remove it in later
  revisions of the patch set, or put it behind a feature toggle. Once
  the kernel is released we plan to published a preconfigured Azure
  image, which can be used to test the MSHV accelerator.

- QEMU is mapping regions into the guest that might partially overlap in
  their userspace_addr range (e.g. for ROMs in early boot). Currently
  MSHV will reject such overlaps. We are looking into whether we
  can/want to relax that restriction. To work around this we maintain a
  list of mapping references and swap in/out regions if there's a GPA
  fault and we find a valid candidate region in our list. (see last
  commit). Maybe there are alternative, less invasive, suggestions. We'd
  be happy to hear those.

- We noticed that when using SeaBIOS, in certain permutations of guest
  configuration (> 2GB ram & >1 virtio-blk-pci devices), we run into
  unmapped GPA errors. We suspect it has to do with SeaBIOS addressing
  memory in the 4GB+ region in those cases. We are investigating, and
  will hopefully be able to issue a fix soon. For the time being this
  can be worked around by using OVMF as firmware:

- Since the MHSV accelerator requires a HyperV hypervisor to be present,
  it would make sense to provide testing infrastructure for integration
  testing on Azure. We are looking into options how to implement that.

best,

magnus

Magnus Kulke (25):
  accel: Add Meson and config support for MSHV accelerator
  target/i386/emulate: allow instruction decoding from stream
  target/i386/mshv: Add x86 decoder/emu implementation
  hw/intc: Generalize APIC helper names from kvm_* to accel_*
  include/hw/hyperv: Add MSHV ABI header definitions
  accel/mshv: Add accelerator skeleton
  accel/mshv: Register memory region listeners
  accel/mshv: Initialize VM partition
  accel/mshv: Register guest memory regions with hypervisor
  accel/mshv: Add ioeventfd support
  accel/mshv: Add basic interrupt injection support
  accel/mshv: Add vCPU creation and execution loop
  accel/mshv: Add vCPU signal handling
  target/i386/mshv: Add CPU create and remove logic
  target/i386/mshv: Implement mshv_store_regs()
  target/i386/mshv: Implement mshv_get_standard_regs()
  target/i386/mshv: Implement mshv_get_special_regs()
  target/i386/mshv: Implement mshv_arch_put_registers()
  target/i386/mshv: Set local interrupt controller state
  target/i386/mshv: Register CPUID entries with MSHV
  target/i386/mshv: Register MSRs with MSHV
  target/i386/mshv: Integrate x86 instruction decoder/emulator
  target/i386/mshv: Write MSRs to the hypervisor
  target/i386/mshv: Implement mshv_vcpu_run()
  accel/mshv: Add memory remapping workaround

 accel/Kconfig                    |    3 +
 accel/accel-irq.c                |   95 ++
 accel/meson.build                |    3 +-
 accel/mshv/irq.c                 |  370 +++++++
 accel/mshv/mem.c                 |  434 ++++++++
 accel/mshv/meson.build           |    9 +
 accel/mshv/mshv-all.c            |  731 ++++++++++++
 accel/mshv/msr.c                 |  375 +++++++
 accel/mshv/trace-events          |   20 +
 accel/mshv/trace.h               |    1 +
 hw/intc/apic.c                   |    9 +
 hw/intc/ioapic.c                 |   20 +-
 hw/virtio/virtio-pci.c           |   19 +-
 include/hw/hyperv/hvgdk.h        |   20 +
 include/hw/hyperv/hvhdk.h        |  165 +++
 include/hw/hyperv/hvhdk_mini.h   |  106 ++
 include/hw/hyperv/linux-mshv.h   | 1038 ++++++++++++++++++
 include/system/accel-irq.h       |   26 +
 include/system/mshv.h            |  237 ++++
 meson.build                      |   17 +
 meson_options.txt                |    2 +
 scripts/meson-buildoptions.sh    |    3 +
 target/i386/cpu.h                |    2 +-
 target/i386/emulate/meson.build  |    7 +-
 target/i386/emulate/x86_decode.c |   32 +-
 target/i386/emulate/x86_decode.h |   11 +
 target/i386/emulate/x86_emu.c    |    3 +-
 target/i386/emulate/x86_emu.h    |    1 +
 target/i386/meson.build          |    2 +
 target/i386/mshv/meson.build     |    8 +
 target/i386/mshv/mshv-cpu.c      | 1768 ++++++++++++++++++++++++++++++
 target/i386/mshv/x86.c           |  330 ++++++
 32 files changed, 5841 insertions(+), 26 deletions(-)
 create mode 100644 accel/accel-irq.c
 create mode 100644 accel/mshv/irq.c
 create mode 100644 accel/mshv/mem.c
 create mode 100644 accel/mshv/meson.build
 create mode 100644 accel/mshv/mshv-all.c
 create mode 100644 accel/mshv/msr.c
 create mode 100644 accel/mshv/trace-events
 create mode 100644 accel/mshv/trace.h
 create mode 100644 include/hw/hyperv/hvgdk.h
 create mode 100644 include/hw/hyperv/hvhdk.h
 create mode 100644 include/hw/hyperv/hvhdk_mini.h
 create mode 100644 include/hw/hyperv/linux-mshv.h
 create mode 100644 include/system/accel-irq.h
 create mode 100644 include/system/mshv.h
 create mode 100644 target/i386/mshv/meson.build
 create mode 100644 target/i386/mshv/mshv-cpu.c
 create mode 100644 target/i386/mshv/x86.c

-- 
2.34.1


