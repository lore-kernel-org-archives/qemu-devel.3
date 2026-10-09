Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB31CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9d5-0003Gq-FH; Fri, 09 Oct 2026 08:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xF9d0-0003E1-Bv
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:23:10 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xF9cy-00058A-6G
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:23:09 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab3d3c5761so39862957b3.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 05:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791548586; cv=none;
 d=google.com; s=arc-20260327;
 b=ZQRx2G0RkBgwgqmPz12iA8Pu67NITE4z/zVELhiJ6CZrXVCB4aRMCra8vwL+NZWJJe
 cAX13cbvYsSoLpWSVVIzzA6RV29LU/90OtqWUsxo4b91KsjSWvJ8JC1tlSthUs2KrR7n
 OzGKPhDV+DDXWHCR9pbo7tMHc2CBx+/WlWQxsuJjPbMmsXv9pSjjyGRC5oXjPjSWVt0G
 Gjh4EdE/EVgOjnypexCuLtaEZQOILiNggRAfURAMXD3McDoaQMzTppG48nL0bqa2hS8Q
 y6OSajqPNLBXc5OxTW5vEMagDp+IU7Tj2Dzff3FghnmnSpjkyllmA8LAstssHoZy2Arx
 GqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b1Yj0SpUYSJq9LvZoVSYP+vav1lYVlInSIp9/noOsCU=;
 fh=yGWAaXXYYQtYW+LCE7nyqmcq5QIuKbScqyYf4NVD8c4=;
 b=GlLXo6ROg1skSkTGPtgZlbjeKAR8EN3I0XYp8TRUlqSbmSTBmkUDGgg1aQz27eGNEh
 wMBOi6ZF7Gg07mdivkZJuJ0HncFajiq7yLDUXTMFwt3XgeXIMRtADgeBmb0ajbwKvrFu
 VHfJL5VIRIqF4DTqHr8aO8iOmMnEOjpQ96w/ZcktRW8k2G/umlKsIWexvQc5S/Uz+dnN
 Qrwb6aV3+LlScyZ0rEUJUWOBNe6Mb9S7G7sN53akh/gIA6ceAhFvKpJPtak1YsjVREOp
 0o+AuqrDW2CjusxuMhW20VOQVD94H9yYTeDeBA7KcO68mOuB+5+6cd/5HGMWI+dqW/s7
 YX+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791548586; x=1792153386; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b1Yj0SpUYSJq9LvZoVSYP+vav1lYVlInSIp9/noOsCU=;
 b=OmTEW99MtNiZCOUX56e17y0RxgXnbZhtjJMery+4fGzDg75YWuUnaeIzE9HoUZxt69
 W6ft/CE+x54CLgKlj9ezBPDA//5hMk/gNFqa/MEiBw4XbXTHOYz1cuPYAMg1dToWYiYk
 dVMf7f4/s5P9bM6uqZgtWyRmIVGt90N1hQC642OnwIOxHVn4LLgnoJlmLz75I5RhZr/O
 JgqhkrplQG9FgcYzD8V5HjA3GL/r4JFkraOdeADCABQre56EWjhXa1/Ww8bFob8eYrXw
 yLE262DGSWbkToPS4ZCElhaQTOgphJHEvDciSR+H6Yia+sMJw6WNLpo+NZDmspy4mmKa
 gqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548586; x=1792153386;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b1Yj0SpUYSJq9LvZoVSYP+vav1lYVlInSIp9/noOsCU=;
 b=wX1KYMjhRavW7a+KWJdguh0naYpOd3UHIdIudHE59H8gbm3XWUQv0VELaOcO9md5WM
 ULAeQafY7kBjjz+E8kpHyEVVXzSPFB5zvl9teOk3RP8X6M2+OMLPpJ3BQE5icaFd2292
 kUBhN7dIXOUq25dSuraSH9ZILeffC5j/8sclFR4y2eeoKfxAn1AND9jbGQ1FB9EEINOc
 oyYQIYIxsFiuVuqfN9rhYfnPGNba8YbQTPF5H0En8wliFB0LhE0V+EEXIR/HLejQk/D0
 Q3n0wnjawNy5X9qO9l2VzLaPWzCESqOHd/chwi+eqf6gwIi4P3wdCBBPWKg8t1DSNAZa
 g7sQ==
