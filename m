Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09D8C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXVJU-0007md-8k; Tue, 06 Feb 2024 18:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rXVJP-0007mT-Ko
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:57:11 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rXVJN-0003Wb-HF
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:57:11 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cf4d2175b2so768911fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707263827; x=1707868627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pvpz9mnxZyvQgP7CWm7jXS7dfi5DmPcy7EyRI+FmB7U=;
 b=fprrP4qIlCATKqG78NUxKLlg9CeTXegdR+DjJZVEVtqYLdt7VxAtb44t6DQOeo/8DW
 aAGqMgKvJRUw7FuBgApmcILPo2Oatn8XSz7Sp9uWZ6f6vm4BvTh9xIoscSxuC9q8+qv/
 Ki9asuWh9uurpigKDkkENArmTkA2xFeX8L99zFpgjsqPhvg6a1uiqbxm8bdm9cOhEl0W
 yKv4I1Z/VZ2pA6nIYeGQybZ4DjpwLSOcBr71E3xkk+htPCnjuuKIJdjvqHmRSfrSo+r7
 9/YGwGCa7UYyGz9E97ubBKskkNt/26sw+vSCmMy+Ri1JhMzqvHVGaTdWk7kWp7HpO41+
 ZJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707263827; x=1707868627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvpz9mnxZyvQgP7CWm7jXS7dfi5DmPcy7EyRI+FmB7U=;
 b=BEXSH31AbkNP+HSMX1m8yD+PnHP/Ymaz9ghj7AOECP8etaHBw/WJBLYVoXirqZdjDB
 YXKjPoKWg4XhGCuV/mA8sTm9Iwkg5ZGuUdRmtIxUbQEbF06j7opn5oHZzRB1T1MKH2ET
 4TDAU9fxmFWXujVaY9QymjzNxN9+3rvZ75mquhN0Dd6Lrv2XDmg/YOTSbWaGTePtZE4k
 mIEpQ2CX/6HrdLd7qvYlA6I8LnDHmHVawNh0k/q8xyu14D2f0UvgC/8Fcj3WYxdONm93
 wqj8XJsHd49iLfPBnlFzyRht4v7D4xRuL5UXR+RcnnmUVc5+gvh9imfe9tFoFSZkS/3y
 +7Vw==
X-Gm-Message-State: AOJu0YwPdniLxq0qb0f/lNY6ZhTd5B0Qj0cVq0aeCgl1FPD/vSLZ4BDh
 huEl4+EKr/lLUtG10OYdhV9YnhPRcbmw2xOZ5zHY12BaxO6uz7EQB7fOr+kZL1swtAgXDaiWP1a
 wl/qsze+NfC+GzBrKpVpe9z5i70M=
X-Google-Smtp-Source: AGHT+IHW8GkgD5FaV9R/0a7jQ1JfA+NCE0kNzCPxCgWIVBdOLgb8Jq9koo4LsX7MXvdsBsa32yzqSwcUE8MOECe+BEk=
X-Received: by 2002:a2e:99d5:0:b0:2d0:b1a9:dfba with SMTP id
 l21-20020a2e99d5000000b002d0b1a9dfbamr2994692ljj.29.1707263826597; Tue, 06
 Feb 2024 15:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-4-amonakov@ispras.ru>
In-Reply-To: <20240206204809.9859-4-amonakov@ispras.ru>
From: Elena Ufimtseva <ufimtseva@gmail.com>
Date: Tue, 6 Feb 2024 15:56:54 -0800
Message-ID: <CAEr7rXiMEm12YqUJ5r+Nur7iJxcvfxLKmasJKJ2QGmFhZL7-5Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] util/bufferiszero: remove AVX512 variant
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, Mikhail Romanov <mmromanov@ispras.ru>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ec1e120610bf55f0"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=ufimtseva@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000ec1e120610bf55f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alexander

On Tue, Feb 6, 2024 at 12:50=E2=80=AFPM Alexander Monakov <amonakov@ispras.=
ru>
wrote:

> Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
> routines are invoked much more rarely in normal use when most buffers
> are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
> frequency and voltage transition periods during which the CPU operates
> at reduced performance, as described in
> https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html


I would like to point out that the frequency scaling is not currently an
issue on AMD Zen4 Genoa CPUs, for example.
And microcode architecture description here:
https://www.amd.com/system/files/documents/4th-gen-epyc-processor-architect=
ure-white-paper.pdf
Although, the cpu frequency downscaling mentioned in the above document is
only in relation to floating point operations.
But from other online discussions I gather that the data path for the
integer registers in Zen4 is also 256 bits and it allows to avoid
frequency downscaling for FP and heavy instructions.
And looking at the optimizations for AVX2 in your other patch, would
unrolling the loop for AVX512 ops benefit from the speedup taken that the
data path has the same width?
If the frequency downscaling is not observed on some of the CPUs, can
AVX512 be maintained and used selectively for some
of the CPUs?

