Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C9EFEC0F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w574X-0000FL-Uc; Tue, 24 Mar 2026 15:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w574V-0000Ex-2R
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:05:47 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w574R-00089y-2w
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:05:45 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so3894086a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774379140; cv=none;
 d=google.com; s=arc-20240605;
 b=g/gQLtsi8LX/4gyKYiMKIq0X2eVQP7jMXlUj4xw3cw102ht4KgS46ZAC9gV6KlDjrD
 7t9nLbUAQpu5al7Jau4SRjrKl6OzHGhX0qg0G0sLdCoCreDpfedbR28PHXeskBdqwuts
 MHv2pLG3m4dBaJfJVh4dvD1qWE9fzQUTpuoplNm2p+iedzIv7yGMjFEt79tXPf0XgnSI
 k8UDnyqb+mkr+dXu0KvbbtTkICP2U3Yd+eNmUY/PH43stvesGTOIv4NJBnEjbxF3sbQv
 9p3+y9vTXkxkslVqGoFfjPzcxZXQ/Xlu0oQ6TzMBCLQ5N5TG86+asyaaOEFBn163wLtS
 aS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3wsi9O/j1Q1C+u7Ic7Q2ig6tW82w3BBnUHcG6C4tIok=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=SbYo23qKnpv+4oTL3XmivfObjVG3Y9gBydRmsf+UubJWCke2XEthQXLrG13b4PNx/L
 X6IpI1LqVqZ8h18b/0ef/0vonwzGu9eGLPus9TIaf89qDDerqFcwaw+q/5gWgtRByePl
 u0cZkyCm2Of7mbHpMGbtDEOdlkohb9ntUUOp2daOAMc+K83n5FxW0ZMxWENG9f0XhARQ
 KpzyiLyMXFUN85Nh+M+r9qnCj586Cs5r6QnUVeuzR8kVT9qDFSENl5OjOhmOhAcraAgG
 v4rV34JdAvY7YlNuHEvrsJDEIenQ8+pybe5UyeLTku6gBgGjSCtjlPxVK7YICqvC6Um7
 iqNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774379140; x=1774983940; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3wsi9O/j1Q1C+u7Ic7Q2ig6tW82w3BBnUHcG6C4tIok=;
 b=cCjmX8Ynm/JRZEZjqo68llb2kaBADNJ9UheeYlANxFCPo5Vepw1dm7731IbvrFl6oc
 2xwdYNWiaQOEkjLBuE4SuWxYcu8dsR+A42pGh0IaqWrJy1FpHNXdC916oRp8GwPIkap5
 CfNfB4Vv6ql46WuKK6iI7MKkoi9G43y09quBo/+AAZUCBcRoDC02/aWC7VADAkqck6eP
 NQs7eXJdP99pq8rCb442+pT+TByaYtbWlpNYXIhmevLLKbsuzLx3qxuueDTG/GAnGXLX
 EmSd7La9iXs/J5aJfKGi4lfM89nGCp9czWw8q4xAvNd3a040zxEkvlDYhP35ZppBMpCW
 GRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774379140; x=1774983940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wsi9O/j1Q1C+u7Ic7Q2ig6tW82w3BBnUHcG6C4tIok=;
 b=j1yjWw1FRXH/0dqA+5uhTGd9Mxyi3VwmzanMtQaHl5wvxm8oYNF5Ry8C3p/OIPUIHP
 Rk3h4zd6gmd1S2+xYEcbzoyMXU8TzUaz5sxpB4pQgn403+0uKF/34/Mpnq2vMKfFjT4T
 zIBWR0ZZ+sBF0hKIl6x2h8IdtdFI9m7K4nKzYGg5GYDYZ2Revpv2UI3YmsTvdbgwxEFE
 Pg3I1J+i3XzUn1us8QGr/EtK7YjAR2svoDAjerRd8yagW8Kr8OZvFoqKc1QEAyRdqauM
 vzrmo8gPuoh1ju2ligEpItL2ELbBss9q1jVgXPhtCI+C4+3ekKMiu5BUrbk3cTyhwA9u
 Xlkg==
