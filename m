Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D689C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYSf-0004L6-Jn; Wed, 21 Jan 2026 08:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSd-0004IE-QN
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:27 -0500
Received: from p-east3-cluster5-host7-snip4-4.eps.apple.com ([57.103.86.195]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSa-00019d-S0
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:27 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 E87001800120; Wed, 21 Jan 2026 13:41:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002883; x=1771594883;
 bh=4cjYuahheRTHDHA+6eUjUj4UrBehWsjNu/xkb/ODd84=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GmvJ/o847Z9Yt/FkXubQc/cYE1Gn0VMbyIoETDiz54JdehZvJ9lCu12MOPbcsq/cUeJMACKYaNJsE4ckatQYGxBISpY73Ju07sSUNB3k+9944NBUf9v7Owh7zFKJkIKQeYGUEc97Q7kWgZrwLlBu7fwmQrpWMlHV9y6aNp8ggPH/2mOJvK0Ll6iSYm0dk+PTVEJZhHg9yBuTcUFI7O80my9NwbEUJfHZlVwFcgC+rClF8g1RIKdJ2sJyb3lHk0sbLhanLUN3T6HnLq6rgCBMynHXFizYFay5e7sRDTa8DlQ26pCrXiBTc5PEQDtu99SOaUjCcBx27WIMKESOLwGW/g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 5E3391800153; Wed, 21 Jan 2026 13:41:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v17 00/21] WHPX support for Arm
Date: Wed, 21 Jan 2026 14:40:51 +0100
Message-ID: <20260121134114.9781-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=6970d782
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8
 a=2CSUmbMKgiS_FIm3Z54A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: thk9wvICh17GPsT0tDtL2WJJa6fgq56m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX+CkDb2W/JzEY
 FmRBLDRIRurbPnlDIEI5KKGXhG0RrTIoUFyNPfpHqmLS+j2MZXUMjf6Y4Yw+0ZVUeT57jxR+Kmq
 RctwX6DmP0FFL+iZx8XiowXEApsiDru+DT7xIhAbelQcmusmHtgo9o2tLB5v1jKAjpMfQUISl0B
 3d54KxSDo6qHpqxVez6Cv23lS7K+BlWRU1eqsM68SvrhhMAALdF6vMnjyQim6atVTWqt4bHLK5M
 JZ8AUtSWTbJLEycCIS+b6CcIFT7yaT4evuxxVKR82RZksB0DCX8X10AUqAABUQLjQxG3ffr+SWf
 XUYKJr1qD7vrlqFQWI2
X-Proofpoint-GUID: thk9wvICh17GPsT0tDtL2WJJa6fgq56m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1030 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601210115
X-JNJ: AAAAAAAB8b7N1plv0JzvqYT4HK5UKglV9QZ6scRxumzwnCdtPqNc41B5NXEKSrqq+UHj5IR0k8vvcb6GVLD//QOowhgJ/Ffb8500epKvlHYOg6+xfosWnD2WjcjeOAfM6zEc0EClqomOqwshgrkH+KkP/qOsAIVgLKaS+iIT8duADbDCSs8l36AyzEDiCI99oGV7jG8l1aFHFkwEWr0+N2ZJWf45c6zVrbBrwE4IFA2tXfUywXOBQz0LethkQA1La0ImvjFk9NXtKhJQ1LHJkF3QdVClgVuL621dkWH+ntic9VPoOCiweM7OhXkWuDH0jrFmWiNxB2pZg/udLy9DG95+54qtCSlXeDfsbkxYQuhg9BzcYaWNLNGsJyUDLv61F3RR+PSLWXrcV9NZ0MoC911CfyXRzcHAFAiiA0uVDAQnFu0reP4glRiZ6gFs32EVN2LAFG2PhMObdkW+EG/oaYUndlWFe2yOaFhPet1l8iMqYizX0HSSnc+mjtsHDUkIAm2Q8uWgn2kgucwrSfnvwBHr0xti3fD5puoAoVsbd7Z9GLAQYw/N4hoq+v1EugkxqBed8oWa9hjgpqBFEsD3yT9QMu1DVFyJH2uyOYtRnku1wDZdC1MibI3XTb9UE+LXSGCy0V1MpPqP+BlerT3689BpKwhsM7rS1C/U93r4KGin10EscnMrrlUskdKLWExx0llhwFR0ZWqauWvRsc0LwZmLv4XpUUQsZhCBwYwz/MUKcbfg5/+MdnrDyJGrxT90f5erpqlPMWje09zjiWSljCpSRRbPveHs3RlHdK2YowCku4VWFUeMB9A9MKDru/aVJh8fOcgYUcMSLC14RFM4QL8r6ATcdUHWOFU4CcpVU0uZ9MGLqrVz08T7nxkVJg==
Received-SPF: pass client-ip=57.103.86.195;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v18)

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

Mohamed Mediouni (19):
  hw: arm: virt: rework MSI-X configuration
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
  whpx: arm64: gicv3: add migration blocker
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
 docs/system/arm/virt.rst                      |  13 +-
 hw/arm/virt-acpi-build.c                      |  27 +-
 hw/arm/virt.c                                 | 160 ++-
 hw/i386/x86-cpu.c                             |   4 +-
 hw/intc/arm_gicv3_common.c                    |   3 +
 hw/intc/arm_gicv3_whpx.c                      | 247 +++++
 hw/intc/meson.build                           |   1 +
 include/hw/arm/virt.h                         |   8 +-
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
 target/arm/whpx/whpx-all.c                    | 985 ++++++++++++++++++
 target/arm/whpx/whpx-stub.c                   |  15 +
 target/arm/whpx_arm.h                         |  17 +
 target/i386/cpu-apic.c                        |   2 +-
 target/i386/hvf/hvf.c                         |  11 +
 target/i386/whpx/meson.build                  |   1 -
 target/i386/whpx/whpx-all.c                   | 569 +---------
 target/i386/whpx/whpx-apic.c                  |   2 +-
 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m  | Bin 0 -> 188 bytes
 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m  | Bin 0 -> 172 bytes
 tests/qtest/bios-tables-test.c                |  21 +
 44 files changed, 2186 insertions(+), 636 deletions(-)
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


