Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8A0C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIBw-0000Yw-U5; Wed, 28 Feb 2024 06:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIBn-0000XZ-Iq
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:33 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIBl-0005tr-LA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:31 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2998950e951so3700587a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120008; x=1709724808;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QpILs8s5+YntAP1wSKY9eidG0i2Lfm/RB/gLZWHwxUE=;
 b=o2G4nohBaEMM6IOZ9njNb8JeyVb0XRlO1D219bQLLEwjolDwg0zcuvlRen5fjlZ1Hi
 LRs+jfQNjDVGRP8MG3N6mW0w8+KJeiVsrs/9ah11DBi9WrePvxU39FXy1+KtwXP3G3Ho
 e5JQsa+ZFOBMsfyWwtbESwtHk5ROiyDI+dKAdLaOD/zVXYguf5IAZoo8g+ZcR4SqzWYJ
 ljjE/sfkUpOEYs9Ahjq0kb55R+iaZECFUO87zOLLfCjiVHOh6hcFxEQQaktTneg70LG8
 1MB47dr0LVH9F+U2JY5B4+3swGPofE33YoMunSMBbx4NszXufRIBqnJmpOpNrOZeBfLJ
 0DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120008; x=1709724808;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpILs8s5+YntAP1wSKY9eidG0i2Lfm/RB/gLZWHwxUE=;
 b=saM/W2JWzwHruDmb3IQKPYw7SUzw1YD+Z5QSPPVNRo4nnJc+blBWJN7sLnkGVmEN7L
 /iTMxfhRs/5dMMK1aZ1LoX3U/LOZc9RfqNM+DS8D+mU8K3FwIFe5HKaJo1BxJLdhegB/
 4YG810Xkhmr4ePWiPVuuw7noGv4RghsCK8w2vVFyvw+JYQMn/nH0HMb1+W4hgftSQCqG
 1qT5HMw+7dBgnGMqOnWG7fFW+CWAobF7lsPA4atmlOICHCJppcDv8VDCAZGCViEF/WHm
 +1Bpw7Lnw8vc2pmPzfWNNS/Fsy9boD1nYl/gUiaLespyRHwsAsle+vPV3I9Co7/VmniV
 XfAw==
X-Gm-Message-State: AOJu0Yzjo2iYuUBid6PLaCYDZTdc0ssrVIcPY2vPYwxJFUbMryp681T4
 rB6JYJiw/Rk1GFJjjiWdHs9U/ItRj7yw5WT0g95E2xmt7niUBf6VuRaXpeuT8TA=
X-Google-Smtp-Source: AGHT+IE2/J7fSGXM+w8fVyFeDJTdceQNrrkPgcVskz9/rS/fa/vXTwlqrkL0nstNvcoAVaATKqWhgg==
X-Received: by 2002:a17:90a:d34d:b0:29a:b13a:2455 with SMTP id
 i13-20020a17090ad34d00b0029ab13a2455mr6997356pjx.30.1709120007933; 
 Wed, 28 Feb 2024 03:33:27 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 t16-20020a17090a0d1000b0029942a73eaesm1472534pja.9.2024.02.28.03.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:33:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 00/15] hw/pci: SR-IOV related fixes and improvements
Date: Wed, 28 Feb 2024 20:33:11 +0900
Message-Id: <20240228-reuse-v8-0-282660281e60@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPcZ32UC/2XPQW7DIBAF0KtErOsKBrChq94jygLGQ8OidgStl
 Sjy3YvTOqJi+Ue8L/6dZUqRMns73FmiJeY4TyWYlwPDs5s+qItjyQw4KC7Adom+M3XBOQLwQli
 pWHl7SRTi9dFzPJV8jvlrTrdH7SK2628DcPnXsIiOd9qTQY3US2neR3eb4vUV50+2VSxQMcF3B
 oWB8g6c5tBbaJisGexMFma4GHxvLNIQGqZqpnamNmbdyK10fAiqYbpmZme6MFIBBQrrtbMN6ys
 Gz239to0UODCeY2i3DTV7fnLYmEWhPHqrgf6xdV1/AL3zgDzlAQAA
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Akihiko Odaki (15):
      hw/nvme: Use pcie_sriov_num_vfs()
      pcie_sriov: Validate NumVFs
      pcie_sriov: Reset SR-IOV extended capability
      pcie_sriov: Do not reset NumVFs after disabling VFs
      hw/pci: Always call pcie_sriov_pf_reset()
      hw/pci: Rename has_power to enabled
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Remove num_vfs from PCIESriovPF
      pcie_sriov: Register VFs after migration
      hw/pci: Replace -1 with UINT32_MAX for romsize
      hw/pci: Use UINT32_MAX as a default value for rombar
      hw/pci: Determine if rombar is explicitly enabled
      hw/qdev: Remove opts member

 docs/pcie_sriov.txt         |   8 ++-
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |  22 +++++-
 include/hw/pci/pcie_sriov.h |  13 ++--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  15 ++--
 hw/nvme/ctrl.c              |  54 +++++++-------
 hw/pci/pci.c                |  32 +++++----
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie_sriov.c         | 170 ++++++++++++++++++++++++--------------------
 hw/vfio/pci.c               |   3 +-
 hw/xen/xen_pt_load_rom.c    |   2 +-
 system/qdev-monitor.c       |  12 ++--
 hw/pci/trace-events         |   2 +-
 15 files changed, 194 insertions(+), 150 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


