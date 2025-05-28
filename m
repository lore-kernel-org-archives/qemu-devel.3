Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E37C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 07:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBdp-00009n-L1; Wed, 28 May 2025 03:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKBdo-00009H-3P
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKBdj-0002Qp-BD
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748418953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvyhNMJ0uimp/khsNIVEufDaCxJFL+7kBmJ3nVozSFQ=;
 b=KXItPhwJswepPEkq/80q95kdWCoMXl0vBRwBIS2Lqq/fb/ABcB3XkRoNhPVYPGIyR3h7wV
 G9JfYWU6vhrrujp5Tqp07/D/+d1rhVLnhIoT6fLr7TKKbzDoWPwgDqXhHVGr9m7kkJUY1v
 bTraCVvhDs4uPK3923Zr9dLQH6IRFq4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-nalGzvt9O3KLW12qzoxM-Q-1; Wed, 28 May 2025 03:55:51 -0400
X-MC-Unique: nalGzvt9O3KLW12qzoxM-Q-1
X-Mimecast-MFC-AGG-ID: nalGzvt9O3KLW12qzoxM-Q_1748418951
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4d00e44fdso1786251f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 00:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748418950; x=1749023750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AvyhNMJ0uimp/khsNIVEufDaCxJFL+7kBmJ3nVozSFQ=;
 b=C7msM2yEWO1nHgBXbglCjwJWleGrGex0RLHVr7CW08LqUJgTU5d3duP1ty+wUBuBun
 Ar8ZWW7WCbNOPSI2wq6DsaaM1gjxTlbIkzDQBlDEJbayooSYD6c+mTOIVb+pwZmgEkQW
 Uf4EgWbeRQTC/6xi/N6kgw0te0adLqph+T93Wxzg5nhAdFADcFEobwTqCaV8jDi1LHmi
 qcEVHM5jXG63agcsvI7+Fgj1sXLlFIQzBd3Ym43GUeklOfG0AUFuJaQKojRLH75nG3ea
 CxEkVxocNxE+F0IwYrmppkTAQR7y6Bn8heia8PoQ/z3jrWBH71L1Oenp79cmOzJR16Ud
 jM5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXME7GMphUJTgkpuSuGVimVA3TKLxeyC8gFsdNUTjCu0K1XQGQYBKqCGRHs84euLGwWCa8mGLB5dyi+@nongnu.org
X-Gm-Message-State: AOJu0Yz4Aa7h9eGWbuveCIKv17jItMxGUoy4SPnuckKgxEv+gUfvgduE
 JsQYQXrlmqJgtZ7v1UbQd3LUMzI1rP7laZo/0uat7qvGXz8TmfbX8No4JRPYud5Qq2Un2XauY2Y
 Vz7Ei/R95GrgIPDI/SPzC6G0TyrUUFuJTlytpSeb0S4//Y4xfFJlsjk7LV3nYqCapcme1dvgmhb
 fx+uduAcZNnqgqsopNOvXIJuRwbYkTkLE=
X-Gm-Gg: ASbGncs3KRPpXX4EKKFa7sP0xlk35f2of+p1Odf8dtUvTZ+NR2WPuQ7miki+eJEf+OK
 K5bxpeGdA7MQU6tih+qO0EnhLMLQA5EUwiaasA9bN+dG8DF56sDEBpM84TMK1YK+Uazk=
X-Received: by 2002:a05:6000:430a:b0:3a4:d0fe:42af with SMTP id
 ffacd0b85a97d-3a4e944dc36mr1003915f8f.33.1748418950447; 
 Wed, 28 May 2025 00:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAeriPCZKqOJVDOtmAoRES/aOzpR/++wArAnrx/FYKfgm+/FrZNbZ7W3KJqNQB+SmccY6SzirxAU7+2fM11jk=
X-Received: by 2002:a05:6000:430a:b0:3a4:d0fe:42af with SMTP id
 ffacd0b85a97d-3a4e944dc36mr1003882f8f.33.1748418949933; Wed, 28 May 2025
 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250508222132.748479-1-nabihestefan@google.com>
 <20250508222132.748479-2-nabihestefan@google.com>
 <87cycibagm.fsf@pond.sub.org> <aB207Rl-vZxfuJBM@redhat.com>
