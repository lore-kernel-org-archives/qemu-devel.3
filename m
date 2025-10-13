Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B4CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 18:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8NF0-00011l-NI; Mon, 13 Oct 2025 14:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8NEy-00011d-Do
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:25:48 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8NEw-00044U-Nv
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:25:48 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-42e6df6fe53so18925395ab.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760379944; x=1760984744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS7AULqnP5K2VcOVuma4aJK8INRc4Iu+Ot5aiupcf50=;
 b=dr5NjmgVcS/Wgd5Ur1vVEiIeJHLs70SBC1HgRWYFnCgK+CdEpY0/CFFCiJ4Go8nVVq
 /jmo4ntbQ3KP0zngsF4eCDXgduLRsOchmxGINPTZFYg30UERrV/Z9kSADsZB7FIEZQVR
 8Cpe+CnTrJk8LJx0Bg+9C6Fy108gzOfVGharAjj3s6IW1PTXm91PjddTF4rj4c4kIJHD
 MwoJLBxJptAmqoydEgD9knIXhnC3cn+eSrV0f+ec4Hqmhb88BKOr7qbW7B61xtY4eXmy
 dJMUkqGZrm1sDx6RLFa8SAwPxWZv3i3UmPQJp7YjJVdlhvCbzheg3aSFhhoGFS7MRUbo
 AnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760379944; x=1760984744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DS7AULqnP5K2VcOVuma4aJK8INRc4Iu+Ot5aiupcf50=;
 b=kRh4v+9eZ7NzSG/UGxAcU4mt9eL9W6c+3mzRaR3uw00gj8CRcXT8OU4QorRgetkspm
 sjafjBZwjoAq3wY4DZrsjt21Jukqtj7AckF061dK9Gbw+i0v/YxBo6o5r7U02JpnlOjl
 9iRckdOk2k6THT3thCvxoWYC7+WN+QcgwfQpfDR+3p/gozTs+vyKZQXx3DQGGDue1q3y
 ElVH0ulhW4IkXePI1gaizMcqilkZbQKrtNo6qHYCcC7MDockChqEvTfUDcAcO/04bYY5
 bRyD2yicgI+w5a8qM47pwQEXuIYw5/t3J3tshkGG0yhZ83kdYjWIF6Xsgj20DpbQIN5L
 cFMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9zGPjzQH2j+DdIALcKP04N3V/kft+oRMUDopM1uK5rMF0FXaN2bhwdImaBdW+GkuI4qIsfQ1bRmCk@nongnu.org
X-Gm-Message-State: AOJu0Yxh2BkmU8IXWG8rixUQ50tjI8t1U65+21eTSi0j86+GOpoQbY0P
 NBI0Hx3TKoJmhjA4EvVJQGPmwiKHivq6yp8DBaMARNKskU73notveq8+z1BIdAxEC2bY5rc0eka
 QsO0sIGSe/Fd/Fh/fnQUReNWDZMTHDng=
X-Gm-Gg: ASbGncsZ26GKj7jj0OFPhlA6nNexkO0aJ8km5bqAuIIEQQIPKOyotU1aFvEiKL95VbA
 JA175NA2qyBwlORFkkXN/k2nTsIJsaUJeDKryo8fvN0+nhWvfCZCSVdWKnp3FAoHiOs+cQgZW3D
 CO7eDL2J4VCxxe5iwq2WttkeaUjVyU+keeMd4dwnq8hYzzkVEB56rZF7ZBvpkyDT9DGAlGQIKtT
 Gfq04t7ZeFK9A7mVHKBX0ehFdd9ZNQpu4XD
X-Google-Smtp-Source: AGHT+IHWSzfFR4kMO3gauTLslnHeof4o9pj24viCUGsj3lF7tQNXh+lKuQOxzu9xePMDfhYTmnHfRoHvwieUAs5UUyo=
X-Received: by 2002:a05:6e02:3e8e:b0:40b:db4:839b with SMTP id
 e9e14a558f8ab-42f8736d106mr193652205ab.5.1760379944330; Mon, 13 Oct 2025
 11:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-2-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-2-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 14:25:32 -0400
