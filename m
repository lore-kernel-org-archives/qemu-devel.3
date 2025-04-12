Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A961C369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 09:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3WnF-00030I-Ib; Sat, 12 Apr 2025 05:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3WnE-000305-JP; Sat, 12 Apr 2025 05:04:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3WnC-00082S-Kl; Sat, 12 Apr 2025 05:04:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30820167b47so2182458a91.0; 
 Sat, 12 Apr 2025 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744448687; x=1745053487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oEiLipnvsKcQMkPKwfqRP4Rn+ofRlgKbhD3Gs9CpC+o=;
 b=UNpci7kf8b/L9QKsDKzC02jAOzAzsvbuKhwQCkWxI7tFwK5dQNrndAuNrF9Qgl93lT
 ngrw0ujYkRA+EXSl3Qj42aHDCFlPq82DKoubiSJ0sK4oH6d7ZkeJ5/w+/X9ehPdi1s8r
 BUx6Ch8sRTHwvDKlrZuvFsnohEWmb1ENgKd7kCrwHeyGZ1Xd9lTK7TqtGuqBUaYvdCRX
 F7fjy4qtwGJIaygtyolOIngLNhKpvEKQK2HTjkj77YJ4qUXEsYOLZywmkqCQlPLPbFwJ
 VGlS/RQTXt0l5WL50bnlaAPkComko2i1vCYF+9EuLtlcxJvep1NIwEVo4P58Q+ddAzpc
 AX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744448687; x=1745053487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oEiLipnvsKcQMkPKwfqRP4Rn+ofRlgKbhD3Gs9CpC+o=;
 b=BwtQkEuCiWsvraM1/MmeqQTt/PZs8vQda5tgFe2kyzYB65iPRzyPlddVfuuysI785Z
 cjSBrD7kd2hlCdSgmuggLakpeHCU3e6gNaW6lmif1qg7oNxaVXllaCtaKguOmnpeoaNe
 BeZ8dk65CYKEQiM+i0+kMRTUx1WNj4Sh0TJlexkcGzXGeVZSADl1YTuRyk0XoKJFpEHN
 RkhkkIWFW1uGc7QB39sJFrcGuyeC0TS3LZjrRL2BmVCHmQmPFSvz7YGVpjr+QBUzmpzy
 ytbRjA3wN3IzMSxgFfxfVRGhroIGy3OSqAahGdVYxT1QwgDV7bmdaznNEwZDI3a+cAOm
 iYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2z+r1kXlpHuap++jxIMWfxoTCLZm7NDS7yOweqRV7TGqwB5E5sy2M0pjQu0+qnTW3xaeZ//f96PuJaw==@nongnu.org,
 AJvYcCUtXBaaLQEjiWbVoDDEHWKBYo1OgsZPAzaDAIWpoDnIB1hO4Ha7GsycZZTWzQy0ppPlXTSyR0dj8+7Elg==@nongnu.org,
 AJvYcCV5CDoNzn4S0b8V2kRJ4AzJfxuz1XM2ZFBgjqfVcU5dnVtZrLjdFCh1ssQfzHIXg2SOrAtR366oqQ==@nongnu.org,
 AJvYcCWRQD9wjLDpXrYoFB7uRdAZ3GD3HiDLHuKUYpGSsjh5XajsRTATWmnBwW43LYY+uFnV/O/bzXXtAe9NTA==@nongnu.org
X-Gm-Message-State: AOJu0YwisuyrQ/6W4R9yQCXDCYNv3hOyd+ZL8AEx7aXlSE7AA5zCl+Wc
 8gWNNbbr2pE9otr2yfovwnQx7K0q/MKmDh70uPdTSG9sQrP+ifnio73RzvLdtVc1mIElqzhM/VZ
 o6M8NoymOq60kLobTc8C5La9LOIY=
X-Gm-Gg: ASbGncvDPPg2p+avo7wdoyeTWHBqhDqtStbJLikjMNH35uqSyRsK10eZysOkveZWRxP
 SmaYGND8jy1P6eiz0yUy9ZCvs53FUon/ljAJI9mmwe1qaOYhdfWhxRIe0Oe4bH7xU7QqCf4ENCH
 K0VF1PDuPIJqFwfmVlq1+XbtyvWwb5UQ0puv2mDH/lpaghVzwldch2sRLd9cB0DQ==
X-Google-Smtp-Source: AGHT+IFQ0eWcMBThgwrsDqQxBeUhx/8wH5Y0zRfw+lVVwVZWbQZ8ZkhT3Dhc6QF3VBzutjP/cPGhxwFNejUT6GOQg5M=
X-Received: by 2002:a17:90b:5111:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-30784d3f77emr15557946a91.11.1744448686486; Sat, 12 Apr 2025
 02:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <24b5ff124d70043aff97dc30aa45f8a502676989.1744032780.git.ktokunaga.mail@gmail.com>
 <264d9113-16ce-4c05-a468-78e1f9921df6@linaro.org>
