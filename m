Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69F6C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7pr-0001r2-Dr; Tue, 23 Jul 2024 01:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sW7pn-0001Zw-Pj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:13:13 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sW7pi-00025F-N9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:13:11 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2642cfb2f6aso1603476fac.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 22:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721711584; x=1722316384;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FkwhzbcBiCteunZEGThYznqB1ZEnc4Uh9p7jCAFXF9c=;
 b=G7IjoIrlUgS9iUnZ9fAIpHky3zWkqzcKq0AUr8lwn92nDrsDhkzLARuyGI80/B/yM3
 bDTHjyXmnCCHRMnv4SL9vIG53UTPDz/ttXZ70dHp9iv267EWf47npmLMY4aRmjObheXs
 Nqyeqq9W+ZAX5u2Jun9ZJXF6LGOUpMlXKEG2CKkvfMxLDXpgrikxOm3OwpHDVPuzUKTr
 nHvUtdeVS5p/RqY+ukEZ2bRMLSajTDfmQu3ATKSv29nGJ70SI0XIr0m3Rk+E6k/ltVNe
 fcvaW+p7pBTGZu09rRSc2g4/FC9TiOyTOPQ3qDiCGb8MB7JwN+g0tZKtUvMDUx2M42ri
 fsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721711584; x=1722316384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FkwhzbcBiCteunZEGThYznqB1ZEnc4Uh9p7jCAFXF9c=;
 b=bQn3KSu+lc/BnY3L4Dc13drXq5eHmCPtJP9Ax6g5RoEyq6ek+93a1th55NcQ+I2k0s
 5N1ITvvHXpSU4a5eOD2rx1mXmMA3hoDeqIHB3v6+Xkl1AnkJtHptoRb3Oq4oiYELkpIH
 lz9CTHICqr0sEkCdoq6eajhFPGi6S7jNdjIkH9snr+d3i0zt4T/uiIP8dufa414PqiZZ
 73+u57j+LLzjUQs6FGcYsIktbcNE7LEvb+QUhcEp6rurL9tMY53yL3Aoj43DGoy8h9fk
 XaqW0HInhgjajwpgResOSYv8VCrkqkrE4nxmvEaoQRbGhQc4ZTK59CSfTyvXMtum8Cfs
 UwNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqxO16goKxnLmCWE5aCPXVUeqjcC/OXfP7MC4lJhiB7XoMOcONhxxTsIMMfz2o4u/+3OxpFS1KshVHWFOEB82JZ+mpSNU=
X-Gm-Message-State: AOJu0Yw4nIHBEdWEmsx0qX1UrGUsobJr1OzpyipTXdcxzoXX0C+/0kOI
 QHXdmFwtFv/LR85WjOyMlQ9xQRV3NPVEAP09mDGKidEmORCIVmH/uG4c08AP+gp27Omnq1PzgbK
 T7ceucJrZXHH0jF45GNHORmRnqp663Vlhh7RGrg==
X-Google-Smtp-Source: AGHT+IHMQy7tIYmItC1W6Z8STiuB6Mva3tVQlRRggN2IPnAmszEgbgMOPHib5T9jwrBG8mlQWzOhkqaTG+sMWsfadw8=
X-Received: by 2002:a05:6870:4714:b0:260:e453:5368 with SMTP id
 586e51a60fabf-261216b476amr9253788fac.46.1721711583953; Mon, 22 Jul 2024
 22:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-14-imp@bsdimp.com>
 <97219e8c-e210-4108-9873-abe2a933a3f1@linaro.org>
In-Reply-To: <97219e8c-e210-4108-9873-abe2a933a3f1@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 22 Jul 2024 23:12:53 -0600
Message-ID: <CANCZdfqAqPRPuRE3=ha4hWwNajXT5sGc-A4DuTCt_ufvRzxOSA@mail.gmail.com>
Subject: Re: [PATCH 13/14] bsd-user: Make compile for non-linux user-mode stuff
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org, 
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005e203d061de33789"
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=wlosh@bsdimp.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--0000000000005e203d061de33789
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 4:01=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Warner,
>
> On 22/7/24 23:43, Warner Losh wrote:
> > We include the files that define PR_MTE_TCF_SHIFT only on Linux, but us=
e
> > them unconditionally. Restrict its use to Linux-only.
>
> We should check that in meson, i.e.:
>
> config_host_data.set('CONFIG_PRCTL_PR_MTE_TCF_SHIFT',
>                       cc.has_header_symbol('sys/prctl.h',
> 'PR_MTE_TCF_SHIFT'))
>
> (like we do for CONFIG_PRCTL_PR_SET_TIMERSLACK), then rework
> linux-user/aarch64/mte_user_helper.h (and possibly
> tests/tcg/aarch64/mte.h), moving in a common directory.
>

