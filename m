Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B760BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiIv-0003vO-UQ; Thu, 27 Jun 2024 02:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiIt-0003uk-Vo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:20 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiIr-0003Yx-B0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:19 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c2c6b27428so5514757a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468495; x=1720073295;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=chddfuUG7IJpjiouLZLeBYAYBbku4KICX4r1mGMQnWI=;
 b=JBL2H2Uog8ss12p1eL8XcmrgHKikNiHBwg/GPahUcWJt3R5WoqOtF1KNAMFoWmZ0XF
 PbgcJg1U3YVDkZxdxdWib8+B1f+fHVnSPo0YvZCsBYW5V09e22oaD37ln07w2NWto6gL
 0qVTJ0g7jiqXLfoLKosJpQa8ACbo1zh3qq+1+W36Vy8woSdyze5RnFNZGiGqRdIRACC5
 LTPXQltSD7rIffqUge07pz7Hgl7w1nkuSasblxZhTCgWrz4WPSv9Vt4Qoy2nnRkgSHvi
 Q1yi7MVEMY1Eh8944IbkxyYjmBPdlqm2fmbntcHds1mGzXfEpHGO2jAUR2e5c+hIIJHG
 gK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468495; x=1720073295;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chddfuUG7IJpjiouLZLeBYAYBbku4KICX4r1mGMQnWI=;
 b=eIWENggvfXDaoZ38NagmSkzzlfZ+KERTeq0mtZsWd+0NLtzA07pmloexOckeVjI2dd
 iPbwfUYQdyrIiKXpc+XvT0LaUBMtxQqFpP7TtRZt92jjOMrp2jS4I//7YjzlI2J1xZhl
 Fz9povjNo9Xx4iha0mO3Y8Gcdastnjijz/JSNxwr4mCmQXagbXBeBzD6fAyGmbjNf3Nc
 T3OiuaEjQceLwHyUr+nk2ZTmJnN6clKUEBlvgMDkKNBplTPBFsafA6eitLraP3cGlREE
 nHb3dGyrjYH7OfhVATjaAX/2gig4DJK/gxf3M512nk5cx0/YjrPYcBOjlYdacR8aBDc4
 1hSQ==
X-Gm-Message-State: AOJu0Yxx/yiK7ijeLcfTif/JHccaR3TuhlCvs+qs6TZdDrcowS4S6lxd
 J3Av+ay2+D1b3xdJ7oihA/Y9eZGVpZbmqyU8wymn6Bx61sdV9f2QVMhMfSIHasA=
X-Google-Smtp-Source: AGHT+IELLI35U8mOCvrM5F9m7opvqlgm0Rp4A2Uqmy9Cx1pXsff1WuSrN3fNLpT+zA6B3iIgyiDh8w==
X-Received: by 2002:a17:90b:1a81:b0:2c5:1a3:6170 with SMTP id
 98e67ed59e1d1-2c861490bf2mr10771591a91.38.1719468495433; 
 Wed, 26 Jun 2024 23:08:15 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8fdb6d9f3sm573635a91.0.2024.06.26.23.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:08:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v10 00/12] hw/pci: SR-IOV related fixes and improvements
Date: Thu, 27 Jun 2024 15:07:49 +0900
Message-Id: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALUBfWYC/2XPz07DMAwG8FeZcqbIdv404cR7IA5J6rAc2FAL1
 aap7046aAnK0ZZ/n/zdxMRj5kk8HW5i5DlP+XwqA8LDQcSjP71xl4eyEASkAMl1I39N3CXvmSg
 gOqlEuf0YOeXLPejltczHPH2ex+s9d8Z1+5NAIH8TZuyg04Ft1JGNlPZ58NdTvjzG87tYI2aqG
 MLGqDBSwZPXQMZRw2TNaGOyMAvYB2Nd5D41TNVMbUytzPkBnPTQJ9UwXTO7MV0YqxQxogvau4a
 ZitHezazdWJEnGyCmtltfs/3JfmUuogoxOE3cMFuz/Um7MkvGAFlkAw1zf0yi3pgrzPTeG+eTG
 rT8x5Zl+Qb6Bie5VAIAAA==
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

I submitted a RFC series[1] to add support for SR-IOV emulation to
virtio-net-pci. During the development of the series, I fixed some
trivial bugs and made improvements that I think are independently
useful. This series extracts those fixes and improvements from the RFC
series.

