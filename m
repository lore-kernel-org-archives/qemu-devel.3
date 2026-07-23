Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75991C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnzn-0002dB-G5; Thu, 23 Jul 2026 03:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmnzm-0002co-3k
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmnzj-00083i-8U
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784792245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ob9Gw6xMWv+4BflWioB/8IFbQdkw3PkAGT8poQ+VH5o=;
 b=ia3raAnV5GykepOwNAIPMF3SM0dXv6jEDewYaC469JFINv+RwL23vV6TVlgbvEEXvN7W9E
 xbjmKYxsp74aJms9cCbdCQM5NCAX6tjKABJ1Z8zEVNIZ2UUIDyq/swhQRU6M47YMMAqR28
 pS9O9GaC26mOqaluYxZrsydORMAjxUI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Gx9QZiJeM2qkXysLnsVv2g-1; Thu, 23 Jul 2026 03:37:24 -0400
X-MC-Unique: Gx9QZiJeM2qkXysLnsVv2g-1
X-Mimecast-MFC-AGG-ID: Gx9QZiJeM2qkXysLnsVv2g_1784792243
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955843c6cdso3738085e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784792243; x=1785397043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ob9Gw6xMWv+4BflWioB/8IFbQdkw3PkAGT8poQ+VH5o=;
 b=a/DVxTdaISQKnX0FyUo2u9IRBMszVgYNFwSMZEcVJF1hDXeAsjX6mgJ41PLVdi6sIa
 HVPKtTowZnM8twDyIIVI3xclX20JLNZBYQY7pND5hG1jaIL3ZsP7co83xFl8PV9Gju3+
 HcD1oeKeB0CwPd5+4xeVik8tHvWgkcEiV0CYXeoX9Na1uhEw1w/LWqPGc9EXbJAaWAG0
 KMee5IAaU+lzBp8cGc7iKX/0FN+NTHrOSEQadiHXhyCklqLGB0q0FCUoa889QEwsz7Nq
 BRBLfWdVhBmMXdDGbBi0buhGcMBwKyFxCy5c6ITHKhwIfuO00rk4KoDPNyrTLMAXga1G
 Vhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784792243; x=1785397043;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ob9Gw6xMWv+4BflWioB/8IFbQdkw3PkAGT8poQ+VH5o=;
 b=bOZBjQWKU+294BHYiHf04dLV9uFFVol5p+wg8faNjWmI1Y5pT3nrswb+RielYg6D00
 kVy/wLhJ16+f5+khgqdTmG3EgX1rdw5Gago6UyyhFJRH5VAtpNK/PI8JAIhDBkOB5oUm
 YRnfbnFJu0AfNCWfjuElPeSAC47JT2KXqJX8nWrsmVtii5RbHSI4tJ7nuc+W0sBDnQ27
 YP6XWg2JMCkFzSFWGukqAduv1EmBnGKSerTCOC3Ch83opcspIW+m+CVrKTEeMTQx1iro
 TD03o7/fyfazBkY2KpqVnqY0veBwSni9Noe2lGiijnSV7Iog9L6sE7gVwQs39HS+08Qv
 RXYg==
X-Gm-Message-State: AOJu0Yys8b3JnmQ0IdfWGwp8qnk+FgQzuo6V2zFXSc/PbZfrDBZKBeUb
 05vtm7z5WDejukb5kwzU0A1dwF7Eq9imOV+zvk5k7dwQtWBEHa7sj8b5nEAiV3HzKIXJLCnUqs3
 1ZVOMET3qxYBbiPczlNiNxxcZ6drsY7uCCAIajRuujHUJg6cwi81/iOhC
