Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD4FE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqNN-0002HA-I0; Sun, 15 Dec 2024 10:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMqNM-0002Gm-Jz
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:17:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMqNL-0005Ar-3U
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734275862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoOeSHk01gUgu1TNmVkgXOJaH51dfBUuz6nP+GNP8mw=;
 b=Wj9J2eJF6SjaJFaNPdU/bZK40E/rpVe1F6V1C4D1E8ZIFDksajIcL68tHA7Ru4tXhUHOXY
 AtSVyrYqaXVTDgrqy0SjJ6SbkrhBn43YI3JgD48Toz3DfNhxXdFLlAfkWNTurY9TVsmQI5
 saRx24MaNJc+oh1Hb3s04Clghr8L0S0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-n4iub9zwO8GY007_DRziow-1; Sun, 15 Dec 2024 10:17:40 -0500
X-MC-Unique: n4iub9zwO8GY007_DRziow-1
X-Mimecast-MFC-AGG-ID: n4iub9zwO8GY007_DRziow
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38629a685fdso721150f8f.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734275859; x=1734880659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoOeSHk01gUgu1TNmVkgXOJaH51dfBUuz6nP+GNP8mw=;
 b=cAlKYiRC+hIQ4Gj2UQ16fKdKDZLpurDKnf0OCJ6vClQPkMDRFcVlpOlg9JOGIwblM0
 5nILoe6fNGAhiKKJUUVsSUuZ5e4dedo5VdQN33zfPlzg7ks12mel0PUgxs9GSyOtG5fs
 EGZkugrZOeOP1WUfWlQjmIABysEn1XL911eBsZXSz4y4hM0QfXpQChMpGQOEsrL6K9pb
 Aa6zJNx1Fyh9ZLb3qyD3Av6X6PGGVVYBUGygbLUGtlEYUxsf7P4IsrmcAEafpbruocFD
 t9uQpt7Mto8cYYHk/OsjPZ0hGEzmv68NmeTL0rW9agoMr2ARf9mAV6veTpjNRrX0TLMO
 b75A==
X-Gm-Message-State: AOJu0YwhI6G1CK7rmSYlPbDW6PmaF2K0oFYPmlbrw7+Vjbiw0zUZ5qTJ
 DhhjOnW0PLDf26ZH6SYpUH1cER2zLGpxMhNTJ9qO8lpcg0IwHEECdB/huC6cubn5ls+oKqMpsBH
 gO6cog2k+MdJcr9Ujbf7sioZJYL3yRLs+Leel3D5fThJMSfdfJvKidWaPVnhi42QuuzzWMWgtyl
 NO7piRXt/FZkGCpJ4jZAxZip+8hSs=
X-Gm-Gg: ASbGnctCCeUUFwc6tD2WBuyJa6KFwHMeEqxHJZgzTrsI6TedMwitN+XS5FtO88GXbgn
 Oe8sK4zuMVLgzUDWxgQJJFUTr8JLKWqMCMgFO
X-Received: by 2002:a05:6000:4b12:b0:385:edb7:69ba with SMTP id
 ffacd0b85a97d-38880ac5f25mr8916373f8f.1.1734275859209; 
 Sun, 15 Dec 2024 07:17:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh+AqXUakHp1bpVuFdFw6iOK1yq9n5rJI1hqDGWdL3pMELzLZO+Sx6nxiYL6Lx7MpsurHdVnsuQ4cEAYThPhk=
X-Received: by 2002:a05:6000:4b12:b0:385:edb7:69ba with SMTP id
 ffacd0b85a97d-38880ac5f25mr8916362f8f.1.1734275858853; Sun, 15 Dec 2024
 07:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-12-pbonzini@redhat.com>
 <376ee81c-6465-4592-b4f8-9beec26199dd@linaro.org>
In-Reply-To: <376ee81c-6465-4592-b4f8-9beec26199dd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 15 Dec 2024 16:17:27 +0100
Message-ID: <CABgObfY9idHAZzBB7AXkQgbd4O04bk6G6SR7N+qyEXLFekqyLQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] target/i386: execute multiple REP/REPZ iterations
 without leaving TB
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000082981c0629509098"
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

--00000000000082981c0629509098
Content-Type: text/plain; charset="UTF-8"

Il dom 15 dic 2024, 16:07 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> > @@ -1384,6 +1409,12 @@ static void do_gen_rep(DisasContext *s, MemOp ot,

>           gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
> >       }
> >
> > +    if (can_loop) {
> > +        tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX], 1);
>
> Since we've just written back cx_next to ECX, this is the same as cx_next
> -= 1, yes?
>

Yeah, I wanted to make cx_next die at the assignment to ECX but it probably
does not make a difference to generated code.

Paolo

>
>
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
>

--00000000000082981c0629509098
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 15 dic 2024, 16:07 Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">&gt; @@ -1384,6 +1409,12 @@ static void do_gen_rep(Di=
sasContext *s, MemOp ot,</blockquote></div></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_jcc_noeob(s, (JCC_Z &lt;&l=
t; 1) | (nz ^ 1), done);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (can_loop) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX],=
 1);<br>
<br>
Since we&#39;ve just written back cx_next to ECX, this is the same as cx_ne=
xt -=3D 1, yes?<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Yeah, I wanted to make cx_next die at the assignment to ECX =
but it probably does not make a difference to generated code.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><d=
iv class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
<br>
Anyway,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org</=
a>&gt;<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--00000000000082981c0629509098--


