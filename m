Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B2AD4A601
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 05:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgcJB-0008Rd-55; Fri, 16 Jan 2026 00:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vgcJ9-0008QA-Ga
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:23:39 -0500
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vgcJ7-00053H-MP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:23:39 -0500
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1233702afd3so2116791c88.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 21:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768541016; cv=none;
 d=google.com; s=arc-20240605;
 b=PSLl4gKeFzKCgLw818hZT78FsHVuny5BtXuubr8xi19/1tbKeIJKyE+a+itRbBWuPy
 wt07HhIagPfHHHo26NRtgWvRUTWSL45ZnHoY1PzRi7dKnEX8V0uvGEzMielqIminsI8Z
 3Nbdokb2SfZdyMVYT3/L8YtHBtBYeVEtFNqb6kb2nEChX62hrSUtWdMXkgdlLGRGKt00
 qMR5/yg42QzfC4PTssnbFlw70p9JoxUOj29vwjQw4zr3Rdpc0w4u6W9o2nysAj2AFUPW
 HP96Y4nSlmf4DKvhScKA6JW1fJCuels2/boyJ2dGabbvwhFgrohSh2R5gfK/IQ+vyyN/
 83qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MCT6AS8C4sxj8fT4cLaKMr4zxpBr+wOT6Wl9pNVSvRU=;
 fh=JxbFDm//Q/K0vmJOBwqF9Ed57QYSkX3GI+tb16n9SLs=;
 b=iRkvmSgiwMB6QYeIj5qvQVo7lAUM8jdsRcmRl0j/sZHl4/xneCW2dwZPyOXsTfLilu
 cbhpfWVZr79naAhZL1aXLLwA6bd3PFHXVQAawfveeGMmLCy/8EJ1uPjHDfDijADVm5dO
 wQDS93grjAB5i2ggZ/IhV2WmKv3p3iQtyTWNCEYCkhqmaaSOLwfszKKarylqIMaN3LNQ
 ko6oReVgwuOBATZn+ZNdE1PWSclIUvAttr6PHclT7OPqtN6oMZQMpu92erIJN/Bww5z8
 EFA+USgJauTl8QDPAA5C8eBV7e3GuERzkGev34oaq0mcMQmr/qvd4JLWr40eixfTWVJS
 dzgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768541016; x=1769145816; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MCT6AS8C4sxj8fT4cLaKMr4zxpBr+wOT6Wl9pNVSvRU=;
 b=Oto3fEZC3qBwuueeahqda+hlsuL91ve3bulr8dNxbFJgiwxIpvSs+QTBAi0ffmOLWf
 l8SuBun6Q2wuvcNdOP7n8pBpvGKJmjtPjeTjIJxbMJCT29oeU1ElGjluOWr8I88bNAYn
 w7mzYJZ6g4kAUgLt6xrhUgKtBau4jrzvXfl17biRCq4z36vl3QI1eAswKhFDO0rYG1GQ
 MfjhV+BEjuBIm1139Qu96G1/ACAjCIS5Y46f05dxGvWA/7cC0vdNO0er2soX8xVkhpFi
 Fm0F1yz10YJMfiaePtFn5liwfhaDitb123vKVF95pND74Qw4M3308Cp8MArsB+6xu3Xz
 9y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768541016; x=1769145816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCT6AS8C4sxj8fT4cLaKMr4zxpBr+wOT6Wl9pNVSvRU=;
 b=ZDSDSuPgH3KNIqE2qCEci3cu+EUCSntqhe3gQtdWdCcUY/5Y5Jr7KOB0G59VaxO8Oo
 vxkaMQ/XxxOKSsoT3dph42iucJ2nu8NqTxU7CiNWvdrx042v4QI1Def0iQf6MC6jK1xw
 4x1uCrZ/ldCt2AT/wIVyJAkGWC1Djcf023jO1CtoAE+dTlxlAsrWhhCiIiueBo0H78BR
 iGmgavDV4Pbk89EAdpEdcy2b21rTbfB7gm7LsbK2njyOAgXJ3IIDlIlSoz3M+Wb6Qa2g
 PQwkp+5wFBFLpq2mD0I9ybbWh9H/42/uAPkOp+QW1+9fAk+w8C+2HQTOOF74KXIyHAGe
 D2+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCCP9goy6AhYAXOiw7PS4/W5n4P8f14c4fhFEZNviLEGq9YKuZ5W8qXyiapAerxw/NV/4VWX5tM+hc@nongnu.org
X-Gm-Message-State: AOJu0YydizxSQkJ9POj7ulfnUoXSKIQnItrbl1uS7gGiq5ho5F1db1wC
 QiuUV4VyQuaNLkr2RbfnvYmM5iUybL2g0Muuf77iItpkCTXtqZTWSjgQes6omdoLLaCUEBb5ECr
 F6oJanEHtGbZRsjXQXZXGMhXvahqIdS4=
