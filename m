Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA0FCFC503
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 08:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0GUl-0008Q4-6f; Mon, 14 Oct 2024 04:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1t0GTd-0008I3-G4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 04:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1t0GTa-0006Lm-Ha
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 04:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728894648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OqKpy6EiO79YOIsH43Ny5hjMppL/j/7imlyQdRAlJ/s=;
 b=MT5W0Skr+LnahcrskcJZHa3ZL9RG2Q0egzInnZMHvdpwD71DXG/gzpIevtZYBu6F8Xq6ib
 6O9D6aPP8zz9dLikoLn1k1HpnR6/N2U26bFSEnYdLPbT4nxVQt9zx2ImA6P4xIHsiwO3BK
 MOXAvjFJ0VegcvW3F4CaL0Uj487lRhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-x6RcmpwaMr63C8F0yikp_w-1; Mon, 14 Oct 2024 04:30:46 -0400
X-MC-Unique: x6RcmpwaMr63C8F0yikp_w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d39bf2277so1428464f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 01:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728894645; x=1729499445;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqKpy6EiO79YOIsH43Ny5hjMppL/j/7imlyQdRAlJ/s=;
 b=YqSPzTlfG7gV1rsdHx/VL8UAwxYBQPNwTk6ZphKaczr29dwFAqDy1NeZlsSNJKZ61i
 OgpBm9xfH0m0M8XihkBTEKWZFeg7kwkmQ9sl5Qa7GBWv9Pb1AN39GMB3kaRdx1OelEw9
 sMCB5aW8KB//4jAc66n29pSHXTzyQfeuJjwZ+nfW30gEeDFh2v3W8X1T55NT2ecOiows
 IriPeM+z8eFjPdjrA5u/miONuHooYNhUOKPQUvnyc+lXBtvJUJFqIZwHQc/0ym69JHtn
 bNNF7rUVwuglwTJZ0KAmpySRfLmVauYDg0q9saKco5qkTgBp2dp97x2fqWyYPpmJw3NX
 VlGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+XApTZQcwaUvXU8MAPsQRBw3nVcDsj5uZNyAvmQ59fFI+cHEKONpSCxRM8VcbnCvGjA736MVRDPNK@nongnu.org
X-Gm-Message-State: AOJu0YzAMDtR/D7/CoXA3ueBWD8hjGce8xHOnYM3F6olXI5jCAQZ44o3
 XU8AkzVUnXQik2I231FrUOPXWMpW5SiSMsNLJt9oiosRJhQKP6gUyhAh1FUpIPSIj5O6tIrWzz9
 EsrshBi8afMlREqXn7B9QVJtDiVogcVGg7iY+gVfpr8K4jaef2OqW
X-Received: by 2002:a5d:6383:0:b0:37c:d227:d193 with SMTP id
 ffacd0b85a97d-37d551988acmr8328934f8f.10.1728894644704; 
 Mon, 14 Oct 2024 01:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb3CtxsAZn+o6rBASQgSxbRiDWnI+nbmMEKt7nBF1XsRAev4cQi6b4btGxBehbguuN6zYhbA==
X-Received: by 2002:a5d:6383:0:b0:37c:d227:d193 with SMTP id
 ffacd0b85a97d-37d551988acmr8328915f8f.10.1728894644285; 
 Mon, 14 Oct 2024 01:30:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:4c84:58cb:a1ef:8b78?
 ([2a01:e0a:e10:ef90:4c84:58cb:a1ef:8b78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6cfb43sm10683600f8f.56.2024.10.14.01.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 01:30:43 -0700 (PDT)
Message-ID: <a46a895a-4961-43fa-99d8-3bda7612bb9a@redhat.com>
Date: Mon, 14 Oct 2024 10:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/20] virtio-net: Add only one queue pair when realizing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-9-jasowang@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20240604073755.1859-9-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Akihiko,

On 04/06/2024 09:37, Jason Wang wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Multiqueue usage is not negotiated yet when realizing. If more than
> one queue is added and the guest never requests to enable multiqueue,
> the extra queues will not be deleted when unrealizing and leak.
> 
> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/net/virtio-net.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 3cee2ef3ac..a8db8bfd9c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3743,9 +3743,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>       n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
>                                       n->net_conf.tx_queue_size);
>   
> -    for (i = 0; i < n->max_queue_pairs; i++) {
> -        virtio_net_add_queue(n, i);
> -    }
> +    virtio_net_add_queue(n, 0);
>   
>       n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
>       qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);

This change breaks virtio net migration when multiqueue is enabled.

I think this is because virtqueues are half initialized after migration : they are 
initialized on guest side (kernel is using them) but not on QEMU side (realized has only 
initialized one). After migration, they are not initialized by the call to 
virtio_net_set_multiqueue() from virtio_net_set_features() because virtio_get_num_queues() 
reports already n->max_queue_pairs as this value is coming from the source guest memory.

I don't think we have a way to half-initialize a virtqueue (to initialize them only on 
QEMU side as they are already initialized on kernel side).

I think this change should be reverted to fix the migration issue.

How to reproduce the problem:

Source:

qemu-system-x86_64 -serial mon:stdio -accel kvm -cpu host -m 2G -display none -hda 
vm3.qcow2 -netdev tap,vhost=false,queues=2,id=hostnet0,script=/etc/qemu-ifup -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:49:47:db,mq=true

Destination:

qemu-system-x86_64 -serial mon:stdio -accel kvm -cpu host -m 2G -display none -hda 
vm3.qcow2 -netdev tap,vhost=false,queues=2,id=hostnet0,script=/etc/qemu-ifup -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:49:47:db,mq=true -incoming 
tcp:localhost:4444

In monitor:

migrate tcp:localhost:4444

Result on destination side:

(hangs and then: )
[   44.175916] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0:0:8]
...
I think we have this error because the control virqueue is #3 for QEMU, whereas the kernel 
is using a control virqueue set by the multiqueue (max_queue_pairs * 2 + 1). There is a 
mismatch between queues...

Thanks,
Laurent


