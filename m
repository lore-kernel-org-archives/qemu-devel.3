Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C578CE7AF1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 09:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVAv-0007ET-UV; Fri, 06 Sep 2024 05:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1smVAu-0007Dz-TY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1smVAt-00046o-8M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725614557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gTL/zi1pE2EZCVLY84lKbuTmQLTP3wrqBisJnPrMb9Q=;
 b=OPHxwsV6Fvc3GO36WzgCwddvxjW+s2fREo8OnGnKJrpJz9d3evgKrvNTo5/Q8vj20qWl4G
 voNWYx6M3CTvsLi+lSAOLErvx8ml1ksjBssHNktNqXo8oqjso4gXsG9EzlVfVhuyqN+7im
 UPGWsd6PPVqO5PaPa1/uj/RlRPPZU+0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-aM3xah7MN4WGG3in05yeog-1; Fri, 06 Sep 2024 05:22:35 -0400
X-MC-Unique: aM3xah7MN4WGG3in05yeog-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374c90d24e3so1380596f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 02:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725614554; x=1726219354;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTL/zi1pE2EZCVLY84lKbuTmQLTP3wrqBisJnPrMb9Q=;
 b=gc7z+/I7C9TwIoET8TmjvbY4CwmI6cJ1P7O9zRouCGru/BX72XzvKu/x5iMbuWs6PW
 sfml0EtuZc4h7h6BH6q13nCWLlCqhE3BXN36yCQ9YEIg24lqAmDmuGrtheQXD6FT2FkU
 AytS0p+1UgzNIzLwOnIIg97e3cmIHhmz6dmJ23QAzBYMOlyyUVtDqYbR20iOdmX497yz
 11BVChZUYyWsjq6fL6fVPqe9XjP5iPMePDAlyRrVu5AoSDCVov1Yh1EM5za/xRFDNxm0
 kCyjmERJXXvfgQ1CVOnnjqiSNfozKg6AU4Y5HXpCKnLjptTJkcFxijMNYDcyyjnoQfuW
 WL1Q==
X-Gm-Message-State: AOJu0YxhuIHGedpm66/2dEATcMkFqhxrG6W7ZLC5gKGs1XkjQtVrc/wO
 uXge5ndlUHYWuZJa8FtlSplTCdwCseUo/q+DTW79d31T3VlTT3DsDaR18IysZOAFzN+uec1mG2w
 YVETa0tbPDs1RLBgWfamyy/LHU+9uTE4jyWpMUyKbssDa/mCihX/f
X-Received: by 2002:adf:f387:0:b0:375:fe1e:22b9 with SMTP id
 ffacd0b85a97d-375fe1e22f0mr9113938f8f.62.1725614554625; 
 Fri, 06 Sep 2024 02:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9mVEOkKIjj6xXK4toXaKc+G/cRXHquCEnvd57VYhoNBSGMlJcD7HdeZq3c2tonFX/DB1HIw==
X-Received: by 2002:adf:f387:0:b0:375:fe1e:22b9 with SMTP id
 ffacd0b85a97d-375fe1e22f0mr9113880f8f.62.1725614553337; 
 Fri, 06 Sep 2024 02:22:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:5900:804e:d067:935d:cec9?
 (p200300cbc70d5900804ed067935dcec9.dip0.t-ipconnect.de.
 [2003:cb:c70d:5900:804e:d067:935d:cec9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374baae211bsm17319335f8f.66.2024.09.06.02.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 02:22:32 -0700 (PDT)
Message-ID: <94b8bd09-3ab7-48e5-b221-b1e7af28a201@redhat.com>
Date: Fri, 6 Sep 2024 11:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: kconfig: memory devices are PCI only
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20240906073737.493254-1-pbonzini@redhat.com>
 <be6dfcb4-b1a4-4dff-a08b-e79e303960dd@redhat.com>
 <CABgObfYbnsfxVHHTWkHU-eWFHMMCv-80OzqvLBrbznHpzD2+BQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABgObfYbnsfxVHHTWkHU-eWFHMMCv-80OzqvLBrbznHpzD2+BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06.09.24 10:18, Paolo Bonzini wrote:
> On Fri, Sep 6, 2024 at 9:40 AM David Hildenbrand <david@redhat.com> wrote:
>> On 06.09.24 09:37, Paolo Bonzini wrote:
>>> Virtio memory devices rely on PCI BARs to expose the contents of memory.
>>> Because of this they cannot be used with virtio-mmio or virtio-ccw.  In fact
>>
>> Guess what I am working on at this very the moment ;)
> 
> Ok, then hardcoding VIRTIO_PCI is not nice.
> 
>>> @@ -45,7 +46,7 @@ config VIRTIO_PMEM_SUPPORTED
>>>    config VIRTIO_PMEM
>>>        bool
>>>        default y
>>> -    depends on VIRTIO
>>> +    depends on VIRTIO_PCI
>>
>> depends on VIRTIO_MD ?
> 
> No, because VIRTIO_MD is "default n" (and anyway you don't want to
> enable it by hand in the --without-default-devices case).

Right, that's what I originally tried to achieve.

> 
> But something like this could be a good alternative if you plan to
> support virtio-ccw as well:
> 
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index aa63ff7fd41..253e7d3f90a 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -16,6 +16,7 @@ config VIRTIO_PCI
>       default y if PCI_DEVICES
>       depends on PCI
>       select VIRTIO
> +    select VIRTIO_MD_SUPPORTED
> 
>   config VIRTIO_MMIO
>       bool
> @@ -35,8 +36,14 @@ config VIRTIO_CRYPTO
>       default y
>       depends on VIRTIO
> 
> +# not all virtio transports support memory devices; if none does,
> +# no need to include the code
> +config VIRTIO_MD_SUPPORTED
> +    bool
> +
>   config VIRTIO_MD
>       bool
> +    depends on VIRTIO_MD_SUPPORTED
>       select MEM_DEVICE
> 
>   config VIRTIO_PMEM_SUPPORTED
> @@ -46,6 +51,7 @@ config VIRTIO_PMEM
>       bool
>       default y
>       depends on VIRTIO
> +    depends on VIRTIO_MD_SUPPORTED
>       depends on VIRTIO_PMEM_SUPPORTED
>       select VIRTIO_MD
> 
> @@ -57,6 +63,7 @@ config VIRTIO_MEM
>       default y
>       depends on VIRTIO
>       depends on LINUX
> +    depends on VIRTIO_MD_SUPPORTED
>       depends on VIRTIO_MEM_SUPPORTED
>       select VIRTIO_MD
> 
> 
> and then you just need to select VIRTIO_MD_SUPPORTED from VIRTIO_CCW.

Sounds good.

> In the case of PCI there is some board support code as well, which is
> why VIRTIO_{MEM,PMEM}_SUPPORTED is selected from "config PC", but
> perhaps in the s390 code you can select those three from VIRTIO_CCW as
> well.

Yes, only VIRTIO_MEM_SUPPORTED for now.

> 
> If this looks good I'll send it as v2.


Thanks!

-- 
Cheers,

David / dhildenb


