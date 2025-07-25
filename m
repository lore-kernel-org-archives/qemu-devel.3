Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F56C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 22:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufQyK-0007Se-Iy; Fri, 25 Jul 2025 18:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQwz-0006cP-Uh
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:39 -0400
Received: from p-east3-cluster3-host11-snip4-9.eps.apple.com ([57.103.86.112]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQw9-0003jb-Mm
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:30:49 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 714541800124; Fri, 25 Jul 2025 22:30:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=IMK7UfL90JIknTmFT+PE2HJ8KA6fi59wTdPzFd8Qhm8=;
 h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version:x-icloud-hme;
 b=X2rAFp5w4HPICXRwqncoKfbmHM9LzEhtjV9DNmlbzQp/vNRhxFIHZsfmJcAOmjt/qJ+l7agYFVFYl6bZ5NESb6ifjz/4Q2hMJX9VeViJ+Qhih7unjh4Bo4fAO6kS3bVYKiw2M8IHxbz98h1IMVJCsr21XU0t8XwBvZOzP5Z3PEKvXgzr3CpkPagPvxzIpoobFBUqOXAgVqhmvk07sGxq1PMI9qDUni8JkEiVWyLhpoxe4Att0V7le/7ceIOiuJUNzP0kjyr3JAHlPhronTHXvw3R0njjFMEymwQaQ084z0aUZEjNSRiSyp4wRc37U42l7BvwCPgN+QbeYN5GK3BHYw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 048331800121; Fri, 25 Jul 2025 22:30:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v3 0/9] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Sat, 26 Jul 2025 00:30:26 +0200
Message-Id: <20250725223035.52284-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MoOlpdoaxIcxJBq0mCWYHZTEKVzQCbrA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE5NSBTYWx0ZWRfXy3wz76XojnGn
 obB4namrqUc6fqXpp05lN5/jG1B96VpWtZqJp5lSpUMBqVslWtYI6/hYcFWNno1RcLHoV7+Gyhl
 IzJk4TYPAM6Pr3ObXdDCfmlHZXyR9hc3YR2ooZvyynIkw7wH61ZWREzEeEYq74+gqceFgtEhHI2
 jM+b7T0LBLVTLo+0HBHMVL+Fh50T4YR7NI01L3UJ0fRlkpkW4MzuWyVlvQRJ8XUpQMlFuFDdX6z
 zVy5D5YMg62rz0F0LjSyrpKSK/U2lrrUFxpUIF26zrrgGTyEaCfxDEKVOW7SG8rAp9FfWd5ac=
X-Proofpoint-ORIG-GUID: MoOlpdoaxIcxJBq0mCWYHZTEKVzQCbrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250195
Received-SPF: pass client-ip=57.103.86.112;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Early series.

Known issues:
- when nested virt is enabled, no UI response within EDK2
and a permanent wait. Workaround: -boot menu=on,splash-time=0

Issues to be addressed in additional commits or a new patch series:
- Save/restore of GIC state isn't complete yet.
- Save/restore of HVF state when EL2 is enabled isn't complete yet.
- This series doesn't contain EL2 physical timer emulation, which is
needed if not leveraging the Apple vGIC.

However, this is usable and there seems to be some interest for it. Hopefully
it'll be at least somewhat useful.

PS: I can step up to maintain HVF support if needed. WHPX arm64 patch series
is coming soon too.

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

Mohamed Mediouni (9):
  accel, hw/arm, include/system/hvf: plumbing changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  target/arm: add asserts for code paths not leveraged when using the
    vGIC
  hw/intc: Add hvf vGIC interrupt controller support
  hw/arm, target/arm: nested virtualisation on HVF
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hw/arm: virt: add GICv2m for the case when ITS is not available
  target/arm: hvf: use LOG_UNIMP for CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS

 accel/hvf/hvf-all.c        |  44 +++
 accel/stubs/hvf-stub.c     |   1 +
 hw/arm/virt-acpi-build.c   |   4 +-
 hw/arm/virt.c              |  43 ++-
 hw/intc/arm_gicv3_common.c |   3 +
 hw/intc/arm_gicv3_hvf.c    | 624 +++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build        |   1 +
 include/hw/arm/virt.h      |   2 +
 include/system/hvf.h       |   3 +
 system/vl.c                |   2 +
 target/arm/hvf-stub.c      |  15 +
 target/arm/hvf/hvf.c       |  86 +++++
 target/arm/hvf_arm.h       |   3 +
 13 files changed, 822 insertions(+), 9 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.39.5 (Apple Git-154)


