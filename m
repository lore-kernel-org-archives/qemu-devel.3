Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F61CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLLYf-0004ya-Uz; Fri, 08 May 2026 09:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <santimonserr@gmail.com>)
 id 1wLIeL-0007tb-W2
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:41:42 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <santimonserr@gmail.com>)
 id 1wLIeI-0003BX-Ri
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:41:41 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso1569834a34.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 03:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778236897; cv=none;
 d=google.com; s=arc-20240605;
 b=F+AwnSjwZpvIFrF3y5WBswJyDOVccwJQXQ5lnGyFVz037i1F3n/bnaw7SZjDues1F/
 2hrmFZ0t0isfkK9Pj6CZx/z0sCiAdlN6OfCYd5eyDniYZrjqBNrqnZkTP0AOn2MNFrUK
 FU/fT4nD9ptZfJ5HmhO5ruIhjZy55Zmoqf8SlLyywfm4IymbBqTRXjhRtWdmhwV1OtBs
 XNA9qigl6wKdcMT+R2Qa1XRwe2DZ67N1BFyLrtkzBp4jseIKfYyzW8UZRgylbSQWhPR5
 6SNzs5i0jlr0/6vuiCIejgocay0yCRDl64Q0qgCzVKOBzj8PaGlzHMcy+cPboKsCa+70
 uTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=afQsYXFF8D2MMNMGPC1go+O955dFjGWpSxtSnMkvkJo=;
 fh=MHPIT82OQg8Y5v9Kf+6MbANroGP28OaiiVfvKXrcjl4=;
 b=ChvV2DwVhspGIX2XKHfXbtikvIJaNar/JQrio3Ey0lPDz7ORXy3Mfw4ydH5akNNWJN
 z3HpBLVxOsgcvE35Shgq96jEEOgNTNZs2fYKGaj+vdUCDhAFmtMfsy5H39RoDT2LYebj
 5YprQYh940nkp9a+3j00Kk3WtJGKj4mAxi0PxeJwtplX02HdJggzZFtFZv2K/uAIfs/T
 XbPvrWLNHlxOHZ+8XqgikRPqGRZAuBeK8slcUJsxAK6XfJetb+CG9NXb2n288Pqzp7up
 ovQn8yeKdVSVkszbwRfeLQhTEg4pJ3/i5gLnkjnQ+wOOKw9b4/pGAwcihC76Y8sf4RsA
 DeJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778236897; x=1778841697; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=afQsYXFF8D2MMNMGPC1go+O955dFjGWpSxtSnMkvkJo=;
 b=fUpRamODOqLrUx6/wMng3B6x1IN5sUwhwT9HzXcfwuiFdlMk3Kkf9iq8o1h/GV+qt8
 fUsxm1iTKSQHnHXRBLfnQsP2C2riTmhZtAu/P/FpEAI3/OtK9kS6/eyUutIPxX12MNmg
 qUKMOejE12pNAStj7wFd5CTwaQVzzsJeMrbpECpaMSz4RO17WA69xRB3V0rDdoaIIphk
 FTy+nvMKU7N3i3WyUbrliz3q0IJOn2hckV7W4ICraGCp4B4Yr4l6w98oYDc5whOsn6Ze
 3jQxWvcb/Lza8FVJYzk6tg4a8otrBKyrSWE0LlzvUaNR+XzmWz1il5OQNrAkN/je5L2f
 3k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778236897; x=1778841697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afQsYXFF8D2MMNMGPC1go+O955dFjGWpSxtSnMkvkJo=;
 b=Mpaq/BCNfPnUA+Ta8+Wc3jzxAolm0yY7aapMcr1XJNWkDCdbudmx67Y49SEn6817qs
 JqU2Cgw01VXGFPHegGEpdP97eaC61ykzelj+jhqixCVu2S9GZ+G/OFkNjHFS23t2qGNO
 +N/YR11a4lvP37b2KG6RDMiABQUu+bbrD+fsnyqwXPp4rQYr72KRTeaVzvwNhIL4sKJq
 chTpryvNpM3L/5rhvU742FwE1TL3lRJeZflDaylQgb0UNUcm4t6zfkapnE6EDj5WFwuy
 fz1JEfRyUd2Z5txlSQW20S/Pl+eVmqp/qil4QAVJ+S7c86vTZeBcfAUsUesnYeSk6dDT
 h1uA==
X-Gm-Message-State: AOJu0Ywv5jXvmW5YYtur3aQ8DNZMDJ+Ozm/7y9uCENKmGNQYVWSqk22Q
 UQVKK9UvGZml7u5koB3hXHQNbmInt1zaizdDOR/cVSSCFSjtN7yJI1Sr6IkFGFIGcneMhx7XG6p
 w3pBshUhih8ckJsQnWY+u0UOh7tsZNnE=
