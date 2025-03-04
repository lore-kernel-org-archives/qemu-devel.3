Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E22CC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpREi-0007Sd-67; Tue, 04 Mar 2025 07:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpREc-0007SE-Hc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpREZ-0007tf-HQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741090729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nsSGa+BA4RK2fk5zZ2syYol7ei3E0HQlcWcUPK/Q5Ts=;
 b=dxDJQRgkXCk6qKqZS2S7lbc0TRoVTxtYwHzj4/vVJm3eU9lb3rIQ+jKzGgR2Wxgf4E1bO0
 67qqSlgE4GWrDbDlRaTrrpQmDRvrdHLSH+i6YKJMQUvh7ytVVly9jrys+HprbQZo9XB+5e
 6rp/mEM2Sm5CoizFzMh9qIXyXTe83qI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-FOX5LFD8M-eJlI11JbDKPw-1; Tue, 04 Mar 2025 07:18:48 -0500
X-MC-Unique: FOX5LFD8M-eJlI11JbDKPw-1
X-Mimecast-MFC-AGG-ID: FOX5LFD8M-eJlI11JbDKPw_1741090727
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391079c9798so1046076f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 04:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741090727; x=1741695527;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsSGa+BA4RK2fk5zZ2syYol7ei3E0HQlcWcUPK/Q5Ts=;
 b=IJzNqhqSiusvlCFn2OjXf0/MQsNxnBLBMVLoWWjVFMLmq03H5QvZxtWmLHRabCKp+W
 6yXt7BVnEhFsmtLtrCVOjY1mXBI4mJcn08tNyGGaAQ6W2ureAwBm2Y8w3MXNYC2JOfB4
 ow7nKxctCMbtQFUMMJ8dCgr+kZ0JbvvcvJ2hbH/tfvYzEvZVCj4DcWufRO4Qx1BqpJxw
 sPiUviMY1CgZeuk23rv4iYc5UcY+gghnrbh4grpKV1cbXvFPdx1UntPdw9h8k5WyigE7
 JDJptt8Vkzg8RxHhjKAuTehtF6yK/5rgeFMJJbeNVHEpXI8ThZTgm0KC4jWYKf6n0RLm
 c40w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNosSZrQwYXPOWAPSQipYGkB/NDphIkr8488RHLLqETAFAhRzSygYNwOPlpkH82vzf59Ok+ftNxIbH@nongnu.org
X-Gm-Message-State: AOJu0YyLg1u/NGy038mVCnQ/3q6Y1VyK9FEcltQgxDhmvID7ZxGlJyvy
 I2iTTKdO7hfcTSQR4TU7vCw9VkzIXF+wJP0RAJtvq/obv0IZmK7B4+o6BiOcXhhsfKlsxTnJoVe
 xVct0/FYbrHhJLksrzcDLTfpwdPYOTbYzYb8VUBk8n3QDiQv5iyMs
X-Gm-Gg: ASbGnctSJm2wKVgHa0ttk1hbOI/DLnu4JB2Xl95eQCU+TRQI5ndjClCAMb2dSQoDNC3
 XYWWj4fRqU/TAgZ8bZLxSRNDdBK1GWFQVBQDd+FZoEiVmrisujc/5kILU6P/mYGCrrpQ1ibryI/
 ik+jApf1QWoigtKRtlYzrQpQW/Lpy1pPMzbOQ1uisXdwVo5n9SQfSfx+dX6i8mQabPvKRkZAP9A
 tgu1/mAwQ7hjC6RO9iPcDS0J3m9ZF5aSYugVm6R+EELfDUyn2Iw7RU5/5OCjC2EN2PM9bczHaS8
 2gL+OTQKA9NOmos2cUrCBZVzDHQVJzE86xEJeImt+iQoXrsLJZUp7Q==
X-Received: by 2002:a5d:64a6:0:b0:390:eb01:655b with SMTP id
 ffacd0b85a97d-390eca56475mr14309748f8f.54.1741090727229; 
 Tue, 04 Mar 2025 04:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGARcnz5DvXXA8OtQ/73gKJeifhpajIJUn9wtEdUURLtNC49zmGQcVS5MiDIbuPWVOQDuVOBA==
X-Received: by 2002:a5d:64a6:0:b0:390:eb01:655b with SMTP id
 ffacd0b85a97d-390eca56475mr14309727f8f.54.1741090726775; 
 Tue, 04 Mar 2025 04:18:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6d17sm17263995f8f.28.2025.03.04.04.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 04:18:46 -0800 (PST)
