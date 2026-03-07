Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301F1F55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw09-0001fS-5N; Sat, 07 Mar 2026 13:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw05-0001ep-Gb
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:41 -0500
Received: from p-west2-cluster1-host5-snip4-5.eps.apple.com ([57.103.68.48]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw02-0003SM-U7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:40 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 62ADA1800635; Sat,  7 Mar 2026 18:03:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906617; x=1775498617;
 bh=rYZgDohogmMyMPo2ukKZ4q9AqtrQdEbHqiJgDZC3Fto=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=SOs+SsQ1FeRYdrs6PxOL1JpI2wiffG8pJLtuNm9XT6ejPLnckXIIKb5Rlr41AKmCXk5GSaurnbX4oLE0wQyd72d67rihANNL/Gd8kKEbJsTj4NqgSm1uzVtSj2R3tTa/DyYq+qrb66cOMMSO77u3j2RXrv0FKrFaXacuV3GynukEm6umzPqsZci5zot3F0HMAnTi+gm76z6X3cWc75S6EaEate1MMWYCgz3J4jk0GggsAsAqwInhWw+xW3BLRov3F1y0yv8WsjKdhE3ARFZZmPC03J9w38njz8x6g60AEuchMpdpMz2kRaFD8rE/OoHxOoIylVC2pX8ccS3SvBjiPg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 D0017180018B; Sat,  7 Mar 2026 18:03:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 00/13] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Sat,  7 Mar 2026 19:03:17 +0100
Message-ID: <20260307180330.75168-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=T7iBjvKQ c=1 sm=1 tr=0 ts=69ac6878
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=jwI92-NncrociDarPsAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XEaiXnLLuqssZHX2WKGiPH2U7f-LABK2
X-Proofpoint-ORIG-GUID: XEaiXnLLuqssZHX2WKGiPH2U7f-LABK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfX4x1Ie9LEu4tU
 r7B9boNaUshRQ6F0IBwiG20ymsSUkSKckFQ2Qwg2Ir+2A0A/1RJfumLiJVeDxKLwllAwaRgNgDU
 MwSlffY+F1SdcaYy9UNrTB20Dv4TCDvNPybpr90btvRpvcSST8zk4gpHHk65RZeKh0+hsnVLJO/
 VAA43sr94Mapg3IT4sikdoZWbNdR/pyHXXNXN0NfaVOiCb+bAgKjG6VcsXAzHS2jqWqIoDKP/1O
 cy8xiRhYDvFnlmnjeFEL1HC+g5KrCZzcg+hF7IDBlv1XxcwY05TTV5HKnBxmb/cePyBhQguPHtf
 b3nozK/CyuFvOepxnaiCf11HoP1rF87UUxmYOqdmI6NPdiJAt0XrNSjiORK7c4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABK4f2xzi4cAyWQbK3ULAp8ULatiWAwn2/DR0U4QmJ7TJMdzRfkmz4CVdED2s+NXTJwqjIw7ltF78madFB3rfAlt6Km5X7nRvMXv9md4RNHeC1q4nm+8y+NfbSWLD53PNQscqSClOHO1tNSy446zyS1nLteJZzXiI7aqWT5AESE2HIzgtz3xeMpJdPg7pwDxaFcK20fHC+FHH+jqPI/Azo/hkAl7ajpT5mA7r9Ct5VJNGzyIWsggZfnUINNA3HsGqadNKg3rFm1xBF5QMlF8vFLa7IKDQrkMTjceS2iwC8dJiVs1deUCJ5mL49cyd/CCVm279XL0GuNCojzZJe5rIBvmhTPYRBbb8YGyRPta4fJY360/7IuA2Rcw+VzVXapQDNCZQ2VZpYUUzU+I43o0VIAyUto4dCtlvqcSMChQEMue99+a/cFX2dOOhqCSbjc5vct82o6dnYw7QSz3YXTFQ+9y9vqYXBjC6lT5dKQfPkkLbK6RJ7PyZGlSkr7O4wfC8N+q8A0XuH+9HN7VfMJfdSFwGCuCcGAc20TCfEMmK+MoAgTWVEJq+5HXbjQc820DBF9/ENO2O6iFqEjYrwKQXx8kQ8g9tWmwkgPeniqfi2aw1AN/nqMGExsj8lfn331J37XyafJR+3lRRkhgBV+b8nXHTnDhdqqaUj2kRC7jS0C4WRdwTY3oH44zfwueX2GQaT6wyrA7fuKTC2jMlFfa2+7h+nLwpO2c3Mdo2uQuL2sfzWmHN+5qCF4Xi5jUpSB63odha+vceXhZDVtcF4
Received-SPF: pass client-ip=57.103.68.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
(tag for this submission: hvf-irqchip-and-nested-v19)

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

v19:

- change hvf_nested_virt_enable(bool) from a macro to a function call

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

 accel/hvf/hvf-all.c                |  55 ++
 accel/stubs/hvf-stub.c             |  11 +
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
 13 files changed, 1171 insertions(+), 16 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

-- 
2.50.1 (Apple Git-155)


