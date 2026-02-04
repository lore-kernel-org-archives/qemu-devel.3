Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057CCE83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX2O-000365-7V; Wed, 04 Feb 2026 02:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vnX2L-00035Q-AB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:10:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vnX2J-00025s-9A
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770189048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDQIDQrOZ7MYzHfBTumi8CZJXJ0KWIrYrNRnd4S3M7U=;
 b=MEa2fvSbipmnYaVB8Qgdicgfvv5JYagt0ZG6prteRjd1X+x8oylAPfyTdazFeuypAG7Od6
 0SxnpulSOeZEiIyTVjlZ9HEUf5nnluNAtHHAbqoOXmrZe9ZJqFaaC8nXT7D4JXtlKj5Vs1
 slkIIgml1uL7I5crpVdG+gpusa7eOLI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ow74XmwcMtCmG0VdiseoZg-1; Wed, 04 Feb 2026 02:10:46 -0500
X-MC-Unique: ow74XmwcMtCmG0VdiseoZg-1
X-Mimecast-MFC-AGG-ID: ow74XmwcMtCmG0VdiseoZg_1770189046
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-948bf9d7537so2799174241.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 23:10:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770189046; cv=none;
 d=google.com; s=arc-20240605;
 b=BEsfWXs2Hwmm6e3/FhwhDRmL48ZsCoPsNaUeUsmtc8i/KxXqtSK2CR5nJDIGnSSK6i
 6ysiumSAuA3idOW+aU1AI0Haa8OCkg41LSuOQDWnqwd/tZeg2YQpb3NxS9wlIdlcGwsn
 D791mpMhpJ+zbCW2xbiwXg0bTG3Ws5287TpiW9PrSGk5WFPRmBowk1mSutGcFxmjzoOW
 o8ta4ZTR/WKoOdezlp6x4EJROWcTGTJ410p2wKqovl77smGwW/tJEjoMWnH8ujiggfty
 a9Iww8L46LApLMzPpPFzAbWaPxiic0dMGd68mY7pb+6v1YSHl1l/+B3SF8aWUsQA3HgX
 Rb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qDQIDQrOZ7MYzHfBTumi8CZJXJ0KWIrYrNRnd4S3M7U=;
 fh=gBtOToTaNo1aGE2ughEX1ep6kf//7VVdGIHBZzJ8XDA=;
 b=NnWfDHg4kylkHyVpz9ecViTVqxtEb1Uh4LDcJxLzohjKeYK7BI+t/aBPA4UcxMiDtp
 WS6TPbfnqXT5sp0RwvBdP/LAZ9KC3kjBHA8YNuNpCHolaB+6/5lj1rA0vu9RrzOCuRXa
 ia03ipN8aoFDh8gZ8uPU36NTfCnn13P3+0c5gxnNLRz8k+nIjvMQ2hVotJVuZbiL656K
 PcNB/JEyDPUM4bkcW2vTMo2A5LgCKcN+eZ3v2KUS+cZkFyf0cavZdsT7O8JgZHo/fWCJ
 HTsP7N5XLAw0Kr/S5Qcp4EX2vdx6V2JUeePrI0tJdscejq8uqot9T+3R6NhOOSbGPVqB
 ZQDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770189046; x=1770793846; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDQIDQrOZ7MYzHfBTumi8CZJXJ0KWIrYrNRnd4S3M7U=;
 b=H98O9uzKsQ/Jzjh/pS3exqnblKFV6sxCM/l8IRwJ+tkJANIcbjZXpbf7IHDf96RTVi
 ICsonQcy2Un/s+1f/j/ZZIdiQ+HWKk1V4N15SIfajiHm6Y7IaXlpta6sLBfeU7Ra8d9t
 +qOJQo635vY9j2GPmzRPpdPI2n3vdn7XNeid4geKwK8mZ6OoQc8ouYwqW2GW1tDMntoi
 GxXPSp9MSv8uAbooC7hkZei2DqShUEswOGkVd2d7GMZPzbVsn+5zZl2sgqIugQRkOnn1
 J32N4kbEagJOXLxXLqkAgnnRtotaLtGpKYoXXKbVq+qFBS4R8vzRIFcfd/gWgIKgq5cb
 hHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770189046; x=1770793846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qDQIDQrOZ7MYzHfBTumi8CZJXJ0KWIrYrNRnd4S3M7U=;
 b=mEJtYaHTX/p4ErHrRA+WEva/9rDhmutNhG22Y7h26H7KH5pfuNUCB4fDqhBFTOh8Nv
 ZkFM8UNPv+QPZ/Sa6veAGmSyVkrNmaM+NnZHuPN9yR2p/xQY7iGASTLDhBWVrVJTeimt
 NME4KN7NSQq1j25qhnaVYHavpWkYyxrpNQfqh7UZ/P2CEpVqHRKveuaKsNwPcwelBsy1
 PrAzzQqVounOi7sVURv3aow2WYOThDooJzZnTSH8NCkq5M7m+XHtEsLKvNXkaWsA3BXQ
 ZsolU/H3p++OXaNIzGqgwyvO5KA2Ra8P2pVMq7CpymIJcrxeL6xJEIgwdl7DkidY54V6
 LwSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxJE5tu7Iu9lo3rrAhlbZfTL1M2O4kZXHbCIuJHUftuOojgyHoE37oDOJzfCWJ0jgvOAmvYJnwQOSK@nongnu.org
