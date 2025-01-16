Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16ADC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLka-000896-49; Thu, 16 Jan 2025 04:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLkY-00088D-Cq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:15 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLkV-0000vY-Ka
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:13 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166360285dso11111405ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018069; x=1737622869;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z4fcvrtFMb3tEXkyl3/g+nhsL3eRNfTE0SsG8nv6/mo=;
 b=16N0uLrRecDV2QeTP8XpMeiQQbddIgAcUtOureDRWBxu5nwQN4n/43GzkFVayHLxA4
 tZxXCJZRfY1n+MAqZC/AQpaqRhw+u+fDuBxUDsf9hVPi+JLJDjX8aUyLYfT6NKCxIt/r
 6UkymnfL4lFIdTUk8bScYuOEho2w6Y778rXi/JyjM43lz0Wxia2UBJ7c4mv85540cpT1
 vfMGetQHIquRcwwTVSWcCSVxprk/UgT7KiiiBzpFL5Pxl2Krhq1PdRnNlPm1YQ/h9NPM
 JFHnnDbuA7/C5N4tVmEZZuve7Wl8lxYcEeBnhiErxI9gS2zjeyrLICaZbESt1FQtUoif
 vGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018069; x=1737622869;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4fcvrtFMb3tEXkyl3/g+nhsL3eRNfTE0SsG8nv6/mo=;
 b=oHcsd2YNy5+3tPexWWTZMSuoJ+QuiySvs6CxW956W64nZFqDpjLzUGXkc41NvZ1uDo
 I559by40dOzV+xxLNmyT9xijg9OoYZ1AK8aP56/4S6NM6sLdP2bdAM2E3fYEvb+pV0Pf
 JVVjZzGWj+8Lbod4n16OVTWlhHAr00Q0bAb4FJHkuzb88eBssXfgLwGk/r88STT7k26D
 w/kth3Eh7Z8us3xKRyl32yIDDZferHJKwa6b58PL21w5N1K78hvz+6wSEwOp5sbd4wIZ
 sdCaXQhKiPOBGFIkhX9DWGlVRZ9dHldjw5MvX0BjkLMGME/7F0G0+zJy8+jMLznB/+kJ
 CfRg==
X-Gm-Message-State: AOJu0YyZB6MG21MFmWGb/Efi3rtvdZNfhmUzG6AAAu3G5Km0/xj/0jXe
 ryE8mh5K2tap28VZ72iubzGbk9Wal0EtDz+P9ko0pUwI6/p3NCihepfa4sInPnM=
X-Gm-Gg: ASbGncuT8hCR6wP80OhY8FSFkHKwC9u5sqVyhazNNp3bJGeD7Kasg74ZRRaKouPiJ8X
 ag0OPKMGs8j9y0LtCW8bBwIMC0mLX5O2rwGmL+s+V7XQRN/vkRpc1QvBjXJbAeDqnQRpVrPvQmN
 C3X5vxmdDg0Mo9t3Tg+j4ExBp4r9Hp5oYy0DZfCRlakIDtH3RXr2PuAY4siWNeFK6BeNm++vtDD
 hh2oPXQHNowHrEIwOtJ8RCc/jFCvzBHirmpqmVRdYd3E3LXj8aXoDyKh3o=
X-Google-Smtp-Source: AGHT+IGpPDz88/31QaLUa6y+8THg9rpxFbiEEYXjVWVTSLwesxyH6XMH8jo9TvLnir3F8+44t98LqQ==
X-Received: by 2002:a17:902:f54f:b0:211:e812:3948 with SMTP id
 d9443c01a7336-21a83da2b03mr512285885ad.0.1737018069414; 
 Thu, 16 Jan 2025 01:01:09 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f25c661sm94536825ad.248.2025.01.16.01.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:01:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v20 00/11] hw/pci: SR-IOV related fixes and improvements
Date: Thu, 16 Jan 2025 18:00:51 +0900
Message-Id: <20250116-reuse-v20-0-7cb370606368@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMPKiGcC/23SS27bMBCA4asEWlfBzPDdVe8RZMHHMNGidiC1R
 oLAdy/pRhQDeilC30gk/89p43Xhbfr58DmtfFm25XwqDwQ/Hqb46k8vPC+pLEwEJAHJzSv/3Xj
 O3jNRQHRCTuXdt5Xz8n4b9PRcnl+X7c95/bjNvWBd/T+BQHxNuOAMswpso4qshbC/kv84Le+P8
 fx7qiMu1DGEnVFhJIMnr4C0o4GJntHORGEW0ARtXWSTByZ7JncmK3M+gRMeTJYDUz2zO1OFscw
 RI7qgvBuY7hi1vem6N5bkyQaIedyb6Vn7SVOZiyhDDE4RD8z2rP2krcyS1kAWWcPA3MEEqp25w
 rTxXjufZVJiYAiH02TafUOBJnoIlpNIbrwC7EKx0K4Oayk5WBGCLeeZwwiph+1csLaShBMQJSK
 G8TxR9LBtEWstpXDvZTIppzuwy8Xi0XTtRUZUIWpmYD3CLhhLB7wVk1K5QA1MdiwGu2Rc98XaT
 ALUQQaZNd754hENlutvsFYTkokoBAnDY9rYslGA3anWbqKQjn1OVps7AbgeugZrOVlJZEvRq2y
 +wev1+g/Z5zBEjgQAAA==
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Changes in v20:
- Use qdev_is_realized().
- Link to v19: https://lore.kernel.org/r/20250109-reuse-v19-0-f541e82ca5f7@daynix.com

Changes in v19:
- Avoided inling pci_set_power().
- Link to v18: https://lore.kernel.org/r/20250104-reuse-v18-0-c349eafd8673@daynix.com

Changes in v18:
- Rebased.
- Link to v17: https://lore.kernel.org/r/20241022-reuse-v17-0-bd7c133237e4@daynix.com

Changes in v17:
- Added patch "pcie_sriov: Ensure VF addr does not overflow".
- Changed not to link VF with sPAPR DRC.
- Asserted pci_is_vf() when zpci is not found. (Cédric Le Goater)
- Link to v16: https://lore.kernel.org/r/20240913-reuse-v16-0-d016b4b4f616@daynix.com

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
Akihiko Odaki (11):
      hw/ppc/spapr_pci: Do not create DT for disabled PCI device
      hw/ppc/spapr_pci: Do not reject VFs created after a PF
      s390x/pci: Avoid creating zpci for VFs
      s390x/pci: Allow plugging SR-IOV devices
      s390x/pci: Check for multifunction after device realization
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Ensure VF addr does not overflow
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Remove num_vfs from PCIESriovPF
      pcie_sriov: Register VFs after migration

 docs/pcie_sriov.txt         |   8 ++-
 include/hw/pci/pcie_sriov.h |   9 +--
 hw/net/igb.c                |  10 ++-
 hw/nvme/ctrl.c              |  22 +++---
 hw/pci/pci.c                |  21 +++++-
 hw/pci/pcie_sriov.c         | 159 ++++++++++++++++++++++++--------------------
 hw/ppc/spapr_pci.c          |  20 +++++-
 hw/s390x/s390-pci-bus.c     |  42 +++++++++---
 hw/pci/trace-events         |   2 +-
 9 files changed, 187 insertions(+), 106 deletions(-)
---
base-commit: 7433709a147706ad7d1956b15669279933d0f82b
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