X-Gm-Features: AS18NWAjcuEzkv8MsUWvEPE6_LmZruaxWjUKTXghfAzAF3rzAwg03f4B4y05UW0
Message-ID: <CAFubqFve=gFEEAhBNEirjR6NO=BMEh1uEq2zM2UXCN2CMBtPbw@mail.gmail.com>
Subject: Re: [PATCH v2 01/23] vhost-user: rework enabling vrings
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We call the handler almost the same way in three places:
>
>  - cryptodev-vhost.c
>  - vhost_net.c
>  - vhost.c
>
> The only difference, is that in vhost.c we don't try to call the handler
> for old vhost-user (when VHOST_USER_F_PROTOCOL_FEATURES is not supported)=
.
>
> cryptodev-vhost and vhost_net code will just fail in this case. Probably
> they were developed only for newer vhost-user. Anyway, it doesn't seem
> correct to rely on this error path, if these devices want to check,
> that they don't communicate to old vhost-user protocol, they should
> do that earlier.
>
> Let's create the common helper, to call .vhost_set_vring_enable and
> use in all three places. For vhost-user let's just always skip
> enable/disable if it's unsupported.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/cryptodev-vhost.c |  8 +-------
>  hw/net/vhost_net.c         |  7 +------
>  hw/virtio/vhost-user.c     |  7 ++++++-
>  hw/virtio/vhost.c          | 21 ---------------------
>  include/hw/virtio/vhost.h  |  9 +++++++++
>  5 files changed, 17 insertions(+), 35 deletions(-)
>
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index 943680a23a..abdfce33af 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -152,7 +152,6 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
>  {
>      CryptoDevBackendVhost *crypto =3D
>                         cryptodev_get_vhost(cc, b, queue);
> -    const VhostOps *vhost_ops;
>
>      cc->vring_enable =3D enable;
>
> @@ -160,12 +159,7 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
>          return 0;
>      }
>
> -    vhost_ops =3D crypto->dev.vhost_ops;
> -    if (vhost_ops->vhost_set_vring_enable) {
> -        return vhost_ops->vhost_set_vring_enable(&crypto->dev, enable);
> -    }
> -
> -    return 0;
> +    return vhost_dev_set_vring_enable(&crypto->dev, enable);
>  }
>
>  int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index a8ee18a912..25e9f1fd24 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -587,7 +587,6 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>  int vhost_net_set_vring_enable(NetClientState *nc, int enable)
>  {
>      VHostNetState *net =3D get_vhost_net(nc);
> -    const VhostOps *vhost_ops =3D net->dev.vhost_ops;
>
>      /*
>       * vhost-vdpa network devices need to enable dataplane virtqueues af=
ter
> @@ -601,11 +600,7 @@ int vhost_net_set_vring_enable(NetClientState *nc, i=
nt enable)
>
>      nc->vring_enable =3D enable;
>
> -    if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
> -        return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
> -    }
> -
> -    return 0;
> +    return vhost_dev_set_vring_enable(&net->dev, enable);
>  }
>
>  int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 36c9c2e04d..f367ce06ce 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1235,7 +1235,12 @@ static int vhost_user_set_vring_enable(struct vhos=
t_dev *dev, int enable)
>      int i;
>
>      if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURE=
S)) {
> -        return -EINVAL;
> +        /*
> +         * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has=
 not
> +         * been negotiated, the rings start directly in the enabled stat=
e,
> +         * and can't be disabled.
> +         */
> +        return 0;
>      }
>
>      for (i =3D 0; i < dev->nvqs; ++i) {
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 266a11514a..414a48a218 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2013,27 +2013,6 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, =
uint16_t queue_size,
>      return 0;
>  }
>
> -static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable=
)
> -{
> -    if (!hdev->vhost_ops->vhost_set_vring_enable) {
> -        return 0;
> -    }
> -
> -    /*
> -     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
> -     * been negotiated, the rings start directly in the enabled state, a=
nd
> -     * .vhost_set_vring_enable callback will fail since
> -     * VHOST_USER_SET_VRING_ENABLE is not supported.
> -     */
> -    if (hdev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER &&
> -        !virtio_has_feature(hdev->backend_features,
> -                            VHOST_USER_F_PROTOCOL_FEATURES)) {
> -        return 0;
> -    }
> -
> -    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
> -}
> -
>  /*
>   * Host notifiers must be enabled at this point.
>   *
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 08bbb4dfe9..1ee639dd7e 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -215,6 +215,15 @@ static inline bool vhost_dev_is_started(struct vhost=
_dev *hdev)
>      return hdev->started;
>  }
>
> +static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int=
 enable)
> +{
> +    if (!hdev->vhost_ops->vhost_set_vring_enable) {
> +        return 0;
> +    }
> +
> +    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
> +}
> +
>  /**
>   * vhost_dev_start() - start the vhost device
>   * @hdev: common vhost_dev structure
> --
> 2.48.1
>

