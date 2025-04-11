Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24383C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3CTk-0001uk-N9; Fri, 11 Apr 2025 07:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3CTi-0001uQ-Mr; Fri, 11 Apr 2025 07:23:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3CTg-0005UZ-90; Fri, 11 Apr 2025 07:23:22 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so1915082a91.2; 
 Fri, 11 Apr 2025 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744370597; x=1744975397; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=POWa9amohhkg9IY0tHhBlk6A916balObl73gAB2+jZM=;
 b=AqpipT5dZMIj6W8CFdR97xZt7/SAg/9+39hPwZrXvLFuxP/35qsQRo2Ulv9zPuVbne
 bBDlMlZXng/Sm76wWqhCGMGOYgEXFcOcRa9Pi81ZLP4poNOuZ1wnF3iTJcUZDQzt0lE7
 APPj8MXJi3ylCUtLD1HFQ8JccmEsUNuGZlgNKWQ5T1fq5FcZyMok4t3B/F8WljdlNLmo
 eKLkmxkFpltzXQ2GuCg9yvUhPeCZnarz+Y/VQ3q1CMnMHyInVC6zT61FxSCB5z4/gABb
 iPDWAIjPl4g7KwaUCcjuQMN2km2yGRSROFDAAySH9u5B8NYyz8CF7bqg3+ivojWoXCDH
 QQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744370597; x=1744975397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=POWa9amohhkg9IY0tHhBlk6A916balObl73gAB2+jZM=;
 b=JrpRyb6VxMvOinbkfOAJxOyb2BZnyHQs4kD0OB1oDONvTb/YlU+qntk+wO3GezyEa3
 Hf5dKGfIro6/aoUu2tifkdGMJ9zrKwwSvVffhCObJRmZAK5BSUwJ/JpD7B+Ts9ADh9r0
 I20vImNQgr63qjDEmEj1NbJdI5BS5xcZsTxy8U10TnyH4vMTR/6HaCcugOOZEw5eavvp
 Lp4uiRNgcKzi6xXpQlxBP487HrVWLX5gWrz1APVH4cHK6BlYUOT7iKRZs8eQh6i+qrRe
 6c71Qe+N+qB1H8QKwTEuYUEdyN/PR7U2EC/3BCz8KQGP4b1y/+4CbiNLSCK0AktjAKaj
 3f2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD4R5Xve0mn4dE1krg0/0kHQ5cVGDHrxVhP0Y8R/xcZblYri2RvpjOrA3ij9Rp342pexxVHiA4d1MUkQ==@nongnu.org,
 AJvYcCUR3UddvD6GUf6BMrKrB4Di41AeQKNkjw8zQpa2bBdzoj/H2j7AITh16F5niQd2N5bwJ1N3cja6tVdD3A==@nongnu.org,
 AJvYcCXFEQbvqhPu6+9y9BhRyVQV8sJhdCHEAOu/y+9uaTWq8ViWITr9z1hZ+5ZjhYpEFAzrX9NWbPMv3O8Hdg==@nongnu.org,
 AJvYcCXqkYbEyT5geW2hvppM4PTrbmNGBzVBpkoad2HvAx1+oDnop53yWPMPOxzQ18a3NA4GMRjpH0BlHQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywj7QNGcNKaau5gcNDMpU1t4kW5yKN7ubLn4nXp5CX8NON6638h
 8FXPgvNyk0xLqeOq0faOaJzIauLZx6yfa24x67A9VQU6a7jMIgHLcqpl7Ej+i1Dwcjk6cgxxH9u
 y6g+lsLyt3ZAIQ5i9PVbKACAw03s=
X-Gm-Gg: ASbGnctaWrC1by5WsWlcFCHmqmVQvkSozY+AI1IJ8QOhsl7mqKXc7SR9UK/fSYvHAMF
 Z/HdC7/aeoDr1SdG2sqSfV07sQnx5oyBEK3LNC6VJY8E8SJbK5pB2CwY3DfMKMfPK/Ac0FaeDch
 bCECVBXPAenQ0Km6vVFfgrF+5m9Jmtwh/msXri8Vz8bYjFHJnIe8M=
X-Google-Smtp-Source: AGHT+IEx09neglJA9sV2m9YQPc83Idqs+cTRdQSRaKY2RxTdStZP04TJkjZlR6ugPMRC7gQ/vlb15nFJyKWl3A+J2zQ=
X-Received: by 2002:a17:90b:5643:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-3082363461amr4452010a91.14.1744370597104; Fri, 11 Apr 2025
 04:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <04b7137a464e0925e2ae533bbde4fcdfe0dfe069.1744032780.git.ktokunaga.mail@gmail.com>
 <e0dcc4e6-1e8e-468f-83e5-36ffb014eeef@linaro.org>
 <671805c9-f802-412b-998e-ba83719f1e72@redhat.com>
 <CAEDrbUbnAzXpmNSNi11j7+a0DCYHy7d_MCY=TMqHUoxmo_ZHGw@mail.gmail.com>
 <CABgObfaL3f3BD56ajE=Dv+VKidjpW=FRuwTyFHr_Fpu5uAqmpg@mail.gmail.com>
