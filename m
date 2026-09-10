Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDEAC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4c8w-00031B-4l; Thu, 10 Sep 2026 06:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4c8u-0002zx-3A
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4c8s-0007Kv-1J
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789036588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDbQCeLzfNu84VLy+xV0QX+4I4coPrPPbOutCorIy38=;
 b=NC8KMsPDtBI/Uvno+Y3MtW0avhkNGtXkdtFRag+kxAthC4M6WnonryT7S9qcKVwd4hx1Ji
 +AQ422bUTzaOGU1GrEsYG9D0SDeqYjzVIsKOYnBaogjV/WBNw7qGZayrHYl5f4DzlIqDuu
 IjbS/SYHnHju+v+ZZ4H+XtTejUyDWJM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-M73MfMcLOp2ub6QN0WG5xg-1; Thu, 10 Sep 2026 06:36:25 -0400
X-MC-Unique: M73MfMcLOp2ub6QN0WG5xg-1
X-Mimecast-MFC-AGG-ID: M73MfMcLOp2ub6QN0WG5xg_1789036584
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so5206224a12.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 03:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789036584; cv=none;
 d=google.com; s=arc-20260327;
 b=QcELn8oDKj5WpQBxPPU5Tto63NmNk4sw01Eev/j49THxoXsuG12qvGBEjTCl009dwA
 NzifbfJImtlLlYpDYgW+VbFPQ/G7k9Fy60Zlh1NXxloFbwcgdqt4bW6K3eKuW0wpWTRK
 /3xkfsmKh7VX47dGTSnI9KWcydX5BvC6g+VTiKqNnGExc388HnUGZscHLUtECX9+2U35
 wEZiGpDdtlEy6fpQJZpqJVf6Iu+tXdmIBo5hYE+LEO0yp/n11IB0gjvlbtXJ0jezcRWn
 VbfVMy4Or6d16afOxF31oOKU/cP0GXDCbKjeLqHLBCbOtoZacR7bdmxGoo1dl110gEny
 KSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VDbQCeLzfNu84VLy+xV0QX+4I4coPrPPbOutCorIy38=;
 fh=HLSuPskybtIIysCDrrCUGCclYLaEEdtpVmqnrjAgGtQ=;
 b=JWSBNMePfkBf5lMIKGJz0PmTLR13WkxEYa1SBAOKhi6Y5Stm3VI4LIHaELdv0hgKmN
 v/rGYZ/CDblW731u+rqKl2huRXNgMjZj5N9/u9RzdNJarahymFZbBidyeo/IaHvlrDN2
 7Dg6jHHeuTX6h0JCjQwG53Vs5FfxBMx6mTtOlDWsRiZT0n/WGgVAlOps+3O1FzfgOmtD
 RnJZyrLrIyJMyHywVIjz3bbgSAtPqceY2/1mY+PqTeRpGwF/ZWwZQAvs+cy5CWIjrFqS
 kwsH90Ad09ERSj4yG7ao0V0ppuNKDcxNUb2TFs1xhbMrIWRrajIFt4ut7HwAgSz3AAOk
 CR5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789036584; x=1789641384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VDbQCeLzfNu84VLy+xV0QX+4I4coPrPPbOutCorIy38=;
 b=Wc0z7P3TfJ4neq29HK0xOfIc1xSFpKkEF0hqBmGgeoNNBpXfBh4jMHPFrl3wK7N2vX
 uCvcg+gqpCkm9FCAN3C8g/UVc7k/gTA1FFHhUqo7Z6Ceu7MwT4JhxWIY6WJ8NNjMk0v6
 sM+UCdANKUkK8i4ENcssQBzl1UQ+R9vkIqd7bghMPvhQJQ70LU1DSLqcN15XewK7botd
 KTMh7Y0LBJ6OEOMU/zz3OdunhBn2loN0JcF4fZHm65azRG/089mpT3qsyQXhnoKFErVA
 /2aosXvwl33D7Dd52OCnIyL+I2lQ9Y0zOzaEJabeOCEPUWAzQKekksz8Beb22YTfHx8/
 hrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789036584; x=1789641384;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VDbQCeLzfNu84VLy+xV0QX+4I4coPrPPbOutCorIy38=;
 b=IqGpG3y7f2EV4aDQlKnm2QjQO8hFJZDqWnEcGnQkQTVXtZKg95Mn4+7MlPe8xywbNv
 kAoLGn0584ek26nnEGot5sx9jNsgimDZRecbIRT8Sy65MQ+Vb5WbOmSgUSNgaq7A5frP
 DRubdXoxNjpOCe0iMZ7DVVFWfrIuWoAayIVifP0RZAFIz/9adb3pFwYteDK6vCqZnKN+
 1ezZrsbgPB+VqfbTKt2AG6+vt0MUev250o5i9UwLh2GyyAmxgfRIQUM+AdnBF5mE9wKQ
 Zya03toBai3PXwEMjZMGBORFgnA9d43RYmROMSpeeY3ZQnQ7jMsXk3bkbWFUz+6pEk7N
 g8lw==
