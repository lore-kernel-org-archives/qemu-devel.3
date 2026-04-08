Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36ED10FC459
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 22:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAb9F-0000Bp-FN; Wed, 08 Apr 2026 18:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAb94-0000BB-Ld
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:13:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAb8p-000398-Jv
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:13:10 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so287547a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 15:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775686373; cv=none;
 d=google.com; s=arc-20240605;
 b=EtjzEPIwHxnQ4nFf4sGbs/OuwmM1rqxeJN9PR8iE+/wnbtzPnU5Ij7CyzM27xYRGIF
 Ah8T7qoFfqtBef5Ic94eSlFrze2cFa3Xj2E93yMeLL2SMHM1UaqTc73bzzq51Jyg4dcN
 CrObMkt5mkBKiSL0AOMg5RIe/JJ78CYBb1+p7a0A0LnbTtbD0tpuHNxzOpP4PzAPwxnU
 yGQ/b8RfCxHAVGTk4s56txVQOGcmISU43PukDhXvQIPLw4k/bpfu1ZJ8JqAJVRfY5uTI
 F6Tn8KXlMugOQU8vmKRc6Kp2DRSVugW5aXDxWhV+CSiXXmB5rAQIP1AaAhsZsFyMW+L7
 0CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=36K9EkSBSlg8jiezZ7mmGAl0E/I4vMzaCJUa7EIvf8I=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=Ibn/9dAn4DOu/n0rMgtGHnC/pZTPJbXvZu/yqcaQ1SFynydMQPYNaLXi0Y1CTm0828
 PTRkKyrdPWipJUdhv3QRX0DpfOObmevxcx79aAejvediVkCheJwdq0CsCXy8IsRtjgek
 QzVeroujQIt9pw48YcSywIL+nhfnt2oLSkZsGv90bkgiV4SZL2SVBE+z/Zjx6ORWukg6
 FxU+iCH5IYHSxGYuMIxLGdMQrHXiAyLwQ9JuL+wY9lZsIykls6EMr38PjAiCFTKM5cg4
 aNI55ZzA8UkqIZZu3+f0Gi9OKHB9vueTIROWZcerW/qQJCt03Fu4vjUb38Pig77lUn3m
 l/HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775686373; x=1776291173; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=36K9EkSBSlg8jiezZ7mmGAl0E/I4vMzaCJUa7EIvf8I=;
 b=M0qtSczkk5cqZMQXuAhIEso/mX6WA/vLq9BeGzRmsFnueJSKZZLRq2XL9pMPJ+CgGN
 5L2uqLS7OPNSN/jOsHPPOY9j2sEAa14IxFAL1ALxLT/scTaZwkqejVq+2lCXwwHs8x+G
 FETVrShsrN9YkKZKntKArQXa5eRr90YXuxjk49ubCu2+KywOiVHCS0OZw9YwErAs9d49
 8j32wK6YUOu2vSgfvm4K7v+NLVnPj7k8P5WuJB0KiknkRXRikt6kmcQuRX7cOzrK+TXl
 sVekLbQm3C5zULv5V3Jz0VVa1nYDrpioJj7/I8aevPetnHnv4tXrQzubGJv4+ZGSQ3nw
 eV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686373; x=1776291173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36K9EkSBSlg8jiezZ7mmGAl0E/I4vMzaCJUa7EIvf8I=;
 b=O8qtwsd9dcB3/vSvB/GjA/NxTszIPLfx397UBQTq4H9qoJ9R2ekIElkluj6hW0l7w8
 i1tue8RN7x9T2C+7cry7NKYaQ2D4vbabEj4+BZw9xPYLah3jklVzNFN0dx1RuiCVrrPL
 onG/J77of3Oa6e1gm1t3DYc0EzFhvy+kbs1WJq83uhNBGoIX4ZRr3q2syMBkqZX3vWsA
 G4te8poNTDYncT3BqwXowU9wpWr70XJQQWmw0XW264uQfPhLGYoSfXHVodS5XWYyP5Lb
 /diNqbVWGLyIX99g9S0dRh7swfQyYuLFE7v1HEFscCxzI5O2+DIar37HyWiofD+IlzPJ
 3Pyw==
X-Gm-Message-State: AOJu0YxzTBjweFZOTz4MxgtdRTLeoYvJys3IpHkewUk+3LiAEgF1Fe/w
 mM4HGXf7cQAYrvx/qkatX8gn6Rm0g/jiLRbJt5FKyUFyoaqlkyOV7acGIMeunjB1XgHSfHBC5p9
 fXvxtrWh22VtIgIJlf6k143T33vM3QCQ=
