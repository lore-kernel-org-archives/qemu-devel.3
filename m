Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81F1FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEG-0001Yy-Tw; Wed, 29 Apr 2026 15:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEE-0001YD-LK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:46 -0400
Received: from ms-2001b-snip4-4.eps.apple.com ([57.103.73.145]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEC-0000DD-9H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:46 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 4DE3B18005E1; Wed, 29 Apr 2026 19:05:38 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAE1fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YDXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489540; x=1780081540;
 bh=W43n6LVvCh3Rymerk0s50oQ+N/m7lZANcrqMXqV6cU8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=fnlgP1TdlGR1cEKcRBoZ0yR8CK9bKZSD1Lct7bpKkQeJr8rkVLMz8RylqQRtJxgUpzMnlHAyVAVtIm1v9EY6BixPP4PRufDGu88AIu/bK70vei31GgyLADCsPzR8PcsAX/ZQfRphCw5ypitzA6qxvZLiDm2SqdZ4WV9UfrsAz+wvUSduXdzkCqvuWINfTNW9WxQPlMpsAue9TUtQAOCdzBLnZGvfgyG3068gS9rX4pwrdK17oDd2ZJSFzYhNTaTpO4oYLQohV0t3uFWsNK9W5OETKeEUNq7IeMJOezxXHB9WcWLL2ci5FbOq8vTab24iEXAw2REZgf2fTjmoKv32vQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 9C05418000C6; Wed, 29 Apr 2026 19:05:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v21 00/15] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Wed, 29 Apr 2026 21:05:17 +0200
Message-ID: <20260429190532.26538-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX4JKT4dLScaCq
 nW+bln3xZHvW6SBF3ekj521sWYxa9ihI0KEKrQ78BMvmZljIzaKHJoejtOqog7SFVyl/M23st0q
 pB5zCbDyjZOq2e9aqp8ScNeKjWrpF5XklxcTYydpJmxjyO0DFgZEtbzX3aI5rhwcYs0GXqwV4t/
 M3BsN+ox4BvsTyncIiYueLfxLun2uudqCwZ193WASe4dfBFhH21UcXl1hvF+fAL96DegJUl8y+p
 hayYufPrnKZe3IqrzMxwQRhVG+gSnMfSVfIsJpsuZYLsdX8H3xt6Eu9pLtOUci/fYWiOLAh6TZz
 VM7M9lcETP6Kv64F5b7HAAgYiorVaH2n4vJn9REtuVF5gJU5fCCsotN+ZqXkHw=
X-Authority-Info-Out: v=2.4 cv=dtnWylg4 c=1 sm=1 tr=0 ts=69f25684
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=jwI92-NncrociDarPsAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eIELW4XmlcxAnWRfGI947F6AZlE2sQO7
X-Proofpoint-GUID: eIELW4XmlcxAnWRfGI947F6AZlE2sQO7
Received-SPF: pass client-ip=57.103.73.145;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(tag for this submission: hvf-irqchip-and-nested-v21)

This series adds support for nested virtualisation when using HVF on arm64 Macs.

The first two patches are from the SME enablement series and are present for the
series to be buildable on its own.

It has two parts:
- Apple vGICv3 support and necessary infrastructure changes for it
- Nested virtualisation support. Note that the nested virtualisation implementation
shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).

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

v20:

- Only enable kernel-irqchip=on when running with -M virt-11.1 or later
- Enable nested virt to work with kernel-irqchip=off when using a GICv2

v21:
- Rebase.
- Addressing review comments but not switching things to HVFState at least
for now

Mohamed Mediouni (15):
  hw/intc: Add hvf vGIC interrupt controller support
  hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  hw/arm, target/arm: nested virtualisation on HVF
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  hvf: gate ARM_FEATURE_PMU register emulation when using the Apple vGIC
  hvf: arm: allow exposing minimal PMU for kernel-irqchip=on
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC
  hvf: sync registers used at EL2
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hvf: arm: disable SME when nested virt is active
  hvf: arm: physical timer emulation
  hvf: enable nested virtualisation support
  hvf: arm: enable vGIC by default for virt-11.1 and later

 accel/hvf/hvf-all.c                |  62 +++
 accel/stubs/hvf-stub.c             |  11 +
 hw/arm/virt.c                      |  45 +-
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_hvf.c            | 826 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 +
 hw/intc/meson.build                |   2 +
 include/hw/arm/virt.h              |   2 +
 include/hw/core/boards.h           |   1 +
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 include/system/hvf_int.h           |   1 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 208 +++++++-
 target/arm/hvf/sysreg.c.inc        |  44 ++
 target/arm/hvf_arm.h               |   5 +
 16 files changed, 1225 insertions(+), 25 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

-- 
2.50.1 (Apple Git-155)


