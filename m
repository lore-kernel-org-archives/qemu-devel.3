Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1446F0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUo6-00013Z-Ft; Fri, 06 Mar 2026 08:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUo4-000136-Ow
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:28 -0500
Received: from p-west2-cluster1-host6-snip4-10.eps.apple.com ([57.103.68.63]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUo2-0006tj-F2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:28 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 930291802E61; Fri,  6 Mar 2026 13:01:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802084; x=1775394084;
 bh=trev5yEM/Tw+YfL0dNm2dQEQ23YGcRwkTpeHpvFNoFQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=aM/Co5eX60TkVd9CMaZhAhWz229OzJ3gs5NJ5zMriU0k+egZOdUDIouwbQ/3gBJdpj7Gx/z89Li4SsCcraUjxBZku0/mW1cvxZqrh6AaN0bA7sUYTEeV+OEjRDZkQApP7WF5slSFwqaEED5u7UlnoJ5eINTrSKKu7Np4wXlHP01Z0ewQE+m5AIL+MtvHOw65385bLUtkfeyPjEn33Z81W9YFtTyX8/jNbr9VL6GGDwYpNTSoCOeSiXfPVxZ5NRCRNSXSw7DT0UcluAJmrpRw+b8vJatoAxjXLrxCT9+ihHDuebod0Z4A69LQwD7Vokx7UVzdrGgxSTZ8FiwyXzttrQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 62A731800846; Fri,  6 Mar 2026 13:01:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Fri,  6 Mar 2026 14:00:50 +0100
Message-ID: <20260306130107.35359-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ngd9Yt9OGRuiw55G73Ztnksba1pvJoAn
X-Proofpoint-ORIG-GUID: Ngd9Yt9OGRuiw55G73Ztnksba1pvJoAn
X-Authority-Info-Out: v=2.4 cv=TZObdBQh c=1 sm=1 tr=0 ts=69aad023
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=jwI92-NncrociDarPsAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX5pl1PXZAjQL7
 lDviE7b5PlV/zQdDmEGPXB/NGyX3+T5Q5tFBsKWdj3aHLFm9YSm8+kvoyu2BuiwlLPN8ay+lA48
 HwEQIxaZSD1uFsH24Deud37NCshbcveITGsKf/+Gywi2nyePrghCdY0LS3YNTtr7iHrKr82bwat
 YBigKaPY8K7j0ajGyu/h96dxZyTTZNvzIxZRFinESH6Y+Oj64Q1XNzvF22v9SPKCbBAqZQdndSt
 LdM0ZsDLsCC5lnaqNSpQ6U4zkopyaB+xfjVSFP2Datsahn8z0Lc+GtA2sXK8LCmH+9cmixnu82Y
 bv1TXAidfBnEO3VkTygkytmsIc2onjfKbduyDVEFqmsFA0qxv9JiRsne44I8K8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAAB/ugHRR4jZZ8tV+EHKMLcW28H54PqhIUQlRP9fv75FXSZ2jDPjqwMav4mx+Mv8mN/Wwl4D9m1pykunEQWEzP8FJCTf1WmskM4tGfUUrx0KA9J5cYjgKzVZJre0S5t/rE67bLcZL0xzHm+7KQMm3f5kx6wYY24XDhomHmzqmB3RsQxzJLgZtXdCJM6A+x7HmbZeHhAb4J5IOb+YUKdR6U3UJSrx6rUBfMTkR+SSoBttIw04xXdg3WJxRzrYV9yp6VR/H+bI9hCG7nlWQMgoHoaF9eFeLmGqTemsSJfl3SSE54dlOLtJlQW6FB9DUBmRo8zH91qiyCk+SFhGJBonhLh+1Z2SlTj2jYfl4KsHEeoc79K71AxOEMeCVSLBn21XYh2gncXdJ27k3YilqAvmeQTxhtXYFtmicjXkUf3MMdC3WchVt0qKz1IK8bq6ajo4S+hx1Lvmrbjtq3guLjFda1Wy1qPeIjsFlwB27rFwXQxTVJSed/xIibprHzxOFndrDc7SN8QKylasNPtUKbIzByiYp1FlXWLfMUpUwHELR0PIbZg28JwVDseQa6Jj2B0lp9C6glNeCTkR+Uuy41Pt7r0bRaR4yJtV/XhFX42HvdIC9Qjo96DCG/QvSdQ8ixGlUaLr/ykiMj7jKUbmSjh8lTgsptWqk+rhIMGsFZFgWOW1WJnAbzQobyuZtkOV6QOTM7nFCTVrZunBTWv07S1gj4AFWDKj/1fKYA5pjSbc2Ov+zGun88rpQFoP35ROsvR0SPwiLzzG35LPHWpmT2+Lk/vJ6bqPy7P0hSyIV9C7OyCc1Qe2aY=
Received-SPF: pass client-ip=57.103.68.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
(tag for this submission: hvf-irqchip-and-nested-v15)

This series adds supports for nested virtualisation when using HVF on arm64 Macs.

Reviews would be very welcome :-) It's maybe a bit unlikely that this will make
it to QEMU 11.0 I might as well try.

