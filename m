Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE198C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 14:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2rBX-0002jC-FG; Sat, 05 Sep 2026 10:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2rBW-0002j2-2K
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 10:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2rBT-0004o5-Tj
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 10:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788617754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y257Mw8dXSVIqdbAEDYSvIagO+dCSVaWX+3e2nCVU8o=;
 b=dl6HVhEet+nstZV+MhIrwqWrcTntT44L9O+uf5r2p864vOiuS64YP54T5lrttetfaIEq8/
 Cbib0Ksqh7+K5vADDCOufZQTZX04iGykDYEdrgOYqaE2NBynQN2zUPdu4yH0lCFwsXNxqL
 FHSJKWTS+4ipJXCu+Of8/1/JSNmzJpo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Ci4tfWzgOTq6BIRHtkwDoQ-1; Sat, 05 Sep 2026 10:15:52 -0400
X-MC-Unique: Ci4tfWzgOTq6BIRHtkwDoQ-1
X-Mimecast-MFC-AGG-ID: Ci4tfWzgOTq6BIRHtkwDoQ_1788617751
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-484357599a4so1306035f8f.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 07:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788617751; cv=none;
 d=google.com; s=arc-20260327;
 b=gML1g3wkL2pi7QOl9Ma69mVF8XgLcJ+17kRYn2mwpAxG/DGhzVpXLv/XjKRoL/BajI
 0AYxYocoybeUseT7VhZ2H4f0L+Hcy3W+S3odFqcWSkuNLSdTY3UkdRXWzhYoawfhWh+A
 1k7SKICJJPKrARrZZtSwcSqdlrljEUnVFlVBl5jpZkyQhX2Tz18aXdqhDHTbkJNJ94zu
 EbYHTUIPoflJVfPSGnNbiFks9yD+FEJazIli/rK+2D8dfxWu0Qzq4KfkgqlFY2WZZBJB
 SOQ2plPHTPFUHi9CZYWHJ3EQ21JeEfwCGMe6WccviWk04/mgX6qkaBN05DoggUv7G4do
 x+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y257Mw8dXSVIqdbAEDYSvIagO+dCSVaWX+3e2nCVU8o=;
 fh=V9+71croMFy7g4qkDc9jmUXy3V+s2UVp5dMTtywG71c=;
 b=XNq0hUKGUCz3+luikgf8kccXthaRlEnUaihzw7ZmTHxPQMGNCA7rIMbHR+TIy/qdxR
 LuNg8j3A5BitSkh2DXqGwArS5OsuUG3CLxuL6svSqvQd0lzo/QZofhEuR40jDymmr+Uz
 rLFsHP9wtFyKsLaGzMp9l6hUtZtKMC5gIpIv2MnXtfmOqfc6aED2a1wEi+Q6oJkY1ucw
 gJUQ9P5rH2r6LxaFIJMzUSHgT3O782tokmTDnw7WiTIdIMFwzAN5avjxyty9rK9Ym67m
 zg26R5jopEt5bHgPMOopgNDoVmLNtV3L2qyJ/C1ZSpn/P+Ng0307jBwzVe0Lroar9Zo/
 OfTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788617751; x=1789222551; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y257Mw8dXSVIqdbAEDYSvIagO+dCSVaWX+3e2nCVU8o=;
 b=HrnDyqXQDbrbDgBQCwJ934v4cno+sNzi7IiYl8yeiZZ/jQeLfxsXsLq/oPKA2RDiLW
 zhmHY9+6aUf127L6EWvxTZU5dmGxeJ+6iM2mfs7Kmck40q2ip0V1U7321/AswwomZ0sp
 VfRQ8SAlqGze/3uhlTXdWiualKRlXH32pscW5zYiRbX7aq2KLThQwTA/oJ2QuaIf4lg3
 mhkRFfqkhP3t2slWPs7OwQVy/yWxKWYHkc4YID6gmg9IJ5CWDSAE6P2D4Cjo4dGTBdE7
 vvV4qHPCdYVkB9HHjnLirjUifsFUeRa2GPsstTPyw1UjfGvujrnMeCB3fWXy5oBCzOfL
 6Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788617751; x=1789222551;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y257Mw8dXSVIqdbAEDYSvIagO+dCSVaWX+3e2nCVU8o=;
 b=DS/1P2QsNEAsvvsyU8imE7keDHjtTJEz4cmeml8t/WOb/g8LgNOyoVzTDvpYZ4iaqZ
 DHo5EBSv0gU5CyqbnjorDiUQs4PGYmWv7R4JYiY2KIm4JZL/EgDfkwp2KRNIMdntu7ie
 UhQGM0aUzhtWJcToQbB/RNQuoPAIhWiRfHUULexxBo9uUpBRHqT2Y084dubfbtFAmV1j
 jo/mAvCvNMsaZuBSn0UNb17dDRN6bJrN5srWuK1pA4a56rusKoH0QGVsCtcjSCj86n1x
 iLTfJB6YrVJePCibVp+GEesQH4R12UudroJwCeHdKSVItN0cQknLSHjb9b4Ebreg6w3W
 mMiQ==