X-Gm-Message-State: AOJu0YzOnfJApWn9k7isJ5UvWl7XSZ6NfRqF1Ftt61jWuVFSBdEultd0
 rA8QNBCzFJGXlrWegafVrggbvkhvCn5ON57SJ+aHUtVX1gpcAGf7dJXeqFzbx095SuHbkIWvqZq
 Hmf8dlDpEcHQxaya1iqTNB2iRCl8Dbm0=
X-Gm-Gg: ATEYQzwQ5OdokOMudzAwjvFmrpdHeOk6woGEUqi09KYEKqFFIzRiyPeRKMeXTISsTJv
 20unWtB/ant+Exo4mZKDbCh7y6k4kjlqvHzTvFywFp6Wj9B8dt24q7vK9LhryPWd34gUdXAIyuD
 Of+lAZy5Q5Ul4d0qlwkdjEWTF0R5jjmyEHAr3qkLSDWAPO3f5GS9+fV1xfA+CZ3gUMb/+PtnAyW
 bJ0u+6X448A1jQaZv6uyVGkoMUsumWhqaoYth8U1FxCftGwXkrawqVGxTZwfsjsYnhh4X1wF1y+
 BzyxXOkP5e5eK6cF8vIoYE5uixIZ7zjIzDFolvWv7YGe4SnKDQ==
X-Received: by 2002:a17:90b:2fcc:b0:35b:93d8:6aaa with SMTP id
 98e67ed59e1d1-35c0dd7af62mr419159a91.19.1774379139297; Tue, 24 Mar 2026
 12:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <82c5487435a72c68ceec1c09dd6fb986409328e1.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <82c5487435a72c68ceec1c09dd6fb986409328e1.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 13:05:28 -0600
X-Gm-Features: AaiRm534NtYCcygvGG175OOg9heji9TkL3ZYGYY-0WTpYRM2sp0ljm-WBcIXNbU
Message-ID: <CAATN3NpkMvcWubprGjd705iQ0XCAJD+toCnEv78E3=ZL+eSemg@mail.gmail.com>
Subject: Re: [PATCH 10/13] tests/hexagon: add tests for v68 HVX IEEE float
 arithmetics
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000004b774c064dc9d6b8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1034.google.com
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

--0000000000004b774c064dc9d6b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hvx_misc.h        |  12 +++
>  tests/tcg/hexagon/fp_hvx.c          | 129 ++++++++++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx_disabled.c |  32 +++++++
>  tests/tcg/hexagon/Makefile.target   |   8 ++
>  4 files changed, 181 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx.c
>  create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c
>
> diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
> new file mode 100644
> index 0000000000..85b8ff78ed
> --- /dev/null
> +++ b/tests/tcg/hexagon/fp_hvx.c
> @@ -0,0 +1,129 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <hexagon_types.h>
> +#include <hvx_hexagon_protos.h>
> +
> +int err;
> +#include "hvx_misc.h"
> +
> +#if __HEXAGON_ARCH__ > 75
> +#error "After v75, compiler will replace some FP HVX instructions."
> +#endif
> +
>
> +/***********************************************************************=
*******
> + * NAN handling
> +
> *************************************************************************=
****/
> +
> +#define isnan(X) \
> +     (sizeof(X) =3D=3D bytes_hf ? ((raw_hf(X) & ~0x8000) > 0x7c00) : \
> +                              ((raw_sf(X) & ~(1 << 31)) > 0x7f800000UL))
> +
> +#define CHECK_NAN(A, DEF_NAN) (isnan(A) ? DEF_NAN : (A))
> +#define NAN_SF float_sf(0x7FFFFFFF)
> +#define NAN_HF float_hf(0x7FFF)
> +
>
> +/***********************************************************************=
*******
> + * Binary operations
> +
> *************************************************************************=
****/
> +
> +#define DEF_TEST_OP_2(vop, op, type_res, type_arg) \
> +    static void test_##vop##_##type_res##_##type_arg(void) \
> +    { \
> +        memset(expect, 0xff, sizeof(expect)); \
> +        memset(output, 0xff, sizeof(expect)); \
>

sizeof(output)


> +        HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0]; \
> +        HVX_Vector hvx_buffer0 =3D *(HVX_Vector *)&buffer0[0]; \
> +        HVX_Vector hvx_buffer1 =3D *(HVX_Vector *)&buffer1[0]; \
> +        \
> +        *hvx_output =3D \
> +
> Q6_V##type_res##_##vop##_V##type_arg##V##type_arg(hvx_buffer0, \
> +
> hvx_buffer1); \
> +        \
> +        for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / bytes_##type_res; i++=
) {
> \
> +            expect[0].type_res[i] =3D \
> +
> raw_##type_res(op(float_##type_arg(buffer0[0].type_arg[i]), \
> +
> float_##type_arg(buffer1[0].type_arg[i]))); \
> +        } \
>

