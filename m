Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4A4C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl45Q-0006NF-0N; Thu, 20 Feb 2025 05:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1tl45M-0006K2-82
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1tl45J-0000Ix-Vd
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740048432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I3uT+5j22I133zxTX3VahKsG5GmWqv+UxgUGdlGP8Wc=;
 b=ZUbPPgcbe6VMpMpnto+fO1gXS/G1LbHRJ0IP3cmjQdN0fn/3HHkYQyHa1X2x7kKCyVpynw
 eiXP8bfhoo+KAcGa/bAEloUEQRGVzR5ahZRxaebLkixmhJLKeRQGFumiRsZ9GxU1i97/II
 PjFSaIkY2SIWH0EG3bay0t1AiNLHAqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-4bKo6qANMXe8lexRBEIj1A-1; Thu, 20 Feb 2025 05:45:39 -0500
X-MC-Unique: 4bKo6qANMXe8lexRBEIj1A-1
X-Mimecast-MFC-AGG-ID: 4bKo6qANMXe8lexRBEIj1A_1740048338
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f255d44acso380338f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 02:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740048338; x=1740653138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3uT+5j22I133zxTX3VahKsG5GmWqv+UxgUGdlGP8Wc=;
 b=NfyU45dimAkcShuyczxi6l2l8kA3gcIFt6LmNRZTHRbD5S6Z3hUnfe3/1bsMc5kvkO
 cVJPPQzziuy8Nak0NKdYuD+VIKrnTI8BpPwZo+Cvsm7DRwmjpVe1RBGjE82os4f1Xc7B
 MtgSF0s7jjVVYFrUVliHlsc8COcMGRU0Bu4m1GkN2puKz1Uk0j6J9PxnHM1CaZA6OqMI
 NC9IFU7rJmLr+Wn8LXHkVaMS1fU2Fd7JSxArBp76veLSw5qmlWFFSjH5slGVZeEw7wRs
 re2H/eKxPm03tdhyYqgaa0xMbMsSRH0LZYte7QbRUaruIy31GaWDDGC8H3V8yYipfmkJ
 VuQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoMalR5pPysBcZ+9/CAEjgfmebe+MiMHxske1joiFgzYTV88kqcB7lWUgl9ohi/C6wvXlWO3OW+yws@nongnu.org
X-Gm-Message-State: AOJu0Yw0udav+O2TvItUtgzGoNXwfMQ0isPHZO5thpTK52Yd3RPqnIKr
 4WIQ2oUdtZSEGBIhA6yAXWffkv5C9V+vRHlgXgOT1BAzuM+gf117LFRimmB7QjEj37mGBuYmgVJ
 j/uyeHVRSmQzsRQqFah8gTsMeB1qZrx9XEG/E+nThzULFZIqy+3L3
X-Gm-Gg: ASbGncunI6GDoEQ9lxYMfXILnI/GUHE99DgMEVRydFxg0cjJg9VFQ7j3IJYD1Av4Oyl
 vYT+bGiWrxV0btzu6Mj+lBEl+ZykuM0HvHGK3bfZLYG+ae6eFhMTRwOL9MUVUsN4FkLHdwVZJR5
 KPPHZbt5o+vithK541vaA83oRgbH/XL5KYZqjjISsFyb32powhNzCGYg8er+a8e69Jewri1KEw+
 gnkHUsKJCL1jQOyzOuiJjz7zsoj8yJm+XhauJmyVNeJRY1hN2sWMraV63RlR7QmUttKcHf1aWc4
 Jupexn0MbljafwQSbxkEy4DOKKb8zO70cN95KZ6tYih133g=
X-Received: by 2002:adf:fd8d:0:b0:38f:476f:e176 with SMTP id
 ffacd0b85a97d-38f650fee42mr1466184f8f.31.1740048337978; 
 Thu, 20 Feb 2025 02:45:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrTJcfF7vs+mr7OJ6to+0O2bheYTha5O+xwOZb9uPdp1B3C4d3bfSHWohQeldI1KFASM3wHg==
