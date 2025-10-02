Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78FECAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 16:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Lio-000204-Cl; Thu, 02 Oct 2025 11:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v4Lim-0001zo-If
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:59:56 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v4Lic-0004Dy-FU
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:59:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-27edcbbe7bfso15310465ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759420777; x=1760025577; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Q3AQtHGGd55e/twIp2rJFhdrntWiLs1wjzu/6WeXYA=;
 b=gWqttNE/20ZRWXvGBAAIFTLFiiB9CNDZul2Hz6yLTXP2sLI+QupVqCzDkpy4JdUHnm
 RclBWynBBVyTZR+quXN2Sq2nww8lHc+T1cLZNtWHqsA2OnWT0vT8txVvMaueG1d8ykpX
 m5NYvkGFbWtkqDAQWdUuaGMqtT36Vf/X7JGvpV/nVl4ViAl8x5w+TMF0bmIolA7tYAna
 WKFcmjPwz77PDfroov/pFol79TdK1rI8mDDakJXrJoSz5jw+L7dsMEEGOX/CUbF9AZlh
 FXs7JupUoTMV97VjbRgdBY73+hxcJwC3+OlAiu5g9Ce9DzPfe18u3XKlxAjw5tGv6MwM
 CLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759420777; x=1760025577;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Q3AQtHGGd55e/twIp2rJFhdrntWiLs1wjzu/6WeXYA=;
 b=TOdpKYhsckz9WcnHVpeqVCINYOMApprufimHvurx25RNRo4OHIyg5z+r7OxQTcXp58
 QvQx7HmBmMqEaViGUxm3Ay4GLEnrCyCFyd51HNgncwIVOMVDbGUDRevGPuOiTxw3bZV7
 OMNNj9ZzY6d7tBls0cmeluuN/qrn8yL4i3Y7dsMqfMmhb380CtPQvxB1H1D1prWPZH2B
 1IddLR0IQfWKyz3e2kdHi4fCYpuXxM3Sr1QFEDqVYkVigCYRfPnJn+xtrkWWXxKX7EU/
 jE6regbbpTHGcU9LFiEuR3nNyrjPaC8/RgYd9MQDeRtMF3IdWwpnfSjdwsQPbmd5jCcA
 0XOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuFBrz8ttdsGc7wzEWQUklAZs381Kdbs/dVaXHhm8x+xS5App6TGYbnI4gmYnAUUWwH3799rVps63A@nongnu.org
X-Gm-Message-State: AOJu0YxsWKTj0c4yMxYIlwHLBUa7/e5SZzAEYkVUazZt62uyezX08ef6
 dv48aV6F2ygSSLXPj/RycDI0GlpidDGUJvHNADKoFfhnmjsaWGUeiICZwKGWzWCbcugchZbEc4P
 LvNc0EA18c+as57xNHtZXMkKaNTCSm+lTbL0p
X-Gm-Gg: ASbGncupQ83C/tFaxmacCKVneBbSHSalW+kW/xzeNgBmdPjPsGdV6lq3bQpDgsQMC3h
 62qQ+eKN1yNLpAXYwFKxHITSGTLb89j7j5aPTwJKokX2En+AH+B+JBM6ePnz3tn6ni02fKUS9NT
 LkyOTU8XHRRiXGN1A/I9eZPsd4aSQeF3ga6bPJ3Jb19hhjqOE326G94PV8euHMJWMKDBAa5ZcXM
 vakatR2wbEUfIt6hllWre7v35m/8MCipeZaCW4ZNpahqkij1S9zUEHi1ACv
X-Google-Smtp-Source: AGHT+IFx1Lop2L7yQiWryABITmxr963QWBVoFOq7eBm/XGwz1c77q1YhNlaDejopiMDVWwrmXuIXCvj7twsWLptbo0g=
X-Received: by 2002:a17:903:3847:b0:250:1c22:e7b with SMTP id
 d9443c01a7336-28e7f4407c0mr104544865ad.43.1759420776841; Thu, 02 Oct 2025
 08:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
 <ba60c570-fff0-4ab8-b3bc-d191663d2912@linaro.org>
 <2dde1493-db82-4b3d-a962-2cd92355a3c0@linaro.org>
In-Reply-To: <2dde1493-db82-4b3d-a962-2cd92355a3c0@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 3 Oct 2025 00:59:24 +0900
X-Gm-Features: AS18NWASghm1EQ8n08KG2Tr7TNPJvgD1HR1-BJs_xdfxMCMX208LNTXLXU3YeCc
Message-ID: <CAEDrbUaRFjnz_R=N=0MEGLzp2iOYb-X5CfpuZCjx5n6ED06xNg@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] wasm: Add Wasm TCG backend based on wasm64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006a072c06402f12db"
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000006a072c06402f12db
Content-Type: text/plain; charset="UTF-8"

Hi Pierrick,

> I've been able to build qemu-system-x86_64 for wasm.
>
> When running it, I could not get any output following instructions on
> https://github.com/ktock/qemu-wasm-sample/tcgdev64.
> Anyway, I could run this using emrun, even though output is limited to
> javascript console, and not the graphical console printed on webpage.
>
> Am I missing something obvious here?

By default, Emscripten's runtime sends output to the JavaScript console, so
the example repo (qemu-wasm-sample) relies on xterm-pty[1] to setup a
terminal UI on the page.

If you compiled QEMU using the emsdk-wasm-cross.docker environment (instead
of the additional Dockerfile provided in the qemu-wasm-sample repo) please
make sure that xterm-pty is linked to the final QEMU build. A simplest way
to do this is to add an extra -l flag to emcc to link with xterm-pty, using
an envvar.

