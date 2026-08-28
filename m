Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FBFC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvVV-0002Bp-AP; Fri, 28 Aug 2026 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wzvVT-0002BU-Hq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wzvVR-0006Ro-Jd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787919383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NP7iQyp3d3npFz2QPR3YGYYaTucClh7lCRmDMNIgu4s=;
 b=ets9WLvzQvsak3McveHkpiOZnxVVZOTmxhHkIgUxZpG2M0WECX60mYTwTLNE2n2IvRPhf2
 tz5QGrKemptOiIOAAd/j6H4wORb6vaIB9RXK+V93KJb5uwS8kQTLb6lZbs9UeuS8FVQ4wh
 jxAl6m+0qftsPHH+ce3BKvS8QwV6oDw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Lamf0AFzOtWzblqfcrlt8A-1; Fri, 28 Aug 2026 08:16:22 -0400
X-MC-Unique: Lamf0AFzOtWzblqfcrlt8A-1
X-Mimecast-MFC-AGG-ID: Lamf0AFzOtWzblqfcrlt8A_1787919382
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81e6bb29581so12002557b3.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919382; cv=none;
 d=google.com; s=arc-20260327;
 b=EnNiUX8OIt1ExPfDF8qBPjMRG1WgAw+IEVzGrFI7wkR27u9YO0Jlr4qcYWlQs0moLu
 0KEQgDUjZdwBlicFY3Bez5vbicBsNI/QvLNaI7tPLHrdvweQOdeOGIoygORI8XJT+X84
 KD1MuYNBGmP7qpnlIRTQJ+e5fs4jofIcLO2zFwKEeofOHk2jpUmsfzuWCHQ2UrP2AsIM
 sFdHn/kInA80Sc2eMb9WOe1AT4jgFU79oJMKrWb0ninuHELI2W3qOrHqRwOZQjScdXnn
 CA/bhB/x6s9Z2wlEpOzCPAIjN7hulhCKLyRM5nlXgIBJnqvJWjffpZSWuEcChlTAyZ4T
 hIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NP7iQyp3d3npFz2QPR3YGYYaTucClh7lCRmDMNIgu4s=;
 fh=yg5daGthdVMj9fDITVijmPSN3ReNNkmmnmBt2RkEpmU=;
 b=QXhqjaNh4gxr7u6ziXYdmP3SroCUB5joWs2JnYySz+xGkztjsn8rEXG+D7LQOKmE9C
 sKvWTJUS2/6aCUht3yQaFqjXWzXkx5iBHQomH7/iOXsnuQUmDyvvwmZpNRFrjYyX7YOi
 Ragl77BDSkAIeSYa/QUOpxCoangU9dsGOXgSaZSqcMDRNVHEpSBrIpT7En6T9d0bf5JL
 EXjjW4S6wUf6ywtcsMYTroIEdBIMBhDo6lCcvPN7vfgZiDMwGDUAFDpGOAKzbiii11Al
 Ibxt94Kg2SaMMOZESYPC7nsem7CnLMp9LOAuCuP1YyxFv4e3mthEpagz7ZZyNp+f2iHu
 CX8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787919382; x=1788524182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NP7iQyp3d3npFz2QPR3YGYYaTucClh7lCRmDMNIgu4s=;
 b=M0zTXiN9Gm7mzlk9V95v2NoKkYN/Qc48GodyERcInO0twelMFmPXgGaben4TQsDf2F
 Cx+JGzePLMF4e1mx/ICYvtkcAvCT3zcSYsZHoPbE+fMXzOTId5PTIppW+pUwxIauU9SN
 NpfIFKTg7cANpNfd7ucjvc7+eRlUDwuN7eXXiRCP0pPH7BlnfXEqwV/MaM0DMfMFLHlf
 tpnZpCW10FFu7aVGY2MJ5xd4zJ3nA5t83zS7zPAynSRnap2ndqnu03RNypwf6RiJ+7tK
 3fQdJoOCXR68KP6RgyiQ1xZtQNgtlOuf4661JGS11SnWQ84CZbu2d49XhFA7sPeOZHJM
 L3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919382; x=1788524182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NP7iQyp3d3npFz2QPR3YGYYaTucClh7lCRmDMNIgu4s=;
 b=eYYxJRH82wPj/9Jh/AMKFvfOc5aJiJed9leXNiSUWbXTs/NYNqYPEO396Kw4SsYVD6
 pjguPtyF/8GmneApw4yV9dnnvlJ4ODHilIFKbvgMJNEd95htOQz1yex2Gv5z2F5Cme8p
 17+X9lHIJJM7MIyRhVhu5IgCJplQMM9+HwOLpGbFyCfj8izlb9k57j2L/p6t8c4M2ADE
 Vu0m5G3GmwCprqyx8JXheDYW8qbdD9Xo5FXoaoMj9d0a/mMmvZZw2NEIBZZ5fhBtaj41
 i9BC9/FZQzDVn+gTZoY/DSEEiKY0WLZoSAkU9uFW3Gy9LkEbKZ3Y5nqOmyX49FmEVA7p
 SSjA==