X-Gm-Message-State: AOJu0YyuGM2mJ4f5ycQfz9WW9VEoE7fmyZ0Tq3En0CwnpYdqdE8rYjut
 najcRc7aG8GyIIMhht8/TM3xCKw+evfcXWBOQNlXzJjT1w0crYPY10nMWnxtbskLzGfXjhRb3fP
 1ailsYjD8gfSxZSqtCZWD8r9QB4Bxk5qqIQwzCJVoBBRLwg86cH6C1NqLMMVpkCMDCZvIvjpxYj
 bJoP+DWUcxGUMH+7jyyTrvE5rnv8VNves=
X-Gm-Gg: AZuq6aL8jmJgT7LRG2Uge65x412I06KiuGbIWwiVFcpcNITr2IU2KcwqgapSf4zqFY7
 Jo+SeaMdAOrEW3BkkclO0b+ly+ikBukLiPPPwOx4VVIo3mvSFd8eOdcpPmELXbm4m9+TvEMG5px
 BAvrrFdXYban4Y4PYXdWq5myqey4IzpKQu5sGFi94Tuf1NacMLy45sm28SlqIpNTX6O5Q=
X-Received: by 2002:a05:6102:e0e:b0:5f5:7723:28ee with SMTP id
 ada2fe7eead31-5f9394a6de1mr772611137.11.1770189045895; 
 Tue, 03 Feb 2026 23:10:45 -0800 (PST)
X-Received: by 2002:a05:6102:e0e:b0:5f5:7723:28ee with SMTP id
 ada2fe7eead31-5f9394a6de1mr772608137.11.1770189045493; Tue, 03 Feb 2026
 23:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20220921060026.392164-1-chenh@yusur.tech>
 <BL3PR02MB79380882D0B877C2D5A754FFEA4F9@BL3PR02MB7938.namprd02.prod.outlook.com>
 <CACGkMEttGsDrFo_U7AKHEof0HwVfHaRTeQSRE+QTiRPPtnU3hQ@mail.gmail.com>
 <20220922055531-mutt-send-email-mst@kernel.org>
 <fbf87d19-f7ab-dfdb-9f93-4087262cad57@yusur.tech>
 <CACGkMEuc22yQwNTe5NeQH1ooxk_HgM7tpuTFcNKWZVmYEJPAwA@mail.gmail.com>
 <20260203074633-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260203074633-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 4 Feb 2026 15:09:55 +0800
X-Gm-Features: AZwV_QgPZXVuML5U2w3IC1lJFn_Ywkzn81-2M4kNcZxKyTFkVXtDUjjrllxm2x0
Message-ID: <CACLfguUXqbgAjHysFBWR0YVu52bTSzC=na7c9K=hKqXA6eSe-Q@mail.gmail.com>
Subject: Re: [PATCH v2] hw/virtio/vhost-user: support obtain vdpa device's mac
 address automatically
