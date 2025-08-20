Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32907CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAd-0007Y2-9V; Wed, 20 Aug 2025 04:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoeAS-0006sk-Pt; Wed, 20 Aug 2025 04:27:37 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoeAN-00016H-1e; Wed, 20 Aug 2025 04:27:36 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b474a38b25cso2359112a12.0; 
 Wed, 20 Aug 2025 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755678448; x=1756283248; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V7fAKMSbTNa9ntikrP+lYZirQUgGeZAh7FsOcE/UtIs=;
 b=UvfZFgSd9ZSZKG6Lw7T1yJ/3DogMghew1uItLHF0DsTq6CbPMAWnSkdYEqu2ux78Gn
 PJXWwtNXdIp7S99I4b0/V256mjL99rjMSQlmmNLdNTRTYadDG+dsVsIMA/PAXg9n+fZU
 cxSR6HZqaR3Ndx3a4gHxkw7cL2teuHQTP8rx1TWzq64IBMl13OEZ+0eQB1tMCgc8LftI
 wcg3IJbIgJi5kMI/lF1UARs9y+w5eLNKigt37iXK+1fAfQHdXIIp68EEffSqP/+qzW3R
 4cbquE/MU187RSx/9VYddY+kYpsTzz2r8YsUNTUcn4ZSZ/tZzBthkAyUUhqLan3Fh7sw
 UJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755678448; x=1756283248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7fAKMSbTNa9ntikrP+lYZirQUgGeZAh7FsOcE/UtIs=;
 b=QL+DiWWK0jHlt5OIdM4NDL9rfr3LcpjGTxChOyiY5IkBJS5PPn51Nne6KjEd4FkSHu
 WeI40Xi6Ez/qUdVmT3M5aEHwOLfUA5DSMNmRAnei/lZxj762h1NMLKYcfbTKt5RcyTSL
 Liolw0SbfLSoFEJXVq6oSUKL9jgN3uuZsEyfGnfWNriLNdcpom71jQ21DhcpoxnaA2uh
 XC8xgVe/W5eIOQQZKUv8WezrkjdnyUQrRUXpBpiEIFDCKyH9wHswfWQSW/3CMZxnIxEw
 35ylYj3behkvovE4/d41gUaFHEm9nZx3FYxThq+Ca9/QaxPr06Msnj6gRRm7HpbtqHda
 HfIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCPif1UAeoOxvJJG4tTde7ILKEMQsKghD6vw+dmUZnCMzceZUiaNnF5idewu4svGX35OqnRyB+uw==@nongnu.org,
 AJvYcCUkFpmk5xM4bScTbNbgX4J/LYfl2MzM5TYT38dzwdKP7MgHftmKnasy0mEWaLQWvT7ihRdywwB78zj7uA==@nongnu.org,
 AJvYcCXABOxge7rf8Y4KJ1RY8rxzPL/q+bZyL7QhtFqxezLJsp3aZmIh65B9ntj5F4Wtr07D4EsQaqNFHu4LOA==@nongnu.org
X-Gm-Message-State: AOJu0Yw4XffJ6kBoPz+2HyWxgdIi7qKad4Ursehc6XtRFNyVMUKALiaD
 00On1qh1srA+8scCMuUK/dCabcybv7nSEzyq5JY9pLepTdQg+7kyGOD/q5Pe/ub0h2gktfZaohA
 KgcYuSw1KENuX2Xl8rmcfeMISqobzMg0=
X-Gm-Gg: ASbGncuB5wN7RGQxiQXG3LfSmKjMY0Jw6w7vrbsAvebze5tGU8npqowObwVKybfuquG
 wbm23W/4qUIlXP2Ji62BUqP2Ngxvo9buT9V9rZA4ywbuy/lj5lC/qy7cNrK/DuRGM2pvwHNHNxf
 4UFp5mMbYH9wfiku8hEQhV7Rs4PPWHA0ZxazxSArktVMpytsWFGo4VnfKtXQRrpnmPt3FZ0pMwg
 m3vLkqCfkxxbKB0K1YnZFYNnneMnxOrGJIBXx0F9fbeRWbi
