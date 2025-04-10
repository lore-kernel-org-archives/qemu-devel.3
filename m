Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52735C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 13:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2rjI-0001lk-FP; Thu, 10 Apr 2025 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2rjB-0001jZ-3y; Thu, 10 Apr 2025 09:13:58 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2rj7-00061i-Tk; Thu, 10 Apr 2025 09:13:56 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so819026a91.0; 
 Thu, 10 Apr 2025 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744290825; x=1744895625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=udz9qh+QGhClyiDEnhuS+4N7zuIIA+8WZldsmLxEeaI=;
 b=J6q/MVo0XAf6Ahi0shRRHFb6Xhj7p1GSJkdV84kdhHK2cD+XGgMQENd0WRE1HgKq+S
 wmFtQ4E+BVsCGZs9QIqgO7IORSsMOzKwn8zvVEVxuCacKq12onztAAUgL2yi3AIf60mx
 Dy0SO6/LFXLLmEHJQVOFx0+RZlCcoSW7Cp8e2cnrUaeDQz/0bFBbKdJ7PI6ZIk7/E2Lv
 Vze7CDao7FD55aQjoEGPv9clyrdI6/hIWRfdlFvXlQi3KqqiEWYLrKuCoMgVZZrEu8mN
 MqiTYzSbqvh2f1kwP/BF3E3VWrXnYDuVWy1dbsE2j23CtWq5fVR6WxN8PJA21anw1rjK
 OdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744290825; x=1744895625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=udz9qh+QGhClyiDEnhuS+4N7zuIIA+8WZldsmLxEeaI=;
 b=LA5f1SkULIwNoppvPIXrtz6Gdx+hS/KvOpNngfJAyYzOTIyB+HKpd3Nr34sV743+Z+
 oR9sQZuR0Rv79SnKxz1rkLZYYS/DSZ8fPnpLhqckzf+c2tKLwgT5+l3p5DSoOKMuZN5u
 czQDVBqnmSyMBLzEEcunCQm6zgqTTCuwjkdNEjnpcYk5GT+LyT8WTXgtM/Ek6oy9cu+Q
 vrO51l4nV0tVggsUJINlcZ1f98uduMW0r8Q8RV8uWTVSSH1PNFnda4UBc3ZPfIB7J1QG
 j8HVP4l1wMXO/5VYkc8W7VIl92jcRr8bjAVICYVCVDQfZ8RS5j412xTMqP/AVViTlj/f
 +LAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWXmkgsoVCXWpbmHit38y2Lkd+lb2K6vCajvp/Mlmk1FNlMs9FxtLGsbEuTcEdt8jmJtcwMK3r3l6YuA==@nongnu.org,
 AJvYcCXMX8MgAjMHZSXrKsAwQrfgF/sxYdgNJzvhqWoL50bisHpazWCvHDmLX2yPLfk+JkXAO9PA2+9+mxf0iA==@nongnu.org,
 AJvYcCXYjd7PHF9wLuLtXPVg1nLh+lBz2fByO6nxo30aRW1gP0Lh/NthfNrIxAuCephPAxzYov8/Aw+HhP1S1Q==@nongnu.org,
 AJvYcCXwlizZKwMa1GXcUDbryf+VMpVrzlFIXmYoaqhZfueGVSWwYTDibKny5ezRnqJtaaoKqlAogB2s+w==@nongnu.org
X-Gm-Message-State: AOJu0YxeLgqMACLTwOr1dnan6OJr/OQnI7WxUD5fvrVCp+z+VUWNOuIS
 lEl0QTonYXfMmr070LLxZOUt3Vg3dtuWCtKWfb3qR8tUZSpmraqdBy4kgJZdGesW1LrNUVrSJMF
 fP3rqYHgDIh6doi36OjYvStQBc/SJzTbcvOo=
