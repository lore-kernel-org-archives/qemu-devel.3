Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC11F513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdJ-00014F-2x; Sat, 07 Mar 2026 10:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdH-00013S-2s
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:31:59 -0500
Received: from p-west2-cluster5-host1-snip4-10.eps.apple.com ([57.103.71.113]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdE-0000MF-NW
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:31:58 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 D95E9180013E; Sat,  7 Mar 2026 15:31:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897511; x=1775489511;
 bh=vut9BTMGTNyfEdyPTkaWdMqMO7t+5UPIcg4WxfqBYVE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=chkutCx5kdulkry8jljrC3t7r2Up5FnS05Xb6W6TASe9tXaeQLbO14jsiTVv3E+EH4BOLMJ7MG7isOPwhWx/+jyiV3duz2mWAUmasC0VhWuZAINGQs0NjC4YBbMyR32oBCoLKwrYOaOEYwjOrVJOELCXyz3W/++AZRDgVB6tIxApeXhAJy4A7ngEivp54EIBmnW3JvkNt+rbViVacmISa7ek5y1DNrlxyYKoJQX7uQ8Mb+f4X8IinA8F/sfnLrGTLUQU6woifrEFNn5jZMYhK0879Tgkk6XZ/HEdiYB60pWjR+yPcg1UFTh3Q01OMymxWmiECrWl3m4AYzRM3N1YUw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 D45DB1800142; Sat,  7 Mar 2026 15:31:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 00/13] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Sat,  7 Mar 2026 16:31:30 +0100
Message-ID: <20260307153143.76893-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WTDkSIyPq7Llw_NYqMTQMjugJS1Um3Up
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfX1/bmbyhMQDkB
 iZlRFWNr7N9eMqwfSwKidi415hYsCReYB6GmW5oY9lYhKM1s5fRafg1vLjnnBj1jnDKKC6v+cRl
 yRV/hncROY0sYRCaxc58txkor94q71QvN9DcFqrvLRxEwX7ShmU7jcujQAP5vbiyWKHNpjE0arE
 2Wgh0/vlBe17pkn1E2RAWcMyc78qKs+LpR06B/v3eo8AvpObBDFUjdpotd3s7vpRtmgaSLy6cJw
 fXjOKkCtIuTb03g6nmHq6t75Qjfe4mLUlzIaycccbGI9jH+Sq8jekY4BeJomEJqm4yAa9piZ4jR
 Xkl0jAtea9wBTJbf7POC6DfMGByGiFpPo8k5vsS1e46hyBBIdJxvRlKo5KzOYE=
X-Authority-Info-Out: v=2.4 cv=KNtXzVFo c=1 sm=1 tr=0 ts=69ac44e6
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=jwI92-NncrociDarPsAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WTDkSIyPq7Llw_NYqMTQMjugJS1Um3Up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 clxscore=1030
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABZk3jGads5zPI3u2EjYlhsfuzG1FBz3FhqXPAsQ1m27EwYYhmmT2g3RxPJVb2EpTP0jT9MzxoIBYzJ7AWPLFuXZN5u4bCLRhkBTKN9PLnXiTj7pJtP2C2phyvsE4xNpJAgrkI4FT2Y+OfjKhd3SnljARLXdxX9AGVJkHUPCvSgVfs6lw1npkPKMjp6TZuxvX1w2rcFTvYNSFaBXtVt+UUpdP/WXolWcaTpyQxEebn4DSDoXuOpWpKWEeMh6yR5uV3WRVmqzutRT9dyUJV9MtlIZz0uKey+vXY6FQBZC0zqGA34v7BeXD3beqG9mazp5ZWzRNLgaUwVmaXV6h7/UawFoNvRcIiz8W9SVBJ+Hns4VglPtgYAW5muttPg8RBGBFvtRpOEfWeOcdn65kXVSB9ph0SUvdroIu73uBcquHp4zCet5V9sB6EpMDZZH+ItdV4HfanVfhy1JqIxf798IWV80sfyfOcxAtJOhSiS16WjeoUg2WTyV9FQx2uGlcK0elj+DyYauuITFg9WdDzIJbitP4GRQ1W+xE8d3wrRmKI7BLmygtqWh4ruv4dDXsnbJnQNrJHo1QPF3beMXdslkOosX5UqIZcqcCAM0qapn0n2t2fLOzRrfYg2S8NUGyKZEnGy29b7a+/3NKA4xEX1ovYcV8rFOHe/4T4RHWZnfasy5daVcXQG6Uym4nB9yB+lQNrPS/Iirc5wwTtQl2lBCFImpqqqJHPu9CA5Rmgi+HkHjFIeCERkIFbALsVHzddKlDaAlP/CW64AQ==
Received-SPF: pass client-ip=57.103.71.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
(tag for this submission: hvf-irqchip-and-nested-v17)

This series adds support for nested virtualisation when using HVF on arm64 Macs.

The first two patches are from the SME enablement series and are present for the
series to be buildable on its own.

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

v16/17:
- Availability checks as needed except for the vGIC code, where they're
just skipped instead as availability is checked elsewhere.
- Some tiny cleanups
- v17: one more (optional to take) cleanup commit

v18:

- Some tiny nits here and there but that's about it.
- Drop some patches on top as CI isn't ready for them yet

Mohamed Mediouni (13):
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

 accel/hvf/hvf-all.c                |  51 ++
 accel/stubs/hvf-stub.c             |   2 +
 hw/arm/virt.c                      |  37 +-
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_hvf.c            | 828 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 +
 hw/intc/meson.build                |   2 +
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 162 +++++-
 target/arm/hvf/sysreg.c.inc        |  44 ++
 target/arm/hvf_arm.h               |   5 +
 13 files changed, 1158 insertions(+), 16 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

-- 
2.50.1 (Apple Git-155)


