Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64BAECD981
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1Dv-0003iu-PH; Thu, 05 Feb 2026 10:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Du-0003iO-93
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:24:50 -0500
Received: from p-west2-cluster1-host7-snip4-5.eps.apple.com ([57.103.68.88]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Dr-0001Pp-Ds
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:24:49 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 18CF018001FF; Thu,  5 Feb 2026 15:24:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305085; x=1772897085;
 bh=TysnGqY+/4EVfnhYnAdleW0HdpjnKCo0dv/pt4Y9RBI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=SNY+XKzWKVBjYmk5MHPUWpsFuIcd/SJaPjzc0UcREjLHBIGLH/4G2F78QiNYkYCIdPEhkfpCP8X0lookiJmy5wDyTYTln7Hj78pCTo3Radq17qIkYB26U5wZDsjmlLnW8Jee39s9rt6JGpzfZMqiVz4Jis5Vfq0QuKEGXadHqEZtQDPTv+BGNgbL30+sL7v21MDFoI2uG/Ud1xBTDYWnHIPJ6dnKi7yAUE4CqJCywCzGzhts1UV7a+Dfx3T5V7rQHgTzk0aN1q3hMncj/Ys0Sk+3P+OizHRrJUnM6xOv5REup/X+2s2KrVpvEI+XIQInKgDmjoN0F9HNK9ang43mbA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 0EA071800755; Thu,  5 Feb 2026 15:24:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 00/22] WHPX support for Arm
Date: Thu,  5 Feb 2026 16:24:03 +0100
Message-ID: <20260205152432.78208-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pvn1jX6pJ2R4px3iFOSEv0hB9wiG7UkA
X-Proofpoint-ORIG-GUID: pvn1jX6pJ2R4px3iFOSEv0hB9wiG7UkA
X-Authority-Info-Out: v=2.4 cv=adlsXBot c=1 sm=1 tr=0 ts=6984b63c
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=GaQpPoNlAAAA:8 a=KKAkSRfTAAAA:8
 a=mDV3o1hIAAAA:8 a=1Fe2uPTpBdqolypXLAQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX0Jjhc5caaVQn
 YnGL499cX3DVKyrf/IMAZirkD/xN4VEgrIjyTSKyT6TCkGLXdLvS2ME8gWu8FoHOZDjiUXprNOb
 LNVtLIotJH/z19LofD/SSBDBA0UGCr2Zbu26UBQcQekQPBgWebF57WgjPbVe91iGslhxglAIGGX
 dRuN9bH+DH4w8bFLmhCNGq4pbzDscGHEvmQoCggqisNY8rFeC4ytRoJ84B8HMOyjqHqxoaTDQt7
 5qMDvhOtzPLWK3WgESWCz16qCNKLlZnmRgPLOB2g5NVfZMc1iIRlE52lG4opYwKru+4/ctEKsle
 3we4v+pPipszo2P05BXAAp7vdgzM0eMsMEmUvd+eeWfuap/jwRai99LhQ/uJC0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABzvqZlrmtDxeRD9oXevzh5wwZGh2zmpiE6uBoPbt/Xi/qIT9+HQSxOQgBYBrA9eeIymgrlR1N59+HTTKOEtb0rhPqJ797ebAI6bcKPRlcDdrFjp9xAstFF+N14PdbvQStL1Xh2h/ijpz04mtu/k2BtsNSvetLHuPFUs5MZOkwMLq7UJD7YFT4hQ6/bGwjG+JAUd1jIcvZoHS7G5VvK+A7/grNwB2BQBQKD/lb4A33/YFDshIzACF5bDMXE/NQ8cW8sO6/omD4+Z7uKuQ2d5uiS4ww+kDmGe++rGjF8Iw4SmfJ7h1RkgGTUyMpFdWSkCB9nRmXVJdJvAoR5zEJhsaeh+y5TZWLDmSKeDnUvD0mq5yqA3ImLg671vl24gLpbVHTRUvnWas6vr7lWYA47MQpUpYdeiverSXAzwerE5kO+JbfYdl+7PqoEwpWJoilTNxeRLG9iBKTHdf+Wo1a6Ko0KQfjYelYdtwMGgMDDc3mSoPniXSwaeJWMbolY7cCwxVGHugKUxwEY8nkqvKfIHXI2RqGkrwWm5TJvdGvqNuSN/dfy2S1m5+lOb4/evXKDAucVplNZY5ktL2kmL9NBPdyupDad7rpwCBaEskVEk5ZpkR6jCeP6B/2+Q41SbAX4jRV/Kvqa4OCL6uGYppciSAWKRLLTRODc+csXVhGdJ+wcrsr7yq42pgXHafPMtkjuQFlgs8pIU1wnZt2C1aVjFWs8o5QvCwI4GlcYK0ub77mZR2MLT5NXfbgnGBgcvWcYciBoiRGBOZsoaA3rolremU4q2UdA7wOo2DxyetCkX47XEi8+Jnscv1jcBpILvLXtpQvnB7y3HjWMsBr/sTjAkxI+9cb1DUqJH84mOkjBlwoKfuYDKlmZ5fX6k8Z76lWWEvjISfj8ijyC6358TOMp50z6JZtWTpo+m4rB36xZc23TanEFL604TUQ
Received-SPF: pass client-ip=57.103.68.88;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v21)

Patches without a review: patches 3, 5, 6, 7

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

Updates for v22:
- Oops, add updated IORT now that the SMMU patches are merged
The revision field in the IORT changed compared to the revision of the SMMU patches the artefact was built on.
Ran a make test again in a clean tree to make sure...

in side note: try to make certain that qemu-system-aarch64 is built as part of make test on macOS instead of
the unsigned variant only as that might have been why I didn't observe this

Updates for v21:
- Change commit messsage a bit for the ACPI table updates so that it doesn't get parsed as a diff
- Split "qtest: hw/arm: virt: add new test case for GICv3 + GICv2m" into two commits

Updates for v20:
- Rebase on current origin/staging

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

Mohamed Mediouni (20):
  qtest: hw/arm: virt: skip ACPI test for IORT with GICv2
  hw: arm: virt: rework MSI-X configuration
  tests: data: update AArch64 ACPI tables
  qtest: hw/arm: virt: add ACPI tables for new GICv3 + GICv2m test case
  qtest: hw/arm: virt: add new test case for GICv3 + GICv2m
  docs: arm: update virt machine model description
  whpx: Move around files before introducing AArch64 support
  whpx: reshuffle common code
  whpx: ifdef out winhvemulation on non-x86_64
  whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
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
 hw/arm/virt.c                                 | 141 ++-
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
 47 files changed, 2166 insertions(+), 637 deletions(-)
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


