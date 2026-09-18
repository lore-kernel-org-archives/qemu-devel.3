Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F3CC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 01:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7NWY-0007qp-Hg; Thu, 17 Sep 2026 21:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7NWW-0007qa-RL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:36:20 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7NWU-0007hE-Ua
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:36:20 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056c2064so247078a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789695377; cv=none;
 d=google.com; s=arc-20260327;
 b=fKpEqjIga44Gf/los5VwR3t7yo4YA0MdZLb04pS+bMqomNCZlmsgrG9Yn2Rn6tzxMI
 dLI4lPjLLscxd2NMOyS1eV4VI0TKWYVsf28eLjRil3KcE6ywnNSLdGRGpq41ntSBeIFJ
 xw1VuywLqC1mwhPnxFSlFP3vrhH83PgaJ3znaAcMesFlDpc2FumZ+i6OLtIbYrS5UejY
 CcBf7Q22G88Lkip4TMO/xit0KsgP9hYGX46f/gwLH3w/H+3qGaOLxnAcAwPq3nP5dB66
 05o0VaTB2dJ9FhDUr5AiyYUjMHRHddQ3WmqXHhy/x2pK3GSMKFkhPUYVTcO7DW8wdaph
 riZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZY9puDclBvEzT6YB4uwjAUe0cpa5tvMQY/c5MhF/Ucw=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=koZ8qJ4cKA01hZ1BuEgqe4zBUCMd+v4SCuOeAVFtrdqNf7UnUY706IUhkgM9389g6x
 stuIUrfnkwW42m5+oWovboHJLUUVdZ4Wd4ys51fjb237ejf5Uu0lRF+OlKeKj2xlxrfi
 yBnYOBPfDI1pZh0skqN4RMO9BESzRiu+CNQxA/3+esYNvoocAIoyjUo3SOh7E3uKxKyo
 qmVh8ihXBK4FfhJLq9JT4QTocP7srbmv5Ww2GuJW/SE9d2AJNOKUL2BcfDwC06tp7YwQ
 8LHA40AlH7pvMkiYMIgtmwUoWyAO90wsAuT4AhQMYKLdyapC6TQjM0X36ntNH4MxdfZK
 my2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789695377; x=1790300177; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZY9puDclBvEzT6YB4uwjAUe0cpa5tvMQY/c5MhF/Ucw=;
 b=R4LpBOF7OA3GhVnFscHawTvzEOLL30HJ4Hoot/dpUP3jFZmFMKeN2xN10Yxy7//JGI
 vL6H99ZNqk8k5LHa9b1gMZakPu+Bh+cDhCe5RZN0Q7+FUNx5jfxxiR8VwplmdBly14oI
 p9Ul8nUPRUmZzOu2YbxhPuzmtJwllMZqmSDpaTd9BuOsLeySB+4e14yAj4l+KGcVIE10
 Y6Ti7sPWCKkeFPWWDv1gxlnlA/3hLHPdXfoofCsGlaZ4raRNVLGLFXn60x8o4VkedNdL
 ew4Szbp1Mdc5XuGzswF1FbvCGrAKmsy0GLzVAIr/vyO0YkbFVUTayG5XBow/IYSIoLR2
 psGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789695377; x=1790300177;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZY9puDclBvEzT6YB4uwjAUe0cpa5tvMQY/c5MhF/Ucw=;
 b=dB+xXWYZoFFAMbxVMkuaxVk4e6stRKezwIICl7QjS1nafibmDZvL7TwQwgeZ/1KkrX
 5ORzReOMRg0KvYhLPhFzGc7EPTOGHd+11agfgKqSsyMd4eFwCND4IuBrphSryqpbLVr/
 WgiDEn9nNvspVc1NpWxbphkUVjouBVaNj4OOKSnWLe5eERhzPzI79ZlxjcBqss+UEkTK
 Z5p7uZ1Q11eHu6Bv0YUyaHcm3FxaupvaGYgq4LbAdUbGV54RbUxXiH3Ttcy6HDseuI6V
 d/4QjmUN+vzz1GsjvseS2aPFih5yggOdpJhE0pG00wFbJfU6VzCi74sCPZh0xwKsV4Dp
 p/0g==
