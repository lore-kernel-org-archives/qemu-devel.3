Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F57C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuutS-0007Cx-9d; Fri, 14 Aug 2026 12:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuutR-0007Ca-1b
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 12:36:29 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuutO-0005BF-KN
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 12:36:28 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a157f90752so1803517a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 09:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786725385; cv=none;
 d=google.com; s=arc-20260327;
 b=W90I7Dx9Gx3T/BNb4cz+kl4JEygvIkouGOmIiwAOcR6OAH7i3+munr35shGtyyiizo
 R6r/moaiXDpFRa5tJPzMLGoUbA0ou0Z57Lvqp8cGFx/VOIOzKEN+DRwf/Qj4WTO2u7kr
 6YyhKW+SEZzHiw0jpISxT0MEJfdH3vSzEeQueIFCA2m55HHvBv1g9QKHRzoKTKjse0G/
 dS3fgGY2kbp2EmLq51fW2hXM3AQwwrKtJTtZtEoi7grc39U4L1jp2wD9WqoXKvbs2jTz
 Nsz/7U51xUs4e68uJ2T4wdAXFfo9t3nrttODsG+TzaLjtfKNwNvD9V+j8O59x87Yu7Xa
 H+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rILL9ROjtzfQeesTc+pm93QP0HwodkeY7Z+/hIWUlnI=;
 fh=YM3Xfs/gGLQA9UJyBgfM/xaPLKAkiosrVbd0SbrThIU=;
 b=IBPMXUy8aYV1n0H8mpbbU1YvaNywFKvwjXUYdLyE1QNp9vdtslhfRinflV8dErQyTH
 tkwjEdPhnTl9vS9ckxVPT923OaGagK1QcScqIdAzCONEf7fen+BXh4EJ3lY2QSYSwBkZ
 x/dXrttbo3/BJUqrDvVRVSGYlee6o0MhSuY/env1B1egxT9qB3cnqzPJt/wcU/CQuszy
 W6kqE1Gx6aaJLqFUpRrVBPOLiq08MY2I/S0KdoSYIRrpgy9iGMITPY6cbU8IrPIwPq/2
 XO99MV5fV2/lxfORVGlmSEpcdGwqPept08m6gwHqDmr+MmXGctz+IqzuGVNYLfVPLthp
 jkjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786725385; x=1787330185; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rILL9ROjtzfQeesTc+pm93QP0HwodkeY7Z+/hIWUlnI=;
 b=Ox5uiRFh3KJHkIEK4AeMRqpqgmclH5VIGz11WjcZYxvdfVOyqQYd+dssjOQoq7rRbH
 foLTz9zddYiEpbJQ0EtVIpAu5aERYoI/qCj8kpR9V+0w1MaZCRzgG7xcUcQlH35rQ+OM
 NhUpFhriP389vt0m6/Wkau/zu1nIp5E582ZgndDjZ/p12iZApgOob8IKxiNdWIIp6G3o
 XIorehKrP+QN0I8MDu0ljD7hmglSTUHWuvGjo2X/II+i/H79cZdMMbTrWz064O4Jr+Qq
 6vuSaQGG6fHVHcOlIBKh3lXw4zaX72rS5S353C4HQCDCOejbida8Dq0whE8yNdWy5h5S
 UxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786725385; x=1787330185;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rILL9ROjtzfQeesTc+pm93QP0HwodkeY7Z+/hIWUlnI=;
 b=KP1tesUGm2s7xs/31/DET8n9R8fJwUOPALDXr4N5ncBj2SOzGNwMbBWR8wY6wanPlL
 QOQX89gM89lDcg4WwlmpBVcuk8ycdFs1stx/sDdSrIcTzxFW7Qgv32oPFPilqcOkhOb+
 mwxWRZEKr5QHvXisp2Sf75Cxs+Xc5vysapdc8ipIG/JplllIfFcgEk9PZDuzuZaE6NJL
 +f+lpNPYpJ/xYwxW6lG72/nZLfLzQoy+PODrih+be7DQH9Qo84pj84niTK7aIe8GpjRk
 Byt2XX/VvXVAoFD0h4N3Yg1G0K0Z7eEnPHFIBxWFcIfEJmILZZczYHuK7KNYaQDDlMm6
 SX0A==
