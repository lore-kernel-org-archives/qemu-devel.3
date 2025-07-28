Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75022C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 05:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGsq-0000KN-BZ; Mon, 28 Jul 2025 01:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrM-0007Bu-Qx
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:17 -0400
Received: from p-east3-cluster6-host11-snip4-1.eps.apple.com ([57.103.85.232]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrJ-0007BB-O1
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:16 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 34FA31800128; Mon, 28 Jul 2025 05:57:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Q5hN65bQb4OoDEEW1hR/TVOSx0BXnS6Y+azFb2T/bIE=;
 h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version:x-icloud-hme;
 b=BJnt0U+SHf79Ronsc3xF6bebpHHihszLAwURCnNAOpnhqEfYku0ANqRDQ1tb4EFtiPUMslt1wjQ1nEtDW0Wv3Nz0p+8vQjHlhCMUMod5c4TH1iZVzMOPP/hPJ/dgEz1KDqi6aoOhLEIo7PScbADom6iBCR9c+5sVDu5wG8RI6pRZd+qb16KPApkNAWwH1OMU8L7YvJGBtobLlHVIKn0ZXZkbEpewBA/2gNVnf4107zUlWcCFQRQPGywRsv6qlsPQICZAfNuh03VI10np9fYnUl1j39S74gVKZDzEurtRjviZ7ezR+TBTjbwxGwFxYCRlVG4jGvAqdOHG749dsEARrA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 72AAF180009B; Mon, 28 Jul 2025 05:57:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 00/15] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Mon, 28 Jul 2025 07:56:46 +0200
Message-Id: <20250728055701.38975-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cl0Blk2xjRz1JY3SD2KIqeeDHOeFLi1H
X-Proofpoint-ORIG-GUID: cl0Blk2xjRz1JY3SD2KIqeeDHOeFLi1H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfX4CeF1kfaepdO
 k1BMOmB5P+rfv8mDzHkQpI7h9CUi+4kbySRDPw+f2oXbqIOMlSPrvYgyyQHCHJAyfY8OM0bTgJw
 /Rdfyw5O5Qg1Qrd/MsmZ7N+4jvFUVYv1qUI5wibJz2YPfqcNwoPiRxPZ8FVf7ZCqLJWYrI8mRBo
 8NYIXhMquG3WKSCtvClQrDFOpiHg7q7aZbF3V5QoOu62efwkyR+jjC9ScNP36MGb/7uFaaasozM
 PZxXWlJkHhD7azGFmPVWZv9dTLzF+rEfMvlAOYLTcQjrJB1eJTKhbF4MYv7IPm9a0I/qkQtdg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 clxscore=1030 phishscore=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.85.232;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds supports for nested virtualisation when using HVF on arm64 Macs.

It has three parts:
- Apple vGICv3 support and necessary infrastructure changes for it
- support for MSI interrupts in GICv3 + GICv2m configurations, which is independent
from Apple platforms and can be merged independently.
- Nested virtualisation support. Note that the nested virtualisation implementation
shipping as of macOS 26.0 is nVHE only, and does not leverage VNCR (FEAT_NV1-style).

Known issues:
- when nested virt is enabled, no UI response within EDK2
and a permanent wait. Workaround: -boot menu=on,splash-time=0. Interrupts do
work later on in Linux.
- Save/restore of GIC state isn't complete yet. Added a migration blocker
for when multiple vCPUs are used.
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

v3->v4:
- GIC state save improvements, including saving the opaque Apple-specific state
- Saving HVF system register state when using the vGIC and/or EL2

Mohamed Mediouni (15):
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC
  hw/intc: Add hvf vGIC interrupt controller support
  hvf: save/restore Apple GIC state
  hw/arm, target/arm: nested virtualisation on HVF
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hw/arm: virt: add GICv2m for the case when ITS is not available
  target/arm: hvf: use LOG_UNIMP for CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  target/arm: hvf: when the platform irqchip is used, abort on writes to
    the ptimer
  hw/intc: hvf: sync state in c->ich* registers when virt on
  hvf: sync registers used at EL2
  hw/intc: hvf: add migration blocker when using multiple vCPUs with the
    Apple GIC

 accel/hvf/hvf-all.c        |  44 +++
 accel/stubs/hvf-stub.c     |   1 +
 hw/arm/virt-acpi-build.c   |   4 +-
 hw/arm/virt.c              |  43 ++-
 hw/intc/arm_gicv3_common.c |   3 +
 hw/intc/arm_gicv3_hvf.c    | 749 +++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build        |   1 +
 include/hw/arm/virt.h      |   2 +
 include/system/hvf.h       |   3 +
 system/vl.c                |   2 +
 target/arm/hvf-stub.c      |  15 +
 target/arm/hvf/hvf.c       | 227 ++++++++++-
 target/arm/hvf_arm.h       |   3 +
 13 files changed, 1087 insertions(+), 10 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.39.5 (Apple Git-154)