Put this in a loop over the input buffers to get more input values.  Then
change the second argument to check_output below.


> +        check_output_##type_res(__LINE__, 1); \
> +    }
> +
> +#define SUM(X, Y, DEF_NAN) CHECK_NAN((X) + (Y), DEF_NAN)
> +#define SUB(X, Y, DEF_NAN) CHECK_NAN((X) - (Y), DEF_NAN)
> +#define MULT(X, Y, DEF_NAN) CHECK_NAN((X) * (Y), DEF_NAN)
> +
> +#define SUM_SF(X, Y) SUM(X, Y, NAN_SF)
> +#define SUM_HF(X, Y) SUM(X, Y, NAN_HF)
> +#define SUB_SF(X, Y) SUB(X, Y, NAN_SF)
> +#define SUB_HF(X, Y) SUB(X, Y, NAN_HF)
> +#define MULT_SF(X, Y) MULT(X, Y, NAN_SF)
> +#define MULT_HF(X, Y) MULT(X, Y, NAN_HF)
> +
> +DEF_TEST_OP_2(vadd, SUM_SF, sf, sf);
> +DEF_TEST_OP_2(vadd, SUM_HF, hf, hf);
> +DEF_TEST_OP_2(vsub, SUB_SF, sf, sf);
> +DEF_TEST_OP_2(vsub, SUB_HF, hf, hf);
> +DEF_TEST_OP_2(vmpy, MULT_SF, sf, sf);
> +DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
> +
>
> +/***********************************************************************=
*******
> + * Other tests
> +
> *************************************************************************=
****/
> +
> +void test_vdmpy_sf_hf(bool acc)
> +{
> +    HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0];
> +    HVX_Vector hvx_buffer0 =3D *(HVX_Vector *)&buffer0[0];
> +    HVX_Vector hvx_buffer1 =3D *(HVX_Vector *)&buffer1[0];
> +
> +    uint32_t PREFIL_VAL =3D 0x111222;
> +    memset(expect, 0xff, sizeof(expect));
> +    *hvx_output =3D Q6_V_vsplat_R(PREFIL_VAL);
> +
> +    if (!acc) {
> +        *hvx_output =3D Q6_Vsf_vdmpy_VhfVhf(hvx_buffer0, hvx_buffer1);
> +    } else {
> +        *hvx_output =3D Q6_Vsf_vdmpyacc_VsfVhfVhf(*hvx_output, hvx_buffe=
r0,
> +                                                hvx_buffer1);
> +    }
> +
> +    for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / 4; i++) {
> +        float a1 =3D float_hf_to_sf(float_hf(buffer0[0].hf[2 * i + 1]));
> +        float a2 =3D float_hf_to_sf(float_hf(buffer0[0].hf[2 * i]));
> +        float a3 =3D float_hf_to_sf(float_hf(buffer1[0].hf[2 * i + 1]));
> +        float a4 =3D float_hf_to_sf(float_hf(buffer1[0].hf[2 * i]));
> +        float prev =3D acc ? float_sf(PREFIL_VAL) : 0;
> +        expect[0].sf[i] =3D raw_sf(CHECK_NAN((a1 * a3) + (a2 * a4) + pre=
v,
> NAN_SF));
> +    }
>

