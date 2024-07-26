Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A524C3DA64
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 02:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXAS5-0007kF-L8; Thu, 25 Jul 2024 22:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sXARw-0007jL-EL
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sXARt-0001UN-Uk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721959968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68qXEV2QOs5A+nfyOfVtC96FPOGyDocpRDCoKxAMlSo=;
 b=O/NNSZDZRUXTmXaqdIXue/qTv0BOYoNYVzhDBj/hEZikK1oeB1f0dTCyBgzrM+aCJGab4l
 u+N8hGvPjvKnQjznJyOS2L1seeGbtXiwvx5ZysTFLqHn02r/1dSspQir/HbSV2TwH4GeIV
 3zjJUoft4d6j+2eU3aqlOSkPiLL1ZW4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-d-H_O9wdMiCAvY1c6vJE_w-1; Thu, 25 Jul 2024 22:12:44 -0400
X-MC-Unique: d-H_O9wdMiCAvY1c6vJE_w-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb4ea563dfso577756a91.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 19:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721959963; x=1722564763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68qXEV2QOs5A+nfyOfVtC96FPOGyDocpRDCoKxAMlSo=;
 b=eIk3xeZs/uwwdeIHtoKseQHkdehXM0jknRT5nelw3RkY/krREdEbUMS0KI/gVct/yz
 AYEwNAp3BnDPFNBb8UjfzuYmEhNg8RDDyshGms7NvAiZv0NovhJUGOl5pfTaEbdfCohS
 A5/x6wymWaOWywmBDsJpeiiM7pAhWZh/g4gwRqEpbupJvKfvJ00LjT8SyWCGazlVIosn
 LL/g9qIPRpvgyyjfJSFZS3OpAwVSsDSNADDjZbLpA3KguRcrulUhmWJ7tkmaUtqGfcIt
 FC4atqHFHTk6NhfBSOfiNvRZj7fPnIy/U7zT91tYyxWDfe9Bryax7Y4eGq6NzyT7HGYD
 6+gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDZB/4G62nS1Sf5MdSxJP2/eiEMPWHpfcCaIvHu9dxJOMvFJpIPDhV0hG/avfjtYpfeA3kjv1Q3C8vAv7aUUtN7v2Pq6s=
X-Gm-Message-State: AOJu0Yx2kap8wU1XpdW8zwOUo51yasz6mXJroLbdqLQrQ455oPqHCgKm
 w4Rbb4aZZ7K6VKXLdLLEjd5ZHEixOQM6mZm6Ok0d+ubtEJ5YDHGf4BKRmdWYKOFPpzY8cTBP3Ok
 wD3nkGgCcAn5by/8bVFl/jwdzU2S17Xpl2z6X9RFuN9xiDzj8HFoQ6lujH4d08X7XIerMEL2vDu
 jTEP41l0twNCaq7GFQ/E5ymPG8L18=
X-Received: by 2002:a17:90a:fe82:b0:2c9:83f3:1291 with SMTP id
 98e67ed59e1d1-2cf238b9040mr5464851a91.34.1721959963208; 
 Thu, 25 Jul 2024 19:12:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfPovOJ5Ahnr1fxpiBto5mt2QYQWnMFa+nRj2FqDcmIIhl85AHYL6FD+34rtNGcWrVo8D44+QBFc0u9V9rXYM=
X-Received: by 2002:a17:90a:fe82:b0:2c9:83f3:1291 with SMTP id
 98e67ed59e1d1-2cf238b9040mr5464820a91.34.1721959962665; Thu, 25 Jul 2024
 19:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com> <ZqLPLBnbfD5r6z7D@x1n>
