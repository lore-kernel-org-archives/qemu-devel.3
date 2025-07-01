Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5E5C83030
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 01:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWPy5-000658-PR; Mon, 30 Jun 2025 21:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uWPy1-00064w-3b
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uWPxx-0007Hi-MD
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751333959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EDcSDVdNS+p8obJbvsSzlZkaQlD4maZqo1IXdLr/dI=;
 b=JodIQyglK95j8nE7ZJ4+Fpyihwx8/6jAMKmGRzMH65M1PF/Mv8fuASwKG/3i13p4eyEXif
 fjQluYHlpIXz4t+XoxMCOanv9AfG9Da2UdpuFtuVKS1EzQKO58zJVKxb6ZYxBCbdQiO13x
 QX4CL62lO47OCwvj1wqvxgJVjWOF4h4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-5XpaXEJwNDeaGIxJ2N1shQ-1; Mon, 30 Jun 2025 21:39:18 -0400
X-MC-Unique: 5XpaXEJwNDeaGIxJ2N1shQ-1
X-Mimecast-MFC-AGG-ID: 5XpaXEJwNDeaGIxJ2N1shQ_1751333957
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so4290221a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 18:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751333957; x=1751938757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EDcSDVdNS+p8obJbvsSzlZkaQlD4maZqo1IXdLr/dI=;
 b=PGNW9mrXZSVUwXB7psp/BfyH0h4PdnGISGWE4KByFs3x6y2UL2jX8lBbPJ3SLtxivV
 KPcqht3RoY6vvbR/ifWLwuF1nCziKb6YmeardyQn8oMJKhp3kmPn8GUsSLn5y/to38Y7
 fVM0UR64utlsdNYXc/DSuqoYkJv+yNbtB9J2QGmFoX2KALb/Wp8xB7o/prijVNQ48ius
 xPqzn+N7aidVOi84ehYTKmr91yrSmESfexHLXCEhZgRa0+A5kSb4kjYDf8oI83OzSmSu
 IiWoSMGoWxwcdqT3rTt/2UaveDfAqVKpCWBJXsSA+qxTJx1qozmnH9zwz0qv55aC00hm
 E/oQ==
X-Gm-Message-State: AOJu0YzcwtJGG+xCVj6DIqc7+aXwslLpcFhiUYngnsNRZamDG/KG++5a
 0hPfhlWUrQOuQ5ixc7b3fScm+XZogI61INlOzk1MQTpBO5O2U0fG1rxdiFzfwXrkgi2HgCUxQB6
 CWjUlFhUIGLMzg8Aov2SxCNFqlhXbYYK+ymMAQcq1UtlPHw+DDmnyRHBzxvEQVbCyLhDKg2rQgq
 2nvKl2nZLrgU0c1/1LdKML5290kkiU+98=
X-Gm-Gg: ASbGncsH9TbgWaqxNNkg2Nl5SXg21ZI90z/h6tX3Vf9UxFh/ql0pP3JQbjJwpZgxfub
 oSaWdY7JfvaYtoc0tgrMpN2M0WgJcK8ZY/DmhIWx5qzkjsgyqzshmNgEbVL7xON6o8fMs0e22dT
 Hz
X-Received: by 2002:a17:90b:4b0d:b0:313:28f1:fc33 with SMTP id
 98e67ed59e1d1-318c910a238mr22193997a91.10.1751333957137; 
 Mon, 30 Jun 2025 18:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFWIlZGQQzPnyHRJbQSHva2Qvj1BeIWylcRUMN/76DTsG2AkzYfiTEeB+pqEOHaWaqT3v93LxoaEj5zOhmG5Y=
X-Received: by 2002:a17:90b:4b0d:b0:313:28f1:fc33 with SMTP id
 98e67ed59e1d1-318c910a238mr22193963a91.10.1751333956754; Mon, 30 Jun 2025
 18:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-6-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-6-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 09:39:03 +0800