X-Gm-Message-State: AFuF++kO4W4V9Ezj8K7Hut57+hXmhMRQUqJLUvwSzioEdgONGUJO+ziN
 YXOvBR7p2DDQzDeQMbSS13XBzyMsTq3dn2hi0PdB4IlkDWOmMLNHkcoNlfcuF/EK267ZQON8nK6
 CDZvplYunN8sunBJQEFnumKJIcWDmaMU=
X-Gm-Gg: AYBFou1ZNBnmOOUlaRjTpGFipujvoteqhmmOubkYnIfiSJnlyqjcModWmW13wDENuUe
 2sdX3GNhmYef8HSp68bHyHGfoNt62cpSjO2Szgds7XZmg00nirfi/ogEFGqTfcOM0noPJCk5B08
 pXJSQTqzgjgKmIG6NTd9zsoWUOqczur3tScTeHrj+Q7jEKnSjGcbI5fmHnm8MXBXo4tUyDurh81
 lAEGAiSgzhuGrHSgqXnDkkYl4tDph5wUFdJfrsbY4gZEMeI2puFR6RgGfDybtrFQ7idKxMkaKSe
 gzYz1nGha45/MyoqIObSyfyirdlXq8z0/GJCbngwQbDyGbQBoJNR/Tw=
X-Received: by 2002:a17:907:c1b:b0:c26:19e3:e979 with SMTP id
 a640c23a62f3a-c2a157c41b3mr92775166b.25.1789695376737; Thu, 17 Sep 2026
 18:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-3-luoyonggang@gmail.com>
 <db731c3c-69c3-4c4d-b1d4-27e2a943d900@linaro.org>
In-Reply-To: <db731c3c-69c3-4c4d-b1d4-27e2a943d900@linaro.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2026 09:36:02 +0800
X-Gm-Features: AcwNN1XALxAE471dq9S7qtW3S-9RErAdHzzxsQo1O1xZI8X5l-YENDERcGK4BWE
Message-ID: <CAE2XoE-Pvvqux9NeD8k6FTJ-TYKjdVNtsVDU3SXB=bi8_TjW5Q@mail.gmail.com>
Subject: Re: [PATCH 02/21] helper-gen: move helper_info extern into gen_helper
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002fca3e065bb7edf6"
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000002fca3e065bb7edf6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 8:58=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:
>
> On 9/17/26 14:42, Yonggang Luo wrote:
> > Declare helper_info inside each gen_helper_* body so a comment on
> > DEF_HELPER attaches to gen_helper_*, not helper_info_*. The extern
> > still refers to the global from helper-info.c.inc. Silence
> > -Wnested-externs around the HELPER_H expansion only.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   include/exec/helper-gen.h.inc | 24 ++++++++++++++++--------
> >   1 file changed, 16 insertions(+), 8 deletions(-)
>
> Huh?  Why does comment placement matter?
>
>
> >   #define DEF_HELPER_FLAGS_0(name, flags, ret)
   \
> > -extern TCGHelperInfo glue(helper_info_, name);
 \
> >   static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))
   \

Please look here, this is the implementation in the header already, so we
have no .c file to
comment on it. comments on  &glue(helper_info_,name) do not help, because
we are always calling
to gen_helper_$name. The clangd and other auto-tools can not infer comments
from &glue(helper_info_,name).

If we move extern TCGHelperInfo glue(helper_info_, name);   into inline
function content, then the comment on
DEF_HELPER_*() macros will take effect.

The static inline void is the source of the issue. I have no other way to
deal with it.

> >   {
  \
> > +    extern TCGHelperInfo glue(helper_info_, name);
 \
> >       tcg_gen_call0(glue(helper_info_,name).func,
  \
> >                     &glue(helper_info_,name), dh_retvar(ret));
   \
> >   }


