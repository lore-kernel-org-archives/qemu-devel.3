Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNbZ-000538-6W; Tue, 18 Aug 2026 13:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misetic@osec.io>) id 1wwNIP-0002OB-47
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:08:17 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <misetic@osec.io>) id 1wwNIN-0006F6-7R
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:08:16 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15f020a223so698794066b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787072893; cv=none;
 d=google.com; s=arc-20260327;
 b=mD4jOfZRaTO44J58GQfBoCUkEDSIOuKlyPBGCmnAFP538PEcM2SoyUMpb0Qnc9rIvE
 P56BuxKWtuKwG8EpM7ltG3/WctdqwkR5N46N8eAY6SYSDnrVwW2tiQCzT8XZd1JhwPza
 dZRgqLQAj0knHsU9SWtzbl8DiZrGJSsYa4DwsqAJQMin4FPs5WHG+1IbroU1h7VJm651
 2I1amvOALxG2cu+ZUe0/l5OQOQq26ie1YdTvIF6aSuoDfqxgtJhioOXPvegrOmDykbpZ
 ixpPKqtCBgbwuMM7utY+9QBk7S8Ktv5qDsw3MheTYhHhI9WT8oLwNpg6SSbpTslvJVgf
 C91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f4ZNGSGsSif9oCQcYLLvKpPuI+szjYsmvvIUn5z4Jac=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=aJUaq67l/GmNGwIJDqf0Kdu2ufCD7tk/49Dd5CmczUJFlUqXWOj8h1mTLpuRMxqTGu
 zjpQ/CF1JBCp3+Fa20R3xxxzfZHMUTvXz8OJ30fny7IrU/CDxPWrv4i2/g3dnF1Tib+H
 0ri/gvgGRSxQ1AAQNRCzXoODfLiUbFtkq7gpPC0aOY02Q+HUAMrxEo5OZ9eE8dHOKCBF
 w3AW15jr1q/JTrue2h1/Zt+zZo+ckgXtfLFpIn4rT8lFa5F6YR3cDfIfWlMVWmFPfjWg
 YXDGdK69Vo9i9PhQXisHvLZNcZQ7v7bCVflji/ouj08h3OdFgum2fjeXYDzAt/OO5766
 Z1ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osec.io; s=google; t=1787072893; x=1787677693; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f4ZNGSGsSif9oCQcYLLvKpPuI+szjYsmvvIUn5z4Jac=;
 b=KH77FTWXvfOVAPUCHL/cYdMbR65UQtY4nPpgwxBRXa4tDpE9TirKhnM08BuGf3zEkj
 Qa6xR4l0KxV8qf16u1Y+qwG6aEEC16WhwFU6mOhXFCWGUezcgp0PXj5uOwU3Ys7Mbr9s
 rG8Jt2inCf2SEm1a2je/bOFR5q8mbNUivsaYNZOXGZQpFahk1271LVE24qfqPif7l7Bl
 oh0avzaNaw4kcNXmEATZ+AKt5s3lBr0NJyTNkIRhPY94kQ8pnO2A0U6l+ZOkIkzRhlsh
 xBgC4/naw3iasQss6NvKxFy/QdHtN7gFYVq8Y35UGbAU8+Yih1SGnxEVN3tUmXER1CXK
 irUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072893; x=1787677693;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f4ZNGSGsSif9oCQcYLLvKpPuI+szjYsmvvIUn5z4Jac=;
 b=h9YuflZTPtZQUy9GmIiAp8z0VgbXaDrr08exciwlLC1/Ggi2rXx4XEMjMBpbt/T0WN
 N6rzwJverE+GGthtx7Y8t56s7qqVpKMPq8iZ0TinedkZRQ31ALhjrFtK+mNmYe9w+aj1
 lv//MyHZLBqCaa27Cte2BC9qyvvvgRbLEe6+ljH8UlIZQ6DQVODoM+Qoa3sjxWsarPla
 OTCixRfaUFh6z3elE4b0+NlWMFNFhcy7wIr0tdO5Z7tIKOtBlKnhQMP3ZQuFh0lOcJv2
 2gkcLXRclN3j5iisqPoKtni8L2vRFgdz4QWMn55iOX67Q4Pmec/dyH3yiqKN4sXFOj/T
 nX/w==
X-Gm-Message-State: AOJu0Yz3PjPV7LuJkfBRpeFYfhvt0M7OICqlJMEHeekW08Lvbqxt+Lwj
 VNNecelO4IOdnfSbPtItIjClURoRc7B9OtDiQSwvU4j0dCzbtiS96vI0LXNVx9JjOhw7rn/TAWY
 GKIgOJA2uJMl7pokIbXnseBYP7xEPNnJeZ/5z+Zy/rjndie+CO2GlTpY=
