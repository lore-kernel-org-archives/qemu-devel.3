Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ED3C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpOL8-0004kJ-W3; Thu, 30 Jul 2026 06:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wpOL7-0004i6-L1
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wpOL6-00004y-9J
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785408611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WqsPoxEJw0yP4OhfLRrCTDEL9RtNQ3K51WKgVzFOz+A=;
 b=TvOihGic87RH9YI/ZTvBPCNvBvXwLxT5859n0X4UitEr/z4loimhEgP1Qxlg3FNrAv1n6Z
 Koj3QC04v2vj4ekIoJpv6hyngvlgvCCVz5kMLoT1X/Fjr9Hv15CHPcPVQZqn4M13sU/yCY
 LllQr2ulKchv73J9G/D30+ZSR1YMBmo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-w356ceR4NiSWWNez3KBLKA-1; Thu, 30 Jul 2026 06:50:07 -0400
X-MC-Unique: w356ceR4NiSWWNez3KBLKA-1
X-Mimecast-MFC-AGG-ID: w356ceR4NiSWWNez3KBLKA_1785408606
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso13813635e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785408606; x=1786013406; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WqsPoxEJw0yP4OhfLRrCTDEL9RtNQ3K51WKgVzFOz+A=;
 b=sX8qRZJJkSHZOnQeklKhEmcsc0f7kuWpcxb1C6wyMf/uDv1be8vPc1zQpxkh+fD5oj
 yl/tF9G6Da9AL2GtOpkTZrbn8fpmwCFt44HgSJIPScG+N0uJoAoG9TKp+xCFqsQhA1wk
 yjuwMrROC+/gFsjH62MElylyiY1EaXFPpxaC5pyZepbLDtDy1Ply6GK/HnU6XvqvScAb
 3EfK9PJCKN74+w8fEVlDcrP9T1wts/JqTp9fXeIqw7g5ic7d/V7fC0+j+hh1hjAy16MZ
 Ylk0DVgL1ENqL8MXEVqAtAr6f+gjJmAPrwrUvi1lEKtg7jSSoccS4CUj+dB0JPnqrd/0
 3klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785408606; x=1786013406;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqsPoxEJw0yP4OhfLRrCTDEL9RtNQ3K51WKgVzFOz+A=;
 b=NvlkPXfy6Hgq2XH7N3q8Yr8Iwu/gh70n9jQDbWfRrlbK6KVzk+73Gt5XNZeKwt5Q1n
 2PLK0j5MiotIIBEb/iyosLJ9tixW6y7A1Q0BgBJi/42+Stq36PhZrcmzhyJkjirwguCH
 fZ98BHTi1MyVJn56445l/pSdxUEaJ1NkDAapAFa5psIjg6xxlzfqMKh1UZnHx7gkaO5H
 jenxswWHHPzg13eZZhXeUu43OlMZu0Y1EnRkDHvUTGoqFPO1NIIfKiJv9s+3+8b30URp
 cgKnXU8Fhv2uuFnA8MI9vlY12JxAg2uZkflyQL9ddMqSawon4hrHyuMZZXkROHPx6Hwc
 cPJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU0V890r/o1h8Ik9RjyW47XTffJMZ3SmnRv2Zx7pLcnqoC3PIvzFSVA6woBaU0of75xNcpk7ovNFCP@nongnu.org
X-Gm-Message-State: AOJu0Yz5u6I3/Cn+3uwZrTsESF3ge6VdylzRhh7lC2VOs9tG1avSz2EP
 daJD7zrxto1yDC36xBO8QxYCy1HSFEMeGF17oj+MUyMVngJe3CvhqpQZHHC7GY/mThhD6WK/dY8
 2mdWKBIyVdQYFfwo84AK4167cR/QjyKCiNGRRxpaF9C7T9+sr7IaUyqCi
X-Gm-Gg: AR+sD11byl/vcTvLYu3nglPKLqvsGh+TmY7IcFeF0lISEoUkhiAFh02P+Xcc4WMORDh
 6MdW/mapKB6/TplE7ISO8jEsF+Nn67XFuAmU/i2OjKWV6WHOVpVvMjEfKL4vtNQ5sav+f10mES1
 /ZU0pxtWUyAniF3G/JPa1BwCtcn7StJkAkgV627gnaQfks9ovWZstR8IPfoYYUsULq2p9Oqc08o
 CZxUgKj27F/oRKypQgog9HADw/5k5B+3cVzSgM/GHRSGrIyecSSLT5qqtph7V8BHbxSrAGn/GvC
 nAjDaU+JCHJdpMAug3ajvFwXNkxByWg4d49WGz3EDX467Kf52vpis/8fUZ8J1KfM0Gn9whbRsRp
 j4DgvMhfftT4DFRgpuZRYXbFnCS3U7TGnS7r0SG4=
X-Received: by 2002:a05:600c:628f:b0:495:4a34:16e1 with SMTP id
 5b1f17b1804b1-49800eadaf7mr27610655e9.23.1785408606502; 
 Thu, 30 Jul 2026 03:50:06 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:495:4a34:16e1 with SMTP id
 5b1f17b1804b1-49800eadaf7mr27610085e9.23.1785408605889; 
 Thu, 30 Jul 2026 03:50:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cc6asm5814809f8f.18.2026.07.30.03.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 03:50:05 -0700 (PDT)
Message-ID: <3da739fb-cc3e-42ed-ae7c-46afa38151ab@redhat.com>
Date: Thu, 30 Jul 2026 12:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, philmd@oss.qualcomm.com,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260728031731.286666-1-gshan@redhat.com>
 <20260728031731.286666-3-gshan@redhat.com>
 <20260729182316-mutt-send-email-mst@kernel.org>
 <CAFEAcA8nxsXNPuqOoc4DGnHbCKQ-pBJib4JhXnYkzMg79GMfAA@mail.gmail.com>
 <20260730062155-mutt-send-email-mst@kernel.org>
 <CAFEAcA_xWqomb6jPf_9RmAfaf77uHajMkQk4biOcK3xR+Rgunw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA_xWqomb6jPf_9RmAfaf77uHajMkQk4biOcK3xR+Rgunw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/30/26 12:34, Peter Maydell wrote:
> On Thu, 30 Jul 2026 at 11:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Jul 30, 2026 at 10:24:32AM +0100, Peter Maydell wrote:
>>> The idea is rather just to ignore the unaligned-access-to-not-RAM
>>> case as "only a theoretical issue" and default it to memmove().
>>> If anybody reports an actual problem we can think about it then :-)
> 
>> Well given the only reported case of virtio DMA into vfio memory we have is
>> GH100 and that one is mapped MT_NORMAL, I'm fine with that.
> 
>> I feel extending vfio to report the mapping type to userspace might
>> not be a bad idea down the road, though. "Directly accessible"
>> is a very rough approximation to the rich variety of mappings
>> available across architectures.
> 
> Yes, this sounds like a good longer term idea. If userspace doesn't
> have a way to know what the mapping behind something it's mmap()ed
> is then it can't know what operations it can and can't safely do.
> 
Gavin, didn't you have the idea of using a VFIO region caps for that ?

This is similar to what we did on POWER9 with :

    VFIO_REGION_INFO_CAP_NVLINK2_SSATGT

which exported GPU RAM to the userspace too.

Thanks,

C.


