Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7AACAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYrs-0008HC-O9; Tue, 16 Sep 2025 12:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYrr-0008Fj-6x
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:49:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYrl-0006Q9-BM
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:49:22 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 04F7C20154ED;
 Tue, 16 Sep 2025 09:49:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04F7C20154ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041355;
 bh=MsYvYaG6IPmeEZ7uQjHqywRPxY5PH02KC5Rg/XDy06c=;
 h=From:To:Cc:Subject:Date:From;
 b=Eg7P4eogMiobR+dRKqHiA/nUKpEcJFCnNrvXmGdYzHh/jtFJ0NMjykgA/pVBeHXG/
 +O+eVHicErfX2LGGeEtSh1vpzVnjrbmKlm6DqHzJErfNIYwrg1T0SwaAJ5oreuN8ZP
 5a/YgX0FWWX4gKZLRSLoQLFw1wP2JzN88gvjN9uI=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Date: Tue, 16 Sep 2025 18:48:20 +0200
Message-Id: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
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

Hello all,

This is the fourth revision of a patch set implementing an accelerator
for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in
various scenarios. Thanks for the feedback to the previous revision, I
tried to incorporate those. The changes in the currenct patchset beyond
the suggested fixes are mostly related to the replacement of retired
ioctl calls that will not part of the upstreamed MSHV kernel driver.

Best regards,

magnus

Changelog:

v3 => v4

- Addressed code review comments
- Extended mention of MSHV accelerator in documentation
- Reworked the QMP `query-mshv` command to work like other accelerator's
  implementations (availability of the accelerator, instead of issueing
  stat() on /dev/mshv)
- Added a HMP `info mshv` command
- Replaced ioctls `MSHV_GET_VP_REGISTERS`, `MSHV_SET_VP_REGISTERS`,
  and `MSHV_TRANSLATE_GVA` with calls to `MSHV_ROOT_HVCALL`
- Allocate static pages in cpu->accel for the HVCALL input/output params
  (to avoid allocations in the MMIO exit path)

v2 => v3

- Addressed code review comments (style)
- Reserve GSI 01-23 for IO-APIC pins (this resolved a problem in which MSI
  routes would be overwritten with interrupts from legacy devices, breaking
  irqfd notification for virtio-blk queues)
- Guard memory slot table with mutex and RCU mechanism (multiple threads
  might access the memory slot table, and in the event of an UNMAPPED_GPA
  exit we need to query the table for an unmapped region covering that GPA)
- Include memory slot manager in MshvState
- Produce mshv.h kernel header with ./scripts/update-linux-headers.sh from
  linux 6.16 (not all UAPI definitions are defined in the upstream kernel,
  hence we ship hw/hyper/hvgdk*.h and hw/hyperv/hvhdk*.h headers)
- Added a QMP command query-mshv (a requirement for integration into
  higher-level tooling)
- Removed handling of HALT vm exit, since this is not a supported HV
  message any more.
- Added 2 maintainers from Microsoft for the respective file hierarchy
- Added mshv as accelerator option in the documentation

RFC (v1) => v2

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
- Added handler for HLT vm exits.
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

- A discrete kernel ioctl "set_immediate_exit" (to avoid a race condition
  when handling terminiation signals like ctrl-a x) has been tested and
  proven to mitigate the problem. Since other consumers of /dev/mshv have
  simular requirements as QEMU, we opted to iterate a bit more on the
  respective kernel interface.

Magnus Kulke (26):
  accel: Add Meson and config support for MSHV accelerator
  target/i386/emulate: Allow instruction decoding from stream
  target/i386/mshv: Add x86 decoder/emu implementation
  hw/intc: Generalize APIC helper names from kvm_* to accel_*
  include/hw/hyperv: Add MSHV ABI header definitions
  linux-headers/linux: Add mshv.h headers
  accel/mshv: Add accelerator skeleton
  accel/mshv: Register memory region listeners
  accel/mshv: Initialize VM partition
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
  accel/mshv: Handle overlapping mem mappings
  target/i386/mshv: Use preallocated page for hvcall
  docs: Add mshv to documentation
  MAINTAINERS: Add maintainers for mshv accelerator

Praveen K Paladugu (1):
  qapi/accel: Allow to query mshv capabilities

 MAINTAINERS                      |   15 +
 accel/Kconfig                    |    3 +
 accel/accel-irq.c                |  106 ++
 accel/meson.build                |    3 +-
 accel/mshv/irq.c                 |  397 +++++++
 accel/mshv/mem.c                 |  562 ++++++++++
 accel/mshv/meson.build           |    9 +
 accel/mshv/mshv-all.c            |  728 ++++++++++++
 accel/mshv/msr.c                 |  374 +++++++
 accel/mshv/trace-events          |   33 +
 accel/mshv/trace.h               |   14 +
 docs/about/build-platforms.rst   |    2 +-
 docs/devel/codebase.rst          |    2 +-
 docs/glossary.rst                |    6 +-
 docs/system/introduction.rst     |    3 +
 hmp-commands-info.hx             |   13 +
 hw/core/machine-hmp-cmds.c       |   15 +
 hw/core/machine-qmp-cmds.c       |   14 +
 hw/intc/apic.c                   |    8 +
 hw/intc/ioapic.c                 |   20 +-
 hw/virtio/virtio-pci.c           |   21 +-
 include/hw/hyperv/hvgdk.h        |   20 +
 include/hw/hyperv/hvgdk_mini.h   |  817 ++++++++++++++
 include/hw/hyperv/hvhdk.h        |  249 +++++
 include/hw/hyperv/hvhdk_mini.h   |  102 ++
 include/monitor/hmp.h            |    1 +
 include/system/accel-irq.h       |   37 +
 include/system/hw_accel.h        |    1 +
 include/system/mshv.h            |  196 ++++
 linux-headers/linux/mshv.h       |  291 +++++
 meson.build                      |   11 +
 meson_options.txt                |    2 +
 qapi/accelerator.json            |   29 +
 qemu-options.hx                  |   16 +-
 scripts/meson-buildoptions.sh    |    3 +
 scripts/update-linux-headers.sh  |    2 +-
 target/i386/cpu.h                |    4 +-
 target/i386/emulate/meson.build  |    7 +-
 target/i386/emulate/x86_decode.c |   27 +-
 target/i386/emulate/x86_decode.h |    9 +
 target/i386/emulate/x86_emu.c    |    3 +-
 target/i386/emulate/x86_emu.h    |    2 +
 target/i386/meson.build          |    2 +
 target/i386/mshv/meson.build     |    8 +
 target/i386/mshv/mshv-cpu.c      | 1764 ++++++++++++++++++++++++++++++
 target/i386/mshv/x86.c           |  297 +++++
 46 files changed, 6208 insertions(+), 40 deletions(-)
 create mode 100644 accel/accel-irq.c
 create mode 100644 accel/mshv/irq.c
 create mode 100644 accel/mshv/mem.c
 create mode 100644 accel/mshv/meson.build
 create mode 100644 accel/mshv/mshv-all.c
 create mode 100644 accel/mshv/msr.c
 create mode 100644 accel/mshv/trace-events
 create mode 100644 accel/mshv/trace.h
 create mode 100644 include/hw/hyperv/hvgdk.h
 create mode 100644 include/hw/hyperv/hvgdk_mini.h
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


