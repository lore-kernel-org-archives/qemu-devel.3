Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC20EE6B47
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQCl-0007tf-3J; Fri, 06 Feb 2026 13:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voQCj-0007t3-Sp
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:17 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voQCh-0001PR-D0
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:17 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-354a5da7910so1074270a91.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770401114; cv=none;
 d=google.com; s=arc-20240605;
 b=Aexzetm7AQ+VDg9zLJThyfMZRG7fv8bt31QdcbSGWC0iCOV5AudHuZ37fny8w8b/8Y
 dgAPjHBmDrCJC9kbEghvSTgrgHlexWvNGWgiIKUO8Jwf3Hv/6xtuZ7XgubdKsjMS6Cy8
 VmV9fqQYblZ7dknOjKziltR/dVCWp6gUe2p6kJ3CvD6HgkGnvfWxRgZ6spbUygiAwa+F
 GJoMury33vCXaYBu8sulwDVjQimdusJthK6i9exncOW+rIOTwxRaN9gdxkdeCEdmjCOv
 rKkjyL4Etid0tJbcVbEfSu69uBV0bTKX+qotOizYzkootza363bjJjvaAO1uxigH1fND
 npOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IQ1RuZS4tcepVxa8gISRjCOllsUJ5Oh6WexV+0Yfyi0=;
 fh=KZjezXCSrxx39dO31pbOeDiyxGEGLz3PIZWBEAGptp8=;
 b=jEm8wQiyix8dOevVUKifNhbNUL85pa4w/62gqIR21qIBRNuXjQ+8y9D3efUdW0KkT0
 RRmq35Km9hO31ddFkuIRpePfCBtRZ4dzOy1ZhljVJrmyTg3jf7trFPLRRcdCp5V3pjW9
 dTnFJI5IMmC5jxBzVUyHFbDVP29q2RDh4v3nSPHacnTYbHWvK8pN33bMapyDBAgYvXGj
 ivRgKtR39jojWT6k9dGOuLS6DflyciEyNZt0zqfM1RL5z6h9vdZ/SyvblG2a71iyqxLv
 OMb4Qn0DXlGEFnSBADbXX0vKDiadab1kDma8yj6L8ucF/PO6qHCQ9//H3jRIJrDAPM5y
 Wf9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770401114; x=1771005914;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IQ1RuZS4tcepVxa8gISRjCOllsUJ5Oh6WexV+0Yfyi0=;
 b=LsE6GXVADFudAR6wQNe5r0Sqsz4bA6orXzf74qS+pKZH4oAgbxRLIlmayO0dpg7iU+
 D5iosH41t53LX8sKfIKyPCNMrvFXG5sTNx07L13tTUjO0P8+DeoyDOnerDcF7KSPp6EO
 JkXCYHpWQRRy4Xpu+5NoIMsVXHtNvQTv/wUgoH9Q8IYx1QH8aHFD2ehmLEgUbSCqlc9c
 y0BU84Or/OAc29P9YBbb6/G8mTALa/YHFUzN+g5CAMLh8tGeLxf3FIFoFBAvn24wvENJ
 hgwnSJNisJoCN2RQ2//SAoeCd9pQlGbRGOLjR+0rlFk521Ch1qNlkv6dIfWjOYZWwVEB
 ViuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401114; x=1771005914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQ1RuZS4tcepVxa8gISRjCOllsUJ5Oh6WexV+0Yfyi0=;
 b=oheGEdeEcY99mTMeZtBpkhrWWRt3ZIDCAzr8dqy99Lw9MWGIp0kCkP4kC4Rq0562Ko
 uCOO/8CgM+RERuJxgNzUkpWmb6FxWBub6a2gqjdJnTDfVrYvpmZ2lTLDV0X2nWXDcovg
 CN8xlLvW+/VCABSfZmlaEH8PI5q/kod7HKFmFiGdVHjdlBK7TTSybcIEAd4A8YO1tTCX
 3Wf83OYapP0hjEuPYBCgjdeMTfojIieHaa2jmzoP8TF5jESsB4fBrTMNew76zrO5WcfR
 srszdJPU30xKcAsURbcwGfygmP5hQFNOnE19CEZxFw/OWL8UZ2+NnUJ+E4vYgEuNmbSw
 W7vg==
X-Gm-Message-State: AOJu0YyD12+RzyddcjWsl7FM/P5e/df179RxMFGQyFvIGIvZmHyR7h5D
 bUcej9j4Y0FLREkcLR2C4CHSTDHpvDL6fCdVCGpGn9FkmJTVcEwmwF2hJd+Zp0wPvZ/rNWHadZW
 zo6vErS0jcarfd9z4AtGZa18cvkD0iHecZVeN0zDD3g==