X-Gm-Gg: ASbGncvIhmCjmbw5eARaNYVaET8sGzzNj87//b+u6kPnfAezfexK+zMTy4hBrs64ZLT
 n6ZqUJgWm39wYHYKLxOL2BmgkGGj/vvin2SZHYPsFspdMNbDu2d/wPNJ6Ho0GwF9BCWlIMVyPuC
 VjXSKWOpEpLgHK1rfypP2aIQ5rJTJVR2/+P6CrsQWN9nmRT8oOSkk=
X-Google-Smtp-Source: AGHT+IHA5DXV1VDngm6EMg4TX+jHyOpj7gQjHaUrbxc+wjrpGkmtyh7sngf76C1H6pvUi1ovpAomVHDyO9IzGi3fAxA=
X-Received: by 2002:a17:90b:2d46:b0:305:2d27:7ca7 with SMTP id
 98e67ed59e1d1-30718b82295mr4996389a91.16.1744290825050; Thu, 10 Apr 2025
 06:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <20250409192115.GA5528@fedora>
 <dc36c24e-dc4a-4c24-97b7-8b812441ffce@linaro.org>
 <CAEDrbUZ4mbCT-npk8Nha4fDd9a5PGguAxS_RD0wG96gpQRUp+g@mail.gmail.com>
In-Reply-To: <CAEDrbUZ4mbCT-npk8Nha4fDd9a5PGguAxS_RD0wG96gpQRUp+g@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 10 Apr 2025 22:13:33 +0900
X-Gm-Features: ATxdqUEjYAQl__gpGILkSOZoqRiEYNdRUH2kWwRllWKDPgsh1gGixbU0w6jXpgQ
Message-ID: <CAEDrbUYM3aK5ErvF=+oV=q-NVLO0uzxbYjHzcxPGvTLp7yNtwA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Type: multipart/alternative; boundary="00000000000003211406326c5bad"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1029.google.com
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