> ...> +/*
> > + * helper_info_* is declared inside gen_helper_* so a comment on
> > + * DEF_HELPER attaches to gen_helper_*, not helper_info_*. That is a
> > + * nested extern; silence -Wnested-externs for this expansion only.
> > + */
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wnested-externs"
> >   #include HELPER_H
> > +#pragma GCC diagnostic pop
> >
> >   #undef DEF_HELPER_FLAGS_0
> >   #undef DEF_HELPER_FLAGS_1
>
> That you have to have to have this workaround makes me less than
receptive.
>
>
> r~



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002fca3e065bb7edf6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D"gmail-:2ij" class=3D"gmail-Am gmail-aiL gmail-a=
O9 gmail-Al editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"Me=
ssage Body" role=3D"textbox" aria-multiline=3D"true" tabindex=3D"1" style=
=3D"direction:ltr;min-height:85px" aria-controls=3D":2l6" aria-expanded=3D"=
false"><br><br>On Fri, Sep 18, 2026 at 8:58=E2=80=AFAM Richard Henderson &l=
t;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.=
org</a>&gt; wrote:<br>&gt;<br>&gt; On 9/17/26 14:42, Yonggang Luo wrote:<br=
>&gt; &gt; Declare helper_info inside each gen_helper_* body so a comment o=
n<br>&gt; &gt; DEF_HELPER attaches to gen_helper_*, not helper_info_*. The =
extern<br>&gt; &gt; still refers to the global from helper-info.c.inc. Sile=
nce<br>&gt; &gt; -Wnested-externs around the HELPER_H expansion only.<br>&g=
t; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoy=
onggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &=
gt; =C2=A0 include/exec/helper-gen.h.inc | 24 ++++++++++++++++--------<br>&=
gt; &gt; =C2=A0 1 file changed, 16 insertions(+), 8 deletions(-)<br>&gt;<br=
>&gt; Huh?=C2=A0 Why does comment placement matter?<br>&gt;<br>&gt;<br>&gt;=
 &gt; =C2=A0 #define DEF_HELPER_FLAGS_0(name, flags, ret) =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>&gt; &gt; -extern TCGHelperInfo glue(helper_info_, name); =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>&gt; &gt; =C2=A0 static inline void glue(gen_helper_, name)(=
dh_retvar_decl0(ret)) =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br><br>Please look here,=
 this is the implementation in the header already, so we have no .c file to=
<br>comment on it. comments on =C2=A0&amp;glue(helper_info_,name) do not he=
lp, because we are always calling<br>to gen_helper_$name. The clangd and ot=
her auto-tools can not infer comments from &amp;glue(helper_info_,name).<br=
><br>If we move extern TCGHelperInfo glue(helper_info_, name); =C2=A0 into =
inline function content, then the comment on <br>DEF_HELPER_*() macros will=
 take effect.<br><br>The static inline void is the source of the issue. I h=
ave no other way to deal with it.<br><br>&gt; &gt; =C2=A0 { =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>&gt; &gt; + =C2=A0 =C2=A0extern TCGHelperInfo glue(helper_i=
nfo_, name); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 tcg_gen_call0(glue(helper=
_info_,name).func, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;glue(helper_info_,name), dh_ret=
var(ret)); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; =C2=A0 }=
<br><br><br>&gt; ...&gt; +/*<br>&gt; &gt; + * helper_info_* is declared ins=
ide gen_helper_* so a comment on<br>&gt; &gt; + * DEF_HELPER attaches to ge=
n_helper_*, not helper_info_*. That is a<br>&gt; &gt; + * nested extern; si=
lence -Wnested-externs for this expansion only.<br>&gt; &gt; + */<br>&gt; &=
gt; +#pragma GCC diagnostic push<br>&gt; &gt; +#pragma GCC diagnostic ignor=
ed &quot;-Wnested-externs&quot;<br>&gt; &gt; =C2=A0 #include HELPER_H<br>&g=
t; &gt; +#pragma GCC diagnostic pop<br>&gt; &gt; =C2=A0<br>&gt; &gt; =C2=A0=
 #undef DEF_HELPER_FLAGS_0<br>&gt; &gt; =C2=A0 #undef DEF_HELPER_FLAGS_1<br=
>&gt;<br>&gt; That you have to have to have this workaround makes me less t=
han receptive.<br>&gt;<br>&gt;<br>&gt; r~<br><br><br><br>--<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=
=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></di=
v>

--0000000000002fca3e065bb7edf6--

