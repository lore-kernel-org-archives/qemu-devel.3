Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC6C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39K9-00069L-In; Fri, 11 Apr 2025 04:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u39K4-0005qY-C5
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:01:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u39Jy-0004Ei-Kv
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:01:11 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-226185948ffso18472295ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744358464; x=1744963264;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBAxy9dfYALpet6u6DVdO4HlIrEY3tMVoVQPB29GNHQ=;
 b=GA0yrz5vXJ5DOWFcxMW3qgZ7HEpE4zax5LVbAgbYO8YTDmCDDHCP91KYzflIDsDtI+
 aP3CuskWdrhsQ0eNQOJq8nEKegKiEPeKMudHVBqPTatZ1N72m3FeNjKo3qBvhIDQYSnp
 u9xYPJ4uRa/pFI/KBDX766RXS38xjSjQ6KZIpD8bLwnMTRWTssfePED5XY++fzG31Or0
 np+hDV088cXaQM3Jp3V+xEj4mERDHW9hxlLdkiJCUnZIyjANP4zTIzCgz03fkL267qcP
 nfNlICWvePVrvC7j8MI3Fu1BwwhhRjyYe1DL99WNrr8//KPzJbo2ycRw0MwUP/Kvyhwt
 uKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358464; x=1744963264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBAxy9dfYALpet6u6DVdO4HlIrEY3tMVoVQPB29GNHQ=;
 b=onNiGrtSWzmJuWSaSQ5tvfn2uiTsxLBmifrLeyWIcyEjVlf7KYDbsz7keJdBMENI8e
 dHaiSN069BIEbCm2wT7t1p+NNj1aSxGCS4H133YO327MOhq5gA7YGDVpUH0J8+QLBp26
 gisZM/egU6EAYaL5GWeKo5F2HhpM6tOoroX40Itr9iJnxexRP31fE64moVDxDjqruLBK
 E8THxKYco5ygcpfYHtCAfqMpfkFWRiAxQAHw+b3q7o4vZA6zTacwbiEbPH/m+RES1Vp8
 xyvfGn4rowKQobyKvAc6y2hJgRf8z8AFr27mQF2QnBGlCOhKyMj6wOtV4JHJxAEyKSCB
 XS4Q==
X-Gm-Message-State: AOJu0YzHXy9JFnanfQhrEw21fl/jy9Mg9AwPQ1kiQX5K5riq/3cNXfxL
 IMF2mgv/Wik56ztQAHqyTb5BQdYeIvtRPjR3w5WAU6+isYlFdbG+q6uC7dbp5EU=
X-Gm-Gg: ASbGnctRLi2kwP3pMJ7jqw6FD+tIkQznz2jtqLm4GU9bVnqGfUGLEd/98qab6wUeh9A
 AsQgJF+MMMdeT3759Wl93ipXUDGepaqAlD4t8uFYz0+eMcyiorSmsv+IROB2OywMLcYT0MMg9zX
 PLx5Nh2YseiMq6Bc2CZfwgnbhEpJfCt/0K49KcQVN3K7sqtZ8WoIx7N91bjOk6Bag1LyYJw6oW1
 xiaFqIiYU0ZZ1mMsVe4HBh2ug7wWdc688EAgdFB0Lwy669BqHZJupYAzorcB91jJK+ely1UIMjx
 V7t4DwNNWTQI3m44tIxh2GCpmgd0P7vWec4Or3CYTIHkRARBRM6J1dT5PlWkPIq9
X-Google-Smtp-Source: AGHT+IF57BXWDZrqhhhtFjYlqZs62w/DxyC5IRZak8nQ3S+ORpqCeYx/URCP3pFjt9okFaPI2HGO2A==
X-Received: by 2002:a17:902:d542:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22bea4afa98mr29965245ad.22.1744358464513; 
 Fri, 11 Apr 2025 01:01:04 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccac49sm43030115ad.217.2025.04.11.01.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 01:01:04 -0700 (PDT)
Message-ID: <0a2611ae-93b0-48d6-ae89-02ab50339946@daynix.com>
Date: Fri, 11 Apr 2025 17:01:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@daynix.com, qemu-stable@nongnu.org
References: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
 <su2au5bn77cjz64dgsd4by5atjlbun54467c2srdcmgoyeefpw@xym6ucphqa2d>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <su2au5bn77cjz64dgsd4by5atjlbun54467c2srdcmgoyeefpw@xym6ucphqa2d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2025/04/07 17:29, Antoine Damhet wrote:
