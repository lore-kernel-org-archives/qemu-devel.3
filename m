Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91795C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 03:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue3kS-0002hD-4J; Mon, 21 Jul 2025 23:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ue3kQ-0002ff-BH
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 23:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ue3kO-0000x5-CF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 23:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753155174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDbUXAfW0ntIqSQ5PXTJZbtBEs7EVq2RCc1zFOatD1o=;
 b=RCgSIAK9QTNufX/7QjKWSNZfsCvSu2ZSdiu1RT7J/Kommtzesr7jvA2R2B/SyftAhsMedb
 VXXuGO9n4zvVdnk0AesSG3PTDsQ2cecelU6cgDhxgQ1eW46klfDyM4KfTPSjCMrzH134gt
 n3Y0JdkfgAAQTEZbgq/y0TWV7r6OfZo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-0lcBFW4SPSalKc9c_4cs6g-1; Mon, 21 Jul 2025 23:32:52 -0400
X-MC-Unique: 0lcBFW4SPSalKc9c_4cs6g-1
X-Mimecast-MFC-AGG-ID: 0lcBFW4SPSalKc9c_4cs6g_1753155172
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-315af0857f2so4653312a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 20:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753155171; x=1753759971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDbUXAfW0ntIqSQ5PXTJZbtBEs7EVq2RCc1zFOatD1o=;
 b=Rjo4UtI2T4hvHO5SnXmhifd+q97Yjt0jhFudE2hR4BOfCuBhOHBSsCF9DblFA7MWx1
 durIXag5OaXKgdTAl76HjGLu7tels701pmtNpOvfOQfe178jF7yCsWQXfU3Hhy1MDnIU
 QoGAjAUSWZuDrxWXy+hzRFsSNA/Jlv62YdVJMWH4LgQCusZ5nr9bcM2UM6r+ixWe2IuP
 9oHYS6KFJD0emDJVsVScZDss+dlIK9wlrHA+7BcPHbeULyOODnTywg+LZ+lQpCRhUQvA
 llvwFdLN9QJosf736fTX0gjwCvnA11l1jUaXpszk0SWiYUnX706BfVyjBZmNYFL1fvcD
 PVxg==
X-Gm-Message-State: AOJu0YzkCwHUnUXiJRQ1W1iNQHVHxycPDlMYsSEMNL2vBgm1uPkmdd2M
 1LH0pPT6Y2asecndqctG3Q3t8S2puofvi1r4hAudk2eTVv/mYjIrMRoHgPMzxQytomZfaCJjUWU
 zB5MlDRZ0HLD59l7/3J2MG17aYIeXywjuFuL22eh78KfRAql1FqkKaXYdqvFKr+ZOCBr5KUE1iP
 peaLxwgVNECYz9jm/Wt90+kNBLTNt8TvU=
X-Gm-Gg: ASbGncv4Rc9dxq+npDqQrqWLSLEJwN0FQlkOzT8X4KshjEQvgx3A/KjSpuWF5x9LgkU
 xYz0eQKkehJQkXn+r5V0PA9LjQxPnt0yXhcHspwrgJnui11zdko5IC9ra8wHg9dcfrWOjV9QVIU
 wrQT5zWyltG6+dUppCumwXwg==
X-Received: by 2002:a17:90b:5385:b0:313:d343:4e09 with SMTP id
 98e67ed59e1d1-31c9f45e1a3mr26727889a91.3.1753155171502; 
 Mon, 21 Jul 2025 20:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHbxZdglUW3yX/gP06yrWsQAdIsdE8ClVb5DsMUdwtGkYA3o1GAGUVrp0usP+JkDedZk1VE1w9m65br3VrUeo=
X-Received: by 2002:a17:90b:5385:b0:313:d343:4e09 with SMTP id
 98e67ed59e1d1-31c9f45e1a3mr26727856a91.3.1753155171028; Mon, 21 Jul 2025
 20:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752828082.git.pabeni@redhat.com>
 <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
In-Reply-To: <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Jul 2025 11:32:39 +0800
X-Gm-Features: Ac12FXx9OuYyWeGVPiFLOYyXP8buykoC2Yg8DJa4n51LmP4HPqYnhXqeZYTaH-4
Message-ID: <CACGkMEtWOk2o1xRK9XtaXPuWBnd8Yrfk4DVNJZB4kRCZzxWwRQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 07/13] vhost: add support for negotiating extended
 features
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 18, 2025 at 4:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Similar to virtio infra, vhost core maintains the features status
> in the full extended format and allows the devices to implement
> extended version of the getter/setter.
>
> Note that 'protocol_features' are not extended: they are only
> used by vhost-user, and the latter device is not going to implement
> extended features soon.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>   - fix compile warning
>   - _array -> _ex
>
> v1 -> v2:
>   - uint128_t -> uint64_t[]
>   - add _ex() variant of features manipulation helpers
> ---
>  hw/virtio/vhost.c                 | 73 +++++++++++++++++++++++++++----
>  include/hw/virtio/vhost-backend.h |  6 +++
>  include/hw/virtio/vhost.h         | 33 ++++++++++++--
>  3 files changed, 100 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index c30ea1156e..85ae1e4d4c 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost_de=
v *dev,
>  static int vhost_dev_set_features(struct vhost_dev *dev,
>                                    bool enable_log)
>  {
> -    uint64_t features =3D dev->acked_features;
> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
>      int r;
> +
> +    virtio_features_copy(features, dev->acked_features_ex);
>      if (enable_log) {
> -        features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> +        virtio_add_feature_ex(features, VHOST_F_LOG_ALL);
>      }
>      if (!vhost_dev_has_iommu(dev)) {
> -        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> +        virtio_clear_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>      }
>      if (dev->vhost_ops->vhost_force_iommu) {
>          if (dev->vhost_ops->vhost_force_iommu(dev) =3D=3D true) {
> -            features |=3D 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
> +            virtio_add_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>         }
>      }
> -    r =3D dev->vhost_ops->vhost_set_features(dev, features);
> +
> +    if (virtio_features_use_extended(features) &&
> +        !dev->vhost_ops->vhost_set_features_ex) {
> +        VHOST_OPS_DEBUG(r, "extended features without device support");
> +        r =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    if (dev->vhost_ops->vhost_set_features_ex) {
> +        r =3D dev->vhost_ops->vhost_set_features_ex(dev, features);
> +    } else {
> +        r =3D dev->vhost_ops->vhost_set_features(dev, features[0]);
> +    }
>      if (r < 0) {
>          VHOST_OPS_DEBUG(r, "vhost_set_features failed");
>          goto out;
> @@ -1506,12 +1520,27 @@ static void vhost_virtqueue_cleanup(struct vhost_=
virtqueue *vq)
>      }
>  }
>
> +static int vhost_dev_get_features(struct vhost_dev *hdev,
> +                                  uint64_t *features)
> +{
> +    uint64_t features64;
> +    int r;
> +
> +    if (hdev->vhost_ops->vhost_get_features_ex) {
> +        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
> +    }
> +
> +    r =3D hdev->vhost_ops->vhost_get_features(hdev, &features64);
> +    virtio_features_from_u64(features, features64);
> +    return r;
> +}

Nit: let's have a vhost_dev_set_features() as well?

Thanks


