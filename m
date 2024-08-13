Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A5C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdl9j-0005it-CK; Tue, 13 Aug 2024 02:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9h-0005fi-2J
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9c-0006O2-4n
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so42337835ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531030; x=1724135830;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hDrK+gpz+8nrNvDJA4musNmPUHNQf2VkCuouqLWyFRQ=;
 b=YZaMQ2gzBRssdvFZWKDXMn1eVvl6935sn+Wr1U2kvmH8IbW3WAE2PYAp41mj6Cn3af
 QdhPuTr1Jfc4caFKOm8U2BkMpCUZTyatPDfgUDA81u/V+W0mLEmUc3BbqvhcanWPkZGG
 2fjL5SEGXsxYARmIfjWUyNM+eDxFp2iLwXHPDtHXzxatlkAYucL9OHKeS0L66CtoxtYB
 9lj8COA3GrdjeAIqfZAnIqfQ0jIoT1483WSJLOtLkYjKD4vpmc2KZx7qiLHVJ1/LrlFP
 MmVD6FROb8WCBc6cTbBWYy4OwmO278UY18bs2r4/U6EVSNHO2A7uB+4c80pNzTpXCpca
 3pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531030; x=1724135830;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDrK+gpz+8nrNvDJA4musNmPUHNQf2VkCuouqLWyFRQ=;
 b=nBTQ58nDNb1q3hd+5Jq4SFLZe9ERjGSrLkdCPcwvRU4dxzFxbJUM/H5V1eTrm1WD5f
 HtiUfe90rFSgEIUqssDdu/OMQ0yOW+aV3h7QLPmYb+po1FEFtal2lenKcDvgAMDssebt
 7gZEJs9rl707L5kZtfc4txmRQMnUu3PXL1eTjGJZTqrhSPdt2GKkHUw54WEqAuw0ky5W
 BDck4XGzIglRKWJPUqtfysjgJrADfg8ERQ/L6z+0u9nEfKrXdDj43MW/fBC34pNtLKFw
 dduYfODmEBW1pAsBUikPAOq6JIajJJWHWX+xQvWI87VriFFTu08dl0bTP6qodlgjmT3u
 kI1g==
X-Gm-Message-State: AOJu0YzvBkThNldGmLIfofJAd+12nYEQjgRgx2KzF4CNl7PW5mc8fJaA
 R90ASdmn7d0bQVF3cfr2vPGMPyL2k2oUcOytherx535sZs7K2LCvUJZK+RQLhd4=
X-Google-Smtp-Source: AGHT+IF57/o3/t6BK1eIzKi0RksZ9BZ7c5XO/vsu6GaZT1LS0vTaN5CWuX/sd13vlT0MR7csxjHKMw==
X-Received: by 2002:a17:902:ea11:b0:1fd:9648:2d66 with SMTP id
 d9443c01a7336-201cbc2b694mr30420895ad.17.1723531030108; 
 Mon, 12 Aug 2024 23:37:10 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201cd1ce9d4sm6567435ad.280.2024.08.12.23.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-9.2 v7 0/9] virtio-net: add support for SR-IOV
 emulation
Date: Tue, 13 Aug 2024 15:36:59 +0900
Message-Id: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAv/umYC/2XQS2rEMAwG4KsMXteDLb+76j1KF36p40WTYhczw
 5C71xNI0zYbgZC/X1h30nItuZHn053U3Esr8zQa83Qi8eKn90xLGj0BBoKPQlstc6dOMsAAGkK
 2ZLz9rBnLdc15JThX6s5A3sbgUtrXXG9rfufr+F9U55RRAUEow9CEpF+Sv03leo7zxxrR4Rfjb
 GMwWHDKZet1Qo8HJjYmmWBqY2IwH1IwyhgmDByY3JkEuzH5YNH6qIGDs0emdmb4zzb1+BsqJRx
 zAjEemN6Z3U+iB2PRIkoXJZi/J1mW5RvWHI3stwEAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

Based-on: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
("[PATCH for-9.2 v11 00/11] hw/pci: SR-IOV related fixes and improvements")

Introduction
------------

This series is based on the RFC series submitted by Yui Washizu[1].
See also [2] for the context.

