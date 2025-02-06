Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC67C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5KH-0003ot-22; Thu, 06 Feb 2025 12:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg5KD-0003dy-VV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg5KB-0002yU-UI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738861556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fGfNVcJ8Fm15c2fGEraNBchhhgVWnCL1630vv05fTFQ=;
 b=Sa3irVhCwmEWvF/VFsFFT3JUz8N4ujg9nu84eMYpSsQDDqmUYd1OUqwsVcyj07lK19tVRB
 zI/c8yVqhoSmZOgpT4mUnlIpC4XrvXCUlIQnj/L3IeRU3en/w2FvDVL/I/tXr6Z6kSiNuK
 Z+lqoFDvrohaYmryENtUGwdIjJXoj28=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-yFGW1PUGMtaAzb_pgyggKQ-1; Thu, 06 Feb 2025 12:05:54 -0500
X-MC-Unique: yFGW1PUGMtaAzb_pgyggKQ-1
X-Mimecast-MFC-AGG-ID: yFGW1PUGMtaAzb_pgyggKQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dbdc2926eso654106f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738861553; x=1739466353;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGfNVcJ8Fm15c2fGEraNBchhhgVWnCL1630vv05fTFQ=;
 b=mW1op1TDKGf+zferVMrM5kQOpNsPo941cgp97mdB+/S/3hKrNE2gtXcEtSJ+zR2NrC
 /rnH/FDWUGBKmijUbltF1RHMfq2DjrEnHOpeP8GglA7K834H6KHMZNyFu+n2hC5KAEmq
 KGogx38+bLbwCQ/GUJnQOnUi3BV8I4MPfrVSF2Dbt/vQoW/ug1kbdM+un3I4PO81NjJW
 0QftdKuVZc+JwuBfOJK+I38PtkBXlFpWo/Bz74qojGPebvnyINMOOxyBi1PVjq1CckCP
 NoUnqfaU4ASu9JPe7s7nyMtITSb3vjEraAj+VgNSD+M4xQVdLEsp3zOP0hd3Rwv12IHe
 B/5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjyjQoPDOOTkZX6NzC+iCvJzBbooOQzvcbaPLROxdFjTG9Jr/dLbH49YYK7il99NzKR+iAVOXJPQz7@nongnu.org
X-Gm-Message-State: AOJu0Yyl0xDzlg4ylCDKQWD/yPGKeP+hxnWOswiej5i1xzdoythGci4C
 TIEWQAdXrFOsruQW/paYW1FJLBYepHOJOD4gfxNg3QptabDeLUdTaEk8I8S6XwQkgBGg7aisTcl
 cEkSDWN8t8DlPs0WMkg0Ww9GZ9N6WQDxe3Rhi6fqPcrv4MvpqHxMI
X-Gm-Gg: ASbGncv2EbDCJet/G4QMosLi9p+42pC341r1n1KXqWD1dDqa8Q4uiveJkdpH6aTS+x+
 S7//cU/bTQER9MFvWwBft3wjTGAEzu+VYwaH3K+VOfGElWVxEiQvUfgoOdpeMb+duXHeUlp4sdF
 ANzeoRtPKEvMd8kFR+VQnyA1PHujtBmbtBC2caXXiF6cHZjNacF2JvwaXenvyVg/yubF+q2lVq1
 QlqNpHsgUvEDwAa0kMR2ada1M/Qui8eyEUh4q0wIYajJAoqe4kds8w5M1ScQf0sf0TxIKJLRBPq
 In4mF1ruc6EVVfGbitzBNjFOt0DmuOW7p5Z2/JBA6W4=
X-Received: by 2002:a05:6000:1449:b0:38a:88e2:e6aa with SMTP id
 ffacd0b85a97d-38db48826e8mr6072739f8f.29.1738861553311; 
 Thu, 06 Feb 2025 09:05:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHttq3RXEr4i8yJpX9qk8iVX7fMUEGOArlV0toIdjE9p2NwEfU/ofRUeJGYOYBsrpJIO2JF4w==
X-Received: by 2002:a05:6000:1449:b0:38a:88e2:e6aa with SMTP id
 ffacd0b85a97d-38db48826e8mr6072678f8f.29.1738861552807; 
 Thu, 06 Feb 2025 09:05:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc4458d71sm1078327f8f.63.2025.02.06.09.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 09:05:52 -0800 (PST)
Message-ID: <86da512b-7287-4ac9-ac02-b226f7de71bd@redhat.com>
Date: Thu, 6 Feb 2025 18:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU address
 space width
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
 <20250130115800.60b7cbe6.alex.williamson@redhat.com>
 <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
 <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
 <22bb3017-1db3-4041-81f0-972568de1017@redhat.com>
 <2rywkwsowee2sqj7ss7uqceis25i5ohf3n2jbpgmy24mqxwtqb@u4o37jpf7fky>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2rywkwsowee2sqj7ss7uqceis25i5ohf3n2jbpgmy24mqxwtqb@u4o37jpf7fky>
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

On 2/6/25 08:54, Gerd Hoffmann wrote:
>>> Note that there is a 'guest-phys-bits' property for x86 CPUs, which is a
>>> hint for the guest what the usable address width is.  It was added
>>> because there are cases where the guest simply can't figure that it is
>>> not possible to use the full physical address space of the cpu.  There
>>> are some non-obvious limitations around 5-level paging.  Intel has some
>>> CPUs with phys-bits > 48 but only 4-level EPT for example.
>>>
>>> So one option to handle this is to make sure guest-phys-bits is not
>>> larger than the iommu width.
>>
>> Yes. This is what I am trying to do.
>>
>> Patch [1] returns X86_CPU(cs)->phys_bits. I was not sure which *phys*
>> property to use. If you think this is incorrect and not returning the
>> right information, I will change the proposal with guest-phys-bits.
> 
>> [1] https://lore.kernel.org/qemu-devel/20250130134346.1754143-8-clg@redhat.com/
> 
> Yes, guest-phys-bits should be used here (and the helpers renamed too
> for consistency, to avoid making all this more complex than it already
> is).

yep. I will do that in a dedicated series.

Thanks

C.


