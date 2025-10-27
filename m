Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1531FCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKKB-00070C-PU; Mon, 27 Oct 2025 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDKK5-0006tG-BR; Mon, 27 Oct 2025 06:19:33 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDKK1-000587-8A; Mon, 27 Oct 2025 06:19:32 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59RAJBfR020236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 19:19:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6tb1ZfeeDiSbV2uBs4uiPRzZA4g/1gjlvgC72cZNFHM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1761560359; v=1;
 b=GhIf3feCo+JJgP9XAdzuHZaiSfBVpqGqP4zaiUKxmOcvrdHGzMJM3+AX/L5RrSfC
 tbRnvhTXTOwqIr1z43sQQ0Mqil5AsXYGmVg9vqdoXuusLu6K44coOqUOH2bOYY+Q
 NPNf0W6NoJEkytm+FSKOfYIAlBWwyRo2PKs/WI9yFLnb66ZRlhTv8pwVh75vEvz/
 ztiRR3vS+jCkA4ZQl3RAnOjSpFeYX/bifxOG1NKx8DE6g44Rrl9cryIkR/Ui8afW
 7cHPzmA6cyBq45UONF3WJv5PwJRCmdIduECQt8mJvAzhEobEhsKFtPAMnlnTvZZI
 dJgMCL6DdmYZSNhhgYEndg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 0/3] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
Date: Mon, 27 Oct 2025 19:19:05 +0900
Message-Id: <20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlH/2gC/3XN0QqCMBTG8VeRXbexnZXOrnqP6GLOqadAbdORi
 O/etEAIuvx/HH5nJt46tJ6ck5k4G9Bj18aQh4SYRre1pVjGJsDhxDNQNKAbqJKy1JVOjRAFiae
 9sxW+NuZ6+7SzzzFqwz426IfOTdurINb1Rw2CCsp1kacKIAWjLs7XzCBDNtKhe0wd04bde7JqA
 XYh5+IrQBS0AZnlRx4B/ldYluUN04vdu/wAAAA=
X-Change-ID: 20250728-virt-833dafa6c11b
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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
Changes in v3:
- Fixed test failures reported by Peter Maydell.
- Link to v2: https://lore.kernel.org/qemu-devel/20250901-virt-v2-1-ac2379402c80@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/qemu-devel/20250728-virt-v1-1-0ab9682262c8@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (3):
      test/acpi: aarch64/virt: Allow DSDT and MCFG changes
      hw/arm/virt: Remove the lower bound of HighMem IO Regions
      test/acpi: aarch64/virt: Update golden masters for DSDT and MCFG

 include/hw/arm/virt.h                            |   1 +
 hw/arm/virt.c                                    |  16 ++++++++++++----
 tests/qtest/libqos/generic-pcihost.c             |   2 +-
 tests/data/acpi/aarch64/virt/DSDT                | Bin 5337 -> 5333 bytes
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
 tests/data/acpi/aarch64/virt/MCFG.memhp          | Bin 0 -> 60 bytes
 15 files changed, 14 insertions(+), 5 deletions(-)
---
base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
change-id: 20250728-virt-833dafa6c11b

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