X-Gm-Gg: AZuq6aK4VJbmxXfW+MkWPNWooz9QlTsAhPmnObmk/YNpWWAMB5FDkFefozDJUxNPHXw
 8m3zoM13Q3vVHdsja6WGoLHERQtGzD6ImTcGYpGbmato4i4DN5MczDHO8KqEwnNKzBkSY/jxhPo
 1g/Ltt3121WpQQCmUvmDotZO3RCzrps23G39xPNwAlIpITqTK1gD3EWUl239LzcZpTXW9e6ozS3
 KQG8pzvun5Fd+dq6rhuwc237w/S3I9SuQLMilgONJgMW7lhT/B2UXwqnNe3c6C1kQfjS7ZXoB/f
 BZgg6Q==
X-Received: by 2002:a17:90b:2748:b0:354:aee0:cab2 with SMTP id
 98e67ed59e1d1-354b3ba34bfmr2774456a91.2.1770401113702; Fri, 06 Feb 2026
 10:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-19-8d8ff0035372@bsdimp.com>
 <1cdc9e1c-5c5b-4ef7-92e9-25085acd5ca5@linaro.org>
In-Reply-To: <1cdc9e1c-5c5b-4ef7-92e9-25085acd5ca5@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 11:05:02 -0700
X-Gm-Features: AZwV_QgJcVFCXhHGuEV_qy7dbE2-ubjDly0UoGcZvvVXoCWF9pVhGBdKIYuUT5U
Message-ID: <CANCZdfr5q=1-EkFET3hirHh7uVe=EfQJhfcd8rQSOJWXtExHQQ@mail.gmail.com>
Subject: Re: [PATCH 19/24] bsd-user: Add do_bsd_msgctl implementation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000007e1349064a2ba1a3"
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

--0000000000007e1349064a2ba1a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 8:22=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add implementation of msgctl(2) syscall for System V message queue
> control
> > operations. Handles command translation and structure conversions for
> > IPC_STAT/IPC_SET/IPC_RMID operations.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 53
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > index 81fdfd8351..27f4497d76 100644
> > --- a/bsd-user/bsd-misc.h
> > +++ b/bsd-user/bsd-misc.h
> > @@ -28,6 +28,12 @@
> >
> >   #include "qemu-bsd.h"
> >
> > +#ifdef MSGMAX
> > +static int bsd_msgmax =3D MSGMAX;
> > +#else
> > +static int bsd_msgmax;
> > +#endif
>
> (1) This isn't used in this patch, and probably generates a Werror.
>

Yes, but no actually: bsd-misc.c isn't in the build yet... However, it
should be folded with later revs. I missed that in the prep.


> (2) Does any supported FreeBSD version actually define MSGMAX anymore?
>      Grepping current source suggests one always has to probe at runtime.
>

Yes. That's true. I'll remove the #ifdef. there is a define in the kernel,
but it's confined to sysv_msg.c file.


> Anyway, if you move this item to the next patch,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> for the rest of this one.
>
> r~
>

--0000000000007e1349064a2ba1a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 8:22=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add implementation of msgctl(2) syscall for System V message queue con=
trol<br>
&gt; operations. Handles command translation and structure conversions for<=
br>
&gt; IPC_STAT/IPC_SET/IPC_RMID operations.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 53 +++++++++++++++++++++++++++++++++=
++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 53 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; index 81fdfd8351..27f4497d76 100644<br>
&gt; --- a/bsd-user/bsd-misc.h<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
&gt; @@ -28,6 +28,12 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu-bsd.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#ifdef MSGMAX<br>
&gt; +static int bsd_msgmax =3D MSGMAX;<br>
&gt; +#else<br>
&gt; +static int bsd_msgmax;<br>
&gt; +#endif<br>
<br>
(1) This isn&#39;t used in this patch, and probably generates a Werror.<br>=
</blockquote><div><br></div><div>Yes, but no actually: bsd-misc.c isn&#39;t=
 in the build yet... However, it should be folded with later revs. I missed=
 that in the prep.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
(2) Does any supported FreeBSD version actually define MSGMAX anymore?<br>
=C2=A0 =C2=A0 =C2=A0Grepping current source suggests one always has to prob=
e at runtime.<br></blockquote><div><br></div><div>Yes. That&#39;s true. I&#=
39;ll remove the #ifdef. there is a define in the kernel, but it&#39;s conf=
ined to sysv_msg.c file.</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
Anyway, if you move this item to the next patch,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
for the rest of this one.<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000007e1349064a2ba1a3--

