Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EF61061B34
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7XMR-0001wc-GR; Tue, 31 Mar 2026 07:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7XMO-0001vR-V7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7XML-0005cq-8y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774956851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rue0E2b6IDP6rIiZ1mkb+/vZyxSBkjesYP+fx3E528Y=;
 b=Gm7OIxEtYbjAQeQjLQB6wMS9Ngu9pokRs3qdMOJ3s9Dv+jPteP+kFFTf7wXhvU1o2hitI2
 VTek6PeV/m+n89I9r885sX6iimTqJDHkSifw5Te6C5TQiQNvdXo2pl4DkFb6kqeoG44gaa
 GbxKqyC+/+Ll5UjvpfIQLU4avjoTkmM=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-exw3SzQCNH-fnraJfy2PMQ-1; Tue, 31 Mar 2026 07:34:10 -0400
X-MC-Unique: exw3SzQCNH-fnraJfy2PMQ-1
X-Mimecast-MFC-AGG-ID: exw3SzQCNH-fnraJfy2PMQ_1774956850
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-65019a4b560so3088736d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 04:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774956850; cv=none;
 d=google.com; s=arc-20240605;
 b=WmUXXOugrh23amUL+mGzYvgMDujL+/LSGXzYfRSSls05Hdpj8rfJ0oLC+EPsFGRvEH
 n88psO4Nwcg96IiGJYsvke9s/l4RZeaZJ/oaUWDbsHcqv9QV1O5bZ6/IDlgQhZeuuu61
 8ksDUjRXLwJFRCT4zJ0MW8OE18zpEaio5OwryVh2MA62uzppmKYHu4V08Qij/gWDvgl+
 Ec3ww1wxA3xKaxV/6tR9afj+7TwzJMV2PZKXBNgipzwg6P2xy5GNYypWhj8bF+t9apv+
 hxW7nqUD7/w8u5Lx3DmdPK8VOfbo8OVZQRiNreXbXnvRrNkOXxANZF0jy1smordpw57j
 +xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rue0E2b6IDP6rIiZ1mkb+/vZyxSBkjesYP+fx3E528Y=;
 fh=pXm4kqJhz0sclCsk7unKqGwgbqBi3wrCcjfkkZ1CYHI=;
 b=a9mWTN9VdaVw6lDw1mItfkIeKlmoLziLLB2rw90XTSXfKvxt+RPNSqXRzoce8in7kd
 9anGHWAJS0dC6IPJ4J9rh+sM8oHSAAd422CkIexPEL7hlvRgYk+VulAf/lrJEzZffP9H
 sOOUAkATdjI+sM62CKpC1flhXAmEuT/RVsrM3G5ARxQhI1d4XQ/nT8eC5Unep8rui1jO
 1NPRavPeTnXwpC76FBsv9VkLm+dsrpvGox9+8fme3bB5Egn27B8LpPzjLJETRg+YFpen
 9ka9wCqJvVKqJGII6fvCJ9yVU85/W9umn5rfPZIiOTYw8KJc+qEX/3VU2z8bJMY9NlR6
 C0EQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774956850; x=1775561650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rue0E2b6IDP6rIiZ1mkb+/vZyxSBkjesYP+fx3E528Y=;
 b=CW9eJNRdK9iJt9WwF3ycdzaIdp19emtAs/xIoW8kvNJLk+0tEfibjURAq/EOM8td5Z
 mV/E/HQ3CCCjJawXxBen1qaHs6xubyKu5KjE77+I5LlU4wFA7S+ma2KVqRc8PQltwXPq
 6I0BmBnnUNAKlDzGTWDz9sR2+vgioanIIVYN1So+ENmJwhsrxLRmgmJDLtWmgmVCYXAf
 buJdpIjKvDHTtH2+mu/7oG1JFOYSzf6RmicyW0LaLpJgmoZHM/mDq7dNmtkoAmuxy3kT
 frcDDRSkw3xc3eS5EAJ9Keb3VV0SSLZjiphVmqddu2IXuvgWM6vn8Qt/xEWUF8G7Rfqv
 O7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774956850; x=1775561650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rue0E2b6IDP6rIiZ1mkb+/vZyxSBkjesYP+fx3E528Y=;
 b=jl8xDi2Bi/tvy7ADmHk/rFxuaC5Iq60xk3lijH9fA/h00MkZxcEqti7eEYz50055b0
 ofW2s20G3XgF5IIuZO+gwRRVqljH625saUbWroBrywsBYzDBKI+JeQUvoFAdQjaRWlMy
 aXMqrjIbLTCV1MBegZU6DMh2kj7CkJParsG9w+Puatfmhv3N6/nYF6lXEMB8bUDNm8KK
 KX0T5Yw55xxVbqWqH7CIf6zM6joKrPgvFivDPLg0PERfANtzta25Jfp/XDOOZzwep5Eg
 hCmub2SXiq0+V+yJKSq2imsxo0Fw5TQuRGHwsB5ebgwgiaPpHX3ovVwbQyPQD5Kexni9
 R4yA==
