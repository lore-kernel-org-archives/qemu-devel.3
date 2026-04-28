Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC04FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjWf-0004QT-DJ; Tue, 28 Apr 2026 10:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wHjWb-0004NH-6h
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wHjWZ-0007eH-3n
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777386894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/X9F3hqTAla0CwSU5HYsvFQXK93IfCi423LiAxlW4MQ=;
 b=KNtCj9nZVLTlSWvlWOkXEvJPnM2qeRYj94J86baasSUDBEmy3AJZKQ74cAslWi2OCT43yx
 BYaT5Ug35+1GYA8C4/Y5CYKB7Zl8CbwrteIKQCcWCQHJB/DphRQikhLfMc/JsmDVDyt7PT
 5qAhFya6N/yLFEX5BWufhdn6N89gHFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-otuGXGbaNwKFYRdNJc4b5Q-1; Tue, 28 Apr 2026 10:34:50 -0400
X-MC-Unique: otuGXGbaNwKFYRdNJc4b5Q-1
X-Mimecast-MFC-AGG-ID: otuGXGbaNwKFYRdNJc4b5Q_1777386889
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43efc93e4f6so9306763f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386889; cv=none;
 d=google.com; s=arc-20240605;
 b=R3WU8KQ1nuAqGs6xQkplSKWVpHbqKiZRs6Hfb5yNlsKlkL92uBVS64FivGMuEEK0lC
 RoKxUb+/XSmGjszGHl/fkCyP/wAJykpMRITVlofF7R1xE4a6hQ3negeDcx/8+yA4Bl7E
 f1G6awrzFJOuQp1sJNwXTN/Sk2Iy3uJI5MKrHpjXZFx/bQIDGYrQmQYXZ4rG1VeWWMYL
 cUP/sPnR9/KVrKnu/5xQJRiFS6sqcsk1dzW4y8h3qxphq9kwv/Z2ctIFrP2eZW/kOgpV
 IzXndW8hr2Io7eT2nqmh6Xn24vPMmUgD9Jbrf4gKxA0lakPGjfjQ5CN+OH/Vf+IxJDoQ
 fEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/X9F3hqTAla0CwSU5HYsvFQXK93IfCi423LiAxlW4MQ=;
 fh=9Xx9cwOY4dhrEmyBhLmu/e46S7D1etRAmjbIzgyduAk=;
 b=lzsyKNEpG5AltcoVMoM7SgtZ8lBnGZqz/jPCtvOtfI6pTkl9jAZ8ROMNmWDXBXnRNs
 uLZeVAt0/Pwe3Uv13PLwmEC5sFk6jgY5z8Omg5yhqFVbzJZ2WP0cfnkPeeDoSj1+i9ni
 IteiF3cuEjR82m8bPvdFAVCxPwBJ9aU0uU1pJUZkCWkvKHrjWNzlERrenIZB1zbNNVRB
 EjikXDXsvYrbF8ONfuJC21iTzY7lwD2eWxsSrcRbtqIVRvtdlqCsYKiAMsyhVxtq29Bo
 6gEAexn0vA7bFSxWEUw4Rt74OC9oMNTkio8royCkQ2sK4ZzwLplU1BK7dvkXbVGGPYUY
 BXCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777386889; x=1777991689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/X9F3hqTAla0CwSU5HYsvFQXK93IfCi423LiAxlW4MQ=;
 b=N//JgTjFGyqhzN1TgYVJ9ZS6EZ7+AhD0EbIVJ67CP7TsnZWqbXbM1Hj07dqHcocD8J
 cK4ZkEzURzBWWZEaRpwOqa9u/NgDwZWUFKkufHrxNULwuCcxOEt5Z9CdvOz3nGDzJRpD
 9iz88FPhZBo1b4JDnopywAWJ6v9XNLk9u9RXMtF4Xjf9ubSeYmEkXkZVeH3bv1PnTMaD
 Wr4rIpvgUrw8qRjoK3hBTXmHNYfqJTUJS8x/pmCboXjc4GUvnZM0YSN5dpjhUQuz/i1O
 +ZV+5VYlWDyTmFtOI3Bkxeb+Abrd3izS8cI6MqC2NM1PRgu+ShnhMS26bsFIk82BmXj7
 MIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386889; x=1777991689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/X9F3hqTAla0CwSU5HYsvFQXK93IfCi423LiAxlW4MQ=;
 b=s6vLDXjp1YarrzoGK1LdoVaKeilc0QPP822w29Ly4sK62HWW0fmbYYeAvJsZCaN7TY
 XM923GjDJCoqzCI/psGawlUspibJVhdSceOlU17H432uBM9bQPyeWgKivsZHFjhmiJuO
 VE3HJxPISzp+VjFXqiPDJ/nbUVAzWvclgOtyVnYo0I0lOuR4F/kVn20aZ0crFAD61eHQ
 T5vww6hqxK5Rc5KcDfYpZxGboB4PF2izey75MkGfFwamPRlSNcwkpKHsZxNjWDPLVH6q
 9PkxJpqp5pGaK6XNkcWqGUXnpfgD6o7SIqMSZgWJJ1OKqXPBel7vVn8U+PpJfDh8GxLt
 xwWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hSZNGKdmO9o3w3PFJWL0PKCWqmxWZu5rspCylkhK+bVFUangzSMYKxFMWR9+gcZiCvplPngQy8h71@nongnu.org
