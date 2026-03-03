Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251DDEB3648
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 00:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxDx9-0004q3-AT; Mon, 02 Mar 2026 19:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxDx6-0004pv-Vr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 19:49:33 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxDx3-0003ya-DZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 19:49:32 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c6e77ace76aso1910730a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 16:49:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772498962; cv=none;
 d=google.com; s=arc-20240605;
 b=Sf8wf//8q3L5djxr4l0YP2HTMpEEBP3Z1rZIw5gx6W7alH4RXwUnVHnoYmZqxWp/qP
 aZvAEY0XpoJTr/NifGoxIUoFBQQ2PFmQyhcemKjRZu+gvyGSuZttbgnT9IxFzkpO033u
 2X3ElSej0y4BpKfpG7iW3PqLSb3kSjPEwlIOCOAD8Xgnbl90bm84YpuQ8n/h/CVayLPw
 iMcKLGq+6ZzoPNT0IEQUd2G97erxYtEXFbvj3KaNv/+W/tvCPMuZ3rL2LtUzyDvSz7wN
 /DQBNQJxkni4b9emfLUL96nnjEYk1E8hv4RWWqSb2UP0Zm/6yJv9Kb8ePaDnrPjETUh6
 naLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qhRWWznHD8WTta8ncBr/wJvOCnBAE19xC/cR5b9t9aY=;
 fh=sbxuPqjMywa3JYEGeYJMyo5ksfdP/w06LeNzDEfn49s=;
 b=X+xqxoAecImdDqNv7CpWZtvRpFelAuDjIFy4owkm/OMCRVEITF2I2nqx5mKaEG5+fE
 IekWI5hjCG+UkZV7W7wsrAjDi296DxWdCxJc261kvDlfNHSkka6+UxBGfKOSrIdNnc9P
 86nggSqxUUPO3oWObUiwuPr3ngEVfKrTlEI/V/BNOY5NFrKma1cDhZ2mztSwR29I9CtV
 kkSY/imcTdd22N0WEUyflGh2CayIfZ3o45U2LDC6AKZbjUcKYvZ66qiPEuakgDCulCCs
 Y46vBOiSVL2YVBcBjWxWhvrlfG6VVx/+9CoP5UhgeTTS8gsDq78K2E0xMqmEBX49i12/
 KvOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772498962; x=1773103762; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qhRWWznHD8WTta8ncBr/wJvOCnBAE19xC/cR5b9t9aY=;
 b=dZBJt1ljwzhOnSSgd7j9hGNJOeMj3AZP4k722fb19m8vOmDWkpv4bSTFT2+gJ0rgsP
 n/qDDWCAoIjUJY+N1sWcseMGopKHJxmm1DcdFjNXLNf0z4EN99ZYq51mfMhnpyNx+T9n
 kWpo9BeWEMChSEE5Wyny0Gg6nJ+IzfkyYKo2szLorIu5Pli7sy5PqvqhG2K5TflrlvgR
 spCWOOkYEkApzo5aheBH5C658Cx6E7c4cjlEtluy/AiSYD/65EJ8ACJYHHfFG8hiTAtx
 t3cK7eNopWZpYNLLizd+3QPLnbzRv4y0Q+hn4qxk9QD+sDW6/KVE1X96/3JbLr1vA6Eb
 gAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772498962; x=1773103762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhRWWznHD8WTta8ncBr/wJvOCnBAE19xC/cR5b9t9aY=;
 b=JZFRBdeJ0IEdWZJT9WC4iPAo+jGKn3ypgHvdd3xCIlqhEk/470KIhG2EY7ZU7BOsD+
 N/iv9mqSwQiuyDOZmJSYML/G9JYiAhJpEKXrEw8pU85hTDlFeeh41L9oGEbRZ/sPk43Y
 qGFuo21DXpG/lqM+xYXNW4LyTFgCmWq4b8PgyYJgC6aa5bZdWf7KmynBIBwPq/uV6YcD
 FTgue/A6q4VJtpZkGWho5IEa/CnURxPsDX+hGtK99KrnZxYPhy4vbV9gyaMdV9As25Xk
 49/Qk1k8X+SiRAnn20/cLeLRtJ1uvC0jouXRXdlVdz2fFrtPbwXBS/1bC2/T4ucwsN2t
 1mFQ==
