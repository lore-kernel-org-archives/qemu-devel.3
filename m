Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781BCC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 22:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tksm0-0000us-Lo; Wed, 19 Feb 2025 17:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkslz-0000uB-56
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 17:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkslv-0002oR-NX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 17:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740004946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=19G/Il9pb8b0RlkKaV7QMkYbnoQT5/a/ExXZ0AlzHj8=;
 b=eaw+ovFoxD9vH7GviwKDJE5CFB2yk5F9u2zMbBQV8EpsetTu/BEQz5LaHqlWIqR0fvxk75
 ZDOh3i6xak1mH6DTsYP5p7gx+CJKTM41vPgYuPpHTWcQabAHBehi1OB7f7WliVpHW/rU1h
 6j+iUgIXQsy48IrDFMAsa51jDvCsNEk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-sQ6nvtYUP0K7kfFlwKIifA-1; Wed, 19 Feb 2025 17:42:24 -0500
X-MC-Unique: sQ6nvtYUP0K7kfFlwKIifA-1
X-Mimecast-MFC-AGG-ID: sQ6nvtYUP0K7kfFlwKIifA_1740004943
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so6322625e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 14:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740004943; x=1740609743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19G/Il9pb8b0RlkKaV7QMkYbnoQT5/a/ExXZ0AlzHj8=;
 b=ng65PvDXKE/U70JDYqEJcKkky4RsU0r0LuXaP+Kw9f4sRne56i+Bmk/Gt1JFP+Tbf7
 7xharWXc6+VnOv7fo49o6GL+4+g6xS4ypfXFlJ49W7SZsgJDofTS8F0gX9kMqUn3vjdk
 VetVRK+v3eUVkhc33tCAU8eovDU31zu+LtvMVMMfj8EiZQAGqm/yn0X7FQ4U9gjsUw7G
 TQxe5XB+x+yRZGd3IRzIgl77KMF7kT4RqWdCPl2Qrw7wnt/g/emZNFkP1xSd+8NnWcZs
 0oPIxvDjqrY4gmZRQAKbJjZG9YGPcFem4pILeQNUnxSxYqs5+MvUoMm23j5jpzuAbmWs
 XXvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5TrTQfAc7m7SE82t0sfF9cWCbGzCymJXUFnJJArX9xBFFUcRXrGHwroYLqulgC+kJnCD9cQGl7pYc@nongnu.org
X-Gm-Message-State: AOJu0Yz2W9hN8w7IwTAKASNpMZIt00aTTixAnTpeoJPmWhRQ/WdIA8tM
 HAqBxk1XIrYszbKu+59C6G5AHcravv4gOTGynVvrNHj/XK1qsQJcRUO6cviIp2iOXhyQyWSMQjI
 M4UWKzoFbxQunp670g1sBuk+0ul+SAq+zKR7PWCd/UCTQdGZnw3OYTnk6FIFrMeim4udUT6KbRX
 K0tju0U0zgQ5mujtH8xZSQo4IIVIA=
X-Gm-Gg: ASbGncvcuSMF/UGrU5xqmwifSeXHfxLiVwzRCrAdSv3eSK9k0V2/1HXe3ERHCSd2rW1
 9mM7TN4FSTFA1xFKFIGzFSQwxTACzV9laWfvgz7EVN/NuMaq0igifyZT1pX8tmLc/
X-Received: by 2002:a5d:6e91:0:b0:38f:2c10:da1e with SMTP id
 ffacd0b85a97d-38f61609eb8mr749496f8f.27.1740004942757; 
 Wed, 19 Feb 2025 14:42:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpWdYUVEoUWQp0BMzUo/XYJNYFyVFXZ+03ya3txgrPfcc7MT1Ci+JpxnH4HbNCPoH9Bji5nmPh/m1ZWuBsPYg=
X-Received: by 2002:a5d:6e91:0:b0:38f:2c10:da1e with SMTP id
 ffacd0b85a97d-38f61609eb8mr749489f8f.27.1740004942418; Wed, 19 Feb 2025
 14:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-10-kwolf@redhat.com>
 <0ee134e7-02bf-4b9b-9c9a-83c88386cd57@redhat.com>
 <Z7XWdLOe7dK1eh29@redhat.com>
