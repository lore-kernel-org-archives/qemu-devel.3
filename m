Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B5FC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 22:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to8oN-0004dw-Eq; Fri, 28 Feb 2025 17:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1to8o8-0004ct-KK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 17:26:13 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1to8o3-0000sS-24
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 17:26:09 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86b3bd4d0faso954266241.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740781565; x=1741386365; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NrOy85b8Jb+3hQXd18r5ZDJw8If0ZhaCQRyEl8EnjsQ=;
 b=JjD4Z36N50Na3VElvwvWtABdqq71cDfPECJ1plB14JtLUtbQXwYlQQIYFKzcfm/lyY
 JAdrMLiIHwTO8kgprfbPRk7isjbiRkP+rqgA0Xh4s+zUxNYx2XOz6wTdm6Dbzt/Cilcr
 es6B3eVIV9CsKTOmIa9T6atBzOGCYfiyKMti/dLSnWZj3nmv3VpaQ7tJZybQZndErn2U
 6O18fsz4BaCEDOkDAV16ON33ej1SUsw6w+5VmoWdAIdkTwdkvD+s7IF+zzxctF7tu2D1
 aSSaWdsPJ6aHwGEGoxXrE3zfUn5SI/ro06X0uvg5jq5XcEeeYMaXDu9VE8n7sIkKUvh9
 uBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740781565; x=1741386365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrOy85b8Jb+3hQXd18r5ZDJw8If0ZhaCQRyEl8EnjsQ=;
 b=gd/LnFs8Y1YwYrgyI89UJ9R3cD2keYkjdwZQQq3+b83Po3YqLKgXVocT+KUWqeIUpM
 nBBIb3CyOmPfxa3WN1MOOQRVoLFPE58pvHv2gbNXEK96N2Ymp6qokoURk+8J0rDa2jRo
 /H5/XmvFA9wTOEchepLN6J/v1dtYTVEl8jctOwAPAEAax5AXZlq5nzO6ttocZzZv1mQL
 r8/UP3sZ+7gQDg4EI58Ta85CxQerizBdaZbpZESXhHznXM/NcbKNV8IGIoJvWLsndeqw
 d/rmU1suqLMuYVFjwZchh8GdPaLp/CDP8l0gQTXNv9R/FjU8aUhWmHUukwSEugs9w07Q
 mNhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo8w2oY39YspjDoN29Lga6NuSPHMXpD+Jo0hqTN03GMoW4QltYTqVkt7An95PJA6oGX80zKXv8AimH@nongnu.org
X-Gm-Message-State: AOJu0Yy8zibk2rvTv6NItjoEVHscqds7ItL2rtqPtcUtee025xm3+AhA
 ftqQG12GrOUZqRRhb39z5SdYlwUERE84iIUvEEe+Q7bnyuJ3B+Ye+jizT8bsLHLU+rPi4WezLwc
 3VJ6ax7uXfbsyN+QQieK3es9c5vierSg0zHWO
X-Gm-Gg: ASbGncuxNocSQpxH8Vq7oK6Bo53oQtntUGzJLkWajKj9cyWKF5h7Z8wRW/nXWc6gW/l
 bt5+U6NutaX7IcP5EKgGBCF2ju8swYL6HR3HNPPX9vmDVrsyw/sUVdJsuZBO9omdRJms5c/5SDf
 0z9fm4hABRuMsj0YgFbE5RN8V34iwO/13i6iU+GCw6oKj1ibIZa7RloVng
X-Google-Smtp-Source: AGHT+IF5e4AzmtKmOkB5MLffJGDQyzlDib7DFrzV22RCyhQmqFZfnaF5Vap2nT0pktgiX9iYJB3Zc00tePkHknwMAwE=
X-Received: by 2002:a05:6102:4691:b0:4bb:bf49:9076 with SMTP id
 ada2fe7eead31-4c044859411mr4814254137.2.1740781565382; Fri, 28 Feb 2025
 14:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20250228212329.1775669-1-venture@google.com>
 <7771abbe-ab3f-43d8-9ac6-9ea0bc63b243@linaro.org>
In-Reply-To: <7771abbe-ab3f-43d8-9ac6-9ea0bc63b243@linaro.org>
From: Patrick Venture <venture@google.com>
Date: Fri, 28 Feb 2025 14:25:52 -0800
X-Gm-Features: AQ5f1JqvdGAj7ImVeL7cEHSVGiHesOc0qYTfwwwjluLY-4P2Xv1ilpZ9WO-Ydf8
Message-ID: <CAO=notwzQsC7oJZxY_Jby9znX0ov62AVXsTENb7tagEBR2DcWQ@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: fix msan findings in translate-all
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, 
 Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="000000000000d6a88c062f3b4a7b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=venture@google.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000d6a88c062f3b4a7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:38=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/28/25 13:23, Patrick Venture wrote:
> > From: Peter Foley <pefoley@google.com>
> >
> > e.g.
> >    Uninitialized value was created by an allocation of 'host_pc' in the
> stack frame
> >    #0 0xaaaac07df87c in tb_gen_code
> third_party/qemu/accel/tcg/translate-all.c:297:5
> >
> > Signed-off-by: Peter Foley <pefoley@google.com>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >   accel/tcg/translate-all.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index d4189c7386..f584055a15 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -298,7 +298,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
> >       tcg_insn_unit *gen_code_buf;
> >       int gen_code_size, search_size, max_insns;
> >       int64_t ti;
> > -    void *host_pc;
> > +    void *host_pc =3D NULL;
> >
> >       assert_memory_lock();
> >       qemu_thread_jit_write();
>
> False positive, because the error return exits without using the
> uninitialized value.
> But if we do want to "fix" this, do it at the beginning of
> get_page_addr_code_hostp.
>

Acknowledged.  Gotta hate false positives, although better aggressive than
not. Thanks!


>
> r~
>

--000000000000d6a88c062f3b4a7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28,=
 2025 at 1:38=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 2/28/25 13:23, Patrick V=
enture wrote:<br>
&gt; From: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" target=3D"=
_blank">pefoley@google.com</a>&gt;<br>
&gt; <br>
&gt; e.g.<br>
&gt;=C2=A0 =C2=A0 Uninitialized value was created by an allocation of &#39;=
host_pc&#39; in the stack frame<br>
&gt;=C2=A0 =C2=A0 #0 0xaaaac07df87c in tb_gen_code third_party/qemu/accel/t=
cg/translate-all.c:297:5<br>
&gt; <br>
&gt; Signed-off-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" t=
arget=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0accel/tcg/translate-all.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
&gt; index d4189c7386..f584055a15 100644<br>
&gt; --- a/accel/tcg/translate-all.c<br>
&gt; +++ b/accel/tcg/translate-all.c<br>
&gt; @@ -298,7 +298,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_insn_unit *gen_code_buf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int gen_code_size, search_size, max_insns;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t ti;<br>
&gt; -=C2=A0 =C2=A0 void *host_pc;<br>
&gt; +=C2=A0 =C2=A0 void *host_pc =3D NULL;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_memory_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_thread_jit_write();<br>
<br>
False positive, because the error return exits without using the uninitiali=
zed value.<br>
But if we do want to &quot;fix&quot; this, do it at the beginning of get_pa=
ge_addr_code_hostp.<br></blockquote><div><br></div><div>Acknowledged.=C2=A0=
 Gotta hate false positives, although better aggressive than not. Thanks!</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
</blockquote></div></div>

--000000000000d6a88c062f3b4a7b--

