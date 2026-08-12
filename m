Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB073C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9PU-0004i7-Tf; Wed, 12 Aug 2026 09:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wu9PS-0004hu-Gj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:54:22 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wu9PO-0000P6-Fv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:54:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ceab75934dso13587375ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786542857; x=1787147657; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N90NN4n9+LzV7tiYeeKSL3/VSpyLD/AD9T0cJNXZa5o=;
 b=PijYLHbsz2Lg4ljFePeDxGAI9tdmux+H120ih7tQSmw6kNwSdBF0/JU8QVJ1UqSI8a
 ZysMraQFI0Eg+SheL3y/c9X8Scgl2xXS6nli20rZ8rUi96VVObJ/aS8spdPeBczXlRjt
 NpPGKBomtmVqmQuQspMv5K6ZnNu0KdhoEBVc8vbotq1CotmR2CTQ0ZOivcOki/DlW7eC
 jeDZxOzwMXOZEHaloAje+ECNPK2dGmygL4SD8d2F55EtVm7VS68rJ7P2mKYzLQFLepRI
 NJU2f/zfuuwZ/VubPwRTLosJ+fIZoJ80MZZ0D1eo3ZK4N4MTBaXrG0Z3SHXBwGrwoXuL
 UTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786542857; x=1787147657;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N90NN4n9+LzV7tiYeeKSL3/VSpyLD/AD9T0cJNXZa5o=;
 b=San7jqo6SP/R3y7JEISf+EkGKzNqtZFsO1zPIxrKCLCMVlNGoD4J7XPuXlGrGttgcV
 4LjtfqTJqWFfAQZPmcZWMT5mb3g0w2icW+5HHxF+VaDNxCAYY/g2J8/fzmoFPKWT0zQt
 MllUQ+3KEOdLFlvLMIigJbWR6NF5leDePGC1DImqFM+lhl2Ow4N8gesIIuBRFehV2Na9
 c1QZ6UUfbRn9tV6AxepVWNgrURXdY0txdXzHuC0gpRxISI2ngLOw6bT58WjfyGidCqwg
 F3X/xIVektBj/cX/dWi44NlJZZCRIubBoiGp3fW3OpE2PSJElvPggXeynCFCguv88XkY
 jj5w==
X-Gm-Message-State: AOJu0YzEk1P4Smlul0SZV4Ad/naKcrNsFEFo/0hGIvVq2lsZdiNHD8cI
 z/EC8Bwx7s7F3tsci6FKY2cKoTHs0rfHfB8+tpougwzL0P2ilSNayVoHM00uwwLV/70=
X-Gm-Gg: AR+sD12w42Tzt50NwfZzdvfQpbmvHLhqvxh7e0iI5V8FTJ1QZtiT+mhLgGN2Qbqp/8T
 cZlICwYAQCJEMs+NqKYqUb0nNz4ElSa7DT5qteA2JVFJfxJIWSdkYnHBCF4TZDotAwGnE3YbQdc
 N0lQp5CkjQHUrx+wE0mpD3IYjDVKKR7FL/9zfbOIR9r/lKn8XdLhXE4pC/g3cKqdrUU+2yMHfPn
 dt4IAwCxofjQsgoHHh21Y56NoImyyMtSykRj93xBlQ+UMMpoIznBSGRQ0KwLb12TEAFzo5JKH9r
 /NaD+YyWl2vzaJBo/u6BOpj8YQG8cqzfj3XQup2ObiXAi3tDzXzeNliaM4Sz8rwKIFlrBQ2xI+Y
 cv6yHpOFkh/XR2EB/cE0abJcBypyI5SxASKysUhmU1UFjQ2wjRQXvmY8uCqNZuMJudvoKwVIFFl
 UvHkWZAu14pKjLKxlSEfjz7af0L3O94hIdheHLP7VuEQg+r8a/PJRxhrfgw75GdckdQmcX8Q==
X-Received: by 2002:a17:903:22c4:b0:2ce:7563:70a5 with SMTP id
 d9443c01a7336-2d3453a1791mr57888355ad.6.1786542856795; 
 Wed, 12 Aug 2026 06:54:16 -0700 (PDT)
Received: from smtpclient.apple ([212.135.212.213])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d351152467sm7283655ad.33.2026.08.12.06.54.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Aug 2026 06:54:16 -0700 (PDT)
From: Jack wang <163wangjack@gmail.com>
Message-Id: <F0F514AE-1866-47FD-B204-3EB5E0A0159B@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_E51B9375-9BFF-449C-8072-1866BF2C15C3"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [RFC PATCH v1 0/5] hw/gpio: STM32F1xx GPIO controller in Rust
Date: Wed, 12 Aug 2026 21:53:55 +0800
In-Reply-To: <20260726145119.19881-1-163wangjack@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 qemu-rust@nongnu.org, caojunze424@gmail.com
To: qemu-devel@nongnu.org
References: <20260726145119.19881-1-163wangjack@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_E51B9375-9BFF-449C-8072-1866BF2C15C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi all, sorry for pre wrong link with patch 5,now I add right link(rfc) =
below, really sorry  for my mistake

