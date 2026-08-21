Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C93C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPyh-0004ip-4D; Fri, 21 Aug 2026 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxPyf-0004ie-OW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:12:13 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxPyd-00018s-DD
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:12:13 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso208544766b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787321530; cv=none;
 d=google.com; s=arc-20260327;
 b=CAFH36ZFQN/bBKJgdrK/2S9osqQuiXMDJb4tIlbGzkjmHDkwkmLm70jkU28Jr7pZ+Y
 qkBhiUEPONYkg4UCUTmmHGZK46OA0rITxCV5BAtxONKboy/4mDn7j95cDUyy3fb+tn3w
 gfvov1olsdb5CHeQcw2M0SsRGOOAR4Swc6eJ9eTSGo09N5h0jTZIjxv3ZhmzOkuRR37q
 +9xrQzR4ZT0y2F4pK1w5CdlFzQ9+oA8rBWf4PnQ6eylBpoayBFkMlx+iwO2Ab+Bm8TRK
 oSMMF+0yFmiT7FTSj+pEPaadFk8FKAZ4v7WY0HKi+vMJOIl9rYTN5ziMJM55sY9WO5Ir
 cKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IM0CRC39+qXDsl45pVlgW6WGy4lqeisf7dHsSF6IXII=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=J532RX/wAAsobiWYIvoySyxOyFEDLQPwAXQa6kj/aJ/D65diW4qxlnL0HZZ+e+QA7J
 zakIVSoZmhooaoFMrWVd43WPF7KazFCSF9Ly3fjqQZOh5ZE0FVbHpg+pGd1+8NUxKfL7
 IPtlKPg/iQ58+2ZrUvjGnXv3hhVG6WpO7GENIJs/guFbXm7upv+h5fuYuhgLqUvi2uAZ
 PyX+Dju/4EULr9e40r0lLkPd86HlTlgXwO62lMlYt98N3aG1fB9Dt62V2mnkcV3EKP89
 2XeqxRnSfC50S9nv6YXgv/i/labR0+iCjAWAhIIZ492zdWpNKziz3nvU3PQGqR4DbiUk
 AJiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787321530; x=1787926330; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IM0CRC39+qXDsl45pVlgW6WGy4lqeisf7dHsSF6IXII=;
 b=Lig5Oab46SPe4guAzjpXs4PGTCedydqwqc2QD4SsA81ORE7jBAaNuqcRnONhHbynvj
 7dBN5En5fSBxaM2meCNB2OKpLl8cbqVVdyANmRA1+3pzXDAeh6cQdFbKN1jDtROjaOlI
 27AQjIzYpFDm4rdidbWghICdSVTqeEtV1QYgquDViGoGK0AGOvfCbeawbVlXgZkAAHh+
 I+/z8bl/xxXGv3ZcgVg9CH6vsqqGCL28qO2QrTbKRXWD7mvVHMVD2a4Jn4shfAHV/Mi5
 YXE2GJTnTsXWTD5bZynSzxfN/0mwFTsCv//toCa+RD0BdXAWPb0R4KQiFL3dizgqGrlb
 PzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787321530; x=1787926330;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IM0CRC39+qXDsl45pVlgW6WGy4lqeisf7dHsSF6IXII=;
 b=ShTmGwAlOc7Rm2KNNLY3HfivRhaLQ7xA2DpFQPU/X/1wXQkaT5MJLy7HfFxkS700p9
 JzcFyxXOJlEff5bzmzQEr2IXhLKMsqfOLBSvOeVGdisOsIV9smeXWock/HGgmNeF8qNx
 rfXRIbbhxQ652QrthuBDuG0KsrsJItMFSxZDMd2I9wTYIwoe0hpGJraMJkgFklvCM+cC
 L0xcs7S+6J5ggww2auqaT3R93bbLfUMBjf4cXz1kfw50W1ml6apVwuFcvOgTKd1+0SYK
 7eqJr/YO3LZpf05yrzd0ZVHFUrFh9WRp8wYpRKiOhbI8Igy4K8l3VCTr5bdiJOJXrJ8w
 qgVg==
X-Gm-Message-State: AFuF++kNbu8dAxnOtoNgyHdBgkbO278pekzVzZPCEruMSfMhkVgfmNwj
 wHRBx3i3Pqg/Byod3AabAnmVN4P7eqLK+W/mqmaPHoRy1op+EEgCctAPhkORSk5TR/h5uiB3wi0
 ZtYeVuc2DU5vO7qAhMbuoFi/vrXorDA4=
X-Gm-Gg: AR+sD11Zd8Dr23vJ2sUd/kM79I1zHCMXAQLD6+dw6TKJqDgDWXSDNCQ+3Nw2oLa5jNS
 kWh6tPQlfFhQfJZ37jqYXESvdj7pV693a2Y8af0EnhmQVa2MeBL3wW8T1fUQSOAXRB2xibnLVxP
 pEUReNEEh4O04CRnzRQAIoIFr0vJ6vzZTMR7CkQAl8WLrqrNXbikbSksVjo7+T9f2/JQBX/cQyJ
 A7rK4Az3h2zuEi75tias7ZP1P94/k3gc+1OOCGkseADYJ1D461PAMJ+yJHUJa/H/IAZGjOnPBT8
 439t8v9WsD5coADsOVTMglJwGM1Ghx0oGwOf8i0dBkd8nMVtM/gTRJop
