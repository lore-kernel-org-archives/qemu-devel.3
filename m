Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB39DCA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe7B-0003B0-Mm; Wed, 20 Aug 2025 04:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoe7A-0003Aj-Nb; Wed, 20 Aug 2025 04:24:12 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoe78-0000Rl-SY; Wed, 20 Aug 2025 04:24:12 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b47174c3817so4505132a12.2; 
 Wed, 20 Aug 2025 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755678248; x=1756283048; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ayVoMlGV644opSYSNfnrBKX1rKw9RzMeodw+Qepq4JE=;
 b=PFyidfs29zGGPKHTZNStoBvTLnUyrS5HED2YM2q0QLrE7b4JwrxJI/3UVdmn+OjGYq
 ToZdablgbgRomB+FBFVlsluIi+sf5xVw/SMW1B4NttXBrFVG9OjM55Od/U53Q6KdPQTM
 EgdsAq8F9Wlwm8Q45QLdEGc3dy+13fDh7+jgR8IrcJoFbP/7t+VTt4Z91QT1PCvOFo1L
 cMuMSX6DV7qUBmEuR8sqj3ADHvD5I4kEo817o31RmFhWbhBqvCer23IxuQEfUc6ogpqN
 PcJsYESPQr9A6qDuCELsF9YqzKLXHs7/5ZbTBdei8htxXD4GWi81C3fNZrD1eWwQSyPz
 X2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755678248; x=1756283048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ayVoMlGV644opSYSNfnrBKX1rKw9RzMeodw+Qepq4JE=;
 b=YTqg5ygN0hKz1lr1NFgMZ6YfzQFcSBja9UIuTcHogmC1SDlTvUBVmrSMeJsL9sgbc8
 z7K+BEg/+1cLBUYGGj6PMO4MasUWUrqjvu3ld1/Gq9F1XVX8FibkmBxkK4N9/lrsgnMV
 jyiMUINMdmUKFkAjlkvdKV55jJa/srm7ugVK1gjNyeLDJ77ef/Jt6OOD01k9kr5ID7bW
 1Sh0d0K71UGahKWy33wAnq0eMLEol+CcJc7l8oKm+BXSIJdLV0gnTIjIIEkF/jXt0CSy
 AwpTV2EvFR6+RKY3ciBRToAz/UVKVFJ4KhW4p4ooTwY3DZ6AsLDN9sxIHjtymwUcIeZn
 jkvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrQ9Sp3z6NDlRqfu5fVe1LUx0zMmJuZlcKAp0WHQ2AnCZz6aA3B9LlAE1DUGovh1gKwnmK3bGKonTdlA==@nongnu.org,
 AJvYcCVtxZSN6HSrLpydgLCiYVkPYfgRPhFhIrf5Znpge4ClAtkun9y5D0W/1lSFr42uzwPAnqNN+QmIMKkbeA==@nongnu.org,
 AJvYcCXj8cbA7z9M874uZvSJQkNpYqhqQy2mlbtNp7fyTOL6OiwphGW8vURIykPWbpNm3TULE6DzBbXjhQ==@nongnu.org
X-Gm-Message-State: AOJu0YyBjdj9Ph6mXlA/MBMNbV+zCunvp/86up5lKQtHoW//+g3h8Na4
 z4xOn4cgd/taj5QpogEhad1ZPlg0/E2kZVqow7RD2gqUCm6AaDWQhJChUdv7GL+WDUVrwfGu6gx
 qQgx5TV8u4IcFVFHPFCon6r83zh9+oYg=
X-Gm-Gg: ASbGncsEeUlGpsBsQe60ZLH0aM0y+yiX3RUv5Mecltg+aF9atNzvL7XPKJ8bQ3jtm7y
 aEq+WmNXkdzwg4s3Bu85zCKkmD4a30Drl1r+Mj2X9W5OuC5hUtzGZ+2aYQ//FCY7e83GYxv6HCq
 0U+jwPcfSwKpQj4BZb7ebftDoTDAVEkDw4D2Ue94P1MicZwIyN/nSelVy2zMp8CzyMLGXl0UdqE
 Q9wAvY3qXmC04j7Vq3wt6RP5HTqSgmwgmFkNA==
X-Google-Smtp-Source: AGHT+IHoAnIr2E3aB6xnOKkTQDOyCeX2g3ThQkvTb9d4qY8j8STMZX1dAN+TD6BvbNUtVTefLqwaOpMSsxUF75WZ9S8=
X-Received: by 2002:a17:902:e5cd:b0:240:3e40:43b0 with SMTP id
 d9443c01a7336-245ef25d1eemr32646915ad.43.1755678247985; Wed, 20 Aug 2025
 01:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
 <ceb5f4b3fb6a4c0f6c647a7e1b39c801144ac6af.1755623522.git.ktokunaga.mail@gmail.com>
 <bcdcb0b0-3427-4c4e-b3cf-32b53b5e6c4e@linaro.org>
