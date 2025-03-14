Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66651C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyKH-0004OP-Rg; Fri, 14 Mar 2025 02:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKB-0004JX-Sv
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyK8-0005Ln-Oa
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224100e9a5cso36662805ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932904; x=1742537704;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bx6aQ1032OWCnTDj23FUcPkbt//lprYk9LJC+jooQ84=;
 b=e3f1kZAQLOOnPJO1QKg+EO5W8KRG7JhXw/45PFse7hb0RTCp5IPflH+tZ+VCKlhXem
 x08o3LIj8BvaXnj0HK8ngQJ3q1uelv2R3dpaVWk3Ejbc4LryJzp7JUHi7MKzyMjE80ZV
 enEo8r3qoVwCZgZLUddo1Z1elcLfqMe3KjCJ4KfxbJl0gxfcsAdPECz6lKPlBiMMgcwD
 txQ2KpPV7BXRd5vlxF/UjbUa+JK3X5EGgzT4bxXoiOIDXcLmJK4F7O2nhG3qfPwGkfpS
 h23ixkYp/UrGzDsuj6YPj1DOxw+DxGGdruyKoq6TA+u8vPOOVTPI+of7yMJ4nN0PgYWA
 HgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932904; x=1742537704;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bx6aQ1032OWCnTDj23FUcPkbt//lprYk9LJC+jooQ84=;
 b=Z7+ApIfpIkc3bM+cpg3z6/0mlThx+tVK/expCaV4FdlOP83QGdcDDZivDPxusuRj/y
 TpmBpdrTgETfK+ynN4/mpS8vFJnWs3xiRhSFSNzPpR9UdnSUEJX8e/cAyDKrzqdm3Gyh
 hOtrkfiOcdWMcDvlGHIsWFuY9SIvDd6zd8BbagkTIIAlKdXSz4Oj7wPHusB9QI2A+dex
 t835VqL/5jktO6cjrIiuBufrd77KCU/SZDMwoYoiUZDwMBNGN8bLmN36y1/aV6mmsnSr
 WfnBc79VdTUgV5nzMC320nOADuDmfie+VoEXgHKc87jC07VfFtDW+9/2Y3zOKgWyJn3h
 jcUA==
X-Gm-Message-State: AOJu0YwVHTNuLpgzDMwX3RqifqObF3AMQTf5CQOD5UKW0BQaHgsW8jLv
 oFnw3zgnaIx4jV66h5SDAcijVoQbJunXL5Ft/+euQ67gVghRzscofU8DlQdMjIw=
X-Gm-Gg: ASbGncv9BhTUkJWHilHri78Jb6V78VhiXWM+arPV1N1rIaoMLaIhzXDBpfRDtZFUmw4
 q3EcBv6lpiwsJXyOzHydPTmucKUFqwSocD0g6GjHvT3HceyeInfjwJGxObieVliq8haJPVPqTQM
 HV1CniCRYZgPes8gtHVFDjHPjmwSDpJn4UkTt4AonuScodKis0+eOetqmiDkjCZU9Sa/qB7BtAS
 gsjyJ2fnh3P2OHVJg339Dnx/OmqpSUWPQoEoIjj2+g3XQRBqo/7wTW16PtYIMp95vfRE6tKzOwS
 pHPabIm6b2zS5zx60P7Rh85mVJFA1go8D+cg/4kRdmLrPokE
X-Google-Smtp-Source: AGHT+IEbLT0rfqg6YCBIAQLSDo4DPYRppAs/AtYLALce1xxeIB3ItE1JJwsnztDrzfUiO5gYNqbv0g==
X-Received: by 2002:a05:6a00:1916:b0:736:b9f5:47c6 with SMTP id
 d2e1a72fcca58-7372240eca2mr1491083b3a.16.1741932904324; 
 Thu, 13 Mar 2025 23:15:04 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-737115294b3sm2342755b3a.5.2025.03.13.23.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-10.1 v9 0/9] virtio-net: add support for SR-IOV emulation
Date: Fri, 14 Mar 2025 15:14:49 +0900
Message-Id: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnJ02cC/2XQzWrDMAwH8FcpPi9Flj9k77T3GDvEH1p9WFOSE
 VpK3n1uwEu3XAxC/v2FdBdTHkuexOvhLsY8l6kM51r4l4OIp/78mbuSai0QUMn6dNNYhrnzGpA
 DWgzZifr3MmYu1zXnXfAwdhKOUnzUzqlM38N4WwfMcu3/y5plB53CoAwBU0j2LfW3c7ke4/C1R
 sz4xCQ0hpUFb3x2vU3c846pxjQoMI2pyvqQAhkiUIQ7pjem0TWmHyy6PlqU6N2emY2R/J1mHru
 xMcqDV8xxx+zG3HYSWxlEx6x91Ej7k9ATk6oxqswZabIi0olpx1xjBiToxlxlxkqtI6dIyf9hy
 7L8AGE7rq0mAgAA
X-Change-ID: 20231202-sriov-9402fb262be8
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
Changes in v9:
- Rebased.
- Link to v8: https://lore.kernel.org/r/20250104-sriov-v8-0-56144cfdc7d9@daynix.com

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
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


