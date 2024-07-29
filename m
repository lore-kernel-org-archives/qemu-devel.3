Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16EAC49EA1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQJi-0005oo-3h; Mon, 29 Jul 2024 09:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJg-0005if-Gw; Mon, 29 Jul 2024 09:21:32 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJd-00028y-18; Mon, 29 Jul 2024 09:21:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2AD32CE0B2E;
 Mon, 29 Jul 2024 13:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FCFC4AF0A;
 Mon, 29 Jul 2024 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722259281;
 bh=1iqK1SFXtBhAzIWotBWi74mTSYu56GHQ8sY3BTgSCAI=;
 h=From:To:Cc:Subject:Date:From;
 b=rze78+Fedp3IILwyy9H8q3eTWuiXgU7X3G9nPO7X/RTUP+isEjFqzg7VOv0k+7oKG
 bPv1yghSo4gtk5cJt8zVh5WhcQouUvMpa94tC2iBFmToGoyZjDr0Oq7zjDNFb6sE/l
 iTUzmimB4pZs20cdRVwmUbex4IAEyg/DHoZPkJjbq7gERP7qCZ+E/hl4jkOBm6w2Rz
 i/rKuJ19G87+xHnihrJ/tolZlcTvWOKguyQoy7T4QJMzzqzdvZ3ZDF4hUA5tWXcen1
 gmCIECws9fdlMS1njBzNaG/txKcJkkAaIwd4e2AT9cyAPlUj5BnXs2Esd1hZLSRhzG
 qtJ6Flx0s9b8w==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJT-000000030VQ-08ej; Mon, 29 Jul 2024 15:21:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] Add ACPI CPER firmware first error injection for Arm
 Processor
Date: Mon, 29 Jul 2024 15:21:04 +0200
Message-ID: <cover.1722259246.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Testing OS kernel ACPI APEI CPER support is tricky, as one depends on
having hardware with special-purpose BIOS and/or hardware.

With QEMU, it becomes a lot easier, as it can be done via QMP.

This series add support for ARM Processor CPER error injection,
according with ACPI 6.x and UEFI 2.9A/2.10 specs.

This series consists of:

- one patch using a define for ARM virt GPIO power pin
  (requested during last review);
- three patches from Jonathan (one coauthored with Shiju) with basic
  EINJ features, already submitted as RFC (but not merged yet) at:
    https://lore.kernel.org/qemu-devel/20240628090605.529-1-shiju.jose@huawei.com/
- three patches from me extending it to optionally allow to
  generate all sorts of possible valid combinations for
  ARM Processor CPER record.

I've been using it to test a Linux Kernel patch series fixing
UEFI 2.9A errata and ARM processor trace event:
   https://lore.kernel.org/linux-edac/3853853f820a666253ca8ed6c7c724dc3d50044a.1720679234.git.mchehab+huawei@kernel.org/T/#t

I also wrote some Wiki pages for rasdaemon (a Linux daemon
widely used to monitor and react to RAS events):
   https://github.com/mchehab/rasdaemon/wiki/error-injection

Being really helpful to test the Linux Kernel behavior when
firmware-first RAS events for ARM processor arrives there,
helping to validate how CPER and GHES driver handles them
(and further testing userspace apps like rasdaemon):

Sending this command to QMP:
    { "execute": "qmp_capabilities" } 
    { "execute": "arm-inject-error", "arguments": {"error": [{"type": ["cache-error"]}]} }

Produces a simple CPER register, properly handled by the Linux
Kernel:

[  839.952678] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[  839.953145] {4}[Hardware Error]: event severity: recoverable
[  839.953451] {4}[Hardware Error]:  Error 0, type: recoverable
[  839.953763] {4}[Hardware Error]:   section_type: ARM processor error
[  839.954094] {4}[Hardware Error]:   MIDR: 0x0000000000000000
[  839.954383] {4}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
[  839.954802] {4}[Hardware Error]:   running state: 0x0
[  839.955066] {4}[Hardware Error]:   Power State Coordination Interface state: 0
[  839.955424] {4}[Hardware Error]:   Error info structure 0:
[  839.955712] {4}[Hardware Error]:   num errors: 1
[  839.955983] {4}[Hardware Error]:    first error captured
[  839.956260] {4}[Hardware Error]:    propagated error captured
[  839.956561] {4}[Hardware Error]:    error_type: 0x02: cache error
[  839.956882] {4}[Hardware Error]:    error_info: 0x000000000054007f
[  839.957192] {4}[Hardware Error]:     transaction type: Instruction
[  839.957495] {4}[Hardware Error]:     cache error, operation type: Instruction fetch
[  839.957888] {4}[Hardware Error]:     cache level: 1
[  839.958166] {4}[Hardware Error]:     processor context not corrupted
[  839.958459] {4}[Hardware Error]:     the error has not been corrected
[  839.958771] {4}[Hardware Error]:     PC is imprecise
[  839.959074] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error

