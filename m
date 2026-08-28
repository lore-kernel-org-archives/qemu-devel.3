Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E1DC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzve7-0005k9-Ig; Fri, 28 Aug 2026 08:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wzve6-0005ji-4g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wzve2-0000w6-Ai
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787919916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0tMs94sb+aFfcub2Wo5fCNJJlmTEWWroFUOWHWnK2I=;
 b=XUkREhuaoOmLLSxlXjO3ofVRamywLSLgvoRyAPes+8fwwzgl2DIQQVj/2njKIEY1tqz8/c
 cYyDeGCmMVj4AOsTNswgoJq8ySaBYcRlwwV809W74Fq868R2c05kOs85wRQiIdlIz1P6+a
 JTx7aHCv32AeH11LNFG2QUPFBsNd40s=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-gGD7XBRuM2iQUJZDJHdjeQ-1; Fri, 28 Aug 2026 08:25:15 -0400
X-MC-Unique: gGD7XBRuM2iQUJZDJHdjeQ-1
X-Mimecast-MFC-AGG-ID: gGD7XBRuM2iQUJZDJHdjeQ_1787919915
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8578f9a0975so18809157b3.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919915; cv=none;
 d=google.com; s=arc-20260327;
 b=nyI5nPhet3ej6k7qgoPKAR59B35plTWfPZf4Wz512GTAKFSD+jc9+ZpQ0FPDWXmBBy
 kOOnMXJbQhHICCE5NSsLTf53nGYMKZ9jRtCQg/FORKZtkptFEaFZekwblrwtcumDMcGN
 uj5cGGL/ePlirwi2EwY1zVkKseKgTgsusVoafTe0wZ17UekDDh3jyUKE94pFTOwuXfWS
 cDlr/Tr37ouEhtn5Pjj9wpFeOudrFLhRdegRLxWkur1iAgUVjtli1+wmZaVMU4jRNk97
 OEerRDBJ0JCpd/VIbrKZIjtk/vuq7t+CG+9K0ds0zN0jriKGE0LpjjRMkiIiMmGOI4sw
 XYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j0tMs94sb+aFfcub2Wo5fCNJJlmTEWWroFUOWHWnK2I=;
 fh=yg5daGthdVMj9fDITVijmPSN3ReNNkmmnmBt2RkEpmU=;
 b=k9/4N9RlmkpAPfy+qLsOQMKiEuPqpfJ80ZIDqgFq0L4ix9V8AICncBQSMWcRVmVyfU
 66NklDNFTwfZZmQV0CqMCNr6r8dUQG9PAdVQrrgZWhby8/naVsRR8bgnkRD6RnZiafgM
 TwwCDL+d+oHkLGORenVIzoX+aBt+iTuucmWfTX/vTK9bPlFtRhotyqG4ZMeCi4clZavE
 ezlkUphF9bY1/4sa9Opz0XP/es0Cd+OJ8WJYTfDlKq1aKTCvu1tnqgONscLbTFrQ2UhD
 VCprhQ2J++BWBSKdUMNVjI2M6OAvrRbDRN7EZuo8bs7YJSqZw3FJwGt7jUYl7UvSqtG2
 L4qQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787919915; x=1788524715; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j0tMs94sb+aFfcub2Wo5fCNJJlmTEWWroFUOWHWnK2I=;
 b=auCY6dlDO9ueZFJpwWW1MYHkTGsINWveezXiMI2TpCkUOdQ+fxK0ZS3kLb3XJki3q2
 Ij94x5lDgtR1d88iVRaz+dEbaPCdQ8b3CW580nZTWj+bqKhzqeVlWya2eNAZcZYyCwN9
 ua0OxbUuHGdRAXpZYf94alAZVoPm5yK4TlE8etOqmWCs9HNiqiCAETLb5qJA3A6qG1Jn
 h6V6xClL4wBArYi21wFO/7FjadePS12o9ea2eRGVGWcgiTUFsXGQbeR7s6dY9u23C2L8
 xoic+ej9267tYpUyljz0rwH1UZi8F0YPV6zlhkAC7TxlUQBd830jqrGA4PrfEJDRn69B
 RMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919915; x=1788524715;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j0tMs94sb+aFfcub2Wo5fCNJJlmTEWWroFUOWHWnK2I=;
 b=bXZw3lnrVi77RIgoAtTkudHavKbeWfcas60OTEQoqjfwEObMfbdpZGDeyG9aJ2lxu2
 Y7GCL1bJfr8FPkpWydm9ygOeXfIFtavdv1NjhzlWVIH4GBJI9OfMLfqdD/uZTN3RqZcb
 +hSB/PbFLFMkMbCuWMRxU1HQcN0r/bh1q63z6Fkujj8gQRQ4l0sfaSScdYZvPTYCzvXw
 FjmUNkh9koa+hB7hKrWzM/Ua9wqXpN7FkiKVqEnSFdweLKpdjXgjIt9X5rwrKQ69cUnc
 xJ5L+i37NEQBDieRpQnUs/f5CO5eSBE+InDh9Od/JfECoi+S4Ox0rDxaCSlwVaGSE3M6
 4a9w==
