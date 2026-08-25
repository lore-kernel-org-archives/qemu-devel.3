Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25028C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wys6v-0003gL-1y; Tue, 25 Aug 2026 10:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wys6t-0003g0-A5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wys6q-0003Gv-Oy
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787667996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBjcdBfvoewouVOB1p8YoexCwmn0WGX7vbnG4qWEdCg=;
 b=i2ibStgDm8OykQUXGDVUiQIIgq+YAeCcYvHOO7znb3j5dOd1z0ilVO/w1f2Um4QD/uRXib
 3rpNfcg/QMJqgfOWq8OMBRMH0akCsZzFaQysi6rsk70SFmhSjvPr1e3VsEIg7AGafMTqxQ
 K6bfL8uX0sDRNXpYEdJzk5+qgM7b04c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-AVfVYHBNPWumK5kdgQsaBg-1; Tue, 25 Aug 2026 10:26:35 -0400
X-MC-Unique: AVfVYHBNPWumK5kdgQsaBg-1
X-Mimecast-MFC-AGG-ID: AVfVYHBNPWumK5kdgQsaBg_1787667994
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-698b899b53cso4296758a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787667994; x=1788272794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eBjcdBfvoewouVOB1p8YoexCwmn0WGX7vbnG4qWEdCg=;
 b=Rsf7Z5P4DyYoONyabS9YNbkLXCdK+5V9970rPchxgfwu/OYdrE4wADJGjhl1pc7GU1
 3FQG8zrZ1IdyKJytRaNPmyedz2o4gO3d97N2oA/qaGs/cSh/21HfKjwrwm1SmHQm0SwH
 SJauRbmYgMEzx/3ejSmjf4bFLqeFw7f/8bP3J5nXtqfswxPsaOyCKCeDO2m/SmzSjjn8
 1S2Ddh2ej0Uz7ruf8ogRlsQXe7zzupB6fXZ19vWvDnX1HtQASsNHowwATIxe1UJZg4H7
 4f/KXa6LlMqbnPg1sxUfgVtLxXpmILu3CLDiSwvLTC+HaUR1VKwyXrbtJ/wnHFaOHmR+
 9zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667994; x=1788272794;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBjcdBfvoewouVOB1p8YoexCwmn0WGX7vbnG4qWEdCg=;
 b=JTX89af1It3ikFk8AXL9OQnKi5jEzwA46shmZ+uaGSI/srKjcClHxESNM8YMjv1Ls4
 zVyJ4dgLrWz7sHHab1kQXAvEUfxmYUpRbuUlbKP+Bi5KSv3FD6ixgxvK/ncsbHKUqPNa
 qurjgeEt1+eviZeN5piupav4LMkL1HvFk0mLLe760R3HRs1IyFPl11qx3k2/pK9Mv1l/
 Tna7zOa0NXdoGv9j8fSQaMPwhy+/jbPZR5iRucZomRc1MseNCxRt/Gd/LXjtKWeiW0pk
 U2BpZAFcB4ikdCkiXnU2ZEPHlvx2ltmfjhndG2ArZdeENRDzQAwClOonPmDzixK1q04J
 D4fw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4A2nEEtZhz80Kl/RjqDNPUmw8DmlRIJhK+qqv6Uo/SAY5tCDwXAu0XB2DE/sVm/1AUpXZNNx6AXUH@nongnu.org
X-Gm-Message-State: AFuF++nJGItd5bSG2jXYNkYfJYn/L4RQZEu8hnBnwxm8IVJDftrE1SRQ
 +DM7V9wQDyukaI274s9Tp1X4FkMg8Gm5yAfIC3KbIEeVVlAGJIhvwkWyjsokvOFHcxZtZksRQW8
 wlpB+AR2MCaPqmHZ5irrgZSQBFk5L3SAeFckIeBoXrAoc3tYO7CNuWbXm
