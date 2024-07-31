Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F43C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 23:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZIMT-0004AH-GR; Wed, 31 Jul 2024 19:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZIMS-00049a-8b
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 19:04:00 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZIMQ-0000ZB-8o
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 19:04:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cfcbdfa572so1797478a91.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722467036; x=1723071836;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F9PF3H9qAIqz5RTX/nfsUw7m/xFoqiQdS9dX1qvBTuY=;
 b=qrDzX73W14pWU8EkCQVaAcjgv1T1OSXPt4ghfgVlDPkfqYXC4IAbdx1nsO5GCxl7yi
 QA3/Sc9ahUQL4gKBr5QHPkqx2dF9NmWWMNWO2GAR2V4rD7px0gFs99dOOp10PS1QfgC8
 FXVIgR7VJuxx5OZiSfL12tWUZRbwj5ex+GHh+4jQZRvJSXXWbZSVeB91XNsvOxvzVDz9
 HvAkZmoMnapXZzYz+f3SWwAMYHDusk3osd3f8IDNQaDbXy/dirdxZUUwkgx7dH1pM2jV
 R1FRmc48gRazf0bQ27INIG0GGvfzVTcgYTkQ39ZgvPIfLuU3/jjkrlEMpff/MzXBaYdW
 t48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722467036; x=1723071836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9PF3H9qAIqz5RTX/nfsUw7m/xFoqiQdS9dX1qvBTuY=;
 b=Em0OIvvKdvLlpjBeVlmzvJrHltyRkdXZ6fqJoZ0DxX3QWnuvPHcDNdnq8aEA8SyjC8
 wyDj9NQe82C96WlfYRYqpHXUbEnfd7Si8fpO74y4H8/DI4uxDzAzFoWWjRaUD47H0Ofz
 yHqDV1DL5pP4tYGWAe1UDN+P61Ha0V9kW2vMvhyuGA2rmseAc6DrKWbasdM08GwOMgMv
 6BnYWzAo8BqZyko23Og9lq9/wDzP+mEJqVWoTzIFRWYqDgqrfgTJ8y9e/ZFR3j318B0Z
 EUWe3Z0nckqT/FG1SAByNDKWo4Zx05+w73pUYLgm5Lc9Htp6G21yz15TPB4Uwj9Dsh8q
 J+8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcbp1OJybCjMS+m8z7AJqzMMjPF62jky659O7aJLp5TMboDGk0PtOJ7arCgyHGDD8XLfr2IIfju0ODOCFnJ/a21ItccBI=
X-Gm-Message-State: AOJu0YyriD51RWW5lcX5oq7OMLzOmJxS8CFYxF19gIicK7XFdBjcRUHT
 NFyr1DbJHt+s3zxNFfclASgTX5tvQ4oy2FQlsbZaB+2hiuVI3dbXTX1iuLmf2+kLF9fAErxAR/q
 ngB3inmmFRzsM0QbiKlCp4wk8j38gNvUse9D/SA==
X-Google-Smtp-Source: AGHT+IGbGTVfb+ktd08yIGatSz2Bcu5bblH82PGt/NET+73ahgGm3JfNMQrt1bjBhE3CCvIbvastkCQKxpCPLJdLy/Q=
X-Received: by 2002:a17:90b:1c03:b0:2cb:5654:8367 with SMTP id
 98e67ed59e1d1-2cfe7b2771dmr880351a91.26.1722467036452; Wed, 31 Jul 2024
 16:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240731144428.5882-1-iii@linux.ibm.com>
 <7c0af87c-466b-4dba-a132-b14c8d262fd4@linaro.org>
In-Reply-To: <7c0af87c-466b-4dba-a132-b14c8d262fd4@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 31 Jul 2024 17:03:45 -0600
Message-ID: <CANCZdfrdXguv_Ynm24dW4d_LY1kDEbHGwQhADFjuPrEuRSiF3w@mail.gmail.com>
Subject: Re: [PATCH] bsd-user/x86_64/target_arch_thread.h: Align stack
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d87547061e931b7a"
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000d87547061e931b7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmmm... All platforms likely need this....
Oh, they all have it except x86, both 32 and 64-bit.... but i386 is already
properly aligned (at least in the
FreeBSD kernel), so maybe that's not needed.