X-Gm-Message-State: AFq9FYLsex3JbsTe6U1k7B3tB9qyZnPGGJQWFt5mHzshmpJiQrJwc7Kr
 LObp74TPbNNemA+F3Ys9xzTbnY1MptzPjai9UMoDMdbg+a8R09wIpwJTTYf/vTQ3N6R7Bfo8rqd
 pkt+8/rzGTU+ncGUvR2Wx82jFkjjIu6X9LwJpDzfFeA==
X-Gm-Gg: AYBFou1yIqxeNpYKje1QRwT2IoGzUpaEMVUQeFeZpLuPDeFk9vguhW50Q/w4OcgRRil
 +XY8fAPl3sH4CKM+zV7Z0fYXJ4VmAPAH3KmEPcAE/MLrQD0cOaVBEodYpEzV6PiQ2ZdpVqETmK2
 gQzM1UdKOH6lEmYXA3bF84ZEA8/5SsKiujLCtmkWD3uSk/6S/FvC3XTK0ecPUL4Osibgqgnfk/U
 89+mX4QqVPVv7O4/7Xz9lZItHkLkJUIXDqLZG5lCMmkbi8WhPgmMy8o7qPZq2UHs1GqIOTNURpb
 vpQGv3tC9mcvhipojMdCHthnNNAZEzQa2bt4RQq18LwX0i4dR3NLrdOo+43fpwIdp0guXs7V2eJ
 6RHA954wXUA==
X-Received: by 2002:a05:690c:e20b:20b0:8a7:d419:e27c with SMTP id
 00721157ae682-8b07edc843bmr3961507b3.17.1791548586336; Fri, 09 Oct 2026
 05:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260924200420.21068-1-ralerrdirsardx@gmail.com>
In-Reply-To: <20260924200420.21068-1-ralerrdirsardx@gmail.com>
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
Date: Fri, 9 Oct 2026 15:22:54 +0300
X-Gm-Features: AclHuK-DNlxtryVnbybrZufM4oqiY9NcUa-wInQuskzMQ5sdszsa3ZLablMLHrI
Message-ID: <CAGHp__YzjZrLChjpCeJd7pY5juKuPZp7Wcfjcn_DZ8KvWGSBvA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: fix immediate stack adjustment for RET and
 RETF
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000162747065d67697a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-yw1-x112f.google.com
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

