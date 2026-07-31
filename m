Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C65C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprGF-0004l3-BS; Fri, 31 Jul 2026 13:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wprFP-0004ao-Bm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:42:18 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wprFM-0007EU-J1
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:42:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso2076080a12.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785519730; cv=none;
 d=google.com; s=arc-20260327;
 b=cqUVbbQq9UUuQTj+mTrnYbZfsbGmRqpoZpMrU/68yVL0iMgx+Wbl34zRg2ZgLW6hSc
 lZ9AI+u2bv2VAH99gY0l2ZH15zxc94O4VnAakxSpyMvMm2W38jikQFgk7yR4LqpAxtp9
 7c1MdN9XdDOjgGfzCti1sQjfRJy07uSObs0G3a9JHlGQgPW7X5AG0czvwpeuSMf8UTXW
 lPuGyK86hiN+JRttK5oKF55xeahGDHGRtOvmoA/5IvFLmUvFJD7Qy2F4E+YVsIaWwsG1
 Lel50VmxJbOS0k7VNJvjuAs/W9SVU3+hZ3mDgzEp6MrFEENtYJhBXn0Q/F8j4nulWEQc
 QChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xndhoQp2S/BmGEiu7fSyCjfVpYu3y1Q7sQ893jc9ksU=;
 fh=UaA1yCOjKZbN2T3Nzlq9jhGnddnHE8rnoiFOPAMopGg=;
 b=AlqiYAZZdBM0FT77MvAg57QdQ3/U5LeSr20KF/Py3e416Pe9vinnUMgQWqpyYG8lhI
 xxfNaF9f/p4PaW1PTZQIspcyUcuIbnYofVRIii8Ps9SAmsk/6JJiEmrvAN5/CqaZw6Wn
 X9OAd4O4mt3tHAafSb6gxdpawj6cgYegKjbzZQu94A+qBEtuPbYqoAzZsiiQCXeMS0Kv
 3pGcbqas6H7oeElvA7UIR7MVlrAchHp1U5Xou4EEmJsZnelD0U3layVHrZGjGgo4220U
 4gBWoI/eaUR1aElunkeoLBFzulxmu3/E8h+NDLUrOFkWHyZhNg+dOMnxsIXO2XIP0zJ3
 gFog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785519730; x=1786124530; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xndhoQp2S/BmGEiu7fSyCjfVpYu3y1Q7sQ893jc9ksU=;
 b=laoS15VdK53XHLS0H3kE+8Z+ZJXySuGIkiUKoUll66i1Q7YSDHc9moUE3v4OIzMvdN
 lQ+IkLgO/F2WImVs7p9YSBEjZKAJy6xD994hN9cItlYrXyZz9ZqSjhN8d50lMjWN44N5
 8vj28y9LuZ+Q25ovMSDs3xPrYv8A+JHBM8aCnSzMX8RMYBXy/hv5cNZA8Wj8f412EKJm
 61XhCoR15jzcalezYl4nqqD5SUAOeCuNyuuSDcGPxluR+vM8G9nIpVUq4bMQc6UzZzGj
 Vz1xk7bYacBuUkdjYF5wSD+4dZpcQbSj+LqpMM+hRPa5XNZdW1IQoAd++/a6f3PolJMD
 8Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519730; x=1786124530;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xndhoQp2S/BmGEiu7fSyCjfVpYu3y1Q7sQ893jc9ksU=;
 b=n4kf3z8Pu68qkLLo4nFmNdvLuOvRmlQeBgblx5M5Sq1KBXqAa1ZGXAKt9EQCUTNnZ9
 FH1p4oZFAcbaYQQ0/o/9kF9VCHGV27XNDmN9i0x2RdqxnWDM3otCw0PzfIE0mB1gEJuc
 Ukaw2XJjJSnLRNtzmDjLWxDTyktMtUg+fO8poGmDNByEwrZSzveJwxZVYFlt+b1BnHPE
 6BtSDXYEFShqBtToSSwfOtaMAnPPmOdFh1aCatk5ZUUVu5ZuGKU5QKN9OnRFf4MMpelP
 f7dXGZzV2WMVjk5rW2djJyfG/yZa+zc6j9WhRY45u1MX0PhcVNWxYQsBEBqaMwhZe/gY
 SIUA==
X-Gm-Message-State: AOJu0YxJn3VNmxb2CW2/f/T/So+iA8YJSYS6hUZQ5t+9SokuWsD1y7/m
 xG4EOGti+C80kr3iev/WClEBjVUeXIVg1H7lRQfVxiaZhdqCVbdTDo8EjNtSVPRL6qIh+HxPCfc
 +4tkFJ8clbgQvhfShffEnp9gfRBQrllY=
