Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F77CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBEb6-0007Ju-1N; Mon, 28 Sep 2026 12:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1xBEb4-0007Jk-CM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:52:58 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1xBEb2-0003ba-3z
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:52:58 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso1665140a91.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790614374; cv=none;
 d=google.com; s=arc-20260327;
 b=Q9LDDzG9QoUyXW79/RmJUJmRIE2sYQZfOSJViwRJePYGYBUPvTOyb2FRIsaafQodIh
 HAPPuSW4zJj5A+i2REjTQGW+g1hlrlha+vWPz3Wu6O7QVbP/C6gCPMQiR27MVXtUH3KK
 WchEHZTP2gE+ZNSOkNQC82kPVcLGB0p+p7yVKKw+anJe+OKVxUfFWLR9ufp7SdxohbOG
 ydDzjOwElRYq11mp3JLrJ7b811wfH6Qruf0vXk8XZSE/8Ujam9eXok2IqPXd2VpFAvac
 TcwKAJUQlB149zRlhA+c6ZYBKCuGOGn84TBZuqxdGrHLqqL65sDikO7iYc1Oc/fcdDWG
 ssjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o9kN9xY0mEvCj/nfI+9lJdTn+X2tKBk+Cpoqlf2JFgY=;
 fh=aFQfxpNWovoQ01QbmIMn6V+zwDnbq7aiAeCFl39L+kU=;
 b=oTGQh5fH4u702RxoH8mtNjaL/Qu+w5yXvQhx6fM30JP70nJAQtO7CtjU9RvTBkZobk
 GZX0YhrcB5r3Sinsj1wOSwyE2NIlv8MEan1RS/8KXf7YAnJRxor7yFn3U1lmCZceGvI4
 lSYUJqwqmsZQtjmnIz2lTqn2H4T1ZbfEYfiUsdkLCPheBBlRAWXoSsin2AeuxBZcCWyp
 hJ1sgZ6mlMOGHf2MOjJPxcOJrzQBWc+MD99zGy+5z9v+HCaE4WX+2Wc0IPCeOOJQldE0
 ZWoVGIWR7rtmWl+CSPxBJiknESBDEfPouGXFSeNGMBEDuEeEYMgKRdysUL54S01FPeJg
 sfZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790614374; x=1791219174; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o9kN9xY0mEvCj/nfI+9lJdTn+X2tKBk+Cpoqlf2JFgY=;
 b=MX3PynPKSexMj4xadK7SeE8KEPPPHgQ2nm7eKbJVR9oMsgN5ck58BOe29yMVk8ljRB
 qdShALsUl5ah2BJgeJfuoOlpWMtmlT2bgK0RHuEn+W3NGa6F1Bw8amTEE+u4IXnu78OL
 iK8u8qv0KS7NmlQBVxwSlOf0Blr8KTUiGBfC2ltBnYbUouJRfSfNmRxZyMcK+pDY8teF
 dN8MfemT5hoScbOBiwWdCnDDqjjoRu7hL6YiwAyghu6kOcFz/8PgAarfKperwCcspRAT
 MKfuxkjT8NMhejdfujc1xPuQs6WMv5rmiRJV9qtU69hqRICZ1m7M6KjfoyCx2j8qZkq8
 uaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790614374; x=1791219174;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o9kN9xY0mEvCj/nfI+9lJdTn+X2tKBk+Cpoqlf2JFgY=;
 b=U03qIJktUdzv/adfMfxixi5ahy7Rvip5msBKdWlfjlEs6jFn3p8Kqa2kNazzS/beuQ
 wBt8mqDb5YzV1MOAnO8XYcIC8hnqn8oLd3Eow7FI/LRCQrWq0Y1LPLWFCjAegZhK4A+H
 d33aRMfzi/x0fRavtuppn2IF7JDNpuTTO1uo52fO/2i2308Uoa+LQA3b/kzRXlBnL2mf
 wbDAwVOH1aaI5KyXxOAhKJKVt8KrB6MkwldhFusLpAGsbm6pGyB/8xAwHygyJo8YzohI
 QSqp/LPZ9TO2dTyDIbNJUNC//k1eq+J7ST4QnAyIO6M7cxXy6vgDugp85bTJoWSwSmi6
 KdTQ==