X-Gm-Gg: AY/fxX4/7PqI5YDNDLyFkHy0fzfx63Bohu29hlI9YV0Qb/7xGXWDQ8Ee7uF7+S5DSIm
 8z78X7oxX5+uGPSJ4DT9x4eaSYaY4hMae7X8rLCJ4Qxbkp15z/1ponQGNBweUIqIs3yN7l5FDla
 tfDiebsqyBS6Y7tR4xyqHQd5Di/dRklzt7wYZiRvVmaU/XcF0iUwnid7mHurxPS8m9pupHkRUIj
 HfjxUR+xV1ZkR9llqTV5UUwNJdDOaUiS6JPvTUXV5GGqkqC/OWht6M7tdH84QH/NGufhlY0Jdwr
 CLCVDgEZnNU7I9czXgCKSdI51A==
X-Received: by 2002:a05:7022:f96:b0:123:3488:899c with SMTP id
 a92af1059eb24-1244a7830f1mr1949003c88.40.1768541016059; Thu, 15 Jan 2026
 21:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-10-richard.henderson@linaro.org>
In-Reply-To: <20260116033305.51162-10-richard.henderson@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 16 Jan 2026 14:23:24 +0900
X-Gm-Features: AZwV_QhKDgMyqVkoWM-YgMRRZWe1_9lt98ycoJ0ODY1z8kUGYCCccI5LZsQZfjQ
Message-ID: <CAEDrbUY90==ZtpTXa66HzDQYufG+JFBk8G_tZetGBen+xmEL+A@mail.gmail.com>
Subject: Re: [PATCH v2 09/58] meson: Drop cpu == wasm32 tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, pierrick.bouvier@linaro.org, thuth@redhat.com, 
 pbonzini@redhat.com, philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000000871b106487a8bd9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1231.google.com
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

--0000000000000871b106487a8bd9
Content-Type: text/plain; charset="UTF-8"

> The 32-bit wasm32 host is no longer supported.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure   | 5 +----
>  meson.build | 6 +++---
>  2 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/configure b/configure
> index 326d27dab1..ba1b207b56 100755
> --- a/configure
> +++ b/configure
> @@ -425,7 +425,7 @@ elif check_define __aarch64__ ; then
>  elif check_define __loongarch64 ; then
>    cpu="loongarch64"
>  elif check_define EMSCRIPTEN ; then
> -  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
> +  error_exit "wasm64 must be specified to the cpu flag"
>  else
>    # Using uname is really broken, but it is just a fallback for
architectures
>    # that are going to use TCI anyway
> @@ -523,9 +523,6 @@ case "$cpu" in
>      linux_arch=x86
>      CPU_CFLAGS="-m64"
>      ;;
> -  wasm32)
> -    CPU_CFLAGS="-m32"
> -    ;;
>    wasm64)
>      CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
>      ;;
> diff --git a/meson.build b/meson.build
> index 28f61be675..082c7a86ca 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -51,7 +51,7 @@ qapi_trace_events = []
>  bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly',
'darwin']
>  supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin',
'sunos', 'linux', 'emscripten']
>  supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86',
'x86_64',
> -  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32',
'wasm64']
> +  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm64']
>
>  cpu = host_machine.cpu_family()
>
> @@ -927,7 +927,7 @@ if have_tcg
>      if not get_option('tcg_interpreter')
>        error('Unsupported CPU @0@, try
--enable-tcg-interpreter'.format(cpu))
>      endif
> -  elif host_arch == 'wasm32' or host_arch == 'wasm64'
> +  elif host_arch == 'wasm64'
>      if not get_option('tcg_interpreter')
>        error('WebAssembly host requires --enable-tcg-interpreter')
>      endif
> @@ -4248,7 +4248,7 @@ if have_rust
>      bindgen_args_common += ['--merge-extern-blocks']
>    endif
>    bindgen_c_args = []
> -  if host_arch == 'wasm32'
> +  if host_arch == 'wasm64'
>      bindgen_c_args += ['-fvisibility=default']
>    endif
>    subdir('rust')

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--0000000000000871b106487a8bd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; The 32-bit wasm32 host is no longer =
supported.<br>&gt; <br>&gt; Signed-off-by: Richard Henderson &lt;<a href=3D=
"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;<=
br>&gt; ---<br>&gt; =C2=A0configure =C2=A0 | 5 +----<br>&gt; =C2=A0meson.bu=
ild | 6 +++---<br>&gt; =C2=A02 files changed, 4 insertions(+), 7 deletions(=
-)<br>&gt; <br>&gt; diff --git a/configure b/configure<br>&gt; index 326d27=
dab1..ba1b207b56 100755<br>&gt; --- a/configure<br>&gt; +++ b/configure<br>=
&gt; @@ -425,7 +425,7 @@ elif check_define __aarch64__ ; then<br>&gt; =C2=
=A0elif check_define __loongarch64 ; then<br>&gt; =C2=A0 =C2=A0cpu=3D&quot;=
loongarch64&quot;<br>&gt; =C2=A0elif check_define EMSCRIPTEN ; then<br>&gt;=
 - =C2=A0error_exit &quot;wasm32 or wasm64 must be specified to the cpu fla=
g&quot;<br>&gt; + =C2=A0error_exit &quot;wasm64 must be specified to the cp=
u flag&quot;<br>&gt; =C2=A0else<br>&gt; =C2=A0 =C2=A0# Using uname is reall=
y broken, but it is just a fallback for architectures<br>&gt; =C2=A0 =C2=A0=
# that are going to use TCI anyway<br>&gt; @@ -523,9 +523,6 @@ case &quot;$=
cpu&quot; in<br>&gt; =C2=A0 =C2=A0 =C2=A0linux_arch=3Dx86<br>&gt; =C2=A0 =
=C2=A0 =C2=A0CPU_CFLAGS=3D&quot;-m64&quot;<br>&gt; =C2=A0 =C2=A0 =C2=A0;;<b=
r>&gt; - =C2=A0wasm32)<br>&gt; - =C2=A0 =C2=A0CPU_CFLAGS=3D&quot;-m32&quot;=
<br>&gt; - =C2=A0 =C2=A0;;<br>&gt; =C2=A0 =C2=A0wasm64)<br>&gt; =C2=A0 =C2=
=A0 =C2=A0CPU_CFLAGS=3D&quot;-m64 -sMEMORY64=3D$wasm64_memory64&quot;<br>&g=
t; =C2=A0 =C2=A0 =C2=A0;;<br>&gt; diff --git a/meson.build b/meson.build<br=
>&gt; index 28f61be675..082c7a86ca 100644<br>&gt; --- a/meson.build<br>&gt;=
 +++ b/meson.build<br>&gt; @@ -51,7 +51,7 @@ qapi_trace_events =3D []<br>&g=
