Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F1CC54F2E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIQ2h-0006MA-Hx; Fri, 23 May 2025 06:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIQ2e-0006LU-2E
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:54:20 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIQ2b-0006er-R4
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:54:19 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30e8daea8c6so5748448a91.0
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747997656; x=1748602456;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FiITWBtG9CncF1MdKwG3Zdo6MyGCGkS7VgyFg4fEuGQ=;
 b=Hi6qolVvU6s0IxDUHrb4mPANWuimNbZLhnnLz+MSORUyzle0/YSJxJbqatATF7yW/d
 fZ4mbtDV/faycGm9wLgAIY8X44WWr+rD2T/++Nl8UB97IfkibxcpydbG+fCdIvx6NfQZ
 NgvR3F85yoe5oAXh5+Mf4Zdn264MFdLYcwpW1aZjKtMiEJyti4gh2fCm7lvpGSd+1lzy
 NlFRTVUn2FdqCBSfn2/LpbPoonpO6PFaNrwIlE+qoglPyYrFVNgJ1QG3GghvaHn7cykp
 5zuR61eLRdsg7eLAsY766LwkMPx+Ww9liLrm31/Gb2srjUbztFXyh1tdyUdkz05WQEVV
 4Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747997656; x=1748602456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FiITWBtG9CncF1MdKwG3Zdo6MyGCGkS7VgyFg4fEuGQ=;
 b=CMFZRVyuKwc6UT20kmBE207+AA3NbXk6YEQJoL+94LBrfoyi5c+/eWEZOe8OTogHH6
 DYYcpOUmW2VkUGGRz2P19unTlffqrf8hG+imFYIuRwp+U5uTtwglrUa8SIErsyBqO7NM
 twsVdMZKdxJvpAnFef4qH1IuaW68h+7NGIpxsoiGnMqQf25b/f8gvSgLLL2cEG+M/VGO
 sQ0eqS15KYNVEw6zxIOf0+X1Q/lN1r9PPQ1WliTGEhukzYPKrcY7moBtnOe0Be7Wrslt
 eEZ/O4DLRVZX2RpuqDHvdTXKGnbZtkoqFt0lpuNtbeI/mf6ZGVaZtwdp1UVCJ4exbkuU
 ilFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYsWlZstPp6M8fZCSOtW1l2+zT+n4OEMyFFY0xNnMY/OFIEw9rwDLi31mfFUYZl8QyqXEmJsJmUkkv@nongnu.org
X-Gm-Message-State: AOJu0YzX8xwluCDWdAhJ4Isl6gii1Osl0Rjalh2ncnCg8nDeVF0RO0Eb
 MpIN3cVKATAomKLkOGD9xivegU6sAFjWi2UcpDyLwaAV+XumTTlw3PAX9vdUdpJvAVM=
X-Gm-Gg: ASbGnctVZkHsYv3Q5EOMhaYSNruEKSQtaUqai7UN4r8b5W5hfH8Eg2i33SMU9/NHmD9
 Bgd7wQgvTZKTAsAaBiUb+kebpk89CV4jC/wbnc3sdjN1BcHDz85DmBFov7IjbaEHdrw+Ly9D0nY
 45GS5lnEW+DI1BgtqMgjVyBe71YW0vfNOrBNmzwznLL5YChdsEBmaCTGkLQfFt9x3Lvy7NbY0E3
 6x3BFNvfyrLAamkvFgB3fheGielUpe0F433i77Rzma9/zIzqqqpq4PSCI5kGPCVpQjPtko13Kwl
 gZ42ycQVPELQqaCgRTxhWfn2Yk7MKGa36hwiRWv6BdVI5cPVBkmtl9KtJ+2gTw==
X-Google-Smtp-Source: AGHT+IFpiOMn5fsClMqYWl6rZ7WdYLr3Soek8ucs01HWGV0O7YhatrnYutpl+rlCQuGywy0jmcshGQ==
X-Received: by 2002:a17:90b:1e04:b0:30e:54be:37e7 with SMTP id
 98e67ed59e1d1-310e972b37dmr4265595a91.24.1747997656061; 
 Fri, 23 May 2025 03:54:16 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ee9f34a59sm5518590a91.1.2025.05.23.03.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 03:54:15 -0700 (PDT)
Message-ID: <0ddd6a2f-55b4-4356-8881-6744580fafd7@daynix.com>
Date: Fri, 23 May 2025 19:54:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/16] net: implement tnl feature offloading
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
 <0aba4f0d-f6e8-4c46-a183-eebb401c13a2@daynix.com>
 <3277a9a5-10a7-49a9-901d-cdeef503b1d1@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <3277a9a5-10a7-49a9-901d-cdeef503b1d1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/23 19:40, Paolo Abeni wrote:
> On 5/23/25 10:16 AM, Akihiko Odaki wrote:
>> On 2025/05/21 20:34, Paolo Abeni wrote:
>>> @@ -890,6 +915,12 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>>>           .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>>>           .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>>>           .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
>>> +#ifdef CONFIG_INT128
>>> +       .tnl  = !!(n->curr_guest_offloads &
>>> +                  (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)),
>>> +       .tnl_csum = !!(n->curr_guest_offloads &
>>> +                      (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)),
>>
>> "[PATCH RFC 14/16] net: bundle all offloads in a single struct" added a
>> struct for offloading, but how about passing n->curr_guest_offloads as
>> is instead?
>>
>> It loses some type safety and makes it prone to have unknown bits, but
>> omitting duplicate these bit operations may outweigh the downside.
> 
> I *think* that one of the relevant point about the current interface is
> that qemu_set_offload() abstracts from the virtio specifics, as it's
> also used by other drivers. Forcing them to covert the to-be-configured
> offloads to a virtio specific bitmask sound incorrect to me. Possibly I
> misread your suggestion?
> 
> [...]
>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>>> index aa5f3a6e22..b7662ece63 100644
>>> --- a/net/tap-linux.c
>>> +++ b/net/tap-linux.c
>>> @@ -287,6 +287,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
>>>            if (ol->uso6) {
>>>                offload |= TUN_F_USO6;
>>>            }
>>> +        if ((ol->tso4 || ol->tso6 || ol->uso4 || ol->uso6) && ol->tnl) {
>>
>> Is it possible to have ol->tnl without TSO or USO? If so, is ignoring
>> ol->tnl really what you want?
> 
> The virtio specifications actually prevent setting UDP-tunnel offload
> without any other "inner" offload (TSO or USO), as it makes little to no
> sense (the stack can't GSO/GRO the outer header without doing the same
> for the inner).
> 
> Does the above makes sense/answer your questions?

The code implies the following:
1a. ol->tnl may be true while TSO and USO are disabled.
2a. It is defined as no-op in such a case.

But the reality is as follows:
1b. ol->tnl being true while TSO and USO are disabled is an error.
2b. The consequence is undefined in such a case.

In that case, virtio_net_get_features() should report the error for 1b, 
which will prevent the error condition from reaching to 
tap_fd_set_offload().

Making the error condition no-op in tap_fd_set_offload() does not make 
it (more) correct as the consequence is undefined anyway (2b). It may 
simply ignore the condition under the assumption that it will never 
happen or assert that assumption.

