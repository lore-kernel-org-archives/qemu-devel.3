Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97AEE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPsy-0001Xo-BJ; Wed, 08 Jan 2025 01:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tVPss-0001XM-KP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tVPsm-0007eQ-O7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736318972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNKXcnoASwC8la+XkfSIyltc5NQD4pYx8fBbBDbyuPk=;
 b=RC5VMdXRYt4MNmKJ8jIPmbZk1c5RJHfWReFpw6dkhL/tNtanfPd+pJcNMk8fDyThuOLGXp
 3k1Jg9LpPRsorSrlqM0Ned743tksfK6XX5C4N7NXcDfo4uNOtAPEg+HUWXqAIpMMDEJPsT
 OIUBBOJ0CSV0NpQWYjHZJE0kFRinzjc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-iFbkXAtaNtu42NVD6A2Yrg-1; Wed, 08 Jan 2025 01:49:29 -0500
X-MC-Unique: iFbkXAtaNtu42NVD6A2Yrg-1
X-Mimecast-MFC-AGG-ID: iFbkXAtaNtu42NVD6A2Yrg
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d3ded861f5so14790615a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 22:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736318969; x=1736923769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNKXcnoASwC8la+XkfSIyltc5NQD4pYx8fBbBDbyuPk=;
 b=Ydnypz0Afbba3k+un9R1/g9w4rAdv0LTMkuiO8xD4/LBCcVhsQmwj4tuu16eUBkSC0
 XKbs5iPMd5chybO1kvlqkGCj/+CfsZ+Fjiymp7CZ54HyLcVVvJnTIEuwqmnsYHvWrVzl
 dn+liFXX1ir3SyaEGCi13Xp6kTa3wK+qRue2UGPKvTIORELKIWAOL5yiKUYaEHvyFre7
 BVXCejlNRi7h93mhJaPcZD1uXG5HoMEDtMYnLEshorpg0pzdwzU56mRJ14l9hP2oMBF9
 N5ybZJDxBntXkHlxx9ktuGKGrXGW1/3vOgpl+RQAkhsLhCAK1JZRuef8sPdXavHhqeUj
 rYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8A6s5tE8FGCINiR/sUQWCJ8R9QqhGBdbxA5+hhWgepjFXd5mmwLOTtQEIItDCXS88dQaGqmh+etvU@nongnu.org
X-Gm-Message-State: AOJu0Yx6GW7myLlK0HmgKDTJ4/1QPCwNn2Sd+AHwqx0ZArpIaFuVdl79
 evwRCtHFPcWdv4DNIFn+mbbcGzGNGHaeCODQeErMV15PymnfL2huTYf3J6GBnKSQwHW+kfx/282
 GAXn6D1op0Qm7wOsZySwW5YLHqY/ONXE0SzHmf4/veSTMlZayxJJCm6J1iCLp0zvwC/cnCIImzI
 Z76eydtXfAy4HkJUv5zEq54eup+jM=
X-Gm-Gg: ASbGncv9qNWwBt4QCTU3D3KXh8271bGRKw6CmN38FSquQmalyRUEAWrab7FKLcMO7pH
 bve8eaNlrxOIWdwU5tdu/L+/YaPeMYAdDc/6cY78=
X-Received: by 2002:a05:6402:2348:b0:5d0:d183:cc05 with SMTP id
 4fb4d7f45d1cf-5d972dfbc14mr1097298a12.5.1736318968643; 
 Tue, 07 Jan 2025 22:49:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHQBBSPg4KdiXhHA+XAJX1n7aF96zZwZF4G3zGXOx0R6C1dmiRy0TXJBlrSyqHFHcpb3CGfLOlrHlIy+Xp4XE=
X-Received: by 2002:a05:6402:2348:b0:5d0:d183:cc05 with SMTP id
 4fb4d7f45d1cf-5d972dfbc14mr1097281a12.5.1736318968254; Tue, 07 Jan 2025
 22:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 8 Jan 2025 14:48:51 +0800
X-Gm-Features: AbW1kvYa43XOnsVprlJQTKkJLKRQg8l3oT_c8BgmPtawHc1X73_YDpbGP9oAOmI
Message-ID: <CAPpAL=ykPpS-=pNsEvGyCNvaQ=U+G1vj54qLjrOS54nROAKeMg@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] virtio-net: add support for SR-IOV emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 devel@daynix.com, Yui Washizu <yui.washidu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