In-Reply-To: <264d9113-16ce-4c05-a468-78e1f9921df6@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Sat, 12 Apr 2025 18:04:34 +0900
X-Gm-Features: ATxdqUFx6htIveUfw8JOGhtktwCwD1PA9Pd1byehNiK70ORRRwiyOyho3hePkAo
Message-ID: <CAEDrbUZO+vJZacBJeE2Od_9Eb+vjX1JYCsNz1QQA4MKFTi9cnw@mail.gmail.com>
Subject: Re: [PATCH 07/10] tcg: Add a TCG backend for WebAssembly
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000497be10632911ced"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1034.google.com
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

--000000000000497be10632911ced
Content-Type: text/plain; charset="UTF-8"

Hi Philippe, thank you for the feedback.

> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > index dfd48b8264..154a4dafa7 100644
> > --- a/tcg/tcg.c
> > +++ b/tcg/tcg.c
> > @@ -136,6 +136,10 @@ static void tcg_out_goto_tb(TCGContext *s, int
which);
> >   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
> >                          const TCGArg args[TCG_MAX_OP_ARGS],
> >                          const int const_args[TCG_MAX_OP_ARGS]);
> > +#if defined(EMSCRIPTEN)
>
> Maybe we can let this independently of EMSCRIPTEN, to reduce #ifdef'ry.

Sure, I'll make this independent of EMSCRIPTEN in the next version of the
series.

> > +static void tcg_out_label_cb(TCGContext *s, TCGLabel *l);
> > +static int tcg_out_tb_end(TCGContext *s);
> > +#endif
> >   #if TCG_TARGET_MAYBE_vec
> >   static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned
vece,
> >                               TCGReg dst, TCGReg src);
> > @@ -251,7 +255,7 @@ TCGv_env tcg_env;
> >   const void *tcg_code_gen_epilogue;
> >   uintptr_t tcg_splitwx_diff;
> >
> > -#ifndef CONFIG_TCG_INTERPRETER
> > +#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
>
> s/&&/||/ otherwise breaks TCI? (various cases)

Thank you for pointing this out. Let me break it down with a table to
clarify this logic.

                  | !defined(CONFIG_TCG_INTERPRETER) | !defined(EMSCRIPTEN)
| && | || |
------------------+----------------------------------+----------------------+----+----+
non-emcc + TCI    |              F                   |           T
 | F  |  T |
non-emcc + non-TCI|              T                   |           T
 | T  |  T |
emcc + TCI        |              F                   |           F
 | F  |  F |
emcc + wasm       |              T                   |           F
 | F  |  T |

If we use "||", this condition becomes always true for non-emscripten
builds, regardless of whether TCI is used. That would break TCI's intended
behaviour. On emscripten builds, both of TCI and wasm backends define
tcg_qemu_tb_exec on their own so the declaration here is unnecessary. This
aligns with the behaviour of "&&", not "||". So unless I'm missing
something, "&&" seems to match the intent?

That said, this condition is a bit complex. Parhaps we shoud introduce a
clearer flag (e.g., HAS_TCG_QEMU_TB_EXEC) in tcg-target.h?

> Out of curiosity, have you tried to run a big-endian guest?

I've just tried a s390x guest by booting Linux. It worked after applying a
small bugfix (unrelated to endianness, shown below). I'll include this fix
in the next verison of the patch series.