X-Gm-Message-State: AFuF++lzDRcrCsDXMtvrMY5Z1HyGW+NkZkP9dBuibQXuv1ipZn6z22bL
 QSXkl8xthSVEU12t5IKzaLOhpo6dJIDlEH86zR5fvOF3m4f51q8XrlqHdFCuLy+8HQBUEsSYSRI
 GjpND7c1NbuI7KnHonH/Q4hWOzNBmc7ijuFm6CayY6Iy8liiBRWRryPlpb/TL7OCB1pcI1vQ9Sk
 fYass3SFc53N9DSb+aZtlaDUiKpmP8QYs=
X-Gm-Gg: AYBFou0L/rAan1KgQAfPLagR6IhTMmmDxmPWN8AHH4kb1MoLld9YGHIeUUMCREmuFuB
 pU8wGNc65QU5TiUIgey/XWNYGNqeigirB4yQ5EgpfTBBxgme2P6K1bJO+chHzpo2mhVr0tPKZRf
 1jy0aUj7xCCnIVqsQV/7UDKbm+06qaRNHU3WNvRd+xtRY9fulpcSDqL90cbnA/l6BGnpyl1dTBf
 h1qQgR03Oq53E7S9SYQXzGzCxP0axMnM4/MkDpTgkNNnhsj5ScN5I7gflQ=
X-Received: by 2002:a05:690c:488a:b0:81f:3556:bc27 with SMTP id
 00721157ae682-85d6e438b29mr28679507b3.27.1787919914342; 
 Fri, 28 Aug 2026 05:25:14 -0700 (PDT)
X-Received: by 2002:a05:690c:488a:b0:81f:3556:bc27 with SMTP id
 00721157ae682-85d6e438b29mr28679147b3.27.1787919913708; Fri, 28 Aug 2026
 05:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-10-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-10-948aae960abb@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 28 Aug 2026 14:24:37 +0200