X-Gm-Features: Ac12FXzQajs-0YoOlZwhA4rJkQVumaaS0rtydQqx0WYSHmufmx0oHWAiqtWGpew
Message-ID: <CACGkMEven2FG294GRJ_PHc_xvE3DkNtEokk+sW=Sss7izJO8rA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] net: Consolidate vhost feature bits into
 NetClientInfo
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jun 18, 2025 at 11:57=E2=80=AFPM Laurent Vivier <lvivier@redhat.com=
> wrote:
>
> Previously, the vhost_net_get_feature_bits() function in
> hw/net/vhost_net.c used a large switch statement to determine
> the appropriate feature bits based on the NetClientDriver type.
>
> This created unnecessary coupling between the generic vhost layer
> and specific network backends (like TAP, vhost-user, and
> vhost-vdpa).
>
> This patch moves the definition of vhost feature bits directly into the
> NetClientInfo structure for each relevant network client.
>
> This refactoring centralizes feature bit definitions where they're
> needed, making code easier to add new vhost-enabled network backends
> in the future without modifying core vhost logic.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/net/vhost_net.c       | 80 ++--------------------------------------
>  include/net/net.h        |  1 +
>  include/net/vhost-vdpa.h |  2 -
>  net/tap.c                | 19 ++++++++++
>  net/vhost-user.c         | 43 +++++++++++++++++++++
>  net/vhost-vdpa.c         |  4 +-
>  6 files changed, 70 insertions(+), 79 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 16dadd022e75..3dff819d2dbd 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -36,86 +36,14 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "linux-headers/linux/vhost.h"
>
> -
> -/* Features supported by host kernel. */
> -static const int kernel_feature_bits[] =3D {
> -    VIRTIO_F_NOTIFY_ON_EMPTY,
> -    VIRTIO_RING_F_INDIRECT_DESC,
> -    VIRTIO_RING_F_EVENT_IDX,
> -    VIRTIO_NET_F_MRG_RXBUF,
> -    VIRTIO_F_VERSION_1,
> -    VIRTIO_NET_F_MTU,
> -    VIRTIO_F_IOMMU_PLATFORM,
> -    VIRTIO_F_RING_PACKED,
> -    VIRTIO_F_RING_RESET,
> -    VIRTIO_F_IN_ORDER,
> -    VIRTIO_F_NOTIFICATION_DATA,
> -    VIRTIO_NET_F_RSC_EXT,
> -    VIRTIO_NET_F_HASH_REPORT,
> -    VHOST_INVALID_FEATURE_BIT
> -};
> -
> -/* Features supported by others. */
> -static const int user_feature_bits[] =3D {
> -    VIRTIO_F_NOTIFY_ON_EMPTY,
> -    VIRTIO_F_NOTIFICATION_DATA,
> -    VIRTIO_RING_F_INDIRECT_DESC,
> -    VIRTIO_RING_F_EVENT_IDX,
> -
> -    VIRTIO_F_ANY_LAYOUT,
> -    VIRTIO_F_VERSION_1,
> -    VIRTIO_NET_F_CSUM,
> -    VIRTIO_NET_F_GUEST_CSUM,
> -    VIRTIO_NET_F_GSO,
> -    VIRTIO_NET_F_GUEST_TSO4,
> -    VIRTIO_NET_F_GUEST_TSO6,
> -    VIRTIO_NET_F_GUEST_ECN,
> -    VIRTIO_NET_F_GUEST_UFO,
> -    VIRTIO_NET_F_HOST_TSO4,
> -    VIRTIO_NET_F_HOST_TSO6,
> -    VIRTIO_NET_F_HOST_ECN,
> -    VIRTIO_NET_F_HOST_UFO,
> -    VIRTIO_NET_F_MRG_RXBUF,
> -    VIRTIO_NET_F_MTU,
> -    VIRTIO_F_IOMMU_PLATFORM,
> -    VIRTIO_F_RING_PACKED,
> -    VIRTIO_F_RING_RESET,
> -    VIRTIO_F_IN_ORDER,
> -    VIRTIO_NET_F_RSS,
> -    VIRTIO_NET_F_RSC_EXT,
> -    VIRTIO_NET_F_HASH_REPORT,
> -    VIRTIO_NET_F_GUEST_USO4,
> -    VIRTIO_NET_F_GUEST_USO6,
> -    VIRTIO_NET_F_HOST_USO,
> -
> -    /* This bit implies RARP isn't sent by QEMU out of band */
> -    VIRTIO_NET_F_GUEST_ANNOUNCE,
> -
> -    VIRTIO_NET_F_MQ,
> -
> -    VHOST_INVALID_FEATURE_BIT
> -};
> -
>  static const int *vhost_net_get_feature_bits(struct vhost_net *net)
>  {
> -    if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP) {
> -        return kernel_feature_bits;
> -    }
> -
> -    if (qemu_is_vhost_user(net->nc)) {
> -        return user_feature_bits;
> +    if (net->nc->info->vhost_feature_bits =3D=3D NULL) {
> +        error_report("Feature bits not defined for this type: %d",
> +                     net->nc->info->type);
>      }
>
> -#ifdef CONFIG_VHOST_NET_VDPA
> -    if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> -        return vdpa_feature_bits;
> -    }
> -#endif
> -
> -    error_report("Feature bits not defined for this type: %d",
> -                 net->nc->info->type);
> -
> -    return 0;
> +    return net->nc->info->vhost_feature_bits;
>  }
>
>  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features=
)
> diff --git a/include/net/net.h b/include/net/net.h
> index 8a62cd6e8aab..dd11be11a39f 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -94,6 +94,7 @@ typedef struct NetClientInfo {
>      NetAnnounce *announce;
>      SetSteeringEBPF *set_steering_ebpf;
>      NetCheckPeerType *check_peer_type;
> +    const int *vhost_feature_bits;
>      IsVHostUser *is_vhost_user;
>      GetVHostNet *get_vhost_net;

Assuming we had already had get_vhost_net, it looks to me it's better
to move/reuse the vhost_feature_bits there?

Thanks