X-Gm-Message-State: AOJu0YzcI9zW8EhYh7yHektM1B4PB81SZU0vmBriZ1jm6CNW5uAuqdUN
 pj0+GlWB+hlwFLFmmn8W1z1KXwfmZWTJzxvWLl/r66C0X2nAvDUwnrksyGW++LoV6izXmxf7rEg
 fI0BRrAHSF+U0HYtp20hFtXjayZZA2Vg=
X-Gm-Gg: ATEYQzwUYNWxw8x7SY+aTIhW+ZVyZ+7VQ+1ywukCr5MiEzcKBnuwdBOKZa07c4mWnfb
 d8dlzlprCAvhoSwDyKyqlBXsDHLFYK9dm+CIQxaK0XXxgt3m/YwSPCoTdTYotpoCPU2f2CMvVYP
 Un5bgx4HYEfLZpH+IopsqLfBGDZPdMFi1V1dkttTtTznV8MBEO/azTKM/I8c84GlqTpUWHPexUz
 mqA8Y7ZEIeABSxRF8nzfbRMeCVGPWClEv/GBMwpW1gYEK1RAQV5flPPN6j7a6Cmxj9ueuksY0Ew
 Orj4pVr8ltF2Rq99uP3hvSyiczRtixA1EGH785Y=
X-Received: by 2002:a17:90a:e18f:b0:358:e7de:a717 with SMTP id
 98e67ed59e1d1-35965cd13ecmr11574860a91.25.1772498962404; Mon, 02 Mar 2026
 16:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
 <20260226043436.648171-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260226043436.648171-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 2 Mar 2026 17:49:11 -0700
X-Gm-Features: AaiRm51dh9bK-M8upjRbQz0XkMA8ykKRl16_X7XSAwTUsD7O3VTOcI2Wj_Y6CbM
Message-ID: <CAATN3NonuVXqN0SiKqFfod4iQR+qrSe+ecLbO2few4SApQ_PqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/hexagon: use TCG_COND_TSTEQ/TSTNE for
 predicate branches
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000004d7c7064c141344"
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

--00000000000004d7c7064c141344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:34=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Replace TCG_COND_EQ/NE comparisons against 0 with TCG_COND_TSTEQ/TSTNE
> comparisons against 1 for all predicate-conditional branches. This tests
> bit 0 of the predicate register directly, eliminating redundant andi
> operations that previously extracted the LSB before the comparison.
>
> For predicate-conditional jumps (jumpt, jumpf, jumptnew, etc.) and
> jump-register variants (jumprt, jumprf, etc.), pass the raw predicate
> value directly instead of going through fLSBOLD/fLSBNEW extraction.
> For callers that produce a 0/1 result via setcond (compare-and-jump,
> jumprz, etc.), the TSTEQ/TSTNE test on bit 0 is equivalent to the
> previous EQ/NE test against 0.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h   | 80 +++++++++++++++++++-------------------
>  target/hexagon/genptr.c    | 32 ++++++---------
>  target/hexagon/translate.c |  2 +-
>  3 files changed, 53 insertions(+), 61 deletions(-)
>
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 45ccd51888..98d3996011 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
>
> @@ -933,31 +933,31 @@
>      do { \
>          TCGv LSB =3D tcg_temp_new(); \
>          COND; \
> -        gen_cond_jump(ctx, TCG_COND_EQ, LSB, riV); \
> +        gen_cond_jump(ctx, TCG_COND_TSTEQ, LSB, riV); \
>      } while (0)
>  #define fGEN_TCG_cond_jumpf(COND) \
>      do { \
>          TCGv LSB =3D tcg_temp_new(); \
>          COND; \
> -        gen_cond_jump(ctx, TCG_COND_NE, LSB, riV); \
> +        gen_cond_jump(ctx, TCG_COND_TSTNE, LSB, riV); \
>      } while (0)
>
>  #define fGEN_TCG_J2_jumpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumpt(fLSBOLD(PuV))
> +    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuV, riV)
>  #define fGEN_TCG_J2_jumptpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumpt(fLSBOLD(PuV))
> +    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuV, riV)
>  #define fGEN_TCG_J2_jumpf(SHORTCODE) \
> -    fGEN_TCG_cond_jumpf(fLSBOLD(PuV))
> +    gen_cond_jump(ctx, TCG_COND_TSTNE, PuV, riV)
>  #define fGEN_TCG_J2_jumpfpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumpf(fLSBOLD(PuV))
> +    gen_cond_jump(ctx, TCG_COND_TSTNE, PuV, riV)
>  #define fGEN_TCG_J2_jumptnew(SHORTCODE) \
> -    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
> +    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuN, riV)
>  #define fGEN_TCG_J2_jumptnewpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
> +    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuN, riV)
>  #define fGEN_TCG_J2_jumpfnewpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumpf(fLSBNEW(PuN))
> +    gen_cond_jump(ctx, TCG_COND_TSTNE, PuN, riV)
>  #define fGEN_TCG_J2_jumpfnew(SHORTCODE) \
> -    fGEN_TCG_cond_jumpf(fLSBNEW(PuN))
> +    gen_cond_jump(ctx, TCG_COND_TSTNE, PuN, riV)
>
>
There are no more uses of fGET_TCG_cond_jumpf, so that macro can be removed=
.

