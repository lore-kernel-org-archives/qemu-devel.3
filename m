Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B46C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkgg-00054H-Ro; Fri, 02 Aug 2024 01:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkge-00051u-Lr
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:18:44 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkgc-0006uF-IT
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:18:44 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093efbade6so5296782a34.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722575921; x=1723180721;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sr7VktO13voQIejF/AoYPv/rc7tepWcOTCytAnmX3Yk=;
 b=kogL/WcLnJygw00R4ASvrdgYNa2mFh4me7OAxZ57YZ0qX2d6idDqrtLjpVm2zlWRvM
 IMAhcWiBGiSyJKaF2scZABrgKRRN2s7k1DdMmyYNguffxLC0HMUXwqh6ZbOM8IrUZX4o
 RJm4NYN9JABUQ3sN/h74gbgqjkprBJV37vwlPyUlwAEnTcCG0g+R7CwdkSSkmfz06E9+
 aKkmelEFbBivVvkX2XCIh/zqQ51xSyihhfmu0M1w0jSqUkIi6rPMKbHsHmdczLEyx7bF
 2E00QGaHSgnrCLBFjPGF0zarJ9v/s6uXBQFuY7gJWKYo8CWnAKBji3zzC+/4MHFZReeR
 JFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722575921; x=1723180721;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sr7VktO13voQIejF/AoYPv/rc7tepWcOTCytAnmX3Yk=;
 b=R/BX+nIIM1Ls4UD6PeDkJNlqYK5QQuzTi1ndG8wFklckhb5p7yR7E/YrkG53XBcUgv
 fV4sljsfHiVeLzbQDCE2ZLQRJ3hB5e7qiVmLKn32HqxGPnO8UTyKfBxx8hFamF06ffzC
 K3e0TEksRbsoogP0Wj82hvbCujQjBt7+c9h0DthMiBi2xxiPmZUChcyTE3ZAvUWXqeYK
 KN2DSs7MNtOeddcXDYe9Dmndp4xnEqh9l/JRD/ZfP7je64dKIbI1heZZ67uLVsUbH0wr
 MUQ8WT+SikRW/rFZh9jwPKIZ5cyIkU5YchoFCY0poCpPTMQ0j9l2N+crR6Kde5HkV4cD
 HN7w==
X-Gm-Message-State: AOJu0YzTNQdk7WyaJLoFKxXJmf9Wb+NZQ37pYuU1s1w/FsssIUUo4526
 +WV4s0Q7Q+bkVw6IphqZ/OAW0WFHoAI0KuKdtdSg1bMl4Hq0QLgqz/N2WV/C1rg=
X-Google-Smtp-Source: AGHT+IGSj+Pq+UuzzwjetcoqR33FydwDTD3F3wKUf1G7hjtJqsz6qKzP+bIfCOUBfJIXHekan+Sh4w==
X-Received: by 2002:a05:6830:6110:b0:709:2842:b5b6 with SMTP id
 46e09a7af769-709b31fcb90mr3307685a34.7.1722575920715; 
 Thu, 01 Aug 2024 22:18:40 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7106ed2de19sm637190b3a.216.2024.08.01.22.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:18:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-9.2 v11 00/11] hw/pci: SR-IOV related fixes and
 improvements
Date: Fri, 02 Aug 2024 14:17:50 +0900
Message-Id: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP5rrGYC/2XRzU7DMAwH8FeZcqaT7Xxz4j0QhyR1WA+sUwvVp
 mnvTlrRrijHxPn9Y8t3MfLQ8SheD3cx8NSNXX8uB8SXg0incP7kpmvLhSAgBUi+Gfhn5CaHwEQ
 R0UslytvLwLm7LkHvIvdD448kPkrh1I3f/XBbPphwKS9RBPIvasIGGh3ZJZ3YSOne2nA7d9dj6
 r+WiIl2DGFlVBipGChoIOOpYnLPaGWyMAdoo3E+sc0VU3umVqZm5kMLXgawWVVM75lbmS6MVU6
 Y0EcdfMXMjtE2m5lnY0WBXISU69nsnm1N2pn5hCqm6DVxxdyebU26mTkyBsghG6iYfzKJemW+M
 GNDMD5k1WpZMYSnM2S3fUOBNgWIjlvZ+v8reDwev0GOqsOWAgAA
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
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32a.google.com
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
      hw/pci: Rename has_power to enabled
      hw/ppc/spapr_pci: Do not create DT for disabled PCI device
      hw/ppc/spapr_pci: Do not reject VFs created after a PF
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Ensure VF function number does not overflow
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
 hw/pci/pcie_sriov.c         | 149 ++++++++++++++++++++++++--------------------
 hw/ppc/spapr_pci.c          |   8 ++-
 hw/vfio/pci.c               |   5 +-
 system/qdev-monitor.c       |  12 ++--
 hw/pci/trace-events         |   2 +-
 15 files changed, 171 insertions(+), 112 deletions(-)
---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


