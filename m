Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF80C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqtNM-0007SS-7Z; Mon, 03 Aug 2026 10:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqtNL-0007S5-1u
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqtNI-0001XG-Ra
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785766239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IO7jLzfsYidO3HRZ6d9qJEPtFXa8LntYflQCNDbj8AE=;
 b=Lz9AihJkLDHGkk29qTbWbJXF7FsjGjcu2RVjmLoRS4DB+vAS/VI3AKri/gJUT5vqgBoFfc
 TBgVYKFhD3cE8Heom4HzUSVdwsBcDpZaNY6XrPVsLAWUQbLrqJmDo+VXNI3GIO59GQ4U3B
 sDAr9lJ330MNldEC/LGQIOByzsHd+w0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-r72_j32ZMM6nrqkPVmVV-A-1; Mon, 03 Aug 2026 10:10:33 -0400
X-MC-Unique: r72_j32ZMM6nrqkPVmVV-A-1
X-Mimecast-MFC-AGG-ID: r72_j32ZMM6nrqkPVmVV-A_1785766232
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496b61bd846so18252875e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785766232; x=1786371032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IO7jLzfsYidO3HRZ6d9qJEPtFXa8LntYflQCNDbj8AE=;
 b=DzoPWi/cTl1leYTDrriVj/usJPFhLxrcubf6r/YwSq76A6BJwxWIdazktwTg6Djvun
 MdL/vVsuFTN1u0JqmqXuZfG07pHqXd8MHwugPZuWlQBJ2AluOnzVug4q/j2WLw1Pwz1g
 s2AcYwvLJVxr4tV31myj73tjx1wc/SLlYq8YjQPwXe481wAImihHlJnlB0ent1l7Woq/
 4cFQVCVV6poWcxQY5DKBP1z99B0BkG2uUYPO/g+KmsMg+HoUO3Z4pYbBTyeJI0fdN+3W
 YAhBIJyNv8C+6jnNrNJhZB3UYbNu5Vl06vOhjw4bHY0BJkeLIY6TgJyf5qMc9s6YBgNK
 MHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785766232; x=1786371032;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IO7jLzfsYidO3HRZ6d9qJEPtFXa8LntYflQCNDbj8AE=;
 b=RF0V+IT6oWGtv1C2zmW1HQcvCvMUVLwzBTF/g+yE7kY5s339H6P3dX5jeungAhdsvc
 NLBssrNdPShDYpZOp6dP1WCdBaEFh5ZutrNkxjC6ausvafsBTv1htESq8mNmF/TNoFEz
 icBdfBchvVxwBsQ02/P7QgOHxnET0R65uogeeizNhI0wHdwL92N1dfjOplkdHJN+YPIX
 JB2FyiPXDwDQR9Qy0h5EsmPhWO0xH72ecDmykOurFwZ1nAk57+ZwWD6TtMFc1RGnQ9Zr
 IT6S4Ilz4TryJyKtVKPrWozjF8syauIzOwZqeYbhiGI27QMtesf8+6TMyr2FIbuaXeEu
 hAWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDBjwLRMTdd0wJZeN4WXsWrWI0PIrN7yUhu0GcKBN5GWUr98OmznykMHlXLT/r0VRLaYr0ZseMSWvU@nongnu.org
X-Gm-Message-State: AOJu0YwsCCIpIbJs5zcvA5PsDEe6qNPBBbDzVNgmI1migwjNCF/0CGCa
 CsklJBfYwy3npKOa5Ol7uZ8rsWoM8S050FX7ciJTb+gjFEnrAS6Zaqfe+fMTi9+4h2ftUQNu9go
 WM2OC01YRkln4PTeVS6EmDjyUIvnjQ+8asQCpbiXX8Jc270lLQpD+M1IH