rasdaemon output (rasdaemon still needs to be patched for
UEFI 2.9A errata):

           <...>-211   [002] d..1.     0.000129 arm_event 2024-07-11 09:50:45 +0000 affinity: -1 MPIDR: 0x80000000 MIDR: 0x0 running_state: 0 psci_state: 0 ARM Processor Err Info data len: 32
<CANT FIND FIELD buf>cpu: 0; error: 2; affinity level: 255; MPIDR: 0000000080000000; MIDR: 0000000000000000; running state: 0; PSCI state: 0; ARM Processor Err Info data len: 32; ARM Processor Err Info raw data: 00 20 06 00 02 00 00 05 7f 00 54 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00; ARM Processor Err Context Info data len: 0; ARM Processor Err Context Info raw data: ; Vendor Specific Err Info data len: 0; Vendor Specific Err Info raw data: 

More complex events with multiple Processor Error Information structures
can be produced like:

    { "execute": "arm-inject-error", "arguments":  {
        "validation": ["mpidr-valid", "affinity-valid", "running-state-valid", "vendor-specific-valid"],
        "running-state": [], "psci-state": 1229279264, 
        "error": [{
            "validation": ["multiple-error-valid", "flags-valid"], 
	"type": ["tlb-error", "bus-error", "micro-arch-error"], 
                               "multiple-error": 3, "phy-addr": 57005, "virt-addr": 48879},
                 {"type": ["micro-arch-error"]}, 
                 {"type": ["tlb-error"]}, 
                 {"type": ["bus-error"]},
                 {"type": ["cache-error"]}],
                 "context": [{"register": [57005, 48879, 43962, 47787]}],
                 "vendor-specific": [12, 23, 53, 52, 3, 123, 243, 255]} }