X-Gm-Gg: AR+sD13YoypD19r1f6Y9OcRYFxiyhxqrQ6ChCEExGYUBO71aEiTySgU3N/TwBBptVpc
 46giEYDC8zCynCq19h1oJBMC1bAHn8l+PSQN8J6rOSPgDgUBP8jYbAf+brA4oRhZIm70xJyNhaB
 V0a6zM1iVh44NVlIAOa1jJ4cSnS25b1RBoBV7Rc6vKdo6ANK8MEUKF5Sp+LFc1m5XfUuxydv9HU
 JuLEL+mG4FWGaEdP14fRiTWVZMZZ8KrzRz27/AYuYOlu23+Gdn1ZF3lGLpp5FlJYzOFrCky1mTR
 rivgZuWVlhAx23Yaiaem3lJ8XYjyfuJ0E8rOa0EK8qHB
X-Received: by 2002:a05:6402:5187:b0:698:5f47:1d4b with SMTP id
 4fb4d7f45d1cf-6a0a7cee213mr352097a12.22.1785519729711; Fri, 31 Jul 2026
 10:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-15-zhangckid@gmail.com>
 <877bmba9k7.fsf@pond.sub.org>
In-Reply-To: <877bmba9k7.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 1 Aug 2026 01:41:56 +0800
X-Gm-Features: AUfX_mxwm7neH4-rEK-GjttqbgymnYrYXXegxbSMPGD6Jb-3pofmwue7KCprDbo
Message-ID: <CAK3tnvLMDvaF4rPuypVSPd9rJFKTfhhugFwbWME5OW-dPfpxLA@mail.gmail.com>
Subject: Re: [RESEND PATCH V10 14/15] iothread: simplify API by merging
 iothread_get_aio_context variants
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003a9e9f0657ebb50a"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52a.google.com
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