X-Gm-Gg: AR+sD13WUqW8ZqmDd/dnvyK3156LPAMQ7BbIa/kcq+e3OkYOjVlpyi4NlBjpbm3Qp7l
 lpWcjy6w7OFXLb8VBv5VFuRoduiIkDOOXPqbxGIH0r6EEbHPgids3yfkRqmWoVUw6ZN4pluG8sl
 rEu/h1hWJqk86BOdNrI98CPKRl0uEjE0uxFserv921/ph1AkyY7uxwuXrNmuhGgF2xhGssUxFdO
 B/D3HKM/lefxeb23YOsvyuPUMVVRzOjiIgoUgObPmv+qG0rrek/PPnLTbLZNo10UYaVrdkduCKP
 9dXS03wNkW71IHSaSxiSO7ky7z3H5G+wrd0y0bg4qhl2Z2SoQNR0mLOy1OoTlZxTywUMIF3kthJ
 1yxRSKJmqIpz2UlJZeNbvgj3rnGIDQI2ZKOvX7Es=
X-Received: by 2002:a05:600c:154a:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-49573d02244mr18199635e9.21.1784792242798; 
 Thu, 23 Jul 2026 00:37:22 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-49573d02244mr18199305e9.21.1784792242309; 
 Thu, 23 Jul 2026 00:37:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm224511345e9.8.2026.07.23.00.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 00:37:21 -0700 (PDT)
Message-ID: <c3b5a5f5-0c3a-4793-9dd6-206ba0b6ed72@redhat.com>
Date: Thu, 23 Jul 2026 09:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode DMA
 (re)map for passthrough BARs
To: Wencheng Yang <east.moutain.yang@gmail.com>,
 Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Yangwencheng <yangwencheng@gmail.com>
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
 <20260721110247-mutt-send-email-mst@kernel.org>
 <20260721230004.2c03fede@shazbot.org>
 <CALrP2iVwJqufzvjOdiEiE0FPTHkMjMjhA4H0siaLAuAHmw2wLQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CALrP2iVwJqufzvjOdiEiE0FPTHkMjMjhA4H0siaLAuAHmw2wLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