> @@ -1718,6 +1718,7 @@ static void tcg_wasm_out_sub2_i64(TCGContext *s,
TCGReg retl, TCGReg reth,
>          tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
>          tcg_wasm_out_op_global_get_r(s, al);
>          tcg_wasm_out_op_i64_gt_u(s);
> +        tcg_wasm_out_op_i64_extend_i32_s(s);
>
>          tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
>          tcg_wasm_out_op_global_set_r(s, retl);
> @@ -1727,6 +1728,7 @@ static void tcg_wasm_out_sub2_i64(TCGContext *s,
TCGReg retl, TCGReg reth,
>          tcg_wasm_out_op_global_get_r(s, retl);
>          tcg_wasm_out_op_global_get_r(s, al);
>          tcg_wasm_out_op_i64_gt_u(s);
> +        tcg_wasm_out_op_i64_extend_i32_s(s);
>      }

--000000000000497be10632911ced
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe, thank you for the feedback.<=
br><br>&gt; &gt; diff --git a/tcg/tcg.c b/tcg/tcg.c<br>&gt; &gt; index dfd4=
8b8264..154a4dafa7 100644<br>&gt; &gt; --- a/tcg/tcg.c<br>&gt; &gt; +++ b/t=
cg/tcg.c<br>&gt; &gt; @@ -136,6 +136,10 @@ static void tcg_out_goto_tb(TCGC=
ontext *s, int which);<br>&gt; &gt; =C2=A0 static void tcg_out_op(TCGContex=
t *s, TCGOpcode opc, TCGType type,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const TCGArg=
 args[TCG_MAX_OP_ARGS],<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int const_args[TC=
G_MAX_OP_ARGS]);<br>&gt; &gt; +#if defined(EMSCRIPTEN)<br>&gt; <br>&gt; May=
be we can let this independently of EMSCRIPTEN, to reduce #ifdef&#39;ry.<br=
><br>Sure, I&#39;ll make this independent of EMSCRIPTEN in the next version=
 of the<br>series.<br><br>&gt; &gt; +static void tcg_out_label_cb(TCGContex=
t *s, TCGLabel *l);<br>&gt; &gt; +static int tcg_out_tb_end(TCGContext *s);=
<br>&gt; &gt; +#endif<br>&gt; &gt; =C2=A0 #if TCG_TARGET_MAYBE_vec<br>&gt; =
&gt; =C2=A0 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsign=
ed vece,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGReg dst, TCGReg src=
);<br>&gt; &gt; @@ -251,7 +255,7 @@ TCGv_env tcg_env;<br>&gt; &gt; =C2=A0 c=
onst void *tcg_code_gen_epilogue;<br>&gt; &gt; =C2=A0 uintptr_t tcg_splitwx=
_diff;<br>&gt; &gt; =C2=A0 <br>&gt; &gt; -#ifndef CONFIG_TCG_INTERPRETER<br=
>&gt; &gt; +#if !defined(CONFIG_TCG_INTERPRETER) &amp;&amp; !defined(EMSCRI=
PTEN)<br>&gt; <br>&gt; s/&amp;&amp;/||/ otherwise breaks TCI? (various case=
s)<br><br>Thank you for pointing this out. Let me break it down with a tabl=
e to<br>clarify this logic.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | !defined(CONFIG_TCG_INTERPRETER) | !defined(EMSC=
RIPTEN) | &amp;&amp; | || |<br>------------------+-------------------------=
---------+----------------------+----+----+<br>non-emcc + TCI =C2=A0 =C2=A0=
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0F =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 T =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| F =C2=A0| =C2=A0T |<br>non-emcc +=
 non-TCI| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0T =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 T =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| T =C2=A0| =C2=A0T |<br>emc=
c + TCI =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0F =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 F =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
F =C2=A0| =C2=A0F |<br>emcc + wasm =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0T =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 F =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| F =C2=A0| =C2=A0T |<br><br>If we use &quot;||&quot;, =
this condition becomes always true for non-emscripten<br>builds, regardless=
 of whether TCI is used. That would break TCI&#39;s intended<br>behaviour. =
On emscripten builds, both of TCI and wasm backends define<br>tcg_qemu_tb_e=
xec on their own so the declaration here is unnecessary. This<br>aligns wit=
h the behaviour of &quot;&amp;&amp;&quot;, not &quot;||&quot;. So unless I&=
#39;m missing<br>something, &quot;&amp;&amp;&quot; seems to match the inten=
t?<br><br>That said, this condition is a bit complex. Parhaps we shoud intr=
oduce a<br>clearer flag (e.g., HAS_TCG_QEMU_TB_EXEC) in tcg-target.h?<br><b=
r>&gt; Out of curiosity, have you tried to run a big-endian guest?<br><br>I=
&#39;ve just tried a s390x guest by booting Linux. It worked after applying=
 a<br>small bugfix (unrelated to endianness, shown below). I&#39;ll include=
 this fix<br>in the next verison of the patch series.<br><br>&gt; @@ -1718,=
6 +1718,7 @@ static void tcg_wasm_out_sub2_i64(TCGContext *s, TCGReg retl, =
TCGReg reth,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_out_op_loca=
l_get(s, TMP64_LOCAL_0_IDX);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_=
wasm_out_op_global_get_r(s, al);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
tcg_wasm_out_op_i64_gt_u(s);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_=
out_op_i64_extend_i32_s(s);<br>&gt; =C2=A0<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_out_op_global_set_r(s, retl);<br>&gt; @=
@ -1727,6 +1728,7 @@ static void tcg_wasm_out_sub2_i64(TCGContext *s, TCGRe=
g retl, TCGReg reth,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_out=
_op_global_get_r(s, retl);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wa=
sm_out_op_global_get_r(s, al);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tc=
g_wasm_out_op_i64_gt_u(s);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_ou=
t_op_i64_extend_i32_s(s);<br>&gt; =C2=A0 =C2=A0 =C2=A0}<br><br></div></div>

--000000000000497be10632911ced--

