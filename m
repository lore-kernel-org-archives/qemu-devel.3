Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495DECD9B5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 23:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo8gc-0003x1-BV; Thu, 05 Feb 2026 18:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vo8ga-0003wt-M1
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 18:22:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vo8gY-0004XH-Sk
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 18:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770333772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRHj1SvQDtOvOuArJO7jd2129JpM4HdXRvRNkRjhPNk=;
 b=gqSGjqlpjPl4CruiejeXDOxBlSrjGb0uUjef3WrPIOZG+rlwZgZaxsuEHGrzWu3ewnjM3s
 IGLZLhqdystspwrYg0bb9BKFD5aEhMZPo7JlBa5GbGa/4akn/F1NRTt+eozPaNcSxTs2MH
 QPFUT0mfX1+h6rF3nzRG4NjGRFKLPFI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-oGBAeMoxPsuS-X7mDMMb3A-1; Thu, 05 Feb 2026 18:22:50 -0500
X-MC-Unique: oGBAeMoxPsuS-X7mDMMb3A-1
X-Mimecast-MFC-AGG-ID: oGBAeMoxPsuS-X7mDMMb3A_1770333769
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435a11575ecso1278480f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 15:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770333769; cv=none;
 d=google.com; s=arc-20240605;
 b=hRA5wPNLOKntwv493dRmcaqfl7FWSuNOFxyOKzVBpVazbpunPqx9VxeeWyFbFuhtzB
 +RE5JVK/Hfe/po6OA8nWQpLuV2mkhb8cVzWV826scjqQ5i+zy8R1pGq+97Geh2OUHsUf
 J2BJKoCeVGciomENn5ZowZ05B/Iwlz13KSt+CIqS0xQxy4mp/Y0qp8IGvB627s8P6huO
 tHJGKGbKxKcSnU4MzVqViZAt62TxyFXwFcsZnMUty7JD4xm3ZtVeRgLqHYWEFOq8Vnk2
 tVG9HbxfLZdqcx5SD27g/ZE+kDrbchRknbYoVsoPSENLxskDjqgm/m9Qy0OeNt80txu+
 Cqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mRHj1SvQDtOvOuArJO7jd2129JpM4HdXRvRNkRjhPNk=;
 fh=w72gMzNHx+rOQeSQN99Ghrv1qiAWz3alirFKmSMpZ9U=;
 b=W3wgUeXVzqqPYvi6+ieHQygSN1YrleSGWm7LKTpVUefr7j8AUbsGAKcbcROCpAfeCM
 NQj0mqEBS5n2lW8Rl50WijIi8NPn6KeDI+ZKoJ3qaoD0cgo4l971gRJ1JxgEc5mRCm7Q
 qr2gNlhbzcgDCkTUFArVld7wzOiRHtli0TYX60OJHxHyAzY7kTJ2/jc0eLtqt5vs0PBx
 Z3ZKvur9q+elGnrFAUTPDHbK6AgKtZ+CjjB/LHytB6Io0DW6YgT5+RqwOOdu3WqQM1ls
 +Dm1+ePx9k5/nBEQU8lR6xEaqcFY8GzvXspzwgqijDs3jvd2u5/eTUy6/wtSwcy88PCl
 TiPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770333769; x=1770938569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mRHj1SvQDtOvOuArJO7jd2129JpM4HdXRvRNkRjhPNk=;
 b=cW0uxVASRI8zGpZ9Jo2RkK1Qj0PcAJQ1AfSDr8JRIbvjHBzGKXobNpEiwS4hBYeCrR
 E5rDtictlYy2NSonuouSubDsndear878ZmgdBpdMZLAjUkGlV69Jb5DIpxLcZ+BoTRHS
 7xfrXISzuvQqrwemkn8MtrV8L0knnQHaX29v8p3ONo72cRv7FBLHND1ZObARoUO/PSL2
 e2xM24p18W9VM4mqSTeQqyVLu+KlBPLzbv4dl/DmcpmS8SPheQDVoaSjZ28fN6uVKyI3
 UuNxa3cz7xszsunbg9AbRmqlQYKxp/T7GfWYswnIkg41QQh3g857fJYIJfeaX8CSHEwR
 T2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770333769; x=1770938569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRHj1SvQDtOvOuArJO7jd2129JpM4HdXRvRNkRjhPNk=;
 b=m9v15GtRlbq7F3gtJQU3xM/9+Lkvl1XQqmu3G5OHoSy3vutFtpTCd8YO7xS2N6mIRh
 t91focE3MQWr95VBP4wWR2bo1wnK18yi4GQ2KQQckHbvKW3IDIgUUzrS5Z3c0Wx5WSEM
 gMeC3xgMD+mGQvTarW5V+eu3yb5ixcLNWx59HqZRxh27A91WTh9oaxIuBDGcwMYowSDw
 g+BOl2dmkCnFd+qe6vD3RBLHhshYkcGteg5YGMItpfCSXqBnkqmzw3q+zs1CTwyqLrty
 KQvsSv4WQ2FyLh0n1nKsZCts8jZneNqT52f9qj6aiekq21+6Ip55QOM9wZxN43GCXzfK
 sumw==
