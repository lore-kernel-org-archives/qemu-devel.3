Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60A1C369AE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 15:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3G8j-0000zk-Bn; Fri, 11 Apr 2025 11:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3G8h-0000zD-0H; Fri, 11 Apr 2025 11:17:55 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3G8d-0000DJ-5r; Fri, 11 Apr 2025 11:17:52 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af59c920d32so1621531a12.0; 
 Fri, 11 Apr 2025 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744384668; x=1744989468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJ5UrI6lGg/6jemr9I1l89LQvEyd7+1XTZ0231uslAs=;
 b=ECC10tQ3a5v9fMYZMesDevB0pZaVT/LRtbTqQ3vR+LD8ga0kcOSftgbvDUnT1kT7nl
 rhkmP4HEP5haI/JcMI+OMAdEr/qUMNt+I5OjLig6qe71qQZDWkN1+9W2zdjZt3ltjJrx
 olUE2lW2eiyuVeoZfHwoTbl2wmT+xoSDLBEg+LY5dn4OBMAOeyA2IvM0SroDl/cBvOAg
 OEl4Itye5R2HH22OCyrNz0DccWvkOY4tQFEwGKKcj1lCd8YrmHrlaBeXUmDZHR2MXu56
 MYbeKVfwGrVyFWY10QZ/SwOrmA7pedpsaNuxWD+X438948L+Coau/0NzewxuR0ck7dVx
 P6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744384668; x=1744989468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJ5UrI6lGg/6jemr9I1l89LQvEyd7+1XTZ0231uslAs=;
 b=R0K0RDmPiF50YuxYgSAn9FlvLGWmVn8y4CJoCGY9ph0EpalhYBGUj6rIJ7q4xY9/wE
 8nMBiHtXpvvWHy+n/qzAi08IQz30dyrtmGiiP5lSwaAekBkI11H1T9ClzIrxZdYIuXCx
 85V6ZB/cfEnX+IFVY+u0hIM/RHxH1q1Z8xG4l2PHOrjE7v/I+g+En+bjH299/CY+xAKE
 ZaeQnJuq6TRoBkF7E4Jnhu5AYytJHmCKMVchqqQ+JDCphsPVjr4/asYzXkSK3v5Fn2rg
 SAFzUehAZvPTEEDYq/CS3l1FXc2+qD9pJgRuDQsXZVMK3eWNXB9h+18KjVf6d8VyM7P2
 /RUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8D+THLg8+8bn2mWG8vgjAzU3k21jZLVxTi59Cn00HwRuiouWeGmRVgxXsfde/2R6txHPudL1F3lucxg==@nongnu.org,
 AJvYcCVRsqpT11HsIKndVLVBkSngSbWd2DYneytCE5hjlr0z88XVRLAQbaGG/efFi0SniyJe3redOUbErw==@nongnu.org,
 AJvYcCVxmaRLq68FksKRS/JnLb/KUH45Z63OSLCyKEZ0qR9aCIZcJn03Ylk1hqWMaC2HjFLOFOLOTFUJh9dsrA==@nongnu.org,
 AJvYcCXR3LMHkDRQ3HI7e7gGMyyJa7hcDWsx+QCAfoEt5tEzE1agPFI9on5QeY0xxA9pw0imRhz/dOClLFzGWg==@nongnu.org
X-Gm-Message-State: AOJu0YwmSuWEY77RDk1sSOeQqtbKLXDyBBMSFou1Ldr2YMK1ji/h8uNZ
 gCbcc4JWWycxdwm73Bw/iXCRoYM3WJRhwsWGl+ag9pyHXQQHEoVLwGMW17T6wOHRTOOzKLU5Pg+
 eWNraye02CyON8wjzeQ9mQmxpk/A=
X-Gm-Gg: ASbGncvlZnsw7Y+IkkZXrIFtKaEJDesmzj8+eG+jmhC1uyKoc00IZSijmOLrCHP44pp
 rLbh3HqHfbYefAnrvWx58OgFv0cLOz+8E9/tC1oVKk7VQ14rGHilEYgyxGX/QgF06Rnm8h0qpC6
 daBGvMeE7A6OEVUCMMt++CVEKemnoubtI5ONxgID8wiIWOM2utbSo=
X-Google-Smtp-Source: AGHT+IGLD6jygAABjZ5gVgXftD6Pr67ZRJ2wBnTAkHzsT1x3Xo93SgZdZfq1toSOFlxuAz9PlvSlfsSCN8QytmN18IM=
X-Received: by 2002:a17:90a:c105:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-30823670d04mr5885118a91.14.1744384667840; Fri, 11 Apr 2025
 08:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <20250409192115.GA5528@fedora> <Z_jwRMsLhtjzdcF5@redhat.com>
In-Reply-To: <Z_jwRMsLhtjzdcF5@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Sat, 12 Apr 2025 00:17:35 +0900
X-Gm-Features: ATxdqUHOawVEa5VymNvEMcZ-3JLYRNrhku_4rFbqNbzfrOe0HX6d0g7wW9byFFk
Message-ID: <CAEDrbUZPFa8nyQNg=ag36RL4vt2ic3pPL240v1vp1D1G+3Lb-w@mail.gmail.com>
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
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
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007a7b99063282340d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
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