X-Received: by 2002:adf:fd8d:0:b0:38f:476f:e176 with SMTP id
 ffacd0b85a97d-38f650fee42mr1466158f8f.31.1740048337555; 
 Thu, 20 Feb 2025 02:45:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258cccd3sm20215367f8f.23.2025.02.20.02.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:45:36 -0800 (PST)
Message-ID: <44a82e93-003a-4d70-a1f0-4bc3efd045d2@redhat.com>
Date: Thu, 20 Feb 2025 11:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Content-Language: en-US
To: eric.auger@redhat.com, Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, clg@redhat.com,
 zhenzhong.duan@intel.com
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
 <20250219141945.5e74c7f3.alex.williamson@redhat.com>
 <4b7cfa82-c730-43af-ab47-53f20131104a@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <4b7cfa82-c730-43af-ab47-53f20131104a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Alex,

On 2/20/25 11:31 AM, Eric Auger wrote:
> 
> Hi Alex,
> 
> On 2/19/25 10:19 PM, Alex Williamson wrote:
>> On Wed, 19 Feb 2025 11:58:44 -0700
>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>
>>> On Wed, 19 Feb 2025 18:58:58 +0100
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>
>>>> Since kernel commit:
>>>> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
>>>> in D3hot power state")
>>>> any attempt to do an mmap access to a BAR when the device is in d3hot
>>>> state will generate a fault.
>>>>
>>>> On system_powerdown, if the VFIO device is translated by an IOMMU,
>>>> the device is moved to D3hot state and then the vIOMMU gets disabled
>>>> by the guest. As a result of this later operation, the address space is
>>>> swapped from translated to untranslated. When re-enabling the aliased
>>>> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
>>>> faults when attempting the operation on BARs.
>>>>
>>>> To avoid doing the remap on those BARs, we compute whether the
>>>> device is in D3hot state and if so, skip the DMA MAP.  
>>> Thinking on this some more, QEMU PCI code already manages the device
>>> BARs appearing in the address space based on the memory enable bit in
>>> the command register.  Should we do the same for PM state?
>>>
>>> IOW, the device going into low power state should remove the BARs from
>>> the AddressSpace and waking the device should re-add them.  The BAR DMA
>>> mapping should then always be consistent, whereas here nothing would
>>> remap the BARs when the device is woken.
>>>
>>> I imagine we'd need an interface to register the PM capability with the
>>> core QEMU PCI code, where address space updates are performed relative
>>> to both memory enable and power status.  There might be a way to
>>> implement this just for vfio-pci devices by toggling the enable state
>>> of the BAR mmaps relative to PM state, but doing it at the PCI core
>>> level seems like it'd provide behavior more true to physical hardware.
>> I took a stab at this approach here, it doesn't obviously break
>> anything in my configs, but I haven't yet tried to reproduce this exact
>> scenario.
>>
>> https://gitlab.com/alex.williamson/qemu/-/tree/pci-pm-power-state

it does not totally fix the issue: I now get:

qemu-system-x86_64: warning: vfio_container_dma_map(0x55cc25705680,
0x380000000000, 0x1000000, 0x7f8762000000) = -14 (Bad address)
0000:41:00.0: PCI peer-to-peer transactions on BARs are not supported.


Eric

> 
> So if I understand correctly the BAR regions will disappear upon the
> config cmd write in vfio_sub_page_bar_update_mapping(). Is that correct?
> I will give it a try on my setup...
>>
>> There's another pm_cap on the PCIExpressDevice that needs to be
>> consolidated as well, once I do some research to figure out why a
>> non-express capability is tracked only by express devices and what
>> they're doing with it.  Thanks,
> I am not sure I get this last point though.
> 
> Thanks
> 
> Eric
>>
>> Alex
>>
> 


