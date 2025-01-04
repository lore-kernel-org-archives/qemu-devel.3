Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AB2E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz63-0003Vt-LY; Sat, 04 Jan 2025 03:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz62-0003V3-Fv
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz5z-0006e0-Kw
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:21 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso183852865ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977678; x=1736582478;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ywgK8/ryWdcjjwMFkAA6qFSlF88HS/h11YsdgAR6+38=;
 b=GtPZoj+JSEazAULGg0IosJSfP4WnB+7V39Nu+Tjxg70RJwgGdibyOK7sle+gtS2Zp0
 lZWc6QLC3I9/auitjVEy/Y59X26pPTbY08atv8SATTS5wCfWV2tqVeSlAX7oLIb0qLb5
 gLO7peihrKiPwhZcgcFF24TUawoaU+okD1aLQGYG+FvCGmm5uFtqtI0X5nOj7c1w4QSt
 yDsiWXCaRPCNV4UYDNcPFgbxEd3bIqBL+O2sHoRvLbY6vgmoUxoQd2VZELaAUmf5C1fa
 Kj9Er7EvOWK436di7xxSSxoRrK7A75dNEiEvMW77hjTJBYUQ8uf6aT2mG1AYo19xx3nK
 1rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977678; x=1736582478;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ywgK8/ryWdcjjwMFkAA6qFSlF88HS/h11YsdgAR6+38=;
 b=bfFsp38REwGQKjCoD39BXJXFWt/UbOp0+W/fz5qD6G0cx6VFFXHm1c3ZKJmxdadayw
 7jUAyOeTjIB6MB+8/iK9KhLkggWFw1DtnQbkZftNpVws/RNJ62PM13tRkPzSswbx0g3O
 dWavG5RGn/AutBuc+m2DPydL2XL4fqHaLWGQ51CWo/7gu00RQJ+UIwRZdd+cSkFzNp8/
 o4OEGfODcwgq1w1G0qPTp+rod+SHJkbaftfOkAoSiq8+5igaT6zwgn/mVjsm8RXWSypz
 7oIfkq+XExJCcwzBiyhcq0Jqn3qYzWinrsE/BK2GQYT3rO0Kyaa+e6y+3ZZCRlw5aeS3
 Rlig==
X-Gm-Message-State: AOJu0YwdMzfnjAeM/slE0XZBP/4Hl1F1vH4rsN2wgFY2RFur02eHnA5L
 r4UvBfd0Z0J5Y666Mmq9YH2MddF18nHB5b4HAVueUsjWM2VDbZ95eSAuwma/gzA=
X-Gm-Gg: ASbGncsRBGVBy82fmlIcURCUL6OffZNUGlPgQvW4J5xDZ0ET0wrEgxf+XpyP/HvngTg
 1vBIA7qjWpo4fYJSWwsN2AOrFUowQ0zftUG6d+9qXBTXOujuEyxSY3TX/jb4qsKhueRZCUYUl0G
 KR6GbkwEoBbFySHNcxevyaY38ICiNtWngIN73rfQfcpIFSs1K/2m4rOj8Y+UofNiVYAnBF9PoBo
 JO1rHRWkyKUFtGrdFv515dwMS22jQd02ELjzeFY4Rhe8yy9rwJQIR6hib9E
X-Google-Smtp-Source: AGHT+IHKEWq/Z/PmX86nOjmWXlAtw0LcOy6ihHnl+QKkIbG5KWyfd9R4blg6coIL9ZiAK7nWrSGOaA==
X-Received: by 2002:a17:903:2cc:b0:216:554a:2127 with SMTP id
 d9443c01a7336-219e6f2f127mr726823715ad.41.1735977678060; 
 Sat, 04 Jan 2025 00:01:18 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc96eb12sm257838725ad.87.2025.01.04.00.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 0/9] virtio-net: add support for SR-IOV emulation
Date: Sat, 04 Jan 2025 17:00:53 +0900
Message-Id: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXqeGcC/2XQTW7DIBAF4KtErOsKZoCBrnqPqgv+pmFRu7IrK
 1HkuxdHcp3WG6SH+B6auYmpjLVM4uV0E2OZ61SHvgX3dBLpHPqP0tXcsgAJqNrRTWMd5s5rCRz
 BQixOtLdfY+F6ufe8vbd8rtP3MF7vtbNab/83zKqTHUJEQ5IpZvuaw7Wvl+c0fIq1YoYHpuTGo
 LHojS8u2MyBDww3piVKszFsLMQcyRBJJDgwvTMNbmN6ZcmFZEGBd0dmdkbq9zezzsbGoJcemdO
 B2Z25fSW2MZkcs/ZJAx1XQg9M4caoMWeUKUikM9MftizLD+QlmxvlAQAA
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

Based-on: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
("[PATCH v18 00/14] hw/pci: SR-IOV related fixes and improvements")

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
Changes in v8:
- Rebased.
- Link to v7: https://lore.kernel.org/r/20240813-sriov-v7-0-8515e3774df7@daynix.com

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
 hw/pci/pcie_sriov.c            | 294 +++++++++++++++++++++++++++++++++--------
 hw/virtio/virtio-net-pci.c     |   1 +
 hw/virtio/virtio-pci.c         |  24 +++-
 10 files changed, 378 insertions(+), 84 deletions(-)
---
base-commit: e5c58fa88d683cde10d9e9089c16a397803667e2
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