--0000000000007a7b99063282340d
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

> On Wed, Apr 09, 2025 at 03:21:15PM -0400, Stefan Hajnoczi wrote:
> > On Mon, Apr 07, 2025 at 11:45:51PM +0900, Kohei Tokunaga wrote:
> > > This patch series enables QEMU's system emulator to run in a browser
using
> > > Emscripten.
> > > It includes implementations and workarounds to address browser
environment
> > > limitations, as shown in the following.
> >
> > I think it would be great to merge this even if there are limitations
> > once code review comments have been addressed. Developing WebAssembly
> > support in-tree is likely to allow this effort to develop further than
> > if done in personal repos (and with significant efforts required to
> > rebase the code periodically).
>
> It is certainly impressive & clever but first two critical questions..
>
> Is there a committment to long term (many years) development & maintenance
> of this, or is it just a short term experiment which will have attention
> dwindle in a year's time ?
>
> Is there a compelling real world use case for this that will justify
> carrying it in QEMU, or is it a case of "it exists because it can" ?

Thank you for the qeustions.

In recent years, I've observed several use cases for on-browser VM
environments.

One potential application is an on-browser development environment, similar
to VSCode's on-browser Python execution environment [1], but with QEMU
offering enhanced compatibility for existing software

Another use case could be an on-browser playground or demo
environment. Several programming languages, such as Ruby [2] and Swift [3],
have already leveraged WebAssembly for this purpose. On-browser QEMU would
extend this capability, allowing a wider variety of software to run within
browsers.

Although the current Wasm backend implementation is still in its early
stages and has room for improvement (e.g., the aforementioned workarounds,
performance, etc.), I believe the examples above represent promising use
cases. Of course, I am committed to maintaining and improving this backend.

[1] https://code.visualstudio.com/docs/python/python-web
[2]
https://github.com/ruby/ruby.wasm/blob/d4a9a03aae6b84327d29783b75edb63549df7e6c/README.md#try-rubywasm-no-installation-needed
[3] https://swiftwasm.org/

--0000000000007a7b99063282340d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Daniel,<br><br>&gt; On Wed, Apr 09, 20=
25 at 03:21:15PM -0400, Stefan Hajnoczi wrote:<br>&gt; &gt; On Mon, Apr 07,=
 2025 at 11:45:51PM +0900, Kohei Tokunaga wrote:<br>&gt; &gt; &gt; This pat=
ch series enables QEMU&#39;s system emulator to run in a browser using<br>&=
gt; &gt; &gt; Emscripten.<br>&gt; &gt; &gt; It includes implementations and=
 workarounds to address browser environment<br>&gt; &gt; &gt; limitations, =
as shown in the following.<br>&gt; &gt; <br>&gt; &gt; I think it would be g=
reat to merge this even if there are limitations<br>&gt; &gt; once code rev=
iew comments have been addressed. Developing WebAssembly<br>&gt; &gt; suppo=
rt in-tree is likely to allow this effort to develop further than<br>&gt; &=
gt; if done in personal repos (and with significant efforts required to<br>=
&gt; &gt; rebase the code periodically).<br>&gt; <br>&gt; It is certainly i=
mpressive &amp; clever but first two critical questions..<br>&gt; <br>&gt; =
Is there a committment to long term (many years) development &amp; maintena=
nce<br>&gt; of this, or is it just a short term experiment which will have =
attention<br>&gt; dwindle in a year&#39;s time ?<br>&gt; <br>&gt; Is there =
a compelling real world use case for this that will justify<br>&gt; carryin=
g it in QEMU, or is it a case of &quot;it exists because it can&quot; ?<br>=
<br>Thank you for the qeustions.<br><br>In recent years, I&#39;ve observed =
several use cases for on-browser VM<br>environments.<br><br>One potential a=
pplication is an on-browser development environment, similar<br>to VSCode&#=
39;s on-browser Python execution environment [1], but with QEMU<br>offering=
 enhanced compatibility for existing software<br><br>Another use case could=
 be an on-browser playground or demo<br>environment. Several programming la=
nguages, such as Ruby [2] and Swift [3],<br>have already leveraged WebAssem=
bly for this purpose. On-browser QEMU would<br>extend this capability, allo=
wing a wider variety of software to run within<br>browsers.<br><br>Although=
 the current Wasm backend implementation is still in its early<br>stages an=
d has room for improvement (e.g., the aforementioned workarounds,<br>perfor=
mance, etc.), I believe the examples above represent promising use<br>cases=
. Of course, I am committed to maintaining and improving this backend.<br><=
br>[1] <a href=3D"https://code.visualstudio.com/docs/python/python-web">htt=
ps://code.visualstudio.com/docs/python/python-web</a><br>[2] <a href=3D"htt=
ps://github.com/ruby/ruby.wasm/blob/d4a9a03aae6b84327d29783b75edb63549df7e6=
c/README.md#try-rubywasm-no-installation-needed">https://github.com/ruby/ru=
by.wasm/blob/d4a9a03aae6b84327d29783b75edb63549df7e6c/README.md#try-rubywas=
m-no-installation-needed</a><br>[3] <a href=3D"https://swiftwasm.org/">http=
s://swiftwasm.org/</a><br><br></div></div>

--0000000000007a7b99063282340d--

