Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32629C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE7j-00081X-Oz; Mon, 15 Jul 2024 01:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE7h-0007zR-Ra
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:19:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE7f-0007Pt-TQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:19:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-75c3afd7a50so2337868a12.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020778; x=1721625578;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JsbtY5prZSpna0aeKvQ7z0WtqDoYDHYeieY3EKi1VU0=;
 b=XhZPi231WSMhQ74LXuXTIObza0f76IOKz38IyE+3mLKoIksgHoWUFHA0PK98tphKxT
 EAzmg/wUY9AYIp3d4m5hyX3rchZNRX4gt89c2Vo2D8WGRkptnmhDakdy70vpFuCw8Y/3
 IpUvibX24pUlBLv7VUbyNNwPJ3eGxTxqRwxFHKaAHJ74inqEm9D71qukGNTOe7eNIUCf
 9d51dLUShvD2LFHpjSNRnlTPCPaQCjLdeWDG8v3GhKLFkD3sZduHPfed+SUKc3myuu3t
 0AOkTuwvx0qKu9/4ehea/M6yHxTWpT6kS742PU2/w6yxNeOScYYk5YG5m8bXFZh3xGYM
 2chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020778; x=1721625578;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JsbtY5prZSpna0aeKvQ7z0WtqDoYDHYeieY3EKi1VU0=;
 b=LrwSDg0pG8sRiRfzMoBGEsHoP4NtP8OBz6z3CMfygUKos0ez6pyUB3AVqK4COY0UB8
 jPJBFAzmCBtWb3flZWr7oAfOSRLizpJtSTnK5+6gAsH+EGP0mf/WF5daxkxPLu69RW0H
 LPnI3gtFT/cI4p71w5Q1L7MDk/faZYVe4Wqckns/77BZQp2+UEJbunswiV/WbJWxWzQG
 fDCHF6NGTFjhzQ2h4BpYMorwDFJdkPR+vDuvrFH7fgS481nUwj5SN7H662bsYbAVysSR
 6UzffMBvNnVrvr62KtG+zwuo8xAbAF2Rjwij0LyarrP3iBsDwdUcd5NCO9jX8I1w4gxj
 cvyQ==
X-Gm-Message-State: AOJu0Ywkp6iTuKxP5nlMD2HBNkaidlDP/ij4COmc4fwxbMFuDFgTzEh8
 Ep7l8b8tOtm4+re9NeHjXg8uhghfetQbU3Bsu8OuLJvsn8PudsJ+iWbo72L2G4M=
X-Google-Smtp-Source: AGHT+IHiY6ToCEbmy5maePsAG720f5n44WBj7hOfzjmncPtCIAtwkeND/F3Ot6tT1ewcCz3FHtttFg==
X-Received: by 2002:a05:6a20:7284:b0:1c0:e77b:d37 with SMTP id
 adf61e73a8af0-1c2982038a4mr18617635637.9.1721020778074; 
 Sun, 14 Jul 2024 22:19:38 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc2751bsm31601615ad.143.2024.07.14.22.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:19:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/8] virtio-net: add support for SR-IOV emulation
Date: Mon, 15 Jul 2024 14:19:06 +0900
Message-Id: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqxlGYC/2XMTQ6DIBRG0a00jEsDDxDsqPtoOgCByqDaQEM0x
 r0XTUx/nJB85J07oeRicAmdDxOKLocU+q4McTygptXd3eFgy0ZAgNHy4BRDn3HNCXgDFRinULl
 9RufDsHaut7LbkF59HNdspsvvfyFTTDADw4QkXhpbXaweuzCcmv6BlkSGL0bJxqAwU4vaKV1Zr
 /2OsY1xwojYGCtMG2ukkJIwCTvGP4yD2hhfWKN0UwGFWv2yeZ7fUdHve0ABAAA=
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
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Based-on: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")

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
Akihiko Odaki (8):
      hw/pci: Do not add ROM BAR for SR-IOV VF
      hw/pci: Fix SR-IOV VF number calculation
      pcie_sriov: Ensure PF and VF are mutually exclusive
      pcie_sriov: Check PCI Express for SR-IOV PF
      pcie_sriov: Allow user to create SR-IOV device
      virtio-pci: Implement SR-IOV PF
      virtio-net: Implement SR-IOV VF
      docs: Document composable SR-IOV device

 MAINTAINERS                    |   1 +
 docs/system/index.rst          |   1 +
 docs/system/sriov.rst          |  36 +++++
 include/hw/pci/pci_device.h    |   6 +-
 include/hw/pci/pcie_sriov.h    |  18 +++
 include/hw/virtio/virtio-pci.h |   1 +
 hw/pci/pci.c                   |  76 +++++++----
 hw/pci/pcie_sriov.c            | 298 +++++++++++++++++++++++++++++++++--------
 hw/virtio/virtio-net-pci.c     |   1 +
 hw/virtio/virtio-pci.c         |  20 ++-
 10 files changed, 369 insertions(+), 89 deletions(-)
---
base-commit: e7b8390b9167be9272c2c959919d9b397842da7f
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


