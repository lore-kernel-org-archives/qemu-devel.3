Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35858C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 11:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIQgZ-0007We-SR; Fri, 23 May 2025 07:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIQgX-0007WC-72
 for qemu-devel@nongnu.org; Fri, 23 May 2025 07:35:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIQgU-0003a3-Sq
 for qemu-devel@nongnu.org; Fri, 23 May 2025 07:35:32 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-74019695377so6560331b3a.3
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 04:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748000128; x=1748604928;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uV/RQmdBtH5jjBKZl2s4IndU2fCUdIQvWPSJN18R9uk=;
 b=T4rHgpDPz8zz1Kx+DUrr5YOj2DsLF2OGH8TQDmMTPUyVWbavrX8UjCrL4iEhzWdUWP
 gjfccxMc3N8J2Vqy7DiRxnDrsmwccFcCzyg52x8BbNhmfPpmFi7JNwtsT9F9knIZU8al
 w1/vrQXy8o/b8Ho7nl9sGMDlQTLY3ZSGMg9mNj+E2q6WfgY2PWpC4wnBLDAQhP5bgVPg
 klc/eFppcwVcWiy9oEFS6iGndTu4xzBzh3l/I10U3LiK5acRKBZbvzWZxHN7PMQbZ6ty
 mefS3QVJdfQFsTKb6sWmU419zn457kL09WbMRpbc/J19BkAA4fmlf9ycEzdB+CGIHnjQ
 LldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748000128; x=1748604928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uV/RQmdBtH5jjBKZl2s4IndU2fCUdIQvWPSJN18R9uk=;
 b=W4H8sgSSdUIDXwAh/8Nroi+Mfbt5CfxUJERuJ8cwTtRGldGWYYMYOaBVVyCY2wuKba
 zWKadrHwcy+NDq4uBtKXY3sSol16+TVQdBIrS0OKun7d4UanNQA7zmxrsNKQNGQgl9D3
 Uc/xIxugXk8dx837LL7jGjn8uLjlIqwdSYokN3WckBP9zjj6h30QG6WrJyC2lre3YCKc
 vunHEHJGDUmdyudNfMxfmNHXJ3y9Xc9gaNv8j7OtxcuWKGcEbqeV7kZlwrDOFGp71hPf
 LBlqgcGSRHxDJ7wo8tFXky58xamavRvp7Cd9WRAGRG7R4h8OQ702e3E3ebbGHoZDzdo9
 szSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdHNJbMdHu9JQseIGDPcKlxw4pZInXUCkaUsGYsVoFlXPoPZFXW2eo9SgHXv+qIE6+NWz7bd1Q7znG@nongnu.org
X-Gm-Message-State: AOJu0Ywdn5IjujOPHqMEzdEysmUbQsrrbY7mWt+qTy/DhpUsCE+iQsR6
 LVOfKKExVWoSgEXrzcp0Yk3NGcfMbHZpuuzEeopDOzzKnIkozOZgKeESWJGm8j8Iy0Y=
X-Gm-Gg: ASbGncvxaN8h4L9sBAPl2Yh4EH3sO3OMdlntp2Cw+3StmFoFgahX1wNtw+QxekI5svW
 MSOsehzRHejuXAKh+li9CaKPVz8F/9TTEyZ9XS1mh8CzWUE1EjSC+pVzk2PzDInVomjcAyEua+W
 JjlgldiDLMIsjL9KsmjB9IWvO3Q+nXvNRiBq1LORFnVZbqaoaxZH6+ZOXCS67LkEBfLXUhC3P5N
 K8DK1MWovupYDvpkigQMsSFCch0Y8zdp7wkLrTCfxgiSz/DPhMZGlNy5BvZB6FdfgodL2gy65H/
 HDBNPiXXVT/QU4ODRCBAPsxkgmCjzKuB0d9ZHjEszusPRKiasRw8M8pboUUWPLtijGpr6lyDXT/
 Wfht/1Sw=
X-Google-Smtp-Source: AGHT+IGt4cMEpyW3L5hC1Ih7dXc8cnb15OJ/1CIp3BexN+bRr9i/iNF4rJDKELL3DRpcGDUH4mA3tQ==
X-Received: by 2002:a05:6a00:4648:b0:742:a0cf:7753 with SMTP id
 d2e1a72fcca58-745ed842a10mr4081647b3a.3.1748000128275; 
 Fri, 23 May 2025 04:35:28 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829ce8sm12578624b3a.118.2025.05.23.04.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 04:35:27 -0700 (PDT)
Message-ID: <6520193c-0a14-4641-8e5f-f9084d264f1c@daynix.com>
Date: Fri, 23 May 2025 20:35:23 +0900
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

virtio is also an interface, and we can reuse it for QEMU-internal 
interfaces too if it is appropriate.

That said, the feature bitmask defined by virtio is inappropriate for 
for qemu_set_offload() because it also contains other features not 
related to guest offloading. We need an alternative interface, and the 
current qemu_set_offload() just passes each flag separately.

Now, "[PATCH RFC 12/16] virtio-net: implement extended features 
support." is adding another format that derives from virtio for guest 
offloading. This format only contains bits related to guest offloading 
by definition and suits well with qemu_set_offload().

Bit names like VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO will imply that it 
derives from the virtio spec I think this is actually an improvement; 
the virtio spec have been the definitive document of the offloading 
features of tuntap, and some features even used the virtio header (so 
e1000e and igb parse and build virtio headers). These bit names make 
this relationship between tuntap and the virtio spec explicit.

