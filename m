Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6CCE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpmq-0007mB-PZ; Sun, 15 Dec 2024 09:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMpmo-0007m3-U4
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:39:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMpmn-0008JW-9K
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734273593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k18jJXISRlFs1ETDlOQSZ0f4+urr1M+Ub0cfg7GAJp4=;
 b=igGQWvtZGod00ELrmXDFzDFQ3z/rVQ4nFV4ZZf7RI9s9dL6jybqgbwgz7NPKQ50Zp/hb9c
 VwDfhU7lW/7zWO0qurg6asuZVA6CXxK6ZqqKewV4W7KqseghfiEQyGAYv+pJU6wg31z2HQ
 CNlO+hJFDuet7x3jIFmlHPls2uHRw6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-P5My8ju5Mo6is8xnuoyTpA-1; Sun, 15 Dec 2024 09:39:51 -0500
X-MC-Unique: P5My8ju5Mo6is8xnuoyTpA-1
X-Mimecast-MFC-AGG-ID: P5My8ju5Mo6is8xnuoyTpA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso768828f8f.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734273589; x=1734878389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k18jJXISRlFs1ETDlOQSZ0f4+urr1M+Ub0cfg7GAJp4=;
 b=Pxt3MwBWDPKe/Y2d2E1g7WW/ga/ZFqVvIwweLz0T4biwKxWoVlLljo+vAnK1meFpqq
 eUL+E4wpZ3/bIru/yFpxfGxXkTi2r1J8oJ7kIx3XUSpaB4n0eclR8YySNu2uXFneQGUY
 vJ8SJQ1f/RMzC9SGdu11a8yej3rzIC1iO9D1EL10PgokAL8Bg9F2w8BjS6ZbQBFj5BST
 IeJXKS5jRFtVVMnf0VbWQ7jPXYotUACdTCK3QuJUvWyYPy3VN5bgjTMMTZyS8THFrW4c
 J0SXlPe7fvNAhtDupmhWbfXbE1hWqy7I8/pHSLL3YiTYfUKXdmZr2ObNHL0S/22tSKrF
 ie+w==
X-Gm-Message-State: AOJu0YxnKapxW3KcsMaX1C0/bCT2NnCKZU3zU0MRRaaKO5tRSuxv1HTq
 y8k7wh5QarQQm9sbGFHOwcHruhJVgqC4BNijuonJmOLZAL660QFnH9GhBsDhdjC7JtnokamNfzN
 jVMfogenHn2UEZ+Qcz9Bml2A97Sl5GEkuwlGU3ouErAOa7fTGNsXGB+m8iPXrVCxHaJ97G/THbk
 EV6//PnT+SKzqwMPu3tSjmUHLQMLGPcfT7zdI=
X-Gm-Gg: ASbGncuBbl8YcXEvHKuHBJ9SU/nlY5fQqxH2INFhmZr45hHqLPPUCkJqHxW9m04yyRe
 wsxuYE9Jtz6A+BR36zpQ0lcBgZ7Qkyq0ruoko
X-Received: by 2002:a5d:5886:0:b0:385:decf:52bc with SMTP id
 ffacd0b85a97d-38880ae1a02mr7138825f8f.32.1734273588772; 
 Sun, 15 Dec 2024 06:39:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2+G/99ouVJ0LCzTbolwDYippaHk9OsmgdVXV2gSo7eAmGo7Jyx+pxQJIQTv5SmUJrdIVob07xHVLfpSrCHFM=
X-Received: by 2002:a5d:5886:0:b0:385:decf:52bc with SMTP id
 ffacd0b85a97d-38880ae1a02mr7138818f8f.32.1734273588445; Sun, 15 Dec 2024
 06:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-5-pbonzini@redhat.com>
 <9b83983a-7f1d-4982-aacb-a88b6ca17388@linaro.org>
In-Reply-To: <9b83983a-7f1d-4982-aacb-a88b6ca17388@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 15 Dec 2024 15:39:36 +0100
Message-ID: <CABgObfbi8vdPGzk4NXBwOQerPhFKPEQqZPmwe6suNW-qBBEJcQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] target/i386: unify choice between single and
 repeated string instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002ee6d7062950093c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
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

--0000000000002ee6d7062950093c
Content-Type: text/plain; charset="UTF-8"

Il dom 15 dic 2024, 15:10 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 12/15/24 03:06, Paolo Bonzini wrote:
> > The same "if" is present in all generator functions for string
> instructions.
> > Push it inside gen_repz() and gen_repz_nz() instead.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/translate.c | 12 +++++++++--
> >   target/i386/tcg/emit.c.inc  | 42 +++++++------------------------------
> >   2 files changed, 17 insertions(+), 37 deletions(-)
> >
> > diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> > index 8bf6aa1fcf6..63a39d9f15a 100644
> > --- a/target/i386/tcg/translate.c
> > +++ b/target/i386/tcg/translate.c
> > @@ -1340,13 +1340,21 @@ static void gen_repz(DisasContext *s, MemOp ot,
> >                        void (*fn)(DisasContext *s, MemOp ot))
> >
> >   {
> > -    do_gen_rep(s, ot, fn, false);
> > +    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
> > +        do_gen_rep(s, ot, fn, false);
> > +    } else {
> > +        fn(s, ot);
> > +    }
> >   }
> >
> >   static void gen_repz_nz(DisasContext *s, MemOp ot,
> >                           void (*fn)(DisasContext *s, MemOp ot))
> >   {
> > -    do_gen_rep(s, ot, fn, true);
> > +    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
> > +        do_gen_rep(s, ot, fn, true);
> > +    } else {
> > +        fn(s, ot);
> > +    }
> >   }
>
> Why not push it into do_gen_rep?
>

Just because do_gen_rep is already complicated enough by the end of the
series.

Paolo


> r~
>
>

--0000000000002ee6d7062950093c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 15 dic 2024, 15:10 Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 12/15/24 03:06, Paolo Bonzini wrote:<br>
&gt; The same &quot;if&quot; is present in all generator functions for stri=
ng instructions.<br>
&gt; Push it inside gen_repz() and gen_repz_nz() instead.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/tcg/translate.c | 12 +++++++++--<br>
&gt;=C2=A0 =C2=A0target/i386/tcg/emit.c.inc=C2=A0 | 42 +++++++-------------=
-----------------<br>
&gt;=C2=A0 =C2=A02 files changed, 17 insertions(+), 37 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c=
<br>
&gt; index 8bf6aa1fcf6..63a39d9f15a 100644<br>
&gt; --- a/target/i386/tcg/translate.c<br>
&gt; +++ b/target/i386/tcg/translate.c<br>
&gt; @@ -1340,13 +1340,21 @@ static void gen_repz(DisasContext *s, MemOp ot=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 void (*fn)(DisasContext *s, MemOp ot))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 do_gen_rep(s, ot, fn, false);<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;prefix &amp; (PREFIX_REPZ | PREFIX_REPNZ)) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_gen_rep(s, ot, fn, false);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn(s, ot);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void gen_repz_nz(DisasContext *s, MemOp ot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*fn)(DisasContext *s, MemOp ot))<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 do_gen_rep(s, ot, fn, true);<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;prefix &amp; (PREFIX_REPZ | PREFIX_REPNZ)) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_gen_rep(s, ot, fn, true);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn(s, ot);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
Why not push it into do_gen_rep?<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Just because do_gen_rep is already complica=
ted enough by the end of the series.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
r~<br>
<br>
</blockquote></div></div></div>

--0000000000002ee6d7062950093c--


