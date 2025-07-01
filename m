Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769D5C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWen8-0002Pw-Kt; Tue, 01 Jul 2025 13:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWen7-0002On-2E
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:09 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWen1-0006R2-Jw
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:07 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id AAB4920415BD;
 Tue,  1 Jul 2025 10:28:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAB4920415BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751390942;
 bh=BfGNjaPbLXQC4E1juiq724yLDptvY78mIT0tFav6nkc=;
 h=From:To:Cc:Subject:Date:From;
 b=qE2V/XbqQpKgN9XGuawreqLwyLRZ+ogCV1yOF8LCUqeMoMZWGUncHiRnZyIPg7Zlc
 7IeouMxmzpFkDbGJLeSzGUsTSWiP1b3p9VzeFCnHOGreGy99ofboRHMoH8sMkiVNpH
 955N1HZME8pO5TD1BLalrhOBSTUCS/oTp035X9t8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Date: Tue,  1 Jul 2025 19:28:07 +0200
Message-Id: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hey all,

This is the second revision of an accelerator implemented for the MSHV
kernel driver, exposing HyperV to Linux "Dom0" hosts. Thanks for the
helpful and quick feedback on the RFC patch. I attempted to address all
comments and we worked on fixing some of the limitation that we
identified in internal testing.

Best,

Magnus

Changelog:

v1 (RFC) => v2

- Addressed code review comments (style, consilidation).
- Rewrote the logic that handles overlap-in-userspace mappings to use
  a static list of slots, inspired by the HVF accelerator code.
- Fixed a bug that wrote corrupt payload in a MSHV_SET_MSI_ROUTING
  call, preventing vhost=on to work on tap network devices.
- Removed an erronous truncation of guest addresses to 32bit when
  registering ioeventfd's using MSHV_IOEVENTFD. This resulted in
  shadowing of low memory when ioevents were registered with
  addresses beyond the 4gb barrier and thus unexpected "unmapped gpa"
  vm exits in lower mem regions (impacting io performance).
- Fixed problem in which the MSI routing table was committed for KVM
  KVM instead of MSHV in virtio-pci bus initialization.
- Added some "mshv" strings to the documentation.
- The above fixes removed a few limitation present in the previous
  revision:
  - Guest with machine type "pc" are booting (testing is still mostly
    performed with q35)
  - Tap network devices can be used with vhost=on option.
  - Seabios can be used with >2.75G memory and multiple virtio-pci
    devices
  - I/O performance improvement as extranous MMIO vm exits are avoided
    by registering ioevents with a correct address.

Notes:

- Changes to the mshv kernel driver that would allow to map regions of
  userspace multiple times into the guest are still being discussed.
  For now commit #26 will work around this limitation.
- A kernel ioctl "set_immediate_exit" will be added to the mshv driver
  to avoid a race condition when handling signals (like ctrl-a x).

Magnus Kulke (27):
  accel: Add Meson and config support for MSHV accelerator
  target/i386/emulate: Allow instruction decoding from stream
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
  target/i386/mshv: Handle HVMSG_X64_HALT vm exit
  accel/mshv: Workaround for overlappig mem mappings
  docs: Add mshv to documentation

 accel/Kconfig                    |    3 +
 accel/accel-irq.c                |   95 ++
 accel/meson.build                |    3 +-
 accel/mshv/irq.c                 |  369 +++++++
 accel/mshv/mem.c                 |  415 ++++++++
 accel/mshv/meson.build           |    9 +
 accel/mshv/mshv-all.c            |  727 +++++++++++++
 accel/mshv/msr.c                 |  372 +++++++
 accel/mshv/trace-events          |   29 +
 accel/mshv/trace.h               |    1 +
 docs/devel/codebase.rst          |    2 +-
 hw/intc/apic.c                   |    9 +
 hw/intc/ioapic.c                 |   20 +-
 hw/virtio/virtio-pci.c           |   21 +-
 include/hw/hyperv/hvgdk.h        |   19 +
 include/hw/hyperv/hvhdk.h        |  164 +++
 include/hw/hyperv/hvhdk_mini.h   |  105 ++
 include/system/accel-irq.h       |   26 +
 include/system/mshv.h            |  184 ++++
 linux-headers/linux/mshv.h       | 1038 ++++++++++++++++++
 meson.build                      |   11 +
 meson_options.txt                |    2 +
 qemu-options.hx                  |   16 +-
 scripts/meson-buildoptions.sh    |    3 +
 scripts/update-linux-headers.sh  |    2 +-
 target/i386/cpu.h                |    4 +-
 target/i386/emulate/meson.build  |    7 +-
 target/i386/emulate/x86_decode.c |   31 +-
 target/i386/emulate/x86_decode.h |   10 +
 target/i386/emulate/x86_emu.c    |    3 +-
 target/i386/emulate/x86_emu.h    |    1 +
 target/i386/meson.build          |    2 +
 target/i386/mshv/meson.build     |    8 +
 target/i386/mshv/mshv-cpu.c      | 1699 ++++++++++++++++++++++++++++++
 target/i386/mshv/x86.c           |  297 ++++++
 35 files changed, 5671 insertions(+), 36 deletions(-)
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
 create mode 100644 include/system/accel-irq.h
 create mode 100644 include/system/mshv.h
 create mode 100644 linux-headers/linux/mshv.h
 create mode 100644 target/i386/mshv/meson.build
 create mode 100644 target/i386/mshv/mshv-cpu.c
 create mode 100644 target/i386/mshv/x86.c

-- 
2.34.1