[1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v10:
- Added patch "hw/ppc/spapr_pci: Do not reject VFs created after a PF".
- Added patch "hw/ppc/spapr_pci: Do not create DT for disabled PCI device".
- Added patch "hw/pci: Convert rom_bar into OnOffAuto".
- Dropped patch "hw/pci: Determine if rombar is explicitly enabled".
- Dropped patch "hw/qdev: Remove opts member".
- Link to v9: https://lore.kernel.org/r/20240315-reuse-v9-0-67aa69af4d53@daynix.com

Changes in v9:
- Rebased.
- Restored '#include "qapi/error.h"' (Michael S. Tsirkin)
- Added patch "pcie_sriov: Ensure VF function number does not overflow"
  to fix abortion with wrong PF addr.
- Link to v8: https://lore.kernel.org/r/20240228-reuse-v8-0-282660281e60@daynix.com

Changes in v8:
- Clarified that "hw/pci: Replace -1 with UINT32_MAX for romsize" is
  not a bug fix. (Markus Armbruster)
- Squashed patch "vfio: Avoid inspecting option QDict for rombar" into
  "hw/pci: Determine if rombar is explicitly enabled".
  (Markus Armbruster)
- Noted the minor semantics change for patch "hw/pci: Determine if
  rombar is explicitly enabled". (Markus Armbruster)
- Link to v7: https://lore.kernel.org/r/20240224-reuse-v7-0-29c14bcb952e@daynix.com

Changes in v7:
- Replaced -1 with UINT32_MAX when expressing uint32_t.
  (Markus Armbruster)
- Added patch "hw/pci: Replace -1 with UINT32_MAX for romsize".
- Link to v6: https://lore.kernel.org/r/20240220-reuse-v6-0-2e42a28b0cf2@daynix.com

Changes in v6:
- Fixed migration.
- Added patch "pcie_sriov: Do not manually unrealize".
- Restored patch "pcie_sriov: Release VFs failed to realize" that was
  missed in v5.
- Link to v5: https://lore.kernel.org/r/20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com

Changes in v5:
- Added patch "hw/pci: Always call pcie_sriov_pf_reset()".
- Added patch "pcie_sriov: Reset SR-IOV extended capability".
- Removed a reference to PCI_SRIOV_CTRL_VFE in hw/nvme.
  (Michael S. Tsirkin)
- Noted the impact on the guest of patch "pcie_sriov: Do not reset
  NumVFs after unregistering VFs". (Michael S. Tsirkin)
- Changed to use pcie_sriov_num_vfs().
- Restored pci_set_power() and changed it to call pci_set_enabled() only
  for PFs with an expalanation. (Michael S. Tsirkin)
- Reordered patches.
- Link to v4: https://lore.kernel.org/r/20240214-reuse-v4-0-89ad093a07f4@daynix.com

Changes in v4:
- Reverted the change to pci_rom_bar_explicitly_enabled().
  (Michael S. Tsirkin)
- Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
- Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
- Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com

Changes in v3:
- Extracted patch "hw/pci: Use -1 as a default value for rombar" from
  patch "hw/pci: Determine if rombar is explicitly enabled"
  (Philippe Mathieu-Daudé)
- Added an audit result of PCIDevice::rom_bar to the message of patch
  "hw/pci: Use -1 as a default value for rombar"
  (Philippe Mathieu-Daudé)
- Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com

Changes in v2:
- Reset after enabling a function so that NVMe VF state gets updated.
- Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com

---
Akihiko Odaki (12):
      hw/pci: Rename has_power to enabled
      hw/ppc/spapr_pci: Do not create DT for disabled PCI device
      hw/ppc/spapr_pci: Do not reject VFs created after a PF
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Ensure VF function number does not overflow
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Remove num_vfs from PCIESriovPF
      pcie_sriov: Register VFs after migration
      hw/pci: Replace -1 with UINT32_MAX for romsize
      hw/pci: Convert rom_bar into OnOffAuto
      hw/qdev: Remove opts member

 docs/igd-assign.txt               |   2 +-
 docs/pcie_sriov.txt               |   8 +-
 include/hw/pci/pci.h              |   2 +-
 include/hw/pci/pci_device.h       |  19 ++++-
 include/hw/pci/pcie_sriov.h       |   9 ++-
 include/hw/qdev-core.h            |   4 -
 hw/core/qdev.c                    |   1 -
 hw/net/igb.c                      |  13 +++-
 hw/nvme/ctrl.c                    |  24 ++++--
 hw/pci/pci.c                      |  33 +++++----
 hw/pci/pci_host.c                 |   4 +-
 hw/pci/pcie_sriov.c               | 149 +++++++++++++++++++++-----------------
 hw/ppc/spapr_pci.c                |   8 +-
 hw/vfio/pci-quirks.c              |   2 +-
 hw/vfio/pci.c                     |  11 ++-
 hw/xen/xen_pt_load_rom.c          |   6 +-
 system/qdev-monitor.c             |  12 +--
 tests/qtest/virtio-net-failover.c |  32 ++++----
 hw/pci/trace-events               |   2 +-
 19 files changed, 200 insertions(+), 141 deletions(-)
---
base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


