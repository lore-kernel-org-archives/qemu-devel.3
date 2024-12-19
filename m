Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE800E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 01:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO5a6-0006Bs-03; Wed, 18 Dec 2024 20:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tO5a0-00067x-Tq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 20:43:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tO5Zy-0000Dl-ON
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 20:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734572632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yCPsyW7U/qPE+9sG+uE7o1u7wh6ztxq158s7gZguTcw=;
 b=ZT8i8IVgJQ7tZ4KyW99eQlFB71QkRrh95d7R/qJPi/uOyZ7Jfso67FP1PuVWPa7PkC2TUv
 PeZIZzISiAO26s7ckEy5SOuGWy8ghV8YFXDbIRvDSrKvfibv2HctlPpKyzLNNe64zp4Lpt
 JYaSVcRFx8bkn06g8136H77FLGu0eSc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-0bXwHx2OObCCdrE30OG-4w-1; Wed, 18 Dec 2024 20:43:50 -0500
X-MC-Unique: 0bXwHx2OObCCdrE30OG-4w-1
X-Mimecast-MFC-AGG-ID: 0bXwHx2OObCCdrE30OG-4w
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa691c09772so21865266b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 17:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734572629; x=1735177429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCPsyW7U/qPE+9sG+uE7o1u7wh6ztxq158s7gZguTcw=;
 b=MgJF4tc5dXhrEv2Jq3n7lkqtT2jlL97rahLR5zfCgF3+CASrd9vntHGeM9Su5ezI0t
 mAe1Ui6tbr8mnnbxaTN5ClDSgJmO6g42pygPuelO6TEDbhrMyuMuLVvYoEYoMMFJZCqH
 0fWZE8awbRiKwjKBh68FnIj+KJ0WtHjhtKSTW6wPIIYP4NY/AMLFhy4/CW5Y1gYdYep1
 5dGjIqB0P5mUGJkuiexewOQwCFk3fC/qKyrzBKAA9kncjZDOHyZSc2Ea2sR/2YEg3T6H
 mNlG0WPDeb2U1qdnGMY/rn5E47VeAGh7VEynTJ7JV1EQLmrIWQ8VMj609jT0KBMEOTfv
 OWww==
X-Gm-Message-State: AOJu0YyEBQXI91KQ4UtyRZurRK9xhf+HDDTKm7a5tSX1N6U2RGjBdFys
 i1uJltGE9VTzs01xRIl0VOH7hmlZXVKgcq0p/zP8HlgNRbEJ8ZT/lQvrkk3+Q36POtgzoGy5BcB
 yxGpWCQ8hzC8uzQduf8d0Fxkfak+GzDtztfCRibPFhs7ipH35A8BIEllEwPW1gYnmt6GRv801lh
 NKfiKgQstGdL5e8tilEXDtlLwhIuA=
X-Gm-Gg: ASbGncuciQ7eqelhJ5NUoeLnhtgKvcnLlqKdAdxD8g4dv47XwU1XnoabJy1iX49J/Fp
 IhL7lXe0utPvJVs5dpOJgNS2x8x0BRPTpxKS4+mQ=
X-Received: by 2002:a17:907:3e8f:b0:aab:9258:483 with SMTP id
 a640c23a62f3a-aac079513e0mr146695666b.27.1734572629387; 
 Wed, 18 Dec 2024 17:43:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEug7JfoIeb6xf3z8zHxnQc+ct6nrwm+juLEs4YI0Z18UTH3b0ejBSnz3+ueCQHwZb57j5jjDnjkjyNhO3WeI8=
X-Received: by 2002:a17:907:3e8f:b0:aab:9258:483 with SMTP id
 a640c23a62f3a-aac079513e0mr146694166b.27.1734572628986; Wed, 18 Dec 2024
 17:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20241218143453.1573185-1-lvivier@redhat.com>
In-Reply-To: <20241218143453.1573185-1-lvivier@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 19 Dec 2024 09:43:12 +0800
Message-ID: <CAPpAL=ybRdn=3n=EOM-ZM-7LareSDzKkVSJkDFbV8nbQqxKzCg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: vhost-user: Implement internal migration
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