X-Gm-Gg: AR+sD109vRAY6iJb7R8b1CoF41hHR0pTXTw/j+kUlCHGky3D8fcp64feeFfR3E9xzYW
 tgT7KWaWz2jjliqjr146B+28SbfewQFbKd77JWFmW42J91McscCsqspHARWogQ6zBTAFeqCktDT
 /yZBKmzK8tL1CZHHH/0p4vvsk9k0/SqyAMKcnn3gObto4doGiE8pH1wP5kY0NPBBHFrQVLlVTTh
 m+sbyI+3rWb5h8fXst0+TJm4mXXmKSVQ+Nbx6wItoBOTUoJm4H/zi/1XJLP6CU5p/XPdfwkyaOd
 3mdjwIcJIzBoHkBw//Q1/bIuRovzXNbKjkNZ5LAl6V4tZpewhhxWeOP7uYdOVFIuuH1KmdgHeDl
 ZJI2WTYK+SH1SjfWii+Q75y40ZQmRuYAtz1UU45pXgpOaqQi0b2OZX2WDyXUQVPGMkhLw56qhFS
 KIO21sOsYLEA4EtHaymWw707JVZUBewQ==
X-Received: by 2002:a05:600c:840f:b0:495:4b24:1b64 with SMTP id
 5b1f17b1804b1-4980c601d19mr211597925e9.0.1785766230755; 
 Mon, 03 Aug 2026 07:10:30 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:495:4b24:1b64 with SMTP id
 5b1f17b1804b1-4980c601d19mr211594245e9.0.1785766228575; 
 Mon, 03 Aug 2026 07:10:28 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d0064sm32186241f8f.5.2026.08.03.07.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 07:10:27 -0700 (PDT)
Message-ID: <31183362-f4b6-4afd-8c6d-2e1b5db35225@redhat.com>
Date: Mon, 3 Aug 2026 16:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/15] hw/virtio/vhost-user: handle data movement with
 shadow vqs
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-14-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-14-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 24.07.26 00:30, Connor Kite wrote:
> - Add start logic for shadow virtqueues, which sets vring addresses.
> - Update logic for sending vring addresses to backend to point
>    to the shadow vrings when isolation mode is active.
> - Implement handlers for intercepted avail and used descriptors. These
>    handlers copy buffer contents between bounce buffers in the isolation
>    region and the buffers made available by the guest
> - Implement logic to stop svqs
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 166 insertions(+), 1 deletion(-)

In general, I find it strange to use two completely separate data 
structures for the address translation in either direction (avail/used). 
I suppose we could have a map of in-flight translations, adding entries 
in avail, and looking for them in used, removing them from the map.

I mean, sure, right now, we can calculate the addresses, because we 
“duplicate” the whole range of guest memory for each device, but that is 
clearly a waste and it would be better to use a smaller size in the 
future; and then each request will need to allocate from that smaller 
device memory, get a random address, and that will need such a map for 
tracking.

> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 75858289a2..e65f877f9a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1299,6 +1299,97 @@ static int init_isolation_regions(struct vhost_dev *dev,
>       return 0;
>   }
>   
> +static int vhost_user_memory_lookup(struct vhost_dev *dev, hwaddr gpa,
> +                                    hwaddr *hva)
> +{
> +    int i;
> +    hwaddr offset;
> +
> +    for (i = 0; i < dev->mem->nregions; i++) {
> +        struct vhost_memory_region *reg = dev->mem->regions + i;
> +
> +        if (gpa >= reg->guest_phys_addr &&
> +            reg->guest_phys_addr + reg->memory_size > gpa) {
> +            offset = gpa - reg->guest_phys_addr;
> +            *hva = reg->userspace_addr + offset;
> +            return 0;
> +        }
> +    }
> +
> +    return -EFAULT;
> +}
> +
> +static int vhost_user_svq_handle_used(VhostShadowVirtqueue *svq,
> +                                      VirtQueueElement *elem,
> +                                      void *opaque)
> +{
> +    hwaddr hva;
> +    int r;
> +    struct vhost_dev *dev = opaque;
> +
> +    for (int i = 0; i < elem->in_num; i++) {
> +        r = vhost_user_memory_lookup(dev, elem->in_addr[i], &hva);

This function only looks for the starting address, so it is not 
guaranteed that the whole buffer is within one memory region.

> +        if (r < 0) {
> +            return r;
> +        }
> +
> +        memcpy((void *) hva, elem->in_sg[i].iov_base, elem->in_sg[i].iov_len);
> +        elem->in_sg[i].iov_base = (void *) hva;
> +    }
> +
> +    for (int i = 0; i < elem->out_num; i++) {
> +        r = vhost_user_memory_lookup(dev, elem->out_addr[i], &hva);
> +        if (r < 0) {
> +            return r;
> +        }
> +
> +        memcpy((void *) hva, elem->out_sg[i].iov_base, elem->out_sg[i].iov_len);

I don’t think we need this `memcpy()` here, as the device may only write 
to IN buffers, not OUT buffers.

> +        elem->out_sg[i].iov_base = (void *) hva;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_user_svq_handle_avail(VhostShadowVirtqueue *svq,
> +                                       VirtQueueElement *elem,
> +                                       void *opaque)
> +{
> +    hwaddr offset;
> +    const DMAMap *map;
> +    DMAMap needle;
> +    hwaddr *iova_base;
> +
> +    for (int i = 0; i < elem->out_num; i++) {
> +        needle.translated_addr = elem->out_addr[i];
> +        needle.size = elem->out_sg[i].iov_len - 1;
> +        map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);

Is it guaranteed that the returned `map` will fully contain `needle`?

> +        offset = needle.translated_addr - map->translated_addr;
> +        iova_base = (void *)(map->iova + offset);
> +
> +        elem->out_sg[i].iov_base = iova_base;
> +        memcpy(iova_base, elem->out_sg[i].iov_base, needle.size + 1);
> +    }
> +
> +    for (int i = 0; i < elem->in_num; i++) {
> +        needle.translated_addr = elem->in_addr[i];
> +        needle.size = elem->in_sg[i].iov_len - 1;
> +        map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
> +        offset = needle.translated_addr - map->translated_addr;
> +        iova_base = (void *)(map->iova + offset);
> +
> +        elem->in_sg[i].iov_base = iova_base;
> +        memcpy(iova_base, elem->in_sg[i].iov_base, needle.size + 1);

I don’t think we need this `memcpy()` here as the device is to strictly 
write to IN buffers, not read from them.

> +    }
> +
> +    vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->out_addr,
> +                  elem->in_sg, elem->in_num, elem->in_addr, elem);

Might make sense to make vhost_svq_add_element() public and use it here.

> +
> +    return 0;
> +}
> +
> +
> +
> +
>   static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                       struct vhost_memory *mem)
>   {
> @@ -1772,6 +1863,8 @@ static int vhost_user_set_vring_err(struct vhost_dev *dev,
>   static int vhost_user_set_vring_addr(struct vhost_dev *dev,
>                                        struct vhost_vring_addr *addr)
>   {
> +    struct vhost_user *u = dev->opaque;
> +
>       VhostUserMsg msg = {
>           .hdr.request = VHOST_USER_SET_VRING_ADDR,
>           .hdr.flags = VHOST_USER_VERSION,
> @@ -1779,6 +1872,25 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
>           .hdr.size = sizeof(msg.payload.addr),
>       };
>   
> +    if (u->user->memory_isolation) {
> +        if (!u->svqs_allocated) {
> +            return 0;
> +        }
> +
> +        int svq_idx = addr->index - dev->vq_index;
> +        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs,
> +                                                      svq_idx);

Again, bounds checking via `vhost_user_get_vq_index()` would be good.

> +
> +        struct vhost_vring_addr svq_addr = {
> +            .avail_user_addr = (uint64_t)(uintptr_t)svq->vring.avail,
> +            .desc_user_addr = (uint64_t)(uintptr_t)svq->vring.desc,
> +            .used_user_addr = (uint64_t)(uintptr_t)svq->vring.used,
> +            .index = addr->index,
> +        };
> +
> +        msg.payload.addr = svq_addr;
> +    }
> +
>       /*
>        * wait for a reply if logging is enabled to make sure
>        * backend is actually logging changes
> @@ -2754,13 +2866,18 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>       return 0;
>   }
>   
> +static const VhostShadowVirtqueueOps vhost_user_svq_ops = {
> +    .avail_handler = vhost_user_svq_handle_avail,
> +    .used_handler = vhost_user_svq_handle_used
> +};
> +
>   static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user *u)
>   {
>       /*Modified from vhost-vdpa*/
>       u->shadow_vqs = g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
>       for (int i = 0; i < dev->nvqs; i++) {
>           VhostShadowVirtqueue *svq;
> -        svq = vhost_svq_new(NULL, NULL);
> +        svq = vhost_svq_new(&vhost_user_svq_ops, dev);
>           g_ptr_array_add(u->shadow_vqs, svq);
>       }
>   }
> @@ -3466,8 +3583,56 @@ void vhost_user_async_close(DeviceState *d,
>       }
>   }
>   
> +static bool vhost_user_svqs_start(struct vhost_dev *dev)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    uint64_t vring_base = u->iso_memory.vring_base_addr;
> +    u->svqs_allocated = true;

