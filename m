Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6A8C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZX5R-000147-34; Thu, 01 Aug 2024 10:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZX5P-0000xR-AH; Thu, 01 Aug 2024 10:47:23 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZX5L-0001qY-RJ; Thu, 01 Aug 2024 10:47:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 79602628A6;
 Thu,  1 Aug 2024 14:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F3C4AF0B;
 Thu,  1 Aug 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722523637;
 bh=5XwGE1OWSAGPagP3hzhg9rsK0lxXgffU2Uv36f4SHSg=;
 h=From:To:Cc:Subject:Date:From;
 b=oC6Fo9aqyqeE1gDAFJaLV3/yNM2Kt9Ot5yri3ryrVX9x//ZuxdLOro6arET93a1e9
 O5OyDwxaHF1nYnpQFaVQgKkptFWwRGZEONkjsTcHgELG9E4h+8gCItnILQD3uG06v5
 +ViZWx0HpuRuWVbBukcJNEdaxJVhBowihySUVM5NYXUV39wMJA7Utfc4xKoOP20Ijc
 k52hq7MgjBB6kdArkT9UedB5FX/L1gC8cq+trlRgc+3Y5GBnicgLwnCcufbW5+R4sg
 TrPSEnGRkHC7zdCWezPCm9GiRHopA3pJe8MtWKd+iedjxIZkwJXZSKg61rp4S+EJJ7
 AU3r4gnkfBEcQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZX5H-00000001WCQ-2hTg; Thu, 01 Aug 2024 16:47:15 +0200
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
Subject: [PATCH v4 0/7] Add ACPI CPER firmware first error injection on ARM
 emulation
Date: Thu,  1 Aug 2024 16:47:03 +0200
Message-ID: <cover.1722523312.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

This series add support for injecting CPER records on ARM emulation.

The QEMU side changes add a QAPI able to do CPER error injection
on ARM, with a raw data parameter, making it very flexible.

A script is provided at the final patch implementing support for
ARM Processor CPER error injection according with ACPI 6.x and=20
UEFI 2.9A/2.10 specs, via QMP.

Injecting such errors can be done using the provided script:

	$ ./scripts/ghes_inject.py arm=20
		 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 9}, "pac=
kage": "v9.0.0-2621-g3de6991b870a"}, "capabilities": ["oob"]}}
	{ "execute": "qmp_capabilities" }=20
		 {"return": {}}
	{ "execute": "ghes-cper", "arguments": {"cper": {"notification-type": [22,=
 61, 158, 225, 17, 188, 228, 17, 156, 170, 194, 5, 29, 93, 70, 176], "raw-d=
ata": [0, 0, 0, 0, 1, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0=
, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 4, 0, 2, 1, 0, =
0, 0, 0, 0, 0, 0, 0, 0, 0, 239, 190, 173, 222, 0, 0, 0, 0, 173, 11, 186, 17=
1, 0, 0, 0, 0]}} }
		 {"return": {}}

Produces a simple CPER register, properly handled by the Linux
Kernel:

[ 5876.041410] {18}[Hardware Error]: Hardware error from APEI Generic Hardw=
are Error Source: 1
[ 5876.041775] {18}[Hardware Error]: event severity: recoverable
[ 5876.042023] {18}[Hardware Error]:  Error 0, type: recoverable
[ 5876.042280] {18}[Hardware Error]:   section_type: ARM processor error
[ 5876.042538] {18}[Hardware Error]:   MIDR: 0x0000000000000000
[ 5876.042781] {18}[Hardware Error]:   Error info structure 0:
[ 5876.043013] {18}[Hardware Error]:   num errors: 2
[ 5876.043222] {18}[Hardware Error]:    error_type: 0x02: cache error
[ 5876.043500] {18}[Hardware Error]:    error_info: 0x0000000000000000
[ 5876.043800] [Firmware Warn]: GHES: Unhandled processor error type 0x02: =
cache error

More complex use cases can be done, like:

	$ ./scripts/ghes_inject.py arm --mpidr 0x444 --running --affinity 1 --erro=
