Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41E6C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2EJ-0000Ya-0R; Thu, 08 Aug 2024 08:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2EE-0000Bf-Qw; Thu, 08 Aug 2024 08:26:52 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2E9-0005xO-Bt; Thu, 08 Aug 2024 08:26:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9EA1E615DD;
 Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C10C4AF0C;
 Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723120003;
 bh=ZOxDxxTAY5bHcgYcs4XI5591I7f113rMY6ajTI12ouQ=;
 h=From:To:Cc:Subject:Date:From;
 b=SGNpItAxANKAuE/4pD2apfR93PB7VqLsQj5gyXyF3Rl5YafQcROTkK3O9ZVD4LJm5
 MI1CaDmxNU2XIKh1xo6H96LQFy2EBzLOXeJfOQCNnbOPtAXKskyAT+XkSjWVD7LC54
 vlNkow+Vrd7OEkEDVI0PtN9qw+503jjymolAPSX2FgRSXleyzQTEdUUkpJg3FEinm5
 IjP6v7zIKlsCA7eG23wPyeF/9QrK8mKJjx5tY0MlGJoEZphrwrOVJh2grn/HH0yN+I
 5lrKTw5IkKBP0f+rRw09BgHRBiTEj8ymCDMiUfEt6k4+Xr3BXcHkRzYguvZc9IDiWp
 VFf4+71ILO8/g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2E4-00000000oD9-3O1z; Thu, 08 Aug 2024 14:26:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 00/10] Add ACPI CPER firmware first error injection on ARM
 emulation
Date: Thu,  8 Aug 2024 14:26:26 +0200
Message-ID: <cover.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

This series add support for injecting CPER records on ARM emulation.

The QEMU side changes add a QAPI able to do CPER error injection
on ARM, with a raw data parameter, making it very flexible.

A script is provided at the final patch implementing support for
ARM Processor CPER error injection according with ACPI 6.x and 
UEFI 2.9A/2.10 specs, via QMP.

Injecting such errors can be done using the provided script:

	$ ./scripts/ghes_inject.py arm 
	Error injected.

Produces a simple CPER register, properly handled by the Linux
Kernel:

[  794.983753] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[  794.984150] {4}[Hardware Error]: event severity: recoverable
[  794.984391] {4}[Hardware Error]:  Error 0, type: recoverable
[  794.984652] {4}[Hardware Error]:   section_type: ARM processor error
[  794.984926] {4}[Hardware Error]:   MIDR: 0x0000000000000000
[  794.985184] {4}[Hardware Error]:   running state: 0x0
[  794.985411] {4}[Hardware Error]:   Power State Coordination Interface state: 0
[  794.985720] {4}[Hardware Error]:   Error info structure 0:
[  794.985960] {4}[Hardware Error]:   num errors: 2
[  794.986175] {4}[Hardware Error]:    error_type: 0x02: cache error
[  794.986442] {4}[Hardware Error]:    error_info: 0x000000000091000f
[  794.986755] {4}[Hardware Error]:     transaction type: Data Access
[  794.987027] {4}[Hardware Error]:     cache error, operation type: Data write
[  794.987310] {4}[Hardware Error]:     cache level: 2
[  794.987529] {4}[Hardware Error]:     processor context not corrupted
[  794.987867] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error

More complex use cases can be done, like:

	$ ./scripts/ghes_inject.py arm --mpidr 0x444 --running --affinity 1 \
	  --error-info 12345678 --vendor 0x13,123,4,5,1 --ctx-array 0,1,2,3,4,5 \
	  -t cache tlb bus micro-arch tlb,micro-arch
	Error injected.