X-Gm-Message-State: AFq9FYK2YLv0ZbCwp6LI1vjr6FfLQEpZUfyFhGvrRRmMrwox+RiW4RJN
 2Us14QNHo73poxkxbtwHH6SLBefjvvYtl4qFooslWc5a3RBhyDt5F3j8tn13gQpxJc/2rWoN2lO
 qZGLqoGQhoHUxwG62iMc/kjZip3NpIeI=
X-Gm-Gg: AYBFou171vA98N5NCyDDmPkRixARdQZaIoEvFSe2zKuQFc7OtWhxLJ+zG+MSdlRWddW
 hqWgBavBJ52zEEi0sf2R8U9HJwbOxiirxKSttDTJl7ekHCV56HzCuzhaI3/A8K1hqzT3xR277wD
 GQqaRw5A/Fs5CnjBRWu87+bkRqcP60WAKSuo1xZkGs+jt3dYfsipseND4k6/Vi3T9+rbCaGtQLw
 8mrHQ3v52a30wsupSM4xdoDk2a7eKy9o7ZRk/gUoWG76wW/+yB9LKbM2SWarhQXbB1AnytUkDbB
 xMDyU3IJdPrsYI3P94Mb+M5iMHotGRQu2CaPw8TDenjrTKNI/+8GnbzI0iCi34Trp0cRsHZ5Ztb
 p3fGVh2SRkWQt
X-Received: by 2002:a17:90b:3c91:b0:3a4:7a81:e6ad with SMTP id
 98e67ed59e1d1-3a47a81e754mr1819277a91.11.1790614374299; Mon, 28 Sep 2026
 09:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-3-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 28 Sep 2026 10:52:42 -0600
X-Gm-Features: AclHuK_BEqZH_GwG76rwgZQ0DC3lv8B1qMo6h1ColIci1YiFnrdj_B34eOgD0Kw
Message-ID: <CAATN3NqiYs5Pm3S02H1vwLmE_BEkG--jq=+XiL0bXxQnJcXZ9g@mail.gmail.com>
Subject: Re: [PATCH 02/10] tests/tcg/hexagon: Cover HVX vector write conflicts
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000b5ba5f065c8de572"
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj2-x0f.google.com
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

