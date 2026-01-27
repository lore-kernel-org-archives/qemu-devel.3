Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFC0D2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4W-0000Lk-3v; Tue, 27 Jan 2026 13:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4D-0000Hl-Dz
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:34 -0500
Received: from p-east2-cluster4-host11-snip4-3.eps.apple.com ([57.103.78.174]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4A-0007ad-Qn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:32 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 4585E180012E; Tue, 27 Jan 2026 18:45:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539527; x=1772131527;
 bh=MzMTGshWymY3momUyp4VGthJxenJG5EpURhNYbaicCM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=CZ/qrCHpyfJdsvhNHNDE3liunFZqQF/vr9fFN33BI+HHqm8OU7UrhlE0jD6UcQxepsmj3xlnYbVj6RWVM2LbJ8bG0YOMYMqRuCq6C57KecfQIDDLCt/QcCWQoE6OBobu1cMeYDRtvBNyq6FLyjfQDuLt5AuvB/WfaLeTZYpHU4JmauQYQEqR5xltW0RC1N7y0IxxFesyKhggaNsvEDqwlYXOYOh1Kpl2npHQU3NTfMyilgRbfy+aJ4DHevhZABNFT8jC8gTmAB5RMGVt6VMzGFYsz7/FKSTq1OI+F9wfYsutT151YVCSQP1aca+u76PCvzk8qkAtzCI8Q5GUxyy8Kw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 91CA718000BF; Tue, 27 Jan 2026 18:45:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 00/12] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Tue, 27 Jan 2026 19:45:11 +0100
Message-ID: <20260127184523.5357-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Z/fh3XRA c=1 sm=1 tr=0 ts=697907c7
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=GaQpPoNlAAAA:8
 a=WuN9omT6I3Se9lZnsf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: ImPMvj__lVWx8MioPhTRbTrxBJsvSPUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX/bF7X0oYIWkb
 +WncJXRGVOJJTjRPUmnwvY8EKruE+Gmh/oRpIPOirlQ9N7jHdb46jrMYzNM+/RrainZLBUCvFZm
 9sjuE+3KbCaznjaoZw3ouXQG+CKaVYsGeBO/hlpmyAvSEC5SMqD8+nyrmhIFLbMa6RIlcqIjK9n
 lFi/S3F8KDdRGvxgkmgTiwtk9CBQHFncelV8bNzCEGObMJmJdcXKtuG9Zzo85qZHFz1D8x4rffp
 6OMRq/3j8Lyr0zu7xhP8kp6Rn8wIXGajxCotd7qXFxBO/ij9hMRCl5n/VIjBxlQXzlCJRkds3c9
 gDovxj32HQP2YHStVKgKPz/bOQrOjSBrfINaYp6wlB0Os9TjEHKb9TC+6JQBDI=
X-Proofpoint-ORIG-GUID: ImPMvj__lVWx8MioPhTRbTrxBJsvSPUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1030 suspectscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABmZ/9DmM4c9/e7jlIudMwAUfkgwAPh3lmogUX2uwmWgCqBkoh2Rpy+BZsJVaZZ5ixmC/I3rEfaqcXIMAnaLb1ecisl1IWP+1rEAraCtq+VXs6NwA8cXS6sFY06MPRFDACld2DyVc2zzNyz1mkXDxxD6SUaFB8Mv4Pd3QnW6yseB52ILq+c7PJ/rU8k4AkFj3dnvmwD4lZByC4N1lR6aP8Q0rvaVd/txvwEXfntqoMMBeaH0uQPZhozSSZCKu01gbo8y0TtVwaQzqyFb1C6nWWmm64OAVBJpKZOzrCCVJ9VcPxlTXK9yKganUepakyZ3lck8jyrPlsp4rTZFvK1jxwRaxzWxyMCTje15vADQvcX0g7rxX4VMd+NVKzVzOIvUGQMb/jAGX7HShgF3N8JKEhFqny9nJ82rd+JwdkMROHhOvnRdo6WBDcYKsFOCeYkLZqGtT9B5gbrEvmURstI7QQTI/ewgyh93PXYV65bPDP3IyLdOCFXnuPSchO4+TEek9PAe6pAZDt41kfCe5mcSjo6HLCOt3vL6DfM2eUKWNgkNqWsWLgIDlFp9Kla8HfwcN705Z6u0Uey3cKhasx5bbe/ZN2zlV1h14ep2L0TM2HAhtwiwO+YA7L0y9txTQOE3Oc2q3WC6HRJUcww/uenkQPFhbN3vZ+SXWER0Idb0+lqGsZz4WSOnGDYTJ2NhnifemOE3nbPs0GlKhrwoG8OcG1ft9IP3hqAdFGTfNlRIqC
Received-SPF: pass client-ip=57.103.78.174;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
(tag for this submission: hvf-irqchip-and-nested-v9)

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

Based-on: https://patchew.org/QEMU/20260127182805.73212-1-mohamed@unpredictable.fr/

Mohamed Mediouni (12):
  hw/intc: Add hvf vGIC interrupt controller support
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  hvf: save/restore Apple GIC state
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
 hw/arm/virt.c                      |  32 +-
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_hvf.c            | 735 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 196 +++++++-
 target/arm/hvf/sysreg.c.inc        |  35 ++
 11 files changed, 1052 insertions(+), 14 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.50.1 (Apple Git-155)