X-Gm-Gg: AeBDiesQHpzFnhqdWngSGD+YEwnM969gn5m9DFJNJAD3+XFtaYDWwJk12IxKKXeO1oT
 24Z5jezE88XGpJQsS6bxqiHApaOUOW/K0Ys8QjEtb5BmpYYGFgVsMDTk86dzFsWKbPM91IQUUUf
 XudqgU5ntVoYY3FxGiK3jBwkzkArYcysxUwTonIzqDcPLsFJP1xz7/u8ya6xXVOjwK7dh6FmAuE
 lin+3Uy1gHVLe715vVLsmnoi5izrBnt9ArLxtM9hqBaSLXZa0XOpcxNjyUdISA8PcyzU4+5HQ7b
 3p/ehw==
X-Received: by 2002:a05:6820:220d:b0:684:188a:737d with SMTP id
 006d021491bc7-69998d4d269mr6961812eaf.44.1778236897031; Fri, 08 May 2026
 03:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
 <1061c734ff63e09ea0544ebecf09abfd6fc25b11.1769407033.git.ktokunaga.mail@gmail.com>
In-Reply-To: <1061c734ff63e09ea0544ebecf09abfd6fc25b11.1769407033.git.ktokunaga.mail@gmail.com>
From: Santiago MC <santimonserr@gmail.com>
Date: Fri, 8 May 2026 12:41:28 +0200
X-Gm-Features: AVHnY4LlZi2qJIDUx1Xg5fKflqgnfcviNXpvCDF7ADeBbL4n1eDXdEE15NZFeXY
Message-ID: <CABE6Nn2h0z+LPOsh++mqEqMcyA3=LJNUq1WfpU7Fu5PQFEY0Mg@mail.gmail.com>
Subject: Re: [PATCH v4 01/33] tcg/wasm64: Add tcg-target.h
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000092fa1b06514c0a5c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=santimonserr@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 May 2026 09:47:58 -0400
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

--00000000000092fa1b06514c0a5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Did this get merged somewhere?

El lun, 26 ene 2026 a la(s) 8:03=E2=80=AFa.m., Kohei Tokunaga (
ktokunaga.mail@gmail.com) escribi=C3=B3:

> Since WebAssembly instructions vary in size and can include single-byte
> instructions, TCG_TARGET_INSN_UNIT_SIZE is set to 1.
>
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>  MAINTAINERS             |  5 ++++
>  tcg/wasm64/tcg-target.h | 61 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 tcg/wasm64/tcg-target.h
>
> V4:
> - Removed tcg-target-reg-bits.h as the 32bit support has been removed and
>   TCG_TARGET_REG_BITS is no longer needed.
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1e586c58f..470b15eeb7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4107,6 +4107,11 @@ F: tcg/tci/
>  F: tcg/tci.c
>  F: disas/tci.c
>
> +WebAssembly TCG target
> +M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> +S: Maintained
> +F: tcg/wasm64/
> +
>  Block drivers
>  -------------
>  VMDK
> diff --git a/tcg/wasm64/tcg-target.h b/tcg/wasm64/tcg-target.h
> new file mode 100644
> index 0000000000..f00761d19f
> --- /dev/null
> +++ b/tcg/wasm64/tcg-target.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Tiny Code Generator for QEMU
> + *
> + * Based on tci/tcg-target.h
> + *
> + * Copyright (c) 2009, 2011 Stefan Weil
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining
> a copy
> + * of this software and associated documentation files (the "Software"),
> to deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S
> IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef TCG_TARGET_H
> +#define TCG_TARGET_H
> +
> +#define TCG_TARGET_INSN_UNIT_SIZE 1
> +#define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
> +
> +/* Number of registers available. */
> +#define TCG_TARGET_NB_REGS 16
> +
> +/* List of registers which are used by TCG. */
> +typedef enum {
> +    TCG_REG_R0 =3D 0,
> +    TCG_REG_R1,
> +    TCG_REG_R2,
> +    TCG_REG_R3,
> +    TCG_REG_R4,
> +    TCG_REG_R5,
> +    TCG_REG_R6,
> +    TCG_REG_R7,
> +    TCG_REG_R8,
> +    TCG_REG_R9,
> +    TCG_REG_R10,
> +    TCG_REG_R11,
> +    TCG_REG_R12,
> +    TCG_REG_R13,
> +    TCG_REG_R14,
> +    TCG_REG_R15,
> +
> +    TCG_REG_TMP =3D TCG_REG_R13,
> +    TCG_AREG0 =3D TCG_REG_R14,
> +    TCG_REG_CALL_STACK =3D TCG_REG_R15,
> +} TCGReg;
> +
> +#endif /* TCG_TARGET_H */
> --
> 2.43.0
>

