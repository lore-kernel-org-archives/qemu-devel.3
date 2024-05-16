Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8352C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 02:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7QQ2-0000Li-Sm; Wed, 15 May 2024 22:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1s7QQ1-0000LV-Q3; Wed, 15 May 2024 22:00:29 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1s7QPz-000455-Nu; Wed, 15 May 2024 22:00:29 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f0277767fbso3423310a34.3; 
 Wed, 15 May 2024 19:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715824825; x=1716429625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FsGnIs3tlSReZg5ks73YfeGlNBSYTHn6KqeMTyK0caI=;
 b=cMkuxAYlndLYjtcYNN3Wy9zjJ8QP1W9XE81HQz06zNyhGY6TmyYMqdn+LPCe4Hw9re
 +NWTu+KpHS6+KunEIDAg8/dia1IBjWX0zwslv6DYdz76aCId1bS1qNV/kOmZow9lIrK2
 6EIhnMO6pe9yS/hZJe2SNYOayEjdfAPt+SW9zKgJ2jx64Y4s1PoYlyKO7Imlj6Wc9QLt
 kBgkonbi091DABsCUdcevAxMVL3b+459mz+ugYLvSKPKMq2zH7XWzQISOk9/5L/hX1aX
 kwX6gB2kRxqP1WJuiCs5IYsG/gOL4Du1W8kAFBq+W7BsC5qBRU2ZkdKx/+aKE3JN0aBr
 2RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715824825; x=1716429625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FsGnIs3tlSReZg5ks73YfeGlNBSYTHn6KqeMTyK0caI=;
 b=CZOFyNEMxs9tAcaMb81cCX5xxjzcttTQdXvalK/IE+bl3+2a+trhbvFOM55Ke0AK/b
 20KRw9AIaSso5ByhtY0px7ywd4ud6Q0e3ogzDjeSrJZ/qzuohnDAuh0Fbi2E4F9ZIvLY
 u/Ff5pRasdf4ny4IvM/mVEcCMhz377cuswBpFNBlTLFUE0a1qb3Ux7QMyN4VN6ZeuUHr
 1oSS0gvNgGGSoR/C/mWShkW33IiMslOR05Ob4Ff9S3TTor6etrHAiyoQXczPRrmLg+yq
 r14njNS5XqhFNb2pYF4QB7R7AcCOYAjTJLYmBZa3U+FIyjTjs1frKx44jScwTfcV98Lk
 +pSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8D1yBNy52dvuwYDRd1BPy3RnYOGSirox4YICHycsdQI+agmDBCL+x4E8zk9MkA3QjW4eeuga8Nx2DIKL9+abO51PvZ44=
X-Gm-Message-State: AOJu0YyctXT6+zuOAjWx5ut7aZy/n+qOUpGiDoQczWfYRHatTDFA8MSx
 YZVhQyR7JUG+EFu1dHsQ5vedEt9KUjiwwlMICp/+JGUU+yk9/g96
X-Google-Smtp-Source: AGHT+IFjoU6rEIGztxZS76rgH1dtG0NZej8hkDiZIsd/7+k65SD8skS2if/+REaNwvVgYWbp2+wKgA==
X-Received: by 2002:a9d:7f92:0:b0:6f0:6ea7:6154 with SMTP id
 46e09a7af769-6f0e90f483fmr23036987a34.3.1715824825220; 
 Wed, 15 May 2024 19:00:25 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340c4d4a1csm12269738a12.40.2024.05.15.19.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 19:00:24 -0700 (PDT)
Message-ID: <966b756c-f4b9-40da-ad35-ddb7c6e7da50@gmail.com>
Date: Thu, 16 May 2024 11:00:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/7] virtio-net: add support for SR-IOV emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=yui.washidu@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2024/04/28 18:05, Akihiko Odaki wrote:
> Based-on: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
> ("[PATCH for 9.1 v9 00/11] hw/pci: SR-IOV related fixes and improvements")
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
>    -netdev user,id=n -netdev user,id=o
>    -netdev user,id=p -netdev user,id=q
>    -device pcie-root-port,id=b
>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>
> The VFs specify the paired PF with "sriov-pf" property. The PF must be
> added after all VFs. It is user's responsibility to ensure that VFs have
> function numbers larger than one of the PF, and the function numbers
> have a consistent stride.


I tried to start a VM with more than 8 VFs allocated using your patch,
but the following error occured and qemu didn't work:
VF function number overflows.

I think the cause of this error is that virtio-net-pci PFs don't have ARI.
(pcie_ari_init is not added to virtio-net-pci when PFs are initialized.)
I think it is possible to add it later,
but how about adding pcie_ari_init ?

As a trial,
adding pcie_ari_init to virtio_pci_realize enabled the creation of more 
than 8 VFs.


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
> [1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
> [2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/
>
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v4:
> - Added patch "hw/pci: Fix SR-IOV VF number calculation" to fix division
>    by zero reported by Yui Washizu.
> - Rebased.
> - Link to v3: https://lore.kernel.org/r/20240305-sriov-v3-0-abdb75770372@daynix.com
>
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com
>
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com
>
> ---
> Akihiko Odaki (7):
>        hw/pci: Do not add ROM BAR for SR-IOV VF
>        hw/pci: Fix SR-IOV VF number calculation
>        pcie_sriov: Ensure PF and VF are mutually exclusive
>        pcie_sriov: Check PCI Express for SR-IOV PF
>        pcie_sriov: Allow user to create SR-IOV device
>        virtio-pci: Implement SR-IOV PF
>        virtio-net: Implement SR-IOV VF
>
>   include/hw/pci/pci_device.h |   6 +-
>   include/hw/pci/pcie_sriov.h |  19 +++
>   hw/pci/pci.c                |  76 +++++++----
>   hw/pci/pcie_sriov.c         | 298 +++++++++++++++++++++++++++++++++++---------
>   hw/virtio/virtio-net-pci.c  |   1 +
>   hw/virtio/virtio-pci.c      |   7 ++
>   6 files changed, 323 insertions(+), 84 deletions(-)
> ---
> base-commit: 2ac5458086ab61282f30c2f8bdf2ae9a0a06a75d
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,

