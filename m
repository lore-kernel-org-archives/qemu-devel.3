Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64BBC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 07:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Q4Z-0006xp-CY; Wed, 09 Apr 2025 03:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2Q4Y-0006xf-5A
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2Q4W-0004rw-FL
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744184527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8yFHkA23yfSNPyQwsAyyaURc5Mbbu555H4ayzbj77o=;
 b=UJdo4RZtpAc1EfldOGRqLy04DykZLXgRUifZ/pIpX4sjLWuqkhZTZFa9UuLz5ZYtGEICoK
 esT21kt4kqPc7cThU2MIsaqcCYcEwnucD6YuDxN7gr/dOqCnzlgVM8YHk7YLZWfIipkT8e
 cvCjTPlQSVz+Dzc3O/BkMO0wizOY7Jo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-DZ_pjhMNNJa4U_AuVI-8Lw-1; Wed, 09 Apr 2025 03:42:02 -0400
X-MC-Unique: DZ_pjhMNNJa4U_AuVI-8Lw-1
X-Mimecast-MFC-AGG-ID: DZ_pjhMNNJa4U_AuVI-8Lw_1744184522
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac31adc55e4so159567766b.3
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 00:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744184522; x=1744789322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8yFHkA23yfSNPyQwsAyyaURc5Mbbu555H4ayzbj77o=;
 b=jFVzKM0KfjJzJHgQPJiVP9rs8QcdXezVWz5CAHtcKON4ttzqE+Ipb7n+75ZP9avn3m
 k8hfZ+G656xRxJmm7HWNK12e93FRL2WlnTOmc0LsweC/4ta3JwRkJDbOt3YmP8uPEcVd
 3D+m2TXyzkIjLSBIt0pyDNh1bqhWOIIQigPM3wlgpKFl11XdE6apvg/sonXg0hdqAq8o
 nWnf/jLxUpHOEIYUnncM2SQB0K7+EytPHLe+3jmk7PT1EAMQmQ1yovivCFKsEzOfXiZA
 tWvE//bS1fnz9ZkFFFnNGwWG3WRgofrdBDivRVrHo0ooXFsE/+2GNUyQ3yEfEPis84Sb
 FEmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNZ1LQQF90MIx1ZoP9I+R9sViV9h6pqO8l2syibKQ0B3lcBEp2w7GboNSD6mTv7Bum1iNOwC4lmwTS@nongnu.org
X-Gm-Message-State: AOJu0Yzr4CXkxyh0o8QJP0mfMe4MB7TSBR1QJaY+JaHPUuDuqElUtidt
 FEKfWTMfrmwCy1NJmezs3kt98dqjFfUgjo7dtIu4e6kZ6JYcOz1XG39Firz2PLlInzIYadd2+Ra
 rDl3hX0Vcoym4L/YKkk+qyR/B5rSrtk4J3OEl7EVsxskO3n5i+FX6LttQZLwzcZHcD6TUzjL1dT
 u4OgKaWQil/VWxmwGIw1doCT6Qgl0=
X-Gm-Gg: ASbGncsC1EiM3WfjGfBgid5dbdM/3Lw6DCHn9uSsd0NDtD6XOqgf4M6jewIMQ7cGm6w
 U2nqeAqQYAo3V9ryjgyY1iaFwgtrjk60xWQa3iLb850hKzmshAdQ75tTEzEvBKcp2kVm12w==
X-Received: by 2002:a17:907:960f:b0:ac3:cabc:1be7 with SMTP id
 a640c23a62f3a-aca9b72ee2bmr176990766b.48.1744184521685; 
 Wed, 09 Apr 2025 00:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGogT1Q3I1ppYOwQ/nZSaw01NFajRpjA2ZTUJQCq2jCr05RspcBQ1AnfEewZ/UWtPLI/V/ntYT6oFt21tsQ/Fw=
X-Received: by 2002:a17:907:960f:b0:ac3:cabc:1be7 with SMTP id
 a640c23a62f3a-aca9b72ee2bmr176988466b.48.1744184521311; Wed, 09 Apr 2025
 00:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-2-lulu@redhat.com>
 <CACGkMEt5CzZFfainmRA2jPSDx2EgY6QvfyRHpUMZ=GamcxFWzQ@mail.gmail.com>
In-Reply-To: <CACGkMEt5CzZFfainmRA2jPSDx2EgY6QvfyRHpUMZ=GamcxFWzQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 9 Apr 2025 15:41:24 +0800
X-Gm-Features: ATxdqUHwBBQbrJ0c6eEjlKjud5Oau94a5yGZegxEpMWzwBz49vUQLksJQhBLgY4
Message-ID: <CACLfguUXkwYpYMTxkVPQrEO_hLm_YobFrUiQJE99=Cs4+rCG5Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] vhost_vdpa : Add a new parameter to enable check
 mac address
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 8, 2025 at 2:38=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Apr 8, 2025 at 2:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When using a VDPA device, it's important to ensure that the MAC
> > address is correctly set.
> > Add a new parameter in qemu cmdline to enable this check, default value
> > is false
> >
> > The usage is:
> > ....
> > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0=
,check-mac=3Dtrue\
> > -device virtio-net-pci,netdev=3Dvhost-vdpa0\
> > ....
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  include/net/net.h | 1 +
> >  net/vhost-vdpa.c  | 4 ++++
> >  qapi/net.json     | 5 +++++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/include/net/net.h b/include/net/net.h
> > index cdd5b109b0..fac1951b6e 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -112,6 +112,7 @@ struct NetClientState {
> >      bool is_netdev;
> >      bool do_not_pad; /* do not pad to the minimum ethernet frame lengt=
h */
> >      bool is_datapath;
> > +    bool check_mac;
> >      QTAILQ_HEAD(, NetFilterState) filters;
> >  };
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 7ca8b46eee..ba1da31741 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -1870,6 +1870,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, con=
st char *name,
> >                                       iova_range, features, shared, err=
p);
> >          if (!ncs[i])
> >              goto err;
> > +
> > +        ncs[i]->check_mac =3D opts->check_mac;
> >      }
> >
> >      if (has_cvq) {
> > @@ -1882,6 +1884,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, con=
st char *name,
> >                                   errp);
> >          if (!nc)
> >              goto err;
> > +
> > +        nc->check_mac =3D opts->check_mac;
>
> Unless we need to iterate all the ncs during the startup, I think it
> would be sufficient to store it in nc[0]?
>
sure, will fix this
> >      }
> >
> >      return 0;
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 310cc4fd19..a5c70d1df8 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -510,6 +510,10 @@
> >  # @queues: number of queues to be created for multiqueue vhost-vdpa
> >  #     (default: 1)
> >  #
> > +# @check-mac: Enable the check for whether the device's MAC address
> > +#     and the MAC in QEMU command line are acceptable for booting.
> > +#     (default: false)
> > +#
> >  # @x-svq: Start device with (experimental) shadow virtqueue.  (Since
> >  #     7.1) (default: false)
> >  #
> > @@ -524,6 +528,7 @@
> >      '*vhostdev':     'str',
> >      '*vhostfd':      'str',
> >      '*queues':       'int',
> > +    '*check-mac':    'bool',
>
> To make this more useful, we probably need to make it true by default
> and do the compatibility work. Btw, while at it, do we need to check
> MTU as well?
>
> Thanks
>
Sure, will change this,
but there is another issue, the kernel and vdpa tool don't support MTU yet.
Should we add an MTU check later?
Thanks

cindy

> >      '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
> >
> >  ##
> > --
> > 2.45.0
> >
>


