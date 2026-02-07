Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28527EE0AF1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 21:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voq8h-0004DM-UP; Sat, 07 Feb 2026 16:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voq8g-0004D0-8Y
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:46:50 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voq8e-0004Qa-8x
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:46:50 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35621da1a7dso365616a91.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 13:46:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500805; cv=none;
 d=google.com; s=arc-20240605;
 b=eyyvuem/8g1OiVXCT+R1BiryWwg60/SVYHa1KBRzlsUkrnEWfFmp8I1yxfzctnjXki
 zwirGw3F0h5m9L5R17aqxSqKop0IjvVOOkRF1dYiqMz+Oul+as3fLNmVTnwzksC4NrvJ
 086xg1AlR/Y/q5X5soAX7XmSDFq+RXd2cdcZDmwv2dkBTVkqD0shGjcRLcE4U+6QLmF5
 KA0RunQanp3Y70gba2lYet5yYxE8r6BMa0YR7h6bzO9Pc7eTwTmOwbAmbRL9niXephKa
 ZXeRdRFThkFEbhMl97JAGalpYqbtCaWd+5kHiyNiDCbSP1pR76JVxbggl4KEaKDr24eO
 n1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZEBBwNNVbjqcKOim9pXfkeNHpvgf8ns7r0IlNspvzq8=;
 fh=fi5LgK1pnHrOxp5ynh2ozKMRfIaIlDVrKEkyjd/vNVU=;
 b=jwlVY9XaMoNDT8pMYD8m9ryK3yYFJQ+bjUVYXSITKKi7ugPzg1KZZXxob7BWESPH27
 PS4bRR4+8lHm93Edj8Uccl77HeWneOjrvED8AYYc5u5n1iwsgI2kVWUV8rCEKvHxYyX2
 EWp8gNqDXgUuGByPOHsi8WG1+xaZV3ZhYy6y4c08sotk9FkfVt6AnpJIe8pzMAJa9RfF
 euHPjNJM84t1S2cOg1bu2VSVAuq2JrRDYrs9gQn1IrjYpk+PQPCZeOpr5uhONZFnLLO4
 4vIrGFf44adP/YWIbCAy347qwbmEF2KcWOwIv+h73LdL6zb7aJozZ4JBQdXLi0mOBPmT
 pmvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770500805; x=1771105605; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEBBwNNVbjqcKOim9pXfkeNHpvgf8ns7r0IlNspvzq8=;
 b=HKJaq+7c8v7ijb9DMO/ZEuPT7qZQ89pnKZHwaRypPLTWjqbFi0Z1ci28BF3n0gsuxO
 3lQLoYJSMGU23SmPV+F90S6HH4JWr+X/XqI3aE1ngDQuty+KGYXOBq8Nk7F+fuW0Bvtv
 o1h6aobeIBdUR8uMtbetUlf3DwaN0HIjUBORDQR4KvG1PqR83HrSBW0IKX/iaUsNsjHo
 3T/kk3NJlvHLYV3xCSNF1gy/QZRnLd3L+8XRnCyUf3dQPzG2c0kOL3BULdOBzd9dmmwo
 oLH3xFY4ExoMIY84lovBqlC7kwy3fhEVxqthZ00Jiothy3J/P9Fz2JV7RJKkEp9lh+YV
 S7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770500805; x=1771105605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEBBwNNVbjqcKOim9pXfkeNHpvgf8ns7r0IlNspvzq8=;
 b=gvbPZfaCwkCc7I1TmXgPDsyDKutOZHihEGL6+uJLXpryrHSFvv15dV7Kavu8RC7mu+
 dzJQrEiFHeY/tv6onit4wAf1ytb7jAj0s9jziLVr1GOKc5kSvKS8mLBKo83WQTf6Q04L
 z4Ud4orOFFE5oNIeGnFhYh/XhOmHlLN3xL3Z4rYh1zli1W5pSYOxTUXLCgUUhQz0NPoC
 68fXkVi3dHV+0Q5NlDoTv8s7jd9DjP01IgoS0MiL8rGK8BGf7II5PDky5fP9GnNCrCD2
 tVqxthdmiD/WKmm4ZBhup+gfFxOm8gGGMz+H6zt0sYXHy7LquwedxX0b9LCv+LHJlJlx
 G5oQ==
X-Gm-Message-State: AOJu0YytijWoDF4zhbSUQtq8oeVsc8tfS5T6pZLN+yB2gfJ7IrIAIJBW
 KUAoWZK4QiPYXAaD02sNs6/SQyTz3yzy9djE7fz51gEuf/fpiBJ8lHVdzzI8mpQiFSV/WrW22wH
 MlaNwc5AOwuVTBWTgjDsFYOQwEGAeWbY=
