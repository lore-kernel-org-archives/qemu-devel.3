Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29C9C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ps2-0003Zz-6M; Fri, 18 Sep 2026 00:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Ps0-0003Zq-4g
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:06:40 -0400
Received: from mail-ej2-x0d.google.com ([2a00:1450:4864:34::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Pry-0002KR-0d
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:06:39 -0400
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c254fa663bfso46322266b.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789704395; cv=none;
 d=google.com; s=arc-20260327;
 b=s0L7fVXd+aSi+QJa5adwvE/6SXioG926gvsuT2TgbFjwNqkZ3aUX6hy+//xlV080I+
 UXpK+kkArogRmjD+ncfcgGi+tSSi4stSeHrZ2E0xHttfrwE+wI0BC7w2gDRqgLs3zJRm
 osOB0oe46Jb98K9BJYQlaQArx4EebI7CwXjQ7CfMiF/OA2jOfbGanmoR8xQ8OaRgRx5k
 asiL3dKUG4i4awaLMohkB/AhBtcmzxiYxQDePj7g4o6UtQD+j7sLvmXvQSJDwUo0KyGM
 1iDDAWFqYhkuv7G1oKrZa2R9rtepZ1xdzDI0uHi4bkIXONdTXuEVlnDJscsnBc2rX3Pc
 JE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2kZur4HzKgdFSE/yq5D3FMiXanB8HmvurtaS3buesjs=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=aHhcOPbNld6U0vLPCrQT8al/D4KeYe3Zqsd8+zGs5ufjrsD+icQk71xyB5i+wP9Atn
 slssBg6P3ckZHjph8a6XC+OfyqPhkB0XIBgn5zqM5kPY8evTyK/e75NMljcS89xsCusS
 DpYLPvW8FuBl/OpnuX7AI8dALoYF2B3rut4pX6EpziyO0Fpw64YIOLkawYBlIPVRvxrb
 lE9qjONXkBrFNB8iPTWu79Hqs5hbVJX7KCyr2W5C793+KJ6UdHGfbMnVv1f9U27Lx9cR
 OmKvfQOehYeO+jA0EHnRBUjqCJyBI2sglewuRVaRx5lscX6t90hZO+BQzkxGd7XTA4ja
 FVJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789704395; x=1790309195; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2kZur4HzKgdFSE/yq5D3FMiXanB8HmvurtaS3buesjs=;
 b=hdVNNXsb5xrC2YuchkJIm80O3VdpClgoNvDqKuGFU4nHJsR4x8RhlQwygdXiq7uru8
 AF0KPbTB9BlO/PTtX0OlN+oLTI1rh99cXqBC4HcBirYNY7Vq/Q6hmKfVxIg4rxZ1Bp7Z
 CTjUPIYF1M0nyb4kD3gVfwK/KC91Pz/lWUid2pZpQd1j8m00dVJT14htNuUREW7VwmJq
 4imbqJGiK9SpZxksNoJvGynhJU3gfAn8szpWQx5c23c5I/HXt78HCGugdZBGoB1mYo84
 r3AE1Xk7t54UwDOf4rRqi8cv+W85Pg+jRw5G6VbEd4AgmA+YHR390Z2Ya6g2y4ygfISP
 bL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789704395; x=1790309195;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2kZur4HzKgdFSE/yq5D3FMiXanB8HmvurtaS3buesjs=;
 b=hKssSM/xD4IvBHfZARDVHNRWCWyssiDGLmdG1EFHeIMF0vEY+//4kF8jrR2sE9lE0M
 UzdDOr05b7QEHBBHTCuUufM4SDfhhQ0SG34QZ4ZIUxXxjkV/jv1bs5VFSbt2/6a3UyMW
 1fVr0d+c3Etjc8jLpiOTids8xT6gkUTY8zFZCh9foPMNz/nKwZI6kSGTT1enc1ZGhrxJ
 35+KKOXu27tlSkP9A8ZGnATPOR5ogl7OOEkWeanvrTed+sPXERe3vCUgcrS9kHKyEywe
 L2fDAx3Gc13QZkF9bKE4KHRcIEuhg+OIAu2xr5AbDeVFbssUAOmAMvnCihe7jSusQm6w
 P/DQ==
X-Gm-Message-State: AFuF++lhMfma56c1IwLVFsam3olAGYHyZc03KhndlXW96Eet5dfbAKq+
 yDroO9F/MnLsU/ohzqX3grRjOwIbOHVB7n0fRieIb3jE7BgWg3hmH/z8VLeOxxBX9U8R/9wM753
 BbSVB/5dOkXOQQTyHJvYu5URIdVS9RMA=
X-Gm-Gg: AYBFou24vP9YTIuRk2fpSXF18Yffc5ELC9VZqUMJPpOfM/V4Il69YWFEZFZHPz8eUTG
 kriluuBNyawxlJfeCj4GouOZOz5jLuPL1uFO8HoeE8Q1sY4WriZx5nLyVQe6tC7uI/u1leVrov1
 D5aBrv58nOZle2nrGIli2r4j+dOZPv1LN+0mQSvUgX70fPlc5kAvPqbWnCMjq807ZXAEVDx/59G
 5Qwq3AE7RWdBma5RSMZ2czEyCTqqmC61i6SSXEhpieoaSToGs106Fx8jM4Lrgt8LNrIsQG6T+pI
 C/5RA2cTR9uwLucgtuppqQ1NRh+33eaWyqJVL6K1NpohRADEUqy3jlaNWPkig8abng==
X-Received: by 2002:a17:907:1c91:b0:c29:f5d5:5a9f with SMTP id
 a640c23a62f3a-c2a158b4b8dmr123440966b.41.1789704395505; Thu, 17 Sep 2026
 21:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-4-luoyonggang@gmail.com>
 <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
In-Reply-To: <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2026 12:06:20 +0800
X-Gm-Features: AcwNN1Wa6ca_YpkEjj8Y2AMZMuNzzw0mFBQ06T6KzJ3Nu7LLg3qsBx7ozeUf6eQ
Message-ID: <CAE2XoE8X8cAS0CsQ52pgBXsrbND14bL03SehRnx64tCGSOxrWw@mail.gmail.com>
Subject: Re: [PATCH 03/21] accel/tcg: add helper raise_excp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bf4387065bba0605"
Received-SPF: pass client-ip=2a00:1450:4864:34::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000bf4387065bba0605
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:01=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:
>
> On 9/17/26 14:42, Yonggang Luo wrote:
> > Add TCG raise_excp (env, exception, restore) that exits with GETPC()
> > or 0 via cpu_loop_exit_excp.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   accel/tcg/tcg-runtime.c |  6 ++++++
> >   accel/tcg/tcg-runtime.h | 11 +++++++++++
> >   2 files changed, 17 insertions(+)
> >
> > diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> > index 7c0aab98a80..ae93765b09e 100644
> > --- a/accel/tcg/tcg-runtime.c
> > +++ b/accel/tcg/tcg-runtime.c
> > @@ -130,6 +130,12 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
> >       return ctpop64(arg);
> >   }
> >
> > +void HELPER(raise_excp)(CPUArchState *env, uint32_t exception,
> > +                        uint32_t restore)
> > +{
> > +    cpu_loop_exit_excp(env_cpu(env), exception, restore ? GETPC() : 0)=
;
> > +}
> > +
> >   void HELPER(exit_atomic)(CPUArchState *env)
> >   {
> >       cpu_loop_exit_atomic(env_cpu(env), GETPC());
> > diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> > index 0b832176b33..036a33d566b 100644
> > --- a/accel/tcg/tcg-runtime.h
> > +++ b/accel/tcg/tcg-runtime.h
> > @@ -22,6 +22,17 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE,
i64, i64)
> >
> >   DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
> >
> > +/**
> > + * raise_excp:
> > + * @arg1: env -- CPU env
> > + * @arg2: exception -- EXCP_* or target trap number
> > + * @arg3: restore -- 0 skip unwind, 1 use GETPC()
> > + *
> > + * Shared TCG exception raise. Translate calls gen_helper_raise_excp.
> > + * Exits via cpu_loop_exit_excp.
> > + */
> > +DEF_HELPER_FLAGS_3(raise_excp, TCG_CALL_NO_WG, noreturn, env, i32, i32=
)
> > +
> >   DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
> >
> >   #ifndef IN_HELPER_PROTO
>
> (1) Put the comment before the implementation, not the header.
> That avoids whatever you're concerned about vs patch 2.

Indeed I tried, and I found basically all tcg's gen_ function have no
comment(detect by the auto-tools),
and it's parameter arg0 arg1 arg2 that can not understand at all; and can
not link to the impl
helper_* that defined as HELPEP(X) that makes me reading the tcg code very
hard.

>
> (2) Don't pass an extra argument that changes behavior like this.
> Better to have two separate functions, each doing one thing.

how about gen_helper_raise_excp and gen_helper_raise_excp_restore

>
> (3) Maybe better to place the functions in cpu-exec-common.c, so that
> the compiler can see all the definitions at once.
>
>

Do you mean do not use  DEF_HELPER_FLAGS_3 at all? directly decl and imp in
cpu-loop.h and cpu-exec-common.c

If this is allowed, then (1) won't be a issue




--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000bf4387065bba0605
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br><br>On Fri, Sep 18, =
2026 at 9:01=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt; w=
rote:<br>&gt;<br>&gt; On 9/17/26 14:42, Yonggang Luo wrote:<br>&gt; &gt; Ad=
d TCG raise_excp (env, exception, restore) that exits with GETPC()<br>&gt; =
&gt; or 0 via cpu_loop_exit_excp.<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: =
Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank"=
>luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0 accel/t=
cg/tcg-runtime.c | =C2=A06 ++++++<br>&gt; &gt; =C2=A0 accel/tcg/tcg-runtime=
.h | 11 +++++++++++<br>&gt; &gt; =C2=A0 2 files changed, 17 insertions(+)<b=
r>&gt; &gt;<br>&gt; &gt; diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/t=
cg-runtime.c<br>&gt; &gt; index 7c0aab98a80..ae93765b09e 100644<br>&gt; &gt=
; --- a/accel/tcg/tcg-runtime.c<br>&gt; &gt; +++ b/accel/tcg/tcg-runtime.c<=
br>&gt; &gt; @@ -130,6 +130,12 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)<=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 return ctpop64(arg);<br>&gt; &gt; =C2=A0 =
}<br>&gt; &gt; =C2=A0<br>&gt; &gt; +void HELPER(raise_excp)(CPUArchState *e=
nv, uint32_t exception,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t restore)<br>&gt; &=
gt; +{<br>&gt; &gt; + =C2=A0 =C2=A0cpu_loop_exit_excp(env_cpu(env), excepti=
on, restore ? GETPC() : 0);<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt; =C2=
=A0 void HELPER(exit_atomic)(CPUArchState *env)<br>&gt; &gt; =C2=A0 {<br>&g=
t; &gt; =C2=A0 =C2=A0 =C2=A0 cpu_loop_exit_atomic(env_cpu(env), GETPC());<b=
r>&gt; &gt; diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h<=
br>&gt; &gt; index 0b832176b33..036a33d566b 100644<br>&gt; &gt; --- a/accel=
/tcg/tcg-runtime.h<br>&gt; &gt; +++ b/accel/tcg/tcg-runtime.h<br>&gt; &gt; =
@@ -22,6 +22,17 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i=
64)<br>&gt; &gt; =C2=A0<br>&gt; &gt; =C2=A0 DEF_HELPER_FLAGS_1(lookup_tb_pt=
r, TCG_CALL_NO_WG_SE, cptr, env)<br>&gt; &gt; =C2=A0<br>&gt; &gt; +/**<br>&=
gt; &gt; + * raise_excp:<br>&gt; &gt; + * @arg1: env -- CPU env<br>&gt; &gt=
; + * @arg2: exception -- EXCP_* or target trap number<br>&gt; &gt; + * @ar=
g3: restore -- 0 skip unwind, 1 use GETPC()<br>&gt; &gt; + *<br>&gt; &gt; +=
 * Shared TCG exception raise. Translate calls gen_helper_raise_excp.<br>&g=
t; &gt; + * Exits via cpu_loop_exit_excp.<br>&gt; &gt; + */<br>&gt; &gt; +D=
EF_HELPER_FLAGS_3(raise_excp, TCG_CALL_NO_WG, noreturn, env, i32, i32)<br>&=
gt; &gt; +<br>&gt; &gt; =C2=A0 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_=
WG, noreturn, env)<br>&gt; &gt; =C2=A0<br>&gt; &gt; =C2=A0 #ifndef IN_HELPE=
R_PROTO<br>&gt;<br>&gt; (1) Put the comment before the implementation, not =
the header.<br>&gt; That avoids whatever you&#39;re concerned about vs patc=
h 2.<br><br>Indeed I tried, and I found basically all tcg&#39;s gen_ functi=
on have no comment(detect by the auto-tools),<br>and it&#39;s parameter arg=
0 arg1 arg2 that can not understand at all; and can not link to the impl<br=
>helper_* that defined as HELPEP(X) that makes me reading the tcg code very=
 hard.<br><br>&gt;<br>&gt; (2) Don&#39;t pass an extra argument that change=
s behavior like this.<br>&gt; Better to have two separate functions, each d=
oing one thing.<br><br>how about gen_helper_raise_excp and gen_helper_raise=
_excp_restore<br><br>&gt;<br>&gt; (3) Maybe better to place the functions i=
n cpu-exec-common.c, so that<br>&gt; the compiler can see all the definitio=
ns at once.<br>&gt;<br>&gt;<br><br>Do you mean do not use =C2=A0DEF_HELPER_=
FLAGS_3 at all? directly decl and imp in cpu-loop.h and cpu-exec-common.c<b=
r><br>If this is allowed, then (1) won&#39;t be a issue<br><br><br><br><br>=
--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=
=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggan=
g Luo</div></div>
</div>

--000000000000bf4387065bba0605--