A polite ping for this RFC series.Thanks advice for Philippe advice and =
I am ready for v2.
Could anyone have other suggestions for my patch. I am appreciative for =
your advice and ready to fix it in v2


> 2026=E5=B9=B47=E6=9C=8826=E6=97=A5 22:51=EF=BC=8CJack Wang =
<163wangjack@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi all,
>=20
> This RFC adds an STM32F1xx GPIO controller modelled in Rust, following =
the
> existing rust/hw/char/pl011 device as a template. The register logic =
(CRL/CRH
> mode+config decode and the IDR update algorithm) is a direct port of =
the C
> model in hw/gpio/stm32l4x5_gpio.c; the STM32F1xx GPIO block (RM0008) =
is the
> same IP used by the upstream stm32f100_soc.
>=20
> This series is currently stacked on an out-of-tree STM32F103 SoC and =
board
> that are not yet upstream which is =
https://github.com/shandianchengzi/qemu
> But the commit(the initialize logic and gpio architecture) is both =
capable=20
> for stm32f100.This is the reason that struct name is  stm32f1xx. Patch =
3=20
> ("hw/arm/stm32f103: instantiate and mapGPIO ports") therefore touches =
files=20
> that do not exist in mainline and willnot apply cleanly on its own.=20
> I am sending this as an RFC to get feedback onthe Rust device model =
and=20
> its integration now, before the SoC lands, rather than as an =
apply-ready series
> . Once the SoC is upstream (or if you I
> can retarget the device at the existing stm32f100_soc), I will resend =
a
> non-RFC series.
>=20
> checkpatch reports SPDX warnings on Kconfig/trace-events/Cargo.toml/
> meson.build and "MAINTAINERS need updating" on the new files. These =
are
> false positives: matching rust/hw/char/pl011, these file types carry =
no SPDX
> header in-tree, and MAINTAINERS already gains an entry covering =
rust/hw/gpio/
> and the qtest in this series.
>=20
> Anyway this is my first time to generate rust model build so sorry for =
some
> mistakes. And any help or tip are welcomed
>=20
> Jack Wang (5):
>  hw/gpio: add stm32f1xx GPIO device model (Rust)
>  rust: add hw/gpio crate to the workspace
>  hw/arm/stm32f103: instantiate and map GPIO ports
>  tests/qtest: add stm32f103 GPIO test
>  rust/hw/gpio: add native unit tests
>=20
> MAINTAINERS                       |   7 +
> hw/arm/Kconfig                    |   1 +
> hw/arm/stm32f103_board.c          |   2 +-
> hw/arm/stm32f103_soc.c            |  54 ++-
> hw/gpio/Kconfig                   |   5 +
> hw/gpio/trace-events              |   7 +
> include/hw/arm/stm32f103_soc.h    |   9 +
> rust/Cargo.lock                   |  17 +-
> rust/Cargo.toml                   |  18 +
> rust/hw/Kconfig                   |   1 +
> rust/hw/gpio/Cargo.toml           |  28 ++
> rust/hw/gpio/Kconfig              |   2 +
> rust/hw/gpio/meson.build          |  54 +++
> rust/hw/gpio/src/bindings.rs      |  19 ++
> rust/hw/gpio/src/gpio.rs          | 539 ++++++++++++++++++++++++++++++
> rust/hw/gpio/src/lib.rs           |   3 +
> rust/hw/gpio/tests/tests.rs       | 191 +++++++++++
> rust/hw/meson.build               |   1 +
> tests/qtest/meson.build           |   4 +
> tests/qtest/stm32f103_gpio-test.c | 328 ++++++++++++++++++
> 20 files changed, 1281 insertions(+), 9 deletions(-)
> create mode 100644 rust/hw/gpio/Cargo.toml
> create mode 100644 rust/hw/gpio/Kconfig
> create mode 100644 rust/hw/gpio/meson.build
> create mode 100644 rust/hw/gpio/src/bindings.rs
> create mode 100644 rust/hw/gpio/src/gpio.rs
> create mode 100644 rust/hw/gpio/src/lib.rs
> create mode 100644 rust/hw/gpio/tests/tests.rs
> create mode 100644 tests/qtest/stm32f103_gpio-test.c
>=20
> --=20
> 2.53.0
>=20