X-Gm-Message-State: AOJu0Yy0RkttVHkiFHv0DeQb0K3oNTl/PbUAx50E7Ne0Zsp/vXGb5cDK
 qcIZWYuyEjLP0Dcc9qAWLK5TfZnr4KM6MhzFMolj2gPtys14oNMZZjvQ+g0rm/CYIGTY1cJMOck
 JECMGwdUvZcqzR8K1ozbUd8uP1YVI7vQ=
X-Gm-Gg: AR+sD103bJYvHxC8NxeNyfrVDgnsms7dGar+F7BDanbAhKoqsBpR/MvpVuPIesqEoJe
 AA7WeVvtTTMQtbTernyi+n8dRO/Z0x79Jkg84SEpQQfO9XBy5mm8Nm2mCUj5BK20m1NNqc4TsnL
 CzOJ17EDJclRTxkaIglumIMOOTOvbNqJpfy3Qji3JIma4y5VW4PtDSVFSOz7kxhlWAfDCdUmIbk
 w4V3q1UBs6+QJhQYRF61iEK38TC4mF9z81F3bon8kfPUq2qwS7CoEv1z2FxHT9Zwfpyv/wmORSs
 Rilo+5A54FwvHQas6wR3xLb+bwxfjiBQRPNRn4ZzcIAR
X-Received: by 2002:a05:6402:1588:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a38a8f9b87mr3770814a12.5.1786725384521; Fri, 14 Aug 2026
 09:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-6-zhangckid@gmail.com>
 <20260811193440.GD170741@fedora>
In-Reply-To: <20260811193440.GD170741@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 15 Aug 2026 00:36:12 +0800
X-Gm-Features: AcwNN1Xi2CGmUtalgmYGPAufO0IeVOz25pOPFefJakD-YdxL3I0oAIZ-0Ky5WzE
Message-ID: <CAK3tnvLVrHPderbYRq29OrMinHG3gX=T+LiAxNFuBkK2E6XutA@mail.gmail.com>
Subject: Re: [PATCH V11 05/15] block/export: track IOThread references
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000db0b7d0659046b98"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000db0b7d0659046b98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026, 3:34=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:

> On Fri, Aug 07, 2026 at 04:25:14AM +0800, Zhang Chen wrote:
> > Track the IOThreads used by a block export and identify the holder
> > with the unique BlockExportOptions id.
> >
> > Acquire holder-aware references during export creation and release
> > them on error or export deletion.  Support both single- and
> > multi-iothread exports.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  block/export/export.c  | 79 +++++++++++++++++++++++++++++++++++++-----
> >  include/block/export.h |  6 ++++
> >  2 files changed, 76 insertions(+), 9 deletions(-)
> >
> > diff --git a/block/export/export.c b/block/export/export.c
> > index b733f269f3..96d719418e 100644
> > --- a/block/export/export.c
> > +++ b/block/export/export.c
> > @@ -15,7 +15,6 @@
> >
> >  #include "block/block.h"
> >  #include "system/block-backend.h"
> > -#include "system/iothread.h"
> >  #include "block/export.h"
> >  #include "block/fuse.h"
> >  #include "block/nbd.h"
> > @@ -85,6 +84,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export,
> Error **errp)
> >      AioContext *ctx;
> >      AioContext **multithread_ctxs =3D NULL;
> >      size_t multithread_count =3D 0;
> > +    g_autofree IOThread **local_iothreads =3D NULL;
> > +    const char *holder_id =3D NULL;
> >      uint64_t perm;
> >      int ret;
> >
> > @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions
> *export, Error **errp)
> >              goto fail;
> >          }
> >
> > -        new_ctx =3D iothread_get_aio_context(iothread);
> > +        holder_id =3D export->id;
> > +        const IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> > +            .u.block_export.export_id =3D (char *)holder_id,
>
> Is this char * cast necessary since the holder variable is declared
> const?
>
>
>
OK=EF=BC=8Cwill fix it in v12.

Thanks
Chen