X-Gm-Message-State: AFuF++niUGgXEIxp6RQVbj15YhrR5f0zwGst/tohOMGrFjIbm+g/m7F+
 fANMgvLcBZkpafp44NMtrBaufF8Tsnou5zfFc4tKCfnQDEkma+Di0I2ETx/N6vOX6qHnVyJu9S+
 GLEJV8gKlz3Zu6HLWhKd5lH1d/4sQYMle6Fp83d4N+tW1Nus4PZ085aUdi5fAoBTUMGjP4uddRJ
 cfJHQsJThFRrhATljTFoseU1QbdeLb1o8=
X-Gm-Gg: AYBFou0kS3qy9YKZhdfNMDkCOrJeCc+nWeChEr2El+Ufrf+aygsniAktZAIYm99ceFB
 N5QFFOTaC0+egdscyKLqmzwrn2ySBn6ns4AluklMMJxQATf/Fc+1gKVhywkXZiSxf+64Jjt4F7q
 AfmkdPbk7CqONx2Q005pBbwPg0wfEruf99CUO2Nfx+gZgyYxZ5d7ZiIT5wmZZA6JbOAr+6NeNfR
 cU1G6OUM8ohVCKn0Uz8M5iwWj/t4EyNhBpc0VyW6dOk+P7so9K4lIu6cEQbtA==
X-Received: by 2002:a05:6000:1acb:b0:485:8b5d:96d with SMTP id
 ffacd0b85a97d-4858b5d0d2dmr18823763f8f.19.1788617751091; 
 Sat, 05 Sep 2026 07:15:51 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:485:8b5d:96d with SMTP id
 ffacd0b85a97d-4858b5d0d2dmr18823676f8f.19.1788617750650; Sat, 05 Sep 2026
 07:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260905014629.991586-1-apolivodaa433@gmail.com>
In-Reply-To: <20260905014629.991586-1-apolivodaa433@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 5 Sep 2026 16:15:40 +0200
X-Gm-Features: AcwNN1UrcJHf7rQRH2NLKgnAcjwZnBPTI0Zi4CBNC0rnLM9tHQYuBrCvLDgFBMw
Message-ID: <CABgObfa4+CzMVN4xj=71cfJL6eMdMWqCoEvQ5RKvPNcR79XO4w@mail.gmail.com>
Subject: Re: [PATCH] target/i386: ignore VEX.L when emitting VROUNDSS and
 VROUNDSD
To: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000aabbe6065abd052a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000aabbe6065abd052a
Content-Type: text/plain; charset="UTF-8"

Il sab 5 set 2026, 03:46 Andrey Polivoda <apolivodaa433@gmail.com> ha
scritto:

> According to both Volume 2 of Intel 64 and IA-32 Architectures Software
> Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
> VEX.L is a "don't care" bit for `VROUNDSS` and `VROUNDSD`.
>
> Currently, QEMU has an assertion in `gen_VROUNDSS()` and `gen_VROUNDSD()`,
> which checks that `s->vex_l` is not set. When either instruction is
> encountered
> with VEX.L bit set, the QEMU process crashes with an assertion failure.
>
> Not only does this behavior deviate from real hardware, but it also
> allows unprivileged guest userspace to crash the QEMU process itself.
>

Good catch - though, note that TCG is not considered a security boundary.


>      case X86_SIZE_ps: /* SSE/AVX packed single precision */
> -    case X86_SIZE_pd: /* SSE/AVX packed double precision */
> -        *ot = s->vex_l ? MO_256 : MO_128;
> +    case X86_SIZE_pd: { /* SSE/AVX packed double precision */
> +            bool is_scalar = (e->s0 == X86_SIZE_ss || e->s0 ==
> X86_SIZE_sd ||
> +                              e->s1 == X86_SIZE_ss || e->s1 ==
> X86_SIZE_sd ||
> +                              e->s2 == X86_SIZE_ss || e->s2 ==
> X86_SIZE_sd);
> +            *ot = (s->vex_l && !is_scalar) ? MO_256 : MO_128;
> +        }
>