In-Reply-To: <CABgObfaL3f3BD56ajE=Dv+VKidjpW=FRuwTyFHr_Fpu5uAqmpg@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 20:23:05 +0900
X-Gm-Features: ATxdqUEJFrccVS8JjDTk1JvgRBI7H_BQD53IPfrWwlrzj4rOHT-ZdCT1qDSf_Ok
Message-ID: <CAEDrbUbDuHPrRmTUUoM0nszzC_8i9Lxjs0vxrSxa6Wa8z4HW9A@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000cc22a406327eedc0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102e.google.com
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

--000000000000cc22a406327eedc0
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> > > >> has_int128_type is set to false on emscripten as of now to avoid
errors by
> > > >> libffi.
> > >
> > > What is the error here?  How hard would it be to test for it?
> >
> > When has_int128_type=true, I encountered a runtime error from libffi. To
> > reproduce this, we need to actually execute a libffi call with 128-bit
> > arguments.
> >
> > > Uncaught TypeError: Cannot convert 1079505232 to a BigInt
> > >     at ffi_call_js (out.js:702:37)
> > >     at qemu-system-x86_64.wasm.ffi_call
(qemu-system-x86_64.wasm:0xa37712)
> > >     at qemu-system-x86_64.wasm.tcg_qemu_tb_exec_tci
(qemu-system-x86_64.wasm:0x65f440)
> > >     at qemu-system-x86_64.wasm.tcg_qemu_tb_exec
(qemu-system-x86_64.wasm:0x65edff)
> > >     at qemu-system-x86_64.wasm.cpu_tb_exec
(qemu-system-x86_64.wasm:0x6762c0)
> > >     at qemu-system-x86_64.wasm.cpu_exec_loop
(qemu-system-x86_64.wasm:0x677c84)
> > >     at qemu-system-x86_64.wasm.dynCall_iii
(qemu-system-x86_64.wasm:0xab9014)
> > >     at ret.<computed> (out.js:6016:24)
> > >     at invoke_iii (out.js:7574:10)
> > >     at qemu-system-x86_64.wasm.cpu_exec_setjmp
(qemu-system-x86_64.wasm:0x676db8)
>
> Ok, I guess a comment mentioning that it's a libffi limitation is enough.
>
> > > At least -g -O3 -pthread should not be necessary.
> >
> > Thank you for the suggestion. -sPROXY_TO_PTHREAD flag used in
c_link_args
> > always requires -pthread, even during configuration. Otherwise, emcc
returns
> > an error like:
> >
> > > emcc: error: -sPROXY_TO_PTHREAD requires -pthread to work!
> >
> > So I think -pthread needs to be included in c_link_args at minimum.
I'll try
> > to remove other flags in the next version of the series.
>
> Reading more about -sPROXY_TO_PTHREAD it seems that you need it for
> all calls to emcc, even when compiling, so it's better to leave it in
> everywhere.
>
> > > For -Wno-unused-command-line-argument what are the warnings/errors
that
> > > you are getting?
> >
> > I encountered the following error when compiling QEMU:
> >
> > > clang: error: argument unused during compilation: '-no-pie'
[-Werror,-Wunused-command-line-argument]
> >
> > It seems Emscripten doesn't support the -no-pie flag, and this wasn't
caught
> > during the configure phase. It seems that removing
> > -Wno-unused-command-line-argument would require the following change in
> > meson.build, but I'm open to better approaches.
> >
> > > -if not get_option('b_pie')
> > > +if not get_option('b_pie') and host_os != 'emscripten'
> > >    qemu_common_flags += cc.get_supported_arguments('-fno-pie',
'-no-pie')
> > >  endif
>
> Meson should have passed the -Werror=unused-command-line-argument flag
> when doing the above test (CLikeCompiler._has_multi_arguments ->
> has_arguments -> Compiler.compiles -> _build_wrapper ->
> build_wrapper_args -> ClangCompiler.get_compiler_check_args). It would
> be great if you can check what's wrong in this theory so perhaps meson
> can be fixed, or at least send here a meson-log.txt.

According to meson-log.txt as shown below,
-Werror=unused-command-line-argument was passed to the compiler, but it
didn't catch the warning.