r-info 12345678 --vendor 0x13,123,4,5,1 --ctx-array 0,1,2,3,4,5 -t cache tl=
b bus vendor tlb,vendor
		 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 9}, "pac=
kage": "v9.0.0-2621-g3de6991b870a"}, "capabilities": ["oob"]}}
	{ "execute": "qmp_capabilities" }=20
		 {"return": {}}
	{ "execute": "ghes-cper", "arguments": {"cper": {"notification-type": [22,=
 61, 158, 225, 17, 188, 228, 17, 156, 170, 194, 5, 29, 93, 70, 176], "raw-d=
ata": [7, 0, 0, 0, 5, 0, 1, 0, 13, 1, 0, 0, 1, 0, 0, 0, 68, 4, 0, 0, 0, 0, =
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 32, 4, 0, 2, 1, 0,=
 0, 0, 0, 0, 0, 0, 0, 0, 0, 239, 190, 173, 222, 0, 0, 0, 0, 173, 11, 186, 1=
71, 0, 0, 0, 0, 0, 32, 4, 0, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 239, 190, =
173, 222, 0, 0, 0, 0, 173, 11, 186, 171, 0, 0, 0, 0, 0, 32, 4, 0, 8, 1, 0, =
0, 0, 0, 0, 0, 0, 0, 0, 0, 239, 190, 173, 222, 0, 0, 0, 0, 173, 11, 186, 17=
1, 0, 0, 0, 0, 0, 32, 4, 0, 16, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 239, 190, =
173, 222, 0, 0, 0, 0, 173, 11, 186, 171, 0, 0, 0, 0, 0, 32, 0, 0, 20, 1, 0,=
 0, 0, 0, 0, 0, 0, 0, 0, 0, 239, 190, 173, 222, 0, 0, 0, 0, 173, 11, 186, 1=
71, 0, 0, 0, 0, 0, 0, 5, 0, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0=
, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0=
, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 123, 4, 5, 1=
]}} }
		 {"return": {}}

964.134325] {19}[Hardware Error]: Hardware error from APEI Generic Hardware=
 Error Source: 1