Oh, this also applies to VMOVSS, VSQRTSS, etc. but that's actually correct
- they're all VEX.LIG. It's worth listing these instructions above the
declaration of is_scalar.

Paolo

         return true;
>
>      case X86_SIZE_xh: /* SSE/AVX packed half register */
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index c83ab80940..7e0d439f6d 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -4642,14 +4642,12 @@ static void gen_VPHMINPOSUW(DisasContext *s,
> X86DecodedInsn *decode)
>  static void gen_VROUNDSD(DisasContext *s, X86DecodedInsn *decode)
>  {
>      TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
> -    assert(!s->vex_l);
>      gen_helper_roundsd_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2, imm);
>  }
>
>  static void gen_VROUNDSS(DisasContext *s, X86DecodedInsn *decode)
>  {
>      TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
> -    assert(!s->vex_l);
>      gen_helper_roundss_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2, imm);
>  }
>
> --
> 2.53.0
>
>

--000000000000aabbe6065abd052a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 5 set 2026, 03:46 Andrey =
Polivoda &lt;<a href=3D"mailto:apolivodaa433@gmail.com">apolivodaa433@gmail=
.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">According to both Volume 2 of Intel 64 and IA-32 Architectures S=
oftware<br>
Developer&#39;s Manual and Volume 4 of AMD64 Architecture Programmer&#39;s =
Manual,<br>
VEX.L is a &quot;don&#39;t care&quot; bit for `VROUNDSS` and `VROUNDSD`.<br=
>
<br>
Currently, QEMU has an assertion in `gen_VROUNDSS()` and `gen_VROUNDSD()`,<=
br>
which checks that `s-&gt;vex_l` is not set. When either instruction is enco=
untered<br>
with VEX.L bit set, the QEMU process crashes with an assertion failure.<br>
<br>
Not only does this behavior deviate from real hardware, but it also<br>
allows unprivileged guest userspace to crash the QEMU process itself.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Good c=
atch - though, note that TCG is not considered a security boundary.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
=C2=A0 =C2=A0 =C2=A0case X86_SIZE_ps: /* SSE/AVX packed single precision */=
<br>
-=C2=A0 =C2=A0 case X86_SIZE_pd: /* SSE/AVX packed double precision */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ot =3D s-&gt;vex_l ? MO_256 : MO_128;<br>
+=C2=A0 =C2=A0 case X86_SIZE_pd: { /* SSE/AVX packed double precision */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_scalar =3D (e-&gt;s0 =3D=
=3D X86_SIZE_ss || e-&gt;s0 =3D=3D X86_SIZE_sd ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;s1 =3D=3D X86_SIZE_ss || e-&gt;s1 =3D=
=3D X86_SIZE_sd ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e-&gt;s2 =3D=3D X86_SIZE_ss || e-&gt;s2 =3D=
=3D X86_SIZE_sd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ot =3D (s-&gt;vex_l &amp;&amp; =
!is_scalar) ? MO_256 : MO_128;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Oh, this also applies to VMOVSS, VSQRTSS, etc=
. but that&#39;s actually correct - they&#39;re all VEX.LIG. It&#39;s worth=
 listing these instructions above the declaration of is_scalar.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case X86_SIZE_xh: /* SSE/AVX packed half register */<br=
>
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc<br>
index c83ab80940..7e0d439f6d 100644<br>
--- a/target/i386/tcg/emit.c.inc<br>
+++ b/target/i386/tcg/emit.c.inc<br>
@@ -4642,14 +4642,12 @@ static void gen_VPHMINPOSUW(DisasContext *s, X86Dec=
odedInsn *decode)<br>
=C2=A0static void gen_VROUNDSD(DisasContext *s, X86DecodedInsn *decode)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGv_i32 imm =3D tcg_constant8u_i32(decode-&gt;immediat=
e);<br>
-=C2=A0 =C2=A0 assert(!s-&gt;vex_l);<br>
=C2=A0 =C2=A0 =C2=A0gen_helper_roundsd_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PT=
R2, imm);<br>
=C2=A0}<br>
<br>
=C2=A0static void gen_VROUNDSS(DisasContext *s, X86DecodedInsn *decode)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGv_i32 imm =3D tcg_constant8u_i32(decode-&gt;immediat=
e);<br>
-=C2=A0 =C2=A0 assert(!s-&gt;vex_l);<br>
=C2=A0 =C2=A0 =C2=A0gen_helper_roundss_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PT=
R2, imm);<br>
=C2=A0}<br>
<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div></div>

--000000000000aabbe6065abd052a--


