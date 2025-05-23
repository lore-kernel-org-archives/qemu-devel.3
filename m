Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C88C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 07:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIMkZ-0000le-EY; Fri, 23 May 2025 03:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIMkT-0000lE-9n
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:23:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIMkQ-0005B0-9i
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:23:20 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso4481961b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747984996; x=1748589796;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eB4Zd7Mk417ovQpwBim1jjzfRoHj4a5h+Zs1L1+1Dno=;
 b=WqTaT5dyyRfvCsptnAzyuo2HONyQQazqGChShGo23UoaQVjZuyFLFt2+Qt0Wo43Nmk
 2tbVCPQu8UjJ+wcWrVM8b9l1ePiUOcaAWZ/O0UM5L5+BnMHXgc9/ET3y/WPouJiSjGkz
 PMJidmoRkHKjNedVG6gDRhI1TU1gqnjSk+Aj0VwmeuJDvKOAICAJsl+lkG8tqWEsrfw6
 Cn0mmVgRG/eilML9tH6czic/306OxiRxAapO5zUjn27toomcPU3KgPOvU4Oe/W0QKIT4
 B8f9oI/x7XfUDDK7MUvoH3AvjSd4X+ir46+qjxvqy1iJZoTfBOrmUSuY9Elb19kSRBZ8
 3wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747984996; x=1748589796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eB4Zd7Mk417ovQpwBim1jjzfRoHj4a5h+Zs1L1+1Dno=;
 b=RVvfdMj6Ku+Gqu4/sEo4wQZF2/GriTqno8+j6+W9/1USMaCRRS6akmqIQ6dsYWIxKt
 71rB+Iinq+WQnBIPS2CeIGff56pPL+RP73G7m6Of9Wj/UIHsTOU6m4IRXFMwE2ZkxONN
 j37yXa35xaARYb68oowYNikh4+8Qh81iLpsxMSY+zwQhma2bldMjriHsQD6KEMOwa7JT
 Kc0Ybq1ezGNel5ON4fQC46V+KHkZMKRKX6JN3ih0kLvETETp8+gkGcnZ7gCDdxos6CbK
 vflNtHjhXp2+aTBGotBa3/kQjdByTojHkD6gl2N4OYOnUnT4wENRM3EfUzbfXqfwsM7r
 MmRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQWqZOnCZzMyE6sUJRr4pC+wvs6v8SqOj0azcXd1CGsLhddt1DJJ/vfMrgfh+46wSLrHaJeZUYICAl@nongnu.org
X-Gm-Message-State: AOJu0YxnD2Ug0uhucUg+aEubJE6ABpqVY+PeeOS1h3omiAf9OJA16H6F
 gheFBINfOUUxrM8zw/f9Gk+JDHx8iU/yQuBrYkl590X4PuaUSUA5kON+JOag5VI9Qgc=
X-Gm-Gg: ASbGncvl3/s4bkoPMxJeKc0jmqWN3FqvCFttzxPo1x/q0WcQulUiKV/xNJGAvnoMeak
 jadIHqWGw44zKheXk5XcNLvNfHkv/mGiE3+OHTukB0VqfS7WsduVBeH36GzfBAS48Dw8wgquy7w
 IEgYFLK/WO4a7sM9RYS3k9BR3VLm7UF80JYlw/f1wZ8BrEu7GZ+R3xyXK8Qk8ud+btwNqcntxtY
 zRXK3kRMlvsYqgx4rPvRVBW+gBc8rRfxr+v9gjYgpJ60Nwvh22CBuoBjHBxweyEgI0O/UOkoL8A
 lOs8KHJMLuSd4LWnPba9A+eg+0duCk6H/0sKNN7aOoh+ohOznNdXQ1kOdHDayg==
X-Google-Smtp-Source: AGHT+IG1zfgldY3Cntag/tCW5Okl7XQBy8Q0yy2kgwYXNLTXWl1C+qRB/TdZgRiTc9lhUcHQVigzag==
X-Received: by 2002:a05:6a00:3cc7:b0:732:2923:b70f with SMTP id
 d2e1a72fcca58-745ed87c9b5mr2662529b3a.11.1747984996325; 
 Fri, 23 May 2025 00:23:16 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a987707fsm12586166b3a.140.2025.05.23.00.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 00:23:15 -0700 (PDT)
Message-ID: <2739771c-cfc7-43df-af68-5445cd714ff2@daynix.com>
Date: Fri, 23 May 2025 16:23:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/16] virtio-pci: implement support for extended
 features.
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
 <b91bba9115031af5c8b66eca737296ea5889dbec.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b91bba9115031af5c8b66eca737296ea5889dbec.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

Having a period in the subject is unusual.

On 2025/05/21 20:34, Paolo Abeni wrote:
> Allow the common read/write operation to access all the
> available features space.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   hw/virtio/virtio-pci.c         | 19 +++++++++++++------
>   include/hw/virtio/virtio-pci.h |  2 +-
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 0fa8fe4955..7815ef2d9b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -123,7 +123,8 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
>           VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
> -        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
> +        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy,
> +                             VIRTIO_FEATURES_WORDS),

Modifying existing fields breaks migration across versions. Please refer 
to docs/devel/migration/main.rst for details.

>           VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
>                                vmstate_virtio_pci_modern_queue_state,
>                                VirtIOPCIQueue),
> @@ -1490,10 +1491,10 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
>           val = proxy->dfselect;
>           break;
>       case VIRTIO_PCI_COMMON_DF:
> -        if (proxy->dfselect <= 1) {
> +        if (proxy->dfselect < VIRTIO_FEATURES_WORDS) {
>               VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>   
> -            val = (vdev->host_features & ~vdc->legacy_features) >>
> +            val = (vdev->host_features_ex & ~vdc->legacy_features) >>
>                   (32 * proxy->dfselect);
>           }
>           break;
> @@ -1585,10 +1586,16 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>           break;
>       case VIRTIO_PCI_COMMON_GF:
>           if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
> +            virtio_features_t features = 0;
> +            int i;
> +
>               proxy->guest_features[proxy->gfselect] = val;
> -            virtio_set_features(vdev,
> -                                (((uint64_t)proxy->guest_features[1]) << 32) |
> -                                proxy->guest_features[0]);
> +            for (i = 0; i < VIRTIO_FEATURES_WORDS; ++i) {
> +                virtio_features_t cur = proxy->guest_features[i];
> +
> +                features |= cur << (i * 32);
> +            }
> +            virtio_set_features(vdev, features);
>           }
>           break;
>       case VIRTIO_PCI_COMMON_MSIX:
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 31ec144509..c20b289e64 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -165,7 +165,7 @@ struct VirtIOPCIProxy {
>       uint32_t nvectors;
>       uint32_t dfselect;
>       uint32_t gfselect;
> -    uint32_t guest_features[2];
> +    uint32_t guest_features[VIRTIO_FEATURES_WORDS];
>       VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
>   
>       VirtIOIRQFD *vector_irqfd;