[ 5964.134692] {19}[Hardware Error]: event severity: recoverable
[ 5964.134942] {19}[Hardware Error]:  Error 0, type: recoverable
[ 5964.135200] {19}[Hardware Error]:   section_type: ARM processor error
[ 5964.135466] {19}[Hardware Error]:   MIDR: 0x0000000000000000
[ 5964.135700] {19}[Hardware Error]:   Multiprocessor Affinity Register (MP=
IDR): 0x0000000000000444
[ 5964.136025] {19}[Hardware Error]:   error affinity level: 1
[ 5964.136255] {19}[Hardware Error]:   running state: 0x1
[ 5964.136468] {19}[Hardware Error]:   Power State Coordination Interface s=
tate: 0
[ 5964.136767] {19}[Hardware Error]:   Error info structure 0:
[ 5964.137001] {19}[Hardware Error]:   num errors: 2
[ 5964.137210] {19}[Hardware Error]:    error_type: 0x02: cache error
[ 5964.137472] {19}[Hardware Error]:    error_info: 0x0000000000000000
[ 5964.137737] {19}[Hardware Error]:   Error info structure 1:
[ 5964.137976] {19}[Hardware Error]:   num errors: 2
[ 5964.138192] {19}[Hardware Error]:    error_type: 0x04: TLB error
[ 5964.138459] {19}[Hardware Error]:    error_info: 0x0000000000000000
[ 5964.138727] {19}[Hardware Error]:   Error info structure 2:
[ 5964.138967] {19}[Hardware Error]:   num errors: 2
[ 5964.139185] {19}[Hardware Error]:    error_type: 0x08: bus error
[ 5964.139451] {19}[Hardware Error]:    error_info: 0x0000000000000000
[ 5964.139751] {19}[Hardware Error]:   Error info structure 3:
[ 5964.139993] {19}[Hardware Error]:   num errors: 2
[ 5964.140210] {19}[Hardware Error]:    error_type: 0x10: micro-architectur=
al error
[ 5964.140522] {19}[Hardware Error]:    error_info: 0x0000000000000000
[ 5964.140790] {19}[Hardware Error]:   Error info structure 4:
[ 5964.141030] {19}[Hardware Error]:   num errors: 2
[ 5964.141261] {19}[Hardware Error]:    error_type: 0x14: TLB error|micro-a=
rchitectural error
[ 5964.141599] {19}[Hardware Error]:   Context info structure 0:
[ 5964.141843] {19}[Hardware Error]:    register context type: AArch64 EL1 =
context registers
[ 5964.142195] {19}[Hardware Error]:    00000000: 00000000 00000000 0000000=
1 00000000
[ 5964.142534] {19}[Hardware Error]:    00000010: 00000002 00000000 0000000=
3 00000000
[ 5964.142867] {19}[Hardware Error]:    00000020: 00000004 00000000 0000000=
5 00000000
[ 5964.143193] {19}[Hardware Error]:    00000030: 00000000 00000000
[ 5964.143464] {19}[Hardware Error]:   Vendor specific error info has 5 byt=
es:
[ 5964.143750] {19}[Hardware Error]:    00000000: 13 7b 04 05 01           =
                        .{...
[ 5964.144164] [Firmware Warn]: GHES: Unhandled processor error type 0x02: =
cache error
[ 5964.144483] [Firmware Warn]: GHES: Unhandled processor error type 0x04: =
TLB error
[ 5964.144793] [Firmware Warn]: GHES: Unhandled processor error type 0x08: =
bus error
[ 5964.145099] [Firmware Warn]: GHES: Unhandled processor error type 0x10: =
micro-architectural error
[ 5964.145454] [Firmware Warn]: GHES: Unhandled processor error type 0x14: =
TLB error|micro-architectural error

---

v4:
- CPER generation moved to happen outside QEMU;
- One patch adding support for mpidr query was removed.

v3:
- patch 1 cleanups with some comment changes and adding another place where
  the poweroff GPIO define should be used. No changes on other patches (exc=
ept
  due to conflict resolution).

v2:
- added a new patch using a define for GPIO power pin;
- patch 2 changed to also use a define for generic error GPIO pin;
- a couple cleanups at patch 2 removing uneeded else clauses.



Jonathan Cameron (1):
  acpi/ghes: Support GPIO error source

Mauro Carvalho Chehab (6):
  arm/virt: place power button pin number on a define
  acpi/generic_event_device: add an APEI error device
  arm/virt: Wire up GPIO error source for ACPI / GHES
  qapi/ghes-cper: add an interface to do generic CPER error injection
  acpi/ghes: add support for generic error injection via QAPI
  scripts/ghes_inject: add a script to generate GHES error inject

 MAINTAINERS                            |   8 +
 hw/acpi/Kconfig                        |   5 +
 hw/acpi/generic_event_device.c         |  17 +
 hw/acpi/ghes.c                         | 178 ++++++-
 hw/acpi/ghes_cper.c                    |  53 ++
 hw/acpi/meson.build                    |   2 +
 hw/arm/Kconfig                         |   5 +
 hw/arm/virt-acpi-build.c               |  25 +-
 hw/arm/virt.c                          |  33 +-
 include/hw/acpi/acpi_dev_interface.h   |   1 +
 include/hw/acpi/generic_event_device.h |   3 +
 include/hw/acpi/ghes.h                 |  14 +-
 include/hw/arm/virt.h                  |   5 +
 qapi/ghes-cper.json                    |  54 ++
 qapi/meson.build                       |   1 +
 qapi/qapi-schema.json                  |   1 +
 scripts/ghes_inject.py                 | 673 +++++++++++++++++++++++++
 17 files changed, 1048 insertions(+), 30 deletions(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 qapi/ghes-cper.json
 create mode 100755 scripts/ghes_inject.py

--=20
2.45.2



