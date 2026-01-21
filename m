Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FEEC4452E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjC-0008Qy-HK; Wed, 21 Jan 2026 08:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYj6-0008OP-Io
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:30 -0500
Received: from p-west3-cluster6-host9-snip4-10.eps.apple.com ([57.103.75.93]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYj3-0007D4-LN
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:28 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 532561801075; Wed, 21 Jan 2026 13:58:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003903; x=1771595903;
 bh=LvIheowFj/X8dfnBttN6wbKqGOUUKKltaahWWssdl9k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=WuOIvfrurYPaMNGy9oH0LXEbLrEvCqWAHKhQrYHEq5xtNvz7tqZeEb2JNqZuqynHt2snmU3EGLWx1lWz94Zwv/T/HchCvHuomBLWH1/UsHajXsO9XKSx9a9CY1kV07eK9pOF47q9vvAcoZXK/xDXvWrAN5h19G7C+deM7hqQSChoMi9lL8xo2lZ1/mBBPVzhdpLZapTSdRv2ihY8vY+aIg7uScZuLPbXJdana9Bkto0XOyMMGsSBOGbU8Q7xa3ZFGsZkGrMbkZaU7dQYYiChyNDz+gL3kx9trMOcQlUL9U7ylx1WL1ICeUJHjWYuZQ/lUWCQNsMiiqZt8qTHOFtjZw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 F01EC18000AE; Wed, 21 Jan 2026 13:58:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v8 00/11] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Wed, 21 Jan 2026 14:58:05 +0100
Message-ID: <20260121135816.21258-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfXyn7YFzLSkSSD
 2ycLW7P6lpBtKlC8vb8DgcKqQj50iWZdVFpgTN4uC9qgzATAUHWMNwa/YqwNCUbt7JEElNbTUr0
 A3guHgry742egQ0kgBFWHsLFDt0JB4vBR5c13OQwTMMq+e9HskQ5y/6f08ubkOMT+0G1lyNDLJl
 SBy+DsI2miCc7mae9GMyJr4yhbFMTWExIutnME1Y+Xz/Ya9wJYk06PL6576p9ps8S6NAHrEZHOE
 vWEnk89UOx2wdCBuFZ0NvD4pZQ8VCfEtjIPcmbWf4c8N/Z/DC/e4Ryi0IF3d0OjbbFs4CW+WYu6
 w+V+Au/MVb4tDeEIJZn
X-Proofpoint-ORIG-GUID: 1P1hZqJUmGvSVUwnaDfMa4P3MJ8yFLtF
X-Proofpoint-GUID: 1P1hZqJUmGvSVUwnaDfMa4P3MJ8yFLtF
X-Authority-Info-Out: v=2.4 cv=K8ov3iWI c=1 sm=1 tr=0 ts=6970db7d
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=GaQpPoNlAAAA:8
 a=WuN9omT6I3Se9lZnsf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210118
X-JNJ: AAAAAAAB7k+Al/ZTp2BHViZ9pDh+lCGGwXWHjirNJNKgEVt4DzO7Wsh9iHh/fBfbfqYK9NKs8nw6S7YIbthO7ZGpjZbTrwrHaiy2JRswlcbsAK+MWYh33V1qQgbqKQnMezX2PslFG87lo802FFr9d1XB1Q4yl0/uLeQZS23sJPpBU/clbhH8BlOVHj0F5a4mJmPlDcQ8z8RTkV85acwunqqL978BK7Tfbc/KQDNGmZnavunCqVqWCE35tjKd+BlGJKbD0d01wSsmKtJe6A0gEDTmnImSnp/kYtIqEAyyi+6qDXjPFVLL+J9XHH6OuwCul+FHNElx6YR7ORfS+tEuWa+2KlYqKY9xHn3EpoFAN17kSmYwCMuyMgLP4qMwUTZEPvJ8RwHUKRKpwBi4ldNAdl1yU3Cydg1ZBvssl1V9T9ckGKY/hsPBKOR32C03QhZUWN0j8tFE6L9N0S7qxUFWdWOU7/wE5L2k2fiDVPVoXy6KuwqApRF49bH1DOt2XlCwxSuCgfd+3o548wO8OKSog+HroU9BftmnTbuIThPp+OB7hb5EjALrld7ykH5OETRpCTDcrLt1ZqwF/ESCvhziRIhaB0Y35+5gmMOjzYBi/BRs10Q0e74lzCdZ1ssaIBGuu5mtZmRWj3LoIOl1X3CggMTUiOV4U7S+rW+WZhCw3ZOAZDEo+d7MHm+B2QG5yfcqk650BHqf0zehAMbdoUMKl7aR7LRxsAS3rMVOjig=
Received-SPF: pass client-ip=57.103.75.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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
(tag for this submission: hvf-irqchip-and-nested-v8)

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
HV_EXIT_REASON_VTIMER_ACTIVATED doesn’t fire (when not using the provided vGIC
- using a GICv2 doesn’t require having transition notifiers which Hypervisor.framework doesn’t have…)

and when using the provided vGIC, the interrupt never gets delivered back to the guest

Linux as a guest OS is fine with this… but the reference ArmVirtQemu edk2 build always uses the virtual timer even when running EFI at EL2, so it gets broken unless this patch is applied to edk2:

diff --git a/ArmVirtPkg/ArmVirt.dsc.inc b/ArmVirtPkg/ArmVirt.dsc.inc
index 643620371b..1bfe7b67fc 100644
--- a/ArmVirtPkg/ArmVirt.dsc.inc
+++ b/ArmVirtPkg/ArmVirt.dsc.inc
@@ -101,7 +101,7 @@
   CpuExceptionHandlerLib|ArmPkg/Library/ArmExceptionLib/ArmExceptionLib.inf
   ArmSmcLib|MdePkg/Library/ArmSmcLib/ArmSmcLib.inf
   ArmHvcLib|ArmPkg/Library/ArmHvcLib/ArmHvcLib.inf
-  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerVirtCounterLib/ArmGenericTimerVirtCounterLib.inf
+  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLib/ArmGenericTimerPhyCounterLib.inf^M

   PlatformPeiLib|ArmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.inf
   MemoryInitPeiLib|ArmVirtPkg/Library/ArmVirtMemoryInitPeiLib/ArmVirtMemoryInitPeiLib.inf

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

Based-on: https://patchew.org/QEMU/20260121134114.9781-1-mohamed@unpredictable.fr/

Mohamed Mediouni (11):
  hw/intc: Add hvf vGIC interrupt controller support
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  hvf: save/restore Apple GIC state
  hw/arm, target/arm: nested virtualisation on HVF
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
  hvf: arm: allow exposing minimal PMU when running with nested virt on
  target/arm: hvf: instantiate GIC early
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC
  hvf: sync registers used at EL2
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1

 accel/hvf/hvf-all.c                |  51 ++
 accel/stubs/hvf-stub.c             |   2 +
 hw/arm/virt.c                      |  32 +-
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_hvf.c            | 742 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 197 +++++++-
 target/arm/hvf/sysreg.c.inc        |  35 ++
 11 files changed, 1060 insertions(+), 14 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.50.1 (Apple Git-155)


