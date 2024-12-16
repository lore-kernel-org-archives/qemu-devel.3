Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA8CE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEyx-0004dA-EX; Mon, 16 Dec 2024 12:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNEys-0004bq-5D
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNEym-00032U-Tb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734370439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yZHzgIhsDSX0r0/PZN1MN62AtrRvqt/hoxJ+tQHgo3A=;
 b=e9zy9Nx0RXCr1vlXTYTnfEsp/qioBikNhypC3wQOr2tmL36fPFsWG00+bAK0D12P5ANhfO
 LZi6puR3c+mSdugaTJO9tmfYz/WfOyrm735hmHK+ZGUum1ozRbJYsTKKe2H0AjydqZDHYX
 FDvbpuRWwwx68cPiRD+jQDgJ+1uWcls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-rBS8YAQONiu7mKPbTKZVVQ-1; Mon, 16 Dec 2024 12:33:57 -0500
X-MC-Unique: rBS8YAQONiu7mKPbTKZVVQ-1
X-Mimecast-MFC-AGG-ID: rBS8YAQONiu7mKPbTKZVVQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-388d1f6f3b2so631895f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734370436; x=1734975236;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZHzgIhsDSX0r0/PZN1MN62AtrRvqt/hoxJ+tQHgo3A=;
 b=HW13q02dgxAh2ByKGA63wZb33j1/Iyxy6Bx7s9hfl/iGNAMxL8G/8/TmUJabs3ZrEP
 GApIfyZloFDGvuBwsWR4dm2vKWtlmdKqsr9VchhuBpf1Ws+sIhGz7GFRHusCHk0hsFy9
 oSNbQk7MH1xBM2lkdPQ7Nsu5nSGFGkO6v78zx8PjZHVvXQm3crDwiI1TKBAqwZu1Qhdz
 xAoNXbNds84HjEOVCA0g91HzC2BWXXO6KKWMeY+K+PmZREMB/M6wR7sLQPJo0FHQ8R5o
 AWIl+HkuneUZEI+BlW1w6zqiYJzI2nM4dDHd9iJhjwyPjvtZ5hNKqs3gKOMM/wSSj18U
 uNRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbDcrVrUikJpm5M1agjgr5P1r2h86XoMiuuVnKS5dh49g1etup+0QXdlDH98kRoOjw6zDHW8RyFTEZ@nongnu.org
X-Gm-Message-State: AOJu0Yx5GPkFc8Hxbyrw1BMbpmurwDPrzO8zzHyUpJYTCh+JTqTJt9v4
 yufcKhHYXIgicb8N0peqawtQjK2lwSPp1dCBvw8/dj/bCuu1pAocmLIlZNM0TTcvQUo+hhRZ7Xm
 2aq9wl96PV+xVKY8HsaouhwHUxF7KVDayKeEsFIkCRMKrfxWGAvRN
X-Gm-Gg: ASbGncvzYjV1BFi2Cw5s1dPi60IBssRJz6tI1KA5fB/grLn7wcXK3FHGQ9v9zLHyCWa
 52WHcbPvO6l5JULBUJwcKiZNL87Hf2JXu9sg681butF0ryv/TcNFVBnxcUg6J+ozPi33TtWxiEr
 tkU3n1I8ZuZML9Y3zN2DNBYof/3zApacw6In1PfxxD+l9EPtK2PbMvMXvD3i5lVEG8NAbX1Dwbt
 90YNJhiLLQtIqdkcPnSbsOeAbdiwDSkN5OeGi39+zLqNWhneNyIhXm+6sVlEYdKk6iUlCFIVdU4
 EGGFpmzqIrrPSUg7zKQ=
X-Received: by 2002:a05:6000:796:b0:385:f5b6:9c9d with SMTP id
 ffacd0b85a97d-388da3b12f7mr395252f8f.33.1734370436059; 
 Mon, 16 Dec 2024 09:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA7vzxXyMWF96bptwBeNS8tLQrik5ch2fiHFf2ndybz5PN7eQp/Oq+Q6YCQNAHmldfTebgEg==
X-Received: by 2002:a05:6000:796:b0:385:f5b6:9c9d with SMTP id
 ffacd0b85a97d-388da3b12f7mr395229f8f.33.1734370435734; 
 Mon, 16 Dec 2024 09:33:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8011feesm8663094f8f.21.2024.12.16.09.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 09:33:55 -0800 (PST)
Message-ID: <3fdaf6c9-920a-46a5-8409-518022b17b04@redhat.com>
Date: Mon, 16 Dec 2024 18:33:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Joao Martins <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <934927b9-eaf5-411a-8151-7617218d0cad@oracle.com>
 <7d753d6e-a71c-4442-96e2-fbf1fd04133f@nvidia.com>
 <a0e99b1b-f708-4e08-aa14-9fddf7da6184@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a0e99b1b-f708-4e08-aa14-9fddf7da6184@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

Hello Joao,

On 12/16/24 16:37, Joao Martins wrote:
> On 16/12/2024 14:45, Avihai Horon wrote:
>> On 16/12/2024 14:00, Joao Martins wrote:
>>> On 16/12/2024 09:46, Avihai Horon wrote:
>>> I also have a much
>>> smaller series for that sort of unblockage that I can give you a pointer.
>>
>> Yes, if you have it at hand, that could be useful for testing next versions.
>>
>>> Though, eventually the optimizations we will do for VF dirty tracking for vIOMMU
>>> will apply to IOMMU HW too just so we minimize the amount of calls to get dirty
>>> bits.
>>>
>>>> I didn't test it with iommu DPT as I don't have access to such HW.
>>>> Cedric, I remember you said that you have such HW, it would be very
>>>> helpful if you could test it.
>>>>
>>> I am starting to prep the unblocking vIOMMU for Qemu 10, so I can validate if
>>> this series works as well -- but from what I have looked so far it should be all
>>> OK.
>>
>> Thanks, that wouldn't hurt :)
>>
>>> If it helps I have some pending series that lets you test emulated x86 IOMMU
>>> DPT support (either on intel-iommu or amd-iommu) that can help you when you
>>> don't have the hardware to test.
>>
>> That would be great, I didn't know such thing existed.
>>
> 
> I did post it, but it was some time ago (2y). While I got some comments, but
> failed to follow-up:
> 
> https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/#t
> 
> The link above has bugs, but let me conjure the version alongside vIOMMU and the
> other stuff I mentioned earlier.

Please Cc: me next time.

Thanks,

C.