To: =?UTF-8?B?6ZmI5rWp?= <chenh@yusur.tech>
Cc: Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "houyl@yusur.tech" <houyl@yusur.tech>, "zy@yusur.tech" <zy@yusur.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Tue, Feb 3, 2026 at 8:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Sep 23, 2022 at 11:36:38AM +0800, Jason Wang wrote:
> > On Fri, Sep 23, 2022 at 11:33 AM =E9=99=88=E6=B5=A9 <chenh@yusur.tech> =
wrote:
> > >
> > >
> > > On 2022/9/22 17:56, Michael S. Tsirkin wrote:
> > > > On Thu, Sep 22, 2022 at 09:34:41AM +0800, Jason Wang wrote:
> > > >> On Thu, Sep 22, 2022 at 1:58 AM Raphael Norwitz
> > > >> <raphael.norwitz@nutanix.com> wrote:
> > > >>> If I read your response on the other thread correctly, this chang=
e is intended
> > > >>>
> > > >>> to prioritize the MAC address exposed by DPDK over the one provid=
ed by the
> > > >>>
> > > >>> QEMU command line? Sounds reasonable in principle, but I would ge=
t confirmation
> > > >>>
> > > >>> from vDPA/vhost-net maintainers.
> > > >> I think the best way is to (and it seems easier)
> > > >>
> > > >> 1) have the management layer to make sure the mac came from cli
> > > >> matches the underlayer vDPA
> > > >> 2) having a sanity check and fail the device initialization if the=
y don't match
> > > >>
> > > >> Thanks
> > > > I think I agree, we should not overwrite user supplied arguments.
> > > > I think the case where we might want to get the mac from VDPA
> > > > and use it is when it's been assigned randomly as opposed to coming=
 from cli.
> > > Yes, when the cli passes in a random mac address that is inconsistent
> > > with the vdpa device, qemu still starts the virtual machine as usual,
> > > but in this case, the qemu and vdpa environments do not work correctl=
y.
> > > So I want to get mac address directly from vdpa device instead of cli=
.
> >
> > Let's teach the management to do that. It has a lot of advantages, more=
 below.