I tested this patch with virtio-net regression tests,everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Wed, Dec 18, 2024 at 10:36=E2=80=AFPM Laurent Vivier <lvivier@redhat.com=
> wrote:
>
> Add support of VHOST_USER_PROTOCOL_F_DEVICE_STATE in virtio-net
> with vhost-user backend.
>
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/net/virtio-net.c | 135 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 112 insertions(+), 23 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6e8c51a2dbce..b4d9e96dc0d7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3337,6 +3337,117 @@ static const VMStateDescription vmstate_virtio_ne=
t_rss =3D {
>      },
>  };
>
> +static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
> +{
> +    VirtIONet *n =3D VIRTIO_NET(vdev);
> +    NetClientState *nc;
> +    struct vhost_net *net;
> +
> +    if (!n->nic) {
> +        return NULL;
> +    }
> +
> +    nc =3D qemu_get_queue(n->nic);
> +    if (!nc) {
> +        return NULL;
> +    }
> +
> +    net =3D get_vhost_net(nc->peer);
> +    if (!net) {
> +        return NULL;
> +    }
> +
> +    return &net->dev;
> +}
> +
> +static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
> +                                     const VMStateField *field,
> +                                     JSONWriter *vmdesc)
> +{
> +    VirtIONet *n =3D pv;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    struct vhost_dev *vhdev;
> +    Error *local_error =3D NULL;
> +    int ret;
> +
> +    vhdev =3D virtio_net_get_vhost(vdev);
> +    if (vhdev =3D=3D NULL) {
> +        error_reportf_err(local_error,
> +                          "Error getting vhost back-end of %s device %s:=
 ",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return -1;
> +    }
> +
> +    ret =3D vhost_save_backend_state(vhdev, f, &local_error);
> +    if (ret < 0) {
> +        error_reportf_err(local_error,
> +                          "Error saving back-end state of %s device %s: =
",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_user_net_load_state(QEMUFile *f, void *pv, size_t size,
> +                                     const VMStateField *field)
> +{
> +    VirtIONet *n =3D pv;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    struct vhost_dev *vhdev;
> +    Error *local_error =3D NULL;
> +    int ret;
> +
> +    vhdev =3D virtio_net_get_vhost(vdev);
> +    if (vhdev =3D=3D NULL) {
> +        error_reportf_err(local_error,
> +                          "Error getting vhost back-end of %s device %s:=
 ",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return -1;
> +    }
> +
> +    ret =3D vhost_load_backend_state(vhdev, f, &local_error);
> +    if (ret < 0) {
> +        error_reportf_err(local_error,
> +                          "Error loading  back-end state of %s device %s=
: ",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool vhost_user_net_is_internal_migration(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    struct vhost_dev *vhdev;
> +
> +    vhdev =3D virtio_net_get_vhost(vdev);
> +    if (vhdev =3D=3D NULL) {
> +        return false;
> +    }
> +
> +    return vhost_supports_device_state(vhdev);
> +}
> +
> +static const VMStateDescription vhost_user_net_backend_state =3D {
> +    .name =3D "virtio-net-device/backend",
> +    .version_id =3D 0,
> +    .needed =3D vhost_user_net_is_internal_migration,
> +    .fields =3D (const VMStateField[]) {
> +        {
> +            .name =3D "backend",
> +            .info =3D &(const VMStateInfo) {
> +                .name =3D "virtio-net vhost-user backend state",
> +                .get =3D vhost_user_net_load_state,
> +                .put =3D vhost_user_net_save_state,
> +            },
> +         },
> +         VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio_net_device =3D {
>      .name =3D "virtio-net-device",
>      .version_id =3D VIRTIO_NET_VM_VERSION,
> @@ -3389,6 +3500,7 @@ static const VMStateDescription vmstate_virtio_net_=
device =3D {
>      },
>      .subsections =3D (const VMStateDescription * const []) {
>          &vmstate_virtio_net_rss,
> +        &vhost_user_net_backend_state,
>          NULL
>      }
>  };
> @@ -3950,29 +4062,6 @@ static bool dev_unplug_pending(void *opaque)
>      return vdc->primary_unplug_pending(dev);
>  }
>
> -static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
> -{
> -    VirtIONet *n =3D VIRTIO_NET(vdev);
> -    NetClientState *nc;
> -    struct vhost_net *net;
> -
> -    if (!n->nic) {
> -        return NULL;
> -    }
> -
> -    nc =3D qemu_get_queue(n->nic);
> -    if (!nc) {
> -        return NULL;
> -    }
> -
> -    net =3D get_vhost_net(nc->peer);
> -    if (!net) {
> -        return NULL;
> -    }
> -
> -    return &net->dev;
> -}
> -
>  static const VMStateDescription vmstate_virtio_net =3D {
>      .name =3D "virtio-net",
>      .minimum_version_id =3D VIRTIO_NET_VM_VERSION,
> --
> 2.47.1
>
>


