Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235EED1CDA7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38WG-0005dt-JJ; Tue, 22 Oct 2024 02:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t38WD-0005dh-1w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:37:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t38WA-0004re-Ml
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:37:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e49ef3b2bso3738626b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729579041; x=1730183841;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ZBllQQjWewARvqcRBKXGhR3bpw21WmTU9puF7K8wBA=;
 b=Y6SRUaM3NYg2/UvZGh15q/ZktTvEkDNZaYeBoAQQC7afFiVEKT2iQhpTy9vj342XcJ
 qpBWRI+VbOMzXhM3XBDUcb/59MnvN2FAHZfSEq2ic1HmUahLa/c3aAabxWQEh+bqxv0t
 WUXYRo2kM/lER15H909mHU7CXAYMXOmNvWzvCpdTpIWawuDKVsuiqkWlpOQ3ryZ2x41N
 bdSVLOrbw3CE8DxtiV2leFO7qWete6CIMevN+HLlPrZ/K5qCVzbQK8Fm/DsL7m6nBOVG
 o8rHr37/zZrw0xxQlZSQoSO4PEEpAg4muuNasvCQO/qNP3+D1+jieYYJb1uk8u+M00TX
 7w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729579041; x=1730183841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZBllQQjWewARvqcRBKXGhR3bpw21WmTU9puF7K8wBA=;
 b=hcS/SYKqux/+bwJzgW2pMIMrkE8QA5wZaNwcI/H3dR5fsykWnqsiOLL7YYhiaAB+X4
 giXomMyc4bbA8FeQg4QEvavf91raQGq+BCMDBg2pxLvqKvzo3gTwnCHslaTUIKbJaSjs
 Ny1NKyKj5Py7eiNeNGeRVlOF68QddfxtoGlwxmzlQhga/5d3Gc6DqAiv5nJMDBVlACf7
 75hOEVQ0KngjWZz9cpvZaw8ulrpq8uU0vE6iFG4y1LyEEOZgWElJQ/wy1qeReWcO1WMu
 mClNjwlZaDs5gAX/WdvXkKdO3x+AdE8WZlvtSKmHsFScqU7RNYpw2ce8PWmNN2HW8Ka+
 xAow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj7QfbrcNGiuZYcq/chtvnCSGzg/ZSHGveGipRjXPBMDUq6F/nupxdGWNsZJlJteCGhgZJ8VRmowB1@nongnu.org
X-Gm-Message-State: AOJu0YzCCriPrXLknD4C0Us+jDE2J8KNb4ovnlRR5uE48ZQMSQI8u6IF
 uwEHv+CEKAdeVjM4VAANa2/aRAr4PmNaLw0YwIG62Au4mhM7F3IeqjullVBYyrI=
X-Google-Smtp-Source: AGHT+IHxs05Ak44PRzp3fYeS8sobAITmBwdCJZMWN4xEkajQcFrDXoOXyf/NmHfyi1PGZXcF66prrA==
X-Received: by 2002:a05:6a20:2d27:b0:1d9:1af2:9697 with SMTP id
 adf61e73a8af0-1d96b89a174mr3160200637.47.1729579041111; 
 Mon, 21 Oct 2024 23:37:21 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5e225eb4asm651025a91.19.2024.10.21.23.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 23:37:20 -0700 (PDT)
Message-ID: <e5d99f4c-f2d7-42bd-be8d-4cf611c3f425@daynix.com>
Date: Tue, 22 Oct 2024 15:37:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] virtio-net: Copy received header to buffer
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
 <20240915-queue-v1-6-b49bd49b926d@daynix.com>
 <CACGkMEvT0ANv1XY24kQW6urJzA87fQ2DqgPHSUi=r8SREpanxA@mail.gmail.com>
 <CACGkMEvtNPQk9gU7KPsTN=4ghdiZWyV2feYpEj+_1uAGvrMvKw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvtNPQk9gU7KPsTN=4ghdiZWyV2feYpEj+_1uAGvrMvKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/21 17:22, Jason Wang wrote:
> On Mon, Oct 21, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Sun, Sep 15, 2024 at 9:07 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> receive_header() used to cast the const qualifier of the pointer to the
>>> received packet away to modify the header. Avoid this by copying the
>>> received header to buffer.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/net/virtio-net.c | 85 +++++++++++++++++++++++++++++------------------------
>>>   1 file changed, 46 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 3fc1d10cb9e0..ca4e22344f78 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -1685,41 +1685,44 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
>>>    * cache.
>>>    */
>>>   static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
>>> -                                        uint8_t *buf, size_t size)
>>> +                                        size_t *hdr_len, const uint8_t *buf,
>>> +                                        size_t buf_size, size_t *buf_offset)
>>>   {
>>>       size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
>>>                          sizeof(struct udp_header);
>>>
>>> +    buf += *buf_offset;
>>> +    buf_size -= *buf_offset;
>>> +
>>>       if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
>>> -        (size >= csum_size && size < 1500) && /* normal sized MTU */
>>> +        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
>>>           (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
>>>           (buf[23] == 17) && /* ip.protocol == UDP */
>>>           (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
>>> -        net_checksum_calculate(buf, size, CSUM_UDP);
>>> +        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
>>> +        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
>>>           hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
>>> +        *hdr_len += csum_size;
>>> +        *buf_offset += csum_size;
>>>       }
>>>   }
>>>
>>> -static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
>>> -                           const void *buf, size_t size)
>>> +static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
>>> +                             const void *buf, size_t buf_size,
>>> +                             size_t *buf_offset)
>>>   {
>>> -    if (n->has_vnet_hdr) {
>>> -        /* FIXME this cast is evil */
>>> -        void *wbuf = (void *)buf;
>>> -        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
>>> -                                    size - n->host_hdr_len);
>>> +    size_t hdr_len = n->guest_hdr_len;
>>>
>>> -        if (n->needs_vnet_hdr_swap) {
>>> -            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
>>> -        }
>>> -        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
>>> -    } else {
>>> -        struct virtio_net_hdr hdr = {
>>> -            .flags = 0,
>>> -            .gso_type = VIRTIO_NET_HDR_GSO_NONE
>>> -        };
>>> -        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
>>> +    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
>>> +
>>> +    *buf_offset = n->host_hdr_len;
>>> +    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
>>> +
>>> +    if (n->needs_vnet_hdr_swap) {
>>> +        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
>>>       }
>>> +
>>> +    return hdr_len;
>>>   }
>>>
>>>   static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
>>> @@ -1887,6 +1890,13 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
>>>       return (index == new_index) ? -1 : new_index;
>>>   }
>>>
>>> +typedef struct Header {
>>> +    struct virtio_net_hdr_v1_hash virtio_net;
>>> +    struct eth_header eth;
>>> +    struct ip_header ip;
>>> +    struct udp_header udp;
>>> +} Header;
>>
>> I don't see too much value in having this structure especially
>> considering eth/ip/udp is not even used.
>>
>> Any reason we can simply use an array as a buffer in virtio_net_receive_rcu()?

We still need to access virtio_net and it needs to be properly aligned. 
We can still make the latter part an array, but it does not look nicer:

typedef struct Header {
     struct virtio_net_hdr_v1_hash virtio_net;
     uint8_t eth[sizeof(struct eth_header) + sizeof(struct ip_header) + 
sizeof(struct udp_header)];
} Header;

> 
> Btw, since the code was for ancient guests and userspace, I wonder how
> it is tested.

I didn't test with dhclient, but I tested with UDP packets synthesized 
with iperf.

Regards,
Akihiko Odaki