X-Gm-Message-State: AFuF++nX2/gn5Ho+/umRworkjD2ZZfQmND2+KKmXsvigaJKac+NLOW9N
 6lNUQG2R3lnjYyymyXcwAqNGH+TliGkQzzPZeUQzHyN8Urlkqx9WJQGdUf20nOZcW/frJAGIfw0
 tJ41wSAsIPJ6+jxPa9HDeYdTaUi2vzRtw1fVVpixMI8HjjMi5WPVIpJRHlcUX9Zq+3wtOqkSSEI
 9v4oWVUgBQ1o+hGz3jat/CHXQ1+cdP2kI=
X-Gm-Gg: AYBFou00Y396zHeb8KaSUWFFQvis/itqPHP4DTJc6/l6nczvzrVJow8/eorHEif+5x+
 I6TSqwf6QYAU+t6CpWTCl5ZOmp1UCKp+RixDnWVzK2pave6mYGCSA1SWmU5gMNTbZarG5ympJho
 lucuqAGD1buVjxLFHtEVQ+LSP1tVA11D8KZMummmGRSFabDqj3a4Hr34bgVGizVC3Dnk7WNvpL/
 Wp3sAnGLuotj6RcKr+HaQiaZ4YliE8qhpLg0ZjDMPvWJwAJP9RcmZeE8K4=
X-Received: by 2002:a05:690c:c4f1:b0:814:585f:73c8 with SMTP id
 00721157ae682-85d5feceaf2mr28516237b3.0.1787919381642; 
 Fri, 28 Aug 2026 05:16:21 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f1:b0:814:585f:73c8 with SMTP id
 00721157ae682-85d5feceaf2mr28515827b3.0.1787919381156; Fri, 28 Aug 2026
 05:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-5-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-5-948aae960abb@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 28 Aug 2026 14:15:44 +0200
X-Gm-Features: AcwNN1V9jSnTneck_2Wd0unjGb7Spui0y8bYGe2l7i_08vxr2fE-rAM-G89C-Us
Message-ID: <CAJaqyWcO3bSakzykPr-p=eBrqntNaTdUuvZdo2-B_DVxrt6wjw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/13] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Alyssa Ross <hi@alyssa.is>, 
 Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Tue, Aug 18, 2026 at 7:12=E2=80=AFAM Connor Kite <connorkite@gmail.com> =
