Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BB9C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 04:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvU61-00027M-32; Fri, 21 Mar 2025 00:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1tvU5z-00026x-8X; Fri, 21 Mar 2025 00:34:59 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1tvU5w-0000bz-SR; Fri, 21 Mar 2025 00:34:59 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3015001f862so2083761a91.3; 
 Thu, 20 Mar 2025 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742531694; x=1743136494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0XED+HRzFWuugvuVG4TcNLucOBtBtQnR+5fymSpW1Fo=;
 b=nG22asLCNB7DAI5R1g6Y8DgX9MRnjpZLx0Qn9uPF1kBxKyVeJ/TlebpN+ahSS82Qrs
 NqwZbHDxEglmDzTSMWNoC7Lz289nGBg4yJrEjvZDlT82sNHkPlm0zaqdEVizu1QiRoK3
 GeDqHkhPr3cynyWcggEAbpRoK9EhphzrYq6RKRDObOTzLqHpCDGlXTFwyAT/fnMygyhg
 90uMnTHXwl9ytNCygbTfnxEH+p43UZKo/ljcWAyExWXEayf5HqA0OrCN6UOu5KaKs+Zt
 0oD1mKFtLwz0Hlxsf1iyKBCVI7juaaJ9XjvEKlFpp/9W43VDvEOXUpZ37yDUn9kj5urG
 tn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742531694; x=1743136494;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0XED+HRzFWuugvuVG4TcNLucOBtBtQnR+5fymSpW1Fo=;
 b=fZ/tTffb15EO7QmUMqyUaBWIfZPnelHb46aISIw1D/9Q0FC8YvEDP4NLZY17kjM+f/
 +/rZJJm7ZTTA390ZBXjvBd5+Wd3a9pzOVhZV+x71Hh515jXlfUWrBORLP9o15X8FLXM4
 0MYVW2n3IyF9OpnsZwgcfFir2ZBR/VSC/1RnN+5Wpxr4xw/2bhoMAcRU9vDZ9c+SD7gK
 VETDwbLzFTllEGow5SgQFIVxuIQuqCSn2rCN0ZHAzHpMWZpMOYnrdHVjCF2piTwquAfH
 4LM7x8gpnT4as9ZPwA2LzOc+kqkZBlsZ0HYyNPw4MgGMUa1Dp9YxcOTDkBHIV1XMynQA
 HoNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgb8+sVuJpQhNcyX0utvCepzxmZiU6ulLq10EYC2hEtYVauXeWcPBUDaTSUhV/S1zZlV08OMHjTrnV@nongnu.org
X-Gm-Message-State: AOJu0Yxt/Nxi1lK63cBzM0MzedK82WRjnawH1oABCCboAhL3pe/mZKFO
 7fBopxDxF9HNnCBknrxDbCfrlEuAHJY2O5cUUGvo08g9rxXO4BWT
X-Gm-Gg: ASbGncs4UOeQcdHWeVG3ObRn0CcTbk59OJgVUo1SWz/yrRZRFmg0fbyqzJOOZ0Y9LfN
 8HSuoccVF9dHRo5ElRo53obosB3astpu4UlSXBNE8q7e3M6l7pH/W5U/FIznd4WPdhxeagZKbqL
 H/ZultRWK0Ju3PcP8xKFrSnRFzrmbBDw4SvQXFzgqZJHs3ozBIKevM8k5EEdWgusVDT5HI3A/Gn
 RbYRf6DuD+PEJlbSs/G2oWq2qjykHNtQ+VGkXMk6AU0dboK2Y4LcSNqbJx2Y9xSsZJi+L0mw4Rh
 ksTdaxRG/jI2oainajpBErhd6BE35o7n7JUHIuWicCwuzLMAvHDcI2JWZdfvtd0=
