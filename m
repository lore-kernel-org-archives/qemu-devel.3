Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A388C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qxX-0006cp-0h; Thu, 10 Apr 2025 08:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2qxU-0006cS-Mv; Thu, 10 Apr 2025 08:24:40 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2qxN-0000C5-WB; Thu, 10 Apr 2025 08:24:37 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af51596da56so700745a12.0; 
 Thu, 10 Apr 2025 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744287871; x=1744892671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bUphInPLmEDCerY7cJxB4YMAiJbIiSaraVi2vqUAgHU=;
 b=BbGVvST71amBqAOwhmwxFngUqkBYWloFv1rIeLong5+MNEacd1xsPk+XfwZzA7tQ37
 4e6I0ARsqtsH54H8Yz3yU4WAjmauT4Rs6QNk3qcCwje8/PiuX1cgNplI2L94uQJ+DmYC
 dm1ZaazkyAhH04iub1XsS1N/WQjTPPCvQdF+xjbjBkxeFbDKI73K6y3UL8K6EIUsZMBV
 WNBnP+KSxhhYdZgiDGtog060eKxsKjb6jiuPAVp0yuQbwc9lssQc3AAad+Ntb+VgBGYt
 OXSSSLaheiaqDzdPe7SyFA7ENeLCKq13jN+xxZ1Jj14SxeWvLbl8L//qEPTUqLdsKzy8
 TJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744287871; x=1744892671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUphInPLmEDCerY7cJxB4YMAiJbIiSaraVi2vqUAgHU=;
 b=uZxEnUhP3Ai/E+p5bOjeymCv/GYeRTA+PFiiq1L/Fd+ukyoM4V4dhQxWTitMGw+3w8
 MPG84NrixQjb8hQrt0OYsJBf0IK6rxGQyQ0knI9zUY7GTNMLaVT6ffPKwMIuRMvYVKa3
 dQlAckc3uta7QmcRw+ZSX+kLqj/IIlQd/ybHoK9IT1Trb1Gw64hinGd5tPq9rtzV/da3
 EL95bjia32RPyDf42Z2j2w0gTG5w9YHtMzhXAsAtx/xL1euzcbw5aWLxS45d1VM+LJFG
 ebu0xbSxGt3TbzYrc/T8T0M1fNOqcS2PMgmb2iMSx4K/27dV8qR/bjHXbYCs097NymE6
 HWVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtkLNJOCvGLVEjlLWj6ntV0MX8OkFQ4bzPom+jN/bfTOyi65VrL+IaH03BR9GYKix2l0lU0rtel92yjg==@nongnu.org,
 AJvYcCWR3jsNuamBsuVp/XBmLCRmeyQ8t7rLybQRjUNfMkKu6eWORNJ+FOiQGKqBKl9vQ3xDIFDG7kM19A==@nongnu.org,
 AJvYcCWT7TNVmMQy4SqgT1v2T83IRUNpoKBpNuVDj2g9CVif3FKcON7AITrhe2VHenGO7nDEH5u+Ug6WtfSHKQ==@nongnu.org,
 AJvYcCXctlW9lHaGhxwqwd8FSFarZAK6sFIdjSBxFKIpxCQaoTcoP9sGYA2jFNDFIiw7puukrm0mfYD5N1UWzg==@nongnu.org
X-Gm-Message-State: AOJu0YyYzgG6yWoynIW6B/7PsTwb1yN44hWugPRb1Q7870hfRkaciGw2
 PWy2PjASLHRSvbb+LA9E2kLTDdECfdPNDcfCYTSoVqaN0SqlNoj3u+lxYMmTVotLoQf9oGdhVxr
 7GrPya34p4CTjJeXe0fCap4iU9cA=
X-Gm-Gg: ASbGncuLsJQWAxesGknBzow+FstrhSAy5eS7f6uDlW2fno/X99q4HwxteZHlAv3sfg8
 7rFuC5N7vYW17fY8XkHxuIj046+Zq53N9GGEse+cG/uWC/T02tr5QfcYcDbr6Ul+IFziQ1oPBkx
 OWaV91qLridvm4z7uz2bKaRlLoVFBYKWgEOIWE64GRMkRCgvo1MXE=
