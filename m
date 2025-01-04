Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8844E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyxd-0000x8-Cu; Sat, 04 Jan 2025 02:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxb-0000wM-0E
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:39 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxY-00031a-Ug
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:38 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so13518557a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977155; x=1736581955;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aseo/3QWw+nycGIJviqzZZf35h/mvmstu5RbBWE55SM=;
 b=ocvnqtCRwFxP0WOMSKc2ggAhr3rRyetnu378At50DPJY4L0fK7chy7Ewk7fKDhxDFr
 CbVzhgRVWHYNERkFqPybusLSqQZM3fdBzR8E7c/LfhLXg7hQYmtJR1Yv3B/nWaO0oBKs
 KJ6AbKTMGWnh4yzx+ow0tYE8fdlH0rm+++TR+6sQcD/9/oLjOhUQhhTHq7teuRj6H3NV
 uDiyz2koz8Abv1+8Tk0OV2BgTJ42hxnqZPrrjqr31bIN5whZbaGV1q+WdPuMFWevuCu6
 YVfOnDMy02EocFXH43MtDQHmawG//0dMwKlIp4elfK1H/XCiFfYt//RHLGDS2ljEhcPj
 HSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977155; x=1736581955;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aseo/3QWw+nycGIJviqzZZf35h/mvmstu5RbBWE55SM=;
 b=UK2+nQRiKC3/6uvKzj+O8uVAhJQBMqiQmjBedSCtEdRPNaGRKW8R+7PA/d7czRCkdY
 Fp3hpCaBg294KtnHfwEuvsjokDUSwIf70Rf++r30kRyxhFLhVQHSMeu+FDyFp4WWh8id
 DBwogqMNfxxha0C642bYJLVpoUQAR/whNyri+NbYpt9128u2HgNVpQpe3CnijZgrQIij
 GEB/j5sPxoAqxT+UBkwkpNb+s1DlfASSQqOHye8gLvYKJVhKtBj5A2fEEtWN4xmcXLAw
 kIVJzrkzVvioZmbrmeQ8TYyTAZoeN1WSyJFE9vGItLkEvKECCeCV734WTjF497wK0xPC
 /HHA==
X-Gm-Message-State: AOJu0Yy4yvElwfZQwIq/uW3TayTU5UmP4mpVoYND5XrHidMvr+5hF7TO
 AoicKV+2gOUT+Rn885aPE+AbCLvd0JcEg2NT024Px7/NKq9kZTZCmM/GExdyJyM=
X-Gm-Gg: ASbGncssNFpMW6S7axeYRsxd5NyQL/iCdox4+Fp3jp5svH332jRNpjp4bpzzAvBCta1
 Ysrv6qooAhFjA6ZtGM8ctj7W+3iSjupalD4CO9xPETRmNkOIHJ6aMwOiWvOV+1f7saz6hK26+Ba
 ZRZkOSb0GTVBoI9Vfmb9XGoEXxwQUhpFea6ru17jC6WX4yqEQMQ8cThCXvk1qVwYUZ8oNlHhqhv
 pMm3ild46eUOQ1fmIUyov3XFugb1vNsqLn2muKU2guK1QfniF/uqcmSMxEA
X-Google-Smtp-Source: AGHT+IGpJnYxvDMPdxmQhyaeyDa5B/bO1lULGoNMIzmzsaWQ/0UmmcSePv5aMuj+VvSn9YVP5tN3Mg==
X-Received: by 2002:a05:6a00:ad3:b0:728:b601:86df with SMTP id
 d2e1a72fcca58-72abdd91456mr74530028b3a.10.1735977155275; 
 Fri, 03 Jan 2025 23:52:35 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8fba98sm27537295b3a.161.2025.01.03.23.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:52:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v18 00/14] hw/pci: SR-IOV related fixes and improvements
Date: Sat, 04 Jan 2025 16:52:20 +0900
Message-Id: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALToeGcC/23SzY7cIAwH8FdZ5dxUtvnuqe9R9YDBdHPozCppR
 7tazbsXpk1CxR5B/AzG//dpk3WRbfry9D6tclu25XqpC/Sfnqb0HC8/ZF5y3ZgISANSmFf5vcl
 cYhQiRgxKT/XsyypleX0U+va9rp+X7dd1fXvUvWHb/VuBQP2rcMMZZsPik0lilfJfc3y7LK+f0
 /Xn1ErcqGMIO6PKSHOkaIBsoIGpntHOVGUe0LH1IYkrA9M90zvTjYWYIagIruiBmZ75nZnKRJe
 ECQObGAZmO0ZHb7b1JpoieYZUxt5cz45HusZCQs2JgyEZmO/Z8UjfmCdrgTyKhYGFkyk0OwuVW
 RejDbHobNTAEE5nyR3zhgpdisBessphHAF2QfFwjA5bUgp7xezrfxYeIfXw+BdsWckqKEgaEXn
 8T1Q9PFrElpaa8Bh1drnkD2AXF49npltedELDyYqA2BF2gfF0wkdicq4DtCDkx8RgF5nQ3dgyk
 wEta9bF4gc3nqHBOv4DttRwdgmVIuXk/2jf7/c/i04lmBwEAAA=
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |  19 +++++-
 include/hw/pci/pcie_sriov.h |   9 +--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  10 ++-
 hw/nvme/ctrl.c              |  22 +++---
 hw/pci/pci.c                |  23 ++++---
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie_sriov.c         | 159 ++++++++++++++++++++++++--------------------
 hw/ppc/spapr_pci.c          |  20 +++++-
 hw/s390x/s390-pci-bus.c     |  42 +++++++++---
 hw/vfio/pci.c               |   5 +-
 system/qdev-monitor.c       |  12 ++--
 hw/pci/trace-events         |   2 +-
 16 files changed, 212 insertions(+), 130 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