[  925.340284] {5}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[  925.340662] {5}[Hardware Error]: event severity: recoverable
[  925.340924] {5}[Hardware Error]:  Error 0, type: recoverable
[  925.341280] {5}[Hardware Error]:   section_type: ARM processor error
[  925.341631] {5}[Hardware Error]:   MIDR: 0x0000000000000000
[  925.341893] {5}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
[  925.342278] {5}[Hardware Error]:   error affinity level: 0
[  925.342571] {5}[Hardware Error]:   running state: 0x0
[  925.342835] {5}[Hardware Error]:   Power State Coordination Interface state: 1229279264
[  925.343157] {5}[Hardware Error]:   Error info structure 0:
[  925.343388] {5}[Hardware Error]:   num errors: 4
[  925.343602] {5}[Hardware Error]:    error_type: 0x1c: TLB error|bus error|micro-architectural error
[  925.343960] {5}[Hardware Error]:    virtual fault address: 0x000000000000beef
[  925.344241] {5}[Hardware Error]:    physical fault address: 0x000000000000dead
[  925.344526] {5}[Hardware Error]:   Error info structure 1:
[  925.344757] {5}[Hardware Error]:   num errors: 1
[  925.344965] {5}[Hardware Error]:    first error captured
[  925.345183] {5}[Hardware Error]:    propagated error captured
[  925.345416] {5}[Hardware Error]:    error_type: 0x10: micro-architectural error
[  925.345714] {5}[Hardware Error]:   Error info structure 2:
[  925.345946] {5}[Hardware Error]:   num errors: 1
[  925.346148] {5}[Hardware Error]:    first error captured
[  925.346413] {5}[Hardware Error]:    propagated error captured
[  925.346719] {5}[Hardware Error]:    error_type: 0x04: TLB error
[  925.346988] {5}[Hardware Error]:    error_info: 0x00000080d6460fff
[  925.347248] {5}[Hardware Error]:     transaction type: Generic
[  925.347492] {5}[Hardware Error]:     TLB error, operation type: Generic read (type of instruction or data request cannot be determined)
[  925.347945] {5}[Hardware Error]:     TLB level: 1
[  925.348153] {5}[Hardware Error]:     processor context corrupted
[  925.348392] {5}[Hardware Error]:     the error has been corrected
[  925.348635] {5}[Hardware Error]:     PC is imprecise
[  925.348848] {5}[Hardware Error]:     Program execution can be restarted reliably at the PC associated with the error.
[  925.349232] {5}[Hardware Error]:   Error info structure 3:
[  925.349459] {5}[Hardware Error]:   num errors: 1
[  925.349662] {5}[Hardware Error]:    first error captured
[  925.349884] {5}[Hardware Error]:    propagated error captured
[  925.350115] {5}[Hardware Error]:    error_type: 0x08: bus error
[  925.350371] {5}[Hardware Error]:    error_info: 0x0000000078da03ff
[  925.350629] {5}[Hardware Error]:     transaction type: Generic
[  925.350878] {5}[Hardware Error]:     bus error, operation type: Prefetch
[  925.351144] {5}[Hardware Error]:     affinity level at which the bus error occurred: 3
[  925.351451] {5}[Hardware Error]:     processor context not corrupted
[  925.351702] {5}[Hardware Error]:     the error has not been corrected
[  925.351960] {5}[Hardware Error]:     PC is precise
[  925.352164] {5}[Hardware Error]:     Program execution can be restarted reliably at the PC associated with the error.
[  925.352546] {5}[Hardware Error]:     participation type: Generic
[  925.352801] {5}[Hardware Error]:     address space: External Memory Access
[  925.353071] {5}[Hardware Error]:   Error info structure 4:
[  925.353299] {5}[Hardware Error]:   num errors: 1
[  925.353502] {5}[Hardware Error]:    first error captured
[  925.353720] {5}[Hardware Error]:    propagated error captured
[  925.353963] {5}[Hardware Error]:    error_type: 0x02: cache error
[  925.354222] {5}[Hardware Error]:    error_info: 0x000000000054007f
[  925.354478] {5}[Hardware Error]:     transaction type: Instruction
[  925.354782] {5}[Hardware Error]:     cache error, operation type: Instruction fetch
[  925.355203] {5}[Hardware Error]:     cache level: 1
[  925.355495] {5}[Hardware Error]:     processor context not corrupted
[  925.355848] {5}[Hardware Error]:     the error has not been corrected
[  925.356206] {5}[Hardware Error]:     PC is imprecise
[  925.356493] {5}[Hardware Error]:   Context info structure 0:
[  925.356809] {5}[Hardware Error]:    register context type: AArch64 EL1 context registers
[  925.357282] {5}[Hardware Error]:    00000000: 0000dead 00000000 0000beef 00000000
[  925.357800] {5}[Hardware Error]:    00000010: 0000abba 00000000 0000baab 00000000
[  925.358267] {5}[Hardware Error]:    00000020: 00000000 00000000
[  925.358523] {5}[Hardware Error]:   Vendor specific error info has 8 bytes:
[  925.358822] {5}[Hardware Error]:    00000000: 3435170c fff37b03                    ..54.{..
[  925.359192] [Firmware Warn]: GHES: Unhandled processor error type 0x1c: TLB error|bus error|micro-architectural error
[  925.359590] [Firmware Warn]: GHES: Unhandled processor error type 0x10: micro-architectural error
[  925.359935] [Firmware Warn]: GHES: Unhandled processor error type 0x04: TLB error
[  925.360235] [Firmware Warn]: GHES: Unhandled processor error type 0x08: bus error
[  925.360534] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error

---

v4:
- patches 4 and 7 folded;
- Several improvements at QAPI documentation: now, both man-page and html
  outputs look nicer and have tables to better define some fields;
- QAPI updates are now changed to QEMU version 9.2 and upper;
- Minor coding style improvements;
- added a MAINTAINERS entry for arm error inject;
- Generic Error Device notify callback renamed to generic_error_device_notify();
- GED patch description fixed;
- running_state/psci logic fixed.

v3:
- patch 1 cleanups with some comment changes and adding another place where
  the poweroff GPIO define should be used. No changes on other patches (except
  due to conflict resolution).

v2:
- added a new patch using a define for GPIO power pin;
- patch 2 changed to also use a define for generic error GPIO pin;
- a couple cleanups at patch 2 removing uneeded else clauses.

Jonathan Cameron (2):
  arm/virt: Wire up GPIO error source for ACPI / GHES
  acpi/ghes: Support GPIO error source.

Mauro Carvalho Chehab (4):
  arm/virt: place power button pin number on a define
  target/arm: preserve mpidr value
  acpi/ghes: update comments to point to newer ACPI specs
  acpi/ghes: Add a logic to inject ARM processor CPER

 MAINTAINERS                         |   7 +
 configs/targets/aarch64-softmmu.mak |   1 +
 hw/acpi/ghes.c                      | 339 +++++++++++++++++++---
 hw/arm/Kconfig                      |   4 +
 hw/arm/arm_error_inject.c           | 420 ++++++++++++++++++++++++++++
 hw/arm/arm_error_inject_stubs.c     |  34 +++
 hw/arm/meson.build                  |   3 +
 hw/arm/virt-acpi-build.c            |  34 ++-
 hw/arm/virt.c                       |  21 +-
 include/hw/acpi/ghes.h              |  41 +++
 include/hw/arm/virt.h               |   4 +
 include/hw/boards.h                 |   1 +
 qapi/arm-error-inject.json          | 284 +++++++++++++++++++
 qapi/meson.build                    |   1 +
 qapi/qapi-schema.json               |   1 +
 target/arm/cpu.h                    |   1 +
 target/arm/helper.c                 |  10 +-
 17 files changed, 1160 insertions(+), 46 deletions(-)
 create mode 100644 hw/arm/arm_error_inject.c
 create mode 100644 hw/arm/arm_error_inject_stubs.c
 create mode 100644 qapi/arm-error-inject.json

-- 
2.45.2