In-Reply-To: <aB207Rl-vZxfuJBM@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 May 2025 09:55:38 +0200
X-Gm-Features: AX0GCFvmLaOtrFRsE6pWNNO_rqiSGIttG-eQpxpdgBvuAVAnZd0Lxk-XgUsDwb8
Message-ID: <CABgObfaOtK7W3CqR8+Dm3R71kGp3_mVkKVDaHa=SX8G0HZExMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] util: fix msan findings in keyval
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="0000000000006e005206362d820a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000006e005206362d820a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 9 mag 2025, 09:58 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> On Fri, May 09, 2025 at 07:48:57AM +0200, Markus Armbruster wrote:
> > Nabih Estefan <nabihestefan@google.com> writes:
> >
> > > From: Peter Foley <pefoley@google.com>
> > >
> > > e.g.
> > > I   2025-02-28 09:51:05.240071-0800         624     stream.go:47
> qemu: Uninitialized value was created by an allocation of 'key_in_cur.i' =
in
> the stack frame
> > > I   2025-02-28 09:51:05.240187-0800         624     stream.go:47
> qemu: #0 0xaaaac49f489c in keyval_parse_one
> third_party/qemu/util/keyval.c:190:5
> > >
> > > Signed-off-by: Peter Foley <pefoley@google.com>
> > > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > > ---
> > >  util/keyval.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/util/keyval.c b/util/keyval.c
> > > index a70629a481..f33c64079d 100644
> > > --- a/util/keyval.c
> > > +++ b/util/keyval.c
> > > @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict,
> const char *params,
> > >  {
> > >      const char *key, *key_end, *val_end, *s, *end;
> > >      size_t len;
> > > -    char key_in_cur[128];
> > > +    char key_in_cur[128] =3D {};
> > >      QDict *cur;
> > >      int ret;
> > >      QObject *next;
> >
> > Prior review of Peter's patch concluded this must be false positive:
> >
> https://lore.kernel.org/qemu-devel/14168384-ecdb-4c05-8267-ac5ef1c46fe9@r=
edhat.com/
>
> While I agree with Paolo's reasoning, I think it is still worth adding an
> explicit initializer, because it makes it easier for both humans and
> machines
> to reason about correctless.
>

The problem is that, in the exact same (impossible) case there would have
to be another uninitialized variable, s. So the patch ends up making it
harder to understand what are the invariants of the function.

One should fix the compiler instead.

Paolo


> To reinforce that we don't have an actual bug though, also note that qemu
> unconditionally builds with -ftrivial-auto-var-init=3Dzero. So if we happ=
en
> to forget any, it won't cause a bug in the common case of a
> zero-initializer.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000006e005206362d820a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 9 mag 2025, 09:58 Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
berrange@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Fri, May 09, 2025 at 07:48:57AM +0200, Markus Ar=
mbruster wrote:<br>
&gt; Nabih Estefan &lt;<a href=3D"mailto:nabihestefan@google.com" rel=3D"no=
referrer noreferrer" target=3D"_blank">nabihestefan@google.com</a>&gt; writ=
es:<br>
&gt; <br>
&gt; &gt; From: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; e.g.<br>
&gt; &gt; I=C2=A0 =C2=A02025-02-28 09:51:05.240071-0800=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0624=C2=A0 =C2=A0 =C2=A0stream.go:47=C2=A0 =C2=A0 qemu: Uninit=
ialized value was created by an allocation of &#39;key_in_cur.i&#39; in the=
 stack frame<br>
&gt; &gt; I=C2=A0 =C2=A02025-02-28 09:51:05.240187-0800=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0624=C2=A0 =C2=A0 =C2=A0stream.go:47=C2=A0 =C2=A0 qemu: #0 0xa=
aaac49f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.c=
om" rel=3D"noreferrer noreferrer" target=3D"_blank">pefoley@google.com</a>&=
gt;<br>
&gt; &gt; Signed-off-by: Nabih Estefan &lt;<a href=3D"mailto:nabihestefan@g=
oogle.com" rel=3D"noreferrer noreferrer" target=3D"_blank">nabihestefan@goo=
gle.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 util/keyval.c | 2 +-<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/util/keyval.c b/util/keyval.c<br>
&gt; &gt; index a70629a481..f33c64079d 100644<br>
&gt; &gt; --- a/util/keyval.c<br>
&gt; &gt; +++ b/util/keyval.c<br>
&gt; &gt; @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qd=
ict, const char *params,<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 const char *key, *key_end, *val_end, *s, *end=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 size_t len;<br>
&gt; &gt; -=C2=A0 =C2=A0 char key_in_cur[128];<br>
&gt; &gt; +=C2=A0 =C2=A0 char key_in_cur[128] =3D {};<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 QDict *cur;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 QObject *next;<br>
&gt; <br>
&gt; Prior review of Peter&#39;s patch concluded this must be false positiv=
e:<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/14168384-ecdb-4c05-8267-=
ac5ef1c46fe9@redhat.com/" rel=3D"noreferrer noreferrer noreferrer" target=
=3D"_blank">https://lore.kernel.org/qemu-devel/14168384-ecdb-4c05-8267-ac5e=
f1c46fe9@redhat.com/</a><br>
<br>
While I agree with Paolo&#39;s reasoning, I think it is still worth adding =
an<br>
explicit initializer, because it makes it easier for both humans and machin=
es<br>
to reason about correctless.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">The problem is that, in the exact same (impossi=
ble) case there would have to be another uninitialized variable, s. So the =
patch ends up making it harder to understand what are the invariants of the=
 function.</div><div dir=3D"auto"><br></div><div dir=3D"auto">One should fi=
x the compiler instead.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
To reinforce that we don&#39;t have an actual bug though, also note that qe=
mu<br>
unconditionally builds with -ftrivial-auto-var-init=3Dzero. So if we happen=
<br>
to forget any, it won&#39;t cause a bug in the common case of a zero-initia=
lizer.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer noreferrer=
" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =
=C2=A0 <a href=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferre=
r noreferrer noreferrer" target=3D"_blank">https://www.flickr.com/photos/db=
errange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-o-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138=
.berrange.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">h=
ttps://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer nore=
ferrer" target=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=
=C2=A0 =C2=A0 <a href=3D"https://www.instagram.com/dberrange" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://www.instagram.com/dbe=
rrange</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000006e005206362d820a--