X-Gm-Gg: AR+sD12P7B0jwLo4PniB453x3iJgRjC0ozfo0KlizoudD3SfMlW9/S5EhBcXEXcHfCO
 +Hfcq66fc9KksFukyNss0BBLZbs0Au4ktmsM8GL5pYbjEQyjdq0AKKp8xynvhLE4/w3X4yAB4Mj
 JGZmOFJrtLP6EiuQm6ql4ytTIYuAEiMjqoM69qzu1aKrM/N+2BlY+uULzy6YTw1BfX30wiYxf93
 jms5MgwpdFO1oHhogMBe2XYHu7lRrbkrCZuoagnPzcPJ2ahVL+A2YebCYTWJXfiAa64bn7fXeRj
 3KT/ZUurtQyieSDdNnzYYFgtVHIsmcnblvoD5wCC/7C/iK4LZhMl0bYJEnwAe+LyKyJtoohEK57
 ILc9nkCbwuI/FPWEVQAq2ZxTKAobO311cg01ockt0r2pfZZYs8isNO1sQZ1Q61KAQlced0S0BBi
 t0uAdOIrxsbbYpB0CyHhVJ1glh4QRpDw==
X-Received: by 2002:a05:6402:3805:b0:6a3:87b7:b5a9 with SMTP id
 4fb4d7f45d1cf-6a5c412fd8emr9529028a12.12.1787667993915; 
 Tue, 25 Aug 2026 07:26:33 -0700 (PDT)
X-Received: by 2002:a05:6402:3805:b0:6a3:87b7:b5a9 with SMTP id
 4fb4d7f45d1cf-6a5c412fd8emr9528927a12.12.1787667993410; 
 Tue, 25 Aug 2026 07:26:33 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70a:12bf:c327:80a0:6d65:31e3?
 (p200300cfd70a12bfc32780a06d6531e3.dip0.t-ipconnect.de.
 [2003:cf:d70a:12bf:c327:80a0:6d65:31e3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1d741asm14271081a12.27.2026.08.25.07.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 07:26:32 -0700 (PDT)
Message-ID: <5d91e894-c54e-4dc5-bb3f-463c14b6fda0@redhat.com>
Date: Tue, 25 Aug 2026 16:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/13] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
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
 Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-5-948aae960abb@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-5-948aae960abb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 18.08.26 07:12, Connor Kite wrote:
> By default svq vrings are placed in an anonymous memory map. As svqs
> will be leveraged to enable memory isolation in vhost-user, it is useful
> to be able to place the vrings in a shared isolation memory region.
>
> Adds the option to specify vring placement by providing a vring base
> address before starting the svq.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c | 69 ++++++++++++++++++++++++++++++++------
>   hw/virtio/vhost-shadow-virtqueue.h |  8 ++++-
>   2 files changed, 66 insertions(+), 11 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 496e7e58a3..f54a61439a 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -812,6 +812,13 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
>       return ROUND_UP(used_size, qemu_real_host_page_size());
>   }
>   
> +size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq)

If this function is not used in this patch, it probably should not be 
introduced here.

