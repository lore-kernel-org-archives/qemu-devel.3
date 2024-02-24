Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED4C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoH4-0006MG-74; Sat, 24 Feb 2024 04:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoH3-0006LU-67
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:24:49 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoGz-0002NI-LY
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:24:48 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so1188762a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766684; x=1709371484;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FLuDekVo/OQlHHYu0NQSKy11eQTVnGRj+7wb1VVa+Po=;
 b=qJXZoCkS3vmuPtt+9HafD+1SM6QIHitsrGe0OGqMquXqZyS3McBL2+OPD7UiBs9avT
 rWwqLKlENqrKvUq6mK/Ie6et/7/0GYUJFklxFJFKfNZaeRRhkz0NpWJHHEu6K5hcdQej
 39RypkKn4OiQuqJpxcmA5b+zRvGzrp3eiRaTtu63jVeHBatvKqbCMsdzHFZGOGNmD/dv
 ct4MSWLzEUYxko6WJ0bNZC8bxour2n4J/ZGX/tLwyZ2ZXHpxQvz8K08U9ydc6GfrSIb8
 1gJtOgDQZg9atV26sVW908eJZg1UA032Y2kzwgSTO8+g/lm37Mi1mvYEmnw02QuWlffb
 pGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766684; x=1709371484;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FLuDekVo/OQlHHYu0NQSKy11eQTVnGRj+7wb1VVa+Po=;
 b=IFlS1WQkdXW3k8Js5Yh+BdCjS0P0EKGZqD8xodjGqYfuWX5n4vWPRVad68CJ+AOKXs
 3eFD/szro+jin+hQXYk1Jb8tkqDwietkfZOs70pqyxy90bSFo+/wJhwXUleol57mXtO2
 kNU0Bq21+TR43MBHb/5MWC/87UlrHilghlP0qnf9XqGzurKyfj+iJ1inVokHawl3Kkp1
 ct8slQyRdsang3QpJ5JmceVn1AevPmHTizY+8MvkjjWbf++qQYCp1BNBSzkwigIocixp
 0Kjlw66JzNKH/rMjdUNi0gv9e8P+1R6yT8jy8TIqmr8fSKs+K3NPDtfYqrQCYSewjVRk
 GzPg==
X-Gm-Message-State: AOJu0YwRdemwPSAQenHad5ha3qOpT7Z9QpAgq41VX1FuZEgnTvRwBLrC
 OVdaWI29UBu1CVhPL40aKV3rZFP8pcPnLkkytbQ0hw/+HhJQlhruPY1Ur/ORcis=
X-Google-Smtp-Source: AGHT+IGV8DCyMmYBSS2EunuAo3UuKFv2Rf7Su24Gu/d/oa1N3k0F+ltP9nwfdLMWw/6r44/xcVwq7Q==
X-Received: by 2002:a17:902:e5cf:b0:1db:7c5e:f07c with SMTP id
 u15-20020a170902e5cf00b001db7c5ef07cmr2795828plf.66.1708766683999; 
 Sat, 24 Feb 2024 01:24:43 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 kr13-20020a170903080d00b001d9588f0714sm670203plb.177.2024.02.24.01.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:24:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 00/16] hw/pci: SR-IOV related fixes and improvements
Date: Sat, 24 Feb 2024 18:24:32 +0900
Message-Id: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANC12WUC/2XP3U7EIBAF4FfZcC0Ghp+CV76H8WKgg8uFrQFtd
 rPpu0tXazC9PJP5TnJurFLJVNnT6cYKLbnmeWpheDixeMbpjXgeW2YgQAsJnhf6qsQTIgEEKb3
 SrP1+FEr5cu95eW35nOvnXK732kVu158GEOq3YZFccBPIRRPJKuWeR7xO+fIY53e2VSzQMSl2B
 o2BDghoBFgPB6Z6BjtTjTkhh2CdjzSkA9M90zvTG/M4Cq9QDEkfmOmZ25lpjHSKMkofDPoDsx2
 Dv21220YaEFwQMf3ftq7rNwhpV5+uAQAA
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Akihiko Odaki (16):
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
      vfio: Avoid inspecting option QDict for rombar
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


