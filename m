Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C7CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 03:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJhh-0005c5-53; Tue, 26 Mar 2024 23:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpJhg-0005bs-1H
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:11:52 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpJhe-0005o1-0i
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:11:51 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c37d50adecso4096971b6e.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711509108; x=1712113908;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YhlZON9mQyCPeD3shzb4wJ/sWnxwtJpSLaF9DociUaU=;
 b=chunzNhHAICskhcJq3lx8RolROl6r34/asidHIK0BSWyy1iL40EF1v2c4xlzMeONNj
 N+LIQsECIy5uHPki6htSSZ4Ao0kdM+4QTtlFYO/5ivDJ9fHqMRaLMvFljQNF/hrHJgX3
 G3cFyNoDSu5KA7MtT6uokFHwYInsvIFcWjiBaCxgxkNcKizw5zreZn/dvPSh01avZZbn
 AKxMOYZhl+/DmvfudkfxDOG5+YOZANW1vAVl7HQ8RfUZA/GMZLYs9ic341mQgt9rayDA
 CpmCqs1bgY8lsMh4H4CtBYQ1qM3BcQbsBKwmQuj3C0dRtRoCq7tRYuUjfqQva085eoaL
 jFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711509108; x=1712113908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YhlZON9mQyCPeD3shzb4wJ/sWnxwtJpSLaF9DociUaU=;
 b=dcEWPYJ9Tf94XCAcMdF5IbUCrI3rZWt5ubkzHeus60KMhRuV2vO0fV1nmdPLxrPTig
 484kmZoJjfvhiDD0Prt2+dq7MrgV/8OuF1gK4jXO9et41HWG6y5OiowQRyQsYO1c/zAF
 NeJaF/YAjKMeUAmCeKqkUq+TmEtBqvNKscZyhpO6J/xA8Atodjn3XOCK6pQi5haJ8geg
 n0ry4l5XEN3hvmoCK0vT2H7mursAearljgtbLDzT2KOzyU7OIaJI7LJKnsnbmZn2f1NS
 GliMg6Ogw55zu6pL06TJfpI0op0BbIguFfoFB9SEeW/D834s+pfE6c1J8LTbGId0U0QQ
 L5LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzh4K3BjUA8vCL06czFQFtDTfbT6pPd2zcWRbMRNmQ9wXnRDqb9HDFm1+NWRFBKhZr85LiZCOfPQmTH0zeAHq/EoWUEfI=
X-Gm-Message-State: AOJu0YzHjKh0I+JUr/A/azUSCtkSItuSqgD2x/W8QNRHgUa2mIzIV76b
 DX7+XBaM/ZSGCtIjQVLIuYZg4xqDMYzp9HqwDVOkyw7b4m2YYFdxM2rqAoLrQyQ=
X-Google-Smtp-Source: AGHT+IEk6fN1Go1BYJQlQRwHqAr1Gvhdq3rOGT/RNiO0SLUidZ2Jy7lpmzuqzEl2vUiLZ0qpN7ukkw==
X-Received: by 2002:a05:6808:301f:b0:3c3:cc31:5b57 with SMTP id
 ay31-20020a056808301f00b003c3cc315b57mr56790oib.31.1711509108312; 
 Tue, 26 Mar 2024 20:11:48 -0700 (PDT)
Received: from [157.82.202.248] ([157.82.202.248])
 by smtp.gmail.com with ESMTPSA id
 r6-20020aa78b86000000b006ea92de360esm6969640pfd.93.2024.03.26.20.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 20:11:47 -0700 (PDT)
Message-ID: <72ccd5e9-8e9a-4d01-bbdc-94c2dfaf6468@daynix.com>
Date: Wed, 27 Mar 2024 12:11:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
References: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
 <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
 <a31d0734-823b-4b67-8888-46f0c787cf8f@daynix.com>
 <CACGkMEvYQr2=0DF99ge9DotJg-O3H1FmZQAzhb=6RVWSvvGqmA@mail.gmail.com>
 <a4bdd207-e069-47ef-8e80-7b27528a315d@daynix.com>
 <CACGkMEsCTsQ8H6=XYMZ+8Pb9X1o19j9A4N8kiO500Dbgnw-i6g@mail.gmail.com>
 <cc71e6c8-eca5-4ce1-9c16-8f85c6a5073e@daynix.com>
 <CACGkMEvW+_MTvJ5TwJLNxKC=u0bTTLETuHqK5_0P27GQra5Dng@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvW+_MTvJ5TwJLNxKC=u0bTTLETuHqK5_0P27GQra5Dng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x229.google.com
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