> > +        };
> > +
> > +        new_ctx =3D iothread_ref_and_get_aio_context(iothread, &holder=
);
> > +        multithread_count =3D 1;
> > +        local_iothreads =3D g_new0(IOThread *, 1);
> > +        local_iothreads[0] =3D iothread;
> >
> >          /* Ignore errors with fixed-iothread=3Dfalse */
> >          set_context_errp =3D fixed_iothread ? errp : NULL;
> > @@ -163,8 +173,15 @@ BlockExport *blk_exp_add(BlockExportOptions
> *export, Error **errp)
> >              return NULL;
> >          }
> >
> > +        local_iothreads =3D g_new0(IOThread *, multithread_count);
> >          multithread_ctxs =3D g_new(AioContext *, multithread_count);
> >          i =3D 0;
> > +        holder_id =3D export->id;
> > +        const IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> > +            .u.block_export.export_id =3D (char *)holder_id,
>
> Same here.
>
> > +        };
> > +
> >          for (strList *e =3D iothread_list; e; e =3D e->next) {
> >              IOThread *iothread =3D iothread_by_id(e->value);
> >
> > @@ -172,7 +189,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export=
,
> Error **errp)
> >                  error_setg(errp, "iothread \"%s\" not found", e->value=
);
> >                  goto fail;
> >              }
> > -            multithread_ctxs[i++] =3D iothread_get_aio_context(iothrea=
d);
> > +            local_iothreads[i] =3D iothread;
> > +            multithread_ctxs[i++] =3D
> iothread_ref_and_get_aio_context(iothread,
> > +
>  &holder);
> >          }
> >          assert(i =3D=3D multithread_count);
> >      }
> > @@ -225,12 +244,15 @@ BlockExport *blk_exp_add(BlockExportOptions
> *export, Error **errp)
> >      assert(drv->instance_size >=3D sizeof(BlockExport));
> >      exp =3D g_malloc0(drv->instance_size);
> >      *exp =3D (BlockExport) {
> > -        .drv        =3D drv,
> > -        .refcount   =3D 1,
> > -        .user_owned =3D true,
> > -        .id         =3D g_strdup(export->id),
> > -        .ctx        =3D ctx,
> > -        .blk        =3D blk,
> > +        .drv                  =3D drv,
> > +        .refcount             =3D 1,
> > +        .user_owned           =3D true,
> > +        .id                   =3D g_strdup(export->id),
> > +        .ctx                  =3D ctx,
> > +        .blk                  =3D blk,
> > +        .iothreads            =3D g_steal_pointer(&local_iothreads),
> > +        .iothread_count       =3D multithread_count,
> > +        .iothread_holder_id   =3D g_strdup(holder_id),
> >      };
> >
> >      ret =3D drv->create(exp, export, multithread_ctxs, multithread_cou=
nt,
> errp);
> > @@ -250,8 +272,32 @@ fail:
> >          blk_unref(blk);
> >      }
> >      if (exp) {
> > +        if (exp->iothreads) {
> > +            const IOThreadHolder holder =3D {
> > +                .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> > +                .u.block_export.export_id =3D exp->iothread_holder_id,
> > +            };
> > +            for (size_t j =3D 0; j < exp->iothread_count; j++) {
> > +                if (exp->iothreads[j]) {
> > +                    iothread_put_aio_context(exp->iothreads[j],
> &holder);
> > +                }
> > +            }
> > +            g_free(exp->iothreads);
> > +        }
> > +        g_free(exp->iothread_holder_id);
> >          g_free(exp->id);
> >          g_free(exp);
> > +    } else if (local_iothreads) {
> > +        const IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> > +            .u.block_export.export_id =3D (char *)holder_id,
>
> Same here.
>
> > +        };
> > +
> > +        for (size_t j =3D 0; j < multithread_count; j++) {
> > +            if (local_iothreads[j]) {
> > +                iothread_put_aio_context(local_iothreads[j], &holder);
> > +            }
> > +        }
> >      }
> >      g_free(multithread_ctxs);
> >      return NULL;
> > @@ -269,10 +315,25 @@ static void blk_exp_delete_bh(void *opaque)
> >      BlockExport *exp =3D opaque;
> >
> >      assert(exp->refcount =3D=3D 0);
> > +
> >      QLIST_REMOVE(exp, next);
> >      exp->drv->delete(exp);
> >      blk_set_dev_ops(exp->blk, NULL, NULL);
> >      blk_unref(exp->blk);
> > +
> > +    if (exp->iothreads) {
> > +        const IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> > +            .u.block_export.export_id =3D exp->iothread_holder_id,
> > +        };
> > +
> > +        for (size_t i =3D 0; i < exp->iothread_count; i++) {
> > +            iothread_put_aio_context(exp->iothreads[i], &holder);
> > +        }
> > +        g_free(exp->iothreads);
> > +    }
> > +
> > +    g_free(exp->iothread_holder_id);
> >      qapi_event_send_block_export_deleted(exp->id);
> >      g_free(exp->id);
> >      g_free(exp);
> > diff --git a/include/block/export.h b/include/block/export.h
> > index ca45da928c..a093dea0b6 100644
> > --- a/include/block/export.h
> > +++ b/include/block/export.h
> > @@ -16,6 +16,7 @@
> >
> >  #include "qapi/qapi-types-block-export.h"
> >  #include "qemu/queue.h"
> > +#include "system/iothread.h"
> >
> >  typedef struct BlockExport BlockExport;
> >
> > @@ -89,6 +90,11 @@ struct BlockExport {
> >
> >      /* List entry for block_exports */
> >      QLIST_ENTRY(BlockExport) next;
> > +
> > +    /* The IOThreads utilized by this specific block export */
> > +    IOThread **iothreads;
> > +    size_t iothread_count;
> > +    char *iothread_holder_id;
> >  };
> >
> >  BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
> > --
> > 2.53.0
> >
>

