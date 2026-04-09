Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B89F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtAe-00028I-AC; Thu, 09 Apr 2026 13:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAtAc-000270-Qh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:27:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAtAa-0005YF-Vx
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:27:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2addb31945aso7856205ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775755675; cv=none;
 d=google.com; s=arc-20240605;
 b=VKrxLSs+vXa2kF9jnQars0a1OMNwQibJppSrHA5V6rZ1dB82Y7psgYzaBBcBkO9idW
 8PLOvNU7yDxJF24THi0i0oHzm4r5qcsAnt0k05V0zxcX8r/KC0gCRY2BqRNsA3hhDkhE
 CegYonVrLC1TKeKfBLffxhVnMi92oyeM4IyFyNZvhp8zR35lYDXYIC92SrqsTmV9i5Ah
 BMqqKSPdNl6knTLdoNKFnOrPCsDLdyf2GunQ6hhHQ+UhNVGzLr7BPyAgZOhTKNG2Qkgf
 nPLX8jrvAw+s4EMNqHM0KTDUPTDxy+crcIaZHngo5NXvhOe+WBZrja2npDClXCY6LVCz
 ozDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=da8dZHOAV15R7rSphM+0+4IQr+G/pblv8fdCwkg1+gE=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=JFSx9n79n2ldv+ZVlg5DuQZLv1YXvpLeeJuVHMjfGMg2WEH4Ea8nY1atOtSpONgC+z
 aWmm8tXRMduct+NXUbqFmYdwQ5M8Xhaft1fDlhVjUMTu8s4pszqIMYkfh2RLNjCDI5ik
 RgJn6R4drYKjXBNwJunhdCHPxGnYoeCYx+hLBcg/+3002npwP3fOQAZ/pWG9I5hC0IFU
 gmre4UoP1MbT774E3JBrIf0LEQJmIGrbXe2kX7rt0Bkwr+GIiqqxXLFP6yRLm1OoIHhh
 zsVIyPCC/p1GkeMEwIo9zAEgDMVe0yiIATSe0z7SgKBW5fYI7V8NR3Y4HSKMBxl0gH0P
 lnlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775755675; x=1776360475; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=da8dZHOAV15R7rSphM+0+4IQr+G/pblv8fdCwkg1+gE=;
 b=jQRrBRue3gv0SZWE8q9J2ExH5T8k0Xrrg1XMmGTB3gaOSxCMpBN2UabHyt6viCIVa5
 lT6kENZzjuXwkcNXi4vCbXye52clPnw1GpF9JmED+TrdoTBzYDgtBFqnOuaKb1wHvkKK
 F/69lGCVrBjpMvG7gMChXFZc6VbT47RXk/xgRkhTiSiBEY5dO1zXk1uKIWjJTS4dDj9f
 S3SFKBon3enlm8qo53pPaFFmZuaOjRTvEWRh7V4ryL1fCK6pLf9tZfOshqKwkRAE1uVq
 YlrtFfLftQP5cZawsCLQ3ZVC9NrSodzygZHPvnKp1wHjh2kt7Ou/iY2+j59qIjlPiZXc
 Leng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755675; x=1776360475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=da8dZHOAV15R7rSphM+0+4IQr+G/pblv8fdCwkg1+gE=;
 b=Gpq0I4JfHsw3X9hge3U1Ut6k73R+HIin0yQjuo/okOZ0+wVDqeH5/fSQ0b9fjVjb8T
 9hMXmP+RzF1bVppJqIi2gKqGV8N21fcXvUD03G70STgGLKMC0415JNgFiv7PqNJSn2dE
 8rCzVKtrd41+3mG5l2iQcDpz1z8952U/Ju6eZci+uwZo2Y85Pxb4fNRmiMpVdvMxb2m1
 8hPkmhsK4jXBOxOJQuJXycoRXKRgXHG99dHgo/BrzUIu0UMLppjdSehaYn2ZVkn8ETB1
 RakuFfx9lKCicFYWFyNA8S++lQG/ssyambaays1vZt0M0SSk1NPJNBXSKs4/Qg+QmZhS
 oehQ==
