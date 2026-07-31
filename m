Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C9CC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgne-0003eU-0d; Fri, 31 Jul 2026 02:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpgnb-0003eC-OX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpgna-000793-4Y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785479568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iENUIbIU2816ckNGAkDUXXbZUy5ZNKzWKY3QjyHXScY=;
 b=h9fMasOt0mchsz5oRxb8b2y7CDyqrfHT2G8g5BI6FbAEp34icVjpg9/5W1fh8Xq99piPJ7
 +66gfHqZehTfS+RW4akeNPBxD4XWTE7g41wrBFfZzHp8dK144rNQb0FdBJnQW5FqGWi1EE
 xlGHIO+jVMvkqMvbbOHs5XyIjCYLKdw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-0VQ_hgNUPS-NdmYEvwAW5Q-1; Fri, 31 Jul 2026 02:32:46 -0400
X-MC-Unique: 0VQ_hgNUPS-NdmYEvwAW5Q-1
X-Mimecast-MFC-AGG-ID: 0VQ_hgNUPS-NdmYEvwAW5Q_1785479566
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15deb3377eso41062466b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 23:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785479565; x=1786084365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iENUIbIU2816ckNGAkDUXXbZUy5ZNKzWKY3QjyHXScY=;
 b=eb6K0xb3KJgKX7bVii7dlHPG3fMMc4rGiZehfd9kuGDOB3B7UbGqPzxDF0NSGaKzAB
 1Esf0CR+GAYK7JS37UHM9oB+OFBAMqPIIfE2OR/I54y2UWHAxiq+iWU01KVa/hibiETR
 T9Fu1bhxyVrcIu2GONfoVtYHHCfjs5Mqk4MImL1PPsrX/YNnelmQhDvCPuVAo83PnNQD
 WaNK8JZhzsfkwk7PKTeYOurS+IUj6LGoWZ3RvUmD8xx82HCAdt1rJ/wh6RV4IHYFnMDh
 tGbcBE7zRX6V37crzKo7tsGAaP3alvzW58kOIvALBn2xu7z5TjxV70YHwt8kp2gx1wPE
 wS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785479565; x=1786084365;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iENUIbIU2816ckNGAkDUXXbZUy5ZNKzWKY3QjyHXScY=;
 b=boYwaRe4czyZ7Q0fjE2FxeyC3RelTlzRFPAxoAtflGd5Cd8b4+mzX2n1I9QT/2tkJJ
 oO2AHPE8aUeMrINGwbitvvB5W5bESO0QL0fTAsaOh9LwprJXJzrTIeCL5t0mH0O6lHnK
 Wwj7Q6S47icjoqy9QcDbwoRLYIjf1QPgXLy+a/ovjFBXzUfXm9BstxqzqH6Zf42Q2jee
 xjAlPjRVtWTuQH9HUIpZsm6zqCCWbMAuobwhIkPcva86SXzeTWaXg951Q9gQ+6VFkeR1
 Vp+yt27IlMng/SNCy4vOhV8ZKZq/6h6IbhHsSHyzSCxk8hIzRNoWqRRuONP/WGw2TmJw
 XuNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqZ2V7/9Rm1A+GjiJmGPPtY3ze5cpnP2fYmSwRKZC8VhD3rY6mLMVX2r0ABT/Li56ydfCOpOD5YrWO@nongnu.org
X-Gm-Message-State: AOJu0YyPB8sLHl0s4FNEQnEG228Q1hgj4baseupeA3QRCaoiro0cKOqi
 bdBtwHggy90PEeTd0vjL6dedmn5nQp/gfN9HMbbciqlNG9C5bfReH+BcJdii/axL7UvX9QIWuhq
 u/CEJAkTtLjI9s7a4gNuKl+4XEhd5MrvgzdpvUx2fq+KcabhvM7rW/7UK
X-Gm-Gg: AR+sD10tYsGYQhdP3ypWZOhfgq1g7yPxT/ljXLvKnwOxs7Tai0nkGa0udnZ5F4P0xD2
 bpGEZq7wqL3yUBXkBKaaXwmoa5iganbP2k5/TjMJXGmBM5SZjDFcHyxp+2Z7vYHvPpBOq67s4Te
 GsffiSZ5eWecGqDAYVgQlVaL9Pm820UcMocT3kAk0kO+RAm7ILsdIr2f1ZXdgxC6hg7Ig6VqmqS
 wFs+Q6B0S/z9fnfiaXxwhkpFE2x310RMVY7nS/F0x8hXhGiudlNJmUAioP9gNdMua1u3KD8OoBt
 1dXCV8zHStdfqyf88LV4zBFtBc533+A9nSUGWGY0mlOZv1tHktYe2S6EQXFhBdJLBDUgsTa5V67
 Bd4iET8RDVxFNt8tvRNJRqhOKr0RBqNTGIofxFYo=
X-Received: by 2002:a05:6402:2811:b0:69a:a9d3:9fc with SMTP id
 4fb4d7f45d1cf-6a0984e887bmr360695a12.1.1785479565626; 
 Thu, 30 Jul 2026 23:32:45 -0700 (PDT)
X-Received: by 2002:a05:6402:2811:b0:69a:a9d3:9fc with SMTP id
 4fb4d7f45d1cf-6a0984e887bmr360660a12.1.1785479565186; 
 Thu, 30 Jul 2026 23:32:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c655626sm338210a12.22.2026.07.30.23.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:32:43 -0700 (PDT)
Message-ID: <bb1bb4da-cc0e-4f14-a7a0-eb4252925d0c@redhat.com>
Date: Fri, 31 Jul 2026 08:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio: make virtio_add_queue() queue_size an
 unsigned int
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 virtio-fs@lists.linux.dev, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Alexander Graf
 <graf@amazon.com>, Jason Wang <jasowangio@gmail.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-block@nongnu.org, Greg Kurz <groug@kaod.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Amit Shah <amit@kernel.org>
References: <20260730205846.19479-1-stefanha@redhat.com>
 <20260730205846.19479-2-stefanha@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260730205846.19479-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/30/26 22:58, Stefan Hajnoczi wrote:
> virtio_add_queue()'s queue_size argument is a signed int. The
> vdev->vq[i].vring.num and num_default fields are already declared as
> unsigned int, so change the virtio_add_queue() argument's type for
> consistency.
> 
> A note on consistency: the VIRTIO specification defines queue size as an
> unsigned 16-bit value. QEMU's device models variously use uint16_t,
> uint32_t, and other unsigned types for queue size qdev properties.
> virtio_add_queue() limits queue size to the much smaller
> VIRTQUEUE_MAX_SIZE (1024) constant, so the different widths don't really
> matter.
> 
> I have checked that all callers of virtio_add_queue() pass an unsigned
> queue size.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/hw/virtio/virtio.h | 2 +-
>   hw/virtio/virtio.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c99cb19d886..ff7f837fb92 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -302,7 +302,7 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
>   
>   typedef void (*VirtIOHandleOutput)(VirtIODevice *, VirtQueue *);
>   
> -VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
> +VirtQueue *virtio_add_queue(VirtIODevice *vdev, unsigned int queue_size,
>                               VirtIOHandleOutput handle_output);
>   
>   void virtio_del_queue(VirtIODevice *vdev, int n);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index daa5607338c..e1210f024c6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2564,7 +2564,7 @@ void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector)
>       }
>   }
>   
> -VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
> +VirtQueue *virtio_add_queue(VirtIODevice *vdev, unsigned int queue_size,
>                               VirtIOHandleOutput handle_output)
>   {
>       int i;


