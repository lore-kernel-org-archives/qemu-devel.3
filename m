Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631D4C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 13:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2rhZ-0000qe-SR; Thu, 10 Apr 2025 09:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2rhX-0000qO-2a; Thu, 10 Apr 2025 09:12:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2rhU-0005r5-Jl; Thu, 10 Apr 2025 09:12:14 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so703857a91.0; 
 Thu, 10 Apr 2025 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744290729; x=1744895529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HmI2bjN6zGXjbfxLwXVYEXPcQclMjbuVOoLUyfiC0/w=;
 b=Z7hOnl9y6k+o9nT4aIG44Knguzqaj4BbzbHx6j+qo398DZmz8Wt9d8l4eshOHBmHZV
 bqgUySyCy7kA866lC2T0C9Y7MiWKcdWKDOmALdFpRNabP+ta/iwkaj/Oufq+lsuVmvg9
 HxtkLhOOS30ZD48nSHXPHPMgfB+7Qb+bxfhFidDLRuQKtYaByoupazHNyaYi+GkNAQAd
 GRd+0p1qqk0ZPaw5CHL1iLtc27AHrvgxGHmeHUY8bxndkPgkx6FzzpOlzWD0DI8pfSBm
 a03N8zizYUtBvhF+6V36t6EkDbu+kBeDwgxeS+sGQLLDqFr4oQ8Gg45payLFEyM28coC
 WVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744290729; x=1744895529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmI2bjN6zGXjbfxLwXVYEXPcQclMjbuVOoLUyfiC0/w=;
 b=CIGOoBk0COkRpe/dnFCxHtp79tithO7M4SqJG88mIxkD87tLY6jaqxANPMe4CUIIRO
 XzRK9mt9IrkOmdwYZ609BIDggfbWLAgpJNWGbltyf43bOl38COSa5aCRY0CkdJjY2j67
 G4D3n4JKNrSiEdO//lbnTXJkz5t8YhjHkqAVokUTbLUocPMhPx4XDTA3dqaKRFHi7k75
 xq8yuaZYIw1IrZWis9DXu4EwLPtVgKNgNjrgQfWYWTrEBRU9tl5V++qHm96e09TyG0/9
 qTMiV9fmVeMMBK+cKpFIJfkAXxRUxq3MXMSsZscYqiTDdl6bBuvdSll0xCJ780kNUAoT
 KYDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJvQkCAXr54IZiwHrBGrj7fssIbFFCHayk+we58CwslpEIKnF1fRNLOIeWpH2EMLBlqNnAB37aUQF1eA==@nongnu.org,
 AJvYcCVyXtc6+f5/MkOgp/ttlhICk3s15re1WN91RAaCOb1F6mL+RC3RtXONrgMAmR5Jgw96ivB52/9AxnE/GA==@nongnu.org,
 AJvYcCXIJdozC/HxmH/Ha7T/LDBtygs5+anV6TzmapUktqEzqWgGR1d5V7JazfU7wy6OT1J1ENE1XdwuikFa0Q==@nongnu.org,
 AJvYcCXKP9zcUpoXX1PltTh0LfFoQAlhFFS6Lh2nAW8/uXC4tQ7pfDdssRImsYLk4WM+aRkNPJ1rSihyUw==@nongnu.org
X-Gm-Message-State: AOJu0YzrXMC9sqzrmWSHiglzJDtoJMbH5S8/I1b23je4ngfv22nHzv8R
 Is+3yYWF9XC8U6YQbLdiaxfkVHz5qs4ima07rAnSgTV6R4IM9AU6H/9y+HGjsvXBTfyuRcmr8wn
 lThyAt3iAjwCRflGcXk6054Z9WCE=
X-Gm-Gg: ASbGnctfBOL/LCF9O7C95rpdkyH9fHD1hPeryB1ICgODgoAeEI2xzzcN4jPxy/wyyNy
 qRfxSIjFSHHTGY35ownMXApFpCWUVrsb91IpJUXgLwZz7uSVyFz01OvAbCvUvu3vYLf+Abw1osK
 BWWtQ9ngyvcMKKVcqzaV/UnUoGEeJ1Hgt2pxTPk6+08WSeK692+Xo=