Message-ID: <df7cdd6f-0d12-4903-9614-8f74e76416f7@redhat.com>
Date: Tue, 4 Mar 2025 13:18:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PCI: Implement basic PCI PM capability backing
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250225215237.3314011-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Michael,

Could you please re-ack (or not) v2 ?

Thanks

C.

On 2/25/25 22:52, Alex Williamson wrote:
> v2:
> 
> Eric noted in v1 that one of the drivers had a redundant wmask setting
> since pci_pm_init() enabled writes to the power state field.  This was
> added because vfio-pci was not setting wmask for this capability but
> is allowing writes to the PM state field through to the device.  For
> vfio-pci, QEMU emulated config space is rather secondary to the config
> space through vfio.
> 
> It turns out therefore, that vfio-pci is nearly unique in not already
> managing the wmask of the PM capability state and if we embrace that
> it's the pci_pm_init() caller's responsibility to manage the remaining
> contents and write-access of the capability, then I think we also
> solve the question of migration compatibility.  The new infrastructure
> here is not changing whether any fields were previously writable, it's
> only effecting a mapping change based on the value found there.
> 
> This requires only a slight change to patch 1/, removing setting of
> the wmask, but commit log is also updated and comments added.  I also
> made the bad transition trace a little more obvious given Eric's
> comments.  Patch 2/ is also updated so that vfio-pci effects the wmask
> change locally.  The couple drivers that don't currently update wmask
> simply don't get this new BAR unmapped when not in D0 behavior.
> 
> Incorporated reviews for the unmodified patches.  Please re-review and
> report any noted issues.  Thanks,
> 
> Alex
> 
> v1:
> 
> https://lore.kernel.org/all/20250220224918.2520417-1-alex.williamson@redhat.com/
> 
> Eric recently identified an issue[1] where during graceful shutdown
> of a VM in a vIOMMU configuration, the guest driver places the device
> into the D3 power state, the vIOMMU is then disabled, triggering an
> AddressSpace update.  The device BARs are still mapped into the AS,
> but the vfio host driver refuses to DMA map the MMIO space due to the
> device power state.
> 
> The proposed solution in [1] was to skip mappings based on the
> device power state.  Here we take a different approach.  The PCI spec
> defines that devices in D1/2/3 power state should respond only to
> configuration and message requests and all other requests should be
> handled as an Unsupported Request.  In other words, the memory and
> IO BARs are not accessible except when the device is in the D0 power
> state.
> 
> To emulate this behavior, we can factor the device power state into
> the mapping state of the device BARs.  Therefore the BAR is marked
> as unmapped if either the respective command register enable bit is
> clear or the device is not in the D0 power state.
> 
> In order to implement this, the PowerState field of the PMCSR
> register becomes writable, which allows the device to appear in
> lower power states.  This also therefore implements D3 support
> (insofar as the BAR behavior) for all devices implementing the PM
> capability.  The PCI spec requires D3 support.
> 
> An aspect that needs attention here is whether this change in the
> wmask and PMCSR bits becomes a problem for migration, and how we
> might solve it.  For a guest migrating old->new, the device would
> always be in the D0 power state, but the register becomes writable.
> In the opposite direction, is it possible that a device could
> migrate in a low power state and be stuck there since the bits are
> read-only in old QEMU?  Do we need an option for this behavior and a
> machine state bump, or are there alternatives?
> 
> Thanks,
> Alex
> 
> [1]https://lore.kernel.org/all/20250219175941.135390-1-eric.auger@redhat.com/
> 
> 
> Alex Williamson (5):
>    hw/pci: Basic support for PCI power management
>    pci: Use PCI PM capability initializer
>    vfio/pci: Delete local pm_cap
>    pcie, virtio: Remove redundant pm_cap
>    hw/vfio/pci: Re-order pre-reset
> 
>   hw/net/e1000e.c                 |  3 +-
>   hw/net/eepro100.c               |  4 +-
>   hw/net/igb.c                    |  3 +-
>   hw/nvme/ctrl.c                  |  3 +-
>   hw/pci-bridge/pcie_pci_bridge.c |  3 +-
>   hw/pci/pci.c                    | 93 ++++++++++++++++++++++++++++++++-
>   hw/pci/trace-events             |  2 +
>   hw/vfio/pci.c                   | 34 ++++++------
>   hw/vfio/pci.h                   |  1 -
>   hw/virtio/virtio-pci.c          | 11 ++--
>   include/hw/pci/pci.h            |  3 ++
>   include/hw/pci/pci_device.h     |  3 ++
>   include/hw/pci/pcie.h           |  2 -
>   13 files changed, 127 insertions(+), 38 deletions(-)
> 