I don’t like setting this before it actually being the case very much. I 
understand that it is necessary for how you decided to set up 
`vhost_user_set_vring_addr()`, but there should at least be a comment 
(because reading this code, there is the obvious question: Why is this 
set when it is not true?); or the code should be different. I.e. having 
a `vhost_user_set_shadow_vring_addr()` function, maybe, which would not 
even take an `addr` argument and could be used both below and in 
`vhost_user_set_vring_addr()`.

> +
> +    for (int i = 0; i < u->shadow_vqs->len; i++) {
> +        VirtQueue *vq = virtio_get_queue(dev->vdev, dev->vq_index + i);
> +        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs, i);
> +        svq->base_addr = (hwaddr *) vring_base;

I really do not like the lack of bounds checking here again. There 
should be something, somewhere (i.e. in the “Isolated memory data” 
portion, maybe in `struct IsolationRegion`), that tells how much memory 
has been allocated for the shadow virtqueues, and we need to check that 
we do not overflow.

> +        vhost_svq_start(svq, dev->vdev, vq, u->iso_iova_tree);
> +
> +        struct vhost_vring_addr addr = {
> +            .index = dev->vq_index + i,
> +            .desc_user_addr = vring_base,
> +            .avail_user_addr = vring_base + sizeof(vring_desc_t) *
> +                svq->vring.num,
> +            .used_user_addr = vring_base + vhost_svq_driver_area_size(svq)

All values set here are effectively ignored, right? Because 
`vhost_user_set_vring_addr()` just overwrites them. (Having a 
`vhost_user_set_shadow_vring_addr()` could maybe save us from having to 
set this up.)

Not that it’s currently wrong to set them this way, just asking.

Hanna

> +        };
> +
> +        vhost_user_set_vring_addr(dev, &addr);
> +
> +        vring_base += vhost_svq_device_area_size(svq) +
> +                      vhost_svq_driver_area_size(svq);
> +    }
> +
> +    return false;
> +}
> +
> +static void vhost_user_svqs_stop(struct vhost_dev *dev)
> +{
> +    struct vhost_user *u = dev->opaque;
> +
> +    for (int i = 0; i < u->shadow_vqs->len; i++) {
> +        vhost_svq_stop(g_ptr_array_index(u->shadow_vqs, i));
> +    }
> +}
> +
> +
>   static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
>   {
> +    struct vhost_user *u = dev->opaque;
> +    if (u->user->memory_isolation) {
> +        if (started) {
> +            vhost_user_svqs_start(dev);
> +        } else {
> +            vhost_user_svqs_stop(dev);
> +        }
> +    }
> +
>       if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
>           return 0;
>       }
>