X-Gm-Message-State: AOJu0YwMTCqa+XlVTix3B9LtLu49aL8EZpqEgOPFEYTnrPzdnPv7jdWe
 CUjTzTPVWF8PzGSPOpvGXRIok4VUyRNZ/to2/5CsBIJbVYIkdbhLDdmhnb9+wD5PvALBnHUgaLA
 E/jNnMGtKIj2L6o/eDXMhKqt1wUAI6v7PmUXtrH/paxKeu78EWr68s3sTToreuv8Rr1p+rwVhRM
 ubdX9ddeg37WGCbgDZTYHAgfTm/NrC3/o=
X-Gm-Gg: ATEYQzwZnBi0eaAE8jETIqlDrrw/uGxkfIegJJDjdaDLNapeSya143Dux2hXwNEZJ9d
 +OiuY3iEiZc65s/5Fw29dMp+43FEcQ4zZACl1HNjZlGoJ3GJRLXyAfb0MPDuIExC6uAPWHFc5HU
 VENDgPtuVmsFN7E6XiZ8AGQpySLdsSDWmAUc1A+4GN29E070NYnebHLM7aHy1X8MFODwCdLnCkf
 Wn0fl7gCtCMcHdJ1TlC/CZwBOhmvC2VNsBVKb7D
X-Received: by 2002:a05:690e:120f:b0:64d:626a:f4fd with SMTP id
 956f58d0204a3-64ff743d5b3mr14352061d50.71.1774956849681; 
 Tue, 31 Mar 2026 04:34:09 -0700 (PDT)
X-Received: by 2002:a05:690e:120f:b0:64d:626a:f4fd with SMTP id
 956f58d0204a3-64ff743d5b3mr14352041d50.71.1774956849210; Tue, 31 Mar 2026
 04:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260320163844.754762-1-lvivier@redhat.com>
In-Reply-To: <20260320163844.754762-1-lvivier@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 31 Mar 2026 13:33:32 +0200
X-Gm-Features: AQROBzB5fGSau2jTpMHGgSFoAvh_Nfn_A0Ehne1FShRSeaXkm-WB7hR9H8Q3F5w
Message-ID: <CAJaqyWeqgO9fR+Xi5rtBw0VL=gaMBFa9N7wV20bYhEgq3SbMMw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: allow vhost-user backends to provide config
 space
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 20, 2026 at 5:40=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> Remove the vDPA-only guard on vhost_net_get_config/set_config calls so
> any vhost backend that negotiates VHOST_USER_PROTOCOL_F_CONFIG can
> provide device configuration.
>
> To manage backends that don't support vhost_net_get_config/set_config,
> modify the stubs and vhost_net_get_config/vhost_net_set_config
> with NULL vhost_net parameter to return -ENOSYS.
>
> Until now VHOST_USER_PROTOCOL_F_CONFIG was requisited with the
> supports_config flag in VhostUserState or ignored, but now stop
> stripping VHOST_USER_PROTOCOL_F_CONFIG when the device code doesn't
> explicitly require it, so vhost-user backends that advertise F_CONFIG
> can negotiate it.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/net/vhost_net-stub.c |  4 ++--
>  hw/net/vhost_net.c      |  8 ++++++++
>  hw/net/virtio-net.c     | 36 ++++++++++--------------------------
>  hw/virtio/vhost-user.c  | 31 +++++++++++--------------------
>  4 files changed, 31 insertions(+), 48 deletions(-)
>
> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> index 0740d5a2ebe6..6edc0a222f3b 100644
> --- a/hw/net/vhost_net-stub.c
> +++ b/hw/net/vhost_net-stub.c
> @@ -53,12 +53,12 @@ void vhost_net_get_features_ex(struct vhost_net *net,=
 uint64_t *features)
>  int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>                           uint32_t config_len)
>  {
> -    return 0;
> +    return -ENOSYS;
>  }
>  int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
>                           uint32_t offset, uint32_t size, uint32_t flags)
>  {
> -    return 0;
> +    return -ENOSYS;
>  }
>
>  void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *fe=
atures)
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index a8ee18a91266..13f926b5cfb6 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -42,11 +42,19 @@ void vhost_net_get_features_ex(struct vhost_net *net,=
 uint64_t *features)
