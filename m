Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E5FD0048
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUW-0002R1-Aw; Sat, 28 Feb 2026 17:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUS-0002Pb-Iu
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:49 -0500
Received: from qs-2004e-snip4-1.eps.apple.com ([57.103.84.44]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUP-0005lL-Ra
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:48 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 AC4AC18003B5; Sat, 28 Feb 2026 22:08:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316524; x=1774908524;
 bh=9UDqeceqRziQOxDtUvJSIxEFXXJH7Xsd9madfYHPGRw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=enPJB+3Qox4EhjACxPl/yQqq/g05YGWBojNswSVht7rXNv8W3a91/tqOSNBc5gvc2VJ6xrOhTbmsYjM1yaxLBo+U3mnbPgOGe1OGbwS9548QShMC+Wn50XdsRTj1hPqbqKxr8uX0nQ3QLPvGmW6IkZvowphK/gktOU3UiVjTpQkl3Mi+ewYi3KjNbj88RGy9lJa+lsfIxdPn3Rz0fFlC3NYu3Ppr5L5KQnNvOW3uzJOZkitTV5rBdrIa9gr8F3KCKREz08AwRckLJGqAwbRdOlXJlYoR3K1PqsO6gYUGaDyiA79/TCRh8Wkdse9MayY/pAhoqbrWlh88m5h9HEjhKg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 B0F97180039A; Sat, 28 Feb 2026 22:08:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v11 00/12] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Sat, 28 Feb 2026 23:08:25 +0100
Message-ID: <20260228220837.35275-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Oa2VzxTY c=1 sm=1 tr=0 ts=69a3676a
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=WuN9omT6I3Se9lZnsf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y6f_mmkDEi4-1J9FIJlSNCkhIz7Iqx6U
X-Proofpoint-GUID: y6f_mmkDEi4-1J9FIJlSNCkhIz7Iqx6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfX0GQk9+t4FFjZ
 C/PjTU6Nk8sVXfOlOG9lWh/HdZugp2m4GCeCdXkjMji0O6L3zjJjTNa7Sw4+0ZK8PMoMMw47opo
 RRzs+pVlIKUPsXq9bsyMv3SPERiWp8S93ZOBKnh3Mc1tkeqOG+zzI3v3iCigXrDZ5sQATebaIfD
 HQsMlf0s4ab9khOOdhxU4r75lX0Ouy6D826gc09Kyx3yWcNmStATQoyAzEnVQ2Ngi2+TnSsi7Mn
 mqPjKVnKPt9WFsFunbxSHR9ebj0YBwOwKkEkLA83dqn//4ElqgLuEnZLbl6dvEDGtnIu2/HK1el
 wL+juOsXnMzYbp3Y3tL2d6iYBky8uEzYt9L799jKh4KBxc6RKC1j1ldxBpzcwk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1030
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAABd0FLWN/6hOpFk55ClYPW4bY1dlK/z5bu5kTApXcU2S0HPebOW2IldvZ5aBdifmP9gEfqxlai59aeI18rQSwurDxgr2lOpsY1EanSP7VKZeJivtjCppX7Oelgz2/f5aYrC9BCBAImLppC+i9LvjJqXqt+20P+3ZXLJpuV90Q517LjlLS4SDP8iR7sOrxMqG2O+9sumAbekB1YhETFkiwzJQFJwHk3Sf+A7D23wl13Hxcgi94RdVMfcoZZOTg6hT2dReMs01fgelBoM5s4N/NkMVXLnw6slxe5YOggZoTGOjhaVgEc9En7hb4X8PpX8B0JqN38VJuIszs30bt3zJniQq6OCbZDqm4ogWmKqKMgS5GQdjwqX4H5FaEY1AwUzXAM9yqvA6G7S61QCU63Dh7eFG0WxafiKxczEt8NUvJ5DiBRp+Fu/QFpQlCIzbWYlorAFEknit2ce9u/YtbEJn4aNejV+oWn506VyGuaWTIu++dziM2F1WPZ2UrKos+IZXuInVniqbPJZKHK9n23LiW1jSl2LsqX2QDLIe/ZTqu9Phxr9ijKm3rVmQ+69N28Bu1QJybyOJ9DZv2K+7n/ERREGSCb/Fp8hZJJWWSd9UX7jEvFhDv2nkRJ2uQYJ18Yl8T+lPzF/3/S3dilvpWkc86a+8K7f1V0iqk7dMEKaKzSjV/D2ljOWNZtaN8Q3JiZa+zk59M01PmBArkr4X18xR/4V7bLrWX/x3FfG4f1VOKzJrYNqhxiqkKTcwYc
Received-SPF: pass client-ip=57.103.84.44;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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
(tag for this submission: hvf-irqchip-and-nested-v11)

This series adds supports for nested virtualisation when using HVF on arm64 Macs.

Reviews would be very welcome :-) It's maybe a bit unlikely that this will make
it to QEMU 11.0 I might as well try.

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

Mohamed Mediouni (12):
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

 accel/hvf/hvf-all.c                |  51 ++
 accel/stubs/hvf-stub.c             |   2 +
 hw/arm/virt.c                      |  37 +-
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_hvf.c            | 822 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 +
 hw/intc/meson.build                |   2 +
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 124 ++++-
 target/arm/hvf/sysreg.c.inc        |  45 ++
 12 files changed, 1112 insertions(+), 14 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

-- 
2.50.1 (Apple Git-155)


