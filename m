Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACB9C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugO6u-0005RP-NL; Mon, 28 Jul 2025 09:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6d-0004Na-UV
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:41 -0400
Received: from p-east3-cluster2-host11-snip4-10.eps.apple.com ([57.103.87.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6X-0004Gf-VO
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:29 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 A13DC18001D9; Mon, 28 Jul 2025 13:41:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=SHBv8b1NK8KIR6kKsSRRg9kvT2xY6EHAHbkeCNnJkn8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:x-icloud-hme;
 b=HqftcdN5xzM7FznC0PnbSpaQ+kAdxLomKcGC4KEIukFBB9LeuCUDXKWPXDAqN2TBbk1Bkz5KZxiFbeUaoVbrZQWY1HDdaYB4U8iNCrkeMcOPrErlwwX/fGcw9PfHagz0eL4p73r75HmWJJcsrmDfSCakENUkThtR4XIA5dPG9rUlm8Movr4nOUDBu9jv/28lcz/Cu+Fd9FgWChSbAbRPSHWdnyGWKEfPBrm3Z/X7hPN5FHbtW8LK+/HxMBaL5OuVr3vITw7RDpdaVXF+M3rCCZYA9uZ4qSnAyDPrseisadjDhjv44iLzasmsHsG0AkOcXLT7Evvag3miK1ucZ6J81g==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 EF979181977F; Mon, 28 Jul 2025 13:41:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 00/13] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Mon, 28 Jul 2025 15:41:01 +0200
Message-Id: <20250728134114.77545-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GPlahzYBcRgbGXqV2dxmund9ngo5yn2f
X-Proofpoint-ORIG-GUID: GPlahzYBcRgbGXqV2dxmund9ngo5yn2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfX0HXcSI6i9Y60
 JzEN2iOOaXFbk7MohhuFFG5UUZD23lsUUyrvIY7UPLUubq+ekIA7FjCM6amtlOrmrOwO5EG1jz+
 RoxEnnOiP6pigF/DNDO8kg9kVyQMmB+xM754gkMpXQZxf9G3v1srOUe0OyAOiLwRJOyghbjGS6t
 MtQxNgtLXpdJKmbaTi9cJpZ1LVsFJSZko59ZNRsZN1SFszAXpew5Dy3nJXXK7s4tV2nwoiC1gSw
 6dM060wDu0z+DLQ3k7gYyd9kO1g61Ew0PqUVzsYYk+FichzAF2SUkVcUnCheJQEfEFRImJIN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1030 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507280101
Received-SPF: pass client-ip=57.103.87.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v5:
- oops, fixed up save/restore to be functional
- misc changes otherwise

Mohamed Mediouni (13):
  hvf: switch hvf_arm_get_host_cpu_features to not create a vCPU
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  hw/intc: Add hvf vGIC interrupt controller support
  hw/arm, target/arm: nested virtualisation on HVF
  hvf: save/restore Apple GIC state
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hw/arm: virt: add GICv2m for the case when ITS is not available
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  hvf: sync registers used at EL2
  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
  target/arm: hvf: instantiate GIC early
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC

 accel/hvf/hvf-all.c        |  44 +++
 accel/stubs/hvf-stub.c     |   1 +
 hw/arm/virt-acpi-build.c   |   4 +-
 hw/arm/virt.c              |  43 ++-
 hw/intc/arm_gicv3_common.c |   3 +
 hw/intc/arm_gicv3_hvf.c    | 722 +++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build        |   1 +
 include/hw/arm/virt.h      |   2 +
 include/system/hvf.h       |   3 +
 system/vl.c                |   2 +
 target/arm/hvf-stub.c      |  15 +
 target/arm/hvf/hvf.c       | 239 ++++++++++--
 target/arm/hvf_arm.h       |   3 +
 13 files changed, 1049 insertions(+), 33 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.39.5 (Apple Git-154)