The first two patches are from the SME enablement series and are present for the
series to be buildable on its own.

Patches pending review: 14, 16

It has two parts:
- Apple vGICv3 support and necessary infrastructure changes for it
- Nested virtualisation support. Note that the nested virtualisation implementation
shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).

This series doesn't contain EL2 physical timer emulation, which is
needed if not leveraging the Apple vGIC. As such, nested virt requires kernel-irqchip=on.

Known issues:
- when nested virt is enabled, no UI response within EDK2
and a permanent wait. Workaround: -boot menu=on,splash-time=0.

Apple Feedback Assistant item: FB21649319

When the VM is running at EL2 at the very moment the virtual timer fires:
HV_EXIT_REASON_VTIMER_ACTIVATED doesn’t fire (when not using the provided vGIC)
- using a GICv2 doesn’t require having transition notifiers which Hypervisor.framework doesn’t have…)

and when using the provided vGIC, the interrupt never gets delivered back to the guest

Linux as a guest OS is fine with this… but the reference ArmVirtQemu edk2 build always uses the virtual timer even when running EFI at EL2, so it gets broken unless this patch is applied to edk2:

diff of ArmVirtPkg/ArmVirt.dsc.inc:

-  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerVirtCounterLib/ArmGenericTimerVirtCounterLib.inf
+  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLib/ArmGenericTimerPhyCounterLib.inf^M

Changelog:

v1->v2:
Oops. I did a mistake when preparing my patches.

- Add hvf_arm_el2_enable(_) call to virt_set_virt
- Fix nested virt support check to add HVF

v2->v3:
- LORC_EL1 patch was merged separately, remove from this series.
- fix LPIs when kernel-irqchip disabled and using TCG
- remove spurious if case in vGIC supported version detection (inapplicable now)
- Add hvf_enabled() check in combination with hvf kernel-irqchip checks
- cleanly fail on attempt to use the platform vGIC together with ITS

v3->v4:
- GIC state save improvements, including saving the opaque Apple-specific state
- Saving HVF system register state when using the vGIC and/or EL2

v5:
- oops, fixed up save/restore to be functional
- misc changes otherwise

v6:
- Addressing review comments

v7:
- Address review comments, adapt around Qemu changes and bugfixes.

v8:
- Rebase, and misc fixes

v9:
- Misc fixes from WHPX review comments
- Split enablement commit for EL2 into its own separate commit

v10:

- A bit of changes across the board
- move HVF irqchip save/restore into irqchip code
- block nested virt support when kernel-irqchip=off with a GICv2 as
we don't implement an emulated physical timer yet.

v11:
- fixups for the save/restore Apple GIC state patch
- block the same registers as the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
for "hvf: sync registers used at EL2"
- drop patch that warns instead of aborts on mismatch

v12:
- Have the SME2 series at the start of this.
- Adaptation for the SME2 series.

v13:
- include "fix SME capabilities reporting" patch instead of it being standalone
- include "remove hvf_arm.h include" patch at the beginning of the series

v14:
- Turns out that the HVF SME2 patches broke the build for pretty much anything
non-macOS, and didn't address that properly in v13
- Addressed some checkpatch nits

v15:
- Pick new revision of SME2 patches
- separate disable nested virt when SME on patch

Manos Pitsidianakis (2):
  hvf/arm: handle FEAT_SME2 migration
  hvf/arm: expose FEAT_SME2 to guest if available

Mohamed Mediouni (15):
  hw/arm: virt: remove hvf_arm.h include
  hvf: hvf-all: stop including hvf_arm.h
  hw/intc: Add hvf vGIC interrupt controller support
  hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  hw/arm, target/arm: nested virtualisation on HVF
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
  hvf: arm: allow exposing minimal PMU when running with nested virt on
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC
  hvf: sync registers used at EL2
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hvf: arm: disable SME when nested virt is active
  hvf: enable nested virtualisation support

 accel/hvf/hvf-all.c                |  52 +-
 accel/stubs/hvf-stub.c             |   2 +
 hw/arm/virt.c                      |  38 +-
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_hvf.c            | 822 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 +
 hw/intc/meson.build                |   2 +
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 465 +++++++++++++++-
 target/arm/hvf/hvf_sme_stubs.h     | 172 ++++++
 target/arm/hvf/sysreg.c.inc        |  52 ++
 target/arm/hvf_arm.h               |  46 ++
 target/arm/machine.c               |   2 +-
 15 files changed, 1668 insertions(+), 28 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
 create mode 100644 target/arm/hvf/hvf_sme_stubs.h

-- 
2.50.1 (Apple Git-155)