X-Gm-Gg: AeBDieuadxCR3YAI/OZ11U7uVYs/fGsk1W9rEadGCx+8L+t6F+Nj2/w/uRk9IlrJpq3
 UR/vso/r2NHtPay1r3r6T+rIHKH84gzgJIV/kVfaTVFFOkHsqKfNUzhmCquc/bZjwzzpGhtnSje
 O4PxfN3vmkF++N9AoT3waiVoWZxG0vD5A4RoAvGjq80SpmZPACV8q0+zTILtnoKPg4uH8RDVAro
 ZXzQvTEmjrdx1LKyLZfhxNaZnZv+f/fsSR33KWLklDJYMjBmeeCoHSnEJno5f3oM/otYFtJq5fX
 JQ02i8jZpOIdUYGkEz/A0WjwIKDfowAEmi/HT3g=
X-Received: by 2002:a17:90b:164b:b0:35d:a9bb:1e33 with SMTP id
 98e67ed59e1d1-35e3580440fmr991247a91.11.1775686373419; Wed, 08 Apr 2026
 15:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <42b4b2d1c61637d9fd951f05371fad452d9af77e.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <42b4b2d1c61637d9fd951f05371fad452d9af77e.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 16:12:42 -0600
X-Gm-Features: AQROBzDTlm4cPMF8YborykemGqJ4FCeESqekrkk66mD70myGCyU4TIHqhrYFXFg
Message-ID: <CAATN3Nqb2kwrgjw_6axGmht8qPecCPG54arhdpe9OaUtTiYGtw@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] target/hexagon: add v68 HVX IEEE float
 arithmetic insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000852dd4064efa33fb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1029.google.com
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

--000000000000852dd4064efa33fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point arithmetic instructions:
> - vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations
> - vdmpy_sf_hf: dot-product multiply
> - vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate
> - vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output
> - vadd_hf_hf, vsub_hf_hf: add/sub with hf output
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h                         |   1 +
>  target/hexagon/mmvec/hvx_ieee_fp.h           |  18 ++++
>  target/hexagon/mmvec/macros.h                |   1 +
>  target/hexagon/mmvec/mmvec.h                 |   2 +
>  target/hexagon/attribs_def.h.inc             |   4 +
>  target/hexagon/arch.c                        |   8 ++
>  target/hexagon/cpu.c                         |   3 +
>  target/hexagon/mmvec/hvx_ieee_fp.c           |  21 ++++
>  target/hexagon/hex_common.py                 |   1 +
>  target/hexagon/imported/mmvec/encode_ext.def |  18 ++++
>  target/hexagon/imported/mmvec/ext.idef       | 101 +++++++++++++++++++
>  target/hexagon/meson.build                   |   1 +
>  12 files changed, 179 insertions(+)
>  create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
>  create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c
>
>
> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h
> b/target/hexagon/mmvec/hvx_ieee_fp.h
> new file mode 100644
> index 0000000000..75008deb3b
> --- /dev/null
>
> +
> +#define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
> +
>


> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c
> b/target/hexagon/mmvec/hvx_ieee_fp.c
> new file mode 100644
> index 0000000000..3367226998
> --- /dev/null
> +++ b/target/hexagon/mmvec/hvx_ieee_fp.c
> @@ -0,0 +1,21 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hvx_ieee_fp.h"
> +
> +float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status)
> +{
> +    return float32_mul(float16_to_float32(a1, true, fp_status),
> +                       float16_to_float32(a2, true, fp_status),
> fp_status);
>

Use f16_to_f32.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000852dd4064efa33fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point arithmetic instructions:<br>
- vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations<br>
- vdmpy_sf_hf: dot-product multiply<br>
- vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate<br>
- vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output<br=
>
- vadd_hf_hf, vsub_hf_hf: add/sub with hf output<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 18 ++++<br>
=C2=A0target/hexagon/mmvec/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0target/hexagon/mmvec/mmvec.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0target/hexagon/attribs_def.h.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0target/hexagon/arch.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 ++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 21 ++++<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def |=C2=A0 18 ++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10=
1 +++++++++++++++++++<br>
=C2=A0target/hexagon/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A012 files changed, 179 insertions(+)<br>
=C2=A0create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h<br>
=C2=A0create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c<br>
<br><br>
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_=
ieee_fp.h<br>
new file mode 100644<br>
index 0000000000..75008deb3b<br>
--- /dev/null<br><br>
+<br>
+#define f16_to_f32(A) float16_to_float32((A), true, &amp;env-&gt;hvx_fp_st=
atus)<br>
+<br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon=
/mmvec/hvx_ieee_fp.c<br>
new file mode 100644<br>
index 0000000000..3367226998<br>
--- /dev/null<br>
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c<br>
@@ -0,0 +1,21 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hvx_ieee_fp.h&quot;<br>
+<br>
+float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float32_mul(float16_to_float32(a1, true, fp_status),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0float16_to_float32(a2, true, fp_status), fp_status);<br></blockqu=
ote><div><br></div><div>Use f16_to_f32.</div><div><br></div><div>Otherwise<=
/div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@=
gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div><br></div></div></div=
>

--000000000000852dd4064efa33fb--