I tested this series of patches with virtio-net regression tests and
basic scenario tests (reboot, shutdown, jumbo) for vf, everything
works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Jan 4, 2025 at 4:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> Based-on: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
> ("[PATCH v18 00/14] hw/pci: SR-IOV related fixes and improvements")
>
> Introduction
> ------------
>
> This series is based on the RFC series submitted by Yui Washizu[1].
> See also [2] for the context.
>
> This series enables SR-IOV emulation for virtio-net. It is useful
> to test SR-IOV support on the guest, or to expose several vDPA devices
> in a VM. vDPA devices can also provide L2 switching feature for
> offloading though it is out of scope to allow the guest to configure
> such a feature.
>
> The PF side code resides in virtio-pci. The VF side code resides in
> the PCI common infrastructure, but it is restricted to work only for
> virtio-net-pci because of lack of validation.
>
> User Interface
> --------------
>
> A user can configure a SR-IOV capable virtio-net device by adding
> virtio-net-pci functions to a bus. Below is a command line example:
>   -netdev user,id=3Dn -netdev user,id=3Do
>   -netdev user,id=3Dp -netdev user,id=3Dq
>   -device pcie-root-port,id=3Db
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x3,netdev=3Dq,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x2,netdev=3Dp,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x1,netdev=3Do,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x0,netdev=3Dn,id=3Df
>
> The VFs specify the paired PF with "sriov-pf" property. The PF must be
> added after all VFs. It is user's responsibility to ensure that VFs have
> function numbers larger than one of the PF, and the function numbers
> have a consistent stride.
>
> Keeping VF instances
> --------------------
>
> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
> the guest requests. Previously, this behavior was implemented by
> realizing and unrealizing VFs at runtime. However, this strategy does
> not work well for the proposed virtio-net emulation; in this proposal,
> device options passed in the command line must be maintained as VFs
> are hotplugged, but they are consumed when the machine starts and not
> available after that, which makes realizing VFs at runtime impossible.
>
> As an strategy alternative to runtime realization/unrealization, this
> series proposes to reuse the code to power down PCI Express devices.
> When a PCI Express device is powered down, it will be hidden from the
> guest but will be kept realized. This effectively implements the
> behavior we need for the SR-IOV emulation.
>
> Summary
> -------
>
> Patch 1 disables ROM BAR, which virtio-net-pci enables by default, for
> VFs.
> Patch 2 makes zero stride valid for 1 VF configuration.
> Patch 3 and 4 adds validations.
> Patch 5 adds user-created SR-IOV VF infrastructure.
> Patch 6 makes virtio-pci work as SR-IOV PF for user-created VFs.
> Patch 7 allows user to create SR-IOV VFs with virtio-net-pci.
>
> [1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu=
@gmail.com/
> [2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@dayn=
ix.com/
>
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v8:
> - Rebased.
> - Link to v7: https://lore.kernel.org/r/20240813-sriov-v7-0-8515e3774df7@=
daynix.com
>
> Changes in v7:
> - Removed #include <error-report.h>, which is no longer needed.
> - Rebased.
> - Link to v6: https://lore.kernel.org/r/20240802-sriov-v6-0-0c8ff49c4276@=
daynix.com
>
> Changes in v6:
> - Added ARI extended capability.
> - Rebased.
> - Link to v5: https://lore.kernel.org/r/20240715-sriov-v5-0-3f5539093ffc@=
daynix.com
>
> Changes in v5:
> - Dropped the RFC tag.
> - Fixed device unrealization.
> - Rebased.
> - Link to v4: https://lore.kernel.org/r/20240428-sriov-v4-0-ac8ac6212982@=
daynix.com
>
> Changes in v4:
> - Added patch "hw/pci: Fix SR-IOV VF number calculation" to fix division
>   by zero reported by Yui Washizu.
> - Rebased.
> - Link to v3: https://lore.kernel.org/r/20240305-sriov-v3-0-abdb75770372@=
daynix.com
>
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@=
daynix.com
>
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@=
daynix.com
>
> ---
> Akihiko Odaki (9):
>       hw/pci: Do not add ROM BAR for SR-IOV VF
>       hw/pci: Fix SR-IOV VF number calculation
>       pcie_sriov: Ensure PF and VF are mutually exclusive
>       pcie_sriov: Check PCI Express for SR-IOV PF
>       pcie_sriov: Allow user to create SR-IOV device
>       virtio-pci: Implement SR-IOV PF
>       virtio-net: Implement SR-IOV VF
>       docs: Document composable SR-IOV device
>       pcie_sriov: Make a PCI device with user-created VF ARI-capable
>
>  MAINTAINERS                    |   1 +
>  docs/system/index.rst          |   1 +
>  docs/system/sriov.rst          |  37 ++++++
>  include/hw/pci/pci_device.h    |   6 +-
>  include/hw/pci/pcie_sriov.h    |  21 +++
>  include/hw/virtio/virtio-pci.h |   1 +
>  hw/pci/pci.c                   |  76 +++++++----
>  hw/pci/pcie_sriov.c            | 294 +++++++++++++++++++++++++++++++++--=
------
>  hw/virtio/virtio-net-pci.c     |   1 +
>  hw/virtio/virtio-pci.c         |  24 +++-
>  10 files changed, 378 insertions(+), 84 deletions(-)
> ---
> base-commit: e5c58fa88d683cde10d9e9089c16a397803667e2
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


