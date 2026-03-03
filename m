Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4977AEDEBEA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVLG-0001Pq-Kp; Tue, 03 Mar 2026 14:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVL1-0001NZ-7S
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:23:24 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVKz-0001yN-Iq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:23:22 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c70f8ffd162so2790985a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:23:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772565800; cv=none;
 d=google.com; s=arc-20240605;
 b=iIG1gDGR/u6kw94bYsr3JF9IDRefcHjfNSCkLXWKm2OtJlluXnA2gUBP5HiO2dF8Et
 SEIaoPPKzNReo78+yIyuts6ME/B8f1oU2Fg+kbQtcQptdtXhQdDjU12b0o1avrk+lSup
 X1wKEEznKYhSzt9F3Sgez+LyyfzpkaYb2++Zzbr0fgmY7i+RCAYZy8JdHGwstOtFZ56w
 WV+JPVTSaLnQ7tbBNLSeR6tVIL56pLkm7Jci5sgzpW2BzZsz43o6xx86fpMErMKMzmGi
 twlqGk8rqUR59pPsJFnO7aObjKWeynPToqKAN356zYhF0lyKqzw22uhpqXZoWdDgMKA+
 +23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Of2zXkfG3rPU0yVqXi9B6NsYzNgp+DOrsJvvCxub524=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=BnUxZFHopchVqYAhr8aMfp01C6VDMHrm/KuGziFJ7O5tG0K2U7dnlbkW5bsCC6r/E4
 mE+bhbz9uqruGQn2CHcOpMBDGg/BLDbyFd4XEXO5k980TGOMM5ByScn9oZKEL946+IYp
 9TlTkqvCfVD9tKBxET0xSVa/MsuGeKdzsHGgn3e3eJDLKNHM28Zntgbd7bCWeaCIcTOB
 PgUChAWrbN+9dF5llWKmr+FcNn2q9lasJJNcyIQuwVqU/XZEevupOt8qnhAadied5v1+
 XCNft1zPlqwtvVHj1+7gSEuSbUTWt+lBhPhYLdZ83AYbQ0U7hwUlRb71juHUKi792IY2
 or6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772565800; x=1773170600; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Of2zXkfG3rPU0yVqXi9B6NsYzNgp+DOrsJvvCxub524=;
 b=AyWJS07RNjgskZWBThFmtjOjllCRK9mL7YyertgsCGcosmmXC9Lk37m+gQmsfz/XmD
 jLscFIq8WYqr1aHNMoM6bMZjwN9bw6B/5dMvY23eNNanKY/z1QbKxULz03FU838VNfFK
 2oJFZhR0N7WlPcsnC7Do7heHAihum6FSQB+w0pJA+AbVLqhHZyDiOWDBQELGLnqYqAoT
 XJXWVhvE9eigVVKJh/P5qY9rH/kL/hdtnY5l38+/K5wDTW0GrgEFfcTFOsk3cRKtVQYh
 WBBmH6bVcfYk3AlunPtmJhkHSsr7erEGlyVZaHoSDILJ66uW7IFb60ZnzuPd8w+5Hvw1
 nqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772565800; x=1773170600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Of2zXkfG3rPU0yVqXi9B6NsYzNgp+DOrsJvvCxub524=;
 b=i4RdJiPesJobT/mm3ghk4V7k/sQHbLgzT0148XqgvGE1ufjpERcBPuigpPa7zFAoSt
 d6uCfFnIKbQy29ff5DDFP874wD9MQZEQK8xIbwvAehWxKzLCC8CVnmgB6j8JmvHCmsQq
 6Fsm5T/YZ3qRmt+k0VbZMwAbPNFlGRNvuu/+GR2wG0C7HqJ582ssfkbzxbYktRAM+yDY
 1YJv1vDpYpMFivbk4YpITTttGCnBCYk2JDdDPPJ/+GzSU9gQPPNPO1NnYjtXIsG12+7q
 K8HazmPFga4eEWqBoeFdFhjC25Hp98IgWUWR1zfphsWpRPcQMl2cE/LUGED0lmygG6Rv
 4Rbw==
