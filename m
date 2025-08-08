Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B433C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH70-00060e-9w; Fri, 08 Aug 2025 03:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH6q-0005s9-8U
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:01:54 -0400
Received: from p-east3-cluster1-host5-snip4-3.eps.apple.com ([57.103.87.46]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH6n-0005CG-VZ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:01:47 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 2E3EA1800109; Fri,  8 Aug 2025 07:01:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=e1qt2xIm6hFNGN+Bn3h90BoxPwxyvt7Tg+aWyda3+q8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:x-icloud-hme;
 b=bfcBUjKPYuzXnl65qyArmHntvuPzgxzI/RZo6vinUdGnpcRp5lYjfMPsrFWU6/n02ziK4nNPw3S/5tM45f/+I4P10upMaDp1sD1cdGUCxzVyqffRXOLJqseDy3jbCeziBLZHGs8Z/8rS1sCXm2AlJPElwWPYJ34fLuHh4071UJKNhUEcjP+N2MJpj2e2a7zNkZLkW/1UKL3u6J4OgO8UBAHAZrnP2YXlW2PyfHPBLI7j1btVvAWiJZA3mnQ4zeZ8v8BBnCznosLKHWWflwFrUrqCukpZe3YYHuSV3KND+8QxkJxo39EXn7Zc4PuGW594FU63JSYlInNMDF5h/Q48DA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 EE0DA1800121; Fri,  8 Aug 2025 07:01:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 00/13] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Fri,  8 Aug 2025 09:01:24 +0200
Message-Id: <20250808070137.48716-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q4bR-Sh1gsd6G58QDT2FmG2uipmSUdpK
X-Proofpoint-ORIG-GUID: q4bR-Sh1gsd6G58QDT2FmG2uipmSUdpK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NyBTYWx0ZWRfX0S3DwgWa+rRS
 vMWbQLSchG79fGaeJ5NkaEv/29yYWHYfiNKQ/uqgo+XRq28T8Va8bztsnV5MqMSlqE8ljBeyE62
 ZAWRvmLgTij/iS4O9ApHJIZ2z2xk3ukH+EWHX8npklv/zzFIGBFc0pbXSwBuuXet99SZHrzF37M
 v8Nh+qkNExvICR7Nn7zaVHdfiuyWmafBQvm2owD8oF0rtE4W1WElnKf7kLT6TcICMpD6sekidRo
 4OKr47MGN+7OC4fvFIOIkHWASE9bRjsRORXW1j2bzd1R26gGCUBO3Ts6D5yPTgIOP7Wk17Zt8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0
 adultscore=0 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080057
Received-SPF: pass client-ip=57.103.87.46;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
(tag for this submission: hvf-irqchip-and-nested-v6)

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

To do:
- Switching ITS to off by default when using HVF w/ vGIC or WHPX (will probably do when both the series are merged)
- After that, perhaps exit if ITS is explicitly enabled.

PS: I can step up to maintain HVF support if needed.

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

Mohamed Mediouni (13):
  hw/arm: virt: add GICv2m for the case when ITS is not available
  hvf: switch hvf_arm_get_host_cpu_features to not create a vCPU
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  hw/intc: Add hvf vGIC interrupt controller support
  hw/arm, target/arm: nested virtualisation on HVF
  hvf: save/restore Apple GIC state
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  hvf: sync registers used at EL2
  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
  target/arm: hvf: instantiate GIC early
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC

 accel/hvf/hvf-all.c        |  50 +++
 accel/stubs/hvf-stub.c     |   1 +
 hw/arm/virt-acpi-build.c   |   4 +-
 hw/arm/virt.c              |  43 ++-
 hw/intc/arm_gicv3_common.c |   3 +
 hw/intc/arm_gicv3_hvf.c    | 723 +++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build        |   1 +
 include/hw/arm/virt.h      |   2 +
 include/system/hvf.h       |   3 +
 system/vl.c                |   2 +
 target/arm/hvf-stub.c      |  15 +
 target/arm/hvf/hvf.c       | 240 ++++++++++--
 target/arm/hvf_arm.h       |   3 +
 13 files changed, 1057 insertions(+), 33 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

-- 
2.39.5 (Apple Git-154)


