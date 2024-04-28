Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68206C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10U2-0007V4-TC; Sun, 28 Apr 2024 05:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10U0-0007UG-Q8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:04 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10Tx-0003ik-O9
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:04 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a484f772e2so2353675a91.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295159; x=1714899959;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IszGnMpP0dRtsGp91SXeif5PGpGhSioX7K+JbC0wiQs=;
 b=YO+Z+Xpd6mJBuAy6y9627cDSN0fTkFJNdO5/jtXxB07BG2+xuCMgSLgVStewLFlM/n
 2ewuoZdmhwUPe7q9kTZbvDQ7ee6GEJwEuojtd6vj9fkG/k50yAcRl0iUrF0kH31SNUSz
 Gx9rZhtUHpwMkmKHtIPyfJEwPaaya4a/eYKSR13t3pSPZitCgnZgTDYifo5FwaYi4JlD
 G+ksAOFvnYImoQUZpeVnWwqG4wBYMQe9EX2Mvwd/PWiRnlIkXTOq88UQGcQXyKsu8fji
 vypGu/9Q/UPwZ1c0c4VlOAF8C+QZ0DytJYBGcnvl8+anhdS3rKpe36Vz9+YJQ2Rd2Gbu
 WOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295159; x=1714899959;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IszGnMpP0dRtsGp91SXeif5PGpGhSioX7K+JbC0wiQs=;
 b=KauzzNpaCVbLEFu7aPvENAPia/VGtl5j2LiuWklR+GNCUOpp/1ezNsep1wOiMoMYv9
 PYZiR/T1QRY05VGAdRki2ZcD9MzELS04crt73+F7Xlg1hc6Sj9K3H8u0W+BqBSrHGcVr
 eqjXD5st5ScLvUjq0GgXwjI+1jWrPwxC2tumWX19xAQHGLogsuWeKuMr14zEbfp+0SBV
 dMFCcqrSbgqa2spxFbWQI/f+ERlWetxMAKVOZkuy1lW4d1MqLozczq7Zkz7nT5BlHAlm
 sE8wSFSeS8qRYNDCRFufcAGVwXv3iG/ONVX/or0a8l5sn75+BllatKKJ/pecg2QH0EXI
 kDFA==
X-Gm-Message-State: AOJu0YxEDINfz3nelkkJnpSLFuww1wQvYa8R65tRURIs7/8VNLrns4FG
 ui1Hmqi9SKEpboWiJwTtKSVUDwGiY7HAQFTE8i1r+Bn1cgFtIh7ylqXSxDvOo4E=
X-Google-Smtp-Source: AGHT+IHCi2l6x+XfXRYGX8JfmDX3E70KlaCUkuK0UD3WtSko1av5wRDAP9QGQgptSoM/hnSSAE9zXQ==
X-Received: by 2002:a17:90a:fd85:b0:2a7:cd5:faa6 with SMTP id
 cx5-20020a17090afd8500b002a70cd5faa6mr6947045pjb.44.1714295159217; 
 Sun, 28 Apr 2024 02:05:59 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 qj3-20020a17090b28c300b002b0dea23239sm2150994pjb.49.2024.04.28.02.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:05:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v4 0/7] virtio-net: add support for SR-IOV emulation
Date: Sun, 28 Apr 2024 18:05:40 +0900
Message-Id: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQRLmYC/2XMTQrDIBAF4KsE17XoGGPSVaHQA3RbutCojYvGo
 kUSQu5eEQL92Qy8mfnegqIJzkR0qBYUTHLR+TGHelehfpDj3WCnc0ZAgNE8cAzOJ9zVBKyCBpR
 pUf59BmPdVHqu6HI+oVteDi6+fJhLd6Ll9FOTKCaYgWJcECuUbo5azqOb9r1/lIoEH4ySjUFmq
 uOdaWWjrbR/jG2sJozwjbHMpNJKcCEIE/DF1nV9A8UhDjYOAQAA
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
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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

Based-on: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
("[PATCH for 9.1 v9 00/11] hw/pci: SR-IOV related fixes and improvements")

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
Akihiko Odaki (7):
      hw/pci: Do not add ROM BAR for SR-IOV VF
      hw/pci: Fix SR-IOV VF number calculation
      pcie_sriov: Ensure PF and VF are mutually exclusive
      pcie_sriov: Check PCI Express for SR-IOV PF
      pcie_sriov: Allow user to create SR-IOV device
      virtio-pci: Implement SR-IOV PF
      virtio-net: Implement SR-IOV VF

 include/hw/pci/pci_device.h |   6 +-
 include/hw/pci/pcie_sriov.h |  19 +++
 hw/pci/pci.c                |  76 +++++++----
 hw/pci/pcie_sriov.c         | 298 +++++++++++++++++++++++++++++++++++---------
 hw/virtio/virtio-net-pci.c  |   1 +
 hw/virtio/virtio-pci.c      |   7 ++
 6 files changed, 323 insertions(+), 84 deletions(-)
---
base-commit: 2ac5458086ab61282f30c2f8bdf2ae9a0a06a75d
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