--Apple-Mail=_E51B9375-9BFF-449C-8072-1866BF2C15C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><p style=3D"margin: 0px; font-width: =
normal; line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal;"><font =
color=3D"#000000">Hi all, sorry for pre wrong link with patch 5,now I =
add right link(rfc) below, really sorry &nbsp;for my mistake</font><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><font =
color=3D"#000000">A polite ping for this RFC series.Thanks advice for =
Philippe advice and I am ready for v2.</font></p><p style=3D"margin: =
0px; font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal;"><font color=3D"#000000">Could anyone =
have other suggestions for my patch. I am appreciative for your advice =
and ready to fix it in v2</font></p><br =
class=3D"Apple-interchange-newline"><div><br><blockquote =
type=3D"cite"><div>2026=E5=B9=B47=E6=9C=8826=E6=97=A5 22:51=EF=BC=8CJack =
Wang &lt;163wangjack@gmail.com&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><br =
class=3D"Apple-interchange-newline"><div><div>Hi all,<br><br>This RFC =
adds an STM32F1xx GPIO controller modelled in Rust, following =
the<br>existing rust/hw/char/pl011 device as a template. The register =
logic (CRL/CRH<br>mode+config decode and the IDR update algorithm) is a =
direct port of the C<br>model in hw/gpio/stm32l4x5_gpio.c; the STM32F1xx =
GPIO block (RM0008) is the<br>same IP used by the upstream =
stm32f100_soc.<br><br>This series is currently stacked on an out-of-tree =
STM32F103 SoC and board<br>that are not yet upstream which is =
https://github.com/shandianchengzi/qemu<br>But the commit(the initialize =
logic and gpio architecture) is both capable <br>for stm32f100.This is =
the reason that struct name is &nbsp;stm32f1xx. Patch 3 =
<br>("hw/arm/stm32f103: instantiate and mapGPIO ports") therefore =
touches files <br>that do not exist in mainline and willnot apply =
cleanly on its own. <br>I am sending this as an RFC to get feedback =
onthe Rust device model and <br>its integration now, before the SoC =
lands, rather than as an apply-ready series<br>. Once the SoC is =
upstream (or if you I<br>can retarget the device at the existing =
stm32f100_soc), I will resend a<br>non-RFC series.<br><br>checkpatch =
reports SPDX warnings on Kconfig/trace-events/Cargo.toml/<br>meson.build =
and "MAINTAINERS need updating" on the new files. These are<br>false =
positives: matching rust/hw/char/pl011, these file types carry no =
SPDX<br>header in-tree, and MAINTAINERS already gains an entry covering =
rust/hw/gpio/<br>and the qtest in this series.<br><br>Anyway this is my =
first time to generate rust model build so sorry for some<br>mistakes. =
And any help or tip are welcomed<br><br>Jack Wang (5):<br> =
&nbsp;hw/gpio: add stm32f1xx GPIO device model (Rust)<br> &nbsp;rust: =
add hw/gpio crate to the workspace<br> &nbsp;hw/arm/stm32f103: =
instantiate and map GPIO ports<br> &nbsp;tests/qtest: add stm32f103 GPIO =
test<br> &nbsp;rust/hw/gpio: add native unit tests<br><br> MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;7 +<br> hw/arm/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br> =
hw/arm/stm32f103_board.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 =
+-<br> hw/arm/stm32f103_soc.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;54 ++-<br> hw/gpio/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;5 +<br> =
hw/gpio/trace-events =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;&nbsp;7 +<br> include/hw/arm/stm32f103_soc.h =
&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;9 +<br> rust/Cargo.lock =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;17 +-<br> rust/Cargo.toml =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;18 +<br> rust/hw/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br> =
rust/hw/gpio/Cargo.toml =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;28 =
++<br> rust/hw/gpio/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;&nbsp;2 +<br> rust/hw/gpio/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;54 +++<br> =
rust/hw/gpio/src/bindings.rs &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;19 =
++<br> rust/hw/gpio/src/gpio.rs =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 539 =
++++++++++++++++++++++++++++++<br> rust/hw/gpio/src/lib.rs =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;3 +<br> rust/hw/gpio/tests/tests.rs =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 191 +++++++++++<br> =
rust/hw/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;1 +<br> tests/qtest/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;4 +<br> tests/qtest/stm32f103_gpio-test.c | 328 =
++++++++++++++++++<br> 20 files changed, 1281 insertions(+), 9 =
deletions(-)<br> create mode 100644 rust/hw/gpio/Cargo.toml<br> create =
mode 100644 rust/hw/gpio/Kconfig<br> create mode 100644 =
rust/hw/gpio/meson.build<br> create mode 100644 =
rust/hw/gpio/src/bindings.rs<br> create mode 100644 =
rust/hw/gpio/src/gpio.rs<br> create mode 100644 =
rust/hw/gpio/src/lib.rs<br> create mode 100644 =
rust/hw/gpio/tests/tests.rs<br> create mode 100644 =
tests/qtest/stm32f103_gpio-test.c<br><br>-- =
<br>2.53.0<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_E51B9375-9BFF-449C-8072-1866BF2C15C3--