There are some additional uses of fGEN_TCG_cond_jumpt just below these
changes (e.g., fGEN_TCG_J2_jumprz).  So that macro needs to stay.


> @@ -979,31 +979,31 @@
>      do { \
>          TCGv LSB =3D tcg_temp_new(); \
>          COND; \
> -        gen_cond_jumpr(ctx, RsV, TCG_COND_EQ, LSB); \
> +        gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, LSB); \
>      } while (0)
>  #define fGEN_TCG_cond_jumprf(COND) \
>      do { \
>          TCGv LSB =3D tcg_temp_new(); \
>          COND; \
> -        gen_cond_jumpr(ctx, RsV, TCG_COND_NE, LSB); \
> +        gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, LSB); \
>      } while (0)
>
>  #define fGEN_TCG_J2_jumprt(SHORTCODE) \
> -    fGEN_TCG_cond_jumprt(fLSBOLD(PuV))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuV)
>  #define fGEN_TCG_J2_jumprtpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumprt(fLSBOLD(PuV))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuV)
>  #define fGEN_TCG_J2_jumprf(SHORTCODE) \
> -    fGEN_TCG_cond_jumprf(fLSBOLD(PuV))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuV)
>  #define fGEN_TCG_J2_jumprfpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumprf(fLSBOLD(PuV))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuV)
>  #define fGEN_TCG_J2_jumprtnew(SHORTCODE) \
> -    fGEN_TCG_cond_jumprt(fLSBNEW(PuN))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuN)
>  #define fGEN_TCG_J2_jumprtnewpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumprt(fLSBNEW(PuN))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuN)
>  #define fGEN_TCG_J2_jumprfnew(SHORTCODE) \
> -    fGEN_TCG_cond_jumprf(fLSBNEW(PuN))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuN)
>  #define fGEN_TCG_J2_jumprfnewpt(SHORTCODE) \
> -    fGEN_TCG_cond_jumprf(fLSBNEW(PuN))
> +    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuN)
>

There are no more uses of fGEN_TCG_cond_jumpr[tf], so those macros can be
removed.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000004d7c7064c141344
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 25,=
 2026 at 9:34=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Replace TCG_COND_EQ/NE comparisons a=
