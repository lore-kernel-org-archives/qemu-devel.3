Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2EBE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm3e-0000qO-At; Thu, 09 Jan 2025 01:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3Z-0000ps-D0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:14 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3V-0003dW-QZ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:13 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2156e078563so6920905ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404208; x=1737009008;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pgvEn3lO2PpOG8nW5ZGwdRr18e80HQKzFGn6ts2Ixn8=;
 b=h6S5ith2EhttVA2qnUy8iyi+kfcAiW+ghjqNteLd2J5CS03BuobClhmikwiRuZv4vd
 1poEpNLGsyYDyFIcrmHRwQC25VnLxWFoJH11adiphpMonawqzXdatfm1CJD2lIHs+XmX
 k3cqTy+0DM8Vn1RqDsLbVDyMXOj0nPxMLF2c4mZ/0lHUT5yr6wE8Zzrx2Pq4UPHB7UuN
 huEVJ4EFWfsjfTjgSQZvBxfG/zRdJ0biqL8Q+TivT4PECuAslA6vUYUCf/vXz9sDzEeU
 pU3Gbo7O2T/6AsOyKZ25wAFoUlb5cOaUE1G/Hgu3+wk9qmpdp8FYTLACIn5Jot+kUUQS
 iVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404208; x=1737009008;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pgvEn3lO2PpOG8nW5ZGwdRr18e80HQKzFGn6ts2Ixn8=;
 b=VXsONEPBwYr8F2U64NtvAheqnAINja6QOdDB0ItoDqLAadKZhNt2jf6iy3X4+nop6B
 t10UJlbhcN9Ral0C/L6uus0vWyorFVwCWTVq9Vu3aw5uL9oBn3x4sq7kQ4vxgp8KLxiG
 ol9p3MXHHUHyqexp9XmCtroVMJGTlEce5Ju5oE9tyq+OZb/qGP6dKLTxp3AKSN4PIbrg
 U4tUG6HFTYWldGe+bZz0ylNknL1qiqmp4R3fi/6q9tJzt+vrmA5iExCafR3dvq4uRADJ
 FLmoC16xTd38OCKdRdBcBs3xMKgXZHYO3+LOn/2CNKBZNLrLXczujBf9QlIuGyYgpGtO
 FJpw==
X-Gm-Message-State: AOJu0Yxsi6EoaCUffUkWx1WylRhDBLiNn54SK2zpFeHmrmLHU1w45t11
 t2cZ4+3+p+scoodOzpRjQcDlRy/ImE9tDFDppmTmSx37CStH2pJC7vmwBGcFZfw=
X-Gm-Gg: ASbGncs0gD/I+NxCNg0W+2E0PWBMm+2bP9ZsAAAtFgNHATl6Nf2I2x6A7fGqS74F656
 y4ann/p8ZIjlTLmHD9rhb/GW6sZMBMXQ/PQUTXvOPzhUfsqM+82cPLyjS78JGn+LlHvnyW/yBbc
 kU9+i4PPbYGCorjgrfOuuOBhZI/Eqc/he2gPTXLsXw1HSj9YZBz0yE67W8sqCTcExoKNxfHa/7r
 Sv5ZWgrKMJ/ZQ/wrcjqgW0x7gIyhzXu06yofiZZ4KQ+tPlJHDvwubZMBOQ=
X-Google-Smtp-Source: AGHT+IFUoLo81iQCGVkbKck8rv1OJ+BZ8Ya9xZa45EDu+OcU+Z3XU6iKWMno/35aN3i0GEwAvE9xOg==
X-Received: by 2002:a05:6a20:a107:b0:1e0:d766:8da1 with SMTP id
 adf61e73a8af0-1e88d2fc6bemr9379663637.39.1736404207985; 
 Wed, 08 Jan 2025 22:30:07 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8361b7sm36248711b3a.74.2025.01.08.22.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:30:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v19 00/14] hw/pci: SR-IOV related fixes and improvements
Date: Thu, 09 Jan 2025 15:29:45 +0900
Message-Id: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANlsf2cC/23SzW7UMBDA8VepciZoZvzNifdAHDz2mObAbpXAq
 lW17469kMTIPcbKbxLb//dpk3WRbfry9D6tclu25XqpDxg+PU3pOV5+yLzkujARkAakMK/ye5O
 5xChEjBiUnuq7L6uU5fUx6Nv3+vy8bL+u69tj7g3b6t8JBOrfhBvOMBsWn0wSq5T/muPbZXn9n
 K4/pzbiRh1D2BlVRpojRQNkAw1M9Yx2pirzgI6tD0lcGZjumd6ZbizEDEFFcEUPzPTM78xUJro
 kTBjYxDAw2zE69mbb3kRTJM+Qyrg317PjJ11jIaHmxMGQDMz37PhJ35gna4E8ioWBhZMpNDsLl
 VkXow2x6GzUwBBOZ8kd9w0VuhSBvWSVw3gF2IXi4bg6bKUU9orZ1/MsPELq4XEu2FrJKihIGhF
 5PE9UPTy2iK2WWniMOrtc8gewy8Xj2XTrRSc0nKwIiB1hF4ynEz6KybleoAUhPxaDXTKh+2JrJ
 gNa1qyLxQ++eEaD9foP2Krh7BIqRcrJmDYe2RjA7lRbN0npILFkb93/Adzv9z+jJqAgVQQAAA=
 =
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
Akihiko Odaki (14):
      hw/pci: Rename has_power to enabled
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
      hw/pci: Use -1 as the default value for rombar
      hw/qdev: Remove opts member

 docs/pcie_sriov.txt         |   8 ++-
 include/hw/pci/pci.h        |   1 +
 include/hw/pci/pci_device.h |   4 +-
 include/hw/pci/pcie_sriov.h |   9 +--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  10 ++-
 hw/nvme/ctrl.c              |  22 +++---
 hw/pci/pci.c                |  36 ++++++++--
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie_sriov.c         | 159 ++++++++++++++++++++++++--------------------
 hw/ppc/spapr_pci.c          |  20 +++++-
 hw/s390x/s390-pci-bus.c     |  42 +++++++++---
 hw/vfio/pci.c               |   5 +-
 system/qdev-monitor.c       |  12 ++--
 hw/pci/trace-events         |   2 +-
 16 files changed, 211 insertions(+), 128 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


