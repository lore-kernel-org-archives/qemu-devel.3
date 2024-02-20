Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A593C54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPB0-0004c0-3y; Tue, 20 Feb 2024 07:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPAy-0004bD-IN
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:24:44 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPAw-0005pZ-HP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:24:44 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso2111755ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431881; x=1709036681;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YmusaR7+cJU9b9tPOpGJy3lwU8aJAcLmo5XICUvw084=;
 b=oqtpTXSMpdJQeMwKtJB13gHmBD2v+7Ew0H0RNPpSt+aXIiwiQkPIVZi+TBevZnxwYK
 P/Pr5ZWHSfIcYEzEdb9ZhdPlj6c/erDDuS9qHW6XcuKzBgeSGIMAz9t+RRFZt7BOX74t
 VCU9yjcBa3rQQM3gF6l7mtrLaCjozVKzcQ0NDGCZzbHyNMYCQJP+hrMrlyu6rG9K6Z31
 35EFpQIBMC4kPWzPb8vPSpnCGgTNl/sWCp1t8qh3Qf1d0vv/N4abF9T/93V9lov1QxfG
 +nYovo/eQfCQbXuTSme665ISYiRyQGXS+OxR8w7zT2pd9mvce4f41Y/UkiofAUi/7w4x
 Tu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431881; x=1709036681;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmusaR7+cJU9b9tPOpGJy3lwU8aJAcLmo5XICUvw084=;
 b=ATSk/k+yZylEc22EDq1ebFmMYDiK8K1F1CX9T3KeDpRq3Gnar6qGhrugNSeINZ2qbB
 hB2R4+BSfCe3j5Z3hEZRS3AEHWU2SUw38ValkR2hSI4yRqOVvNTDaLyHPPy50u98p3ho
 KlLTgqTA1UqsNGELf0pUtBUzhteNSOVpM3FGVzK5mnG1fdBWTfmAM4pZhfg5FWVrKt28
 V1pziSyletpNiAS17MBqQvMWk75DJvBsaNJgsCXsdwZ5E6wfkLygF4Wc84bobXTyQWqa
 d/JhAJgoaBX1VU+1d/1Nz7y0G9nyZeWYLCj2vVeLeWGnuqBsq2qEpNpHiWGqf1CRWrGq
 GDDA==
X-Gm-Message-State: AOJu0YyB1XY9znkjUr8oQm58Cx+ITxmbmbqNO9grJB+gdH2n6XVWm4Xs
 DChTvaVukNY+w0Kp36ezbB/u8mAsbRtQAWHYSZDxAjbj9UD2rYrYPvFoXgcCYM8=
X-Google-Smtp-Source: AGHT+IECzklMsQL8uyJL9bJMScAJiR9T0j00wuvPctjle0Z7hDWdhLGukFZPi5zIldb9q7zDrFJ/zg==
X-Received: by 2002:a17:902:f683:b0:1db:cb34:d184 with SMTP id
 l3-20020a170902f68300b001dbcb34d184mr7556009plg.27.1708431880715; 
 Tue, 20 Feb 2024 04:24:40 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 h15-20020a170902f7cf00b001d8fe6cd0f0sm6086628plw.150.2024.02.20.04.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:24:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 00/15] hw/pci: SR-IOV related fixes and improvements
Date: Tue, 20 Feb 2024 21:24:35 +0900
Message-Id: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAOa1GUC/2XMwU7EIBDG8VfZcBYzM0ALnnwP4wHo4HKw3YA2u
 9n03aWrTWp6/Cbz+99F5ZK5ipfTXRSec83T2Eb3dBLx7McPlnloWxCQBiQnC39Xlsl7JgqITmn
 Rfi+FU74+Om/vbZ9z/ZrK7ZGdcb3+FgjUX2FGCdIEttFE7pSyr4O/jfn6HKdPsSZm2jGEjVFjp
 IMnb4A6Rwem9ow2phqzgH3orIvcpwPTe6Y3plfm/ABOeeiTPjCzZ3ZjpjHWKWJEF4x3/9iyLD9
 VXCG7dwEAAA==
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
      hw/pci: Use -1 as a default value for rombar
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
 hw/pci/pci.c                |  24 ++++---
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie_sriov.c         | 170 ++++++++++++++++++++++++--------------------
 hw/vfio/pci.c               |   3 +-
 system/qdev-monitor.c       |  12 ++--
 hw/pci/trace-events         |   2 +-
 14 files changed, 189 insertions(+), 145 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