In-Reply-To: <Z7XWdLOe7dK1eh29@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Feb 2025 23:42:10 +0100
X-Gm-Features: AWEUYZkM2NHokcbau8sNgrBP6Mr4lhF_KhShs1ZXW2KJyX00YjJ6w-yrAA-QHXY
Message-ID: <CABgObfb9w1+5pTFXZy4L-2OGSdR6bPKayfbqccFpZ4ya3d+Gvw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] rust/block: Add read support for block drivers
To: Kevin Wolf <kwolf@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 Hanna Czenczek <hreitz@redhat.com>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000802e48062e867836"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000802e48062e867836
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 19 feb 2025, 14:02 Kevin Wolf <kwolf@redhat.com> ha scritto:

> > Likewise, even BochsImage should not need a standard Rust Arc<BdrvChild=
>.
> > However you need to add your own block::Arc<BdrvChild> and map
> Clone/Drop to
> > bdrv_ref/bdrv_unref.  Then BochsImage can use block::Arc<BdrvChild>; th=
is
> > makes it even clearer that Mapping should not use the Arc<> wrapper,
> because
> > bdrv_ref is GLOBAL_STATE_CODE() and would abort if run from a non-main
> > thread.
>
> It's not BdrvChild that is refcounted on the C side, but
> BlockDriverState. We definitely don't bdrv_ref()/unref() for each
> request on the C side and we shouldn't on the Rust side either. The
> refcount only changes when you modify the graph.
>

I keep confusing BdrvChild and BlockDriverState, sorry.

Talking in general about Rust and not QEMU, if you wanted to be able to
optionally store the mapping, and not always modify the refcount, you'd
probably want an &Arc<T>. Then you only clone it if needed for the cache
(for example if you cached the *content* rather than the mapping, you
wouldn't need to clone).

However, Arc doesn't work here. In order to globally invalidate all cached
mappings, you would need the cache to store something similar to a Weak<T>.
But even that doesn't quite work, because if you passed an &Arc the caller
could clone it as it wished. So using weak clones to do cache invalidation
shows as the hack that it is.

Going back to QEMU, the Mapping needs some smart pointer (something that
implements Deref<Target =3D bindings;:BdrvChild>), which does implement som=
e
reference counting unlike the C version but, unlike &Arc<BdrvChild>, cannot
be cloned willy nilly. Instead it can be 1) weakly-cloned under the graph
rdlock 2) used from a weak reference but only for the duration of an rdlock
critical section (no way to make it strong for an arbitrary lifetime!) 3)
invalidated under the graph wrlock.

The nice thing here is that, even if you have a good way to invalidate the
cache, that's orthogonal to how you make the Rust API memory safe. Cache
invalidation becomes just a way to quickly free the BdrvChild=E2=80=94the i=
nvalid
entry would be detected anyway later when trying to use the weak reference.

More practical/immediate suggestion below...

I'm not entirely sure how your block::Arc<T> is supposed to work. It
> would be tied to one specific type (BlockDriverState), not generic.
> Which probably means that it can't be a separate pointer type, but
> BlockDriverState itself should just implement Clone with bdrv_ref().
>

You're right, I always forget the new BdrvChild world.

> That said, I'm not sure how to include "block graph lock must be taken"
> into
> > the types, yet.  That has to be taken into account too, sooner or later=
.
> > You probably have a lot of items like this one so it'd be nice to have
> TODO
> > comments as much as you can.
>
> Actually, I'm not aware of that many items.

But yes, there is a TODO
> item for the graph lock.
>
> I think I'll have something like:
>
>     pub struct BdrvChild {
>         child: GraphLock<*mut bindings::BdrvChild>,
>     }
>

Arc<BdrvChild> poses another problem then, in that graph changes would
invalidate the raw pointer even if the Arc is still alive. Something like
the aforementioned smart pointer would prevent the cache from accessing a
dead pointer (at the cost of adding a refcount field to BdrvChild that C
doesn't use).

But for now maybe you can just rename the *mut-wrapping BdrvChild to
BdrvChildRef, get rid of Arc, and store an &BdrvChildRef into Mapping? Then
if you ever decide to go with the refcounting plan you can implement Deref.

> > +) -> std::os::raw::c_int {
> > > +    let s =3D unsafe { &mut *((*bs).opaque as *mut D) };
> >
> > &mut is not safe here (don't worry, we went through the same thing for
> > devices :)).  You can only get an & unless you go through an UnsafeCell
> (or
> > something that contains one).
>
> Right, we can have multiple requests in flight.
> The fix is easy here: Even though bindgen gives us a *mut, we only want
> a immutable reference.
>

Right.