Put this into a loop also.


> +
> +    check_output_sf(__LINE__, 1);
> +}
> +
> +int main(void)
> +{
> +    init_buffers();
>

The init_buffers function is designed to create inputs for non-FP functions=
.
Create a new function to initialize the buffers with interesting FP values
(e.g., NaN, large FP values that will lead to overflow).
Also, see my prior comment about FP flags.  We'll want to check those here.
We should also add some tests with packets.  See my prior comment about
.new values.


> +
> +    /* add/sub */
> +    test_vadd_sf_sf();
> +    test_vadd_hf_hf();
> +    test_vsub_sf_sf();
> +    test_vsub_hf_hf();
> +
> +    /* multiply */
> +    test_vmpy_sf_sf();
> +    test_vmpy_hf_hf();
> +
> +    /* dot product */
> +    test_vdmpy_sf_hf(false);
> +    test_vdmpy_sf_hf(true);
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
> diff --git a/tests/tcg/hexagon/fp_hvx_disabled.c
> b/tests/tcg/hexagon/fp_hvx_disabled.c
> new file mode 100644
> index 0000000000..af409ab8d2
> --- /dev/null
> +++ b/tests/tcg/hexagon/fp_hvx_disabled.c
> @@ -0,0 +1,32 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <hexagon_types.h>
> +#include <hvx_hexagon_protos.h>
> +
> +int err;
> +#include "hvx_misc.h"
> +
> +int main(void)
> +{
> +    asm volatile("r0 =3D #0xff\n"
> +                 "v0 =3D vsplat(r0)\n"
> +                 "vmem(%1 + #0) =3D v0\n"
> +                 "r1 =3D #0x1\n"
> +                 "v1 =3D vsplat(r1)\n"
> +                 "v2 =3D vsplat(r1)\n"
> +                 "v0.sf =3D vadd(v1.sf, v2.sf)\n"
> +                 "vmem(%0 + #0) =3D v0\n"
> +                 :
> +                 : "r"(output), "r"(expect)
> +                 : "r0", "r1", "v0", "v1", "v2", "memory");
>

Add a test where the result is used in a .new context.


> +
> +    check_output_w(__LINE__, 1);
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
>
>

--0000000000004b774c064dc9d6b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23, 2026=
 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheu=
s.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qua=
lcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:=
matheus.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@o=
ss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hvx_misc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 ++=
+<br>
=C2=A0tests/tcg/hexagon/fp_hvx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 129 ++=
++++++++++++++++++++++++++<br>
=C2=A0tests/tcg/hexagon/fp_hvx_disabled.c |=C2=A0 32 +++++++<br>
=C2=A0tests/tcg/hexagon/Makefile.target=C2=A0 =C2=A0|=C2=A0 =C2=A08 ++<br>
=C2=A04 files changed, 181 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx.c<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c<br>
<br>diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c<br=
>
new file mode 100644<br>
index 0000000000..85b8ff78ed<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/fp_hvx.c<br>
@@ -0,0 +1,129 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;hexagon_types.h&gt;<br>
+#include &lt;hvx_hexagon_protos.h&gt;<br>
+<br>
+int err;<br>
+#include &quot;hvx_misc.h&quot;<br>
+<br>
+#if __HEXAGON_ARCH__ &gt; 75<br>
+#error &quot;After v75, compiler will replace some FP HVX instructions.&qu=
ot;<br>
+#endif<br>
+<br>
+/*************************************************************************=
*****<br>
+ * NAN handling<br>
+ *************************************************************************=
****/<br>
+<br>
+#define isnan(X) \<br>
+=C2=A0 =C2=A0 =C2=A0(sizeof(X) =3D=3D bytes_hf ? ((raw_hf(X) &amp; ~0x8000=
) &gt; 0x7c00) : \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((raw_sf(X) &amp; ~(1 &lt;&lt; 31)) &gt; 0x=
7f800000UL))<br>
+<br>
+#define CHECK_NAN(A, DEF_NAN) (isnan(A) ? DEF_NAN : (A))<br>
+#define NAN_SF float_sf(0x7FFFFFFF)<br>
+#define NAN_HF float_hf(0x7FFF)<br>
+<br>
+/*************************************************************************=
*****<br>
+ * Binary operations<br>
+ *************************************************************************=
****/<br>
+<br>
+#define DEF_TEST_OP_2(vop, op, type_res, type_arg) \<br>
+=C2=A0 =C2=A0 static void test_##vop##_##type_res##_##type_arg(void) \<br>
+=C2=A0 =C2=A0 { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(expect, 0xff, sizeof(expect)); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(output, 0xff, sizeof(expect)); \<br></b=
lockquote><div><br></div><div>sizeof(output)</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector *hvx_output =3D (HVX_Vector *)&amp;=
output[0]; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector hvx_buffer0 =3D *(HVX_Vector *)&amp=
;buffer0[0]; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector hvx_buffer1 =3D *(HVX_Vector *)&amp=
;buffer1[0]; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *hvx_output =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Q6_V##type_res##_##vop##_V##type=
_arg##V##type_arg(hvx_buffer0, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hvx_b=
uffer1); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; MAX_VEC_SIZE_BYTES / =
bytes_##type_res; i++) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[0].type_res[i] =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raw_##type_res(op(=
float_##type_arg(buffer0[0].type_arg[i]), \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float_##type_arg(buffer1[0].t=
ype_arg[i]))); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br></blockquote><div><br></div><div>Put th=
is in a loop over the input buffers to get more input values.=C2=A0 Then ch=
ange the second argument to check_output below.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_output_##type_res(__LINE__, 1); \<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#define SUM(X, Y, DEF_NAN) CHECK_NAN((X) + (Y), DEF_NAN)<br>
+#define SUB(X, Y, DEF_NAN) CHECK_NAN((X) - (Y), DEF_NAN)<br>
+#define MULT(X, Y, DEF_NAN) CHECK_NAN((X) * (Y), DEF_NAN)<br>
+<br>
+#define SUM_SF(X, Y) SUM(X, Y, NAN_SF)<br>
+#define SUM_HF(X, Y) SUM(X, Y, NAN_HF)<br>
+#define SUB_SF(X, Y) SUB(X, Y, NAN_SF)<br>
+#define SUB_HF(X, Y) SUB(X, Y, NAN_HF)<br>
+#define MULT_SF(X, Y) MULT(X, Y, NAN_SF)<br>
+#define MULT_HF(X, Y) MULT(X, Y, NAN_HF)<br>
+<br>
+DEF_TEST_OP_2(vadd, SUM_SF, sf, sf);<br>
+DEF_TEST_OP_2(vadd, SUM_HF, hf, hf);<br>
+DEF_TEST_OP_2(vsub, SUB_SF, sf, sf);<br>
+DEF_TEST_OP_2(vsub, SUB_HF, hf, hf);<br>
+DEF_TEST_OP_2(vmpy, MULT_SF, sf, sf);<br>
+DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);<br>
+<br>
+/*************************************************************************=
*****<br>
+ * Other tests<br>
+ *************************************************************************=
****/<br>
+<br>
+void test_vdmpy_sf_hf(bool acc)<br>
+{<br>
+=C2=A0 =C2=A0 HVX_Vector *hvx_output =3D (HVX_Vector *)&amp;output[0];<br>
+=C2=A0 =C2=A0 HVX_Vector hvx_buffer0 =3D *(HVX_Vector *)&amp;buffer0[0];<b=
r>
+=C2=A0 =C2=A0 HVX_Vector hvx_buffer1 =3D *(HVX_Vector *)&amp;buffer1[0];<b=
r>
+<br>
+=C2=A0 =C2=A0 uint32_t PREFIL_VAL =3D 0x111222;<br>
+=C2=A0 =C2=A0 memset(expect, 0xff, sizeof(expect));<br>
+=C2=A0 =C2=A0 *hvx_output =3D Q6_V_vsplat_R(PREFIL_VAL);<br>
+<br>
+=C2=A0 =C2=A0 if (!acc) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *hvx_output =3D Q6_Vsf_vdmpy_VhfVhf(hvx_buffer=
0, hvx_buffer1);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *hvx_output =3D Q6_Vsf_vdmpyacc_VsfVhfVhf(*hvx=
_output, hvx_buffer0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 hvx_buffer1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; MAX_VEC_SIZE_BYTES / 4; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float a1 =3D float_hf_to_sf(float_hf(buffer0[0=
].hf[2 * i + 1]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float a2 =3D float_hf_to_sf(float_hf(buffer0[0=
].hf[2 * i]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float a3 =3D float_hf_to_sf(float_hf(buffer1[0=
].hf[2 * i + 1]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float a4 =3D float_hf_to_sf(float_hf(buffer1[0=
].hf[2 * i]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float prev =3D acc ? float_sf(PREFIL_VAL) : 0;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[0].sf[i] =3D raw_sf(CHECK_NAN((a1 * a3)=
 + (a2 * a4) + prev, NAN_SF));<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Put this into a loop a=
lso.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br>
+=C2=A0 =C2=A0 check_output_sf(__LINE__, 1);<br>
+}<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 init_buffers();<br></blockquote><div><br></div><div>The init=
_buffers function is designed to create inputs for non-FP functions.</div><=
div>Create a new function to initialize the buffers with interesting FP val=
ues (e.g., NaN, large FP values that will lead to overflow).</div><div>Also=
, see my prior comment about FP flags.=C2=A0 We&#39;ll want to check those =
here.</div><div>We should also add some tests with packets.=C2=A0 See my pr=
ior comment about .new values.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 /* add/sub */<br>
+=C2=A0 =C2=A0 test_vadd_sf_sf();<br>
+=C2=A0 =C2=A0 test_vadd_hf_hf();<br>
+=C2=A0 =C2=A0 test_vsub_sf_sf();<br>
+=C2=A0 =C2=A0 test_vsub_hf_hf();<br>
+<br>
+=C2=A0 =C2=A0 /* multiply */<br>
+=C2=A0 =C2=A0 test_vmpy_sf_sf();<br>
+=C2=A0 =C2=A0 test_vmpy_hf_hf();<br>
+<br>
+=C2=A0 =C2=A0 /* dot product */<br>
+=C2=A0 =C2=A0 test_vdmpy_sf_hf(false);<br>
+=C2=A0 =C2=A0 test_vdmpy_sf_hf(true);<br>
+<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br>
diff --git a/tests/tcg/hexagon/fp_hvx_disabled.c b/tests/tcg/hexagon/fp_hvx=
_disabled.c<br>
new file mode 100644<br>
index 0000000000..af409ab8d2<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/fp_hvx_disabled.c<br>
@@ -0,0 +1,32 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;hexagon_types.h&gt;<br>
+#include &lt;hvx_hexagon_protos.h&gt;<br>
+<br>
+int err;<br>
+#include &quot;hvx_misc.h&quot;<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 asm volatile(&quot;r0 =3D #0xff\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v0 =3D=
 vsplat(r0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vmem(%=
1 + #0) =3D v0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;r1 =3D=
 #0x1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v1 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v2 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v0.sf =
=3D vadd(v1.sf, v2.sf)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vmem(%=
0 + #0) =3D v0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r&qu=
ot;(output), &quot;r&quot;(expect)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r0&q=
uot;, &quot;r1&quot;, &quot;v0&quot;, &quot;v1&quot;, &quot;v2&quot;, &quot=
;memory&quot;);<br></blockquote><div><br></div><div>Add a test where the re=
sult is used in a .new context.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 check_output_w(__LINE__, 1);<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br><br>
</blockquote></div></div>
</div>

--0000000000004b774c064dc9d6b8--