[  899.181246] {5}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[  899.181769] {5}[Hardware Error]: event severity: recoverable
[  899.182069] {5}[Hardware Error]:  Error 0, type: recoverable
[  899.182370] {5}[Hardware Error]:   section_type: ARM processor error
[  899.182689] {5}[Hardware Error]:   MIDR: 0x0000000000000000
[  899.182980] {5}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000000000000
[  899.183395] {5}[Hardware Error]:   error affinity level: 0
[  899.183683] {5}[Hardware Error]:   running state: 0x1
[  899.183962] {5}[Hardware Error]:   Power State Coordination Interface state: 0
[  899.184332] {5}[Hardware Error]:   Error info structure 0:
[  899.184610] {5}[Hardware Error]:   num errors: 2
[  899.184864] {5}[Hardware Error]:    error_type: 0x02: cache error
[  899.185181] {5}[Hardware Error]:    error_info: 0x0000000000bc614e
[  899.185504] {5}[Hardware Error]:     cache level: 2
[  899.185771] {5}[Hardware Error]:     processor context not corrupted
[  899.186082] {5}[Hardware Error]:   Error info structure 1:
[  899.186366] {5}[Hardware Error]:   num errors: 2
[  899.186613] {5}[Hardware Error]:    error_type: 0x04: TLB error
[  899.186929] {5}[Hardware Error]:    error_info: 0x000000000054007f
[  899.187236] {5}[Hardware Error]:     transaction type: Instruction
[  899.187588] {5}[Hardware Error]:     TLB error, operation type: Instruction fetch
[  899.187962] {5}[Hardware Error]:     TLB level: 1
[  899.188209] {5}[Hardware Error]:     processor context not corrupted
[  899.188535] {5}[Hardware Error]:     the error has not been corrected
[  899.188853] {5}[Hardware Error]:     PC is imprecise
[  899.189114] {5}[Hardware Error]:   Error info structure 2:
[  899.189404] {5}[Hardware Error]:   num errors: 2
[  899.189653] {5}[Hardware Error]:    error_type: 0x08: bus error
[  899.189967] {5}[Hardware Error]:    error_info: 0x00000080d6460fff
[  899.190293] {5}[Hardware Error]:     transaction type: Generic
[  899.190611] {5}[Hardware Error]:     bus error, operation type: Generic read (type of instruction or data request cannot be determined)
[  899.191174] {5}[Hardware Error]:     affinity level at which the bus error occurred: 1
[  899.191563] {5}[Hardware Error]:     processor context corrupted
[  899.191872] {5}[Hardware Error]:     the error has been corrected
[  899.192185] {5}[Hardware Error]:     PC is imprecise
[  899.192445] {5}[Hardware Error]:     Program execution can be restarted reliably at the PC associated with the error.
[  899.192939] {5}[Hardware Error]:     participation type: Local processor observed
[  899.193324] {5}[Hardware Error]:     request timed out
[  899.193596] {5}[Hardware Error]:     address space: External Memory Access
[  899.193945] {5}[Hardware Error]:     memory access attributes:0x20
[  899.194273] {5}[Hardware Error]:     access mode: secure
[  899.194544] {5}[Hardware Error]:   Error info structure 3:
[  899.194838] {5}[Hardware Error]:   num errors: 2
[  899.195088] {5}[Hardware Error]:    error_type: 0x10: micro-architectural error
[  899.195456] {5}[Hardware Error]:    error_info: 0x0000000078da03ff
[  899.195782] {5}[Hardware Error]:   Error info structure 4:
[  899.196070] {5}[Hardware Error]:   num errors: 2
[  899.196331] {5}[Hardware Error]:    error_type: 0x14: TLB error|micro-architectural error
[  899.196733] {5}[Hardware Error]:   Context info structure 0:
[  899.197024] {5}[Hardware Error]:    register context type: AArch64 EL1 context registers
[  899.197427] {5}[Hardware Error]:    00000000: 00000000 00000000
[  899.197741] {5}[Hardware Error]:   Vendor specific error info has 5 bytes:
[  899.198096] {5}[Hardware Error]:    00000000: 13 7b 04 05 01                                   .{...
[  899.198610] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
[  899.199000] [Firmware Warn]: GHES: Unhandled processor error type 0x04: TLB error
[  899.199388] [Firmware Warn]: GHES: Unhandled processor error type 0x08: bus error
[  899.199767] [Firmware Warn]: GHES: Unhandled processor error type 0x10: micro-architectural error
[  899.200194] [Firmware Warn]: GHES: Unhandled processor error type 0x14: TLB error|micro-architectural error

---

v6:
- PNP0C33 device creation moved to aml-build.c;
- acpi_ghes record functions now use ACPI notify parameter,
  instead of source ID;
- the number of source IDs is now automatically calculated;
- some code cleanups and function/var renames;
- some fixes and cleanups at the error injection script;
- ghes cper stub now produces an error if cper JSON is not compiled;
- Offset calculation logic for GHES was refactored;
- Updated documentation to reflect the GHES allocated size;
- Added a x-mpidr object for QOM usage;
- Added a patch making usage of x-mpidr field at ARM injection
  script;

v5:
- CPER guid is now passing as string;
- raw-data is now passed with base64 encode;
- Removed several GPIO left-overs from arm/virt.c changes;
- Lots of cleanups and improvements at the error injection script.
  It now better handles QMP dialog and doesn't print debug messages.
  Also, code was split on two modules, to make easier to add more
  error injection commands.

v4:
- CPER generation moved to happen outside QEMU;
- One patch adding support for mpidr query was removed.

v3:
- patch 1 cleanups with some comment changes and adding another place where
  the poweroff GPIO define should be used. No changes on other patches (except
  due to conflict resolution).

v2:
- added a new patch using a define for GPIO power pin;
- patch 2 changed to also use a define for generic error GPIO pin;
- a couple cleanups at patch 2 removing uneeded else clauses.



Jonathan Cameron (1):
  acpi/ghes: Add support for GED error device

Mauro Carvalho Chehab (9):
  acpi/generic_event_device: add an APEI error device
  arm/virt: Wire up a GED error device for ACPI / GHES
  qapi/ghes-cper: add an interface to do generic CPER error injection
  acpi/ghes: rework the logic to handle HEST source ID
  acpi/ghes: add support for generic error injection via QAPI
  docs: acpi_hest_ghes: fix documentation for CPER size
  scripts/ghes_inject: add a script to generate GHES error inject
  target/arm: add an experimental mpidr arm cpu property object
  scripts/arm_processor_error.py: retrieve mpidr if not filled

 MAINTAINERS                            |  10 +
 docs/specs/acpi_hest_ghes.rst          |   6 +-
 hw/acpi/Kconfig                        |   5 +
 hw/acpi/aml-build.c                    |  10 +
 hw/acpi/generic_event_device.c         |   8 +
 hw/acpi/ghes-stub.c                    |   3 +-
 hw/acpi/ghes.c                         | 308 ++++++++++++++----
 hw/acpi/ghes_cper.c                    |  45 +++
 hw/acpi/ghes_cper_stub.c               |  19 ++
 hw/acpi/meson.build                    |   2 +
 hw/arm/Kconfig                         |   5 +
 hw/arm/virt-acpi-build.c               |   1 +
 hw/arm/virt.c                          |  12 +-
 include/hw/acpi/acpi_dev_interface.h   |   1 +
 include/hw/acpi/aml-build.h            |   2 +
 include/hw/acpi/generic_event_device.h |   1 +
 include/hw/acpi/ghes.h                 |  24 +-
 include/hw/arm/virt.h                  |   1 +
 qapi/ghes-cper.json                    |  55 ++++
 qapi/meson.build                       |   1 +
 qapi/qapi-schema.json                  |   1 +
 scripts/arm_processor_error.py         | 389 ++++++++++++++++++++++
 scripts/ghes_inject.py                 |  48 +++
 scripts/qmp_helper.py                  | 431 +++++++++++++++++++++++++
 target/arm/cpu.c                       |   1 +
 target/arm/cpu.h                       |   1 +
 target/arm/helper.c                    |  10 +-
 27 files changed, 1316 insertions(+), 84 deletions(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/ghes-cper.json
 create mode 100644 scripts/arm_processor_error.py
 create mode 100755 scripts/ghes_inject.py
 create mode 100644 scripts/qmp_helper.py

-- 
2.45.2