X-Received: by 2002:a17:906:6205:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c246a39ef9emr746178966b.1.1787321529596; Fri, 21 Aug 2026
 07:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-8-zhangckid@gmail.com>
 <20260819191657.GF222512@fedora>
In-Reply-To: <20260819191657.GF222512@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 21 Aug 2026 22:11:55 +0800
X-Gm-Features: AcwNN1VlwFjA0VCLfWKhHhb4edTgTwiQ_pjr0KiTb8c6xdPzFVaKLjJ1tdbm0Ts
Message-ID: <CAK3tnvKrdopoHQByWbyyVRJoN15ASTk6hH-mPR4v2b9Q6VQ4_g@mail.gmail.com>
Subject: Re: [PATCH V12 07/15] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000df055406598f3875"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62d.google.com
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

--000000000000df055406598f3875
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026, 3:17=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:

> On Sat, Aug 15, 2026 at 01:48:21AM +0800, Zhang Chen wrote:
> > diff --git a/hw/virtio/iothread-vq-mapping.c
> b/hw/virtio/iothread-vq-mapping.c
> > index 55ce62986c..1859d39630 100644
> > --- a/hw/virtio/iothread-vq-mapping.c
> > +++ b/hw/virtio/iothread-vq-mapping.c
> > @@ -77,6 +77,7 @@ bool iothread_vq_mapping_apply(
> >          IOThreadVirtQueueMappingList *list,
> >          AioContext **vq_aio_context,
> >          uint16_t num_queues,
> > +        char *holder,
>
> const char * is clearer. It indicates that this function doesn't modify
> or free its argument (making ownership clear).
>


OK =EF=BC=8C will fix in next version.

Thanks
Chen



>
> >          Error **errp)
> >  {
> >      IOThreadVirtQueueMappingList *node;
> > @@ -93,10 +94,13 @@ bool iothread_vq_mapping_apply(
> >
> >      for (node =3D list; node; node =3D node->next) {
> >          IOThread *iothread =3D iothread_by_id(node->value->iothread);
> > -        AioContext *ctx =3D iothread_get_aio_context(iothread);
> > +        const IOThreadHolder io_holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +            .u.qom_object.qom_path =3D holder,
> > +        };
> >
> > -        /* Released in virtio_blk_vq_aio_context_cleanup() */
> > -        object_ref(OBJECT(iothread));
> > +        AioContext *ctx =3D iothread_ref_and_get_aio_context(iothread,
> > +                                                           &io_holder)=
;
> >
> >          if (node->value->vqs) {
> >              uint16List *vq;
> > @@ -120,13 +124,19 @@ bool iothread_vq_mapping_apply(
> >      return true;
> >  }
> >
> > -void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
> > +void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
> > +                                 char *holder)
>
> const char *
>

--000000000000df055406598f3875
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 20, 2026, 3:17=E2=80=
=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sat, =
Aug 15, 2026 at 01:48:21AM +0800, Zhang Chen wrote:<br>
&gt; diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-m=
apping.c<br>
&gt; index 55ce62986c..1859d39630 100644<br>
&gt; --- a/hw/virtio/iothread-vq-mapping.c<br>
&gt; +++ b/hw/virtio/iothread-vq-mapping.c<br>
&gt; @@ -77,6 +77,7 @@ bool iothread_vq_mapping_apply(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IOThreadVirtQueueMappingList *list,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AioContext **vq_aio_context,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t num_queues,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *holder,<br>
<br>
const char * is clearer. It indicates that this function doesn&#39;t modify=
<br>
or free its argument (making ownership clear).<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">O=
K =EF=BC=8C will fix in next version.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Thanks</div><div dir=3D"auto">Chen</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 IOThreadVirtQueueMappingList *node;<br>
&gt; @@ -93,10 +94,13 @@ bool iothread_vq_mapping_apply(<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (node =3D list; node; node =3D node-&gt;next) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IOThread *iothread =3D iothread_by_i=
d(node-&gt;value-&gt;iothread);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 AioContext *ctx =3D iothread_get_aio_cont=
ext(iothread);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder io_holder =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_THREAD_HOLDER_=
KIND_QOM_OBJECT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.qom_object.qom_path =3D =
holder,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Released in virtio_blk_vq_aio_context_=
cleanup() */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_ref(OBJECT(iothread));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AioContext *ctx =3D iothread_ref_and_get_=
aio_context(iothread,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;io_h=
older);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (node-&gt;value-&gt;vqs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16List *vq;<br>
&gt; @@ -120,13 +124,19 @@ bool iothread_vq_mapping_apply(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)<=
br>
&gt; +void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *holder)<br>
<br>
const char *<br>
</blockquote></div></div></div>

--000000000000df055406598f3875--

