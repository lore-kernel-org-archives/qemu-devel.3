Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6F3FC9EDA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vync4-0006ef-Sj; Sat, 07 Mar 2026 04:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vync3-0006cD-Al
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:19 -0500
Received: from qs-2007j-snip4-11.eps.apple.com ([57.103.84.231]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vynbz-0000x0-KN
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:19 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 06A09180010C; Sat,  7 Mar 2026 09:06:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874374; x=1775466374;
 bh=bMviX6CjvJXpU0/srrRjhZNCSk57GTzIg5d9+IPg3+I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=JYV31a2N5EZ7SQNj9Th1Ysdc4Ppf4x7WX4D3InxT5NeTopHiFgXh2m1fr31lhZVv4P26/FqL4kwNt7bIis9yysaijyjeMLwETip/MRRaroyUnO7rDh9LMs4sVOMn4aODsZVpy7WMfiNonOVaBJRjKKRy2/DqDaTa147tWQveZY6asTb6xiP82Q85VngYibKCUuCAV60SLYz9qUpc2Z6oPWrrw1yfYgxE+l04U3MVECTVvPKnVp4aOHNHfPAe/SSSDxg8/6C48tuMaTpFuejoYbvSwdKyInXjud1YBApSgbIDZkpDkFQyBqiSEFxISDhQyy4hb/j5jWJhQtgijp0Ceg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 BDFFD1800125; Sat,  7 Mar 2026 09:06:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 00/14] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Sat,  7 Mar 2026 10:05:52 +0100
Message-ID: <20260307090606.95300-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX2047ZgkZUVtV
 ckMBHrKG9N6rKxwITGaGWpoysqCy1WNGHokLlN4HcrGQy4Vg6C5tAXr/bQnIA6gCou6Y+Doh3Gm
 /of2ms70mL8ZVQ+aJ6OxkJ/xCpnH1OjRbmm0nj7Mzr8gV6zHbtIgSB3ZsbTg+pGqIoiFQJGH1j6
 MKkfT4RqzXiQfUqVw+or9jE9M20hJ2TQroeKIo8jKuCDoO517S3jQ7KM8MLq+4tImyuYOky+Ey1
 SwblzZ6lxb1Qh0cDpf1HZrWmwdZ8rYn7buRse7GS+O38ODO5L2H0PZUWEmuxrOWkY/R2dNZaH6D
 ji4mkYA8nYJOj45ZUzkVOdYWkPk3Ndwj1siGrLxvVFL9XQVxz9ZTdKrHOaaJTc=
X-Proofpoint-GUID: hC6BnlmUJEgmcu7wTPVlFPJTNv7E6SV9
X-Proofpoint-ORIG-GUID: hC6BnlmUJEgmcu7wTPVlFPJTNv7E6SV9
X-Authority-Info-Out: v=2.4 cv=QstTHFyd c=1 sm=1 tr=0 ts=69abea84
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=jwI92-NncrociDarPsAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070083
X-JNJ: AAAAAAAB+tF+YYLEG3ghzWoGC9AVWDARIPWsNHiInp+GeBodAgTkBxxbxzFRkMpKrzgQMUgFtmAFpImX7jnQ2MWC0mtSqgqkjEpgWEcsAse/JrDtyPPgnobgbabv/hz06FL84xIbAnq5micxs9w4bkydx1zasX9fVOUsMVjofrZB+jPPUwiBTZXB9w2pkUP1KXeP9Cdh999DqPNeAPKJkBQnA4dTtrGnRzYVnP96V/aqGnQyD/QDKtAlaXQNV+fDFxuRuSXdWbHppvxC/wS6ZlGfz8w70ddhW92FcMON8NdPwk1dRYhusfv4Pg+CmeSul4dX/gRTXLNRLj3Q0dXSovLzo54DEA7RjCQLMXTKCf89w4Z9DoE3yYQRqbE6+r/h4x3f0/+/MmEsdirQpi3jUnpxglDA8idhBhPxoDmntucu93c1AiaJ79tnySArxKMIn72PEUb2cOhq21WqG5J9kPOYXpI6yQ/OYWUSJgp93fAiN5nSYBYdzBRFGaZfEOl4GpZkF+SLwUnHwc7crrN6O/T5IQ393/EA7GAAzHv5xTAcTyypY1TKzDWHQu0/iAHEiYurPRFv2aHWeEHrYluXtI+twXKRSwv+RkCnZ2buQQoBrTkuHHIKCU9+hAE/8ouUzKG3mBfnru6pXX5b9SOtb/Za1LhNmD18JgCWvta9eq+Tc02ndRQsNQ5e+aAWg5FjmMgLBzMFJPDfXFwO/GtW3iyvzFyYCXmFH/woLG2Z0VfmibnXagXEdj6R5hzkj4QETocXIV9nynhzWoRt8XB4ziXGxg==
Received-SPF: pass client-ip=57.103.84.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series adds supports for nested virtualisation when using HVF on arm64 Macs.

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

Mohamed Mediouni (14):
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
  hvf: arm: move SME2 registers to common hvf_sreg structure

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
 target/arm/hvf/hvf.c               | 212 ++++++--
 target/arm/hvf/sysreg.c.inc        |  58 +-
 target/arm/hvf_arm.h               |   5 +
 13 files changed, 1174 insertions(+), 64 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

-- 
2.50.1 (Apple Git-155)