X-Gm-Message-State: AFuF++miAKXezZbO+vpBr8qT2OiM4VjmpiBy7wavW/Fy7q5fZmkuVEhK
 b5b60ZMLOe9MsjStkn2b538fiMiAzSSpk/eWdvReBXqtlTTfdpVYjSxOnQzhbf6oJpuFeibP/o6
 HF5lgYAHqoZKOKCSLVoCr6abbkKbHS/p8aGKhcVHcp/Pif4ra0S/dnfvmxsEuHLcCyHrsrdDwE5
 z6dcX0K81WHX/UIYdzvY5/XhJMeXexPws=
X-Gm-Gg: AYBFou0xMr2TFUQrQywNqTYkN5AZE5KREC1ot8IhESG8FORpGJfNnKdRVIPv96HW+Bn
 gEjBqGvPWu5pDWDPG/aDkSOcJ30e1JVVe7OOX3o3zMMisOVnv8hRR4eRMS+RudaUM8tAdmBUOw1
 Gfu82PrxUJdf7O7z8WDyOaBz4XyScIH0JYY93Hc8mdJVOTdSlakJAvidhcRmLUxcUXh9vy4Oz2H
 GItbIEbF0D+zq2tv6/E0JqIBmVU4r/D2KRlIYurR1PT10kE/2X337//fjAzmLhbWLNcU9u93OYq
 bw==
X-Received: by 2002:a17:90a:da8d:b0:399:1b08:28de with SMTP id
 98e67ed59e1d1-39d709c049fmr10205055a91.7.1789036583831; 
 Thu, 10 Sep 2026 03:36:23 -0700 (PDT)
X-Received: by 2002:a17:90a:da8d:b0:399:1b08:28de with SMTP id
 98e67ed59e1d1-39d709c049fmr10204995a91.7.1789036583353; Thu, 10 Sep 2026
 03:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
 <20260910-virtio-gpu-cleanup-v4-20-7d623714bd71@redhat.com>
 <c37e85c9-94f1-422c-b73d-0051a5d35743@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c37e85c9-94f1-422c-b73d-0051a5d35743@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 14:36:11 +0400
X-Gm-Features: AcwNN1Unha2sNf4RrQYgxMWnu85udCdTABHGTlBpTGX10sx5SxPEvqhD_NYl2DI
Message-ID: <CAMxuvaxsG_V31EvSXA_YY7C-Mg1W7PVgQR9-17_GsgnPmCVrQA@mail.gmail.com>
Subject: Re: [PATCH v4 20/24] virtio-gpu: consolidate disabling scanout
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Sep 10, 2026 at 2:28=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/09/10 17:17, Marc-Andr=C3=A9 Lureau wrote:
> > Use the common virtio_gpu_disable_scanout() to reset the scanout state,
> > including GL state if any.
> >
> > Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-rutabaga.c | 4 +---
> >   hw/display/virtio-gpu-virgl.c    | 6 ++----
> >   hw/display/virtio-gpu.c          | 6 ++++--
> >   3 files changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-r=
utabaga.c
> > index 8a82e96b7461..8697dd6936ba 100644
> > --- a/hw/display/virtio-gpu-rutabaga.c
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -312,9 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virti=
o_gpu_ctrl_command *cmd)
> >       scanout =3D &vb->scanout[ss.scanout_id];
> >
> >       if (ss.resource_id =3D=3D 0) {
> > -        scanout->resource_id =3D 0;
> > -        qemu_console_set_surface(scanout->con, NULL);
> > -        qemu_console_gl_scanout_disable(scanout->con);
> > +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> >           return;
> >       }
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 07349c5c5502..9ca7b946ac65 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -618,8 +618,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
> >               ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> >               d3d_tex2d);
> >       } else {
> > -        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].=
con, NULL);
> > -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scano=
ut_id].con);
> > +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> >       }
> >       g->parent_obj.scanout[ss.scanout_id].resource_id =3D ss.resource_=
id;
> >   }
> > @@ -1430,8 +1429,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
> >       int i;
> >
> >       for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> > -        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
> > -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con);
> > +        virtio_gpu_disable_scanout(g, i);
> >       }
> >   }
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index f9083e9577c3..dc5b2da9a43f 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -435,8 +435,10 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int =
scanout_id)
> >   {
> >       struct virtio_gpu_scanout *scanout =3D &g->parent_obj.scanout[sca=
nout_id];
> >
> > -    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> > -
> > +    if (scanout->dmabuf) {
> > +        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> > +    }
>
> I'm not sure why adding an if branch here. It looks simpler without one.

yep, let's drop it.
ack with that change?

> Regards,
> Akihiko Odaki
>
> > +    qemu_console_gl_scanout_disable(scanout->con);
> >       qemu_console_set_surface(scanout->con, NULL);
> >       scanout->resource_id =3D 0;
> >       scanout->ds =3D NULL;
> >
>