There is no mutable part in BochsImage, which makes this easy. [...] But if
> we were to introduce a mutable part (I think we will add write

support to it sooner or later), then BqlRefCell or RefCell are
> definitely not right. They would only turn the UB into a safe panic when
> you have more than one request in flight. (Or actually, BqlRefCell
> should already panic with just one request from an iothread, because we
> don't actually hold the BQL.)
>

Yes, I mentioned RefCell because of the iothread case but I agree it also
isn't right. It wouldn't panic when you have more than one request in
flight however, as long as only map() needs to borrow_mut(). If instead you
need slightly more complex locking, for example similar to the vbox driver,
you need CoMutex/CoRwLock bindings.

> > +    let mut offset =3D offset as u64;
> > > +    let mut bytes =3D bytes as u64;
> > > +
> > > +    while bytes > 0 {
> > > +        let req =3D Request::Read { offset, len: bytes };
> > > +        let mapping =3D match qemu_co_run_future(s.map(&req)) {
> > > +            Ok(mapping) =3D> mapping,
> > > +            Err(e) =3D> return -i32::from(Errno::from(e).0),
> >
> > This is indeed not great, but it's partly so because you're doing a
> > lot (for some definition of "a lot") in the function.  While it would
> > be possible to use a trait, I wrote the API thinking of minimal glue
> > code that only does the C<->Rust conversion.
> >
> > In this case, because you have a lot more code than just a call into
> > the BlockDriver trait, you'd have something like
> >
> > fn bdrv_co_preadv_part(
> >     bs: &dyn BlockDriver,
> >     offset: i64,
> >     bytes: i64,
> >     qiov: &bindings::QEMUIOVector,
> >     mut qiov_offset: usize,
> >     flags: bindings::BdrvRequestFlags) -> io::Result<()>
> >
> > and then a wrapper (e.g. rust_co_preadv_part?) that only does
> >
> >    let s =3D unsafe { &mut *((*bs).opaque as *mut D) };
> >    let qiov =3D unsafe { &*qiov };
> >    let result =3D bdrv_co_preadv_part(s, offset, bytes,
> >          qiov, qiov_offset, flags);
> >    errno::into_negative_errno(result)
> >
> > This by the way has also code size benefits because &dyn, unlike
> > generics, does not need to result in duplicated code.
>
> I don't really like the aesthetics of having two functions on the
> Rust side for each C function, but I guess ugliness is expected in
> bindings...
>

Well, you don't *have* to have two. In this case I suggested two just
because the C and Rust APIs are completely different. But also...

> For now, I'd rather keep into_negative_errno() this way, to keep an
> > eye on other cases where you have an io::Error<()>.  Since Rust rarely
> > has Error objects that aren't part of a Result, it stands to reason
> > that the same is true of QEMU code, but if I'm wrong then it can be
> > changed.
>
> This one is part of a Result, too. But not a result that is directly
> returned in both success and error cases, but where the error leads to
> an early return. That is, an equivalent for the ubiquitous pattern:
>
>     ret =3D foo();
>     if (ret < 0) {
>         return ret;
>     }
>

... this is just "?" in Rust and it's the C/Rust boundary that complicates
things, because "?" assumes that you return another Result. So the
two-function idea helps because the inner function can just use "?", and
the outer one qemu_api::errno. It let's you use the language more
effectively. &dyn is just an addition on top.

If needed your inner function could return Result<T, Errno> instead of
Result<T, io::Error>, too. That works nicely because "?" would also convert
io::Error into Errno as needed.

>
But if you don't want the two functions, why wouldn't you just do "e =3D>
..." in the match statement instead of Err(e)?

Paolo

--000000000000802e48062e867836
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 19 feb 2025, 14:02 Kevin =
Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; ha sc=
ritto:</div></div></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Likewise, even BochsImage should not need a standard Rust Arc&lt;BdrvC=
hild&gt;.<br>
&gt; However you need to add your own block::Arc&lt;BdrvChild&gt; and map C=
lone/Drop to<br>
&gt; bdrv_ref/bdrv_unref.=C2=A0 Then BochsImage can use block::Arc&lt;BdrvC=
hild&gt;; this<br>
&gt; makes it even clearer that Mapping should not use the Arc&lt;&gt; wrap=
per, because<br>
&gt; bdrv_ref is GLOBAL_STATE_CODE() and would abort if run from a non-main=
<br>
&gt; thread.<br>
<br>
It&#39;s not BdrvChild that is refcounted on the C side, but<br>
BlockDriverState. We definitely don&#39;t bdrv_ref()/unref() for each<br>
request on the C side and we shouldn&#39;t on the Rust side either. The<br>
refcount only changes when you modify the graph.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">I keep confusing BdrvChild =
and BlockDriverState, sorry.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Talking in general about Rust and not QEMU, if you wanted to be able t=
o optionally store the mapping, and not always modify the refcount, you&#39=
;d probably want an &amp;Arc&lt;T&gt;. Then you only clone it if needed for=
 the cache (for example if you cached the *content* rather than the mapping=
, you wouldn&#39;t need to clone).</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">However, Arc doesn&#39;t work here. In order to globally invalid=
ate all cached mappings, you would need the cache to store something simila=
r to a Weak&lt;T&gt;. But even that doesn&#39;t quite work, because if you =
passed an &amp;Arc the caller could clone it as it wished. So using weak cl=
ones to do cache invalidation shows as the hack that it is.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Going back to QEMU, the Mapping needs=
 some smart pointer (something that implements Deref&lt;Target =3D bindings=
;:BdrvChild&gt;), which does implement some reference counting unlike the C=
 version but, unlike &amp;Arc&lt;BdrvChild&gt;, cannot be cloned willy nill=
y. Instead it can be 1) weakly-cloned under the graph rdlock 2) used from a=
 weak reference but only for the duration of an rdlock critical section (no=
 way to make it strong for an arbitrary lifetime!) 3) invalidated under the=
 graph wrlock.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The nice =
thing here is that, even if you have a good way to invalidate the cache, th=
at&#39;s orthogonal to how you make the Rust API memory safe. Cache invalid=
ation becomes just a way to quickly free the BdrvChild=E2=80=94the invalid =
entry would be detected anyway later when trying to use the weak reference.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">More practical/immediat=
e suggestion below...</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">I&#39;m not entirely sure how your block::Arc&lt;T&gt=
; is supposed to work. It<br>
would be tied to one specific type (BlockDriverState), not generic.<br>
Which probably means that it can&#39;t be a separate pointer type, but<br>
BlockDriverState itself should just implement Clone with bdrv_ref().<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You&#39=
;re right, I always forget the new BdrvChild world.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; That said, I&#39;m=
 not sure how to include &quot;block graph lock must be taken&quot; into<br=
>
&gt; the types, yet.=C2=A0 That has to be taken into account too, sooner or=
 later.<br>
&gt; You probably have a lot of items like this one so it&#39;d be nice to =
have TODO<br>
&gt; comments as much as you can.<br>
<br>
Actually, I&#39;m not aware of that many items.</blockquote></div></div><di=
v dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"> But yes, there is a TODO<br>
item for the graph lock.<br>
<br>
I think I&#39;ll have something like:<br>
<br>
=C2=A0 =C2=A0 pub struct BdrvChild {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 child: GraphLock&lt;*mut bindings::BdrvChild&gt=
;,<br>
=C2=A0 =C2=A0 }<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Arc&lt;BdrvChild&gt; poses another problem then, in that gra=
ph changes would invalidate the raw pointer even if the Arc is still alive.=
 Something like the aforementioned smart pointer would prevent the cache fr=
om accessing a dead pointer (at the cost of adding a refcount field to Bdrv=
Child that C doesn&#39;t use).</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">But for now maybe you can just rename the *mut-wrapping BdrvChild to=
 BdrvChildRef, get rid of Arc, and store an &amp;BdrvChildRef into Mapping?=
 Then if you ever decide to go with the refcounting plan you can implement =
Deref.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">&gt; &gt; +) -&gt; std::os::raw::c_int {<br>
&gt; &gt; +=C2=A0 =C2=A0 let s =3D unsafe { &amp;mut *((*bs).opaque as *mut=
 D) };<br>
&gt; <br>
&gt; &amp;mut is not safe here (don&#39;t worry, we went through the same t=
hing for<br>
&gt; devices :)).=C2=A0 You can only get an &amp; unless you go through an =
UnsafeCell (or<br>
&gt; something that contains one).<br>
<br>
Right, we can have multiple requests in flight.<br>The fix is easy here: Ev=
en though bindgen gives us a *mut, we only want<br>
a immutable reference.<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Right.=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">There is no mutable part in BochsImage, =
which makes this easy. [...] But if we were to introduce a mutable part (I =
think we will add write</blockquote></div></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
support to it sooner or later), then BqlRefCell or RefCell are<br>
definitely not right. They would only turn the UB into a safe panic when<br=
>
you have more than one request in flight. (Or actually, BqlRefCell<br>
should already panic with just one request from an iothread, because we<br>
don&#39;t actually hold the BQL.)<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Yes, I mentioned RefCell because of the io=
thread case but I agree it also isn&#39;t right. It wouldn&#39;t panic when=
 you have more than one request in flight however, as long as only map() ne=
eds to borrow_mut(). If instead you need slightly more complex locking, for=
 example similar to the vbox driver, you need CoMutex/CoRwLock bindings.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&g=
t; &gt; +=C2=A0 =C2=A0 let mut offset =3D offset as u64;<br>
&gt; &gt; +=C2=A0 =C2=A0 let mut bytes =3D bytes as u64;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 while bytes &gt; 0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 let req =3D Request::Read { offset, =
len: bytes };<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 let mapping =3D match qemu_co_run_fu=
ture(s.map(&amp;req)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ok(mapping) =3D&gt; ma=
pping,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Err(e) =3D&gt; return =
-i32::from(Errno::from(e).0),<br>
&gt; <br>
&gt; This is indeed not great, but it&#39;s partly so because you&#39;re do=
ing a<br>
&gt; lot (for some definition of &quot;a lot&quot;) in the function.=C2=A0 =
While it would<br>
&gt; be possible to use a trait, I wrote the API thinking of minimal glue<b=
r>
&gt; code that only does the C&lt;-&gt;Rust conversion.<br>
&gt; <br>
&gt; In this case, because you have a lot more code than just a call into<b=
r>
&gt; the BlockDriver trait, you&#39;d have something like<br>
&gt; <br>
&gt; fn bdrv_co_preadv_part(<br>
&gt;=C2=A0 =C2=A0 =C2=A0bs: &amp;dyn BlockDriver,<br>
&gt;=C2=A0 =C2=A0 =C2=A0offset: i64,<br>
&gt;=C2=A0 =C2=A0 =C2=A0bytes: i64,<br>
&gt;=C2=A0 =C2=A0 =C2=A0qiov: &amp;bindings::QEMUIOVector,<br>
&gt;=C2=A0 =C2=A0 =C2=A0mut qiov_offset: usize,<br>
&gt;=C2=A0 =C2=A0 =C2=A0flags: bindings::BdrvRequestFlags) -&gt; io::Result=
&lt;()&gt;<br>
&gt; <br>
&gt; and then a wrapper (e.g. rust_co_preadv_part?) that only does<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 let s =3D unsafe { &amp;mut *((*bs).opaque as *mut D) };<=
br>
&gt;=C2=A0 =C2=A0 let qiov =3D unsafe { &amp;*qiov };<br>
&gt;=C2=A0 =C2=A0 let result =3D bdrv_co_preadv_part(s, offset, bytes,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qiov, qiov_offset, flags);<br>
&gt;=C2=A0 =C2=A0 errno::into_negative_errno(result)<br>
&gt; <br>
&gt; This by the way has also code size benefits because &amp;dyn, unlike<b=
r>
&gt; generics, does not need to result in duplicated code.<br>
<br>
I don&#39;t really like the aesthetics of having two functions on the<br>
Rust side for each C function, but I guess ugliness is expected in<br>
bindings...<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Well, you don&#39;t *have* to have two. In this case I suggested=
 two just because the C and Rust APIs are completely different. But also...=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quo=
te gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>&gt; For now, I&#39;d rather keep into_negative_errno() this way, to keep =
an<br>
&gt; eye on other cases where you have an io::Error&lt;()&gt;.=C2=A0 Since =
Rust rarely<br>
&gt; has Error objects that aren&#39;t part of a Result, it stands to reaso=
n<br>
&gt; that the same is true of QEMU code, but if I&#39;m wrong then it can b=
e<br>
&gt; changed.<br>
<br>
This one is part of a Result, too. But not a result that is directly<br>
returned in both success and error cases, but where the error leads to<br>
an early return. That is, an equivalent for the ubiquitous pattern:<br>
<br>
=C2=A0 =C2=A0 ret =3D foo();<br>
=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 }<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">... this is just &quot;?&quot; in Rust and it&#39;s the C/Ru=
st boundary that complicates things, because &quot;?&quot; assumes that you=
 return another Result. So the two-function idea helps because the inner fu=
nction can just use &quot;?&quot;, and the outer one qemu_api::errno. It le=
t&#39;s you use the language more effectively. &amp;dyn is just an addition=
 on top.</div><div dir=3D"auto"><br></div><div dir=3D"auto">If needed your =
inner function could return Result&lt;T, Errno&gt; instead of Result&lt;T, =
io::Error&gt;, too. That works nicely because &quot;?&quot; would also conv=
ert io::Error into Errno as needed.</div><div dir=3D"auto"><div class=3D"gm=
ail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">But if you don&#39;t want the two functions, why wouldn&#39;t you just =
do &quot;e =3D&gt; ...&quot; in the match statement instead of Err(e)?</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div></div>

--000000000000802e48062e867836--


