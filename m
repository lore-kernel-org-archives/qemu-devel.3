Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29346CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfna-0004gt-4a; Wed, 20 May 2026 08:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPfnX-0004g3-Qz; Wed, 20 May 2026 08:13:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPfnV-00076Q-Fs; Wed, 20 May 2026 08:13:15 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K9utCP091476
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 18:57:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WTyylUaaZrKTQOUiNy65AxR9R14Q8ETyv12d3ZH2e1U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779271023; v=1;
 b=KtqYUyLnpIai5yzQAaV2LmblzLN74WKi1aMoVCeLr/TFnFr/Di+GpAl0HVsggXny
 qootow4JXFT/ZQc1gEwDjirnMlVnGRFFiwGCDefxFoN6PeaWE3kAaPTlYQ393nW7
 LUqH5HqRtZ+b80REaiufsMSQ6OB66u8GfuudGtY6bNxi+jZUBM1cKL0qf4uKQKi+
 dfx/ESbfTLof86WluZ7LfIEu7urtLX8t/dLsrHRkWnIXeMJWzDOGRyA1MyniTLej
 bCLq0IKvdtQvR26ezqRiFN53TzhBx5LulZH97j1IEtfTAdv5iXuAnD1ANbh1CEZM
 bCkRZkVMTPCeNtjb/Nib/g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v6 0/4] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
Date: Wed, 20 May 2026 18:56:29 +0900
Message-Id: <20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QQW7DIBAF0KtErAsaBgx2V71HlcUYQ0IrxSk4K
 FHku5ekblNVqpf/a/S+NFeWfYo+s+fNlSVfYo7joQbztGFuT4ed53GomSFgAxZbXmKaeKvUQIG
 Mk7Jn9fSYfIjnO/O6/crJf5yqNj3KfczTmC73qSJv7R+1SC45UN+ZFtGga19S3gkXRRQnPo3vl
 1GQE29HdtMKPoQO5CJgFcihsp2GCsCqoH4ECWgXQXHggZAwKOsVDquC/hYMSGwWQVcBYLBoerS
 IelVofgvdIjRV0Chd/QVRQPOvMM/zJ9FHRZTCAQAA
X-Change-ID: 20250728-virt-833dafa6c11b
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=4364;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=Hbkh+QyC3DebZfR694EuTypzJ/08V06tUICMnTEx8AM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZva5bwDYNpZV/lFhzil5V//c1Tu+G802OH5pkSOSKMT
 14vMrXtKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEhNNMP/yv/WtjcyF6wOlHmQ
 Zpa1x6FowQPPZxrpn84d2fhfPDiXgZHhedtLu8Ja0ybrGTd+BmTrLzK6K6y0jW/FKd7n1svmJXI
 zAAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Akihiko Odaki (4):
      test/acpi: aarch64/virt: Test version 11.0
      test/acpi: aarch64/virt: Allow DSDT and MCFG changes
      hw/arm/virt: Remove the lower bound of HighMem IO Regions
      test/acpi: aarch64/virt: Update golden masters for DSDT and MCFG

 include/hw/arm/virt.h                            |   1 +
 hw/arm/virt.c                                    |  17 ++++++++++------
 tests/qtest/bios-tables-test.c                   |  24 +++++++++++++++++++++++
 tests/qtest/libqos/generic-pcihost.c             |   2 +-
 tests/data/acpi/aarch64/virt/DSDT                | Bin 5337 -> 5333 bytes
 tests/data/acpi/aarch64/virt/DSDT.11.0           | Bin 0 -> 5337 bytes
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
 tests/data/acpi/aarch64/virt/MCFG.11.0           | Bin 0 -> 60 bytes
 tests/data/acpi/aarch64/virt/MCFG.memhp          | Bin 0 -> 60 bytes
 18 files changed, 37 insertions(+), 7 deletions(-)
---
base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
change-id: 20250728-virt-833dafa6c11b

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