--000000000000db0b7d0659046b98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 12, 2026, 3:34=E2=80=
=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, =
Aug 07, 2026 at 04:25:14AM +0800, Zhang Chen wrote:<br>
&gt; Track the IOThreads used by a block export and identify the holder<br>
&gt; with the unique BlockExportOptions id.<br>
&gt; <br>
&gt; Acquire holder-aware references during export creation and release<br>
&gt; them on error or export deletion.=C2=A0 Support both single- and<br>
&gt; multi-iothread exports.<br>
&gt; <br>
&gt; Signed-off-by: Zhang Chen &lt;<a href=3D"mailto:zhangckid@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">zhangckid@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/export/export.c=C2=A0 | 79 +++++++++++++++++++++++++++++++=
++++++-----<br>
&gt;=C2=A0 include/block/export.h |=C2=A0 6 ++++<br>
&gt;=C2=A0 2 files changed, 76 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/block/export/export.c b/block/export/export.c<br>
&gt; index b733f269f3..96d719418e 100644<br>
&gt; --- a/block/export/export.c<br>
&gt; +++ b/block/export/export.c<br>
&gt; @@ -15,7 +15,6 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;block/block.h&quot;<br>
&gt;=C2=A0 #include &quot;system/block-backend.h&quot;<br>
&gt; -#include &quot;system/iothread.h&quot;<br>
&gt;=C2=A0 #include &quot;block/export.h&quot;<br>
&gt;=C2=A0 #include &quot;block/fuse.h&quot;<br>
&gt;=C2=A0 #include &quot;block/nbd.h&quot;<br>
&gt; @@ -85,6 +84,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export,=
 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AioContext *ctx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AioContext **multithread_ctxs =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 size_t multithread_count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 g_autofree IOThread **local_iothreads =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *holder_id =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t perm;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;=C2=A0 <br>