X-Google-Smtp-Source: AGHT+IH1nsUb28CHqWUeZgZdTKrAL/O6lBCk9HZlgPtf6sIqdp3ca0S9KDAFHYiMQAA/4nlFHO4lvJCuhyOwVO/HCF8=
X-Received: by 2002:a17:903:228c:b0:23f:df36:5f0c with SMTP id
 d9443c01a7336-245ef22772emr23663335ad.29.1755678447798; Wed, 20 Aug 2025
 01:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
 <cf283ca6c957d3c454facb228000129c171c904f.1755623522.git.ktokunaga.mail@gmail.com>
 <ac5ac33d-26a7-4be6-bf02-75fa61d3ad9a@linaro.org>
In-Reply-To: <ac5ac33d-26a7-4be6-bf02-75fa61d3ad9a@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 20 Aug 2025 17:27:16 +0900
X-Gm-Features: Ac12FXzEH5igDaer4Lkq1pe4jEyNIefHUYYyQ9KTo6xtAmGNGg3VVLUN1b2noeQ
Message-ID: <CAEDrbUZo33Ay4efVr==sYmq+V_ya5NDXs6O9c_dHpLHOnDXc_w@mail.gmail.com>
Subject: Re: [PATCH 20/35] tcg/wasm: Add andc/orc/eqv/nand/nor instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000388da6063cc7be76"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x530.google.com
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

--000000000000388da6063cc7be76
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

> On 8/20/25 04:21, Kohei Tokunaga wrote:
> > This commit implements andc, orc, eqv, nand and nor operations using
Wasm
> > instructions.
> >
> > Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> > ---
> >   tcg/wasm/tcg-target.c.inc | 55 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 55 insertions(+)
> >
> > diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
> > index 01ef7d32f3..3c0374cd01 100644
> > --- a/tcg/wasm/tcg-target.c.inc
> > +++ b/tcg/wasm/tcg-target.c.inc
> > @@ -449,6 +449,56 @@ static void tcg_wasm_out_cond(
> >       }
> >   }
> >
> > +static void tcg_wasm_out_andc(
> > +    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
> > +{
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
> > +    tcg_wasm_out_op_not(s);
> > +    tcg_wasm_out_op(s, OPC_I64_AND);
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
> > +}
>
> Don't implement stuff that's not present in the ISA.
> This will be handled generically.

Thank you for the feedback. I'll remove them and rely on the default
expansion.

Regards,
Kohei

--000000000000388da6063cc7be76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard,<br><br>&gt; On 8/20/25 04:21,=
 Kohei Tokunaga wrote:<br>&gt; &gt; This commit implements andc, orc, eqv, =
nand and nor operations using Wasm<br>&gt; &gt; instructions.<br>&gt; &gt; =
<br>&gt; &gt; Signed-off-by: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga=
.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; =
&gt; =C2=A0 tcg/wasm/tcg-target.c.inc | 55 ++++++++++++++++++++++++++++++++=
+++++++<br>&gt; &gt; =C2=A0 1 file changed, 55 insertions(+)<br>&gt; &gt; <=
br>&gt; &gt; diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c=
.inc<br>&gt; &gt; index 01ef7d32f3..3c0374cd01 100644<br>&gt; &gt; --- a/tc=
g/wasm/tcg-target.c.inc<br>&gt; &gt; +++ b/tcg/wasm/tcg-target.c.inc<br>&gt=
; &gt; @@ -449,6 +449,56 @@ static void tcg_wasm_out_cond(<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; =C2=A0 }<br>&gt; &gt; =C2=A0 <br>&gt; &gt;=
 +static void tcg_wasm_out_andc(<br>&gt; &gt; + =C2=A0 =C2=A0TCGContext *s,=
 TCGReg ret, TCGReg arg1, TCGReg arg2)<br>&gt; &gt; +{<br>&gt; &gt; + =C2=
=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));<br>&gt; &g=
t; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));<br=
>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_not(s);<br>&gt; &gt; + =C2=A0 =C2=
=A0tcg_wasm_out_op(s, OPC_I64_AND);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_ou=
t_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));<br>&gt; &gt; +}<br>&gt; <br>&gt;=
 Don&#39;t implement stuff that&#39;s not present in the ISA.<br>&gt; This =
will be handled generically.<br><br>Thank you for the feedback. I&#39;ll re=
move them and rely on the default<br>expansion.<br><br>Regards,<br>Kohei<br=
><br></div></div>

--000000000000388da6063cc7be76--