t; =C2=A0bsd_oses =3D [&#39;gnu/kfreebsd&#39;, &#39;freebsd&#39;, &#39;netb=
sd&#39;, &#39;openbsd&#39;, &#39;dragonfly&#39;, &#39;darwin&#39;]<br>&gt; =
=C2=A0supported_oses =3D [&#39;windows&#39;, &#39;freebsd&#39;, &#39;netbsd=
&#39;, &#39;openbsd&#39;, &#39;darwin&#39;, &#39;sunos&#39;, &#39;linux&#39=
;, &#39;emscripten&#39;]<br>&gt; =C2=A0supported_cpus =3D [&#39;ppc&#39;, &=
#39;ppc64&#39;, &#39;s390x&#39;, &#39;riscv32&#39;, &#39;riscv64&#39;, &#39=
;x86&#39;, &#39;x86_64&#39;,<br>&gt; - =C2=A0&#39;arm&#39;, &#39;aarch64&#3=
9;, &#39;loongarch64&#39;, &#39;mips64&#39;, &#39;sparc64&#39;, &#39;wasm32=
&#39;, &#39;wasm64&#39;]<br>&gt; + =C2=A0&#39;arm&#39;, &#39;aarch64&#39;, =
&#39;loongarch64&#39;, &#39;mips64&#39;, &#39;sparc64&#39;, &#39;wasm64&#39=
;]<br>&gt; <br>&gt; =C2=A0cpu =3D host_machine.cpu_family()<br>&gt; <br>&gt=
; @@ -927,7 +927,7 @@ if have_tcg<br>&gt; =C2=A0 =C2=A0 =C2=A0if not get_op=
tion(&#39;tcg_interpreter&#39;)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0error(&#=
39;Unsupported CPU @0@, try --enable-tcg-interpreter&#39;.format(cpu))<br>&=
gt; =C2=A0 =C2=A0 =C2=A0endif<br>&gt; - =C2=A0elif host_arch =3D=3D &#39;wa=
sm32&#39; or host_arch =3D=3D &#39;wasm64&#39;<br>&gt; + =C2=A0elif host_ar=
ch =3D=3D &#39;wasm64&#39;<br>&gt; =C2=A0 =C2=A0 =C2=A0if not get_option(&#=
39;tcg_interpreter&#39;)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0error(&#39;WebA=
ssembly host requires --enable-tcg-interpreter&#39;)<br>&gt; =C2=A0 =C2=A0 =
=C2=A0endif<br>&gt; @@ -4248,7 +4248,7 @@ if have_rust<br>&gt; =C2=A0 =C2=
=A0 =C2=A0bindgen_args_common +=3D [&#39;--merge-extern-blocks&#39;]<br>&gt=
; =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=A0bindgen_c_args =3D []<br>&gt; - =
=C2=A0if host_arch =3D=3D &#39;wasm32&#39;<br>&gt; + =C2=A0if host_arch =3D=
=3D &#39;wasm64&#39;<br>&gt; =C2=A0 =C2=A0 =C2=A0bindgen_c_args +=3D [&#39;=
-fvisibility=3Ddefault&#39;]<br>&gt; =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=
=A0subdir(&#39;rust&#39;)<br><br>Reviewed-by: Kohei Tokunaga &lt;<a href=3D=
"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;</div></d=
iv>

--0000000000000871b106487a8bd9--