> Working directory:  /build/meson-private/tmp4q_5wl_9
> Code:
> extern int i;
> int i;
>
> -----------
> Command line: `/emsdk/upstream/emscripten/emcc -m32
/build/meson-private/tmp4q_5wl_9/testfile.c -o
/build/meson-private/tmp4q_5wl_9/output.o -c -D_FILE_OFFSET_BITS=64 -O0
-Werror=implicit-function-declaration -Werror=unknown-warning-option
-Werror=unused-command-line-argument -fno-pie` -> 0
> Compiler for C supports arguments -fno-pie: YES
> Running compile:
> Working directory:  /build/meson-private/tmpl9yy_8gs
> Code:
> extern int i;
> int i;
>
> -----------
> Command line: `/emsdk/upstream/emscripten/emcc -m32
/build/meson-private/tmpl9yy_8gs/testfile.c -o
/build/meson-private/tmpl9yy_8gs/output.o -c -D_FILE_OFFSET_BITS=64 -O0
-Werror=implicit-function-declaration -Werror=unknown-warning-option
-Werror=unused-command-line-argument -no-pie` -> 0
> stderr:
> clang: warning: argument unused during compilation: '-no-pie'
[-Wunused-command-line-argument]
> -----------
> Compiler for C supports arguments -no-pie: YES

It seems there's a related issue thread on the Meson repository [1].

[1] https://github.com/mesonbuild/meson/issues/5355

> My suggestion is (if possible) to split out the parts of this series
> that are enough to run QEMU under TCI, and get those in as quickly as
> possible. The TCG backend can come second.

Sure, I'll try to split this patch series.

--000000000000cc22a406327eedc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi Paolo,<br><br>&gt; &gt; &gt;=
 &gt;&gt; has_int128_type is set to false on emscripten as of now to avoid =
errors by<br>&gt; &gt; &gt; &gt;&gt; libffi.<br>&gt; &gt; &gt;<br>&gt; &gt;=
 &gt; What is the error here?=C2=A0 How hard would it be to test for it?<br=
>&gt; &gt;<br>&gt; &gt; When has_int128_type=3Dtrue, I encountered a runtim=
e error from libffi. To<br>&gt; &gt; reproduce this, we need to actually ex=
ecute a libffi call with 128-bit<br>&gt; &gt; arguments.<br>&gt; &gt;<br>&g=
t; &gt; &gt; Uncaught TypeError: Cannot convert 1079505232 to a BigInt<br>&=
gt; &gt; &gt; =C2=A0 =C2=A0 at ffi_call_js (out.js:702:37)<br>&gt; &gt; &gt=
; =C2=A0 =C2=A0 at qemu-system-x86_64.wasm.ffi_call (qemu-system-x86_64.was=
m:0xa37712)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 at qemu-system-x86_64.wasm.tcg_=
qemu_tb_exec_tci (qemu-system-x86_64.wasm:0x65f440)<br>&gt; &gt; &gt; =C2=
=A0 =C2=A0 at qemu-system-x86_64.wasm.tcg_qemu_tb_exec (qemu-system-x86_64.=
wasm:0x65edff)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 at qemu-system-x86_64.wasm.c=
pu_tb_exec (qemu-system-x86_64.wasm:0x6762c0)<br>&gt; &gt; &gt; =C2=A0 =C2=
=A0 at qemu-system-x86_64.wasm.cpu_exec_loop (qemu-system-x86_64.wasm:0x677=
c84)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 at qemu-system-x86_64.wasm.dynCall_iii=
 (qemu-system-x86_64.wasm:0xab9014)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 at ret.=
&lt;computed&gt; (out.js:6016:24)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 at invoke=
_iii (out.js:7574:10)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 at qemu-system-x86_64=
.wasm.cpu_exec_setjmp (qemu-system-x86_64.wasm:0x676db8)<br>&gt; <br>&gt; O=
k, I guess a comment mentioning that it&#39;s a libffi limitation is enough=
.<br>&gt; <br>&gt; &gt; &gt; At least -g -O3 -pthread should not be necessa=
ry.<br>&gt; &gt;<br>&gt; &gt; Thank you for the suggestion. -sPROXY_TO_PTHR=
EAD flag used in c_link_args<br>&gt; &gt; always requires -pthread, even du=
ring configuration. Otherwise, emcc returns<br>&gt; &gt; an error like:<br>=
&gt; &gt;<br>&gt; &gt; &gt; emcc: error: -sPROXY_TO_PTHREAD requires -pthre=
ad to work!<br>&gt; &gt;<br>&gt; &gt; So I think -pthread needs to be inclu=
ded in c_link_args at minimum. I&#39;ll try<br>&gt; &gt; to remove other fl=
ags in the next version of the series.<br>&gt; <br>&gt; Reading more about =
-sPROXY_TO_PTHREAD it seems that you need it for<br>&gt; all calls to emcc,=
 even when compiling, so it&#39;s better to leave it in<br>&gt; everywhere.=