> +{
> +    VhostShadowVirtqueue svq;
> +    svq.vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
> +    return vhost_svq_driver_area_size(&svq) + vhost_svq_device_area_size(&svq);

I’m not 100 % happy about this (initializing a pseudo svq), might be 
better to make it so there are vhost_svq_driver/device_area_size() 
variants that take the num directly, and then have 
vhost_svq_driver/device_area_size() be wrappers around it, but, well. At 
least the implementations are right above it so one can verify that 
nothing else in VhostShadowVirtqueue is used. (It’s just that one should 
not *have* to verify.)

> +}
> +
>   /**
>    * Set a new file descriptor for the guest to kick the SVQ and notify for avail
>    *
> @@ -842,6 +849,19 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
>       }
>   }
>   
> +/**
> + * Set vring base address if using fixed locations
> + *
> + * @svq: Shadow Virtqueue
> + * @addr: Points to new base address
> + */
> +
> + void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr)
> + {
> +    svq->base_addr = addr;
> + }
> +
> +
>   /**
>    * Start the shadow virtqueue operation.
>    *
> @@ -849,8 +869,10 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
>    * @vdev: VirtIO device
>    * @vq: Virtqueue to shadow
>    * @iova_tree: Tree to perform descriptors translations
> + *
> + * Return 0 on success, -errno on failure
>    */
> -void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
> +int vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                        VirtQueue *vq, VhostIOVATree *iova_tree)
>   {
>       size_t desc_size;
> @@ -868,14 +890,27 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>   
>       svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
>       svq->num_free = svq->vring.num;
> -    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> -                           -1, 0);
>       desc_size = sizeof(vring_desc_t) * svq->vring.num;
> -    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
> -    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> -                           -1, 0);
> +    if (svq->base_addr == NULL) {
> +        svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> +                            -1, 0);
> +        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
> +        svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> +                            -1, 0);
> +    } else {
> +        svq->vring.desc = (void *)svq->base_addr;
> +        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
> +        svq->vring.used = (void *)((char *)svq->base_addr +
> +                          vhost_svq_driver_area_size(svq));
> +
> +        if ((uint64_t)svq->vring.used + vhost_svq_device_area_size(svq) - 1 <
> +           (uint64_t)svq->vring.desc) {
> +                error_report("Invalid shadow vring location");
> +                return -ENOMEM;
> +        }

Why does this check exist?

What needs to be done here is proper bounds checking. That either `.used 
+ device_area_size()` or `desc + vhost_svq_vring_total_size()` does not 
exceed the end of the memory region that has been allocated for the 
vrings. It is clear that such an allocation would never wrap around the 
end of memory because no allocation ever does.

> +    }
>       svq->desc_state = g_new0(SVQDescState, svq->vring.num);
>       if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
>           svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
> @@ -884,6 +919,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>               svq->desc_state[i].next = i + 1;
>           }
>       }
> +
> +    return 0;
>   }
>   
>   /**
> @@ -920,8 +957,19 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
>       }
>       svq->vq = NULL;
>       g_free(svq->desc_state);
> -    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
> -    munmap(svq->vring.used, vhost_svq_device_area_size(svq));
> +
> +    if (!svq->base_addr) {
> +        munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
> +        munmap(svq->vring.used, vhost_svq_device_area_size(svq));
> +    } else{
> +        if (svq->vring.desc) {
> +            memset(svq->vring.desc, 0, vhost_svq_driver_area_size(svq));
> +        }
> +        if (svq->vring.used) {
> +            memset(svq->vring.used, 0, vhost_svq_device_area_size(svq));
> +        }

Why the memset()?

Hanna

> +    }
> +
>       event_notifier_set_handler(&svq->hdev_call, NULL);
>   }
>   
> @@ -940,6 +988,7 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
>       event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
>       svq->ops = ops;
>       svq->ops_opaque = ops_opaque;
> +    svq->base_addr = NULL;
>       return svq;
>   }
>   
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
> index fd68319fb7..1e0cc9e5e4 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -150,6 +150,9 @@ typedef struct VhostShadowVirtqueue {
>   
>       /* Size of SVQ vring free descriptors */
>       uint16_t num_free;
> +
> +    /* Location assigned to vrings if not in default anon memory map */
> +    void *base_addr;
>   } VhostShadowVirtqueue;
>   
>   bool vhost_svq_valid_features(uint64_t features, Error **errp);
> @@ -169,8 +172,9 @@ void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
>                                 struct vhost_vring_addr *addr);
>   size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
>   size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
> +size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq);
>   
> -void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
> +int vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                        VirtQueue *vq, VhostIOVATree *iova_tree);
>   void vhost_svq_stop(VhostShadowVirtqueue *svq);
>   
> @@ -178,6 +182,8 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
>                                       void *ops_opaque);
>   
>   void vhost_svq_free(gpointer vq);
> +void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr);
> +
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostShadowVirtqueue, vhost_svq_free);
>   
>   #endif
>