>
>
> No, making command line friendlier is a good idea.
> the random address from cli is just that, random,
> so why not take it from backend?
>
Yes, we have a vdpa fix recently that allows changing the MAC address
via the vdpa tool before userspace loads. I wonder maybe you can
leverage that.
https://patchew.org/linux/20260126094848.9601-1-lulu@redhat.com/
thanks
cindy
>
> > Not sure for the DPDK case, but kernel vDPA allows the mgmt to
> > provision the vDPA with a mac address which could be used in this
> > case.
> >
> > >
> > > Having a sanity check and fail the device initialization if they don'=
t
> > > match is a good idea, but it seems more convenient to directly overwr=
ite
> > > the cli mac address.
> >
> > This will confuse the management where it may do a lot of mac related s=
etups.
> >
> > Thanks
>
> i do not think any management relies on the random mac hack.
>
> > > >
> > > >
> > > >>>
> > > >>>
> > > >>> That said the way you=E2=80=99re hacking the vhost-user code brea=
ks a valuable check for
> > > >>>
> > > >>> bad vhost-user-blk backends. I would suggest finding another impl=
ementation which
> > > >>>
> > > >>> does not regress functionality for other device types.
> > > >>>
> > > >>>
> > > >>>
> > > >>>
> > > >>>
> > > >>>> From: Hao Chen <chenh@yusur.tech>
> > > >>>> When use dpdk-vdpa tests vdpa device. You need to specify the ma=
c address to
> > > >>>> start the virtual machine through libvirt or qemu, but now, the =
libvirt or
> > > >>>> qemu can call dpdk vdpa vendor driver's ops .get_config through =
vhost_net_get_config
> > > >>>> to get the mac address of the vdpa hardware without manual confi=
guration.
> > > >>>> v1->v2:
> > > >>>> Only copy ETH_ALEN data of netcfg for some vdpa device such as
> > > >>>> NVIDIA BLUEFIELD DPU(BF2)'s netcfg->status is not right.
> > > >>>> We only need the mac address and don't care about the status fie=
ld.
> > > >>>> Signed-off-by: Hao Chen <chenh@yusur.tech>
> > > >>>> ---
> > > >>>> hw/block/vhost-user-blk.c |  1 -
> > > >>>> hw/net/virtio-net.c       |  7 +++++++
> > > >>>> hw/virtio/vhost-user.c    | 19 -------------------
> > > >>>> 3 files changed, 7 insertions(+), 20 deletions(-)
> > > >>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk=
.c
> > > >>>> index 9117222456..5dca4eab09 100644
> > > >>>> --- a/hw/block/vhost-user-blk.c
> > > >>>> +++ b/hw/block/vhost-user-blk.c
> > > >>>> @@ -337,7 +337,6 @@ static int vhost_user_blk_connect(DeviceStat=
e *dev, Error **errp)
> > > >>>>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> > > >>>> -    s->vhost_user.supports_config =3D true;
> > > >>>>      ret =3D vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKE=
ND_TYPE_USER, 0,
> > > >>>>                           errp);
> > > >>>>      if (ret < 0) {
> > > >>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > >>>> index dd0d056fde..90405083b1 100644
> > > >>>> --- a/hw/net/virtio-net.c
> > > >>>> +++ b/hw/net/virtio-net.c
> > > >>>> @@ -166,6 +166,13 @@ static void virtio_net_get_config(VirtIODev=
ice *vdev, uint8_t *config)
> > > >>>>              }
> > > >>>>              memcpy(config, &netcfg, n->config_size);
> > > >>>>          }
> > > >>>> +    } else if (nc->peer && nc->peer->info->type =3D=3D NET_CLIE=
NT_DRIVER_VHOST_USER) {
> > > >>>> +        ret =3D vhost_net_get_config(get_vhost_net(nc->peer), (=
uint8_t *)&netcfg,
> > > >>>> +                                   n->config_size);
> > > >>>> +        if (ret !=3D -1) {
> > > >>>> +               /* Automatically obtain the mac address of the v=
dpa device
> > > >>>> +                * when using the dpdk vdpa */
> > > >>>> +                memcpy(config, &netcfg, ETH_ALEN);
> > > >>>>      }
> > > >>>> }
> > > >>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > >>>> index bd24741be8..8b01078249 100644
> > > >>>> --- a/hw/virtio/vhost-user.c
> > > >>>> +++ b/hw/virtio/vhost-user.c
> > > >>>> @@ -2013,8 +2013,6 @@ static int vhost_user_backend_init(struct =
vhost_dev *dev, void *opaque,
> > > >>>>      }
> > > >>>>      if (virtio_has_feature(features, VHOST_USER_F_PROTOCOL_FEAT=
URES)) {
> > > >>>> -        bool supports_f_config =3D vus->supports_config ||
> > > >>>> -            (dev->config_ops && dev->config_ops->vhost_dev_conf=
ig_notifier);
> > > >>>>          uint64_t protocol_features;
> > > >>>>          dev->backend_features |=3D 1ULL << VHOST_USER_F_PROTOCO=
L_FEATURES;
> > > >>>> @@ -2033,23 +2031,6 @@ static int vhost_user_backend_init(struct=
 vhost_dev *dev, void *opaque,
> > > >>>>           */
> > > >>>>          protocol_features &=3D VHOST_USER_PROTOCOL_FEATURE_MASK=
;
> > > >>>> -        if (supports_f_config) {
> > > >>>> -            if (!virtio_has_feature(protocol_features,
> > > >>>> -                                    VHOST_USER_PROTOCOL_F_CONFI=
G)) {
> > > >>>> -                error_setg(errp, "vhost-user device expecting "
> > > >>>> -                           "VHOST_USER_PROTOCOL_F_CONFIG but th=
e vhost-user backend does "
> > > >>>> -                           "not support it.");
> > > >>>> -                return -EPROTO;
> > > >>>> -            }
> > > >>>> -        } else {
> > > >>>> -            if (virtio_has_feature(protocol_features,
> > > >>>> -                                   VHOST_USER_PROTOCOL_F_CONFIG=
)) {
> > > >>>> -                warn_reportf_err(*errp, "vhost-user backend sup=
ports "
> > > >>>> -                                 "VHOST_USER_PROTOCOL_F_CONFIG =
but QEMU does not.");
> > > >>>> -                protocol_features &=3D ~(1ULL << VHOST_USER_PRO=
TOCOL_F_CONFIG);
> > > >>>> -            }
> > > >>>> -        }
> > > >>>> -
> > > >>>>          /* final set of protocol features */
> > > >>>>          dev->protocol_features =3D protocol_features;
> > > >>>>          err =3D vhost_user_set_protocol_features(dev, dev->prot=
ocol_features);
> > > >>>> --
> > > >>>> 2.27.0
> > > >>>
> > > >
> > >
>