Thank you!


>
>
> Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> ---
>  util/bufferiszero.c | 36 ++----------------------------------
>  1 file changed, 2 insertions(+), 34 deletions(-)
>
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 01050694a6..c037d11d04 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -64,7 +64,7 @@ buffer_is_zero_len_4_plus(const void *buf, size_t len)
>      }
>  }
>
> -#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) ||
> defined(__SSE2__)
> +#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
>  #include <immintrin.h>
>
>  /* Note that each of these vectorized functions require len >=3D 64.  */
> @@ -128,35 +128,6 @@ buffer_zero_avx2(const void *buf, size_t len)
>  }
>  #endif /* CONFIG_AVX2_OPT */
>
> -#ifdef CONFIG_AVX512F_OPT
> -static bool __attribute__((target("avx512f")))
> -buffer_zero_avx512(const void *buf, size_t len)
> -{
> -    /* Begin with an unaligned head of 64 bytes.  */
> -    __m512i t =3D _mm512_loadu_si512(buf);
> -    __m512i *p =3D (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
> -    __m512i *e =3D (__m512i *)(((uintptr_t)buf + len) & -64);
> -
> -    /* Loop over 64-byte aligned blocks of 256.  */
> -    while (p <=3D e) {
> -        __builtin_prefetch(p);
> -        if (unlikely(_mm512_test_epi64_mask(t, t))) {
> -            return false;
> -        }
> -        t =3D p[-4] | p[-3] | p[-2] | p[-1];
> -        p +=3D 4;
> -    }
> -
> -    t |=3D _mm512_loadu_si512(buf + len - 4 * 64);
> -    t |=3D _mm512_loadu_si512(buf + len - 3 * 64);
> -    t |=3D _mm512_loadu_si512(buf + len - 2 * 64);
> -    t |=3D _mm512_loadu_si512(buf + len - 1 * 64);
> -
> -    return !_mm512_test_epi64_mask(t, t);
> -
> -}
> -#endif /* CONFIG_AVX512F_OPT */
> -
>  static unsigned __attribute__((noinline))
>  select_accel_cpuinfo(unsigned info)
>  {
> @@ -165,9 +136,6 @@ select_accel_cpuinfo(unsigned info)
>          unsigned bit;
>          bool (*fn)(const void *, size_t);
>      } all[] =3D {
> -#ifdef CONFIG_AVX512F_OPT
> -        { CPUINFO_AVX512F, buffer_zero_avx512 },
> -#endif
>  #ifdef CONFIG_AVX2_OPT
>          { CPUINFO_AVX2,    buffer_zero_avx2 },
>  #endif
> @@ -191,7 +159,7 @@ static unsigned used_accel
>      =3D 0;
>  #endif
>
> -#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
> +#if defined(CONFIG_AVX2_OPT)
>  static void __attribute__((constructor)) init_accel(void)
>  {
>      used_accel =3D select_accel_cpuinfo(cpuinfo_init());
> --
> 2.32.0
>
>
>

--=20
Elena

--000000000000ec1e120610bf55f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Alexander<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 6, 2024 =
at 12:50=E2=80=AFPM Alexander Monakov &lt;<a href=3D"mailto:amonakov@ispras=
.ru" target=3D"_blank">amonakov@ispras.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Thanks to early checks in the inli=
ne buffer_is_zero wrapper, the SIMD<br>
routines are invoked much more rarely in normal use when most buffers<br>
are non-zero. This makes use of AVX512 unprofitable, as it incurs extra<br>
frequency and voltage transition periods during which the CPU operates<br>
at reduced performance, as described in<br>
<a href=3D"https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html" rel=
=3D"noreferrer" target=3D"_blank">https://travisdowns.github.io/blog/2020/0=
1/17/avxfreq1.html</a></blockquote><div><br></div><div>I would like to poin=
t out that the frequency scaling is not currently an issue on AMD Zen4 Geno=
a CPUs, for example.</div><div>And microcode architecture description here:=
</div><div><a href=3D"https://www.amd.com/system/files/documents/4th-gen-ep=
yc-processor-architecture-white-paper.pdf">https://www.amd.com/system/files=
/documents/4th-gen-epyc-processor-architecture-white-paper.pdf</a></div><di=
v></div><div></div><div>Although, the cpu frequency downscaling mentioned i=
n the above document is only in relation to floating point operations.</div=
><div>But from other online discussions I gather that the data path for the=
 integer registers in Zen4 is also 256 bits and it allows to avoid=C2=A0</d=
iv><div>frequency downscaling for FP and heavy instructions.<br></div><div>=
</div>And looking at the optimizations for AVX2 in your other patch, would =
unrolling the loop for AVX512 ops benefit from the speedup taken that the d=
ata path has the same width?<br></div><div class=3D"gmail_quote"></div><div=
 class=3D"gmail_quote">If the frequency downscaling is not observed on some=
 of the CPUs, can AVX512 be maintained and used selectively for some <br></=
div><div class=3D"gmail_quote">of the CPUs?<br></div><div class=3D"gmail_qu=
ote"><br></div><div class=3D"gmail_quote">Thank you!<br></div><div class=3D=
"gmail_quote"><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
<br>
Signed-off-by: Mikhail Romanov &lt;<a href=3D"mailto:mmromanov@ispras.ru" t=
arget=3D"_blank">mmromanov@ispras.ru</a>&gt;<br>
Signed-off-by: Alexander Monakov &lt;<a href=3D"mailto:amonakov@ispras.ru" =
target=3D"_blank">amonakov@ispras.ru</a>&gt;<br>
---<br>
=C2=A0util/bufferiszero.c | 36 ++----------------------------------<br>
=C2=A01 file changed, 2 insertions(+), 34 deletions(-)<br>
<br>
diff --git a/util/bufferiszero.c b/util/bufferiszero.c<br>
index 01050694a6..c037d11d04 100644<br>
--- a/util/bufferiszero.c<br>
+++ b/util/bufferiszero.c<br>
@@ -64,7 +64,7 @@ buffer_is_zero_len_4_plus(const void *buf, size_t len)<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__S=
SE2__)<br>
+#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)<br>
=C2=A0#include &lt;immintrin.h&gt;<br>
<br>
=C2=A0/* Note that each of these vectorized functions require len &gt;=3D 6=
4.=C2=A0 */<br>
@@ -128,35 +128,6 @@ buffer_zero_avx2(const void *buf, size_t len)<br>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_AVX2_OPT */<br>
<br>
-#ifdef CONFIG_AVX512F_OPT<br>
-static bool __attribute__((target(&quot;avx512f&quot;)))<br>
-buffer_zero_avx512(const void *buf, size_t len)<br>
-{<br>
-=C2=A0 =C2=A0 /* Begin with an unaligned head of 64 bytes.=C2=A0 */<br>
-=C2=A0 =C2=A0 __m512i t =3D _mm512_loadu_si512(buf);<br>
-=C2=A0 =C2=A0 __m512i *p =3D (__m512i *)(((uintptr_t)buf + 5 * 64) &amp; -=
64);<br>
-=C2=A0 =C2=A0 __m512i *e =3D (__m512i *)(((uintptr_t)buf + len) &amp; -64)=
;<br>
-<br>
-=C2=A0 =C2=A0 /* Loop over 64-byte aligned blocks of 256.=C2=A0 */<br>
-=C2=A0 =C2=A0 while (p &lt;=3D e) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_prefetch(p);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(_mm512_test_epi64_mask(t, t))) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 t =3D p[-4] | p[-3] | p[-2] | p[-1];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p +=3D 4;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 t |=3D _mm512_loadu_si512(buf + len - 4 * 64);<br>
-=C2=A0 =C2=A0 t |=3D _mm512_loadu_si512(buf + len - 3 * 64);<br>
-=C2=A0 =C2=A0 t |=3D _mm512_loadu_si512(buf + len - 2 * 64);<br>
-=C2=A0 =C2=A0 t |=3D _mm512_loadu_si512(buf + len - 1 * 64);<br>
-<br>
-=C2=A0 =C2=A0 return !_mm512_test_epi64_mask(t, t);<br>
-<br>
-}<br>
-#endif /* CONFIG_AVX512F_OPT */<br>
-<br>
=C2=A0static unsigned __attribute__((noinline))<br>
=C2=A0select_accel_cpuinfo(unsigned info)<br>
=C2=A0{<br>
@@ -165,9 +136,6 @@ select_accel_cpuinfo(unsigned info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned bit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool (*fn)(const void *, size_t);<br>
=C2=A0 =C2=A0 =C2=A0} all[] =3D {<br>
-#ifdef CONFIG_AVX512F_OPT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CPUINFO_AVX512F, buffer_zero_avx512 },<br>
-#endif<br>
=C2=A0#ifdef CONFIG_AVX2_OPT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ CPUINFO_AVX2,=C2=A0 =C2=A0 buffer_zero_=
avx2 },<br>
=C2=A0#endif<br>
@@ -191,7 +159,7 @@ static unsigned used_accel<br>
=C2=A0 =C2=A0 =C2=A0=3D 0;<br>
=C2=A0#endif<br>
<br>
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)<br>
+#if defined(CONFIG_AVX2_OPT)<br>
=C2=A0static void __attribute__((constructor)) init_accel(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0used_accel =3D select_accel_cpuinfo(cpuinfo_init());<br=
>
-- <br>
2.32.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Elena</div></=
div>

--000000000000ec1e120610bf55f0--

