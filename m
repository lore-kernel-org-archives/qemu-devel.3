Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDC0C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpql4-0007uY-AN; Fri, 31 Jul 2026 13:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpql2-0007uC-0v
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:10:52 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpql0-0001pl-7y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:10:51 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fc856b00eso1478844a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785517848; cv=none;
 d=google.com; s=arc-20260327;
 b=qVs4mdnp4CeluezkdOUnTvJhq4bZm88OqAKEZv9FlyYFJSAi5mvl+WVpRS1PfCFzqB
 GQBLC+a2OzP7oVakQCAfroc1UGn7dE8t013/TfTz2+lLYgh8PF5vwG0Nqx25JwcOn3Fq
 YgssotQyaut5G0C/Dvb0FBAnYFuhlKiSC1oY4pr5n2LdeTSl8+miY5EzGIYLMqBvvP87
 4OWt81Y/Z/HF4fPVVaHjO4+yecDqXLNx8fdF62ypv294lPXZ+p2BxWV9ygiFN2rJHzM6
 JkkFsJ62Q8yz8jj3Lrcn1CX3vC+WFySNjjDYelsTVNrONo6qVcUq383V4htJJOFrFfkG
 lewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ko4IoMN576l5mmq3IdfKwWLvvs6uThQRba347hcZpfY=;
 fh=UaA1yCOjKZbN2T3Nzlq9jhGnddnHE8rnoiFOPAMopGg=;
 b=GcXKkJlH2rZejGELkQt7lJhWy7mkKJpvhbnyE2SOY9X2rsA9vSoX/EwiGC7GlSVII5
 MvG8l8GYyvkb4oeXDN2Gi1H1aSkqscongQSqz/9bU/60goJ33camub3B1uVPws5kL8VV
 HTE3gBf5xirDhS4CQpp9E2KocSZEfNBTZcuCaf+TLGa5WBC2UUBSNia6J6m5pxZDUOSP
 d1PJizOIL1SxBr6T4jSxgMqDDcQEfmUmJZr384/9mLU05KoOnP/5Ud626bPaGbVAtNwN
 g6+RTe3+qzLqK/eSEHKGAx45Q8K1nhDNW5eBmWP3VBbO1ZUx2lAR53i/DcWYmPA1knVH
 E6Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785517848; x=1786122648; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ko4IoMN576l5mmq3IdfKwWLvvs6uThQRba347hcZpfY=;
 b=T0+tfu1UEVyfb9pUFO3uBYUvZVP+XPM8VQuTFz60kVd1M/6v0GGSkF2Stl3WJxp+Aw
 EcXw4PXhh6opaLKdyVT4+NbWEccIKkUuyXX/8uNJ94RLpawYhH32E5dWlUtQ10BKvcCk
 Rl4RV8y9Gf8LguHU+L0Q9NnkRr3r8+2GR9amadD51HB6ftaldpO3Ojd2AVf7xYG826hM
 +TyKYRdBh2q4yfyEbpr6SsTBi/JjUH3ZFfDhyzK4JINWDX9Cb8kuxP3PVguwQAPbGCG1
 pDfrenVxjLU7mkaXbTBYvFGkgCc79RMEJPoAS0EHrVhIw2g9AOd272qnGaVupQVV9WFz
 0NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517848; x=1786122648;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ko4IoMN576l5mmq3IdfKwWLvvs6uThQRba347hcZpfY=;
 b=UfEznL95UQRxK9Oz37RG1Sag40yx9TyfVsSkbYQUirIWq2ZdS3Q9HZBqZ2FfYnVyy1
 qn8QPpbUZJ6rQOasU6wanoiwrrTv2iR2wlTCrQXJatEb9iOpYjGLYuKJTPbtyOT78LDw
 exZmsgamtoONuz50PEGVKq2UQipwBqpjd5HPvnuufhznWY9oyOGITNVwGeRsFQkceDbx
 Xw//mMWZyUhIb8HBHkiV6V9KzikTKvnuyC1+X1ai5yPfxXk2jvv9G2fvmAUzMjdg4OYz
 Ze+dVNspBXCwPEwjXslz1rl2Mc3tSqg5v+F8Cveva4Cswl7r4C+VO9X/cpP1vjNJxKn5
 Y8Wg==
X-Gm-Message-State: AOJu0YylaOSo9PBcF/OFowHc+lzZ0KTXFdoHj1d2Wa1CzsUFt6ATxSlE
 LYFu2WQXaaqSrioURMfrRq+2G0QvF1UnTofu+jTcPzbHhF0bcTFqu3VVCv6U04C4/HJVCqB2CqA
 tnTrNQkDQYLtQ0Iq9Hi5JTsqT7Ms2AeI=
X-Gm-Gg: AR+sD12wZ/HFuGDnUEuHJFtoAK9SVPWDxVP411HtXrbWGoxB1YMZMEdA56HjZ0DNsto
 Sjec5aHzTeqqeDk3fagLSZXjkk6pedesoGLbdmjAkHZPVTUUqWZdLQTgv4gZSrloQTUIfVj0CoG
 a/eEw0vq7Frb6pchmGHZKQ3PLXWaDXwCpayAVcJKM2df0XDqZ6ZbxAdq8tAqlLjoNLZQNWL/z1h
 qw3uDiVZZBGjMVxj+dh/SDYqWdwCTN5zATkbl1QWfzKBgmXdKPJ2nhiubk+ZkkoUY24XrCi3Xh3
 ExRoY0fh70BcdJeZtD9AwYqUamb1El/TfKVcKGmZHUTN