X-Google-Smtp-Source: AGHT+IGoJMcJ+U+31eewFk8jAnjwMIFXYhPze63Ut5gUAsyN3CHJEV0vEawtmKl8IXOWQnQE128cIHWnSmUJjtsuNdA=
X-Received: by 2002:a17:90b:2cc5:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-307e5971608mr4069537a91.14.1744290729576; Thu, 10 Apr 2025
 06:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <20250409192115.GA5528@fedora>
 <dc36c24e-dc4a-4c24-97b7-8b812441ffce@linaro.org>
In-Reply-To: <dc36c24e-dc4a-4c24-97b7-8b812441ffce@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 10 Apr 2025 22:11:57 +0900
X-Gm-Features: ATxdqUEhVEutAfuc3mDKSzX98cgxWYclBJOkBj_kRiDIuAjwYlvWPv-oniVljnY
Message-ID: <CAEDrbUZ4mbCT-npk8Nha4fDd9a5PGguAxS_RD0wG96gpQRUp+g@mail.gmail.com>
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000052547f06326c55cc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1036.google.com
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

--00000000000052547f06326c55cc
Content-Type: text/plain; charset="UTF-8"

Hi Stefan,

> > This patch series enables QEMU's system emulator to run in a browser
using
> > Emscripten.
> > It includes implementations and workarounds to address browser
environment
> > limitations, as shown in the following.
>
> I think it would be great to merge this even if there are limitations
> once code review comments have been addressed. Developing WebAssembly
> support in-tree is likely to allow this effort to develop further than
> if done in personal repos (and with significant efforts required to
> rebase the code periodically).
>
> > # New TCG Backend for Browsers
> >
> > A new TCG backend translates IR instructions into Wasm instructions and
runs
> > them using the browser's WebAssembly APIs (WebAssembly.Module and
> > WebAssembly.instantiate). To minimize compilation overhead and avoid
hitting
> > the browser's limitation of the number of instances, this backend
integrates
> > a forked TCI. TBs run on TCI by default, with frequently executed TBs
> > compiled into WebAssembly.
> >
> > # Workaround for Running 64-bit Guests
> >
> > The current implementation uses Wasm's 32-bit memory model, even though
Wasm
> > supports 64-bit variables and instructions. This patch explores
implementing
> > TCG 64-bit instructions while leveraging SoftMMU for address
translation. To
> > enable 64-bit guest support in Wasm today, it was necessary to partially
> > revert recent changes that removed support for different pointer widths
> > between the host and guest (e.g., commits
> > a70af12addd9060fdf8f3dbd42b42e3072c3914f and
> > bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
> > Emscripten. While this serves as a temporary workaround, a long-term
> > solution could involve adopting Wasm's 64-bit memory model once it gains
> > broader support, as it is currently not widely adopted (e.g.,
unsupported by
> > Safari and libffi). Feedback and suggestions on this approach are
welcome.
> >
> > # Emscripten-Based Coroutine Backend
> >
> > Emscripten does not support couroutine methods currently used by QEMU
but
> > provides a coroutine implementation called "fiber". This patch series
> > introduces a coroutine backend using fiber. However, fiber does not
support
> > submitting coroutines to other threads. So this patch series modifies
> > hw/9pfs/coth.h to disable this behavior when compiled with Emscripten.
>
> QEMU's block job coroutines also rely on switching between threads. See
> how job_co_entry() schedules job_exit(). It's not very likely that users
> will run jobs in a WebAssembly environment, so maybe this is more of a
> theoretical problem for the time being.

Thank you for the feedback. I'll investigate the block job coroutines
further. As you pointed out, I agree that users aren't likely to run block
jobs in the WebAssembly environment.

> If I understand correctly the QEMU project is only build the statically
> linked wasm binary in the CI system and not distributing it (e.g. making
> it available for download)? I'm asking because if the QEMU project wants
> to distribute the wasm binary it may be necessary to put together a
> combined software license to meet the license requirements of glib and
> other dependencies that are statically linked.

Yes, it doesn't distribute the statically linked wasm binary.

--00000000000052547f06326c55cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Stefan,<br><br>&gt; &gt; This patch se=
ries enables QEMU&#39;s system emulator to run in a browser using<br>&gt; &=
gt; Emscripten.<br>&gt; &gt; It includes implementations and workarounds to=
 address browser environment<br>&gt; &gt; limitations, as shown in the foll=
owing.<br>&gt; <br>&gt; I think it would be great to merge this even if the=
re are limitations<br>&gt; once code review comments have been addressed. D=
eveloping WebAssembly<br>&gt; support in-tree is likely to allow this effor=
t to develop further than<br>&gt; if done in personal repos (and with signi=
ficant efforts required to<br>&gt; rebase the code periodically).<br>&gt; <=
br>&gt; &gt; # New TCG Backend for Browsers<br>&gt; &gt; <br>&gt; &gt; A ne=
w TCG backend translates IR instructions into Wasm instructions and runs<br=
>&gt; &gt; them using the browser&#39;s WebAssembly APIs (WebAssembly.Modul=
e and<br>&gt; &gt; WebAssembly.instantiate). To minimize compilation overhe=
ad and avoid hitting<br>&gt; &gt; the browser&#39;s limitation of the numbe=
r of instances, this backend integrates<br>&gt; &gt; a forked TCI. TBs run =
on TCI by default, with frequently executed TBs<br>&gt; &gt; compiled into =
WebAssembly.<br>&gt; &gt; <br>&gt; &gt; # Workaround for Running 64-bit Gue=
sts<br>&gt; &gt; <br>&gt; &gt; The current implementation uses Wasm&#39;s 3=
2-bit memory model, even though Wasm<br>&gt; &gt; supports 64-bit variables=
 and instructions. This patch explores implementing<br>&gt; &gt; TCG 64-bit=
 instructions while leveraging SoftMMU for address translation. To<br>&gt; =