X-Google-Smtp-Source: AGHT+IFjSY680fopcspcV4dUSl5ihWrJhgbnXfs2mZ+dOnxVdG/BfQfFtKhI2p5hFRI6D7GBe8EyIw2lqwpHRV7Cn6k=
X-Received: by 2002:a17:90b:1f88:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-307e9b3f36dmr3334852a91.35.1744287871077; Thu, 10 Apr 2025
 05:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <04b7137a464e0925e2ae533bbde4fcdfe0dfe069.1744032780.git.ktokunaga.mail@gmail.com>
 <e0dcc4e6-1e8e-468f-83e5-36ffb014eeef@linaro.org>
 <671805c9-f802-412b-998e-ba83719f1e72@redhat.com>
In-Reply-To: <671805c9-f802-412b-998e-ba83719f1e72@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 10 Apr 2025 21:24:18 +0900
X-Gm-Features: ATxdqUEAUMCgXq0GAn2bYNIHf98GyBjr_QDHwkvX6Mgc8qM0VB1vNeJy_FRznks
Message-ID: <CAEDrbUbnAzXpmNSNi11j7+a0DCYHy7d_MCY=TMqHUoxmo_ZHGw@mail.gmail.com>
Subject: Re: [PATCH 05/10] meson: Add wasm build in build scripts
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
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
 qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f1196306326baa44"
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x532.google.com
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

--000000000000f1196306326baa44
Content-Type: text/plain; charset="UTF-8"

Hi Paolo, thank you for the comments.

> >> has_int128_type is set to false on emscripten as of now to avoid
errors by
> >> libffi.
>
> What is the error here?  How hard would it be to test for it?

When has_int128_type=true, I encountered a runtime error from libffi. To
reproduce this, we need to actually execute a libffi call with 128-bit
arguments.

> Uncaught TypeError: Cannot convert 1079505232 to a BigInt
>     at ffi_call_js (out.js:702:37)
>     at qemu-system-x86_64.wasm.ffi_call (qemu-system-x86_64.wasm:0xa37712)
>     at qemu-system-x86_64.wasm.tcg_qemu_tb_exec_tci
(qemu-system-x86_64.wasm:0x65f440)
>     at qemu-system-x86_64.wasm.tcg_qemu_tb_exec
(qemu-system-x86_64.wasm:0x65edff)
>     at qemu-system-x86_64.wasm.cpu_tb_exec
(qemu-system-x86_64.wasm:0x6762c0)
>     at qemu-system-x86_64.wasm.cpu_exec_loop
(qemu-system-x86_64.wasm:0x677c84)
>     at qemu-system-x86_64.wasm.dynCall_iii
(qemu-system-x86_64.wasm:0xab9014)
>     at ret.<computed> (out.js:6016:24)
>     at invoke_iii (out.js:7574:10)
>     at qemu-system-x86_64.wasm.cpu_exec_setjmp
(qemu-system-x86_64.wasm:0x676db8)

> >> And tests aren't integrated with Wasm execution environment as of
> >> now so this commit disables tests.
>
> Perhaps it would be enough to add
>
> [binaries]
> exe_wrapper = 'node'
>
> to the emscripten.txt file?

Thank you for the suggestion. I'll explore this approach.