X-Gm-Gg: AR+sD11VdguSOvUJsRDBo13vcr+9Ut+TPJypCiHe0V7LRnelKzFe23c+1Aq8LyT/xfU
 TYcOkE79K0N0DbPni1V55fmQVETSvk7CAZpMFxICrZU7LiHebzMgV+FEZhZvatJTntDBPrHMS/B
 e6YkRdy70vJnis8jSmzGj76vaP3Lo9fJPoeitMP/pr0on3xPhuwpSKimUCDm5GEhRd4uMJPe33y
 5X4oYTcnEZt5hSSN9plfNrQKp0avfD8uKCWQh99WKX5zvY0ERz/tyC3ThPldiMovMOe1Xri5ErD
 BCsk48e0XVrEWEe3gCu4errwYOfjg1DytF/6qJvcN1f3w28m8O2kCQ==
X-Received: by 2002:a17:907:962a:b0:c21:9411:881b with SMTP id
 a640c23a62f3a-c219411893amr359318266b.25.1787072891968; Tue, 18 Aug 2026
 10:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260528113808.86036-1-misetic@osec.io>
In-Reply-To: <20260528113808.86036-1-misetic@osec.io>
From: =?UTF-8?B?SHJ2b2plIE1pxaFldGnEhw==?= <misetic@osec.io>
Date: Tue, 18 Aug 2026 19:08:01 +0200
X-Gm-Features: AcwNN1VHraoPl-WJv3PMHy5iZIKOpyDvkprPutwJbvJY1vE2p8bNfw-oEhShCMk
Message-ID: <CAFF5j3+AMxyXeU2+JGga7ve_mpdK8hYKO1OjuKx-ytNLmgG_Ww@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Add missing CPL==0 check when returning to
 VM86
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="000000000000ea72b006595554cc"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=misetic@osec.io; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:28:02 -0400
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

--000000000000ea72b006595554cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bumping this:
https://lore.kernel.org/qemu-devel/20260528113808.86036-1-misetic@osec.io/T=
/#u

Any comments or suggestions on the patch?

Thanks,
Hrvoje

On Thu, May 28, 2026 at 1:38=E2=80=AFPM Hrvoje Misetic <misetic@osec.io> wr=
ote:

> helper_ret_protected only checks if the VM flag is set in the new eflags,
> while the Intel manual says:
> IF tempEFLAGS(VM) =3D 1 and CPL =3D 0
>         THEN GOTO RETURN-TO-VIRTUAL-8086-MODE;
>
> As CPL=3D=3D0 check is missing in QEMU TCG, a 32-bit binary inside the gu=
est
> can elevate privileges by executing an iret and returning to VM86 while
> setting IOPL to 3.
>
> Fixes: 90a9fdae1f1a ("more ring 0 operations")
> Signed-off-by: Hrvoje Misetic <misetic@osec.io>
> ---
>  target/i386/tcg/seg_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 58aac72011..57cf668131 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -2068,7 +2068,7 @@ static inline void helper_ret_protected(CPUX86State
> *env, int shift,
>              new_cs =3D popl(&sa) & 0xffff;
>              if (is_iret) {
>                  new_eflags =3D popl(&sa);
> -                if (new_eflags & VM_MASK) {
> +                if (new_eflags & VM_MASK && cpl =3D=3D 0) {
>                      goto return_to_vm86;
>                  }
>              }
> --
> 2.48.1
>
>

--000000000000ea72b006595554cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Bumping this: <a href=3D"https://lore.kernel.org/qemu-deve=
l/20260528113808.86036-1-misetic@osec.io/T/#u">https://lore.kernel.org/qemu=
-devel/20260528113808.86036-1-misetic@osec.io/T/#u</a><br><br>Any comments =
or suggestions on the patch?<br><br>Thanks,<br>Hrvoje</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, May 28, 2026 at 1:38=E2=80=AFPM Hrvoje Misetic &lt;<a href=3D"mai=
lto:misetic@osec.io">misetic@osec.io</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">helper_ret_protected only checks if the=
 VM flag is set in the new eflags,<br>
while the Intel manual says:<br>
IF tempEFLAGS(VM) =3D 1 and CPL =3D 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 THEN GOTO RETURN-TO-VIRTUAL-8086-MODE;<br>
<br>
As CPL=3D=3D0 check is missing in QEMU TCG, a 32-bit binary inside the gues=
t<br>
can elevate privileges by executing an iret and returning to VM86 while<br>
setting IOPL to 3.<br>
<br>
Fixes: 90a9fdae1f1a (&quot;more ring 0 operations&quot;)<br>
Signed-off-by: Hrvoje Misetic &lt;<a href=3D"mailto:misetic@osec.io" target=
=3D"_blank">misetic@osec.io</a>&gt;<br>
---<br>
=C2=A0target/i386/tcg/seg_helper.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c<br=
>
index 58aac72011..57cf668131 100644<br>
--- a/target/i386/tcg/seg_helper.c<br>
+++ b/target/i386/tcg/seg_helper.c<br>
@@ -2068,7 +2068,7 @@ static inline void helper_ret_protected(CPUX86State *=
env, int shift,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_cs =3D popl(&amp;sa) &a=
mp; 0xffff;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_iret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_eflags =
=3D popl(&amp;sa);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (new_eflags &am=
p; VM_MASK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (new_eflags &am=
p; VM_MASK &amp;&amp; cpl =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto return_to_vm86;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--000000000000ea72b006595554cc--