--00000000000092fa1b06514c0a5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Did this get merged somewhere?</div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">El lun=
, 26 ene 2026 a la(s) 8:03=E2=80=AFa.m., Kohei Tokunaga (<a href=3D"mailto:=
ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>) escribi=C3=B3:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Since WebAssembly in=
structions vary in size and can include single-byte<br>
instructions, TCG_TARGET_INSN_UNIT_SIZE is set to 1.<br>
<br>
Signed-off-by: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.co=
m" target=3D"_blank">ktokunaga.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 =
++++<br>
=C2=A0tcg/wasm64/tcg-target.h | 61 ++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 66 insertions(+)<br>
=C2=A0create mode 100644 tcg/wasm64/tcg-target.h<br>
<br>
V4:<br>
- Removed tcg-target-reg-bits.h as the 32bit support has been removed and<b=
r>
=C2=A0 TCG_TARGET_REG_BITS is no longer needed.<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index c1e586c58f..470b15eeb7 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -4107,6 +4107,11 @@ F: tcg/tci/<br>
=C2=A0F: tcg/tci.c<br>
=C2=A0F: disas/tci.c<br>
<br>
+WebAssembly TCG target<br>
+M: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.com" target=
=3D"_blank">ktokunaga.mail@gmail.com</a>&gt;<br>
+S: Maintained<br>
+F: tcg/wasm64/<br>
+<br>
=C2=A0Block drivers<br>
=C2=A0-------------<br>
=C2=A0VMDK<br>
diff --git a/tcg/wasm64/tcg-target.h b/tcg/wasm64/tcg-target.h<br>
new file mode 100644<br>
index 0000000000..f00761d19f<br>
--- /dev/null<br>
+++ b/tcg/wasm64/tcg-target.h<br>
@@ -0,0 +1,61 @@<br>
+/* SPDX-License-Identifier: MIT */<br>
+/*<br>
+ * Tiny Code Generator for QEMU<br>
+ *<br>
+ * Based on tci/tcg-target.h<br>
+ *<br>
+ * Copyright (c) 2009, 2011 Stefan Weil<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */<br>
+<br>
+#ifndef TCG_TARGET_H<br>
+#define TCG_TARGET_H<br>
+<br>
+#define TCG_TARGET_INSN_UNIT_SIZE 1<br>
+#define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 ((size_t)-1)<br>
+<br>
+/* Number of registers available. */<br>
+#define TCG_TARGET_NB_REGS 16<br>
+<br>
+/* List of registers which are used by TCG. */<br>
+typedef enum {<br>
+=C2=A0 =C2=A0 TCG_REG_R0 =3D 0,<br>
+=C2=A0 =C2=A0 TCG_REG_R1,<br>
+=C2=A0 =C2=A0 TCG_REG_R2,<br>
+=C2=A0 =C2=A0 TCG_REG_R3,<br>
+=C2=A0 =C2=A0 TCG_REG_R4,<br>
+=C2=A0 =C2=A0 TCG_REG_R5,<br>
+=C2=A0 =C2=A0 TCG_REG_R6,<br>
+=C2=A0 =C2=A0 TCG_REG_R7,<br>
+=C2=A0 =C2=A0 TCG_REG_R8,<br>
+=C2=A0 =C2=A0 TCG_REG_R9,<br>
+=C2=A0 =C2=A0 TCG_REG_R10,<br>
+=C2=A0 =C2=A0 TCG_REG_R11,<br>
+=C2=A0 =C2=A0 TCG_REG_R12,<br>
+=C2=A0 =C2=A0 TCG_REG_R13,<br>
+=C2=A0 =C2=A0 TCG_REG_R14,<br>
+=C2=A0 =C2=A0 TCG_REG_R15,<br>
+<br>
+=C2=A0 =C2=A0 TCG_REG_TMP =3D TCG_REG_R13,<br>
+=C2=A0 =C2=A0 TCG_AREG0 =3D TCG_REG_R14,<br>
+=C2=A0 =C2=A0 TCG_REG_CALL_STACK =3D TCG_REG_R15,<br>
+} TCGReg;<br>
+<br>
+#endif /* TCG_TARGET_H */<br>
-- <br>
2.43.0<br>
</blockquote></div>

--00000000000092fa1b06514c0a5c--