&gt; enable 64-bit guest support in Wasm today, it was necessary to partial=
ly<br>&gt; &gt; revert recent changes that removed support for different po=
inter widths<br>&gt; &gt; between the host and guest (e.g., commits<br>&gt;=
 &gt; a70af12addd9060fdf8f3dbd42b42e3072c3914f and<br>&gt; &gt; bf455ec50b6=
fea15b4d2493059365bf94c706273) when compiling with<br>&gt; &gt; Emscripten.=
 While this serves as a temporary workaround, a long-term<br>&gt; &gt; solu=
tion could involve adopting Wasm&#39;s 64-bit memory model once it gains<br=
>&gt; &gt; broader support, as it is currently not widely adopted (e.g., un=
supported by<br>&gt; &gt; Safari and libffi). Feedback and suggestions on t=
his approach are welcome.<br>&gt; &gt; <br>&gt; &gt; # Emscripten-Based Cor=
outine Backend<br>&gt; &gt; <br>&gt; &gt; Emscripten does not support couro=
utine methods currently used by QEMU but<br>&gt; &gt; provides a coroutine =
implementation called &quot;fiber&quot;. This patch series<br>&gt; &gt; int=
roduces a coroutine backend using fiber. However, fiber does not support<br=
>&gt; &gt; submitting coroutines to other threads. So this patch series mod=
ifies<br>&gt; &gt; hw/9pfs/coth.h to disable this behavior when compiled wi=
th Emscripten.<br>&gt; <br>&gt; QEMU&#39;s block job coroutines also rely o=
n switching between threads. See<br>&gt; how job_co_entry() schedules job_e=
xit(). It&#39;s not very likely that users<br>&gt; will run jobs in a WebAs=
sembly environment, so maybe this is more of a<br>&gt; theoretical problem =
for the time being.<br><br>Thank you for the feedback. I&#39;ll investigate=
 the block job coroutines<br>further. As you pointed out, I agree that user=
s aren&#39;t likely to run block<br>jobs in the WebAssembly environment.<br=
><br>&gt; If I understand correctly the QEMU project is only build the stat=
ically<br>&gt; linked wasm binary in the CI system and not distributing it =
(e.g. making<br>&gt; it available for download)? I&#39;m asking because if =
the QEMU project wants<br>&gt; to distribute the wasm binary it may be nece=
ssary to put together a<br>&gt; combined software license to meet the licen=
se requirements of glib and<br>&gt; other dependencies that are statically =
linked.<br><br>Yes, it doesn&#39;t distribute the statically linked wasm bi=
nary.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr"><br></div></div></div>

--00000000000052547f06326c55cc--

