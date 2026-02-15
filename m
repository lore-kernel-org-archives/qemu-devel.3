Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD66EEF5879
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGW-0005Jc-LB; Sun, 15 Feb 2026 06:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGJ-0005EZ-Ug
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:05 -0500
Received: from p-west2-cluster1-host1-snip4-2.eps.apple.com ([57.103.68.5]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGE-0007vo-1O
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:02 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 C1DE5180018C; Sun, 15 Feb 2026 11:25:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154750; x=1773746750;
 bh=lMGtbgGdc7f2D9dja8I8WjH6L0KvmZvLjdtJ68y7sSM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=grZFuFHm/L6jWzaxiLckhubxFwVyN9Kqv8MZYZhH70heLblfHmftzLV7uW1nOdlBhh1xSMcFrze+HbAe8v1na8vvkD2NSxHIRgkGT9XcPgyiAgX20ulFYwx6vKzMzf66m1huVBHvwxueVB3PshY+6EYhDiKx8iUu5mTFpcAN/I+24TtCCAe8F5qSo0FSvZPvqM0kDkf2fx8QjEIa/PFMvnfJzsrUSdhBybk4nSwPzW6WwNAP0cs/5H6cfLh20kstF8bz+zhX4NFnnUTn7MlKwB7oH1/WU1Avm7TChyJqAENkSFKOmS4N2tPtqIhRJzMS8s09rX/BL2M0kw/vxrn9tA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 05DBF18001B2; Sun, 15 Feb 2026 11:25:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 00/14] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Sun, 15 Feb 2026 12:25:29 +0100
Message-ID: <20260215112543.4817-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX79WI69dm+TWX
 d4lzYNuR6UXZEnTxa3zBToCA4/uv142BV52MNagI7mYAvhne8g9tQDsFWz3FAbNggDRC5iMtSDZ
 sUmtcFuLWRfURrfwMbag7BjSYwiJMHepkVQM1Pxn3nDASsOYnIdqm3u5XQN0shrrawPxfGlF5L+
 K2S0sqDjpDc65M6wDP4rTjgCRXCvQgMnTyjAxQRaW2yG4hQrtB4vb+qgdHDPwa1zHZs7TASGdjA
 XizzSMcremhfg98gU88rTd29W1J/L3haumBKteFcgMluuQINpGOw5j00OoNMV2f84OiroIq9iWy
 iJzmTf0E3+5lAKaMumQklWPXlKHoBYPsaiq4dRvTig/95v1WtqBdKANOqeMO58=
X-Proofpoint-GUID: KzXMeYa_qZ6bf7K2EJ70bJhLT23M_qKm
X-Proofpoint-ORIG-GUID: KzXMeYa_qZ6bf7K2EJ70bJhLT23M_qKm
X-Authority-Info-Out: v=2.4 cv=EPILElZC c=1 sm=1 tr=0 ts=6991ad3d
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=WuN9omT6I3Se9lZnsf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABPBzWhnS8+3bwBcBEpWwS0GWjjPsZwHY+BfUXl80A6gU9rjgSmVunLRPT9s4+JR81TzcuDRGFX4etI70tkpaVjCWDxUQXmmn6UXr68MKgyXUpUC/BOP6QWbvUSgaawbWIH3cEJA6CrNbqS4uQvOMWMQ94RUUIxoP9d7CMsEMqkDBZz+9HJ1AnummG+JshBRf+ZpDjFpmif+p+Yg7Mfky0cANjzSZOTGIl7LA1H4g8kzYzW2qdTuhbxrt0cDJg9b0SqA9QHa0exCRjwF8EyjwhY0vasv3J1Gz8O6Qmhx1Z/9FFvCH5lVVThKlUGHJSB9pDRZpBJkSmzALb3y1ld+ucxx7p6nScxSQ1tpxERx7biYREXtbBmgTq+VHtaFvUpq7uKGxpd8GM5cXRjT8OrPaDTLofaqdEAYSNMFjIM7ruQjrIFVEBT3bUCr9ueJBeI4tjuRrOZ3SW6ENtcwr3brPEOmO9Br9GfCYpstlOO4qV2wasn71CaASYrpjJ06LrcwSNCFgIFX4fIp1Ps7b2/gytN3RHii4KSTsS04zmpH4q4Tkc9zBQDqfA7znJExfY3Sl3Gff/VaIvkjjs0AVu9BwzxjCKAYluT7nf9lUKwT4/r45PEt1H4VBNIxxskFWr3AaUsuJY9T7ysLoX83aY6UZKCEsSygIA7jP8eg1JvDsP6rqgnB9GbxC9eBBJnkWR8J1jGIc0J/mo1ckFKqkkjcvgJfIPw2OaMnucqF59MGKKWvDGvmnshT6GpQch
Received-SPF: pass client-ip=57.103.68.5;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
(tag for this submission: hvf-irqchip-and-nested-v10)

This series adds supports for nested virtualisation when using HVF on arm64 Macs.

It has two parts:
- Apple vGICv3 support and necessary infrastructure changes for it
- Nested virtualisation support. Note that the nested virtualisation implementation
shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).

It's rebased on top of the WHPX arm64 series.

Known issues:
- This series doesn't contain EL2 physical timer emulation, which is
needed if not leveraging the Apple vGIC.

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

Mohamed Mediouni (14):
  Revert "target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0"
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
  hvf: enable nested virtualisation support
  hvf: arm: warn instead of assert on a write_list_to_cpustate mismatch

 accel/hvf/hvf-all.c                |  51 ++
 accel/stubs/hvf-stub.c             |   2 +
 hw/arm/virt.c                      |  37 +-
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_hvf.c            | 818 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 +
 hw/intc/meson.build                |   2 +
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 154 ++++--
 target/arm/hvf/sysreg.c.inc        |  35 ++
 12 files changed, 1103 insertions(+), 39 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

-- 
2.50.1 (Apple Git-155)