--000000000000162747065d67697a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch from September 24 fixing the signedness
of the RET/RETF imm16 stack adjustment (issue #2599).

Could you please take a look when you have time?
I'm happy to address any feedback.

Thanks,
Artemii


=D1=87=D1=82, 24 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 23:0=
5, Artemii Mashanov <ralerrdirsardx@gmail.com>:

> The imm16 operand of RET and RETF specifies an unsigned 16-bit count
> of additional bytes to release from the stack.
>
> Previously, gen_RET() and gen_RETF() stored this operand in an int16_t.
> For example, 0xcaf5 was interpreted as -13579 instead of 51957.
>
> Use uint16_t for the adjustment in both functions to preserve the
> immediate's unsigned value.
>
> Tested locally with near and far returns in both 32-bit and 64-bit
> modes. Each combination covered the form without an immediate and
> immediate values 0x0000, 0x0001, 0x7fff, 0x8000, 0xcaf5, and 0xffff.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2599
>
> Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
> ---
>  target/i386/tcg/emit.c.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 473f415766..0c35403ebc 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3598,7 +3598,7 @@ static void gen_RDxxBASE(DisasContext *s,
> X86DecodedInsn *decode)
>
>  static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
>  {
> -    int16_t adjust =3D decode->e.op1 =3D=3D X86_TYPE_I ? decode->immedia=
te : 0;
> +    uint16_t adjust =3D decode->e.op1 =3D=3D X86_TYPE_I ? decode->immedi=
ate : 0;
>
>      MemOp ot =3D gen_pop_T0(s);
>      gen_stack_update(s, adjust + (1 << ot));
> @@ -3609,7 +3609,7 @@ static void gen_RET(DisasContext *s, X86DecodedInsn
> *decode)
>
>  static void gen_RETF(DisasContext *s, X86DecodedInsn *decode)
>  {
> -    int16_t adjust =3D decode->e.op1 =3D=3D X86_TYPE_I ? decode->immedia=
te : 0;
> +    uint16_t adjust =3D decode->e.op1 =3D=3D X86_TYPE_I ? decode->immedi=
ate : 0;
>
>      if (!PE(s) || VM86(s)) {
>          gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
> --
> 2.55.0
>
>

--000000000000162747065d67697a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p><span>Hi,</span></p><p><span>Gentle ping on this patch =
from September 24 fixing the signedness</span><br><span>of the RET/RETF imm=
16 stack adjustment (issue #2599).</span></p><p><span>Could you please take=
 a look when you have time?</span><br><span>I&#39;m happy to address any fe=
edback.</span></p><p><span>Thanks,</span><br><span>Artemii</span></p><br></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">=D1=87=D1=82, 24 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=
=AF=D0=B3. =D0=B2 23:05, Artemii Mashanov &lt;<a href=3D"mailto:ralerrdirsa=
rdx@gmail.com">ralerrdirsardx@gmail.com</a>&gt;:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">The imm16 operand of RET and RETF specifie=
s an unsigned 16-bit count<br>
of additional bytes to release from the stack.<br>
<br>
Previously, gen_RET() and gen_RETF() stored this operand in an int16_t.<br>
For example, 0xcaf5 was interpreted as -13579 instead of 51957.<br>
<br>
Use uint16_t for the adjustment in both functions to preserve the<br>
immediate&#39;s unsigned value.<br>
<br>
Tested locally with near and far returns in both 32-bit and 64-bit<br>
modes. Each combination covered the form without an immediate and<br>
immediate values 0x0000, 0x0001, 0x7fff, 0x8000, 0xcaf5, and 0xffff.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2599" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2599</a><br>
<br>
Signed-off-by: Artemii Mashanov &lt;<a href=3D"mailto:ralerrdirsardx@gmail.=
com" target=3D"_blank">ralerrdirsardx@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/i386/tcg/emit.c.inc | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc<br>
index 473f415766..0c35403ebc 100644<br>
--- a/target/i386/tcg/emit.c.inc<br>
+++ b/target/i386/tcg/emit.c.inc<br>
@@ -3598,7 +3598,7 @@ static void gen_RDxxBASE(DisasContext *s, X86DecodedI=
nsn *decode)<br>
<br>
=C2=A0static void gen_RET(DisasContext *s, X86DecodedInsn *decode)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int16_t adjust =3D decode-&gt;e.op1 =3D=3D X86_TYPE_I ? deco=
de-&gt;immediate : 0;<br>
+=C2=A0 =C2=A0 uint16_t adjust =3D decode-&gt;e.op1 =3D=3D X86_TYPE_I ? dec=
ode-&gt;immediate : 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0MemOp ot =3D gen_pop_T0(s);<br>
=C2=A0 =C2=A0 =C2=A0gen_stack_update(s, adjust + (1 &lt;&lt; ot));<br>
@@ -3609,7 +3609,7 @@ static void gen_RET(DisasContext *s, X86DecodedInsn *=
decode)<br>
<br>
=C2=A0static void gen_RETF(DisasContext *s, X86DecodedInsn *decode)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int16_t adjust =3D decode-&gt;e.op1 =3D=3D X86_TYPE_I ? deco=
de-&gt;immediate : 0;<br>
+=C2=A0 =C2=A0 uint16_t adjust =3D decode-&gt;e.op1 =3D=3D X86_TYPE_I ? dec=
ode-&gt;immediate : 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!PE(s) || VM86(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_lea_ss_ofs(s, s-&gt;A0, cpu_regs[R_ES=
P], 0);<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div>

--000000000000162747065d67697a--

