Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4A1C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63AI-0003Xj-JY; Mon, 14 Sep 2026 05:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AG-0003Vd-HF; Mon, 14 Sep 2026 05:39:52 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AE-0001OK-GT; Mon, 14 Sep 2026 05:39:52 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9ddbt024283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:39:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=eTAG/xVTDu8dcH+/FixoLcGvVpt3IZn80fR3us/AzSs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378783; v=1;
 b=kQHJQNLgu5dzaFd7D6fBO/1iFr1OUamqrt84JgipXatja79ToQaMAp6d5pSKkopB
 buFAjedvKbsjVXVUt6BemRX/d1AbfuVKwvlVVgbiX7F+S2TcafrDNI5+wBuu3HVz
 CdomEief5bEJ7BCZcJmeJSoEr4WCPw2tolFA9xOD3G48rlw5yQm2kryg2KfUlo3/
 jSE77ayqVY89ZCuRIl48U/1WOmHs9KmiA5T8qAln2gn+3DoGE/5FvG5C7jCRzjsr
 ZRNYlj9Ic6leitzLCoGR+5QoXa3Vlm+pvROKCAN/PjukH0A2l/JGS01ihRyocqqI
 IMaixRgmVC5UJWDhAjO3IQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v8 0/5] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
Date: Mon, 14 Sep 2026 18:39:21 +0900
Message-Id: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33R207DMAwG4FeZck0qxzmWK94DcZHmsAWkdSRdx
 TT13clKRyckevlb1mfLvpIScgqFPO+uJIcxldQfazBPO+IO9rgPNPmaCQJK0GjomPJADefeRqs
 cYx2praccYvqamde3n5zD57lqw1o8pDL0+TKPGtmt+kcdGWUUbNcqg6jQmZdc9o1LTWrOdOg/L
 n1jXfN+IjdtxFVogS0CVsE65LoVUAHYFPivwAD1InAKNFq0GLkOHP2mIO6CAoZyEUQVALxG1aF
 GFJuCfBTaRZBVEMhcvYW1EdWmoFZBIiyCqoJvFTMgpIg+bgr6Ubj/Qs87OOGZUQjd/7+Ypukb+
 ygBLUYCAAA=
X-Change-ID: 20250728-virt-833dafa6c11b
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5189;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=iuiJSO0BBhYprlj07SaAWAxtEStsacZyAT+OrNf6eXI=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9byA5cv/NDT7JYvc/a9mnNTVtFVK2XL6kcbVV02/zcvE
 39+X8eyo5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCKmSQz/fY9JCs7bzbv856uo
 Zdc4rk0/kuf1MXuGYBbn6XuaHvXxyxj+x7sUuE/cVLMgKfvD30S1x5e4dqieTzG8UqnwPZPreM0
 9fgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Remove the lower bound of the Highmem IO Regions' addresses for the
latest machine version to increase the chance to fit the regions in the
PA space.

The lower bound was especially problematic when using virt-install on
Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
require sufficient space in the ECAM region. However, the Highmem ECAM
region did not fit in the limited PA space on the hardware, and the ECAM
region size was limited to 16 MiB. If virt-install had added more than
16 devices to the root bridge, the region overflowed, which prevented
edk2-stable202505 from scanning PCI devices, including the boot disk,
causing boot failures.

Ideally, a virtual machine with more than 16 devices added to the root
bridge should just work so that users and management layers do not have
to care whether they use constrained hardware.

The base address of the Highmem IO Regions was fixed when commit
f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
regions") added the first Highmem IO Region. Later, commit 957e32cffa57
("hw/arm/virt: Dynamic memory map depending on RAM requirements")
allowed moving the Highmem IO Regions to higher addresses to accommodate
RAM more than 255 GiB, but the lower bound remained to keep the legacy
memory map.

Remove the lower bound for the latest machine version to accommodate
more devices with the root bridge. Keeping the lower bound for the old
machine versions ensures the compatibility is still maintained.

The hardcoded memory map in tests/qtest/libqos/generic-pcihost.c is also
updated.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v8:
- Updated the compatibility test and memory layout preservation to
  virt-11.1.
- Stored the HighMem MMIO size in the machine instance so querying
  another machine type's properties does not alter the active memory
  map.
- Link to v7: https://lore.kernel.org/qemu-devel/20260528-virt-v7-0-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp

Changes in v7:
- Added patch "hw/arm/virt: Relax the lower bound of HighMem MMIO region
  size", addressing a limitation pointed out by Igor Mammedov. I
  previously described this as out of scope, but addressed it in this
  version.
- Link to v6: https://lore.kernel.org/qemu-devel/20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp

Changes in v6:
- Rebased.
- Link to v5: https://lore.kernel.org/qemu-devel/20260129-virt-v5-0-421c0abaaf26@rsg.ci.i.u-tokyo.ac.jp

Changes in v5:
- Changed to preserve memory layout for 10.2.
- Added patch "test/acpi: aarch64/virt: Test version 10.2".
- Link to v4: https://lore.kernel.org/qemu-devel/20260125-virt-v4-0-00d726b27224@rsg.ci.i.u-tokyo.ac.jp

Changes in v4:
- Rebased.
- Edited the patch message to avoid confusing git am.
- Link to v3: https://lore.kernel.org/qemu-devel/20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp

Changes in v3:
- Fixed test failures reported by Peter Maydell.
- Link to v2: https://lore.kernel.org/qemu-devel/20250901-virt-v2-1-ac2379402c80@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/qemu-devel/20250728-virt-v1-1-0ab9682262c8@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (5):
      test/acpi: aarch64/virt: Test version 11.1
      test/acpi: aarch64/virt: Allow DSDT and MCFG changes
      hw/arm/virt: Remove the lower bound of HighMem IO Regions
      hw/arm/virt: Relax the lower bound of HighMem MMIO region size
      test/acpi: aarch64/virt: Update golden masters for DSDT and MCFG

 docs/system/arm/virt.rst                         |   2 +-
 include/hw/arm/virt.h                            |   3 ++
 hw/arm/virt.c                                    |  48 +++++++++++++++--------
 tests/qtest/bios-tables-test.c                   |  24 ++++++++++++
 tests/qtest/libqos/generic-pcihost.c             |   2 +-
 tests/data/acpi/aarch64/virt/DSDT                | Bin 5337 -> 5333 bytes
 tests/data/acpi/aarch64/virt/DSDT.11.1           | Bin 0 -> 5337 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt   | Bin 5423 -> 5419 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | Bin 6246 -> 6242 bytes
 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 5391 -> 5387 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp          | Bin 6698 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb            | Bin 7812 -> 7808 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev     | Bin 10274 -> 10270 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy  | Bin 10274 -> 10270 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology       | Bin 5539 -> 5535 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot           | Bin 5354 -> 5350 bytes
 tests/data/acpi/aarch64/virt/MCFG                | Bin 60 -> 60 bytes
 tests/data/acpi/aarch64/virt/MCFG.11.1           | Bin 0 -> 60 bytes
 tests/data/acpi/aarch64/virt/MCFG.memhp          | Bin 0 -> 60 bytes
 19 files changed, 61 insertions(+), 18 deletions(-)
---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20250728-virt-833dafa6c11b

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