--0000000000003a9e9f0657ebb50a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026, 3:43=E2=80=AFPM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Simplify the interface by merging iothread_ref_and_get_aio_context()
> > into iothread_get_aio_context(). The updated function now requires a
> > 'holder' parameter, ensuring that every retrieval of an AioContext for
> > long-term use is automatically registered in the IOThread's holder list=
.
> >
> > Update all callers across block, virtio, scsi, net, and monitor
> > subsystems to match the new signature. This cleanup reduces code
> > redundancy and improves the reliability of IOThread introspection.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> [...]
>
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index 3cce5eeb09..3a6010b9f0 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -73,22 +73,22 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> > -/*
> > - * The iothread_get_aio_context() and iothread_put_aio_context() are n=
ot
> > - * thread-safe and must be called under the Big QEMU Lock (BQL).
> > - */
> > -AioContext *iothread_get_aio_context(IOThread *iothread);
> > +
> >  /*
> >   * Normally the IOThread's AioContext is fetched using
> > - * iothread_ref_and_get_aio_context(), but there are legacy callers
> > + * iothread_get_aio_context(), but there are legacy callers
> >   * without a clear ref/unref lifecycle. They cannot unref (e.g. becaus=
e
> >   * they do not have an IOThread pointer), so provide an unsafe way to
> >   * fetch the AioContext without holding a reference count. This unsafe
> >   * API serves legacy callers - do not use it in new code.
> >   */
> >  AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
> > -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > -                                             const IOThreadHolder
> *holder);
> > +/*
> > + * The iothread_get_aio_context() and iothread_put_aio_context() are n=
ot
> > + * thread-safe and must be called under the Big QEMU Lock (BQL).
> > + */
> > +AioContext *iothread_get_aio_context(IOThread *iothread,
> > +                                     const IOThreadHolder *holder);
> >  void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder
> *holder);
> >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >
> > diff --git a/iothread.c b/iothread.c
> > index 157bb4d302..9d278efc45 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -429,13 +429,8 @@ char *iothread_get_id(IOThread *iothread)
> >      return
> g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
> >  }
> >
> > -AioContext *iothread_get_aio_context(IOThread *iothread)
> > -{
> > -    return iothread->ctx;
> > -}
> > -
> > -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > -                                             const IOThreadHolder
> *holder)
> > +AioContext *iothread_get_aio_context(IOThread *iothread,
> > +                                     const IOThreadHolder *holder)
> >  {
> >      /* Add IOThreadHolder to the list */
> >      iothread_ref(iothread, holder);
>
> Together with PATCH 04, this renames iothread_get_aio_context() to
> iothread_unsafe_get_aio_context(), and
> iothread_ref_and_get_aio_context() to iothread_get_aio_context().
>
> iothread_get_aio_context() takes a reference now.  That's a very
> significant change.
>
> In my opinion, every function that takes or releases a reference needs a
> function comment unless the function name makes it completely obvious.
> I know we have plenty of functions lacking such comments, but that
> doesn't make me wrong :)
>
> There are similarly named functions that, as far as I can tell, return a
> thing's AioContext without taking a reference:
>
>     bdrv_get_aio_context()
>     blk_get_aio_context()
>     block_job_get_aio_context()
>     iohandler_get_aio_context()
>     qemu_coroutine_get_aio_context()
>     qemu_get_aio_context()
>
> I fear this is going to be confusing.
>
> But I'm not the maintainer.  Who is the maintainer?  MAINTAINERS doesn't
> cover iothread.c, even though it is a core piece of infrastructure.
>
>
Thanks for the detailed review!

1. Documentation:
   I completely agree that functions modifying
 reference counts must be explicitly documented.
I will add comprehensive function comments in
include/sysemu/iothread.h in the next version
to clearly state that iothread_get_aio_context()
takes a reference and requires a matching
iothread_put_aio_context().

2. API naming & consistency:
   The main motivation for merging iothread_ref_and_get_aio_context()
into iothread_get_aio_context(..., holder) was
to enforce holder registration and avoid untracked
AioContext retrievals across subsystems.
The mandatory 'holder' parameter serves as
a explicit hint that this is an acquiring operation.

This series based on Stefan's suggestions, and
he also contributed some of the IOThread relevant work. I'll wait for
feedback from Stefan/Paolo/Markus or others regarding the naming
convention. If they prefer keeping a distinct name (e.g.
iothread_ref_get_aio_context), I am open to adjusting it.

I think Stefan is the missed IOThread maintainer role? (By the way, if he
or anyone else has no objections, I can add it at the end.).

Thanks
Chen



> [...]
>
>

--0000000000003a9e9f0657ebb50a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jul 31, 2026, 3:43=E2=80=AFPM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Zhang Chen &lt;<a href=3D"mailto:zhangckid@gmail.com" rel=3D"noreferrer =
noreferrer" target=3D"_blank">zhangckid@gmail.com</a>&gt; writes:<br>
<br>
&gt; Simplify the interface by merging iothread_ref_and_get_aio_context()<b=
r>
&gt; into iothread_get_aio_context(). The updated function now requires a<b=
r>
&gt; &#39;holder&#39; parameter, ensuring that every retrieval of an AioCon=
text for<br>
&gt; long-term use is automatically registered in the IOThread&#39;s holder=
 list.<br>
&gt;<br>
&gt; Update all callers across block, virtio, scsi, net, and monitor<br>
&gt; subsystems to match the new signature. This cleanup reduces code<br>
&gt; redundancy and improves the reliability of IOThread introspection.<br>
&gt;<br>
&gt; Signed-off-by: Zhang Chen &lt;<a href=3D"mailto:zhangckid@gmail.com" r=
el=3D"noreferrer noreferrer" target=3D"_blank">zhangckid@gmail.com</a>&gt;<=
br>
<br>
[...]<br>
<br>
&gt; diff --git a/include/system/iothread.h b/include/system/iothread.h<br>
&gt; index 3cce5eeb09..3a6010b9f0 100644<br>
&gt; --- a/include/system/iothread.h<br>
&gt; +++ b/include/system/iothread.h<br>
&gt; @@ -73,22 +73,22 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 char *iothread_get_id(IOThread *iothread);<br>
&gt;=C2=A0 IOThread *iothread_by_id(const char *id);<br>
&gt; -/*<br>
&gt; - * The iothread_get_aio_context() and iothread_put_aio_context() are =
not<br>
&gt; - * thread-safe and must be called under the Big QEMU Lock (BQL).<br>
&gt; - */<br>
&gt; -AioContext *iothread_get_aio_context(IOThread *iothread);<br>
&gt; +<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Normally the IOThread&#39;s AioContext is fetched using<=
br>
&gt; - * iothread_ref_and_get_aio_context(), but there are legacy callers<b=
r>
&gt; + * iothread_get_aio_context(), but there are legacy callers<br>
&gt;=C2=A0 =C2=A0* without a clear ref/unref lifecycle. They cannot unref (=
e.g. because<br>
&gt;=C2=A0 =C2=A0* they do not have an IOThread pointer), so provide an uns=
afe way to<br>
&gt;=C2=A0 =C2=A0* fetch the AioContext without holding a reference count. =
This unsafe<br>
&gt;=C2=A0 =C2=A0* API serves legacy callers - do not use it in new code.<b=
r>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);=
<br>
&gt; -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const IOThreadHolder *holder);<br>
&gt; +/*<br>
&gt; + * The iothread_get_aio_context() and iothread_put_aio_context() are =
not<br>
&gt; + * thread-safe and must be called under the Big QEMU Lock (BQL).<br>
&gt; + */<br>
&gt; +AioContext *iothread_get_aio_context(IOThread *iothread,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const IOThre=
adHolder *holder);<br>
&gt;=C2=A0 void iothread_put_aio_context(IOThread *iothread, const IOThread=
Holder *holder);<br>
&gt;=C2=A0 GMainContext *iothread_get_g_main_context(IOThread *iothread);<b=
r>
&gt;=C2=A0 <br>
&gt; diff --git a/iothread.c b/iothread.c<br>
&gt; index 157bb4d302..9d278efc45 100644<br>
&gt; --- a/iothread.c<br>
&gt; +++ b/iothread.c<br>
&gt; @@ -429,13 +429,8 @@ char *iothread_get_id(IOThread *iothread)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return g_strdup(object_get_canonical_path_componen=
t(OBJECT(iothread)));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -AioContext *iothread_get_aio_context(IOThread *iothread)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 return iothread-&gt;ctx;<br>
&gt; -}<br>
&gt; -<br>
&gt; -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const IOThreadHolder *holder)<br>
&gt; +AioContext *iothread_get_aio_context(IOThread *iothread,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const IOThre=
adHolder *holder)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Add IOThreadHolder to the list */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 iothread_ref(iothread, holder);<br>
<br>
Together with PATCH 04, this renames iothread_get_aio_context() to<br>
iothread_unsafe_get_aio_context(), and<br>
iothread_ref_and_get_aio_context() to iothread_get_aio_context().<br>
<br>
iothread_get_aio_context() takes a reference now.=C2=A0 That&#39;s a very<b=
r>
significant change.<br>
<br>
In my opinion, every function that takes or releases a reference needs a<br=
>
function comment unless the function name makes it completely obvious.<br>
I know we have plenty of functions lacking such comments, but that<br>
doesn&#39;t make me wrong :)<br>
<br>
There are similarly named functions that, as far as I can tell, return a<br=
>
thing&#39;s AioContext without taking a reference:<br>
<br>
=C2=A0 =C2=A0 bdrv_get_aio_context()<br>
=C2=A0 =C2=A0 blk_get_aio_context()<br>
=C2=A0 =C2=A0 block_job_get_aio_context()<br>
=C2=A0 =C2=A0 iohandler_get_aio_context()<br>
=C2=A0 =C2=A0 qemu_coroutine_get_aio_context()<br>
=C2=A0 =C2=A0 qemu_get_aio_context()<br>
<br>
I fear this is going to be confusing.<br>
<br>
But I&#39;m not the maintainer.=C2=A0 Who is the maintainer?=C2=A0 MAINTAIN=
ERS doesn&#39;t<br>
cover iothread.c, even though it is a core piece of infrastructure.<br><br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Than=
ks for the detailed review!</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">1. Documentation:</div><div dir=3D"auto">=C2=A0 =C2=A0I completely agre=
e that functions modifying</div><div dir=3D"auto">=C2=A0reference counts mu=
st be explicitly documented.</div><div dir=3D"auto">I will add comprehensiv=
e function comments in</div><div dir=3D"auto">include/sysemu/iothread.h in =
the next version</div><div dir=3D"auto">to clearly state that iothread_get_=
aio_context()</div><div dir=3D"auto">takes a reference and requires a match=
ing</div><div dir=3D"auto">iothread_put_aio_context().</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">2. API naming &amp; consistency:</div><div d=
ir=3D"auto">=C2=A0 =C2=A0The main motivation for merging iothread_ref_and_g=
et_aio_context()</div><div dir=3D"auto">into iothread_get_aio_context(..., =
holder) was</div><div dir=3D"auto">to enforce holder registration and avoid=
 untracked</div><div dir=3D"auto">AioContext retrievals across subsystems.<=
/div><div dir=3D"auto">The mandatory &#39;holder&#39; parameter serves as</=
div><div dir=3D"auto">a explicit hint that this is an acquiring operation.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">This series based on Ste=
fan&#39;s suggestions, and</div><div dir=3D"auto">he also contributed some =
of the IOThread relevant work. I&#39;ll wait for feedback from Stefan/Paolo=
/Markus or others regarding the naming convention. If they prefer keeping a=
 distinct name (e.g. iothread_ref_get_aio_context), I am open to adjusting =
it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I think Stefan is th=
e missed IOThread maintainer role? (By the way, if he or anyone else has no=
 objections, I can add it at the end.).</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Thanks</div><div dir=3D"auto">Chen</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000003a9e9f0657ebb50a--

