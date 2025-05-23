Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5100C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 08:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uINg7-00079i-97; Fri, 23 May 2025 04:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uINg4-00079K-Qz
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:22:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uINg2-0004Ef-Cs
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:22:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-742c2ed0fe1so5927093b3a.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747988567; x=1748593367;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bnmAZpxdatmrmqL+0NnP7KC7oDXHTaEufrQM6BEJI3Y=;
 b=uqWkx1Z1aYAwEgbDivhZyMmI1QbTO+Z2PZi/fbjUAVJ2/Vb4eaLyvHcYmpv/dLhbhm
 gV7zKE86gNkJRdHLzp05EwZ0unieLxPPuV0MIX1WMZY5rFIlcle2K/DQ5eVHPTRwgYh5
 YIe7GXJxHkYDggp4BbgWU5J0F6S6DRfX+bgfHDVTIdNCDURZuH/uImWNYZ00ZUGDIO8G
 K0a3u5csltla1cjsLCRU4LAUSugKgYIK/R5UVCj2DB3+c4JljUQdGB1xmsrNl1dToDoL
 ZTQlSSfGcK5Zueqm2f5632OeGSZUcNX+Fx532JNxtBPkGyrE/qs1O9DGzJf567Qb+blz
 m5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747988567; x=1748593367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnmAZpxdatmrmqL+0NnP7KC7oDXHTaEufrQM6BEJI3Y=;
 b=CFUkP4Yw04+B6j8uxoX1ZMhJEs7by74SbEyFQEh5VOLlHiKOcGRBUwwWY4g6AJ+ZtB
 YLQBStRkIR/LAkkXf1N6+Y+HzjySSnYDsHOYeRYABX5o3lrmTC9Iw8M7ZN9Q/82Zs72G
 0WzmXFLLoFqCzj742lebxfpnn80pzvvlW5v8R2EfcrDgXDuAmyk4O7v4ydJ5Rx0PoOr6
 fx1gvmN3lVAAtsK2ygzf6phmbbuktK/aAeR9Ikd6cRzcOb+A2dSRpLIMYHfU2k/z5cYI
 rnCDWwkO8wBuOV+7EzO1Bgwynjvg2pCTf+eA5grwgB3YMhBZ+BwR55KvyZz2VUM3IDfX
 wTWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNtfhKD9e5NWa8bdYskLe43zM9hIPxd/oYh1M1jOfkC243DwLTd3SABkWSnS1eNjeWWr6YdXMGP1yk@nongnu.org
X-Gm-Message-State: AOJu0Ywszbj76FR2YY1FGdj8wDfcTDnADP2v2jk4ISyy2ePLM9arT6qR
 xqFfuQC7GLL4C/UYe8WO84WnY7iWjYfKUnPEEzS5m2zP2yjNrX64Ne1MayyVwZjnEdE=
X-Gm-Gg: ASbGncsj/wvSCJ/I3j2iu+BecGla4gsJSmJJMcc5+VYZq5IWqotqWht/Wtan8Z2kr4E
 Cl1+pLnbabniriHWDgLYFSzGtIUGd7LWoVe09gtOxwX8F0cbcLK9pwZ4/fU8wZBwwn6DvlZYyC6
 QFtvHIduScJisRRKaNAajWvAqBtQZx/8t4t94CLYrwt/X8MC+uaFpjlh6oWvxG4xjr2gQ59s6n0
 vsOYzGV3Qofp10vNwLZ6qaQhhfUMru7RgM2X1hYB0vouHME0t39rT8QBPrMXONjsEwD7yBWMkpj
 8JNElb7is9oQiki6QlMekcpArWmc/GAMhV7HznoyBRKaPNWZyfJ04J+u/Z6crkH1VzmzndyNrhN
 yAz+0FgY=
X-Google-Smtp-Source: AGHT+IG9f2Cxu68S6tY20m6EmfhR1oM2Cz8g/6USWm7LqXHg//0XLyD+LWYIjWR8hEqut/qGwh0fsA==
X-Received: by 2002:aa7:88cc:0:b0:742:a02e:dd82 with SMTP id
 d2e1a72fcca58-742a98dce7fmr35023615b3a.22.1747988567179; 
 Fri, 23 May 2025 01:22:47 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a987708asm12301964b3a.155.2025.05.23.01.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 01:22:46 -0700 (PDT)
Message-ID: <f824d42a-6b4e-4624-874c-bb8eddf663e2@daynix.com>
Date: Fri, 23 May 2025 17:22:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 16/16] net: make vhost-net aware of GSO over UDP
 tunnel hdr layout
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
 <87d85cd2c276a43d0f7ed2d27e00427b8f4a8243.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87d85cd2c276a43d0f7ed2d27e00427b8f4a8243.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

On 2025/05/21 20:34, Paolo Abeni wrote:
> When the GSO over UDP tunnel offload is enabled, the virtio net
> header includes additional fields to support such offload.
> 
> The vhost backend must be aware of the exact header layout, to
> copy it correctly. The tunnel-related field are present if either
> the guest or the host negotiated any UDP tunnel related feature:
> add them to host kernel supported features list, to allow qemu
> transder to such backend the needed information.

s/transder/transfer/

This patch should be squashed into the previous patch ("[PATCH RFC 
15/16] net: implement tnl feature offloading") as QEMU only with the 
previous patch will incorrectly enable tunnel offloading even when vhost 
doesn't support it.

> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   hw/net/vhost_net.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 58d7619fc8..c8e02d1732 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -52,6 +52,10 @@ static const int kernel_feature_bits[] = {
>       VIRTIO_F_NOTIFICATION_DATA,
>       VIRTIO_NET_F_RSC_EXT,
>       VIRTIO_NET_F_HASH_REPORT,
> +#ifdef CONFIG_INT128
> +    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> +    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> +#endif
>       VHOST_INVALID_FEATURE_BIT
>   };
>   