This series enables SR-IOV emulation for virtio-net. It is useful
to test SR-IOV support on the guest, or to expose several vDPA devices
in a VM. vDPA devices can also provide L2 switching feature for
offloading though it is out of scope to allow the guest to configure
such a feature.

The PF side code resides in virtio-pci. The VF side code resides in
the PCI common infrastructure, but it is restricted to work only for
virtio-net-pci because of lack of validation.

User Interface
--------------

A user can configure a SR-IOV capable virtio-net device by adding
virtio-net-pci functions to a bus. Below is a command line example:
  -netdev user,id=n -netdev user,id=o
  -netdev user,id=p -netdev user,id=q
  -device pcie-root-port,id=b
  -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
  -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
  -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
  -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f

The VFs specify the paired PF with "sriov-pf" property. The PF must be
added after all VFs. It is user's responsibility to ensure that VFs have
function numbers larger than one of the PF, and the function numbers
have a consistent stride.

Keeping VF instances
--------------------

A problem with SR-IOV emulation is that it needs to hotplug the VFs as
the guest requests. Previously, this behavior was implemented by
realizing and unrealizing VFs at runtime. However, this strategy does
not work well for the proposed virtio-net emulation; in this proposal,
device options passed in the command line must be maintained as VFs
are hotplugged, but they are consumed when the machine starts and not
available after that, which makes realizing VFs at runtime impossible.

As an strategy alternative to runtime realization/unrealization, this
series proposes to reuse the code to power down PCI Express devices.
When a PCI Express device is powered down, it will be hidden from the
guest but will be kept realized. This effectively implements the
behavior we need for the SR-IOV emulation.

Summary
-------

Patch 1 disables ROM BAR, which virtio-net-pci enables by default, for
VFs.
Patch 2 makes zero stride valid for 1 VF configuration.
Patch 3 and 4 adds validations.
Patch 5 adds user-created SR-IOV VF infrastructure.
Patch 6 makes virtio-pci work as SR-IOV PF for user-created VFs.
Patch 7 allows user to create SR-IOV VFs with virtio-net-pci.

[1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
[2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v7:
- Removed #include <error-report.h>, which is no longer needed.
- Rebased.
- Link to v6: https://lore.kernel.org/r/20240802-sriov-v6-0-0c8ff49c4276@daynix.com

Changes in v6:
- Added ARI extended capability.
- Rebased.
- Link to v5: https://lore.kernel.org/r/20240715-sriov-v5-0-3f5539093ffc@daynix.com

Changes in v5:
- Dropped the RFC tag.
- Fixed device unrealization.
- Rebased.
- Link to v4: https://lore.kernel.org/r/20240428-sriov-v4-0-ac8ac6212982@daynix.com

Changes in v4:
- Added patch "hw/pci: Fix SR-IOV VF number calculation" to fix division
  by zero reported by Yui Washizu.
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240305-sriov-v3-0-abdb75770372@daynix.com

Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com

Changes in v2:
- Changed to keep VF instances.
- Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com

---
Akihiko Odaki (9):
      hw/pci: Do not add ROM BAR for SR-IOV VF
      hw/pci: Fix SR-IOV VF number calculation
      pcie_sriov: Ensure PF and VF are mutually exclusive
      pcie_sriov: Check PCI Express for SR-IOV PF
      pcie_sriov: Allow user to create SR-IOV device
      virtio-pci: Implement SR-IOV PF
      virtio-net: Implement SR-IOV VF
      docs: Document composable SR-IOV device
      pcie_sriov: Make a PCI device with user-created VF ARI-capable

 MAINTAINERS                    |   1 +
 docs/system/index.rst          |   1 +
 docs/system/sriov.rst          |  37 ++++++
 include/hw/pci/pci_device.h    |   6 +-
 include/hw/pci/pcie_sriov.h    |  21 +++
 include/hw/virtio/virtio-pci.h |   1 +
 hw/pci/pci.c                   |  76 +++++++----
 hw/pci/pcie_sriov.c            | 295 +++++++++++++++++++++++++++++++++--------
 hw/virtio/virtio-net-pci.c     |   1 +
 hw/virtio/virtio-pci.c         |  24 +++-
 10 files changed, 378 insertions(+), 85 deletions(-)
---
base-commit: f5cebc77fe020e6ca0c33d8e06cd36edf3ff1d4c
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