X-Gm-Gg: AZuq6aK/+B8qRQxtB9h5TV3AzhytDynkOK24mVUvEwKctglIgl+JJ1D77DptXig/Sd4
 spKdpbamTiI4u8VIByvAGmN5gjO3ZZO7qj/4kzQsKwX0WmC6fPfQe/+4nC+unX/PMUQNvNzcfsK
 ugH/CF1NGnpKAAlywN3sh4Ld3qhtoq01Ee2zUcy3f8zMjvjvkb5WGXgP00crnABFg35oDa+XtEm
 7Wd16prRJESFQ/lAcbq2KEgNKNI4Xsm021fpBuS0fSGJOqTp7kZUea2Pq+EmZ20eZXd9uJ0nB3F
 dZP/FibnW+Qi3Jb+VhR+KfaqURA=
X-Received: by 2002:a17:90b:3c81:b0:356:2872:9c53 with SMTP id
 98e67ed59e1d1-35628729f86mr946653a91.14.1770500804887; Sat, 07 Feb 2026
 13:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
 <20260207180632.1042754-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260207180632.1042754-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 7 Feb 2026 14:46:33 -0700
X-Gm-Features: AZwV_QhNd8CHSUkpxYCLfBpERdQfqL-INuGiahrSFNDk_QL_QvXny2MWuvAoz0M
Message-ID: <CAATN3Nom7=bDkcnR1XWsLoq3yE=uGFeFe6o3CvcNtijkq-+ngg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] target/hexagon: Fix invalid duplex decoding
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com, Brian Cain <bcain@quicinc.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000008cc92c064a42d793"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102f.google.com
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

--0000000000008cc92c064a42d793
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 11:06=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> When decoding a duplex instruction, if the slot0 sub-instruction fails
> to decode after slot1 succeeds, QEMU was leaving the packet in a
> partially-decoded state. This allowed invalid duplex encodings (where
> one sub-instruction doesn't match any valid pattern) to be executed
> incorrectly.
>
> Fix by resetting the decoder state when slot0 fails, returning an empty
> instruction that triggers an exception.
>
> Add gen_exception_decode_fail() for raising exceptions when decode fails
> before ctx->next_PC is initialized. This keeps gen_exception_end_tb()
> semantics unchanged (it continues to use ctx->next_PC for the exception
> PC after successful decode).
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3291
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  linux-user/hexagon/cpu_loop.c        |  4 ++
>  target/hexagon/decode.c              | 13 ++++-
>  target/hexagon/translate.c           | 18 ++++++-
>  tests/tcg/hexagon/invalid-encoding.c | 81 ++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target    |  1 +
>  5 files changed, 113 insertions(+), 4 deletions(-)
>  create mode 100644 tests/tcg/hexagon/invalid-encoding.c
>
>
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index b5ece60450..69ba1ec96c 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -509,8 +509,14 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t
> encoding)
>                  insn->iclass =3D iclass_bits(encoding);
>                  return 2;
>              }
> +            /*
> +             * Slot0 decode failed after slot1 succeeded. This is an
> invalid
> +             * duplex encoding (both sub-instructions must be valid).
> +             */
> +            ctx->insn =3D --insn;
>

Why is this needed?

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000008cc92c064a42d793
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Feb 7, =
2026 at 11:06=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">When decoding a duplex instruction, =
if the slot0 sub-instruction fails<br>
to decode after slot1 succeeds, QEMU was leaving the packet in a<br>
partially-decoded state. This allowed invalid duplex encodings (where<br>
one sub-instruction doesn&#39;t match any valid pattern) to be executed<br>
incorrectly.<br>
<br>
Fix by resetting the decoder state when slot0 fails, returning an empty<br>
instruction that triggers an exception.<br>
<br>
Add gen_exception_decode_fail() for raising exceptions when decode fails<br=
>
before ctx-&gt;next_PC is initialized. This keeps gen_exception_end_tb()<br=
>
semantics unchanged (it continues to use ctx-&gt;next_PC for the exception<=
br>
PC after successful decode).<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3291" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/3291</a><br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:bcain@quicinc.com" target=
=3D"_blank">bcain@quicinc.com</a>&gt;<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
---<br>
=C2=A0linux-user/hexagon/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++=
<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 13 ++++-<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
18 ++++++-<br>
=C2=A0tests/tcg/hexagon/invalid-encoding.c | 81 +++++++++++++++++++++++++++=
+<br>
=C2=A0tests/tcg/hexagon/Makefile.target=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A05 files changed, 113 insertions(+), 4 deletions(-)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/invalid-encoding.c<br>
<br><br>
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
index b5ece60450..69ba1ec96c 100644<br>
--- a/target/hexagon/decode.c<br>
+++ b/target/hexagon/decode.c<br>
@@ -509,8 +509,14 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t e=
ncoding)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0insn-&gt;icla=
ss =3D iclass_bits(encoding);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Slot0 decode failed afte=
r slot1 succeeded. This is an invalid<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* duplex encoding (both su=
b-instructions must be valid).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;insn =3D --insn;<br></bl=
ockquote><div><br></div><div>Why is this needed?</div><div>=C2=A0</div><div=
>Otherwise</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltay=
lorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div></div></div>

--0000000000008cc92c064a42d793--