--000000000000b5ba5f065c8de572
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:23=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/multiple-writes.c | 98 +++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/tests/tcg/hexagon/multiple-writes.c
> b/tests/tcg/hexagon/multiple-writes.c
> index bd2b1384dd9..21771252020 100644
> --- a/tests/tcg/hexagon/multiple-writes.c
> +++ b/tests/tcg/hexagon/multiple-writes.c
> @@ -13,6 +13,7 @@
>
>  #include <assert.h>
>  #include <signal.h>
> +#include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -223,6 +224,80 @@ static int test_vreg_legal_predicated(void)
>      return sig;
>  }
>
> +/*
> + * Complementary predicated writes to the same V-register pair are legal=
.
> + * v16 and v22 are splatted with distinct patterns; since p0 is always
> + * true, v14 must end up holding v16's pattern.  Extracting a word from
> + * v14 confirms the executed branch actually ran, rather than merely tha=
t
> + * no SIGILL was raised.
> + */
> +static int test_vreg_pair_legal_predicated(void)
> +{
> +    int sig;
> +    uint32_t result;
> +
> +    asm volatile(
> +        "r0 =3D #0\n"
> +        "r1 =3D ##1f\n"
> +        "memw(%[resume_pc]) =3D r1\n"
> +        "r4 =3D #0x11111111\n"
> +        "r5 =3D #0x22222222\n"
> +        "v16 =3D vsplat(r4)\n"
> +        "v22 =3D vsplat(r5)\n"
>

Go ahead and assign something to v21 and v23 here.
Ultimately, the values aren't used but the registers are referenced in the
vcombine instructions below.
Alternatively, you could just use v16 and v22.  Something like
        "    if (p0) v15:14 =3D vcombine(v22, v16)\n"
        "    if (!p0) v15:14 =3D vcombine(v16, v22)\n"
If you do that, you can remove v21 and v23 from the clobber list.


> +        "r4 =3D #0\n"
> +        "p0 =3D cmp.eq(r0, r0)\n"
> +        "{\n"
> +        "    if (p0) v15:14 =3D vcombine(v21, v16)\n"
> +        "    if (!p0) v15:14 =3D vcombine(v23, v22)\n"
> +        "}\n"
> +        "%[result] =3D vextract(v14, r4)\n"
> +        "1:\n"
> +        "%[sig] =3D r0\n"
> +        : [sig] "=3Dr"(sig), [result] "=3Dr"(result)
> +        : [resume_pc] "r"(&resume_pc)
> +        : "r0", "r1", "r4", "r5", "p0",
> +          "v14", "v15", "v16", "v21", "v22", "v23", "memory");
> +
> +    return sig =3D=3D SIGILL ? SIGILL : result;
> +}
> +
> +/*
> + * A future write may consume a temporary value from the same V-register=
.
> + * buf is zeroed, so v0.tmp loads all-zero and v0.w =3D vadd(v0.tmp.w, 1=
)
> + * must end up as 1 in every word.  Extracting a word from the result
> + * confirms the add actually used the loaded .tmp value, rather than
> + * merely that no SIGILL was raised.
> + */
> +static int test_vreg_legal_tmp(void)
> +{
> +    long long buf[16] __attribute__((aligned(128)));
> +    int sig;
> +    uint32_t result;
> +
> +    memset(buf, 0, sizeof(buf));
> +
> +    asm volatile(
> +        "r0 =3D #0\n"
> +        "r1 =3D ##1f\n"
> +        "memw(%[resume_pc]) =3D r1\n"
> +        "r2 =3D %[buf]\n"
> +        "r3 =3D #1\n"
> +        "r4 =3D #0\n"
> +        "v1 =3D vsplat(r3)\n"
>

Consider putting something non-zero into v0 here.
That will be a stronger check that the read from buf actually took place.


> +        "{\n"
> +        "    v0.tmp =3D vmem(r2 + #0)\n"
> +        "    v0.w =3D vadd(v0.w, v1.w)\n"
> +        "}\n"
> +        "%[result] =3D vextract(v0, r4)\n"
> +        "1:\n"
> +        "%[sig] =3D r0\n"
> +        : [sig] "=3Dr"(sig), [result] "=3Dr"(result)
> +        : [resume_pc] "r"(&resume_pc), [buf] "r"(buf)
> +        : "r0", "r1", "r2", "r3", "r4", "v0", "v1", "memory");
> +
> +    return sig =3D=3D SIGILL ? SIGILL : result;
> +}
> +
>  static int test_vreg_illegal_mixed(void)
>  {
>      int sig;
> @@ -242,6 +317,26 @@ static int test_vreg_illegal_mixed(void)
>      return sig;
>  }
>
> +/* A pair write and a single write to either pair member are illegal. */
> +static int test_vreg_illegal_pair_overlap(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 =3D #0\n"
> +        "r1 =3D ##1f\n"
> +        "memw(%[resume_pc]) =3D r1\n"
>

Consider putting something into v14 and v15 here and check the values are
unchanged at the end.
Perhaps a subsequent patch that does this for all the illegal tests.


> +        ".word 0x1f5055ee    /* { v15:14 =3D vcombine(v21, v16) */\n"
> +        ".word 0x1e03e5ee    /*   v14 =3D v5 } */\n"
> +        "1:\n"
> +        "%[sig] =3D r0\n"
> +        : [sig] "=3Dr"(sig)
> +        : [resume_pc] "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +
>  static int test_vreg_illegal_uncond(void)
>  {
>      int sig;
> @@ -308,7 +403,10 @@ int main()
>      assert(test_post_increment3() =3D=3D SIGILL);
>
>      assert(test_vreg_legal_predicated() =3D=3D 23);
> +    assert(test_vreg_pair_legal_predicated() =3D=3D 0x11111111);
> +    assert(test_vreg_legal_tmp() =3D=3D 1);
>      assert(test_vreg_illegal_mixed() =3D=3D SIGILL);
> +    assert(test_vreg_illegal_pair_overlap() =3D=3D SIGILL);
>      assert(test_vreg_illegal_uncond() =3D=3D SIGILL);
>
>      assert(test_qreg_illegal() =3D=3D SIGILL);
> --
> 2.34.1
>

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000b5ba5f065c8de572
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 26,=
 2026 at 1:23=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Cc: Taylor Simpson &lt;<a href=3D"ma=
ilto:ltaylorsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</=
a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/multiple-writes.c | 98 ++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 98 insertions(+)<br>
<br>
diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multip=
le-writes.c<br>
index bd2b1384dd9..21771252020 100644<br>
--- a/tests/tcg/hexagon/multiple-writes.c<br>
+++ b/tests/tcg/hexagon/multiple-writes.c<br>
@@ -13,6 +13,7 @@<br>
<br>
=C2=A0#include &lt;assert.h&gt;<br>
=C2=A0#include &lt;signal.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;string.h&gt;<br>
@@ -223,6 +224,80 @@ static int test_vreg_legal_predicated(void)<br>
=C2=A0 =C2=A0 =C2=A0return sig;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Complementary predicated writes to the same V-register pair are legal.<=
br>
+ * v16 and v22 are splatted with distinct patterns; since p0 is always<br>
+ * true, v14 must end up holding v16&#39;s pattern.=C2=A0 Extracting a wor=
d from<br>
+ * v14 confirms the executed branch actually ran, rather than merely that<=
br>
+ * no SIGILL was raised.<br>
+ */<br>
+static int test_vreg_pair_legal_predicated(void)<br>
+{<br>
+=C2=A0 =C2=A0 int sig;<br>
+=C2=A0 =C2=A0 uint32_t result;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r1 =3D ##1f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memw(%[resume_pc]) =3D r1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r4 =3D #0x11111111\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r5 =3D #0x22222222\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;v16 =3D vsplat(r4)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;v22 =3D vsplat(r5)\n&quot;<br></blockquo=
te><div><br></div><div>Go ahead and assign something to v21 and v23 here.</=
div><div>Ultimately, the values aren&#39;t used but the registers are refer=
enced in the vcombine instructions below.</div><div>Alternatively, you coul=
d just use v16 and v22.=C2=A0 Something like</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;=C2=A0 =C2=A0 if (p0) v15:14 =3D vcombine(v22, v16)\n&quot;<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 if (!p0) v15:14 =3D vcomb=
ine(v16, v22)\n&quot;<br></div><div>If you do that, you can remove v21 and =
v23 from the clobber list.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r4 =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D cmp.eq(r0, r0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 if (p0) v15:14 =3D vcombin=
e(v21, v16)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 if (!p0) v15:14 =3D vcombi=
ne(v23, v22)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[result] =3D vextract(v14, r4)\n&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[sig] =3D r0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [sig] &quot;=3Dr&quot;(sig), [result] &quot;=
=3Dr&quot;(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [resume_pc] &quot;r&quot;(&amp;resume_pc)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;, &quot;r1&quot;, &quot;r4&quo=
t;, &quot;r5&quot;, &quot;p0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;v14&quot;, &quot;v15&quot;, &quot=
;v16&quot;, &quot;v21&quot;, &quot;v22&quot;, &quot;v23&quot;, &quot;memory=
&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return sig =3D=3D SIGILL ? SIGILL : result;<br>
+}<br>
+<br>
+/*<br>
+ * A future write may consume a temporary value from the same V-register.<=
br>
+ * buf is zeroed, so v0.tmp loads all-zero and v0.w =3D vadd(v0.tmp.w, 1)<=
br>
+ * must end up as 1 in every word.=C2=A0 Extracting a word from the result=
<br>
+ * confirms the add actually used the loaded .tmp value, rather than<br>
+ * merely that no SIGILL was raised.<br>
+ */<br>
+static int test_vreg_legal_tmp(void)<br>
+{<br>
+=C2=A0 =C2=A0 long long buf[16] __attribute__((aligned(128)));<br>
+=C2=A0 =C2=A0 int sig;<br>
+=C2=A0 =C2=A0 uint32_t result;<br>
+<br>
+=C2=A0 =C2=A0 memset(buf, 0, sizeof(buf));<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r1 =3D ##1f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memw(%[resume_pc]) =3D r1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r2 =3D %[buf]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r3 =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r4 =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;v1 =3D vsplat(r3)\n&quot;<br></blockquot=
e><div><br></div><div>Consider putting something non-zero into v0 here.</di=
v><div>That will be a stronger check that the read from buf actually took p=
lace.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 v0.tmp =3D vmem(r2 + #0)\n=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 v0.w =3D vadd(v0.w, v1.w)\=
n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[result] =3D vextract(v0, r4)\n&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[sig] =3D r0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [sig] &quot;=3Dr&quot;(sig), [result] &quot;=
=3Dr&quot;(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [resume_pc] &quot;r&quot;(&amp;resume_pc), [=
buf] &quot;r&quot;(buf)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;, &quot;r1&quot;, &quot;r2&quo=
t;, &quot;r3&quot;, &quot;r4&quot;, &quot;v0&quot;, &quot;v1&quot;, &quot;m=
emory&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return sig =3D=3D SIGILL ? SIGILL : result;<br>
+}<br>
+<br>
=C2=A0static int test_vreg_illegal_mixed(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int sig;<br>
@@ -242,6 +317,26 @@ static int test_vreg_illegal_mixed(void)<br>
=C2=A0 =C2=A0 =C2=A0return sig;<br>
=C2=A0}<br>
<br>
+/* A pair write and a single write to either pair member are illegal. */<b=
r>
+static int test_vreg_illegal_pair_overlap(void)<br>
+{<br>
+=C2=A0 =C2=A0 int sig;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r1 =3D ##1f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memw(%[resume_pc]) =3D r1\n&quot;<br></b=
lockquote><div><br></div><div>Consider putting something into v14 and v15 h=
ere and check the values are unchanged at the end.</div><div>Perhaps a subs=
equent patch that does this for all the illegal tests.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;.word 0x1f5055ee=C2=A0 =C2=A0 /* { v15:1=
4 =3D vcombine(v21, v16) */\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;.word 0x1e03e5ee=C2=A0 =C2=A0 /*=C2=A0 =
=C2=A0v14 =3D v5 } */\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[sig] =3D r0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [sig] &quot;=3Dr&quot;(sig)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [resume_pc] &quot;r&quot;(&amp;resume_pc)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;, &quot;r1&quot;, &quot;memory=
&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return sig;<br>
+}<br>
+<br>
=C2=A0static int test_vreg_illegal_uncond(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int sig;<br>
@@ -308,7 +403,10 @@ int main()<br>
=C2=A0 =C2=A0 =C2=A0assert(test_post_increment3() =3D=3D SIGILL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(test_vreg_legal_predicated() =3D=3D 23);<br>
+=C2=A0 =C2=A0 assert(test_vreg_pair_legal_predicated() =3D=3D 0x11111111);=
<br>
+=C2=A0 =C2=A0 assert(test_vreg_legal_tmp() =3D=3D 1);<br>
=C2=A0 =C2=A0 =C2=A0assert(test_vreg_illegal_mixed() =3D=3D SIGILL);<br>
+=C2=A0 =C2=A0 assert(test_vreg_illegal_pair_overlap() =3D=3D SIGILL);<br>
=C2=A0 =C2=A0 =C2=A0assert(test_vreg_illegal_uncond() =3D=3D SIGILL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(test_qreg_illegal() =3D=3D SIGILL);<br>
-- <br>
2.34.1<br></blockquote><div><br></div><div>Otherwise</div><div>Reviewed-by:=
 Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimp=
son@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000b5ba5f065c8de572--