X-Gm-Features: AcwNN1Wjj8VMLhtz9l0Ffbk3zEITt7boXt6RDEeYK7jllTVfh-qHtJMSCvCGvJI
Message-ID: <CAJaqyWcLXE2ZKORTC=oBcfLQ1+oza2CvowSnfkpPqmBttHEThg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/13] hw/virtio/vhost-user: handle data movement
 with shadow vqs
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> - Add start logic for shadow virtqueues, which sets vring addresses.
> - Update logic for sending vring addresses to backend to point
>   to the shadow vrings when isolation mode is active.
> - Implement handlers for intercepted avail and used descriptors. These
>   handlers copy buffer contents between bounce buffers in the isolation
>   region and the buffers made available by the guest
> - Implement logic to stop svqs
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c |   2 +-
>  hw/virtio/vhost-shadow-virtqueue.h |   1 +
>  hw/virtio/vhost-user.c             | 292 +++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 286 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index f54a61439a..80b0828d7c 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -350,7 +350,7 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const st=
ruct iovec *out_sg,
>  }
>
>  /* Convenience wrapper to add a guest's element to SVQ */
> -static int vhost_svq_add_element(VhostShadowVirtqueue *svq,
> +int vhost_svq_add_element(VhostShadowVirtqueue *svq,
>                                   VirtQueueElement *elem)
>  {
>      return vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->out_add=
r,
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 1e0cc9e5e4..10a8db6c39 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -183,6 +183,7 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadow=
VirtqueueOps *ops,
>
>  void vhost_svq_free(gpointer vq);
>  void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr);
> +int vhost_svq_add_element(VhostShadowVirtqueue *svq, VirtQueueElement *e=
lem);
>
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostShadowVirtqueue, vhost_svq_free);
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ace328f5eb..ca3aaf7a07 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1364,6 +1364,231 @@ static int init_isolation_regions(struct vhost_de=
v *dev,
>      return 0;
>  }
>
> +static inline int vhost_user_get_reg_idx(struct vhost_dev *dev, hwaddr g=
pa)
> +{
> +    int i;
> +    struct vhost_memory_region *reg;
> +
> +    for (i =3D 0; i < dev->mem->nregions; i++) {
> +        reg =3D dev->mem->regions + i;
> +
> +        if (gpa >=3D reg->guest_phys_addr &&
> +            reg->guest_phys_addr + reg->memory_size > gpa) {
> +            return i;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
> +static int vhost_user_svq_handle_used(VhostShadowVirtqueue *svq,
> +                                      VirtQueueElement *elem,
> +                                      void *opaque)
> +{
> +    uint64_t offset;
> +    void *dst;
> +    void *src;
> +    size_t len, rem;
> +    void *reg_last_addr;
> +    void *reg_first_addr;
> +    struct vhost_dev *dev =3D opaque;
> +    struct vhost_user *u =3D dev->opaque;
> +    void *shmem_addr =3D u->iso_mem_ctx.shared_mem_addr;
> +    size_t shmem_size =3D u->iso_mem_ctx.size;
> +    const DMAMap *map;
> +    DMAMap needle;
> +    int reg_idx;
> +
> +    for (int i =3D 0; i < elem->in_num; i++) {
> +        needle.translated_addr =3D elem->in_addr[i];
> +        needle.size =3D elem->in_sg[i].iov_len - 1;
> +        map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
> +
> +        if (!map) {
> +            return -EFAULT;
> +        }
> +
> +        offset =3D needle.translated_addr - map->translated_addr;
> +        src =3D (void *)int128_get64(int128_add(int128_make64(map->iova =
+
> +                       offset), u->iso_mem_ctx.iso_iova_offset));
> +        dst =3D elem->in_sg[i].iov_base;
> +        len =3D elem->in_sg[i].iov_len;
> +
> +        /* Confirm that buffer range is fully within iso region */
> +        if ((uint64_t)src + len - 1 > (uint64_t)shmem_addr + shmem_size =
- 1 ||
> +            (uint64_t)src + len <=3D (uint64_t)src ||
> +            (uint64_t)src < (uint64_t)shmem_addr) {
> +
> +            return -EFAULT;
> +        }
> +
> +        reg_idx =3D vhost_user_get_reg_idx(dev, needle.translated_addr);
> +        if (reg_idx < 0) {
> +            return -EFAULT;
> +        }
> +
> +        reg_first_addr =3D (void *)dev->mem->regions[reg_idx].userspace_=
addr;
> +        reg_last_addr =3D (void *)(dev->mem->regions[reg_idx].userspace_=
addr +
> +                        dev->mem->regions[reg_idx].memory_size - 1);
> +
> +        /* Confirm that hva from elem matches expected vhost memory regi=
on */
> +        if (dst < reg_first_addr || dst > reg_last_addr) {
> +            return -EFAULT;
> +        }
> +
> +        /*
> +         * copy buffer contents from shared memory into guest memory. If
> +         * the buffer extends across region boundaries, it must be split=
 and
> +         * copied to the correct regions.
> +         */
> +        while ((uint64_t)reg_last_addr - (uint64_t)dst + 1 < len) {
> +            rem =3D ((uint64_t)dst + len - 1) - (uint64_t)reg_last_addr;
> +            len -=3D rem;
> +            memcpy(dst, src, len);
> +
> +            reg_idx++;
> +            if (reg_idx >=3D dev->mem->nregions) {
> +                return -EFAULT;
> +            }
> +
> +            src =3D (void *)((uint64_t)src + len);
> +            dst =3D (void *)dev->mem->regions[reg_idx].userspace_addr;
> +            len =3D rem;
> +            reg_first_addr =3D (void *)dev->mem->regions[reg_idx].usersp=
ace_addr;
> +            reg_last_addr =3D (void *)(dev->mem->regions[reg_idx].usersp=
ace_addr +
> +                            dev->mem->regions[reg_idx].memory_size - 1);
> +        }
> +
> +        memcpy(dst, src, len);
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
> +    void *dst;
> +    void *src;
> +    void *reg_first_addr;
> +    void *reg_last_addr;
> +    size_t len, rem;
> +    struct vhost_dev *dev =3D opaque;
> +    struct vhost_user *u =3D dev->opaque;
> +    void *shmem_addr =3D u->iso_mem_ctx.shared_mem_addr;
> +    size_t shmem_size =3D u->iso_mem_ctx.size;
> +    int reg_idx;
> +
> +    for (int i =3D 0; i < elem->out_num; i++) {
> +        needle.translated_addr =3D elem->out_addr[i];
> +        needle.size =3D elem->out_sg[i].iov_len - 1;
> +        map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
> +
> +        if (!map) {
> +            return -EFAULT;
> +        }
> +
> +        offset =3D needle.translated_addr - map->translated_addr;
> +        dst =3D (void *)int128_get64(int128_add(int128_make64(map->iova =
+
> +                       offset), u->iso_mem_ctx.iso_iova_offset));
> +        src =3D elem->out_sg[i].iov_base;
> +        len =3D elem->out_sg[i].iov_len;
> +
> +        /* Confirm that buffer range is fully within iso region */
> +        if ((uint64_t)dst + len - 1 > (uint64_t)shmem_addr + shmem_size =
- 1 ||
> +            (uint64_t)dst + len <=3D (uint64_t)dst ||
> +            (uint64_t)dst < (uint64_t)shmem_addr) {
> +
> +            return -EFAULT;
> +        }
> +
> +        reg_idx =3D vhost_user_get_reg_idx(dev, needle.translated_addr);
> +        if (reg_idx < 0) {
> +            return -EFAULT;
> +        }
> +
> +        reg_first_addr =3D (void *)dev->mem->regions[reg_idx].userspace_=
addr;
> +        reg_last_addr =3D (void *)(dev->mem->regions[reg_idx].userspace_=
addr +
> +                        dev->mem->regions[reg_idx].memory_size - 1);
> +
> +        /* Confirm that hva from elem matches expected vhost memory regi=
on */
> +        if (src < reg_first_addr || src > reg_last_addr) {
> +            return -EFAULT;
> +        }
> +
> +        /*
> +         * copy buffer contents from guest memory into shared memory. If
> +         * the buffer extends across region boundaries, it must be split=
 and
> +         * copied from the correct regions.
> +         */
> +        while ((uint64_t)reg_last_addr - (uint64_t)src + 1 < len) {
> +            rem =3D ((uint64_t)src + len - 1) - (uint64_t)reg_last_addr;
> +            len -=3D rem;
> +            memcpy(dst, src, len);
> +
> +            reg_idx++;
> +            if (reg_idx >=3D dev->mem->nregions) {
> +                return -EFAULT;
> +            }
> +
> +            dst =3D (void *)((uint64_t)dst + len);
> +            src =3D (void *)dev->mem->regions[reg_idx].userspace_addr;
> +            len =3D rem;
> +
> +            reg_first_addr =3D (void *)dev->mem->regions[reg_idx].usersp=
ace_addr;
> +            reg_last_addr =3D (void *)(dev->mem->regions[reg_idx].usersp=
ace_addr +
> +                            dev->mem->regions[reg_idx].memory_size - 1);
> +        }
> +
> +        memcpy(dst, src, len);
> +    }
> +
> +    vhost_svq_add_element(svq, elem);
> +
> +    return 0;
> +}

You can handle all buffer memcpy operations within the SVQ itself, and
the net CVQ could also reuse and benefit from this. Indirect
descriptor optimizations proposed in other threads can also benefit
from this. That would make the patches much simpler.

> +
> +static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
> +{
> +    assert(idx >=3D dev->vq_index && idx < dev->vq_index + dev->nvqs);
> +
> +    return idx;
> +}
> +
> +static int vhost_user_svqs_vring_map(struct vhost_dev *dev)
> +{
> +    int ret;
> +    struct vhost_user *u =3D dev->opaque;
> +    void *vring_base =3D u->iso_mem_ctx.vring_hva_addr;
> +    uint64_t vring_last =3D (uint64_t)vring_base +
> +                          u->iso_mem_ctx.vring_region_size - 1;
> +
> +    for (int i =3D 0; i < u->iso_mem_ctx.shadow_vqs->len; i++) {
> +        vhost_user_get_vq_index(dev, dev->vq_index + i); /* bounds check=
ing */
> +
> +        VirtQueue *vq =3D virtio_get_queue(dev->vdev, dev->vq_index + i)=
;
> +        VhostShadowVirtqueue *svq =3D
> +            g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, i);
> +
> +        assert((uint64_t)vring_base +
> +               vhost_svq_vring_total_size(dev->vdev, vq) - 1 <=3D vring_=
last);
> +
> +        vhost_svq_set_base_addr(svq, vring_base);
> +        ret =3D vhost_svq_start(svq, dev->vdev, vq, u->iso_mem_ctx.tree)=
;
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        vring_base =3D (void *)((uint64_t)vring_base +
> +                     vhost_svq_vring_total_size(dev->vdev, vq));
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                      struct vhost_memory *mem)
>  {
> @@ -1407,6 +1632,11 @@ static int vhost_user_set_mem_table(struct vhost_d=
ev *dev,
>              return ret;
>          }
>
> +        ret =3D vhost_user_svqs_vring_map(dev);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
>          ret =3D vhost_user_write(dev, &msg, fds, fd_num);
>          if (ret < 0) {
>              return ret;
> @@ -1763,13 +1993,6 @@ static int vhost_set_vring_file(struct vhost_dev *=
dev,
>      return 0;
>  }
>
> -static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
> -{
> -    assert(idx >=3D dev->vq_index && idx < dev->vq_index + dev->nvqs);
> -
> -    return idx;
> -}
> -
>  static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>                                       struct vhost_vring_file *file)
>  {
> @@ -1875,6 +2098,8 @@ static int vhost_user_set_vring_err(struct vhost_de=
v *dev,
>  static int vhost_user_set_vring_addr(struct vhost_dev *dev,
>                                       struct vhost_vring_addr *addr)
>  {
> +    struct vhost_user *u =3D dev->opaque;
> +    ptrdiff_t offset =3D u->iso_mem_ctx.iso_iova_offset;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_VRING_ADDR,
>          .hdr.flags =3D VHOST_USER_VERSION,
> @@ -1882,6 +2107,25 @@ static int vhost_user_set_vring_addr(struct vhost_=
dev *dev,
>          .hdr.size =3D sizeof(msg.payload.addr),
>      };
>
> +    if (u->user->memory_isolation) {
> +        int svq_idx;
> +        VhostShadowVirtqueue *svq;
> +        struct vhost_vring_addr svq_addr;
> +
> +        vhost_user_get_vq_index(dev, addr->index); /* bounds checking */
> +        svq_idx =3D addr->index - dev->vq_index;
> +        svq =3D g_ptr_array_index(u->iso_mem_ctx.shadow_vqs,
> +                                                      svq_idx);
> +
> +        svq_addr.avail_user_addr =3D (uint64_t)(uintptr_t)svq->vring.ava=
il -
> +                                   offset;
> +        svq_addr.desc_user_addr =3D (uint64_t)(uintptr_t)svq->vring.desc=
 - offset;
> +        svq_addr.used_user_addr =3D (uint64_t)(uintptr_t)svq->vring.used=
 - offset;
> +        svq_addr.index =3D addr->index;
> +
> +        msg.payload.addr =3D svq_addr;
> +    }
> +
>      /*
>       * wait for a reply if logging is enabled to make sure
>       * backend is actually logging changes
> @@ -2857,13 +3101,18 @@ static int vhost_user_postcopy_notifier(NotifierW=
ithReturn *notifier,
>      return 0;
>  }
>
> +static const VhostShadowVirtqueueOps vhost_user_svq_ops =3D {
> +    .avail_handler =3D vhost_user_svq_handle_avail,
> +    .used_callback =3D vhost_user_svq_handle_used
> +};
> +
>  static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user=
 *u)
>  {
>      /*Modified from vhost-vdpa*/
>      u->iso_mem_ctx.shadow_vqs =3D g_ptr_array_new_full(dev->nvqs, vhost_=
svq_free);
>      for (int i =3D 0; i < dev->nvqs; i++) {
>          VhostShadowVirtqueue *svq;
> -        svq =3D vhost_svq_new(NULL, NULL);
> +        svq =3D vhost_svq_new(&vhost_user_svq_ops, dev);
>          g_ptr_array_add(u->iso_mem_ctx.shadow_vqs, svq);
>      }
>  }
> @@ -3562,8 +3811,35 @@ void vhost_user_async_close(DeviceState *d,
>      }
>  }
>
> +static void vhost_user_svqs_stop(struct vhost_dev *dev)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    for (int i =3D 0; i < u->iso_mem_ctx.shadow_vqs->len; i++) {
> +        vhost_svq_stop(g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, i));
> +    }
> +}
> +
>  static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
>  {
> +    struct vhost_user *u =3D dev->opaque;
> +    if (u->user->memory_isolation) {
> +        if (vhost_dev_has_iommu(dev)) {
> +            error_report("Memory isolation is not supported with IOMMU e=
nabled."
> +                         "Please disable one and try again");
> +            return -1;
> +        }
> +
> +        if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
> +            error_report("Memory isolation is not supported with packed"
> +                         "vrings.  Please use split vrings");
> +            return -1;
> +        }
> +
> +        if (!started) {
> +            vhost_user_svqs_stop(dev);
> +        }
> +    }
> +
>      if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STAT=
US)) {
>          return 0;
>      }
>
> --
> 2.43.0
>