X-Gm-Message-State: AOJu0YzxIq/Podhu0RGOK3ke3GnJI5pOejmL3f4yi7/JqcN0/AxAWgp/
 pp+FJeeo66rIoyQXQvRpzCay65TCMcfAa6w4jt3ZfRLTsOHuAEqC+I/UnBfcq8FLm5wDZMfSGYE
 Z/3j4HMp8e5pEeRlMFBMwvFJM/ARHhKY=
X-Gm-Gg: ATEYQzzyGPjkbKPe20Bfz//zLf6KSkweLTi16gJkjG9pLrXzU4u5qejQMmQoML0vJl4
 Ar5+Y/TCDvicBBHPm/GgytqyMfHCzkezepyCattP8i+d+qoQL7LFzqy4dnQ0ZmyW5xp2lfcd+SV
 Z4wXyVyrcYrs8RpWg/LGiKbEJA+IhZaa9VkjwddLC//rneNS9mMiWFYNr2HI2OnPR9r2dosar+T
 GIcXlR/khNv3S1YZo1puzCwolx5QirC5usrjGQtqEbcZOhuQyT4dZRhegdRQ7Pwb4xIJXqLEXsa
 hOSaeJ4lWOUksuDYLBInJsNQRdo+00kA4AdGxGY=
X-Received: by 2002:a17:90b:3bcf:b0:356:2c7b:c026 with SMTP id
 98e67ed59e1d1-35965cc5571mr15535998a91.23.1772565799676; Tue, 03 Mar 2026
 11:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-4-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 12:23:08 -0700
X-Gm-Features: AaiRm50D2ArdHkPuUpXF6ki7JNw0oqa44yKXmkmR38Jm2AIboyKDfvM0a8k9V6I
Message-ID: <CAATN3Nru_vMDRRxE4-sVbXJLj3QSXELty34OCxnQt4O5aoBSqg@mail.gmail.com>
Subject: Re: [PATCH v3 03/37] target/hexagon: Fix badva reference, delete CAUSE
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000d4af61064c23a243"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x535.google.com
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

--000000000000d4af61064c23a243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:36=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> The BADVA reg is referred to with the wrong identifier.  The
> CAUSE reg field of SSR is not yet modeled, we will dump
> the SSR in a subsequent commit.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 58a22ee41f2..82c726139f7 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -117,6 +117,14 @@ static void print_reg(FILE *f, CPUHexagonState *env,
> int regnum)
>                   hexagon_regnames[regnum], value);
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static void print_sreg(FILE *f, CPUHexagonState *env, int regnum)
> +{
> +    qemu_fprintf(f, "  %s =3D 0x" TARGET_FMT_lx "\n",
> +                 hexagon_sregnames[regnum], env->t_sreg[regnum]);
>

There are both t_sreg (thread) and g_sreg (global).  Either use
arch_get_system_reg to get the value or change the name of the function to
print_t_sreg.


> +}
> +#endif
> +
>

--000000000000d4af61064c23a243
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:36=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
The BADVA reg is referred to with the wrong identifier.=C2=A0 The<br>
CAUSE reg field of SSR is not yet modeled, we will dump<br>
the SSR in a subsequent commit.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.c | 11 +++++++++--<br>
=C2=A01 file changed, 9 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c<br>
index 58a22ee41f2..82c726139f7 100644<br>
--- a/target/hexagon/cpu.c<br>
+++ b/target/hexagon/cpu.c<br>
@@ -117,6 +117,14 @@ static void print_reg(FILE *f, CPUHexagonState *env, i=
nt regnum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_regn=
ames[regnum], value);<br>
=C2=A0}<br>
<br>
+#ifndef CONFIG_USER_ONLY<br>
+static void print_sreg(FILE *f, CPUHexagonState *env, int regnum)<br>
+{<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;=C2=A0 %s =3D 0x&quot; TARGET_FMT_lx &=
quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hexagon_sreg=
names[regnum], env-&gt;t_sreg[regnum]);<br></blockquote><div><br></div><div=
>There are both t_sreg (thread) and g_sreg (global).=C2=A0 Either use arch_=
get_system_reg to get the value or change the name of the function to print=
_t_sreg.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
+}<br>
+#endif<br>
+<br>
</blockquote></div></div>

--000000000000d4af61064c23a243--