npm install xterm-pty@v0.10.1
cp ./node_modules/xterm-pty/emscripten-pty.js ./libemscripten-pty.js
export EMCC_CFLAGS="-L $(pwd) -lemscripten-pty.js
-Wno-unused-command-line-argument"
emconfigure ./configure --cpu=wasm64 --static --disable-tools \
            --target-list=x86_64-softmmu
emmake make -j$(nproc)

[1] https://github.com/mame/xterm-pty

> As well, I tested this setup (edk2 + linux):
> $ git clone https://github.com/pbo-linaro/qemu-linux-stack
> $ cd qemu-linux-stack
> $ git checkout x86_64
> $ ./build.sh
> $ rm out/host.ext4 # too big for file_packager, does not handle sparse
>
> # copy needed bios files (.bin, .rom) from qemu/pc-bios
> $ /usr/share/emscripten/tools/file_packager.py \
>    qemu-system-x86_64.data --preload out \
>    kvmvapic.bin vgabios-stdvga.bin  efi-e1000.rom > load.js
>
> When booting with:
> Module['arguments'] = [
>      '-m', '1G',
>      '--nographic',
>      '-bios', 'out/OVMF.fd',
>      '-kernel', 'out/bzImage',
>      '-append', 'console=ttyS0',
> ];
>
> Boot fails with:
> ASSERT_EFI_ERROR (Status = Device Error)
>
> While it boots linux with native qemu. Do we have any restriction on
> WASM build that could create this, out of a bug in tcg backend?

Thank you for pointing this out, I'm working on investigating this issue.

Regards,
Kohei

--0000000000006a072c06402f12db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Pierrick,<br><br>&gt; I&#39;ve been ab=
le to build qemu-system-x86_64 for wasm.<br>&gt; <br>&gt; When running it, =
I could not get any output following instructions on<br>&gt; <a href=3D"htt=
ps://github.com/ktock/qemu-wasm-sample/tcgdev64">https://github.com/ktock/q=
emu-wasm-sample/tcgdev64</a>.<br>&gt; Anyway, I could run this using emrun,=
 even though output is limited to<br>&gt; javascript console, and not the g=
raphical console printed on webpage.<br>&gt; <br>&gt; Am I missing somethin=
g obvious here?<br><br>By default, Emscripten&#39;s runtime sends output to=
 the JavaScript console, so<br>the example repo (qemu-wasm-sample) relies o=
n xterm-pty[1] to setup a<br>terminal UI on the page.<br><br>If you compile=
d QEMU using the emsdk-wasm-cross.docker environment (instead<br>of the add=
itional Dockerfile provided in the qemu-wasm-sample repo) please<br>make su=
re that xterm-pty is linked to the final QEMU build. A simplest way<br>to d=
o this is to add an extra -l flag to emcc to link with xterm-pty, using<br>=
an envvar.<br><br>npm install xterm-pty@v0.10.1<br>cp ./node_modules/xterm-=
pty/emscripten-pty.js ./libemscripten-pty.js<br>export EMCC_CFLAGS=3D&quot;=
-L $(pwd) -lemscripten-pty.js -Wno-unused-command-line-argument&quot;<br>em=
configure ./configure --cpu=3Dwasm64 --static --disable-tools \<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --target-list=3Dx86_64-softmmu<br>emmake=
 make -j$(nproc)<br><br>[1] <a href=3D"https://github.com/mame/xterm-pty">h=
ttps://github.com/mame/xterm-pty</a><br><br>&gt; As well, I tested this set=
up (edk2 + linux):<br>&gt; $ git clone <a href=3D"https://github.com/pbo-li=
naro/qemu-linux-stack">https://github.com/pbo-linaro/qemu-linux-stack</a><b=
r>&gt; $ cd qemu-linux-stack<br>&gt; $ git checkout x86_64<br>&gt; $ ./buil=
d.sh<br>&gt; $ rm out/host.ext4 # too big for file_packager, does not handl=
e sparse<br>&gt; <br>&gt; # copy needed bios files (.bin, .rom) from qemu/p=
c-bios<br>&gt; $ /usr/share/emscripten/tools/file_packager.py \<br>&gt; =C2=
=A0 =C2=A0qemu-system-x86_64.data --preload out \<br>&gt; =C2=A0 =C2=A0kvmv=
apic.bin vgabios-stdvga.bin =C2=A0efi-e1000.rom &gt; load.js<br>&gt; <br>&g=
t; When booting with:<br>&gt; Module[&#39;arguments&#39;] =3D [<br>&gt; =C2=
=A0 =C2=A0 =C2=A0&#39;-m&#39;, &#39;1G&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0&#=
39;--nographic&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0&#39;-bios&#39;, &#39;out/=
OVMF.fd&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0&#39;-kernel&#39;, &#39;out/bzIma=
ge&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0&#39;-append&#39;, &#39;console=3DttyS=
0&#39;,<br>&gt; ];<br>&gt; <br>&gt; Boot fails with:<br>&gt; ASSERT_EFI_ERR=
OR (Status =3D Device Error)<br>&gt; <br>&gt; While it boots linux with nat=
ive qemu. Do we have any restriction on<br>&gt; WASM build that could creat=
e this, out of a bug in tcg backend?<br><br>Thank you for pointing this out=
, I&#39;m working on investigating this issue.<br><br>Regards,<br>Kohei<br>=
<br></div></div>

--0000000000006a072c06402f12db--

