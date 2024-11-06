Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A98D3E798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cZj-0007vh-0a; Wed, 06 Nov 2024 04:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t8cZa-0007ui-Kx
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t8cZX-0005rY-UN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730886198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0E8XGB/Vf+JIU/bYlakdzQ0jUr3RFs2ddl+F7Ct7ZWI=;
 b=hluc0M5myilOY4+ANt25DkSZUP2G/MOk1DGdjY0ZiFvztTFZH3kzchg8m//jlXU8uksLCA
 2EyP9Bn4/nnh+5SdwK1qFX0LwEl02WQoETiy3gAPgUU83/L9zr86X2e9/qPqGDrU+R1W1k
 RydkQ8yoQaiiiz2YpMWnjYXp5jkM0zw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-0dXkqqfoOP6d9N3L-YCjjA-1; Wed, 06 Nov 2024 04:43:17 -0500
X-MC-Unique: 0dXkqqfoOP6d9N3L-YCjjA-1
X-Mimecast-MFC-AGG-ID: 0dXkqqfoOP6d9N3L-YCjjA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a194d672bso490305066b.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 01:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730886195; x=1731490995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0E8XGB/Vf+JIU/bYlakdzQ0jUr3RFs2ddl+F7Ct7ZWI=;
 b=kmVqVDpjym0ZtEcOzcik7s7JLQ0xBjIxsUk4dS8yRLnnGC/AZjEjzzX4pgxnlAMcy9
 oswNmGo1AnzX5mwK5Yd3K3iMcc+kXJiRzkIu0ZMW0o1CR2J9rjNaGIgMOo3iQ6EKfPDk
 YQt9KhhAsApyIgT52dJ3UZQx98n6WuZbUxy0Ri82W9Hsymjm4EShLeb8MeYa3Wi7yCbB
 NehdwoBy5ilBI9zndf13LEkr/GBFJj1ZQD+IpP8HZFSDN8+ZLGZdpTPGPy3XmVZZGlwg
 riRpJnrYRrGmECDKYsu17sY2ApD6y5frC6G+hhPhU5+QqSu0Rbt9WpH+IuKYAfa6oN93
 V+NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdTUpOp9+e/ci1erMashbDEYv1XHA+aNS3orVZNJSJjOTUKSRjlFGF5Dswc53o3xchfYylxEOQRu0F@nongnu.org
X-Gm-Message-State: AOJu0Yy9ZCikZCTv0xpre63g071n194n+NXzz2Yr5iH5anO6gD+93MRn
 8K4GJjJgTBvUGyUxopivOuDoHeQEHkMiKcNkRU2ouhSn20wsid7eDJCeedHgHZMuGYQ/AtjaxT1
 UCHu2NGdb/iukiLokj/oFaT/ndkDfnIkmDGWMqbVPJTjdMQbvcP8hpfC5ERqPnKF7YbUHxejlOz
 tKa81FgWCIi4Q1MDnYBMvhBYnuHv69+uWjVMxwrw==
X-Received: by 2002:a17:907:c0b:b0:a9e:c267:78c5 with SMTP id
 a640c23a62f3a-a9ec267b85emr250780966b.55.1730886194768; 
 Wed, 06 Nov 2024 01:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUhmOTNdnjRkVrIHpAhxAMBXwUW0ZDytAFu7LAw3yjv4dyyGYO5ajkYkifPossP8frdoLZpgXlw4uT/YoHgdI=
X-Received: by 2002:a17:907:c0b:b0:a9e:c267:78c5 with SMTP id
 a640c23a62f3a-a9ec267b85emr250779166b.55.1730886194399; Wed, 06 Nov 2024
 01:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20241026080121.461781-1-lulu@redhat.com>
 <20241026080121.461781-2-lulu@redhat.com>
 <20241106042219-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106042219-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 6 Nov 2024 17:42:37 +0800
Message-ID: <CACLfguV2g7=g6=tz79RM1x0PFDxi8U6LuSUdJeQkJ1gw6c_bGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] vhost_vdpa : Add a new parameter to enable check
 mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 6, 2024 at 5:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sat, Oct 26, 2024 at 03:59:59PM +0800, Cindy Lu wrote:
> > When using a VDPA device, it's important to ensure that the MAC
> > address is correctly set.
> > Add a new parameter in qemu cmdline to enable this check, default value
> > is false
> >
> > The usage is:
> > ....
> > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0=
,macstrickcheck=3Dtrue\
>
> typos in command line are not welcome.
> you should also separate words e.g. by dashes.
> Are there more options than strict?
> Also if not strict, should we still warn?
>
There is no other check for this, Thank you, Michael. I will change
this to a new name.
Thanks
Cindy
>
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
> > index c8f679761b..e00651a97b 100644
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
> > index 46b02c50be..071c3ff065 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -1860,6 +1860,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, con=
st char *name,
> >                                       iova_range, features, shared, err=
p);
> >          if (!ncs[i])
> >              goto err;
> > +
> > +        ncs[i]->check_mac =3D opts->macstrickcheck;
> >      }
> >
> >      if (has_cvq) {
> > @@ -1872,6 +1874,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, con=
st char *name,
> >                                   errp);
> >          if (!nc)
> >              goto err;
> > +
> > +        nc->check_mac =3D opts->macstrickcheck;
> >      }
> >
> >      return 0;
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 87fc0d0b28..7d75119858 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -510,6 +510,10 @@
> >  # @queues: number of queues to be created for multiqueue vhost-vdpa
> >  #     (default: 1)
> >  #
> > +# @macstrickcheck: Enable the check for whether the device's MAC addre=
ss
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
> > +    '*macstrickcheck':    'bool',
> >      '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
> >
> >  ##
> > --
> > 2.45.0
>


