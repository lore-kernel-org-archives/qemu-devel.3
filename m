Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAF0C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 03:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we2UL-0005k9-8M; Sun, 28 Jun 2026 23:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1we2UJ-0005jc-TF
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:16:47 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1we2UI-0003GT-AV
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:16:47 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-139aff562e1so4084508c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782703002; cv=none;
 d=google.com; s=arc-20260327;
 b=UTnAoVCmMGwuAnuhz3AlWUbyvIYrToJnQF5lSh/OiZbo1cH9U6KK3R4LW4oAuYD7XL
 FEiu0iFKYLYILop8ZD54xYgJV/XzQDfGaa253mq3HL/M6Tm33wlM5f8WQX0BnM8Rm59P
 a7m9pwFVuLzIYRbjcTq8guKCdwvwjOW6Gc4T76KY/GTSNkgunaf5Co4bj93jU+jfGq3p
 JPdKG8siBSte090TL3QnxQTDfJFkgx6Rz6AuGjJxXO/Ut5lYWmbOyJsC16bDWjKHSN4q
 bPGTHXeeZod31AYEWPdKvkxQhlNLLWvtE7VPHyir2oePo4k1adKGvAv0SEj2Tx0e+5ce
 VvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FU2Y6ZDnWGMedvRtL+6WB/8zpgvLcH9R4Cu7wZq3n8E=;
 fh=qlbVr9zkZNwWyChrtelH0BdFeveJ777FkAQ6cAYMIgY=;
 b=GKxdx/YQSNu3IyWR2MA0mz3qJqDEm5HWGhR40hzjlWkUB+L8QQJ1hGJgndCvLNuz0M
 6SKNI8cyJmgno7vrRTSvLbk79So2Zq6hDzC+LR15WG1+j4jhJYbl8jm2sfmEKmBR1zJI
 77Vp6wzdnRdLp8tC/+nkS5yMbPESNgGTVo+xNT3p62Yzjo0mzGZhGTPhMMWZAhLKiiW+
 B9HZNetHdWjucryva4LxM9to6872IE3eUrVcH8dAhOcCRMWcYXskdvvKe6t4Ql7o+94u
 eUIR0duEl5MO2VuR7Ma0z4nV7ps+d30ew5RZVCxRLx6yGjjNQ6j0hyP+O/WDAVIFKrjb
 +PeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782703002; x=1783307802; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FU2Y6ZDnWGMedvRtL+6WB/8zpgvLcH9R4Cu7wZq3n8E=;
 b=eIkRLsU/MkWFzYIgOJVodtBMVyEWa3Fw4PequMlDWvonulp6iCoqsXusZ+EYulgVxX
 l1I4Y7Zg/cLesJBz/ZacwhmXh9xCuB5U5j6kqMYI0QLEpPvuX1xeqTGOOrq5QgMHusfy
 +hwbYCa6JP6hpIn7AAOFoHB/BxUdtwKSTh4FBq5w/esCAxaac+RhXK0RZf7CFdFj8X4K
 kDqLvW0Wi6qTqqZ/nlQxAp5Q82aCS0W3ofgxUIXogHBtD0+eBE4pP9/hI4J/cmNAETn1
 KgzaUyKAunEWTlfqFk5JztcwkJqNPNBFcgCgIQahk+PWNnbitcE/bR6mg6KZmUJOmNAB
 /Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782703002; x=1783307802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FU2Y6ZDnWGMedvRtL+6WB/8zpgvLcH9R4Cu7wZq3n8E=;
 b=lS5gOTrNf6IICgpC4T4iFqsHJuP8lN5zK9ABcMcIY04y9JNYE+nbqOPxWShFnn8/T8
 VOkIxddNwq5FNDTpQAlALIQradW1JcaD9xOStFHHKy40dM1mPuT/cUPCboTZSCQ/Rl1Y
 pgMZ2ogPNjjsxoDHg6SNAJHV6Va+ipGVHsRe7eMVchVXpZBv1Aiw/Eb+dSsyNXZyy6Ah
 g/GijmPcDJyGlG5sj9YdUlUrgRQat6AP4ydhVnMEwz3u1hgBKvb81X6/Ygn8elEN2WgQ
 JKVYQDjCAQMuqq+ng8R/u4HSAWpy8IEAjzNFNf8PRrTccJc71BzDfjODep5iXXOhgv04
 kIlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+661J2mu+lo8+TgHAYERqbdl/h3ite03/i8Iq4a+qIBNzr2/cMKsdgQwlFGNUN2EQVU66H+8svoYk@nongnu.org
X-Gm-Message-State: AOJu0YwfA6O4CxRJ4GGgISq6PRoBqiTouYflfBkheGG0R4mTdfxGtz+O
 n9CGHc44pI6DGXA8fobV6wkpq3tmHHc402I3+OB6p18YTts9VDKCYgCKg1IhlFRCSviXg3RS/CK
 ubfJgt82bjkSthNz2jondNC9FjPib9p8=
X-Gm-Gg: AfdE7cmAbWDI20ljbc9KxuhF1lGMOiv6mKzxIBASY/VFpdlgsPV6yezzN28x5MVTtHF
 ezvlPoZXwxdkZCJs0EC8BPnCttRUKnSe+EuFyyYHHXEtCLjtcBvAD3XVlz/lBt3bh+oiqznYTmm
 j4KSG6mnEuKHgGicsmJjVzk0gp9D9yyyHCsfMmygoVBFA8jeD18FY2SPrEW8zHSDTx3dcCVmH3w
 pj1MP5rOfoMdYeBBd2eJvAFVOb0RNX1f97OoJrQD2//+XJaEw1dVwro9HJ8g7+361rdpxmkxkVG
 wbulB8LcfW9ST7ToUQiV/CYQqrk=