--00000000000003211406326c5bad
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> On 9/4/25 21:21, Stefan Hajnoczi wrote:
> > On Mon, Apr 07, 2025 at 11:45:51PM +0900, Kohei Tokunaga wrote:
> >> This patch series enables QEMU's system emulator to run in a browser
using
> >> Emscripten.
> >> It includes implementations and workarounds to address browser
environment
> >> limitations, as shown in the following.
> >
> > I think it would be great to merge this even if there are limitations
> > once code review comments have been addressed. Developing WebAssembly
> > support in-tree is likely to allow this effort to develop further than
> > if done in personal repos (and with significant efforts required to
> > rebase the code periodically).
> >
> >> # New TCG Backend for Browsers
> >>
> >> A new TCG backend translates IR instructions into Wasm instructions
and runs
> >> them using the browser's WebAssembly APIs (WebAssembly.Module and
> >> WebAssembly.instantiate). To minimize compilation overhead and avoid
hitting
> >> the browser's limitation of the number of instances, this backend
integrates
> >> a forked TCI. TBs run on TCI by default, with frequently executed TBs
> >> compiled into WebAssembly.
> >>
> >> # Workaround for Running 64-bit Guests
> >>
> >> The current implementation uses Wasm's 32-bit memory model, even
though Wasm
> >> supports 64-bit variables and instructions. This patch explores
implementing
> >> TCG 64-bit instructions while leveraging SoftMMU for address
translation. To
> >> enable 64-bit guest support in Wasm today, it was necessary to
partially
> >> revert recent changes that removed support for different pointer widths
> >> between the host and guest (e.g., commits
> >> a70af12addd9060fdf8f3dbd42b42e3072c3914f and
> >> bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
> >> Emscripten. While this serves as a temporary workaround, a long-term
> >> solution could involve adopting Wasm's 64-bit memory model once it
gains
> >> broader support, as it is currently not widely adopted (e.g.,
unsupported by
> >> Safari and libffi). Feedback and suggestions on this approach are
welcome.
>
> The biggest problem I'm seeing is we no longer support 64-bit guests on
> 32-bit hosts, and don't plan to revert that.

Yes, so the sixth patch ("[PATCH 06/10] include/exec: Allow using 64bit
guest addresses on emscripten") should be considered as a temporary
workaround, enabled only for Emsripten builds. It will be removed once
wasm64 gains broader support and is adopted in the Wasm backend.

--00000000000003211406326c5bad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,</div><br>&gt; On 9/4/25 21:2=
1, Stefan Hajnoczi wrote:<br>&gt; &gt; On Mon, Apr 07, 2025 at 11:45:51PM +=
0900, Kohei Tokunaga wrote:<br>&gt; &gt;&gt; This patch series enables QEMU=
&#39;s system emulator to run in a browser using<br>&gt; &gt;&gt; Emscripte=
n.<br>&gt; &gt;&gt; It includes implementations and workarounds to address =
browser environment<br>&gt; &gt;&gt; limitations, as shown in the following=
.<br>&gt; &gt; <br>&gt; &gt; I think it would be great to merge this even i=
f there are limitations<br>&gt; &gt; once code review comments have been ad=
dressed. Developing WebAssembly<br>&gt; &gt; support in-tree is likely to a=
llow this effort to develop further than<br>&gt; &gt; if done in personal r=
epos (and with significant efforts required to<br>&gt; &gt; rebase the code=
 periodically).<br>&gt; &gt; <br>&gt; &gt;&gt; # New TCG Backend for Browse=
rs<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; A new TCG backend translates IR instru=
ctions into Wasm instructions and runs<br>&gt; &gt;&gt; them using the brow=
ser&#39;s WebAssembly APIs (WebAssembly.Module and<br>&gt; &gt;&gt; WebAsse=
mbly.instantiate). To minimize compilation overhead and avoid hitting<br>&g=
t; &gt;&gt; the browser&#39;s limitation of the number of instances, this b=
ackend integrates<br>&gt; &gt;&gt; a forked TCI. TBs run on TCI by default,=
 with frequently executed TBs<br>&gt; &gt;&gt; compiled into WebAssembly.<b=
r>&gt; &gt;&gt;<br>&gt; &gt;&gt; # Workaround for Running 64-bit Guests<br>=
&gt; &gt;&gt;<br>&gt; &gt;&gt; The current implementation uses Wasm&#39;s 3=
2-bit memory model, even though Wasm<br>&gt; &gt;&gt; supports 64-bit varia=
bles and instructions. This patch explores implementing<br>&gt; &gt;&gt; TC=
G 64-bit instructions while leveraging SoftMMU for address translation. To<=
br>&gt; &gt;&gt; enable 64-bit guest support in Wasm today, it was necessar=
y to partially<br>&gt; &gt;&gt; revert recent changes that removed support =
for different pointer widths<br>&gt; &gt;&gt; between the host and guest (e=
.g., commits<br>&gt; &gt;&gt; a70af12addd9060fdf8f3dbd42b42e3072c3914f and<=
br>&gt; &gt;&gt; bf455ec50b6fea15b4d2493059365bf94c706273) when compiling w=
ith<br>&gt; &gt;&gt; Emscripten. While this serves as a temporary workaroun=
d, a long-term<br>&gt; &gt;&gt; solution could involve adopting Wasm&#39;s =
64-bit memory model once it gains<br>&gt; &gt;&gt; broader support, as it i=
s currently not widely adopted (e.g., unsupported by<br>&gt; &gt;&gt; Safar=
i and libffi). Feedback and suggestions on this approach are welcome.<br>&g=
t; <br>&gt; The biggest problem I&#39;m seeing is we no longer support 64-b=
it guests on<br>&gt; 32-bit hosts, and don&#39;t plan to revert that.<br><b=
r>Yes, so the sixth patch (&quot;[PATCH 06/10] include/exec: Allow using 64=
bit<br>guest addresses on emscripten&quot;) should be considered as a tempo=
rary<br>workaround, enabled only for Emsripten builds. It will be removed o=
nce<br>wasm64 gains broader support and is adopted in the Wasm backend.<br>=
<br></div>

--00000000000003211406326c5bad--