> >> +[built-in options]
> >> +c_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
> >> +cpp_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
> >> +objc_args =
['-Wno-unused-command-line-argument','-g','-O3','-pthread']
> >> +c_link_args = ['-Wno-unused-command-line-argument','-g','-O3','-
> >> pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-
> >> sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-
> >> sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-
> >> sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
> >> +cpp_link_args = ['-Wno-unused-command-line-argument','-g','-O3','-
> >> pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-
> >> sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-
> >> sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-
> >> sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
>
> At least -g -O3 -pthread should not be necessary.

Thank you for the suggestion. -sPROXY_TO_PTHREAD flag used in c_link_args
always requires -pthread, even during configuration. Otherwise, emcc returns
an error like:

> emcc: error: -sPROXY_TO_PTHREAD requires -pthread to work!

So I think -pthread needs to be included in c_link_args at minimum. I'll try
to remove other flags in the next version of the series.

> For -Wno-unused-command-line-argument what are the warnings/errors that
> you are getting?

I encountered the following error when compiling QEMU:

> clang: error: argument unused during compilation: '-no-pie'
[-Werror,-Wunused-command-line-argument]

It seems Emscripten doesn't support the -no-pie flag, and this wasn't caught
during the configure phase. It seems that removing
-Wno-unused-command-line-argument would require the following change in
meson.build, but I'm open to better approaches.

> -if not get_option('b_pie')
> +if not get_option('b_pie') and host_os != 'emscripten'
>    qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
>  endif

> >> +elif host_os == 'emscripten'
> >> +  supported_backends += ['fiber']
>
> Can you rename the backend to 'wasm' since the 'windows' backend also
> uses an API called Fibers?

Sure, I'll rename the coroutine backend in the next version of the series.

--000000000000f1196306326baa44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo, thank you for =
the comments.<br><br>&gt; &gt;&gt; has_int128_type is set to false on emscr=
ipten as of now to avoid errors by<br>&gt; &gt;&gt; libffi.<br>&gt; <br>&gt=
; What is the error here?=C2=A0 How hard would it be to test for it?<br><br=
>When has_int128_type=3Dtrue, I encountered a runtime error from libffi. To=
<br>reproduce this, we need to actually execute a libffi call with 128-bit<=
br>arguments.<br><br>&gt; Uncaught TypeError: Cannot convert 1079505232 to =
a BigInt<br>&gt; =C2=A0 =C2=A0 at ffi_call_js (out.js:702:37)<br>&gt; =C2=
=A0 =C2=A0 at qemu-system-x86_64.wasm.ffi_call (qemu-system-x86_64.wasm:0xa=
37712)<br>&gt; =C2=A0 =C2=A0 at qemu-system-x86_64.wasm.tcg_qemu_tb_exec_tc=
i (qemu-system-x86_64.wasm:0x65f440)<br>&gt; =C2=A0 =C2=A0 at qemu-system-x=
86_64.wasm.tcg_qemu_tb_exec (qemu-system-x86_64.wasm:0x65edff)<br>&gt; =C2=
=A0 =C2=A0 at qemu-system-x86_64.wasm.cpu_tb_exec (qemu-system-x86_64.wasm:=
0x6762c0)<br>&gt; =C2=A0 =C2=A0 at qemu-system-x86_64.wasm.cpu_exec_loop (q=
emu-system-x86_64.wasm:0x677c84)<br>&gt; =C2=A0 =C2=A0 at qemu-system-x86_6=
4.wasm.dynCall_iii (qemu-system-x86_64.wasm:0xab9014)<br>&gt; =C2=A0 =C2=A0=
 at ret.&lt;computed&gt; (out.js:6016:24)<br>&gt; =C2=A0 =C2=A0 at invoke_i=
ii (out.js:7574:10)<br>&gt; =C2=A0 =C2=A0 at qemu-system-x86_64.wasm.cpu_ex=
ec_setjmp (qemu-system-x86_64.wasm:0x676db8)<br><br>&gt; &gt;&gt; And tests=
 aren&#39;t integrated with Wasm execution environment as of<br>&gt; &gt;&g=
t; now so this commit disables tests.<br>&gt; <br>&gt; Perhaps it would be =
enough to add<br>&gt; <br>&gt; [binaries]<br>&gt; exe_wrapper =3D &#39;node=
&#39;<br>&gt; <br>&gt; to the emscripten.txt file?<br><br>Thank you for the=
 suggestion. I&#39;ll explore this approach.<br><br>&gt; &gt;&gt; +[built-i=
n options]<br>&gt; &gt;&gt; +c_args =3D [&#39;-Wno-unused-command-line-argu=
ment&#39;,&#39;-g&#39;,&#39;-O3&#39;,&#39;-pthread&#39;]<br>&gt; &gt;&gt; +=
cpp_args =3D [&#39;-Wno-unused-command-line-argument&#39;,&#39;-g&#39;,&#39=
;-O3&#39;,&#39;-pthread&#39;]<br>&gt; &gt;&gt; +objc_args =3D [&#39;-Wno-un=
used-command-line-argument&#39;,&#39;-g&#39;,&#39;-O3&#39;,&#39;-pthread&#3=
9;]<br>&gt; &gt;&gt; +c_link_args =3D [&#39;-Wno-unused-command-line-argume=
nt&#39;,&#39;-g&#39;,&#39;-O3&#39;,&#39;-<br>&gt; &gt;&gt; pthread&#39;,&#3=
9;-sASYNCIFY=3D1&#39;,&#39;-sPROXY_TO_PTHREAD=3D1&#39;,&#39;-sFORCE_FILESYS=
TEM&#39;,&#39;-<br>&gt; &gt;&gt; sALLOW_TABLE_GROWTH&#39;,&#39;-sTOTAL_MEMO=
RY=3D2GB&#39;,&#39;-sWASM_BIGINT&#39;,&#39;-<br>&gt; &gt;&gt; sEXPORT_ES6=
=3D1&#39;,&#39;-sASYNCIFY_IMPORTS=3Dffi_call_js&#39;,&#39;-<br>&gt; &gt;&gt=
; sEXPORTED_RUNTIME_METHODS=3DaddFunction,removeFunction,TTY,FS&#39;]<br>&g=
t; &gt;&gt; +cpp_link_args =3D [&#39;-Wno-unused-command-line-argument&#39;=
,&#39;-g&#39;,&#39;-O3&#39;,&#39;-<br>&gt; &gt;&gt; pthread&#39;,&#39;-sASY=
NCIFY=3D1&#39;,&#39;-sPROXY_TO_PTHREAD=3D1&#39;,&#39;-sFORCE_FILESYSTEM&#39=
;,&#39;-<br>&gt; &gt;&gt; sALLOW_TABLE_GROWTH&#39;,&#39;-sTOTAL_MEMORY=3D2G=
B&#39;,&#39;-sWASM_BIGINT&#39;,&#39;-<br>&gt; &gt;&gt; sEXPORT_ES6=3D1&#39;=
,&#39;-sASYNCIFY_IMPORTS=3Dffi_call_js&#39;,&#39;-<br>&gt; &gt;&gt; sEXPORT=
ED_RUNTIME_METHODS=3DaddFunction,removeFunction,TTY,FS&#39;]<br>&gt; <br>&g=
t; At least -g -O3 -pthread should not be necessary.<br><br>Thank you for t=
he suggestion. -sPROXY_TO_PTHREAD flag used in c_link_args<br>always requir=
es -pthread, even during configuration. Otherwise, emcc returns<br>an error=
 like:<br><br>&gt; emcc: error: -sPROXY_TO_PTHREAD requires -pthread to wor=
k!<br><br>So I think -pthread needs to be included in c_link_args at minimu=
m. I&#39;ll try<br>to remove other flags in the next version of the series.=
<br><br>&gt; For -Wno-unused-command-line-argument what are the warnings/er=
rors that<br>&gt; you are getting?<br><br>I encountered the following error=
 when compiling QEMU:<br><br>&gt; clang: error: argument unused during comp=
ilation: &#39;-no-pie&#39; [-Werror,-Wunused-command-line-argument]<br><br>=
It seems Emscripten doesn&#39;t support the -no-pie flag, and this wasn&#39=
;t caught<br>during the configure phase. It seems that removing<br>-Wno-unu=
sed-command-line-argument would require the following change in<br>meson.bu=
ild, but I&#39;m open to better approaches.<br><br>&gt; -if not get_option(=
&#39;b_pie&#39;)<br>&gt; +if not get_option(&#39;b_pie&#39;) and host_os !=
=3D &#39;emscripten&#39;<br>&gt; =C2=A0 =C2=A0qemu_common_flags +=3D cc.get=
_supported_arguments(&#39;-fno-pie&#39;, &#39;-no-pie&#39;)<br>&gt; =C2=A0e=
ndif<br><br>&gt; &gt;&gt; +elif host_os =3D=3D &#39;emscripten&#39;<br>&gt;=
 &gt;&gt; + =C2=A0supported_backends +=3D [&#39;fiber&#39;]<br>&gt; <br>&gt=
; Can you rename the backend to &#39;wasm&#39; since the &#39;windows&#39; =
backend also<br>&gt; uses an API called Fibers?<br><br>Sure, I&#39;ll renam=
e the coroutine backend in the next version of the series.<br><br><br></div=
></div>
</div>

--000000000000f1196306326baa44--