<br>&gt; <br>&gt; &gt; &gt; For -Wno-unused-command-line-argument what are =
the warnings/errors that<br>&gt; &gt; &gt; you are getting?<br>&gt; &gt;<br=
>&gt; &gt; I encountered the following error when compiling QEMU:<br>&gt; &=
gt;<br>&gt; &gt; &gt; clang: error: argument unused during compilation: &#3=
9;-no-pie&#39; [-Werror,-Wunused-command-line-argument]<br>&gt; &gt;<br>&gt=
; &gt; It seems Emscripten doesn&#39;t support the -no-pie flag, and this w=
asn&#39;t caught<br>&gt; &gt; during the configure phase. It seems that rem=
oving<br>&gt; &gt; -Wno-unused-command-line-argument would require the foll=
owing change in<br>&gt; &gt; meson.build, but I&#39;m open to better approa=
ches.<br>&gt; &gt;<br>&gt; &gt; &gt; -if not get_option(&#39;b_pie&#39;)<br=
>&gt; &gt; &gt; +if not get_option(&#39;b_pie&#39;) and host_os !=3D &#39;e=
mscripten&#39;<br>&gt; &gt; &gt; =C2=A0 =C2=A0qemu_common_flags +=3D cc.get=
_supported_arguments(&#39;-fno-pie&#39;, &#39;-no-pie&#39;)<br>&gt; &gt; &g=
t; =C2=A0endif<br>&gt; <br>&gt; Meson should have passed the -Werror=3Dunus=
ed-command-line-argument flag<br>&gt; when doing the above test (CLikeCompi=
ler._has_multi_arguments -&gt;<br>&gt; has_arguments -&gt; Compiler.compile=
s -&gt; _build_wrapper -&gt;<br>&gt; build_wrapper_args -&gt; ClangCompiler=
.get_compiler_check_args). It would<br>&gt; be great if you can check what&=
#39;s wrong in this theory so perhaps meson<br>&gt; can be fixed, or at lea=
st send here a meson-log.txt.<br><br>According to meson-log.txt as shown be=
low,<br>-Werror=3Dunused-command-line-argument was passed to the compiler, =
but it<br>didn&#39;t catch the warning.<br><br>&gt; Working directory: =C2=
=A0/build/meson-private/tmp4q_5wl_9<br>&gt; Code:<br>&gt; extern int i;<br>=
&gt; int i;<br>&gt; <br>&gt; -----------<br>&gt; Command line: `/emsdk/upst=
ream/emscripten/emcc -m32 /build/meson-private/tmp4q_5wl_9/testfile.c -o /b=
uild/meson-private/tmp4q_5wl_9/output.o -c -D_FILE_OFFSET_BITS=3D64 -O0 -We=
rror=3Dimplicit-function-declaration -Werror=3Dunknown-warning-option -Werr=
or=3Dunused-command-line-argument -fno-pie` -&gt; 0<br>&gt; Compiler for C =
supports arguments -fno-pie: YES <br>&gt; Running compile:<br>&gt; Working =
directory: =C2=A0/build/meson-private/tmpl9yy_8gs<br>&gt; Code:<br>&gt; ext=
ern int i;<br>&gt; int i;<br>&gt; <br>&gt; -----------<br>&gt; Command line=
: `/emsdk/upstream/emscripten/emcc -m32 /build/meson-private/tmpl9yy_8gs/te=
stfile.c -o /build/meson-private/tmpl9yy_8gs/output.o -c -D_FILE_OFFSET_BIT=
S=3D64 -O0 -Werror=3Dimplicit-function-declaration -Werror=3Dunknown-warnin=
g-option -Werror=3Dunused-command-line-argument -no-pie` -&gt; 0<br>&gt; st=
derr:<br>&gt; clang: warning: argument unused during compilation: &#39;-no-=
pie&#39; [-Wunused-command-line-argument]<br>&gt; -----------<br>&gt; Compi=
ler for C supports arguments -no-pie: YES <br><br>It seems there&#39;s a re=
lated issue thread on the Meson repository [1].<br><br>[1] <a href=3D"https=
://github.com/mesonbuild/meson/issues/5355">https://github.com/mesonbuild/m=
eson/issues/5355</a><br><br>&gt; My suggestion is (if possible) to split ou=
t the parts of this series<br>&gt; that are enough to run QEMU under TCI, a=
nd get those in as quickly as<br>&gt; possible. The TCG backend can come se=
cond.<br><br>Sure, I&#39;ll try to split this patch series.</div>

--000000000000cc22a406327eedc0--

