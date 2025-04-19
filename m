Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB799C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 06:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6286-0003rc-ND; Sat, 19 Apr 2025 02:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6283-0003ly-Lv
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 02:56:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6280-0008Ga-5X
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 02:56:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c33677183so29515275ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745045798; x=1745650598;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gYgOc/1GkS+rgUKH6Y0bpgzgkVtAbzeGiDwI5Vjz/ak=;
 b=JbS42H/dAv1qksw7Bx3D7XIYwOTaZvrQkK/Wt4TURzw/AzotE3NwYy2boxj5NkdLSZ
 v1zHo07UCT5pTDtV20MduYWW1q8EuLsMSm5nNACvgkxETU4ps17EZSv6YdzwnDYYJVAB
 dB5oRyp684T6VE2BGTOwCfFCT5irVtY/ho2KAMPjbOPOadvbxtj789qNWndg2JuK4/iy
 Fb8j1sforHKQLo2ocfH6YdvlIf3UTpFkr9rmSzeGIxMxZzM575BXmsl03/78MZGSWLv/
 7iEi10EkIX5iROOHoVLGSQg4RQHtYzvugpmi4Gs/ctQpApMFiuCmaRPV0Y18ujIPqlA+
 UzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745045798; x=1745650598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYgOc/1GkS+rgUKH6Y0bpgzgkVtAbzeGiDwI5Vjz/ak=;
 b=CkQ6u7374rs28nYVrcRxQJIWAddCPWWmzWlz9pc8FR5OmTV3HZyYrh3TlzsJzd8w3T
 v360RZYkDEi5NJzoHW9vNplBVsKHbLhr0WTn7m/AoRdGgaJ4GBuf1fXlOmLrxWVuF4fc
 hORjUZ75r5nb/wSfmV2S1ZlRuZGbYqM3oMKq8aKX8yBRgI0fIq4MJkyTKSckCHHc65Ko
 Rv+A6boXBFQETS6bUp4PfKArjoG2c0w33NtBgAU2O0z/xWc2+acGR3Q4NXE85NU/1IsN
 MFddFW0Gm5uSZiQSPYaS6J1YXtmqcrOg+BycU+2O1FBuns+aWbhBjjLK8oPasfVLVLKA
 bpiA==
X-Gm-Message-State: AOJu0Yzl4t8yCmX3evYW6J6MzaLMmifbHm7di2AoxStroCHGK/zPL8hs
 E1te987llnUKoHkDr7EU2cOE57HRwMhNwdPj1uojYIGzpaP7WxcofG2B2SmDWU4=
X-Gm-Gg: ASbGncvW4rxXHrLz2gJsKqQ7rN7kQCbt2t5F8M5xS3mVZLY9K8GXw2uKP6Fd6JzlIRD
 i4n/XiT7uxLHiZyn5BX3Vu/dIEYNqjsidQ5Y4ZOcGhtgOfTJ159jsQUkTDbsWouHMun1Nm2L5na
 wZWu3aKtmbwJ8C2EWYJ9aILUxbfGwoKNc1uNePnEsKZ/zqSpBzQjT5LRr2go+g/yQdZo8ddmt5J
 na73PcqCUDscNEmU5FqW7VcbVUzqVlMoansYm0ietuWb3xzCtSOQC6owPlMKkPIBhd0LUIC6w2I
 ag6SMPnxpB/CiD/RW3o1Z+EmEIDb5wYznRyRDIqmkIQB4FJRhMUroctAN7HPh1gjAsRhxW1IAU6
 R2iN/IarybxOcbV9P0o8=
X-Google-Smtp-Source: AGHT+IGtSI3rPWPte0OzQUeVj1Y1nfSLRmWDpxJRQV/aJUXBJs5HyRtyJrq7znGr5o78SYG8gPWe0w==
X-Received: by 2002:a17:902:e80e:b0:224:e0f:4b5 with SMTP id
 d9443c01a7336-22c53573cd7mr66123745ad.7.1745045797931; 
 Fri, 18 Apr 2025 23:56:37 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb48ebsm27265045ad.122.2025.04.18.23.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 23:56:37 -0700 (PDT)
Message-ID: <f67a4bd1-9d81-4e81-84a8-8f7e519926b9@daynix.com>
Date: Sat, 19 Apr 2025 15:56:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@daynix.com, qemu-stable@nongnu.org
References: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
 <su2au5bn77cjz64dgsd4by5atjlbun54467c2srdcmgoyeefpw@xym6ucphqa2d>
 <0a2611ae-93b0-48d6-ae89-02ab50339946@daynix.com>
 <pssex66ivae3kkxo7rwxo2mnroit7zpnirxis6eu56b2scaj3h@2flhgmzcxvy6>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <pssex66ivae3kkxo7rwxo2mnroit7zpnirxis6eu56b2scaj3h@2flhgmzcxvy6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/04/11 22:20, Antoine Damhet wrote:
> On Fri, Apr 11, 2025 at 05:01:01PM +0900, Akihiko Odaki wrote:
>> On 2025/04/07 17:29, Antoine Damhet wrote:
>>> On Sat, Apr 05, 2025 at 05:04:28PM +0900, Akihiko Odaki wrote:
>>>> The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
>>>> buffer") was to remove the need to patch the (const) input buffer with a
>>>> recomputed UDP checksum by copying headers to a RW region and inject the
>>>> checksum there. The patch computed the checksum only from the header
>>>> fields (missing the rest of the payload) producing an invalid one
>>>> and making guests fail to acquire a DHCP lease.
>>>>
>>>> Fix the issue by copying the entire packet instead of only copying the
>>>> headers.
>>>>
>>>> Fixes: 7987d2be5a8b ("virtio-net: Copy received header to buffer")
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> Tested-By: Antoine Damhet <adamhet@scaleway.com>
>>>
>>>> ---
>>>> This patch aims to resolves the issue the following one also does:
>>>> https://lore.kernel.org/qemu-devel/20250404151835.328368-1-adamhet@scaleway.com
>>>>
>>>> The difference from the mentioned patch is that this patch also
>>>> preserves that the original intent of regressing change, which is to
>>>> remove the need to patch the (const) input buffer with a recomputed UDP
>>>> checksum.
>>>>
>>>> To Antoine Damhet:
>>>> I confirmed that DHCP is currently not working and this patch fixes the
>>>> issue, but I would appreciate if you also confirm the fix as I already
>>>> have done testing badly for the regressing patch.
>>>
>>> Thanks for the swift response, ideally I'd like a non-regression test in
>>> the testsuite but a quick test showed me that I couldn't easily
>>> reproduce with user networking so unless someone has a great idea it
>>> would be a pain.
>>>
>>>> ---
>>>>    hw/net/virtio-net.c | 35 ++++++++++++++++-------------------
>>>>    1 file changed, 16 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index de87cfadffe1..a920358a89c5 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -1687,6 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
>>>>        virtio_tswap16s(vdev, &hdr->csum_offset);
>>>>    }
>>>> +typedef struct Header {
>>>> +    struct virtio_net_hdr_v1_hash virtio_net;
>>>> +    uint8_t payload[1500];
>>>> +} Header;
>>>> +
>>>>    /* dhclient uses AF_PACKET but doesn't pass auxdata to the kernel so
>>>>     * it never finds out that the packets don't have valid checksums.  This
>>>>     * causes dhclient to get upset.  Fedora's carried a patch for ages to
>>>> @@ -1701,7 +1706,7 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
>>>>     * we should provide a mechanism to disable it to avoid polluting the host
>>>>     * cache.
>>>>     */
>>>> -static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
>>>> +static void work_around_broken_dhclient(struct Header *hdr,
>>>>                                            size_t *hdr_len, const uint8_t *buf,
>>>>                                            size_t buf_size, size_t *buf_offset)
>>>>    {
>>>> @@ -1711,20 +1716,20 @@ static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
>>>>        buf += *buf_offset;
>>>>        buf_size -= *buf_offset;
>>>> -    if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
>>>> -        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
>>>> +    if ((hdr->virtio_net.hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
>>>> +        (buf_size >= csum_size && buf_size < sizeof(hdr->payload)) && /* normal sized MTU */
>>>>            (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
>>>>            (buf[23] == 17) && /* ip.protocol == UDP */
>>>>            (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
>>>> -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
>>>> -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
>>>> -        hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
>>>> -        *hdr_len += csum_size;
>>>> -        *buf_offset += csum_size;
>>>> +        memcpy((uint8_t *)hdr + *hdr_len, buf, buf_size);
>>>> +        net_checksum_calculate((uint8_t *)hdr + *hdr_len, buf_size, CSUM_UDP);
>>>> +        hdr->virtio_net.hdr.flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
>>>> +        *hdr_len += buf_size;
>>>> +        *buf_offset += buf_size;
>>>>        }
>>>>    }
>>>> -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
>>>> +static size_t receive_header(VirtIONet *n, Header *hdr,
>>>>                                 const void *buf, size_t buf_size,
>>>>                                 size_t *buf_offset)
>>>
>>> `receive_header` can now "receive" the whole packet that's kinda
>>> misleading. I though another approach would be to only do the
>>> detection/flag patching from receive_header and recompute the checksum
>>> directly in the final `iov`, this would also eliminate the extra payload
>>> copy.
>>
>> It is possible to avoid copying but I chose not to do that because this is
>> not a hot path and the code complexity required for that does not look
>> worthwhile for me.
> 
> Understood and OK.
> 
>>
>> But I agree that the names of receive_header() and Header structure are
>> misleading. The reasoning I used to convince myself is that the "Header" is
>> at the head of the packet at least. I'd like to hear if you have an idea of
>> better naming; otherwise I would rather leave it as is.
> 
> Maybe we can sidestep this entirely, do we need to do the workaround
> _inside_ `receive_header` ? WDYT of the following pseudocode:
> 
> ```
> guest_offset = receive_header(&header);
> iov_from_buf(&header);
> work_around_broken_dhclient(&header, &payload);
> iov_from_buf(&payload);
> ```

net_checksum_calculate() currently needs a contiguous buffer so it needs 
to be changed and it also requires one additional iov_from_buf() call. 
It's a bit too complicated to workaround the naming problem I think.

> 
> If not maybe something along the line of "PacketPrefix" or
> "PacketStart".

Now I'm inclined for "PacketPrefix". In a normal context, "prefix" and 
"start" are no different from "header", but in the networking context, 
"header" is frequently used to describe the metadata and implies it 
doesn't contain data. Usually I don't like to choose wordings according 
to such an implied nuance, but avoiding the word "header" here has a 
practical value.

I'll probably choose "prefix" instead of "start" since it sounds more 
specific than "start".

Regards,
Akihiko Odaki

> 
> Regards,
> 