X-Google-Smtp-Source: AGHT+IEErBW7yS1BaMQeln3BsdEyIhWsSTpEnqPu2NTWGt5KhK7hViMR4GBBoZNtbBYeIOQkSZFL2Q==
X-Received: by 2002:a17:90b:2743:b0:2ff:4a8d:74f8 with SMTP id
 98e67ed59e1d1-3030fe721dfmr2654786a91.6.1742531693801; 
 Thu, 20 Mar 2025 21:34:53 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f45029sm6930705ad.53.2025.03.20.21.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 21:34:53 -0700 (PDT)
Message-ID: <b8a1565a-2adc-420b-aad3-d10efa2e2650@gmail.com>
Date: Fri, 21 Mar 2025 13:34:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yui Washizu <yui.washidu@gmail.com>
Subject: Re: [PATCH for-10.1 v9 0/9] virtio-net: add support for SR-IOV
 emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
Content-Language: en-US
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=yui.washidu@gmail.com; helo=mail-pj1-x102d.google.com
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


I tested the following features with this patch series, and there were 
not  issues:
- Creation and deletion of VFs
- Communication with an external machine through VFs

Thank you.


Yui


On 2025/03/14 15:14, Akihiko Odaki wrote:
> Based-on:<20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
> [1]https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
> [2]https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/
>
> Co-developed-by: Yui Washizu<yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
> Changes in v9:
> - Rebased.
> - Link to v8:https://lore.kernel.org/r/20250104-sriov-v8-0-56144cfdc7d9@daynix.com
>
> Changes in v8:
> - Rebased.
> - Link to v7:https://lore.kernel.org/r/20240813-sriov-v7-0-8515e3774df7@daynix.com
>
> Changes in v7:
> - Removed #include <error-report.h>, which is no longer needed.
> - Rebased.
> - Link to v6:https://lore.kernel.org/r/20240802-sriov-v6-0-0c8ff49c4276@daynix.com
>
> Changes in v6:
> - Added ARI extended capability.
> - Rebased.
> - Link to v5:https://lore.kernel.org/r/20240715-sriov-v5-0-3f5539093ffc@daynix.com
>
> Changes in v5:
> - Dropped the RFC tag.
> - Fixed device unrealization.
> - Rebased.
> - Link to v4:https://lore.kernel.org/r/20240428-sriov-v4-0-ac8ac6212982@daynix.com
>
> Changes in v4:
> - Added patch "hw/pci: Fix SR-IOV VF number calculation" to fix division
>    by zero reported by Yui Washizu.
> - Rebased.
> - Link to v3:https://lore.kernel.org/r/20240305-sriov-v3-0-abdb75770372@daynix.com
>
> Changes in v3:
> - Rebased.
> - Link to v2:https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com
>
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1:https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com
>
> ---
> Akihiko Odaki (9):
>        hw/pci: Do not add ROM BAR for SR-IOV VF
>        hw/pci: Fix SR-IOV VF number calculation
>        pcie_sriov: Ensure PF and VF are mutually exclusive
>        pcie_sriov: Check PCI Express for SR-IOV PF
>        pcie_sriov: Allow user to create SR-IOV device
>        virtio-pci: Implement SR-IOV PF
>        virtio-net: Implement SR-IOV VF
>        docs: Document composable SR-IOV device
>        pcie_sriov: Make a PCI device with user-created VF ARI-capable
>
>   MAINTAINERS                    |   1 +
>   docs/system/index.rst          |   1 +
>   docs/system/sriov.rst          |  37 ++++++
>   include/hw/pci/pci_device.h    |   6 +-
>   include/hw/pci/pcie_sriov.h    |  21 +++
>   include/hw/virtio/virtio-pci.h |   1 +
>   hw/pci/pci.c                   |  76 +++++++----
>   hw/pci/pcie_sriov.c            | 294 +++++++++++++++++++++++++++++++++--------
>   hw/virtio/virtio-net-pci.c     |   1 +
>   hw/virtio/virtio-pci.c         |  24 +++-
>   10 files changed, 378 insertions(+), 84 deletions(-)
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,