wrote:
>
> By default svq vrings are placed in an anonymous memory map. As svqs
> will be leveraged to enable memory isolation in vhost-user, it is useful
> to be able to place the vrings in a shared isolation memory region.
>
> Adds the option to specify vring placement by providing a vring base
> address before starting the svq.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 69 ++++++++++++++++++++++++++++++++=
------
>  hw/virtio/vhost-shadow-virtqueue.h |  8 ++++-
>  2 files changed, 66 insertions(+), 11 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 496e7e58a3..f54a61439a 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -812,6 +812,13 @@ size_t vhost_svq_device_area_size(const VhostShadowV=
irtqueue *svq)
>      return ROUND_UP(used_size, qemu_real_host_page_size());
>  }
>
> +size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VhostShadowVirtqueue svq;
> +    svq.vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_index(=
vq));
> +    return vhost_svq_driver_area_size(&svq) + vhost_svq_device_area_size=
(&svq);
> +}
> +
>  /**
>   * Set a new file descriptor for the guest to kick the SVQ and notify fo=
r avail
>   *
> @@ -842,6 +849,19 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue =
*svq, int svq_kick_fd)
>      }
>  }
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
> +    svq->base_addr =3D addr;
> + }
> +

Would it work to keep that allocation detail in SVQ, instead of
letting it leak outside? Something like a flag to allocate the areas
with mmap or qemu_memfd_alloc, instead of the base_addr itself.

> +
>  /**
>   * Start the shadow virtqueue operation.
>   *
> @@ -849,8 +869,10 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue =
*svq, int svq_kick_fd)
>   * @vdev: VirtIO device
>   * @vq: Virtqueue to shadow
>   * @iova_tree: Tree to perform descriptors translations
> + *
> + * Return 0 on success, -errno on failure
>   */
> -void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
> +int vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                       VirtQueue *vq, VhostIOVATree *iova_tree)
>  {
>      size_t desc_size;
> @@ -868,14 +890,27 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Vir=
tIODevice *vdev,
>
>      svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_index=
(vq));
>      svq->num_free =3D svq->vring.num;
> -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
>      desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
> -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
> +    if (svq->base_addr =3D=3D NULL) {
> +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANO=
NYMOUS,
> +                            -1, 0);
> +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_siz=
e);
> +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANO=
NYMOUS,
> +                            -1, 0);
> +    } else {
> +        svq->vring.desc =3D (void *)svq->base_addr;
> +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_siz=
e);
> +        svq->vring.used =3D (void *)((char *)svq->base_addr +
> +                          vhost_svq_driver_area_size(svq));
> +
> +        if ((uint64_t)svq->vring.used + vhost_svq_device_area_size(svq) =
- 1 <
> +           (uint64_t)svq->vring.desc) {
> +                error_report("Invalid shadow vring location");
> +                return -ENOMEM;
> +        }
> +    }
>      svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
>      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
>          svq->batch_last.id =3D VIRTIO_RING_NOT_IN_BATCH;
> @@ -884,6 +919,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtI=
ODevice *vdev,
>              svq->desc_state[i].next =3D i + 1;
>          }
>      }
> +
> +    return 0;
>  }
>
>  /**
> @@ -920,8 +957,19 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
>      }
>      svq->vq =3D NULL;
>      g_free(svq->desc_state);
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
> +    }
> +
>      event_notifier_set_handler(&svq->hdev_call, NULL);
>  }
>
> @@ -940,6 +988,7 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadow=
VirtqueueOps *ops,
>      event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
>      svq->ops =3D ops;
>      svq->ops_opaque =3D ops_opaque;
> +    svq->base_addr =3D NULL;
>      return svq;
>  }
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index fd68319fb7..1e0cc9e5e4 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -150,6 +150,9 @@ typedef struct VhostShadowVirtqueue {
>
>      /* Size of SVQ vring free descriptors */
>      uint16_t num_free;
> +
> +    /* Location assigned to vrings if not in default anon memory map */
> +    void *base_addr;
>  } VhostShadowVirtqueue;
>
>  bool vhost_svq_valid_features(uint64_t features, Error **errp);
> @@ -169,8 +172,9 @@ void vhost_svq_get_vring_addr(const VhostShadowVirtqu=
eue *svq,
>                                struct vhost_vring_addr *addr);
>  size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
>  size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
> +size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq);
>
> -void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
> +int vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                       VirtQueue *vq, VhostIOVATree *iova_tree);
>  void vhost_svq_stop(VhostShadowVirtqueue *svq);
>
> @@ -178,6 +182,8 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadow=
VirtqueueOps *ops,
>                                      void *ops_opaque);
>
>  void vhost_svq_free(gpointer vq);
> +void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr);
> +
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostShadowVirtqueue, vhost_svq_free);
>
>  #endif
>
> --
> 2.43.0
>