X-Gm-Message-State: AOJu0Yx24sUDkMnnw2z3I6NBDv62BJiVgvm1vqONTO7dFYlJR7eOvVLF
 1Eea4tSLSMEPNPMeQ3d6KVmqjftmSWHi4nRnq4UsRYZNYgMBisBv7pO8b/Qk+KPGPtRb7fTHQlq
 3w6DrULrO3W96VKB5jvupESx55eRT/ahw7wvkKApihVmW1Oj03je8ojPLzyqFMgXoDd6YqcWUop
 zYo8ZMfah1BflwaIE0YtWQrVWXvQgH9ao=
X-Gm-Gg: AeBDiesqxmrQESsTOeAfuWlWc3guZ/eR3Xip+HdYYbsmu703I/oUZ3qSxNKcOwxdRyD
 1Xxslc58LyZlr/c2Ns+cBnKhOWZMft5e3rqDDmi1pJBLM/8Le3dQkvn7sV5sqEWvURUL7bcPX+b
 Wd+ai+njtyHBWab5DZ7mgLtsZbM8DgrpqUi7Q9FTOe/+nvakb4J7U0NYpG06aH3x6E9kAKzNWNl
 RC2PSmVehZ590I71BWDersq6aoHTIHth9oAuIpzWNW1ArOyIjvQDsdkmJJs3siBxWiCei8IPipc
 IBkUJUSdS9DgSU6V
X-Received: by 2002:a05:6000:2212:b0:43f:e41d:8ba8 with SMTP id
 ffacd0b85a97d-44648681cfbmr5983410f8f.2.1777386889312; 
 Tue, 28 Apr 2026 07:34:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2212:b0:43f:e41d:8ba8 with SMTP id
 ffacd0b85a97d-44648681cfbmr5983364f8f.2.1777386888777; Tue, 28 Apr 2026
 07:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-13-vsementsov@yandex-team.ru>
 <d80e91c1-2cbb-4081-a923-7b0c1da3b7cc@redhat.com>
 <f7525a89-7878-43e8-b791-69829589666f@yandex-team.ru>
 <CABgObfbz98A0P4_FAqeKVk_fS+o_3=79agYz=qwnMdmg-h2L-Q@mail.gmail.com>
 <b47b83aa-c574-4a38-bad2-4f42d6a7c597@yandex-team.ru>
 <de48c866-6018-4a5f-9129-2c1d184f4495@redhat.com>
 <878qa72u1m.fsf@pond.sub.org>
In-Reply-To: <878qa72u1m.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Apr 2026 16:34:34 +0200
X-Gm-Features: AVHnY4LAgXKfO-9HkdCQ53gP3Vc0YEnYYHITbZOoBUhLgGbKXmP4cUmH8cBqSgU
Message-ID: <CABgObfYzPc-=MzV=2VKfKxfN1o80bLyowvMREXom_C8H=mim3g@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] migration: VMStateInfo: introduce new handlers
 with errp
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002273a90650862252"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000002273a90650862252
Content-Type: text/plain; charset="UTF-8"

Il mar 28 apr 2026, 13:39 Markus Armbruster <armbru@redhat.com> ha scritto:

> 3. Set an error, goto error exit without flipping the return value
> variable from success to failure.  I've seen and fixed this, too.  Best
> to initialize the return value variable to failure, and flip it to
> success only when success is ensured.  Of course, that flip can be
> forgotten as well if it's needed in multiple places.  That's rare.
> Anyway, returning eliminates this bug pattern.
>

This can also be fixed with autofree etc.

Another one is returning directly the value from another function without
flipping from 0/-errno to bool. I think this one is more common.

Paolo

