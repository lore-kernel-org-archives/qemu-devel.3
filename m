Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5D0D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXZ4-0004BQ-1P; Thu, 29 Jan 2026 14:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZ1-00043w-EX
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:23 -0500
Received: from ci-2005i-snip4-7.eps.apple.com ([57.103.89.218]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXYy-0005ic-B1
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:22 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 8D2101800146; Thu, 29 Jan 2026 19:20:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714418; x=1772306418;
 bh=VVuQCcVcIAOlugEEhO1OI2phaGGlCyLNt0BooV4UdKI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=XiYrQaqKFkP8oMNUnoq2bA+XHA9EMiY5x84k0WfZBCe4Tx83XTV283uAeTe8lmcK/WMhUyG4iaRdNunb4zx7bdMiBl5fA82bjZdv7LuLSFzjx69yoDyAAcCxBKA+d5t/0vBIhLEya3XjPlWekUbxmFmjZhWFYDepZTdMM6edueu6o6ZN+LuJvEHvaaYiNW5NC+c3Y/YqOcfrNnp8E3y/ThjL1x7Pu+JHK6UtUo8tL1rycWfxARCSchqxoU9si57/eUkAZ3mwoGPvU9fEQyN4ucX7f//RmlGh1eZsDRHMMRw+P7rxD1Qtf8xGvw6RYB98pOPNaG97y36o6RySD8Kw7w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 1935518018BA; Thu, 29 Jan 2026 19:20:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 00/22] WHPX support for Arm
Date: Thu, 29 Jan 2026 20:19:45 +0100
Message-ID: <20260129192009.14707-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=697bb2f1
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=GaQpPoNlAAAA:8 a=KKAkSRfTAAAA:8
 a=mDV3o1hIAAAA:8 a=3sHXeTOdJn_U_PFnuNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TsGk-CjGIx1TcOnXNXPlZKShXsFxAMEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX6FoInZu4jqF0
 PQYGSuuoYi0mtdyGxi8KSc6GtRvm7yqHZaEdYE0hOxmjk9tJHruYktwAaB2kPPjdBhgQ6x6FJ1s
 9x1NVO742P4zfTHzZ6BtUkZbgQ60Ay5uH4ssXFXsxnSVDqH9sc69VJuaBOI1pL234NkhZzeaqWC
 GRYMgHQEMvABjPQtSMHBzo9Y4ib3MysEnKzFKqHDshR6RAPgws39+Oa0W4Xdp8tXK4NX58+rN9p
 7vJ+caM0jPF2mgX2jtPjI3rgr8+GEnZoe5MI68Ay31LVCOH+oXjgIUphyzpNvYlIsEpEtkjfi6z
 odkhWxv7N6HelAXtNiyCe0rbD6WqnlqfP4V3+97GukgKcCxSiJQxx1yP4Eo33E=
X-Proofpoint-GUID: TsGk-CjGIx1TcOnXNXPlZKShXsFxAMEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABSgVN8ivYJVGqt2bvqWbJkKqKYkfD1NtssMI5Eb3nv2J6JB+/webGgLjFSl0ceAs/jeywikZUaSqv8Zl0pCdCnVn3rggGklWl8C9bKvBpcKkED8VxJvvvlcFNo1DQUUpSbHeUm9uAYPHTrIHTMugRqmqfzkBPAd9UmbXM7ft6imJsk8c+eFaCr7rDcd5SZfDR6xG5t+O0nwNbd1ImoZ3prCAPiLPSICrcrGQKuU0MUMU9NFws9WM1ASElOgI4ZBHz4LctJdzBqrVD/mnyfd1T2dmMhb9M2yVdwAQVflEf3+MzXINIWYrlkatOpoJoT/nD9JjGNe4aHzg3PrnHZPsjQO6X8cL2i4yi5aqmXsCzeGMsFcmYcny2pp4u04xIVW3zZlxsKkU0CKCPeIqrWQg4DYJPStbGJklg3DTfODrxWtjLyCpmMaXiy2Rxx787ogwozcXxaiL78s1MbTLRZOekPcVkebII7lzwsVdE9WvF7xgLlRqUPpHi4EovV+e8j1RVq3gI8X5QL+9cHXX4JYQT9Jygirk13nP0x+JaAXmlj66c9X/IP48x4i6gB99+LDM8/Cno4uAVzctO072ejUVu4wl3S5XCI7atEgxw/8BjjC5RG5OTxWHu0gr1wXCtBWqrVsJp7hla/8PYN8eA+kGo4fXc8v92Wjso30mm6opHB5NSvh4PGR5kT9/zaOTdOknmKG3mjJHkKHtCsyrE42e39RQC4rV6XUxOJzqPr9Remk2vJ3uYIL2JyPUmCO97F22yw6BvIvAJkJWyaYoxmyNhFYRR/sorsuenC9E5OU719RFvrLBmnTNbDsYPQPVRXfF4hySdQ9M/ZBD0sjro0inEExeNG+EoR1pQJ5aZiSY=
Received-SPF: pass client-ip=57.103.89.218;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v19)

