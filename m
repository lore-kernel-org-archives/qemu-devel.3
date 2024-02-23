Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE09FC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdR4b-0006bX-NF; Fri, 23 Feb 2024 03:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdR4Z-0006YQ-O3
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdR4Y-0007hp-5w
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708677501;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmzESXaHkihpPVFRXL/jKinH8c8bgeSFI8rWJ5sEJbg=;
 b=RAXgyDKjpJtV8t774kYdufhROmjU4wxxy8BmytlnfqUWqo6oJ1PyaA0089THqFhnRNG9lt
 2Pnf1TIk2BY02WIZBiXV8uTB9HPFBHoj6ye9UXk03p/6+vHCFPAG132KmYeD9BgAETmEZ/
 lOKc6tQoua/qzEQOerUqcYlCz4IYOt0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-LH8d4SQqOtW7JxZULjN41g-1; Fri, 23 Feb 2024 03:38:19 -0500
X-MC-Unique: LH8d4SQqOtW7JxZULjN41g-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-608a1a2723cso10141037b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708677499; x=1709282299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmzESXaHkihpPVFRXL/jKinH8c8bgeSFI8rWJ5sEJbg=;
 b=L65uz/Y54iYaL8LNxwpUY8Ga+5O1/8jjKivzGtUdAOSH/H/A1BuT1iUbP2KAmBzE0J
 nbIycxyavPsMxVoDax8WtxM8aQKEgOXYDF1Fc6psMdqGDvyrM2sqU9zKwmBDjs0DYpnM
 8U0RwaddIiiD1I47aM25VDMfmII0fmwgRrrF/KeZkwdCnfsc7aGb8sKx3SlUnWp3bLVP
 AOqGbOf1ihD0r7/sb3qQB+wJd1oBgOzuWdFVqKxyC6QAZOshiXoYpQ5rWD9jYdPzsTF6
 jQUIAIAdjj0PvKc+ZZJgNJgnZQyXGjOmO2x+ywLILBQQtV8c2NQDuQoVp4NggaLx4TKk
 oW5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX2ZBXrlSYsFiqo6PV4OfjujGDmNDEo19BzCe8qUlAUUsWXggzIG0gIckqr2KP68i2pAJKR9UCeBRYpsf64Ymz8Y84XEs=
X-Gm-Message-State: AOJu0YxXLBsIXSrzqYnp84+ykEd5w/mg8PipGP5bptqHQipmscv/NuKV
 FXNdHuOCwcaSuJdtH5tGut4uAX6vtOn93m7SKmYIDdDI4ZNvAA1Yvmb0xFY6ZMAoIqHMFnEVhw/
 jdlM+od0ownVtsYoWXGIJ5pUjJpVusgSxFppcE3PJKYCDPXqJE64U
X-Received: by 2002:a81:b71e:0:b0:607:6ad3:8746 with SMTP id
 v30-20020a81b71e000000b006076ad38746mr1426838ywh.46.1708677498869; 
 Fri, 23 Feb 2024 00:38:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXD4wfZor91Zq+xwR00Cuo8VdzWEIoYHcM2ygK5dJnWiLLLimbc9+EDRFQd2sfkACiKDU4xg==
X-Received: by 2002:a81:b71e:0:b0:607:6ad3:8746 with SMTP id
 v30-20020a81b71e000000b006076ad38746mr1426818ywh.46.1708677498211; 
 Fri, 23 Feb 2024 00:38:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a05622a049400b0042c6ec8247bsm6174121qtx.94.2024.02.23.00.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 00:38:17 -0800 (PST)
Message-ID: <c12ba73f-5eeb-47b7-bd16-cf686f13d108@redhat.com>
Date: Fri, 23 Feb 2024 09:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] virtio-iommu: Change the default granule to the
 host page size
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240223074459.63422-1-eric.auger@redhat.com>
 <20240223074459.63422-4-eric.auger@redhat.com>
 <bdab51cf-fca8-4fe7-9e47-31bd10259dfa@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <bdab51cf-fca8-4fe7-9e47-31bd10259dfa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/23/24 09:08, Philippe Mathieu-Daudé wrote:
> Hi Eric,
>
> On 23/2/24 08:27, Eric Auger wrote:
>> We used to set the default granule to 4KB but with VFIO assignment
>> it makes more sense to use the actual host page size.
>>
>> Indeed when hotplugging a VFIO device protected by a virtio-iommu
>> on a 64kB/64kB host/guest config, we current get a qemu crash:
>>
>> "vfio: DMA mapping failed, unable to continue"
>>
>> This is due to the hot-attached VFIO device calling
>> memory_region_iommu_set_page_size_mask() with 64kB granule
>> whereas the virtio-iommu granule was already frozen to 4KB on
>> machine init done.
>>
>> Set the granule property to "host" and introduce a new compat.
>>
>> Note that the new default will prevent 4kB guest on 64kB host
>> because the granule will be set to 64kB which would be larger
>> than the guest page size. In that situation, the virtio-iommu
>> driver fails on viommu_domain_finalise() with
>> "granule 0x10000 larger than system page size 0x1000".
>>
>> In that case the workaround is to request 4K granule.
>>
>> The current limitation of global granule in the virtio-iommu
>> should be removed and turned into per domain granule. But
>> until we get this upgraded, this new default is probably
>> better because I don't think anyone is currently interested in
>> running a 4KB page size guest with virtio-iommu on a 64KB host.
>> However supporting 64kB guest on 64kB host with virtio-iommu and
>> VFIO looks a more important feature.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   hw/core/machine.c        | 1 +
>>   hw/virtio/virtio-iommu.c | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 70ac96954c..38851df4b8 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -35,6 +35,7 @@
>>     GlobalProperty hw_compat_8_2[] = {
>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
>> +    { TYPE_VIRTIO_IOMMU_PCI, "granule", "4K" },
>
> IIUC the current value is qemu_target_page_mask(), not 4KiB.
> Could this be an issue for arm / mips / mips / sparc64 guests?
The virtio-iommu currently is only supported on ARM and x86 where
qemu_target_page_mask() corresponds to a 4K granule. So I don't think it
makes any issue.

Thanks

Eric
>
>>   };
>>   const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>>   diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 0461b87ef2..e9e44a8ad8 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1558,7 +1558,7 @@ static Property virtio_iommu_properties[] = {
>>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>>       DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>>       DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
>> -                             GRANULE_MODE_4K),
>> +                             GRANULE_MODE_HOST),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>