X-Received: by 2002:a05:6402:1f49:b0:6a0:a560:1637 with SMTP id
 4fb4d7f45d1cf-6a0a7ca333fmr316838a12.14.1785517848048; Fri, 31 Jul 2026
 10:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-7-zhangckid@gmail.com>
 <87a4rkplof.fsf@pond.sub.org>
 <CAK3tnv+UMEsZTR12iY74sD42m5nNhYEtyF58QxVoG-JAeUZHcw@mail.gmail.com>
 <87cxw3aah5.fsf@pond.sub.org>
In-Reply-To: <87cxw3aah5.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 1 Aug 2026 01:10:35 +0800
X-Gm-Features: AUfX_mxelj1tlfoSBDBMGgbSqkLntbTD7kgHI1UM7NLr4NQkF7bPw9Fx0s-n9Iw
Message-ID: <CAK3tnv+g_m27CEj_PRUyHVsViZv74H+dtHmxw9yjEQqSVVuN-Q@mail.gmail.com>
Subject: Re: [RESEND PATCH V10 06/15] monitor: Update tracking iothread users
 with holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000012b73b0657eb454a"
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

--00000000000012b73b0657eb454a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026, 3:23=E2=80=AFPM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Tue, Jul 21, 2026 at 8:33=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Based on monitor QOM path tracking iothread users with holder.
> >> > Introduce the AioContext in the Monitor struct to avoid repeated
> calls to
> >> > iothread_get_aio_context() and ensure symmetrical ref/unref during
> >> > monitor lifecycle.
> >> >
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >>
> >> Why are repeated calls bad?
> >>
> >> How would symmetry be lost?
> >>
> >
> > OK, will add detailed comments like this in the next version:
> >
> > Avoid repeated calls: Under the holder tracking model, fetching the
> > AioContext increments the IOThread refcount and registers holder
> metadata.
> > Dynamically querying it in helper functions (e.g., suspend, BH
> scheduling)
> > leads to redundant refcount churn.
>
> Right here, we still have
>
>     AioContext *iothread_get_aio_context(IOThread *iothread)
>     {
>         return iothread->ctx;
>     }
>
> and complicating code to avoid additional calls feels dubious.
>
> PATCH 14 changes it to
>
>     AioContext *iothread_get_aio_context(IOThread *iothread,
>                                          const IOThreadHolder *holder)
>     {
>         /* Add IOThreadHolder to the list */
>         iothread_ref(iothread, holder);
>
>         return iothread->ctx;
>      }
>
> Are you making this change in preparation of PATCH 14?
>


Yes, following Stefan's earlier suggestion allows for lifecycle management
to be completed with minimal disruption.

Thanks
Chen


> > Ensure lifecycle symmetry: Storing AioContext in mon->ctx establishes a
> > strict 1-to-1 lifecycle pairing: a single
> iothread_ref_and_get_aio_context()
> > in monitor_complete() matched by a single iothread_put_aio_context()
> > in monitor_cleanup().
> >
> > Thanks
> > Chen
>
>

--00000000000012b73b0657eb454a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 31, 2026, 3:23=
=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armb=
ru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Zhang =
Chen &lt;<a href=3D"mailto:zhangckid@gmail.com" target=3D"_blank" rel=3D"no=
referrer">zhangckid@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Jul 21, 2026 at 8:33=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Zhang Chen &lt;<a href=3D"mailto:zhangckid@gmail.com" target=3D"_b=
lank" rel=3D"noreferrer">zhangckid@gmail.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Based on monitor QOM path tracking iothread users with holder=
.<br>
&gt;&gt; &gt; Introduce the AioContext in the Monitor struct to avoid repea=
ted calls to<br>
&gt;&gt; &gt; iothread_get_aio_context() and ensure symmetrical ref/unref d=
uring<br>
&gt;&gt; &gt; monitor lifecycle.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Zhang Chen &lt;<a href=3D"mailto:zhangckid@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">zhangckid@gmail.com</a>&gt;<br=
>
&gt;&gt;<br>
&gt;&gt; Why are repeated calls bad?<br>
&gt;&gt;<br>
&gt;&gt; How would symmetry be lost?<br>
&gt;&gt;<br>
&gt;<br>
&gt; OK, will add detailed comments like this in the next version:<br>
&gt;<br>
&gt; Avoid repeated calls: Under the holder tracking model, fetching the<br=
>
&gt; AioContext increments the IOThread refcount and registers holder metad=
ata.<br>
&gt; Dynamically querying it in helper functions (e.g., suspend, BH schedul=
ing)<br>
&gt; leads to redundant refcount churn.<br>
<br>
Right here, we still have<br>
<br>
=C2=A0 =C2=A0 AioContext *iothread_get_aio_context(IOThread *iothread)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return iothread-&gt;ctx;<br>
=C2=A0 =C2=A0 }<br>
<br>
and complicating code to avoid additional calls feels dubious.<br>
<br>
PATCH 14 changes it to<br>
<br>
=C2=A0 =C2=A0 AioContext *iothread_get_aio_context(IOThread *iothread,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nst IOThreadHolder *holder)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add IOThreadHolder to the list */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iothread_ref(iothread, holder);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return iothread-&gt;ctx;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
Are you making this change in preparation of PATCH 14?<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Yes, following Stefan&#39;s earlier suggestion allows for lifecycle =
management to be completed with minimal disruption.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Thanks</div><div dir=3D"auto">Chen</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Ensure lifecycle symmetry: Storing AioContext in mon-&gt;ctx establish=
es a<br>
&gt; strict 1-to-1 lifecycle pairing: a single iothread_ref_and_get_aio_con=
text()<br>
&gt; in monitor_complete() matched by a single iothread_put_aio_context()<b=
r>
&gt; in monitor_cleanup().<br>
&gt;<br>
&gt; Thanks<br>
&gt; Chen<br>
<br>
</blockquote></div></div></div>

--00000000000012b73b0657eb454a--

