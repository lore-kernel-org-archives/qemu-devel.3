Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCFDCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RHw-0000q3-U7; Thu, 16 Oct 2025 12:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHv-0000pE-Cl
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:15 -0400
Received: from p-east2-cluster3-host3-snip4-4.eps.apple.com ([57.103.77.155]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHi-0001Y4-Bp
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:15 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 DD1811800095; Thu, 16 Oct 2025 16:56:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=WQoimyNrqMuLKK8HZ2qqr3R8ZeRpBe6kqdqqVEl2UjA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Y/dqpDPlLse/jE9eDz0zswh5yxMZDzvDb4OVyX5o1nEXgUJg0ktXk1fBu2OsJig3+dKO1Ntgu1CjNzpV7EFqKUG3YyHF937l/vpRpqu9h13wRZ0RYXJrtWzYDw5S8vhPmTIW+eGRr2XpKJT4wpkqyyIxnsfIai9iCfQeA28Okm4YoMeVDrx/8XaEEfPj5EB6EBjDDT5KL8zCdtK31ofwTEUgDlM7NftrvOp6wwnnU3WHDgdKH4OXTQ920cv6yrgVZ4ZQrgEBN8w8OZJUupzEaZWyzUW2mp32DAlCSbeZguVDzmJPaQvLsWlbxLXU98J7g4EUNukkkV/5FXTUhT3WRw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 5B3B3180049B; Thu, 16 Oct 2025 16:55:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 00/24] WHPX support for Arm
Date: Thu, 16 Oct 2025 18:54:56 +0200
Message-ID: <20251016165520.62532-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX6sRpAn3TmvdO
 Gomd5xqlT3Ydt+ee9xcaw6IqfPCgKcJmveAcYJZnyZYG43nyA7ZsNFTuWohB24gqqBb10eJZJJz
 ozbYCdTzU4Bmt0ieKqBzduqyrGkFsIu5TpxWMjKkMaWuyYK6eommYFq2cMi3CaetiDsWKYZ0I+9
 TQMhadI/PHIIrdGwrxlHX+EUGH79A4lLfCqDjDbdGUmvvuCa+ESqh+A1TSQAFQkCqgr6Lbxp2WD
 VUpYrga9HrIOC99Th7FUyoc3PkWMHgHV1zMsCoVDVZb0yPq8kxsHa7/GZirV4H21dGk6+vP+k=
X-Proofpoint-ORIG-GUID: 3AgDAUtVXY2WhA5XknDnGzjG0KmqPDEU
X-Proofpoint-GUID: 3AgDAUtVXY2WhA5XknDnGzjG0KmqPDEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1030 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAAB8uhTKpU63Cqf4zUQdqStkirqtQ0ogyHS00NOOqBoppECHcQAKeVRu+5trG8t+YQonu5maWfXK5vugmvVK3bvGBCwijiFjOHnXgE5Cp2Q8Ig+KKqrPWoMVGR2nWPLseQ4J06F66SIuBnulLJvuomYH70EwNr0Tp+ETf+KhK5tckzmcr8eM4D/T+Jm3ZzkfhX4Hq28YDztFL4fR7mX+mYd0pPTuWg6jS893l/oirGOLOjt6QF4w1TPk7Ol6ZmQfDnEvu7r27zywHwV6aNv3+wEVRKTg+ac72JnDNDP0Lwumv6ltD5HmIN6D057ME294sVHkAKuohS5Ik6HBNB0BpM7YuY3xP8aVkBpNB4QUiwpwpuWiEcvDjStxmB6ku/SGe8oBYTSqkNWGe6a3gL04vYDInGM3nBuY5Rk1xSRrP+O3mAzJae8+aeC2hsXOFjhQifjNEwpKSS+E0mWDB8MTCDGbiJxdiwSvoprbKw/0KH/juv3f8Z72TMRvBgj8yOa05gd/UgySFRptpDMsRG4cnLm4H6gQsWkOybnK8vqQLpJ3gcQ991fR25L9GvNB837NRgxIlf82SAZbq91+4QnHxRSkSPxbmwn4PoAeLCffiPnRu2qasAC4Qb+zmlKoMer5am0HLuBnA/2m4WcyFRl5KTkpXTgV8WTaRL4UCjt1fzHvUXljMXT8BhJRU0T06UjFRYlJoIK9pxHRUbKHEcu7SgP54V2zh5Z7rN/Hh7Ed3pPqJm7w3ZgxX3UZFVRjACQgvTnVeckC2Ln04uDL9YX8wteTo5WBVHajPk/EsPOTgm5eg+b0pEA6lb7sUS0MI+46tbMNLIjlxdZZ+sxjrlBzC+n9O9s6N1WoJgZ/z1o3jWvDKP6cIinap4adfFkag1SfeXDhqBGGyLp5rAuyHFXZhzzUlk=
Received-SPF: pass client-ip=57.103.77.155;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v6)