On Wed, Jul 31, 2024 at 4:43=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/1/24 00:44, Ilya Leoshkevich wrote:
> > bsd-user qemu-x86_64 almost immediately dies with:
> >
> >      qemu: 0x4002201a68: unhandled CPU exception 0xd - aborting
> >
> > on FreeBSD 14.1-RELEASE. This is an instruction that requires
> > alignment:
> >
> >      (gdb) x/i 0x4002201a68
> >         0x4002201a68:        movaps %xmm0,-0x40(%rbp)
> >
> > and the argument is not aligned:
> >
> >      (gdb) p/x env->regs[5]
> >      $1 =3D 0x822443b58
> >
> > A quick experiment shows that the userspace entry point expects
> > misaligned rsp:
> >
> >      (gdb) starti
> >      (gdb) p/x $rsp
> >      $1 =3D 0x7fffffffeaa8
> >
> > Emulate this behavior in bsd-user.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   bsd-user/x86_64/target_arch_thread.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/bsd-user/x86_64/target_arch_thread.h
> b/bsd-user/x86_64/target_arch_thread.h
> > index 52c28906d6d..25233443c14 100644
> > --- a/bsd-user/x86_64/target_arch_thread.h
> > +++ b/bsd-user/x86_64/target_arch_thread.h
> > @@ -31,7 +31,7 @@ static inline void target_thread_init(struct
> target_pt_regs *regs,
> >       struct image_info *infop)
> >   {
> >       regs->rax =3D 0;
> > -    regs->rsp =3D infop->start_stack;
> > +    regs->rsp =3D (infop->start_stack & ~0xfUL) - 8;
>
> The formula in sys/amd64/amd64/exec_machdep.c, exec_setregs is
>
>    ((stack - 8) & ~0xful) + 8
>
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Agreed.

Reviewed-by: Warner Losh <imp@bsdimp.com>

There's a *lot* that's missing on for amd64 emulation relative to the other
platforms.

Warner

--000000000000d87547061e931b7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hmmm... All platforms likely need this...=
.<div>Oh, they all have it except x86, both 32 and 64-bit.... but i386 is a=
lready properly aligned (at least in the</div><div>FreeBSD kernel), so mayb=
e that&#39;s not needed.</div><div><br></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 31, 2024 at 4:43=
=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linar=
o.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On 8/1/24 00:44, Ilya Leoshkevich wrote:=
<br>
&gt; bsd-user qemu-x86_64 almost immediately dies with:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu: 0x4002201a68: unhandled CPU exception 0xd - =
aborting<br>
&gt; <br>
&gt; on FreeBSD 14.1-RELEASE. This is an instruction that requires<br>
&gt; alignment:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 (gdb) x/i 0x4002201a68<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4002201a68:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 movaps %xmm0,-0x40(%rbp)<br>
&gt; <br>
&gt; and the argument is not aligned:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 (gdb) p/x env-&gt;regs[5]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 $1 =3D 0x822443b58<br>
&gt; <br>
&gt; A quick experiment shows that the userspace entry point expects<br>
&gt; misaligned rsp:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 (gdb) starti<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (gdb) p/x $rsp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 $1 =3D 0x7fffffffeaa8<br>
&gt; <br>
&gt; Emulate this behavior in bsd-user.<br>
&gt; <br>
&gt; Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.co=
m" target=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/x86_64/target_arch_thread.h | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_thread.h b/bsd-user/x86_64/ta=
rget_arch_thread.h<br>
&gt; index 52c28906d6d..25233443c14 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_thread.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_thread.h<br>
&gt; @@ -31,7 +31,7 @@ static inline void target_thread_init(struct target_=
pt_regs *regs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct image_info *infop)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0regs-&gt;rax =3D 0;<br>
&gt; -=C2=A0 =C2=A0 regs-&gt;rsp =3D infop-&gt;start_stack;<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;rsp =3D (infop-&gt;start_stack &amp; ~0xfUL) -=
 8;<br>
<br>
The formula in sys/amd64/amd64/exec_machdep.c, exec_setregs is<br>
<br>
=C2=A0 =C2=A0((stack - 8) &amp; ~0xful) + 8<br>
<br>
With that,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockqu=
ote><div><br></div><div>Agreed.</div><div><br></div><div>Reviewed-by: Warne=
r Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;=C2=A0</=
div><div><br></div><div>There&#39;s a *lot* that&#39;s missing on for amd64=
 emulation relative to the other platforms.</div><div><br></div><div>Warner=
</div></div></div>

--000000000000d87547061e931b7a--

