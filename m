Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF688EEEC0B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxEj-0003KO-JD; Thu, 12 Sep 2024 23:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxEh-0003JE-Qc
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:44:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxEf-00081J-85
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:44:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so1290163b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199079; x=1726803879;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2v0B0MqBQU16aS4rM02kxbO2DvS4wsiLcrbdrI5VJYE=;
 b=V/ok+e3/6IULqdn9uMnoP8ERYKLRcNDzYs9jukWN1m5jaNHP16ACqIywVI+I1w3wvX
 W97XVT1Iyb0ES5ZP1JjzQJ2wdtvM7u8Tnon6Obz7AsT+M43GC5yOr2uUsbPMoBYkrLPb
 K3wnfD/mht/Vzij7K9EMs1oLEmKN8d57NNVZNwFX705h0M6b0zJ9vCG/HhtRbsTUltHh
 HrnhfhZw/md/P8cXO8kZBncJhOX+VeqaIeIXnRgN7RjcgDd1uFx+rPQKo4Kpbtt0+tKw
 qYWCtX/CaZNmJUmQA61XQI/plC6xaVdifeFLCksNLi5u1fhLvl0eOCpO0VfI3rR/xAKV
 ywSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199079; x=1726803879;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2v0B0MqBQU16aS4rM02kxbO2DvS4wsiLcrbdrI5VJYE=;
 b=KkZt4VXs5OCn5kw5b4j9swuz1YgGysEgXSyUUS7PmU0Y+DmnwFBu6KX2f6rglfi9IV
 eSy2lVr8vbtaNT8MZa5K8NZuUlsNsp7EN0rHDBLS74pkogfjZfng6KPnnrhHIUJ0WnqC
 yaOOSanniwbONhuqZuRTVksQvi/ljSwXoMSP7LVymTRyC+8oPl3DeLv6m70EbgIsKC0Y
 eCBtGfXePcOG8WLqKIcouikBJg8ODQJ8g6Y5LB3qgFYNdPWJraLoi5/IyQzBwMnAU5BQ
 ABhdFpeLt5qNR9WJfQIsrpmZE2nELc7TyhXOK7o+kwwsKi1RsUMqvQJvCppXlmM490DA
 JpKA==
X-Gm-Message-State: AOJu0YyRHbyVBD0G4591PxJIBIutZEX3Q4i7VeuK80wHYeAM/MYyT59a
 1VIFMp0b7ABbpI1Nwk6JJgsGn+JleKgGybi9PUHWIexImm3jL7MGByUKMx/y5Ow=
X-Google-Smtp-Source: AGHT+IFnuBy+sR6xyEYX89s+g0CRXBcNwHr3uj7flX6w3+NSidPW7JXl6dY9Oyou79Hje8K5oWdsxw==
X-Received: by 2002:a05:6a21:181a:b0:1cc:bb1f:1d4 with SMTP id
 adf61e73a8af0-1cf756c1867mr8351630637.0.1726199078850; 
 Thu, 12 Sep 2024 20:44:38 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71908fc8247sm5273526b3a.29.2024.09.12.20.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:44:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v16 00/13] hw/pci: SR-IOV related fixes and improvements
Date: Fri, 13 Sep 2024 12:44:28 +0900
Message-Id: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABy142YC/23SS27cMAwG4KsEXtcBSb2ornKPoAs9qMaLzhR2M
 kgQzN0rTWuPAnUpQR8hkv/ntMm6yDZ9f/icVrks23I+1QPabw9TegmnnzIvuV5MBKQByc+rvG0
 ylxCEKCJ6paf69vcqZXm/FXr+Uc8vy/Z6Xj9udS/Ybv9WIFD/KlxwhtlE4WSSWKX4KYeP0/L+m
 M6/plbiQh1D2BlVRjoGCgbIehqY6hntTFXGgC5a9klcGZjumd6ZbsyHDF4FcEUPzPSMd2YqE10
 SJvTRBD8w2zE6erOtN9EUiCOkMvbmenZ80jXmE+qYojckA+OeHZ/kxpisBWIUCwPzd6bQ7MxXZ
 l0I1oeis1EDQ7g7S+7YN1ToUoDIklX24wqwCwrDsTpsSSmRVYxc51niCKmHx1ywZSUrryBpRIz
 jPFH18GgRW1pqwkPQ2eWS/wO7uDDeM93yohOamKwIiB1hFximO7wlJue6QAtC/DUx1+v1DwDpv
 s6qAwAA
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")

I submitted a RFC series[1] to add support for SR-IOV emulation to
virtio-net-pci. During the development of the series, I fixed some
trivial bugs and made improvements that I think are independently
useful. This series extracts those fixes and improvements from the RFC
series.

[1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v16:
- Added patch "s390x/pci: Avoid creating zpci for VFs".
- Added patch "s390x/pci: Allow plugging SR-IOV devices".
- Link to v15: https://lore.kernel.org/r/20240823-reuse-v15-0-eddcb960e289@daynix.com

Changes in v15:
- Fixed variable shadowing in patch
  "pcie_sriov: Remove num_vfs from PCIESriovPF"
- Link to v14: https://lore.kernel.org/r/20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com

Changes in v14:
- Dropped patch "pcie_sriov: Ensure VF function number does not
  overflow" as I found the restriction it imposes is unnecessary.
- Link to v13: https://lore.kernel.org/r/20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com

Changes in v13:
- Added patch "s390x/pci: Check for multifunction after device
  realization". I found SR-IOV devices, which are multifunction devices,
  are not supposed to work at all with s390x on QEMU.
- Link to v12: https://lore.kernel.org/r/20240804-reuse-v12-0-d3930c4111b2@daynix.com

Changes in v12:
- Changed to ignore invalid PCI_SRIOV_NUM_VF writes as done for
  PCI_SRIOV_CTRL_VFE.
- Updated the message for patch "hw/pci: Use -1 as the default value for
  rombar". (Markus Armbruster)
- Link to v11: https://lore.kernel.org/r/20240802-reuse-v11-0-fb83bb8c19fb@daynix.com

Changes in v11:
- Rebased.
- Dropped patch "hw/pci: Convert rom_bar into OnOffAuto".
- Added patch "hw/pci: Use -1 as the default value for rombar".
- Added for-9.2 to give a testing period for possible breakage with
  libvirt/s390x.
- Link to v10: https://lore.kernel.org/r/20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com

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
Akihiko Odaki (13):
      hw/pci: Rename has_power to enabled
      hw/ppc/spapr_pci: Do not create DT for disabled PCI device
      hw/ppc/spapr_pci: Do not reject VFs created after a PF
      s390x/pci: Avoid creating zpci for VFs
      s390x/pci: Allow plugging SR-IOV devices
      s390x/pci: Check for multifunction after device realization
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Remove num_vfs from PCIESriovPF
      pcie_sriov: Register VFs after migration
      hw/pci: Use -1 as the default value for rombar
      hw/qdev: Remove opts member

 docs/pcie_sriov.txt         |   8 ++-
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |  19 +++++-
 include/hw/pci/pcie_sriov.h |   9 +--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  13 +++-
 hw/nvme/ctrl.c              |  24 ++++---
 hw/pci/pci.c                |  23 ++++---
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie_sriov.c         | 153 +++++++++++++++++++++++---------------------
 hw/ppc/spapr_pci.c          |   8 ++-
 hw/s390x/s390-pci-bus.c     |  40 +++++++++---
 hw/vfio/pci.c               |   5 +-
 system/qdev-monitor.c       |  12 ++--
 hw/pci/trace-events         |   2 +-
 16 files changed, 199 insertions(+), 128 deletions(-)
---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