On 7/23/26 05:50, Wencheng Yang wrote:
> __
> 
> 
> On 2026/7/22 13:00, Alex Williamson wrote:
>> On Tue, 21 Jul 2026 11:03:39 -0400
>> "Michael S. Tsirkin"<mst@redhat.com> <mailto:mst@redhat.com> wrote:
>>
>>> On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:
>>>> On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:
>>>>> From: YangWencheng<east.moutain.yang@gmail.com> <mailto:east.moutain.yang@gmail.com>
>>>>>
>>>>> A passthrough device's own MMIO/BAR range is registered with the IOMMU
>>>>> (VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
>>>>> address space, to support peer-to-peer DMA into that BAR from other
>>>>> devices. Toggling the guest's PCI_COMMAND memory-decode-enable bit off
>>>>> and back on -- something PCI enumeration/attribute code does routinely,
>>>>> sometimes several times for the same device (e.g. disable before
>>>>> reprogramming a BAR then re-enable, or generic driver probing during
>>>>> guest OS boot) -- currently tears down and rebuilds this mapping every
>>>>> single time via vfio_listener_region_del()/region_add(), unconditionally.
>>>>>
>>>>> For devices with very large BARs this is expensive: mapping a 64GB BAR
>>>>> into IOMMU page tables measured at ~8.5s per call on this hardware, and
>>>>> was observed being repeated 3-5 times for the same BAR during a single
>>>>> guest boot, because nothing changed about the underlying mapping between
>>>>> the disable and the following re-enable.
>>>>>
>>>>> Defer the actual VFIO_IOMMU_UNMAP_DMA for "ram device" regions (i.e.
>>>>> passthrough device BARs used for P2P DMA -- explicitly not regular guest
>>>>> RAM or RamDiscardManager-backed regions, so migration/ballooning/
>>>>> virtio-mem are unaffected) instead of issuing it immediately in
>>>>> region_del(). If a matching region_add() for the exact same region
>>>>> (same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
>>>>> the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
>>>>> host-side mapping was never actually removed, so there is nothing to
>>>>> redo. A region_add() for anything that doesn't match maps normally, as
>>>>> before.
>>>>>
>>>>> Nothing is leaked: any mapping still on the pending list is flushed with
>>>>> a real unmap in two places -- vfio_container_instance_finalize(), before
>>>>> the container's fd is closed (VM shutdown / last device in a group removed),
>>>>> and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
>>>>> device's own BARs, so a device hot-unplugged while the container stays
>>>>> alive for other devices can't leave a dangling deferred entry either.
>>>>>
>>>>> This does not weaken the PCI_COMMAND memory-decode security boundary:
>>>>> every guest write to PCI_COMMAND is still forwarded synchronously and
>>>>> unconditionally to the real device's config space in
>>>>> vfio_pci_write_config() (an entirely separate code path, untouched by
>>>>> this change), which is what actually gates whether the physical device
>>>>> claims/responds to transactions targeting its BAR, independent of
>>>>> whatever the IOMMU's routing table still contains. This change only
>>>>> avoids redundant bookkeeping of that routing table when nothing about
>>>>> the mapping has changed.
>>>> Seems like you should focus on huge pfnmap support on your platform
>>>> rather than hack the VMM to not behave like bare metal.  Thanks,
>>>>
>>> But bare metal does not tweak an iommu during pci enumeration?
>> Bare metal is not using the IOMMU to map the device into a guest
>> physical address space, so no, an equivalent operation does not occur
>> there.  The proposal here is intentionally leaving stale gpa mappings
>> to avoid the unmap/remap overhead, where we've essentially eliminated
>> that overhead on other platforms with huge pfnmap support.  The
>> specific platform that's being optimized here is also omitted, which
>> makes it impossible to determine the ongoing need for this code.
>>
>> The scheme here effectively assumes that a region_del() will either be
>> followed by a region_add() that cancels the deferred unmap, or the
>> deferral will be executed on finalize.  It does not actually account
>> for cases where the guest might remap the BAR to a different address,
>> ex. pci=realloc, leaving a stale mapping in place.  The finalize also
>> appears to be using a different MR from the one deferred, such that the
>> IOMMU is actually only unmapped due to close().
>>
>> More importantly though, this entire scheme is relying on a gap in the
>> vfio type1 IOMMU backend, where clearing the memory enable bit of the
>> command register zaps the CPU mappings and errors faults while cleared,
>> but does not generate unmaps in the IOMMU.  IOMMUFD resolves that gap,
>> generating a move-notify/invalidate on the dma-buf, which results in an
>> IOMMU unmap.  IOW, the premise of this workaround is broken in the
>> direction that VFIO is headed.
>>
>> Therefore, I'd once again suggest that effort is better redirected to
>> implement huge pfnmap support for whatever platform this might be in
>> order to follow a proven solution to this problem for type1.  Huge
>> pfnmap is used both in the CPU fault path as well as the DMA mapping
>> path, by virtue of generating user faults in the pfnmap.  Alternatively,
>> iommufd may provide better p2p DMA mapping performance than type1
>> without huge pfnmap, but CPU faults would lag without such support
>> anyway.  Thanks,
>>
>> Alex
> 
> I noticed you provided a kernel patch "PCI: Batch BAR sizing operations",
> 
> the patch eliminates the overhead of IOMMU map/unmap operations from
> 
> guest kernel. I found OVMF has the same issue, I tried to fix it in edk2 source
> 
> code, but the PCI commands are scattered, it's hard to handle it like kernel.
> 
> I think it's reasonable to handle it qemu, as the overhead is introduced by
> 
> qemu to support PCIe device passthrough.
> 
> 
> "we've essentially eliminated that overhead on other platforms with huge
>   pfnmap support."
> 
> Can you provide some key references about this approach?
Check these related commits.

Linux :

   commit f9e54c3a2f5b ("vfio/pci: implement huge_fault support")

QEMU:

   commit 00b519c0bca0 ("vfio/helpers: Align mmaps")

Thanks,

C.