X-Gm-Message-State: AOJu0Yx5gA9niniyQ5Urd/0kOwwMVZKQv1ZsNwDwu3ihs+goxdaZQ8Z+
 S2PGcvS9Ousvr4KG5vcx2Dniw5Y3M5leYy5OJdseTl2gTreQ1bGUzv0tHn7t+iB5SBFZ02p1eZc
 HzIFV6RFYQC3Ut1uaZ/8YHljyNrVR7v8=
X-Gm-Gg: AeBDieuAJYLCarnH1reZdRCPt26u676hFM22SnKLUGU8laydWVYFdM9zvpnlqYadU6h
 4DASJmbIeAchI3n9NX0f8nCe4KtZsv8AUncslkn2nHdOU+XAA+zxgJ5h+hvsWMGDq6JxuJME+KB
 aww2cKGmZ4qD4hFV6/X9U5bEjGGcOSdTDU9QpbcoXeCwLsuoMbqNVDW7hNa6IcoMD5zeRTQVjJp
 16rRcs14vehA+fQFLKU2Pkd/K4iW9YznlAJM7JGhYtylmOS5LlhOK+gBmWJffxtZa2I0sW9j9/m
 FVfcUKc1PUi/L6Aj9dMILekUUk9f87ZUMbbJs2E=
X-Received: by 2002:a17:903:984:b0:2aa:d67b:ef96 with SMTP id
 d9443c01a7336-2b28191857emr266832315ad.31.1775755675454; Thu, 09 Apr 2026
 10:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <f46538124c66fdd7401438f88f9ba1a3e3a2baf5.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <f46538124c66fdd7401438f88f9ba1a3e3a2baf5.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Apr 2026 11:27:42 -0600
X-Gm-Features: AQROBzBcC5eXDBb1yPj6tkOdDdFR5z_kXS_iiIGO1b_SXjOReKOJgBMz4N1CvOw
Message-ID: <CAATN3NpLvCLEndqkRYOFq7VD0h-4=NfrAiPUO6EafnDst_Cb=A@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] tests/hexagon: add tests for v68 HVX IEEE float
 comparisons
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000003e52ec064f0a5632"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62e.google.com
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

