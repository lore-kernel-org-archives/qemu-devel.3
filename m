Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45047C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 05:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvV5J-0003r4-7E; Fri, 21 Mar 2025 01:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1tvV5H-0003qX-Kk; Fri, 21 Mar 2025 01:38:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1tvV5F-0001RK-4V; Fri, 21 Mar 2025 01:38:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225d66a4839so42677455ad.1; 
 Thu, 20 Mar 2025 22:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742535494; x=1743140294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XM023hlGEOTsxrVeFrhqhWpzzevPypp0Gh8j9sxHdwQ=;
 b=Y+bLlcPsAncDen/w4HvFzW3Go9x6uDgJQnKLrxZ0ewYCFY5a98wXXCth0CQS3ctrW1
 fr20cwpLfxuuP9Aa9XrIWSnX9Ng1F3zyoP6yc1B7dDE38XOz8heytj8jrtlDqkx20tOt
 3CnTAbXTY13wZ1+REkr0gb5lU6LDnzm3zpsL56mww4ZdwRctsWCK5oLpQAHFPrv7SeOO
 4QDX4n4SRNqwDdXzxBFyrkh8E+PQ2tIkrlbSql7Pw3sHO22mYK/9S1uwp1MOKw0qUibQ
 6rYotBmbQ4U6epQ97Kptiv8zMB6O1s+FcxbQl5fhs65n2b48yPNj1wxdvyQJu5cJNyKB
 Z9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742535494; x=1743140294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XM023hlGEOTsxrVeFrhqhWpzzevPypp0Gh8j9sxHdwQ=;
 b=j/IYr+Sp47hpLSj7LCsURtg2sdBKUF6wayqwtYy/VXvxLYuT8vO3DLEV3T4S1i4suF
 9gw8i+cahfcLwYxU3vNgNi6vUwbzKjMVWJ0SdZtkwQR009GsfLtR5IWkViamJCVdtkl9
 6V7GMKoeQbwik8+6l7a+G2vXvLaQac7yYC4hdbrbq0Rqv49j/DaXOXrFqfaR//9S+ob1
 tZ9E9OwNJrhFjYsV9j/5a0vUKEMIqmFSzofnU0JIEwgrY7mPeiJdFqM3m64Y4mkPr3A2
 mffXKNFT4M0wvs0VbkCADOtbaN75tAWv0yFBu1lDyyU/mSeNV427k/KEeeiUQ46FpuRD
 VSMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFhS54AS/nICPMEa+uSWLGdpfTLfjoFIZXq9psPUmBgTFujWGtdG9Npjc5k5n/RECOfrryYF4ojT1G@nongnu.org
X-Gm-Message-State: AOJu0YwSiKfanJpZgJdUSYtCwqLt0uaKa0UZUbkvncCOwijUAG7evj7E
 8Qw5yYSFuU/eK+ROC90+QuX1ZKu3CLtntZfmLI3E8tdtYRvnqlag
X-Gm-Gg: ASbGnctgQcPEioYrpW8yWTuiiRwhHCxMMZWVy2YX+r4X9gnO1D+RxWIHPsEL04PU0wj
 9F4+phYFZOY+4OXx5XRBWe3zybR0ZNiCQ3ao4ICtipL2If/scUftBV6+UJmA8AIX7OXcqcuS4Wi
 mduNxmbfWECLo+0wOeGAU/LGRIWCfWRg+Q5rGVjf+B5OFR5lxSmhR51F55xy0HyeQBPshTyfd0s
 No7bxpHfH02oVEcBDLy1N5Bb+V7prlZ5DmVPbtUnK/+giy3pWuZsO4MbNwyLOi9kt4pdb/pTUTM
 i7hnSB3x73YRGcUI6PaEwZFTS+DeZ98F1NsnKfWZUjaCNiXsySpea3f4cL22DMg=
X-Google-Smtp-Source: AGHT+IG7NlGd2F4n/5EZtrSsk69UYC1kqGn8FT4SranSxdSlM3OLnZzt36vIlEMld2Hjsy2dosIUDw==
X-Received: by 2002:a05:6a00:6108:b0:736:b923:5323 with SMTP id
 d2e1a72fcca58-7377a1d9565mr8619110b3a.10.1742535494117; 
 Thu, 20 Mar 2025 22:38:14 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611cb14sm882153b3a.114.2025.03.20.22.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 22:38:13 -0700 (PDT)