Missing features:
- VM save-restore: interrupt controller state notably
- SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.
So SVE2 is currently masked for VMs when running this.

Known bugs:
- U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.

Note:

"target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.

"accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
as part of this series to make it compilable as a whole.

And another note:

Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
so didn't do changes there to a sysreg.inc.

Updates for v19:
- Address review comments
- Documentation update
- Base on top of the current target-arm queue (https://patchew.org/QEMU/20260129160917.1415092-1-peter.maydell@linaro.org/)

Updates for v18:
- MSI-X config patch: remove workaround to keep existing ACPI tables, as even Ubuntu has hibernation support
off in their stock kernel...
- Fold patch "whpx: arm64: gicv3: add migration blocker" into "whpx: interrupt controller support"
- address review for "whpx: interrupt controller support"

Updates for v17:
- Reworking the MSI-X configuration patches
- Accordingly, its= retains the same behavior as before, so add a test case for GICv3 + GICv2m.
- Squashing "whpx: arm64: check for physical address width after WHPX availability"
with "whpx: arm64: clamp down IPA size"
- Not worthwhile to have a separate GICv3 + GICv2m patch, squash it into the "rework MSI-X
configuration" patch
- Address review comment on "whpx: arm64: gicv3: add migration blocker"

Updates since v16:
- Address some last review comments
- Rebase with the latest origin/staging

Updates since v15:
- Some last tiny changes addressed.

Updates since v14:
- Working around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87950

It turns out that we can't avoid default: in case with an enum on GCC without warnings,
although Clang allows that behavior.

Updates since v13:
- Addressing review comments from Akihiko Odaki
- Squash GICv2 ACPI workaround patch and have it documented as a separate function
- Rebase with current origin/staging

Updates since v12:
- Address review comments and make sure that checkpatch shows no errors, make test also ran
- Tested the Windows x86_64 build too in addition to Windows arm64 and macOS arm64
- Hopefully the last revision, should be ready to merge.

Updates since v11:
- Address review comments
- Rebase up to latest staging
- Switch to assuming Qemu 11.0 as the newest machine model

Updates since v10:
- Bring forward to latest Qemu
- Fix a typo in the GICv3+GICv2m PR

Updates since v9:
- Adding partition reset on the reboot side of things...

Updates since v8:
- v9 and v8 were not submitted properly because of my MTA not behaving, sorry for that.
- v10 introduces a new argument, -M msi=, to handle MSI-X configuration more granularly.
- That surfaced what I think is a bug (?), with vms->its=1 on GICv2 configurations... or I did understand everything wrong.
- Oopsie due to email provider ratelimiting.

Updates since v7:
- Oops, fixing bug in "hw/arm: virt: cleanly fail on attempt to use the platform vGIC together with ITS".
Other commits are unchanged.

Updates since v6:
- Rebasing
- Fixing a bug in the GICv3+GICv2m case for ACPI table generation
- getting rid of the slots infrastructure for memory management
- Place the docs commit right after the "cleanly fail on attempt to run GICv3+GICv2m on an unsupported config" one
as that's what switches ITS to a tristate.
- Fixing a build issue when getting rid of the arch-specific arm64 hvf-stub.

Updates since v5:
- Rebasing
- Address review comments
- Rework ITS enablement to a tristate
- On x86: move away from deprecated APIs to get/set APIC state

Updates since v4:
- Taking into account review comments
- Add migration blocker in the vGICv3 code due to missing interrupt controller save/restore
- Debug register sync

Updates since v3:
- Disabling SVE on WHPX
- Taking into account review comments incl:

- fixing x86 support
- reduce the amount of __x86_64__ checks in common code to the minimum (winhvemulation)
which can be reduced even further down the road.
- generalize get_physical_address_range into something common between hvf and whpx

Updates since v2:
- Fixed up a rebase screwup for whpx-internal.h
- Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for -cpu host
- Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64 variant

Updates since v1:
- Shutdowns and reboots
- MPIDR_EL1 register sync
- Fixing GICD_TYPER_LPIS value
- IPA size clamping
- -cpu host now implemented

Based-on: 20260129160917.1415092-1-peter.maydell@linaro.org

Mohamed Mediouni (20):
  qtest: hw/arm: virt: skip ACPI test for IORT with GICv2
  hw: arm: virt: rework MSI-X configuration
  tests: data: update AArch64 ACPI tables
  qtest: hw/arm: virt: add new test case for GICv3 + GICv2m
  docs: arm: update virt machine model description
  whpx: Move around files before introducing AArch64 support
  whpx: reshuffle common code
  whpx: ifdef out winhvemulation on non-x86_64
  whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
  whpx: interrupt controller support
  whpx: add arm64 support
  whpx: change memory management logic
  target/arm: cpu: mark WHPX as supporting PSCI 1.3
  whpx: arm64: clamp down IPA size
  hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
    and HVF
  whpx: arm64: implement -cpu host
  target/arm: whpx: instantiate GIC early
  whpx: enable arm64 builds
  whpx: arm64: add partition-wide reset on the reboot path

Philippe Mathieu-Daudé (1):
  accel/system: Introduce hwaccel_enabled() helper

Sebastian Ott (1):
  target/arm/kvm: add constants for new PSCI versions

 MAINTAINERS                                   |   6 +
 accel/hvf/hvf-all.c                           |   7 +-
 accel/meson.build                             |   1 +
 accel/stubs/whpx-stub.c                       |   1 +
 accel/whpx/meson.build                        |   7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |   6 +-
 accel/whpx/whpx-common.c                      | 536 ++++++++++
 docs/system/arm/virt.rst                      |  24 +-
 hw/arm/virt-acpi-build.c                      |  20 +-
 hw/arm/virt.c                                 | 144 ++-
 hw/i386/x86-cpu.c                             |   4 +-
 hw/intc/arm_gicv3_common.c                    |   3 +
 hw/intc/arm_gicv3_whpx.c                      | 237 +++++
 hw/intc/meson.build                           |   1 +
 include/hw/arm/virt.h                         |   5 +-
 include/hw/core/boards.h                      |   3 +-
 include/hw/intc/arm_gicv3_common.h            |   3 +
 include/system/hvf_int.h                      |   4 +
 include/system/hw_accel.h                     |  13 +
 .../whpx => include/system}/whpx-accel-ops.h  |   4 +-
 include/system/whpx-all.h                     |  20 +
 include/system/whpx-common.h                  |  26 +
 .../whpx => include/system}/whpx-internal.h   |  16 +-
 include/system/whpx.h                         |   5 +-
 meson.build                                   |  20 +-
 target/arm/cpu.c                              |   3 +
 target/arm/cpu64.c                            |  17 +-
 target/arm/hvf-stub.c                         |  20 -
 target/arm/hvf/hvf.c                          |   6 +-
 target/arm/hvf_arm.h                          |   3 -
 target/arm/kvm-consts.h                       |   2 +
 target/arm/meson.build                        |   2 +-
 target/arm/whpx/meson.build                   |   5 +
 target/arm/whpx/whpx-all.c                    | 994 ++++++++++++++++++
 target/arm/whpx/whpx-stub.c                   |  15 +
 target/arm/whpx_arm.h                         |  17 +
 target/i386/cpu-apic.c                        |   2 +-
 target/i386/hvf/hvf.c                         |  11 +
 target/i386/whpx/meson.build                  |   1 -
 target/i386/whpx/whpx-all.c                   | 569 +---------
 target/i386/whpx/whpx-apic.c                  |   2 +-
 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m  | Bin 0 -> 188 bytes
 tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 84 bytes
 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m  | Bin 0 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 260 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 bytes
 tests/qtest/bios-tables-test.c                |  21 +
 47 files changed, 2169 insertions(+), 637 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 hw/intc/arm_gicv3_whpx.c
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h
 rename {target/i386/whpx => include/system}/whpx-internal.h (95%)
 delete mode 100644 target/arm/hvf-stub.c
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m

-- 
2.50.1 (Apple Git-155)


