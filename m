Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B6D3CCAE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFK8-0004aj-SI; Wed, 14 Jan 2026 23:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK3-0004YK-BA
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:03 -0500
Received: from p-west3-cluster2-host3-snip4-3.eps.apple.com ([57.103.74.66]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFJu-00061A-0v
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:50:58 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 796DF180011A; Thu, 15 Jan 2026 04:50:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4dVIOoxiDJqQysET6P5MQ1tN4AIn9LOjO55WcY8rxT4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ZymhWPjFEPkwFXucM0QRA87B2QuspMh5Lyuq7PYKg6CEfewX7Sjfy2nsumLZIcKYSQ0Jn46k27a/lW91wo/wSp/r3KwMUxb+aLFuhvaX4VTCeZCgJ6Zn50EbbCdWg6XJ7AbHFqF6OHB6OeRwfQEPlZsZKbAlhRNjOQ60/qTuRDNAt2vGy+VS6v1dITK4850memFIlCqrRiEXBYypGI1sAkX3fuBS6hszd/gEctCgRNgMy/S2cBYMHF0OsK35IfqFCiiGb54H4BZ2t4Oum7CK9cKuW8u7qeJyXtOF35frtuFdodJBQxfivin0IuqoihBUsFGJrrk5WzOdUNsGQm5g5g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 83BE618000BC; Thu, 15 Jan 2026 04:50:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v7 00/10] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Thu, 15 Jan 2026 05:50:32 +0100
Message-ID: <20260115045042.70086-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=NcvrFmD4 c=1 sm=1 tr=0 ts=69687229
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=98XxL82NnNWUS95TIaMA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8vY0Z04PXv7xVtW6XyJMyGIeh-un7ai1
X-Proofpoint-GUID: 8vY0Z04PXv7xVtW6XyJMyGIeh-un7ai1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfX1JPeupdJ9sbU
 VEugYzLxviEbsaEeRUzZAhjx48LGQRVjEugAd9hhX+cIf43+/FiUbx5OouBYu9uzxcIXV6KDlP2
 f/o7RSBG3oU/p+ZMi1vcibyGkToueYu3NjQ45MCHGI3IBe5AuOAVyYg9xJ2kAkaBMLPHd17d9IC
 AkR0NSbsTeF9bSeh7+hoEUQn5ejR/KimMys5flTOjtoICu7z71W812796Nixw7K4LV+gtiH+GZg
 1F0EBMKj/+mAhSBFqLb+IeWIiVjI2Vg1y45X2CXHfuU2rGc1DIv1t6qWJ/ib/C3mFRDshsM+AiT
 0IV1aemptuMxiK1vsO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABhM6iNmq4J4wVj2UIMzAC2iBLzLoc11KXaH4ObjWjMn3ZCqukQ7juXYVHRjIqFLYTRSNVOgA6DCZGic2KGl4BDh8Cp97GU7IKJ8DN7gfCT5MbOPiSNUWkv7MJI25COPSLT7wZrfQ8Lxf4QqvQHgr6KFrtU8/NMLsWs+aig3ZfXXzIT/6U9qcpke7+q6bN2hxjZotjFuigh03DAu/4OgmHcH7t8M7Z1RTsJgMvRE1SfaKQ3eFrTvJS3XU7u854j2+bY+Xu98iZP18XmxGs2v+SQROP2X+Zc23vrWGOKcOThgjJOa92AI6DSoAF43xzxdZhzSHurqd4qjlIzY+zNt7TWM9V/FMPSdM3xelK3y0ix/KI1bopAxHJ1rkILgWpJVTY0TdUvuXAL0jOv2M5hXWcbYCps3bkDyYqXKPBHbr+Q77ZuoaHniAPXeCi+gEC8W0fgpQwWZofa6FZlnZ/98hcjbvoYNzUYXpNI5VYfBovk4MuoAPBnMPZ1ndx3J2rDHhVPXArckXLm9sCmgXzmIzAJdMX06X418flwnvGI+EwHanjBG7BjgEWENh9bUySutRFYkgCIMPunjPSQNEfROgLw6D8PHDTXqvIv9iepGrFdPBuv0eD2kCrrFeduNtDLDFP/riTHs2ASYewPDz1wsXPodFLrl56EPdCiRgHpUyXmF8PRwOqIqzaLhgUGGVF7LkvpvdRrT7TLlq/NpmYS4XOXp4AUZY=
Received-SPF: pass client-ip=57.103.74.66;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(tag for this submission: hvf-irqchip-and-nested-v7)

This series adds supports for nested virtualisation when using HVF on arm64 Macs.

It has two parts:
- Apple vGICv3 support and necessary infrastructure changes for it
- Nested virtualisation support. Note that the nested virtualisation implementation
shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).

It's rebased on top of the WHPX arm64 series and the https://lore.kernel.org/qemu-devel/20260112103034.65310-1-philmd@linaro.org/ series.

Known issues:
- when nested virt is enabled, no UI response within EDK2
and a permanent wait. Workaround: -boot menu=on,splash-time=0. Interrupts do
work later on in Linux.
- This series doesn't contain EL2 physical timer emulation, which is
needed if not leveraging the Apple vGIC.

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

Mohamed Mediouni (10):
  hw/intc: Add hvf vGIC interrupt controller support
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  hvf: save/restore Apple GIC state
  hw/arm, target/arm: nested virtualisation on HVF
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
  target/arm: hvf: instantiate GIC early
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC
  hvf: sync registers used at EL2

 accel/hvf/hvf-all.c                |  51 ++
 accel/stubs/hvf-stub.c             |   2 +
 hw/arm/virt.c                      |  33 +-
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_hvf.c            | 743 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 189 +++++++-
 target/arm/hvf/sysreg.c.inc        |  35 ++
 11 files changed, 1054 insertions(+), 14 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.50.1 (Apple Git-155)