Message-ID: <53f4a617-5c4a-46ff-9961-17e6c88734d8@gmail.com>
Date: Fri, 21 Mar 2025 14:38:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v9 0/9] virtio-net: add support for SR-IOV
 emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
 <b8a1565a-2adc-420b-aad3-d10efa2e2650@gmail.com>
 <b9283f28-fec7-4ed4-bb10-e1cffac03457@daynix.com>
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <b9283f28-fec7-4ed4-bb10-e1cffac03457@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yui.washidu@gmail.com; helo=mail-pl1-x630.google.com
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


On 2025/03/21 14:18, Akihiko Odaki wrote:
> On 2025/03/21 13:34, Yui Washizu wrote:
>>
>> I tested the following features with this patch series, and there 
>> were not  issues:
>> - Creation and deletion of VFs
>> - Communication with an external machine through VFs
>>
>> Thank you.
>
> Can you reply with:
>
> Tested-by: Your Name <youraddress@example.com>


OK, Thank you.

I resend it along with the content.


I tested the following features with this patch series, and there were 
not  issues:
- Creation and deletion of VFs
- Communication with an external machine through VFs


Tested-by: Yui Washizu <yui.washidu@gmail.com>


>
> This tag means:
> - you have tested changes you found significant,
> - you found no problems with them, and
> - you are fine to record that in Git commit logs
>
> Pasha Tatashin (who told me they tried the patches), it would be nice 
> if you do the same.
>
> Regards,
> Akihiko Odaki
>
>>
>>
>> Yui
>>
>>
>> On 2025/03/14 15:14, Akihiko Odaki wrote:
>>> Based-on:<20250104-reuse-v18-0-c349eafd8673@daynix.com>
>>> ("[PATCH v18 00/14] hw/pci: SR-IOV related fixes and improvements")
>>>
>>> Introduction
>>> ------------
>>>
>>> This series is based on the RFC series submitted by Yui Washizu[1].
>>> See also [2] for the context.
>>>
>>> This series enables SR-IOV emulation for virtio-net. It is useful
>>> to test SR-IOV support on the guest, or to expose several vDPA devices
>>> in a VM. vDPA devices can also provide L2 switching feature for
>>> offloading though it is out of scope to allow the guest to configure
>>> such a feature.
>>>
>>> The PF side code resides in virtio-pci. The VF side code resides in
>>> the PCI common infrastructure, but it is restricted to work only for
>>> virtio-net-pci because of lack of validation.
>>>
>>> User Interface
>>> --------------
>>>
>>> A user can configure a SR-IOV capable virtio-net device by adding
>>> virtio-net-pci functions to a bus. Below is a command line example:
>>>    -netdev user,id=n -netdev user,id=o
>>>    -netdev user,id=p -netdev user,id=q
>>>    -device pcie-root-port,id=b
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>>>
>>> The VFs specify the paired PF with "sriov-pf" property. The PF must be
>>> added after all VFs. It is user's responsibility to ensure that VFs 
>>> have
>>> function numbers larger than one of the PF, and the function numbers
>>> have a consistent stride.
>>>
>>> Keeping VF instances
>>> --------------------
>>>
>>> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
>>> the guest requests. Previously, this behavior was implemented by
>>> realizing and unrealizing VFs at runtime. However, this strategy does
>>> not work well for the proposed virtio-net emulation; in this proposal,
>>> device options passed in the command line must be maintained as VFs
>>> are hotplugged, but they are consumed when the machine starts and not
>>> available after that, which makes realizing VFs at runtime impossible.
>>>
>>> As an strategy alternative to runtime realization/unrealization, this
>>> series proposes to reuse the code to power down PCI Express devices.
>>> When a PCI Express device is powered down, it will be hidden from the
>>> guest but will be kept realized. This effectively implements the
>>> behavior we need for the SR-IOV emulation.
>>>
>>> Summary
>>> -------
>>>
>>> Patch 1 disables ROM BAR, which virtio-net-pci enables by default, for
>>> VFs.
>>> Patch 2 makes zero stride valid for 1 VF configuration.
>>> Patch 3 and 4 adds validations.
>>> Patch 5 adds user-created SR-IOV VF infrastructure.
>>> Patch 6 makes virtio-pci work as SR-IOV PF for user-created VFs.
>>> Patch 7 allows user to create SR-IOV VFs with virtio-net-pci.
>>>
>>> [1]https://patchew.org/QEMU/1689731808-3009-1-git-send-email- 
>>> yui.washidu@gmail.com/
>>> [2]https://lore.kernel.org/all/5d46f455- 
>>> f530-4e5e-9ae7-13a2297d4bc5@daynix.com/
>>>
>>> Co-developed-by: Yui Washizu<yui.washidu@gmail.com>
>>> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
>>> ---
>>> Changes in v9:
>>> - Rebased.
>>> - Link to v8:https://lore.kernel.org/r/20250104-sriov- 
>>> v8-0-56144cfdc7d9@daynix.com
>>>
>>> Changes in v8:
>>> - Rebased.
>>> - Link to v7:https://lore.kernel.org/r/20240813-sriov- 
>>> v7-0-8515e3774df7@daynix.com
>>>
>>> Changes in v7:
>>> - Removed #include <error-report.h>, which is no longer needed.
>>> - Rebased.
>>> - Link to v6:https://lore.kernel.org/r/20240802-sriov- 
>>> v6-0-0c8ff49c4276@daynix.com
>>>
>>> Changes in v6:
>>> - Added ARI extended capability.
>>> - Rebased.
>>> - Link to v5:https://lore.kernel.org/r/20240715-sriov- 
>>> v5-0-3f5539093ffc@daynix.com
>>>
>>> Changes in v5:
>>> - Dropped the RFC tag.
>>> - Fixed device unrealization.
>>> - Rebased.
>>> - Link to v4:https://lore.kernel.org/r/20240428-sriov-v4-0- 
>>> ac8ac6212982@daynix.com
>>>
>>> Changes in v4:
>>> - Added patch "hw/pci: Fix SR-IOV VF number calculation" to fix 
>>> division
>>>    by zero reported by Yui Washizu.
>>> - Rebased.
>>> - Link to v3:https://lore.kernel.org/r/20240305-sriov-v3-0- 
>>> abdb75770372@daynix.com
>>>
>>> Changes in v3:
>>> - Rebased.
>>> - Link to v2:https://lore.kernel.org/r/20231210-sriov-v2-0- 
>>> b959e8a6dfaf@daynix.com
>>>
>>> Changes in v2:
>>> - Changed to keep VF instances.
>>> - Link to v1:https://lore.kernel.org/r/20231202-sriov- 
>>> v1-0-32b3570f7bd6@daynix.com
>>>
>>> ---
>>> Akihiko Odaki (9):
>>>        hw/pci: Do not add ROM BAR for SR-IOV VF
>>>        hw/pci: Fix SR-IOV VF number calculation
>>>        pcie_sriov: Ensure PF and VF are mutually exclusive
>>>        pcie_sriov: Check PCI Express for SR-IOV PF
>>>        pcie_sriov: Allow user to create SR-IOV device
>>>        virtio-pci: Implement SR-IOV PF
>>>        virtio-net: Implement SR-IOV VF
>>>        docs: Document composable SR-IOV device
>>>        pcie_sriov: Make a PCI device with user-created VF ARI-capable
>>>
>>>   MAINTAINERS                    |   1 +
>>>   docs/system/index.rst          |   1 +
>>>   docs/system/sriov.rst          |  37 ++++++
>>>   include/hw/pci/pci_device.h    |   6 +-
>>>   include/hw/pci/pcie_sriov.h    |  21 +++
>>>   include/hw/virtio/virtio-pci.h |   1 +
>>>   hw/pci/pci.c                   |  76 +++++++----
>>>   hw/pci/pcie_sriov.c            | 294 
>>> +++++++++++++++++++++++++++++++ ++--------
>>>   hw/virtio/virtio-net-pci.c     |   1 +
>>>   hw/virtio/virtio-pci.c         |  24 +++-
>>>   10 files changed, 378 insertions(+), 84 deletions(-)
>>> ---
>>> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
>>> change-id: 20231202-sriov-9402fb262be8
>>>
>>> Best regards,
>

