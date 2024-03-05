Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2450FC54E55
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQdf-0003sv-CM; Tue, 05 Mar 2024 03:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdY-0003p9-4w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:01 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdW-0003dm-3a
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:58:59 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so3770037b6e.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709629136; x=1710233936;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ltmKqY+QtMpbNr0sEUs4FH5jNTa+S9Tk/LCR0SpaBRo=;
 b=df2Ejy66dS43u0bcHuXfQ08s/bOOPkyy4hTYQ5K8V+eM0DZOjnHBtsWJZX0uCFsRi7
 AyactJ5/YZeBw1rVhYfgs3s646zLSAWq4tMGrIQmxtmZrx8kzXHp6jVVAim2D/cfSnlB
 2w+PeMBFwrd4fKsJqUkIgi80eBXu1ihrg+RxplwkkDAr3YTSFlcCA6o1z5J7Iz6Cqo0n
 oNxhgfHEKqspRjWLVQzzzgw7wOLnMk8CzAjuUPjNv1t9gxP2lNGbAlJLZYkdC06tt5mf
 MPG9DFP3GI0h5X9pprwT8H5Gf2qvN727EQNcC64rn+Onn9G7RYzFYEQcES9Ssnib/NjR
 d1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629136; x=1710233936;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ltmKqY+QtMpbNr0sEUs4FH5jNTa+S9Tk/LCR0SpaBRo=;
 b=dKTp7vLutgKt7ibMpg+a5C4lTmfjwO2MjO2mg1nArBoYjrYREO/VohCmxBeDaDSQ1X
 N3a33t6I8ZWbeHkz5v2sCXwxdN7irYo2r0wK040IIlLWUsX6F5ZqLgprWTbmc4hCrK4c
 rE+fmv9HXNnZA5SnN1h/GZL1+P3LVmai8IT27FleaskhYGXQVtw0N4Y3W92TrsUzxGlY
 ku4/DQmVTg+SOOTT948FMYdeuhsfWgb7P/JBVbMxE9oJJA1JAzLIfUtU6RnM8C1OsvTC
 H7LzLR+zPXZim10Mdu2ajEQ+M3H9R0bHSgInrSF0htxBRolwphSvr8118/d8kLp80GRm
 KMBA==
X-Gm-Message-State: AOJu0Ywp/O+yPbg4jlN1ZLjDL09FidrwmPCxS2byQjDiES3BHvM0tdqc
 yqO+BNzxdxTep670fLzYuaGOspfQv/Ilo2R18ORRZf808hVVn2vaqWwOlEImKO4=
X-Google-Smtp-Source: AGHT+IGADbWzEP9bLqUcXMb7OPc5uz2fvGuL9+ttDS93Y7UHZQW3cpBM/CeFVRqf2iOkS9MVvKLlNg==
X-Received: by 2002:a05:6808:7cf:b0:3c1:6049:d676 with SMTP id
 f15-20020a05680807cf00b003c16049d676mr1047687oij.36.1709629135829; 
 Tue, 05 Mar 2024 00:58:55 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 p19-20020a63f453000000b005dc4fc80b21sm8764456pgk.70.2024.03.05.00.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:58:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v3 0/6] virtio-net: add support for SR-IOV emulation
Date: Tue, 05 Mar 2024 17:58:47 +0900
Message-Id: <20240305-sriov-v3-0-abdb75770372@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMfe5mUC/12MywrCMBBFf0VmbSSZ2JcrQfAD3IqLpEnsLGwkk
 dBS+u+GgKBuLtw7c84C0QayEQ6bBYJNFMmPucjtBvpBjXfLyOQOyFGKHCwG8ol1e45OY43atpB
 /n8E6mornCpfzCW55HCi+fJiLO4ly+tMkwTiTqGXVcNdoUx+Nmkeadr1/FEXCL0zwD4YZ013V2
 VbVxin3g63r+gbL22XI1wAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 20240228-reuse-v8-0-282660281e60@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
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

Based-on: <20240228-reuse-v8-0-282660281e60@daynix.com>
("[PATCH v8 00/15] hw/pci: SR-IOV related fixes and improvements")

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
Patch 2 and 3 adds validations.
Patch 4 adds user-created SR-IOV VF infrastructure.
Patch 5 makes virtio-pci work as SR-IOV PF for user-created VFs.
Patch 6 allows user to create SR-IOV VFs with virtio-net-pci.

[1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
[2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com

Changes in v2:
- Changed to keep VF instances.
- Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com

---
Akihiko Odaki (6):
      hw/pci: Do not add ROM BAR for SR-IOV VF
      pcie_sriov: Ensure PF and VF are mutually exclusive
      pcie_sriov: Check PCI Express for SR-IOV PF
      pcie_sriov: Allow user to create SR-IOV device
      virtio-pci: Implement SR-IOV PF
      virtio-net: Implement SR-IOV VF

 include/hw/pci/pci_device.h |   6 +-
 include/hw/pci/pcie_sriov.h |  19 +++
 hw/pci/pci.c                |  70 +++++++----
 hw/pci/pcie_sriov.c         | 299 +++++++++++++++++++++++++++++++++++---------
 hw/virtio/virtio-net-pci.c  |   1 +
 hw/virtio/virtio-pci.c      |   7 ++
 6 files changed, 319 insertions(+), 83 deletions(-)
---
base-commit: 2c4eb0476e461b8a4b2f745d25f987e831c7f640
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