gainst 0 with TCG_COND_TSTEQ/TSTNE<br>
comparisons against 1 for all predicate-conditional branches. This tests<br=
>
bit 0 of the predicate register directly, eliminating redundant andi<br>
operations that previously extracted the LSB before the comparison.<br>
<br>
For predicate-conditional jumps (jumpt, jumpf, jumptnew, etc.) and<br>
jump-register variants (jumprt, jumprf, etc.), pass the raw predicate<br>
value directly instead of going through fLSBOLD/fLSBNEW extraction.<br>
For callers that produce a 0/1 result via setcond (compare-and-jump,<br>
jumprz, etc.), the TSTEQ/TSTNE test on bit 0 is equivalent to the<br>
previous EQ/NE test against 0.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0| 80 +++++++++++++++++++--------=
-----------<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 | 32 ++++++---------<br>
=C2=A0target/hexagon/translate.c |=C2=A0 2 +-<br>
=C2=A03 files changed, 53 insertions(+), 61 deletions(-)<br>
<br>
diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h<br>
index 45ccd51888..98d3996011 100644<br>
--- a/target/hexagon/gen_tcg.h<br>
+++ b/target/hexagon/gen_tcg.h<br><br>
@@ -933,31 +933,31 @@<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv LSB =3D tcg_temp_new(); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COND; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_EQ, LSB, riV); \<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTEQ, LSB, riV); =
\<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
=C2=A0#define fGEN_TCG_cond_jumpf(COND) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv LSB =3D tcg_temp_new(); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COND; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_NE, LSB, riV); \<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTNE, LSB, riV); =
\<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
=C2=A0#define fGEN_TCG_J2_jumpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpt(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTEQ, PuV, riV)<br>
=C2=A0#define fGEN_TCG_J2_jumptpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpt(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTEQ, PuV, riV)<br>
=C2=A0#define fGEN_TCG_J2_jumpf(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpf(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTNE, PuV, riV)<br>
=C2=A0#define fGEN_TCG_J2_jumpfpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpf(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTNE, PuV, riV)<br>
=C2=A0#define fGEN_TCG_J2_jumptnew(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpt(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTEQ, PuN, riV)<br>
=C2=A0#define fGEN_TCG_J2_jumptnewpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpt(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTEQ, PuN, riV)<br>
=C2=A0#define fGEN_TCG_J2_jumpfnewpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpf(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTNE, PuN, riV)<br>
=C2=A0#define fGEN_TCG_J2_jumpfnew(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumpf(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_TSTNE, PuN, riV)<br><br></blockq=
uote><div><br></div><div>There are no more uses of fGET_TCG_cond_jumpf, so =
that macro can be removed.</div><div><br></div><div><div>There are some add=
itional uses of fGEN_TCG_cond_jumpt just below these changes (e.g., fGEN_TC=
G_J2_jumprz).=C2=A0 So that macro needs to stay.</div></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
@@ -979,31 +979,31 @@<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv LSB =3D tcg_temp_new(); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COND; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_EQ, LSB); \<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, LSB);=
 \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
=C2=A0#define fGEN_TCG_cond_jumprf(COND) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv LSB =3D tcg_temp_new(); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COND; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_NE, LSB); \<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, LSB);=
 \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
=C2=A0#define fGEN_TCG_J2_jumprt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprt(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuV)<br>
=C2=A0#define fGEN_TCG_J2_jumprtpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprt(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuV)<br>
=C2=A0#define fGEN_TCG_J2_jumprf(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprf(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuV)<br>
=C2=A0#define fGEN_TCG_J2_jumprfpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprf(fLSBOLD(PuV))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuV)<br>
=C2=A0#define fGEN_TCG_J2_jumprtnew(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprt(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuN)<br>
=C2=A0#define fGEN_TCG_J2_jumprtnewpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprt(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuN)<br>
=C2=A0#define fGEN_TCG_J2_jumprfnew(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprf(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuN)<br>
=C2=A0#define fGEN_TCG_J2_jumprfnewpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 fGEN_TCG_cond_jumprf(fLSBNEW(PuN))<br>
+=C2=A0 =C2=A0 gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuN)<br></blockquot=
e><div><br></div><div>There are no more uses of fGEN_TCG_cond_jumpr[tf], so=
 those macros can be removed.</div><div><br></div><div>Otherwise</div><div>=
Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com"=
>ltaylorsimpson@gmail.com</a>&gt;</div><div><br></div><div>=C2=A0</div></di=
v></div>

--00000000000004d7c7064c141344--