On 2024/03/27 12:06, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 11:05 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/03/27 11:59, Jason Wang wrote:
>>> On Wed, Mar 27, 2024 at 10:53 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/03/27 11:50, Jason Wang wrote:
>>>>> On Tue, Mar 26, 2024 at 3:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2024/03/26 15:51, Jason Wang wrote:
>>>>>>> On Sun, Mar 24, 2024 at 4:32 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
>>>>>>>> checksum offloading is disabled so clear the bit. Set the
>>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is valid.
>>>>>>>>
>>>>>>>> TCP/UDP checksum is usually offloaded when the peer requires virtio
>>>>>>>> headers because they can instruct the peer to compute checksum. However,
>>>>>>>> igb disables TX checksum offloading when a VF is enabled whether the
>>>>>>>> peer requires virtio headers because a transmitted packet can be routed
>>>>>>>> to it and it expects the packet has a proper checksum. Therefore, it
>>>>>>>> is necessary to have a correct virtio header even when checksum
>>>>>>>> offloading is disabled.
>>>>>>>>
>>>>>>>> A real TCP/UDP checksum will be computed and saved in the buffer when
>>>>>>>> checksum offloading is disabled. The virtio specification requires to
>>>>>>>> set the packet checksum stored in the buffer to the TCP/UDP pseudo
>>>>>>>> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
>>>>>>>> be cleared in that case.
>>>>>>>>
>>>>>>>> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
>>>>>>>> validation. Even if checksum offloading is disabled, it is desirable to
>>>>>>>> skip checksum validation because the checksum is always correct. Use the
>>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksum.
>>>>>>>>
>>>>>>>> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback")
>>>>>>>> Buglink: https://issues.redhat.com/browse/RHEL-23067
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> ---
>>>>>>>>      hw/net/net_tx_pkt.c | 3 +++
>>>>>>>>      1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>>>>>>>> index 2e5f58b3c9cc..c225cf706513 100644
>>>>>>>> --- a/hw/net/net_tx_pkt.c
>>>>>>>> +++ b/hw/net/net_tx_pkt.c
>>>>>>>> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
>>>>>>>>
>>>>>>>>          if (offload || gso_type == VIRTIO_NET_HDR_GSO_NONE) {
>>>>>>>>              if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>>>>>>>> +            pkt->virt_hdr.flags =
>>>>>>>> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM) |
>>>>>>>> +                VIRTIO_NET_HDR_F_DATA_VALID;
>>>>>>>
>>>>>>> Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?
>>>>>>
>>>>>> On igb, a packet sent from a PCI function may be routed to another
>>>>>> function. The virtio header updated here will be directly provided to
>>>>>> the RX path in such a case.
>>>>>
>>>>> But I meant for example net_tx_pkt_send_custom() is used in
>>>>> e1000e_tx_pkt_send() which is the tx path on the host.
>>>>>
>>>>> VIRTIO_NET_HDR_F_DATA_VALID is not necessary in the tx path.
>>>>
>>>> igb passes igb_tx_pkt_vmdq_callback to net_tx_pkt_send_custom().
>>>> igb_tx_pkt_vmdq_callback() passes the packet to its rx path for loopback.
>>>>
>>>
>>> You are right, how about igb_tx_pkt_vmdq_callback()?
>>>
>>> We probably need to tweak the name if it is only used in rx path.
>>
>> igb_tx_pkt_vmdq_callback() itself is part of the tx path of a PCI
>> function, and invokes the rx path of another PCI function in case of
>> loopback, or triggers the transmission to the external peer.
> 
> Right, so if it's an external TX, VIRTIO_NET_HDR_F_DATA_VALID may not
> work there.

It should be fine since it's just a hint.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Thanks
>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Akihiko Odaki
>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>>                  net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
>>>>>>>>                                        pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1,
>>>>>>>>                                        pkt->payload_len);
>>>>>>>>
>>>>>>>> ---
>>>>>>>> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
>>>>>>>> change-id: 20240324-tx-c57d3c22ad73
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> --
>>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