--0000000000003e52ec064f0a5632
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hex_test.h      |   1 +
>  tests/tcg/hexagon/fp_hvx_cmp.c    | 227 ++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target |   3 +
>  3 files changed, 231 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
>
> diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c
> b/tests/tcg/hexagon/fp_hvx_cmp.c
> new file mode 100644
> +static void test_cmp_variants(void)
> +{
> +    HVX_VectorPred true_pred, false_pred, pred;
> +    memset(&true_pred, 0xff, sizeof(true_pred));
> +    memset(&false_pred, 0, sizeof(false_pred));
>

Minor nit - Use a single vector with a mix of true/false values instead of
one test with all-true and another test with all-false.


> +
> +    PREP_TEST();
> +    ADD_TEST_CMP(sf, SF_one,  SF_zero, true);
> +    ADD_TEST_CMP(sf, SF_zero, SF_one,  false);
> +    ADD_TEST_CMP(sf, SF_one,  SF_zero, true);
> +    ADD_TEST_CMP(sf, SF_zero, SF_one,  false);
> +
> +    /* greater and */
> +    pred =3D Q6_Q_vcmp_gtand_QVsfVsf(true_pred, buffers[0], buffers[1]);
> +    *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);
> +    for (int j =3D 0; j < 4; j++) {
> +        int exp =3D j % 2 ? 0 : 0xffffffff;
> +        if (output[0].sf[j] !=3D exp) {
> +            printf("ERROR line %d: gtand %d: expected 0x%x got 0x%x\n",
> +                   __LINE__, j, exp, output[0].sf[j]);
> +            err++;
> +        }
> +    }
> +    pred =3D Q6_Q_vcmp_gtand_QVsfVsf(false_pred, buffers[0], buffers[1])=
;
> +    *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);
> +    for (int j =3D 0; j < 4; j++) {
> +        if (output[0].sf[j]) {
> +            printf("ERROR line %d: gtand %d: expected false\n", __LINE__=
,
> j);
> +            err++;
> +        }
> +    }
> +
> +    /* greater or */
> +    pred =3D Q6_Q_vcmp_gtor_QVsfVsf(false_pred, buffers[0], buffers[1]);
> +    *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);
> +    for (int j =3D 0; j < 4; j++) {
> +        int exp =3D j % 2 ? 0 : 0xffffffff;
> +        if (output[0].sf[j] !=3D exp) {
> +            printf("ERROR line %d: gtor %d: expected 0x%x got 0x%x\n",
> +                   __LINE__, j, exp, output[0].sf[j]);
> +            err++;
> +        }
> +    }
> +    pred =3D Q6_Q_vcmp_gtor_QVsfVsf(true_pred, buffers[0], buffers[1]);
> +    *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);
> +    for (int j =3D 0; j < 4; j++) {
> +        if (!output[0].sf[j]) {
> +            printf("ERROR line %d: gtor %d: expected true\n", __LINE__,
> j);
> +            err++;
> +        }
>

Add a test for xor


> +    }
> +}
> +
> +int main(void)
> +{
> +    memset(&true_vec, 0xff, sizeof(true_vec));
> +    memset(&false_vec, 0, sizeof(false_vec));
> +
> +    test_cmp_sf();
> +    test_cmp_hf();
> +    test_cmp_variants();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
> diff --git a/tests/tcg/hexagon/Makefile.target
> b/tests/tcg/hexagon/Makefile.target
> index 83969e0e73..76ba245add 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -52,6 +52,7 @@ HEX_TESTS +=3D hvx_misc
>  HEX_TESTS +=3D hvx_histogram
>  HEX_TESTS +=3D fp_hvx
>  HEX_TESTS +=3D fp_hvx_cvt
> +HEX_TESTS +=3D fp_hvx_cmp
>  HEX_TESTS +=3D fp_hvx_disabled
>  HEX_TESTS +=3D invalid-slots
>  HEX_TESTS +=3D invalid-encoding
> @@ -135,6 +136,8 @@ fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
>  fp_hvx_disabled: CFLAGS +=3D -mhvx -mhvx-ieee-fp
>  fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h
>  fp_hvx_cvt: CFLAGS +=3D -mhvx -mhvx-ieee-fp
> +fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h
>

Also hex_test.h

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000003e52ec064f0a5632
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hex_test.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br=
>
=C2=A0tests/tcg/hexagon/fp_hvx_cmp.c=C2=A0 =C2=A0 | 227 +++++++++++++++++++=
+++++++++++<br>
=C2=A0tests/tcg/hexagon/Makefile.target |=C2=A0 =C2=A03 +<br>
=C2=A03 files changed, 231 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c<br>
<br>diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c b/tests/tcg/hexagon/fp_hvx_=
cmp.c<br>
new file mode 100644<br>+static void test_cmp_variants(void)<br>
+{<br>
+=C2=A0 =C2=A0 HVX_VectorPred true_pred, false_pred, pred;<br>
+=C2=A0 =C2=A0 memset(&amp;true_pred, 0xff, sizeof(true_pred));<br>
+=C2=A0 =C2=A0 memset(&amp;false_pred, 0, sizeof(false_pred));<br></blockqu=
ote><div><br></div><div>Minor nit - Use a single vector with a mix of true/=
false values instead of one test with all-true and another test with all-fa=
lse.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br>
+=C2=A0 =C2=A0 PREP_TEST();<br>
+=C2=A0 =C2=A0 ADD_TEST_CMP(sf, SF_one,=C2=A0 SF_zero, true);<br>
+=C2=A0 =C2=A0 ADD_TEST_CMP(sf, SF_zero, SF_one,=C2=A0 false);<br>
+=C2=A0 =C2=A0 ADD_TEST_CMP(sf, SF_one,=C2=A0 SF_zero, true);<br>
+=C2=A0 =C2=A0 ADD_TEST_CMP(sf, SF_zero, SF_one,=C2=A0 false);<br>
+<br>
+=C2=A0 =C2=A0 /* greater and */<br>
+=C2=A0 =C2=A0 pred =3D Q6_Q_vcmp_gtand_QVsfVsf(true_pred, buffers[0], buff=
ers[1]);<br>
+=C2=A0 =C2=A0 *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);<br=
>
+=C2=A0 =C2=A0 for (int j =3D 0; j &lt; 4; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int exp =3D j % 2 ? 0 : 0xffffffff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (output[0].sf[j] !=3D exp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;ERROR line %d: gtan=
d %d: expected 0x%x got 0x%x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__LIN=
E__, j, exp, output[0].sf[j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 pred =3D Q6_Q_vcmp_gtand_QVsfVsf(false_pred, buffers[0], buf=
fers[1]);<br>
+=C2=A0 =C2=A0 *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);<br=
>
+=C2=A0 =C2=A0 for (int j =3D 0; j &lt; 4; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (output[0].sf[j]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;ERROR line %d: gtan=
d %d: expected false\n&quot;, __LINE__, j);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* greater or */<br>
+=C2=A0 =C2=A0 pred =3D Q6_Q_vcmp_gtor_QVsfVsf(false_pred, buffers[0], buff=
ers[1]);<br>
+=C2=A0 =C2=A0 *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);<br=
>
+=C2=A0 =C2=A0 for (int j =3D 0; j &lt; 4; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int exp =3D j % 2 ? 0 : 0xffffffff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (output[0].sf[j] !=3D exp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;ERROR line %d: gtor=
 %d: expected 0x%x got 0x%x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__LIN=
E__, j, exp, output[0].sf[j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 pred =3D Q6_Q_vcmp_gtor_QVsfVsf(true_pred, buffers[0], buffe=
rs[1]);<br>
+=C2=A0 =C2=A0 *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);<br=
>
+=C2=A0 =C2=A0 for (int j =3D 0; j &lt; 4; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!output[0].sf[j]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;ERROR line %d: gtor=
 %d: expected true\n&quot;, __LINE__, j);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Add a te=
st for xor</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 memset(&amp;true_vec, 0xff, sizeof(true_vec));<br>
+=C2=A0 =C2=A0 memset(&amp;false_vec, 0, sizeof(false_vec));<br>
+<br>
+=C2=A0 =C2=A0 test_cmp_sf();<br>
+=C2=A0 =C2=A0 test_cmp_hf();<br>
+=C2=A0 =C2=A0 test_cmp_variants();<br>
+<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br>
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile=
.target<br>
index 83969e0e73..76ba245add 100644<br>
--- a/tests/tcg/hexagon/Makefile.target<br>
+++ b/tests/tcg/hexagon/Makefile.target<br>
@@ -52,6 +52,7 @@ HEX_TESTS +=3D hvx_misc<br>
=C2=A0HEX_TESTS +=3D hvx_histogram<br>
=C2=A0HEX_TESTS +=3D fp_hvx<br>
=C2=A0HEX_TESTS +=3D fp_hvx_cvt<br>
+HEX_TESTS +=3D fp_hvx_cmp<br>
=C2=A0HEX_TESTS +=3D fp_hvx_disabled<br>
=C2=A0HEX_TESTS +=3D invalid-slots<br>
=C2=A0HEX_TESTS +=3D invalid-encoding<br>
@@ -135,6 +136,8 @@ fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h<br>
=C2=A0fp_hvx_disabled: CFLAGS +=3D -mhvx -mhvx-ieee-fp<br>
=C2=A0fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h<br>
=C2=A0fp_hvx_cvt: CFLAGS +=3D -mhvx -mhvx-ieee-fp<br>
+fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h<br></blockquote><div><br></div><div>Al=
so hex_test.h</div><div><br></div><div>Otherwise</div><div>Reviewed-by: Tay=
lor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@=
gmail.com</a>&gt;</div><div><br></div></div></div>

--0000000000003e52ec064f0a5632--