>  int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>                           uint32_t config_len)
>  {
> +    if (net =3D=3D NULL) {
> +        return -EINVAL;
> +    }
> +
>      return vhost_dev_get_config(&net->dev, config, config_len, NULL);
>  }
>  int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
>                           uint32_t offset, uint32_t size, uint32_t flags)
>  {
> +    if (net =3D=3D NULL) {
> +        return -EINVAL;
> +    }
> +
>      return vhost_dev_set_config(&net->dev, data, offset, size, flags);
>  }
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a6476..7ad2dac450d9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -180,17 +180,9 @@ static void virtio_net_get_config(VirtIODevice *vdev=
, uint8_t *config)
>                   n->rss_data.supported_hash_types);
>      memcpy(config, &netcfg, n->config_size);
>
> -    /*
> -     * Is this VDPA? No peer means not VDPA: there's no way to
> -     * disconnect/reconnect a VDPA peer.
> -     */
> -    if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_=
VDPA) {
> -        ret =3D vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *=
)&netcfg,
> -                                   n->config_size);
> -        if (ret =3D=3D -1) {
> -            return;
> -        }
> -
> +    ret =3D vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&ne=
tcfg,
> +                               n->config_size);
> +    if (ret >=3D 0) {
>          /*
>           * Some NIC/kernel combinations present 0 as the mac address.  A=
s that
>           * is not a legal address, try to proceed with the address from =
the
> @@ -223,15 +215,9 @@ static void virtio_net_set_config(VirtIODevice *vdev=
, const uint8_t *config)
>          qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>      }
>
> -    /*
> -     * Is this VDPA? No peer means not VDPA: there's no way to
> -     * disconnect/reconnect a VDPA peer.
> -     */
> -    if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_=
VDPA) {
> -        vhost_net_set_config(get_vhost_net(nc->peer),
> -                             (uint8_t *)&netcfg, 0, n->config_size,
> -                             VHOST_SET_CONFIG_TYPE_FRONTEND);
> -      }
> +    vhost_net_set_config(get_vhost_net(nc->peer),
> +                         (uint8_t *)&netcfg, 0, n->config_size,
> +                         VHOST_SET_CONFIG_TYPE_FRONTEND);
>  }
>
>  static bool virtio_net_started(VirtIONet *n, uint8_t status)
> @@ -3868,6 +3854,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIONet *n =3D VIRTIO_NET(dev);
> +    struct virtio_net_config netcfg =3D {};
>      NetClientState *nc;
>      int i;
>
> @@ -4023,12 +4010,9 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>      nc =3D qemu_get_queue(n->nic);
>      nc->rxfilter_notify_enabled =3D 1;
>
> -   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> -        struct virtio_net_config netcfg =3D {};
> -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> -        vhost_net_set_config(get_vhost_net(nc->peer),
> -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONT=
END);
> -    }
> +    memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> +    vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg, 0,
> +                         ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);

Hi!

This is a vdpa specific workaround, kind of. As an open question,
perhaps omitting this `set_config` is better so vhost-user has
consistent parameters? On one hand I think it's weird to honor only
the MAC address from the command line and ignore all other parameters
like mq=3D or vlan=3D. From the other point of view, making vhost-vdpa and
vhost-user consistent offers benefits.

Or maybe to set the mac address is the motivation for this?

>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index a8907cca74ec..2c310403851f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2196,28 +2196,19 @@ static int vhost_user_backend_init(struct vhost_d=
ev *dev, void *opaque,
>              return -EPROTO;
>          }
>
> -        /*
> -         * We will use all the protocol features we support - although
> -         * we suppress F_CONFIG if we know QEMUs internal code can not s=
upport
> -         * it.
> -         */
>          protocol_features &=3D VHOST_USER_PROTOCOL_FEATURE_MASK;
>
> -        if (supports_f_config) {
> -            if (!virtio_has_feature(protocol_features,
> -                                    VHOST_USER_PROTOCOL_F_CONFIG)) {
> -                error_setg(errp, "vhost-user device expecting "
> -                           "VHOST_USER_PROTOCOL_F_CONFIG but the vhost-u=
ser backend does "
> -                           "not support it.");
> -                return -EPROTO;
> -            }
> -        } else {
> -            if (virtio_has_feature(protocol_features,
> -                                   VHOST_USER_PROTOCOL_F_CONFIG)) {
> -                warn_report("vhost-user backend supports "
> -                            "VHOST_USER_PROTOCOL_F_CONFIG but QEMU does =
not.");
> -                protocol_features &=3D ~(1ULL << VHOST_USER_PROTOCOL_F_C=
ONFIG);
> -            }
> +        /*
> +         * Fail if vhost-user device expects F_CONFIG but backend doesn'=
t
> +         * provide it. Otherwise negotiate as usual.
> +         */
> +        if (supports_f_config &&
> +            !virtio_has_feature(protocol_features,
> +                                VHOST_USER_PROTOCOL_F_CONFIG)) {
> +            error_setg(errp, "vhost-user device expecting "
> +                       "VHOST_USER_PROTOCOL_F_CONFIG but the vhost-user =
backend does "
> +                       "not support it.");
> +            return -EPROTO;
>          }
>
>          if (!u->user->supports_inflight_migration ||
> --
> 2.53.0
>
>