In-Reply-To: <ZqLPLBnbfD5r6z7D@x1n>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Jul 2024 10:12:31 +0800
Message-ID: <CACGkMEuueZsSCRgNvgMXB7Hr0t2xD+EbqgFsF49oUZE8wnBDDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, 
 sriram.yagnaraman@est.tech, mst@redhat.com, sw@weilnetz.de, 
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 6:19=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > USO features of virtio-net device depend on kernel ability
> > to support them, for backward compatibility by default the
> > features are disabled on 8.0 and earlier.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>
> Looks like this patch broke migration when the VM starts on a host that h=
as
> USO supported, to another host that doesn't..
>
> Yuri, would it be possible we always keep all the USO* features off by
> default (so this feature bit never affects migration ABI), but then:
>
>   - only enable them when the user specified ON
>
>   - meanwhile, if detecting host feature doesn't support USO*, it could
>     fail qemu from boot, rather than silently turning it from ON->OFF
>
> ?

I agree, I have raised the same issue several times in the past.

>
> Silently flipping the bit may cause migration issues like this.

Looking at virtio_net_get_features(), it silently clears a lot of features.=
..

Thanks
>
> Or any suggestion on how to fix migration?
>
> Thanks,
>
> > ---
> >  hw/core/machine.c   |  4 ++++
> >  hw/net/virtio-net.c | 31 +++++++++++++++++++++++++++++--
> >  2 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index f0d35c6401..a725e76738 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -38,10 +38,14 @@
> >  #include "exec/confidential-guest-support.h"
> >  #include "hw/virtio/virtio.h"
> >  #include "hw/virtio/virtio-pci.h"
> > +#include "hw/virtio/virtio-net.h"
> >
> >  GlobalProperty hw_compat_8_0[] =3D {
> >      { "migration", "multifd-flush-after-each-section", "on"},
> >      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> > +    { TYPE_VIRTIO_NET, "host_uso", "off"},
> > +    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > +    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> >  };
> >  const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index d2311e7d6e..bd0ead94fe 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -659,6 +659,15 @@ static int peer_has_ufo(VirtIONet *n)
> >      return n->has_ufo;
> >  }
> >
> > +static int peer_has_uso(VirtIONet *n)
> > +{
> > +    if (!peer_has_vnet_hdr(n)) {
> > +        return 0;
> > +    }
> > +
> > +    return qemu_has_uso(qemu_get_queue(n->nic)->peer);
> > +}
> > +
> >  static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_=
bufs,
> >                                         int version_1, int hash_report)
> >  {
> > @@ -796,6 +805,10 @@ static uint64_t virtio_net_get_features(VirtIODevi=
ce *vdev, uint64_t features,
> >          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
> >          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
> >
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> > +
> >          virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
> >      }
> >
> > @@ -804,6 +817,12 @@ static uint64_t virtio_net_get_features(VirtIODevi=
ce *vdev, uint64_t features,
> >          virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
> >      }
> >
> > +    if (!peer_has_uso(n)) {
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> > +    }
> > +
> >      if (!get_vhost_net(nc->peer)) {
> >          return features;
> >      }
> > @@ -864,14 +883,16 @@ static void virtio_net_apply_guest_offloads(VirtI=
ONet *n)
> >              !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_US=
O6)));
> >  }
> >
> > -static uint64_t virtio_net_guest_offloads_by_features(uint32_t feature=
s)
> > +static uint64_t virtio_net_guest_offloads_by_features(uint64_t feature=
s)
> >  {
> >      static const uint64_t guest_offloads_mask =3D
> >          (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
> >          (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
> >          (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
> >          (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
> > -        (1ULL << VIRTIO_NET_F_GUEST_UFO);
> > +        (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
> > +        (1ULL << VIRTIO_NET_F_GUEST_USO4) |
> > +        (1ULL << VIRTIO_NET_F_GUEST_USO6);
> >
> >      return guest_offloads_mask & features;
> >  }
> > @@ -3924,6 +3945,12 @@ static Property virtio_net_properties[] =3D {
> >      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOW=
N),
> >      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> >      DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> > +    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_GUEST_USO4, true),
> > +    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_GUEST_USO6, true),
> > +    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_HOST_USO, true),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > --
> > 2.34.3
> >
> >
>
> --
> Peter Xu
>


