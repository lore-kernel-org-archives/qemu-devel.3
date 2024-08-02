Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1553AC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7N-0000Y2-Ac; Fri, 02 Aug 2024 02:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7L-0000Oq-10
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7I-0000uY-Q7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:22 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so21454175ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581419; x=1723186219;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A0oKSi+MY74Hoi+LwDP5z4bcj24KY/83IQasqzOfYwA=;
 b=uGPlHfCwuS/KYsOBVu82ikoEyNpzkC5q7e6zho5Nt1FkiFusWisV91LXLPoAU9D5L5
 +7Je05uoGs2jxSDxzu5rKkT/3DOrDHhogaFLgz2ZjeES4YzYA9+/2sjRv+CF57AbXBPS
 NQT72BaxoAGdFORt4ZN1ZIxR+i4lZBdwMEMgGTTY/1aXCgm3t9tNS4FdfXA3i24vIgcf
 BSV59fef8QmMXWfYgSrMno3/mMHhgF04hXypStngiOl4SXY7Z9Gax0snODMXHo8SqcKS
 K80LwA9M4D4frTkuXzaL4JxQp1+aXE45/rrMY1wqXu//4gKidgtMUltLRE7P6MvZYuuO
 UdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581419; x=1723186219;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A0oKSi+MY74Hoi+LwDP5z4bcj24KY/83IQasqzOfYwA=;
 b=cFC5CagkkRf9aIC/nUH91dUdiNr4WFCOPS4/RRiT+5RRNceWXdSMekdQc5T+Pw5rxX
 TTEkQ6m+Cb1/+VHhhGnptUBbBW9cN02DAfViNPJmtO1nfXpJYnluSl0Ng0k2ZdvuvQNF
 TYIkLZWgp4v/Z2d4ozuNlLDfaROMjTaKEtRGhNnx2gYOUqqvDJDCGhUJVeX0ucoDfFp3
 WHV+o5zrm52tCGP2/4Q1TErMKMISRLkbEblob0B0zPLDj6yCg4HBlNEBiI/2jo8gp6Dh
 3HdbPjnsxfsDBpsdq8PGnMknDqphZbwszSFmyIv69z54TaZgZuZAU6i1+Vbh7xbszZkh
 CL3g==
X-Gm-Message-State: AOJu0Yyx1dSUJq6zTt8z6qdluMTmyEVz2sYFweTOi2/TqIeiwVSGBOP7
 zuW6kUNRSL02rn+IpPOmuRGg/D+TBrPBaj+kdjv8gFCGYwJrgorPBk7eFe5Zw4I=
X-Google-Smtp-Source: AGHT+IHLIsWn62/Fbzo2ygNnIjPvRXZrT/JlXth6tqGRwuQwlOOCTZqgP5I+Df5L18ir+KVgNIn+Cw==
X-Received: by 2002:a17:903:1209:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-1ff57f062b9mr48680275ad.28.1722581418967; 
 Thu, 01 Aug 2024 23:50:18 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff59059f62sm9807115ad.161.2024.08.01.23.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-9.2 v6 0/9] virtio-net: add support for SR-IOV
 emulation
Date: Fri, 02 Aug 2024 15:49:44 +0900
Message-Id: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIiBrGYC/2XPS2oDMQwG4KsEr+Ngy++ueo+QhZ+NFxkXu5iEM
 HevMzBN0tkIhPT9QnfUYs2xoY/dHdXYc8tlGo3c75A/2+kr4hxGj4AAo6PgVnPp2HACyYEEFzU
 au981pnxdco4olYrNAdBpDM65/ZR6W/I7Xcb/ojrFBDNwTCiSlAvyM9jblK8HXy5LRIcXRsnKY
 DBnhInaypBs2jC2Mk4YEStjg1kXnBJKEaZgw/iTcdAr4w/mtfUSKBi9ZeLJFP27Jh6/JSGYIYa
 l5N/YPM+/6IE9OIABAAA=
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
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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
 docs/system/sriov.rst          |  37 +++++
 include/hw/pci/pci_device.h    |   6 +-
 include/hw/pci/pcie_sriov.h    |  21 +++
 include/hw/virtio/virtio-pci.h |   1 +
 hw/pci/pci.c                   |  76 ++++++----
 hw/pci/pcie_sriov.c            | 308 +++++++++++++++++++++++++++++++++--------
 hw/virtio/virtio-net-pci.c     |   1 +
 hw/virtio/virtio-pci.c         |  24 +++-
 10 files changed, 384 insertions(+), 92 deletions(-)
---
base-commit: 33809cc29cb8ba9de56c135ab78e4b9518f3fcb4
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


