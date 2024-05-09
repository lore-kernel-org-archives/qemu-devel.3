Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB193C25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 05:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wbf-0005rt-Qp; Thu, 09 May 2024 01:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4wbd-0005i7-QP
 for qemu-devel@nongnu.org; Thu, 09 May 2024 01:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4wbc-0005nf-0i
 for qemu-devel@nongnu.org; Thu, 09 May 2024 01:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715233570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJ2Q5TA8yDu/fU/LkLYcnw1zhjQVZvpDDfYWOLRKprI=;
 b=E3m680uVgzsIHqOoanE8iaXm2cB9Qo1C2/OYjbt/HsU5A3jIa57QorqvtLSAiBw8jwRs4r
 aCLYKaT/gBtx85xqtfhdSI310b8wh8ccO8JfdXKtKP/pGZIG7cs0DCNEPlC8yCzl4ZOJNv
 tjARUydomynICcGm7HntSNXQ1rqJhcc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-7Z1hyFJYM-u9MjlRYBTrUQ-1; Thu, 09 May 2024 01:46:09 -0400
X-MC-Unique: 7Z1hyFJYM-u9MjlRYBTrUQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-61be530d024so8455587b3.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 22:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715233569; x=1715838369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJ2Q5TA8yDu/fU/LkLYcnw1zhjQVZvpDDfYWOLRKprI=;
 b=wMAOB+x49ujJd+bv/Rb0073hZMoGtzBZaZiwXLWEGi2UsPQ6CtG5WyxTUo35NI3EJR
 0yMPkJl/6CR4I+bZFNGitmHywJHiu6JlBwSqy28TiN1HvExkV4NAC5h4wy2zj/t+MtIQ
 3xpUOAmUjYXY9sDFNNEHyM5Tji0Tv52wwTAAr6O1GONVRZ+OVmgxhd7WcRUWHR7Bdmxv
 1VRbHmSDj+AXb5tekFXXcjF6dx2ZXlmJ3P4jHX8QddIL/2gFuQPTxdE4PWQOMRRmLfhk
 pdMe4EMedxWav9nZipvnTYx7Lb6LdyRyOlpAzPS1A810DL4OqlMGO9ZNmPso9bL8kmAl
 63cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlS6V62JZ85mw+YWC5jI+d32HcsTyz2T4gTQxz6mL2FNXyuRKi0sxBB4wehMijJF+btDudXw+06ur2zazDdKqd9xP8gmI=
X-Gm-Message-State: AOJu0YxMS0oA4Jc0druXcN8ljBeCvXjOH2iV+hy7Mogkn82cWt+yW3MX
 IMB3hheiFAV5xQhIGT9pVpQblhNUs0X0YjrkAWDBkiGtK5uwhiNSjFQkpDmei7GRBW4bPZQNptd
 DYZgHjl3tuedjVStCbFc4hZJGPxxnVoUpGbd4sL8aPEbzoESvdmcEE5/Uo6vbHdDVHzMYRaZw2O
 1nT/bpSVMRlgduq+MKMBYMYq2EpCY=
X-Received: by 2002:a05:690c:4b05:b0:61b:958b:6c4 with SMTP id
 00721157ae682-62085d50629mr52409417b3.33.1715233567716; 
 Wed, 08 May 2024 22:46:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU9ZMcTGshNgucDHVs3eRDFMyx1Ml2Df8d6+Px5mbq66DGqHGBJugwCc49uob16T2k2y2CDcbt7XIuUrOXKRA=
X-Received: by 2002:a05:690c:4b05:b0:61b:958b:6c4 with SMTP id
 00721157ae682-62085d50629mr52408967b3.33.1715233564925; Wed, 08 May 2024
 22:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240422014041.5706-2-wafer@jaguarmicro.com>
 <CACGkMEsx1TKnCwHWnPN0srv3Xvf_Ji1Kx=y6mxVZ0AW_Zg7hDA@mail.gmail.com>
 <PUZPR06MB4713007E9C50E8EA599C44F6A2E62@PUZPR06MB4713.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB4713007E9C50E8EA599C44F6A2E62@PUZPR06MB4713.apcprd06.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 9 May 2024 07:45:28 +0200
Message-ID: <CAJaqyWeShbAcayZ+7noDocdGNb-p=OAVxK3X5MaaPxUtrh_vBQ@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
To: Wafer <wafer@jaguarmicro.com>
Cc: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

On Thu, May 9, 2024 at 6:32=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote:
>
>
>
> On Wed, May 08, 2024 at 12:01 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Apr 22, 2024 at 9:41=E2=80=AFAM Wafer <wafer@jaguarmicro.com> w=
rote:
> > >
> > > The virtio-1.3 specification
> > > <https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> wri=
tes:
> > > 2.8.6 Next Flag: Descriptor Chaining
> > >       Buffer ID is included in the last descriptor in the list.
> > >
> > > If the feature (_F_INDIRECT_DESC) has been negotiated, install only
> > > one descriptor in the virtqueue.
> > > Therefor the buffer id should be obtained from the first descriptor.
> > >
> > > In descriptor chaining scenarios, the buffer id should be obtained
> > > from the last descriptor.
> > >
> > > Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
> > >
> > > Signed-off-by: Wafer <wafer@jaguarmicro.com>
> > > ---
> > >  hw/virtio/virtio.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c index
> > > 871674f9be..f65d4b4161 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -1739,6 +1739,11 @@ static void *virtqueue_packed_pop(VirtQueue
> > *vq, size_t sz)
> > >              goto err_undo_map;
> > >          }
> > >
> > > +        if (desc_cache !=3D &indirect_desc_cache) {
> > > +            /* Buffer ID is included in the last descriptor in the l=
ist. */
> > > +            id =3D desc.id;
> > > +        }
> >
> > It looks to me we can move this out of the loop.
> >
> > Others look good.
> >
> > Thanks
> >
>
> Thank you for your suggestion, I'll move out.
>

Please add my

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

When you do.

Thanks!


> > > +
> > >          rc =3D virtqueue_packed_read_next_desc(vq, &desc, desc_cache=
, max,
> > &i,
> > >                                               desc_cache =3D=3D
> > >                                               &indirect_desc_cache);
> > > --
> > > 2.27.0
> > >
>