X-Gm-Message-State: AOJu0Yw+Qk4A92zPYvKtv+xgigfqLKIKbWpxpyTNka+/s8Yw8EYmo3Ja
 2eXxEq/tuJ8RUl0sHB1xtMvJ5DgxzclorzAZGzzTrJacjM7iWHxZvi3HmTezkIXV7iv4CVvfIGq
 6/UFjjTgfOPalES/dMKWtUNwsCgWdQln9Oqs++p3q1rwW1D+WOGOhuULDaznNJ1zLVH4Yi6rwO9
 UDdDyippA9IFF6Vr3pxAu+XB0HgzYG5BFVbGrtvgU=
X-Gm-Gg: AZuq6aJvkTP/pKV7XJxzDkPMvqlJD1tIxRxBMABdecxWDxpTRaclQXCplgPZh0K8BZz
 NpI7IAWMHsiZchmyVa8qLlmLsd4ZGAM7/jQH0DhdYvcSy2P6jL5N6KkmcBoROSqCLs0EXdDl8PM
 4NRgXAIWnNgMhgmvWvAIQZU5nbQFxPDsLngPJnAV87C5bU1uCojxaKno3Nbls1CJM89ORSD43gv
 9TR7MPORI8d0cXVbovQEi5LPvOXjgCKxDcG/tC/AGsYnI6j3ey0VMOS4WSdp5DXTW43Fg==
X-Received: by 2002:a05:6000:22c6:b0:435:9882:234e with SMTP id
 ffacd0b85a97d-4362938ff1emr1236623f8f.59.1770333768751; 
 Thu, 05 Feb 2026 15:22:48 -0800 (PST)
X-Received: by 2002:a05:6000:22c6:b0:435:9882:234e with SMTP id
 ffacd0b85a97d-4362938ff1emr1236611f8f.59.1770333768372; Thu, 05 Feb 2026
 15:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
 <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
 <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
 <CABgObfb3zP3TYCz04Rmg+2HZbXZjKFvuACqznJm56ET9NhBhzw@mail.gmail.com>
 <5c46d3a3-e046-46a1-ac5c-5588a2179441@linaro.org>
 <CABgObfZArFHKHjwbWBmWP09OegtfiCpAQuQLtSrWax0tzc_hSA@mail.gmail.com>
 <c2cb0273-de90-439b-9058-c4b57df86fce@linaro.org>
In-Reply-To: <c2cb0273-de90-439b-9058-c4b57df86fce@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Feb 2026 00:22:36 +0100
X-Gm-Features: AZwV_QjxedeNfu7AOlUQ3GebyZLrWQgau44TEUZacnmk1U3sRUhG1C-QPaNE4ME
Message-ID: <CABgObfbBGw77LDuirj1xWVaecEv6oSOZVY7gY1R8FURiK8+_Wg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000065ef29064a1bf397"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--00000000000065ef29064a1bf397
Content-Type: text/plain; charset="UTF-8"

Il gio 5 feb 2026, 23:29 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> >      > I think it would be better to pick a canonical form for AND with
> 2^n-1 and handle
> >      > conversion to extract (like PPC rotates or movz) in the backend.
> >      >
> >      > Picking AND as the canonical form also avoids makes the macros
> for extract validity
> >      > simpler too; adding an extra constraint for immediate 2^n-1 is
> easier and it
> >     generalizes
> >      > to other PPC rotate and mask cases.
> >
> >     Picking AND means we have to use "r,0,ri" for x86, losing register
> allocation flexibility.
> >
> >
> > Then could you wrap the target specific extract_valid with one that
> allows ofs == 0 if AND
> > allows the immediate 2^len-1? That would also simplify this series.
>
> I don't understand your suggestion here.
>

I am not sure about it either... I am just not sure why extract is
guaranteed to be cheaper or have better constraints than AND.

It does happen to be true for x86, though only for len == 8 or 16; but is
it true of all targets that have a more expansive extract instruction?

Paolo



>
> r~
>
>

--00000000000065ef29064a1bf397
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 5 feb 2026, 23:29 Richard=
 Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hend=
erson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I think it would be bett=
er to pick a canonical form for AND with 2^n-1 and handle<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; conversion to extract (like PPC rotates or mo=
vz) in the backend.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Picking AND as the canonical form also avoids=
 makes the macros for extract validity<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; simpler too; adding an extra constraint for i=
mmediate 2^n-1 is easier and it<br>
&gt;=C2=A0 =C2=A0 =C2=A0generalizes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to other PPC rotate and mask cases.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Picking AND means we have to use &quot;r,0,ri&quot;=
 for x86, losing register allocation flexibility.<br>
&gt; <br>
&gt; <br>
&gt; Then could you wrap the target specific extract_valid with one that al=
lows ofs =3D=3D 0 if AND <br>
&gt; allows the immediate 2^len-1? That would also simplify this series.<br=
>
<br>
I don&#39;t understand your suggestion here.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">I am not sure about it either..=
. I am just not sure why extract is guaranteed to be cheaper or have better=
 constraints than AND.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I=
t does happen to be true for x86, though only for len =3D=3D 8 or 16; but i=
s it true of all targets that have a more expansive extract instruction?</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--00000000000065ef29064a1bf397--