Missing features:
- PSCI state sync with Hyper-V
- Interrupt controller save-restore
- SVE register sync

Known bugs:
- reboots when multiple cores are enabled are currently broken
- U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.

Note:

"target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.

"accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
as part of this series to make it compilable as a whole.

"hw/arm: virt: add GICv2m for the case when ITS is not available" present in both the HVF
vGIC and this series.

And another note:
Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
so didn't do changes there to a sysreg.inc.

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

Mohamed Mediouni (22):
  qtest: hw/arm: virt: skip ACPI test for ITS off
  hw/arm: virt: add GICv2m for the case when ITS is not available
  tests: data: update AArch64 ACPI tables
  whpx: Move around files before introducing AArch64 support
  whpx: reshuffle common code
  whpx: ifdef out winhvemulation on non-x86_64
  whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
  whpx: interrupt controller support
  whpx: add arm64 support
  whpx: copy over memory management logic from hvf
  target/arm: cpu: mark WHPX as supporting PSCI 1.3
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS
  docs: arm: update virt machine model description
  whpx: arm64: clamp down IPA size
  hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
    and HVF
  whpx: arm64: implement -cpu host
  target/arm: whpx: instantiate GIC early
  whpx: arm64: gicv3: add migration blocker
  whpx: enable arm64 builds
  MAINTAINERS: update maintainers for WHPX
  whpx: apic: use non-deprecated APIs to control interrupt controller
    state

Philippe Mathieu-Daudé (1):
  accel/system: Introduce hwaccel_enabled() helper

Sebastian Ott (1):
  target/arm/kvm: add constants for new PSCI versions

 MAINTAINERS                                   |   11 +-
 accel/hvf/hvf-all.c                           |    7 +-
 accel/meson.build                             |    1 +
 accel/whpx/meson.build                        |    7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |    6 +-
 accel/whpx/whpx-common.c                      |  666 +++++++++++
 docs/system/arm/virt.rst                      |   10 +-
 hw/arm/virt-acpi-build.c                      |   16 +-
 hw/arm/virt.c                                 |   74 +-
 hw/i386/x86-cpu.c                             |    4 +-
 hw/intc/arm_gicv3_common.c                    |    3 +
 hw/intc/arm_gicv3_whpx.c                      |  249 ++++
 hw/intc/meson.build                           |    1 +
 include/hw/arm/virt.h                         |    6 +-
 include/hw/boards.h                           |    3 +-
 include/hw/intc/arm_gicv3_common.h            |    3 +
 include/system/hvf_int.h                      |    2 +
 include/system/hw_accel.h                     |   13 +
 .../whpx => include/system}/whpx-accel-ops.h  |    4 +-
 include/system/whpx-all.h                     |   20 +
 include/system/whpx-common.h                  |   26 +
 .../whpx => include/system}/whpx-internal.h   |   23 +-
 include/system/whpx.h                         |    4 +-
 meson.build                                   |   20 +-
 target/arm/cpu.c                              |    3 +
 target/arm/cpu64.c                            |   19 +-
 target/arm/hvf-stub.c                         |   20 -
 target/arm/hvf/hvf.c                          |    6 +-
 target/arm/hvf_arm.h                          |    3 -
 target/arm/kvm-consts.h                       |    2 +
 target/arm/meson.build                        |    1 +
 target/arm/whpx/meson.build                   |    5 +
 target/arm/whpx/whpx-all.c                    | 1021 +++++++++++++++++
 target/arm/whpx/whpx-stub.c                   |   15 +
 target/arm/whpx_arm.h                         |   17 +
 target/i386/cpu-apic.c                        |    2 +-
 target/i386/hvf/hvf.c                         |   11 +
 target/i386/whpx/meson.build                  |    1 -
 target/i386/whpx/whpx-all.c                   |  569 +--------
 target/i386/whpx/whpx-apic.c                  |   48 +-
 tests/data/acpi/aarch64/virt/APIC.its_off     |  Bin 164 -> 188 bytes
 41 files changed, 2270 insertions(+), 652 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 hw/intc/arm_gicv3_whpx.c
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h
 rename {target/i386/whpx => include/system}/whpx-internal.h (89%)
 delete mode 100644 target/arm/hvf-stub.c
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h

-- 
2.50.1 (Apple Git-155)