In-Reply-To: <bcdcb0b0-3427-4c4e-b3cf-32b53b5e6c4e@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 20 Aug 2025 17:23:56 +0900
X-Gm-Features: Ac12FXy9KaRW_1uXsoTFaGQAyjVLQ8syyclhpLUhEDiIraVq__e8Fj4iJtw3AVk
Message-ID: <CAEDrbUbtv+m9kp0nb1pzmHD=jaxUNKfWNeQh=nZKP+m5=mQgYw@mail.gmail.com>
Subject: Re: [PATCH 18/35] tcg/wasm: Add bswap instructions
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
Content-Type: multipart/alternative; boundary="0000000000004faac9063cc7b254"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
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

--0000000000004faac9063cc7b254
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

> On 8/20/25 04:21, Kohei Tokunaga wrote:
> > +static void tcg_wasm_out_bswap64(
> > +    TCGContext *s, TCGReg dest, TCGReg src)
> > +{
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(src));
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 32);
> > +    tcg_wasm_out_op(s, OPC_I64_ROTR);
> > +    tcg_wasm_out_op_idx(s, OPC_LOCAL_SET, TMP64_LOCAL_0_IDX);
> > +
> > +    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0xff000000ff000000);
> > +    tcg_wasm_out_op(s, OPC_I64_AND);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 24);
> > +    tcg_wasm_out_op(s, OPC_I64_SHR_U);
> > +
> > +    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x00ff000000ff0000);
> > +    tcg_wasm_out_op(s, OPC_I64_AND);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 8);
> > +    tcg_wasm_out_op(s, OPC_I64_SHR_U);
> > +
> > +    tcg_wasm_out_op(s, OPC_I64_OR);
> > +
> > +    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x0000ff000000ff00);
> > +    tcg_wasm_out_op(s, OPC_I64_AND);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 8);
> > +    tcg_wasm_out_op(s, OPC_I64_SHL);
> > +
> > +    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x000000ff000000ff);
> > +    tcg_wasm_out_op(s, OPC_I64_AND);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, 24);
> > +    tcg_wasm_out_op(s, OPC_I64_SHL);
> > +
> > +    tcg_wasm_out_op(s, OPC_I64_OR);
> > +
> > +    tcg_wasm_out_op(s, OPC_I64_OR);
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
> > +}
>
> Is this any better than the default expansion?

Thank you for pointing this out. I think it can rely on the the default
expansion, so I'll remove it in the next version of the patch series.

Regards,
Kohei

--0000000000004faac9063cc7b254
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard,<br><br>&gt; On 8/20/25 04:21,=
 Kohei Tokunaga wrote:<br>&gt; &gt; +static void tcg_wasm_out_bswap64(<br>&=
gt; &gt; + =C2=A0 =C2=A0TCGContext *s, TCGReg dest, TCGReg src)<br>&gt; &gt=
; +{<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG=
_IDX(src));<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CO=
NST, 32);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_ROTR);<br>=
&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_LOCAL_SET, TMP64_LOCAL_=
0_IDX);<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, O=
PC_LOCAL_GET, TMP64_LOCAL_0_IDX);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_=
op_const(s, OPC_I64_CONST, 0xff000000ff000000);<br>&gt; &gt; + =C2=A0 =C2=
=A0tcg_wasm_out_op(s, OPC_I64_AND);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_ou=
t_op_const(s, OPC_I64_CONST, 24);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_=
op(s, OPC_I64_SHR_U);<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_o=
ut_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);<br>&gt; &gt; + =C2=A0 =C2=
=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x00ff000000ff0000);<br>&gt; &gt=
; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_AND);<br>&gt; &gt; + =C2=A0 =C2=
=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, 8);<br>&gt; &gt; + =C2=A0 =C2=A0=
tcg_wasm_out_op(s, OPC_I64_SHR_U);<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=
=A0tcg_wasm_out_op(s, OPC_I64_OR);<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=
=A0tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);<br>&gt; &gt; +=
 =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x0000ff000000ff00);<=
br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_AND);<br>&gt; &gt; +=
 =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, 8);<br>&gt; &gt; + =
=C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_SHL);<br>&gt; &gt; +<br>&gt; &gt; +=
 =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);<br>=
&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x000000ff=
000000ff);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_AND);<br>=
&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, 24);<br>&g=
t; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_SHL);<br>&gt; &gt; +<br>&=
gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_OR);<br>&gt; &gt; +<br>&=
gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_OR);<br>&gt; &gt; + =C2=
=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));<br>&gt; &g=
t; +}<br>&gt; <br>&gt; Is this any better than the default expansion?<br><b=
r>Thank you for pointing this out. I think it can rely on the the default<b=
r>expansion, so I&#39;ll remove it in the next version of the patch series.=
<br><br>Regards,<br>Kohei<br><br></div></div>

--0000000000004faac9063cc7b254--