X-Received: by 2002:a05:7022:6192:b0:137:fdd8:c7f7 with SMTP id
 a92af1059eb24-139dbac92d9mr11784136c88.34.1782703002214; Sun, 28 Jun 2026
 20:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
 <78cee8b3-5fbe-432f-bb6d-0b2800630c2d@oss.qualcomm.com>
In-Reply-To: <78cee8b3-5fbe-432f-bb6d-0b2800630c2d@oss.qualcomm.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Mon, 29 Jun 2026 12:16:29 +0900
X-Gm-Features: AVVi8CcR4S2IT26wNd34FA7-AUVwuSCIhe5bDmoNQFpdyI6_FwVk9Nb2TeLz5SA
Message-ID: <CAEDrbUZcZvm0-tCkmU3Ez05tC5G82EgpL2czio+-xiJ_PafQVw@mail.gmail.com>
Subject: Re: [PATCH] configs/meson: disable hexagon idef-parser for emscripten
 builds
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002fe46506555be34d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1232.google.com
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

--0000000000002fe46506555be34d
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

> The idef-parser is a native build tool that requires glib-2.0 on the
> build machine. In emscripten cross builds, emconfigure sets
> PKG_CONFIG_LIBDIR to emscripten's sysroot which prevents native
> pkg-config from finding system-installed packages. Disable idef-parser
> by default for emscripten since the wasm target does not need it.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/meson/emscripten.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configs/meson/emscripten.txt b/configs/meson/emscripten.txt
> index 4230e88005f..c5c57e392a9 100644
> --- a/configs/meson/emscripten.txt
> +++ b/configs/meson/emscripten.txt
> @@ -6,3 +6,6 @@ objc_args = ['-pthread']
>  # configuration so explicitly add the flag here.
>  c_link_args =
['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
>  cpp_link_args =
['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
> +
> +[project options]
> +hexagon_idef_parser = false

Thanks for catching this.

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--0000000000002fe46506555be34d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Brian,</div><div><br></div><div dir=3D"ltr">&gt; T=
he idef-parser is a native build tool that requires glib-2.0 on the<br>&gt;=
 build machine. In emscripten cross builds, emconfigure sets<br>&gt; PKG_CO=
NFIG_LIBDIR to emscripten&#39;s sysroot which prevents native<br>&gt; pkg-c=
onfig from finding system-installed packages. Disable idef-parser<br>&gt; b=
y default for emscripten since the wasm target does not need it.<br>&gt; <b=
r>&gt; Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualc=
omm.com">brian.cain@oss.qualcomm.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0conf=
igs/meson/emscripten.txt | 3 +++<br>&gt; =C2=A01 file changed, 3 insertions=
(+)<br>&gt; <br>&gt; diff --git a/configs/meson/emscripten.txt b/configs/me=
son/emscripten.txt<br>&gt; index 4230e88005f..c5c57e392a9 100644<br>&gt; --=
- a/configs/meson/emscripten.txt<br>&gt; +++ b/configs/meson/emscripten.txt=
<br>&gt; @@ -6,3 +6,6 @@ objc_args =3D [&#39;-pthread&#39;]<br>&gt; =C2=A0#=
 configuration so explicitly add the flag here.<br>&gt; =C2=A0c_link_args =
=3D [&#39;-pthread&#39;,&#39;-sASYNCIFY=3D1&#39;,&#39;-sPROXY_TO_PTHREAD=3D=
1&#39;,&#39;-sFORCE_FILESYSTEM&#39;,&#39;-sALLOW_TABLE_GROWTH&#39;,&#39;-sT=
OTAL_MEMORY=3D2GB&#39;,&#39;-sWASM_BIGINT&#39;,&#39;-sEXPORT_ES6=3D1&#39;,&=
#39;-sASYNCIFY_IMPORTS=3Dffi_call_js&#39;,&#39;-sEXPORTED_RUNTIME_METHODS=
=3DaddFunction,removeFunction,TTY,FS&#39;]<br>&gt; =C2=A0cpp_link_args =3D =
[&#39;-pthread&#39;,&#39;-sASYNCIFY=3D1&#39;,&#39;-sPROXY_TO_PTHREAD=3D1&#3=
9;,&#39;-sFORCE_FILESYSTEM&#39;,&#39;-sALLOW_TABLE_GROWTH&#39;,&#39;-sTOTAL=
_MEMORY=3D2GB&#39;,&#39;-sWASM_BIGINT&#39;,&#39;-sEXPORT_ES6=3D1&#39;,&#39;=
-sASYNCIFY_IMPORTS=3Dffi_call_js&#39;,&#39;-sEXPORTED_RUNTIME_METHODS=3Dadd=
Function,removeFunction,TTY,FS&#39;]<br>&gt; +<br>&gt; +[project options]<b=
r>&gt; +hexagon_idef_parser =3D false<br><br></div><div dir=3D"ltr"><div>Th=
anks for catching this.</div><br>Reviewed-by: Kohei Tokunaga &lt;<a href=3D=
"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;</div></d=
iv>

--0000000000002fe46506555be34d--