Hmmm... I'll have to check, but since I didn't add the incompatibility, it
will likely be on my backlog for a while...


> That said, your patch matches this file header:
>
>    #if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
>    #include <sys/prctl.h>
>    #include "mte_user_helper.h"
>    #endif
>
> Even if this #ifdef'ry is ugly, it isn't wrong, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> =C2=AF\_(=E3=83=84)_/=C2=AF
>

Thanks!

Warner


> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   target/arm/gdbstub64.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 2e2bc2700b8..6dc81aecb2a 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -404,6 +404,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs,
> GByteArray *buf, int reg)
> >
> >   int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
> >   {
> > +#if defined(CONFIG_LINUX)
> >       ARMCPU *cpu =3D ARM_CPU(cs);
> >       CPUARMState *env =3D &cpu->env;
> >
> > @@ -425,6 +426,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs,
> uint8_t *buf, int reg)
> >       arm_set_mte_tcf0(env, tcf);
> >
> >       return 1;
> > +#else
> > +    return 0;
> > +#endif
> >   }
> >
> >   static void handle_q_memtag(GArray *params, void *user_ctx)
>
>

--0000000000005e203d061de33789
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 22, 2024 at 4:01=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Warner,<br>
<br>
On 22/7/24 23:43, Warner Losh wrote:<br>
&gt; We include the files that define PR_MTE_TCF_SHIFT only on Linux, but u=
se<br>
&gt; them unconditionally. Restrict its use to Linux-only.<br>
<br>
We should check that in meson, i.e.:<br>
<br>
config_host_data.set(&#39;CONFIG_PRCTL_PR_MTE_TCF_SHIFT&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cc.has_header_symbol(&#39;sys/prctl.h&#39;, <br>
&#39;PR_MTE_TCF_SHIFT&#39;))<br>
<br>
(like we do for CONFIG_PRCTL_PR_SET_TIMERSLACK), then rework<br>
linux-user/aarch64/mte_user_helper.h (and possibly<br>
tests/tcg/aarch64/mte.h), moving in a common directory.<br></blockquote><di=
v><br></div><div>Hmmm... I&#39;ll have to check, but since I didn&#39;t add=
 the incompatibility, it will likely be on my backlog for a while...<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
That said, your patch matches this file header:<br>
<br>
=C2=A0 =C2=A0#if defined(CONFIG_USER_ONLY) &amp;&amp; defined(CONFIG_LINUX)=
<br>
=C2=A0 =C2=A0#include &lt;sys/prctl.h&gt;<br>
=C2=A0 =C2=A0#include &quot;mte_user_helper.h&quot;<br>
=C2=A0 =C2=A0#endif<br>
<br>
Even if this #ifdef&#39;ry is ugly, it isn&#39;t wrong, so:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
=C2=AF\_(=E3=83=84)_/=C2=AF<br></blockquote><div><br></div><div>Thanks!</di=
v><div><br></div><div>Warner<br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/arm/gdbstub64.c | 4 ++++<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c<br>
&gt; index 2e2bc2700b8..6dc81aecb2a 100644<br>
&gt; --- a/target/arm/gdbstub64.c<br>
&gt; +++ b/target/arm/gdbstub64.c<br>
&gt; @@ -404,6 +404,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByt=
eArray *buf, int reg)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf=
, int reg)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +#if defined(CONFIG_LINUX)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -425,6 +426,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint=
8_t *buf, int reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0arm_set_mte_tcf0(env, tcf);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void handle_q_memtag(GArray *params, void *user_ctx=
)<br>
<br>
</blockquote></div></div>

--0000000000005e203d061de33789--