&gt; @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *expo=
rt, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_ctx =3D iothread_get_aio_context(ioth=
read);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 holder_id =3D export-&gt;id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder holder =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_THREAD_HOLDER_=
KIND_BLOCK_EXPORT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.block_export.export_id =
=3D (char *)holder_id,<br>
<br>
Is this char * cast necessary since the holder variable is declared<br>
const?<br>
<br><br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">OK=EF=BC=8Cwill fix it in v12.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Thanks</div><div dir=3D"auto">Chen</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_ctx =3D iothread_ref_and_get_aio_cont=
ext(iothread, &amp;holder);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 multithread_count =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_iothreads =3D g_new0(IOThread *, 1)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_iothreads[0] =3D iothread;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ignore errors with fixed-iothread=
=3Dfalse */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_context_errp =3D fixed_iothread =
? errp : NULL;<br>
&gt; @@ -163,8 +173,15 @@ BlockExport *blk_exp_add(BlockExportOptions *expo=
rt, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_iothreads =3D g_new0(IOThread *, mu=
ltithread_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multithread_ctxs =3D g_new(AioContex=
t *, multithread_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 holder_id =3D export-&gt;id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder holder =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_THREAD_HOLDER_=
KIND_BLOCK_EXPORT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.block_export.export_id =
=3D (char *)holder_id,<br>
<br>
Same here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (strList *e =3D iothread_list; e=
; e =3D e-&gt;next) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IOThread *iothread =3D=
 iothread_by_id(e-&gt;value);<br>
&gt;=C2=A0 <br>
&gt; @@ -172,7 +189,9 @@ BlockExport *blk_exp_add(BlockExportOptions *expor=
t, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_se=
tg(errp, &quot;iothread \&quot;%s\&quot; not found&quot;, e-&gt;value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fai=
l;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multithread_ctxs[i++] =3D i=
othread_get_aio_context(iothread);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_iothreads[i] =3D ioth=
read;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multithread_ctxs[i++] =3D i=
othread_ref_and_get_aio_context(iothread,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;holder);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(i =3D=3D multithread_count);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -225,12 +244,15 @@ BlockExport *blk_exp_add(BlockExportOptions *exp=
ort, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(drv-&gt;instance_size &gt;=3D sizeof(BlockE=
xport));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 exp =3D g_malloc0(drv-&gt;instance_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *exp =3D (BlockExport) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .drv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D drv,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .refcount=C2=A0 =C2=A0=3D 1,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .user_owned =3D true,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
g_strdup(export-&gt;id),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ctx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D ctx,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D blk,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .drv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D drv,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .refcount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .user_owned=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(export-&gt;id),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ctx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D ctx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D blk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iothreads=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D g_steal_pointer(&amp;local_iothreads),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iothread_count=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D multithread_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iothread_holder_id=C2=A0 =C2=A0=3D g_str=
dup(holder_id),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D drv-&gt;create(exp, export, multithread_ct=
xs, multithread_count, errp);<br>
&gt; @@ -250,8 +272,32 @@ fail:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_unref(blk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (exp) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (exp-&gt;iothreads) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder holder=
 =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_=
THREAD_HOLDER_KIND_BLOCK_EXPORT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.block_expo=
rt.export_id =3D exp-&gt;iothread_holder_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D 0; j &lt;=
 exp-&gt;iothread_count; j++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (exp-&gt;i=
othreads[j]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 iothread_put_aio_context(exp-&gt;iothreads[j], &amp;holder);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(exp-&gt;iothreads);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(exp-&gt;iothread_holder_id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(exp-&gt;id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(exp);<br>
&gt; +=C2=A0 =C2=A0 } else if (local_iothreads) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder holder =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_THREAD_HOLDER_=
KIND_BLOCK_EXPORT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.block_export.export_id =
=3D (char *)holder_id,<br>
<br>
Same here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D 0; j &lt; multithread_c=
ount; j++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_iothreads[j]) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iothread_put_=
aio_context(local_iothreads[j], &amp;holder);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(multithread_ctxs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; @@ -269,10 +315,25 @@ static void blk_exp_delete_bh(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BlockExport *exp =3D opaque;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(exp-&gt;refcount =3D=3D 0);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QLIST_REMOVE(exp, next);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 exp-&gt;drv-&gt;delete(exp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 blk_set_dev_ops(exp-&gt;blk, NULL, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 blk_unref(exp-&gt;blk);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (exp-&gt;iothreads) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder holder =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_THREAD_HOLDER_=
KIND_BLOCK_EXPORT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.block_export.export_id =
=3D exp-&gt;iothread_holder_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; exp-&gt;iothr=
ead_count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iothread_put_aio_context(ex=
p-&gt;iothreads[i], &amp;holder);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(exp-&gt;iothreads);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(exp-&gt;iothread_holder_id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qapi_event_send_block_export_deleted(exp-&gt;id);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(exp-&gt;id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(exp);<br>
&gt; diff --git a/include/block/export.h b/include/block/export.h<br>
&gt; index ca45da928c..a093dea0b6 100644<br>
&gt; --- a/include/block/export.h<br>
&gt; +++ b/include/block/export.h<br>
&gt; @@ -16,6 +16,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qapi/qapi-types-block-export.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/queue.h&quot;<br>
&gt; +#include &quot;system/iothread.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct BlockExport BlockExport;<br>
&gt;=C2=A0 <br>
&gt; @@ -89,6 +90,11 @@ struct BlockExport {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* List entry for block_exports */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QLIST_ENTRY(BlockExport) next;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* The IOThreads utilized by this specific block export=
 */<br>
&gt; +=C2=A0 =C2=A0 IOThread **iothreads;<br>
&gt; +=C2=A0 =C2=A0 size_t iothread_count;<br>
&gt; +=C2=A0 =C2=A0 char *iothread_holder_id;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 BlockExport *blk_exp_add(BlockExportOptions *export, Error **err=
p);<br>
&gt; -- <br>
&gt; 2.53.0<br>
&gt; <br>
</blockquote></div></div></div>

--000000000000db0b7d0659046b98--