The last one does some tilting.
>
> Tilting the other way: keeping the rules simple and consistent with
> GError's.
>
> >> Understand. Hm.
> >>
> >> An alternative for this single-caller case, is just add an assertion
> into this caller:
> >>
> >> bool wrapper(..., errp) {
> >>     ERRP_GUARD();
> >>     bool ok = x->foo(..., errp);
> >>     assert(ok == !(*errp));
> >>     return ok;
> >> }
> >
> > I don't think this makes sense, the assertion moves a compile-time
> guarantee to a run-time guarantee which is strictly worse.
> >
> > There are many more examples of void+errp callbacks than bool+errp, the
> most important one being .realize for devices.  A quick grep, which is
> certainly not fully accurate, shows 63 vs. 27:
> >
> > $ git grep -w 'void.*(\*.*errp' | wc -l
> > 63
> > $ git grep -w 'bool.*(\*.*errp' | wc -l
> > 27
>
> Yes.  At some point, I briefly considered updating them to return bool
> for rules conformance, but decided it wasn't worth it.
>
> > In many cases there are just two or three implementation so I wouldn't
> go to great lengths to change it even if I disagree.  But for vmstate (e.g.
> pre_load_errp and friends) this is not going to be the case in the long
> run, and it's more similar to the device case.
>
> We should always be willing to accept reasoned exceptions to rules.
> However...
>
> >>>> I'm not sure that making wrappers, which will have to use ERRP_GUARD
> and check
> >>>> *errp for the error is a good practice. If it is, it would be good to
> start by
> >>>> modifying the documentation in include/qapi/error.h to mention the
> exclusion
> >>>> for callbacks.
>
> ... explaining them in documentation is desirable.
>

--0000000000002273a90650862252
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 28 apr 2026, 13:39 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
3. Set an error, goto error exit without flipping the return value<br>
variable from success to failure.=C2=A0 I&#39;ve seen and fixed this, too.=
=C2=A0 Best<br>
to initialize the return value variable to failure, and flip it to<br>
success only when success is ensured.=C2=A0 Of course, that flip can be<br>
forgotten as well if it&#39;s needed in multiple places.=C2=A0 That&#39;s r=
are.<br>
Anyway, returning eliminates this bug pattern.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">This can also be fixed with a=
utofree etc.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Another one=
 is returning directly the value from another function without flipping fro=
m 0/-errno to bool. I think this one is more common.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
The last one does some tilting.<br>
<br>
Tilting the other way: keeping the rules simple and consistent with<br>
GError&#39;s.<br>
<br>
&gt;&gt; Understand. Hm.<br>
&gt;&gt;<br>
&gt;&gt; An alternative for this single-caller case, is just add an asserti=
on into this caller:<br>
&gt;&gt;<br>
&gt;&gt; bool wrapper(..., errp) {<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 ERRP_GUARD();<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 bool ok =3D x-&gt;foo(..., errp);<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 assert(ok =3D=3D !(*errp));<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 return ok;<br>
&gt;&gt; }<br>
&gt;<br>
&gt; I don&#39;t think this makes sense, the assertion moves a compile-time=
 guarantee to a run-time guarantee which is strictly worse.<br>
&gt;<br>
&gt; There are many more examples of void+errp callbacks than bool+errp, th=
e most important one being .realize for devices.=C2=A0 A quick grep, which =
is certainly not fully accurate, shows 63 vs. 27:<br>
&gt;<br>
&gt; $ git grep -w &#39;void.*(\*.*errp&#39; | wc -l<br>
&gt; 63<br>
&gt; $ git grep -w &#39;bool.*(\*.*errp&#39; | wc -l<br>
&gt; 27<br>
<br>
Yes.=C2=A0 At some point, I briefly considered updating them to return bool=
<br>
for rules conformance, but decided it wasn&#39;t worth it.<br>
<br>
&gt; In many cases there are just two or three implementation so I wouldn&#=
39;t go to great lengths to change it even if I disagree.=C2=A0 But for vms=
tate (e.g. pre_load_errp and friends) this is not going to be the case in t=
he long run, and it&#39;s more similar to the device case.<br>
<br>
We should always be willing to accept reasoned exceptions to rules.<br>
However...<br>
<br>
&gt;&gt;&gt;&gt; I&#39;m not sure that making wrappers, which will have to =
use ERRP_GUARD and check<br>
&gt;&gt;&gt;&gt; *errp for the error is a good practice. If it is, it would=
 be good to start by<br>
&gt;&gt;&gt;&gt; modifying the documentation in include/qapi/error.h to men=
tion the exclusion<br>
&gt;&gt;&gt;&gt; for callbacks.<br>
<br>
... explaining them in documentation is desirable.<br>
</blockquote></div></div></div>

--0000000000002273a90650862252--