> On Sat, Apr 05, 2025 at 05:04:28PM +0900, Akihiko Odaki wrote:
>> The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
>> buffer") was to remove the need to patch the (const) input buffer with a
>> recomputed UDP checksum by copying headers to a RW region and inject the
>> checksum there. The patch computed the checksum only from the header
>> fields (missing the rest of the payload) producing an invalid one
>> and making guests fail to acquire a DHCP lease.
>>
>> Fix the issue by copying the entire packet instead of only copying the
>> headers.
>>
>> Fixes: 7987d2be5a8b ("virtio-net: Copy received header to buffer")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Tested-By: Antoine Damhet <adamhet@scaleway.com>
> 
>> ---
>> This patch aims to resolves the issue the following one also does:
>> https://lore.kernel.org/qemu-devel/20250404151835.328368-1-adamhet@scaleway.com
>>
>> The difference from the mentioned patch is that this patch also
>> preserves that the original intent of regressing change, which is to
>> remove the need to patch the (const) input buffer with a recomputed UDP
>> checksum.
>>
>> To Antoine Damhet:
>> I confirmed that DHCP is currently not working and this patch fixes the
>> issue, but I would appreciate if you also confirm the fix as I already
>> have done testing badly for the regressing patch.
> 
> Thanks for the swift response, ideally I'd like a non-regression test in
> the testsuite but a quick test showed me that I couldn't easily
> reproduce with user networking so unless someone has a great idea it
> would be a pain.
> 
>> ---
>>   hw/net/virtio-net.c | 35 ++++++++++++++++-------------------
>>   1 file changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index de87cfadffe1..a920358a89c5 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -1687,6 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
>>       virtio_tswap16s(vdev, &hdr->csum_offset);
>>   }
>>   
>> +typedef struct Header {
>> +    struct virtio_net_hdr_v1_hash virtio_net;
>> +    uint8_t payload[1500];
>> +} Header;
>> +
>>   /* dhclient uses AF_PACKET but doesn't pass auxdata to the kernel so
>>    * it never finds out that the packets don't have valid checksums.  This
>>    * causes dhclient to get upset.  Fedora's carried a patch for ages to
>> @@ -1701,7 +1706,7 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
>>    * we should provide a mechanism to disable it to avoid polluting the host
>>    * cache.
>>    */
>> -static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
>> +static void work_around_broken_dhclient(struct Header *hdr,
>>                                           size_t *hdr_len, const uint8_t *buf,
>>                                           size_t buf_size, size_t *buf_offset)
>>   {
>> @@ -1711,20 +1716,20 @@ static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
>>       buf += *buf_offset;
>>       buf_size -= *buf_offset;
>>   
>> -    if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
>> -        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
>> +    if ((hdr->virtio_net.hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
>> +        (buf_size >= csum_size && buf_size < sizeof(hdr->payload)) && /* normal sized MTU */
>>           (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
>>           (buf[23] == 17) && /* ip.protocol == UDP */
>>           (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
>> -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
>> -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
>> -        hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
>> -        *hdr_len += csum_size;
>> -        *buf_offset += csum_size;
>> +        memcpy((uint8_t *)hdr + *hdr_len, buf, buf_size);
>> +        net_checksum_calculate((uint8_t *)hdr + *hdr_len, buf_size, CSUM_UDP);
>> +        hdr->virtio_net.hdr.flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
>> +        *hdr_len += buf_size;
>> +        *buf_offset += buf_size;
>>       }
>>   }
>>   
>> -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
>> +static size_t receive_header(VirtIONet *n, Header *hdr,
>>                                const void *buf, size_t buf_size,
>>                                size_t *buf_offset)
> 
> `receive_header` can now "receive" the whole packet that's kinda
> misleading. I though another approach would be to only do the
> detection/flag patching from receive_header and recompute the checksum
> directly in the final `iov`, this would also eliminate the extra payload
> copy.

It is possible to avoid copying but I chose not to do that because this 
is not a hot path and the code complexity required for that does not 
look worthwhile for me.

But I agree that the names of receive_header() and Header structure are 
misleading. The reasoning I used to convince myself is that the "Header" 
is at the head of the packet at least. I'd like to hear if you have an 
idea of better naming; otherwise I would rather leave it as is.

Regards,
Akihiko Odaki

> 
> Cheers,
> 


