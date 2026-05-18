Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7B4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 02:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOo3f-0002H0-Bg; Sun, 17 May 2026 22:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOo3Y-0002Ft-1j
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:50:13 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOo3V-00025M-8m
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:50:10 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12ddbe104ccso1082983c88.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 19:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779072607; cv=none;
 d=google.com; s=arc-20240605;
 b=agPcqxcbmZ3RjjJ920O6mAE26HZ0SmXtGCkxjtQA8eV81/dGy87kZPByyyWwQLR+/B
 bUsQTa/P1sTwWQfn9DTxDBrVbquaKtVJnlyx8XIWEPsrY/FFaKVKZ+qxBcZOlBZ4tVQU
 lm8I9FWhtD6rVn38pOOLYAL0JbuRkpdz4IZFLJ7+/a0GnYW2+UYSDW7ICupSJct8xoVh
 DnqCtSMP2u3rigO7BQjvWMGNtKv7qhs9T+0y4QzXpoMlHEnc2sNVGkiIiBrClkHkQTOm
 BXv5l/32SyEoYzYrTZRj8TnI6oWdKF0C1ZD5TF23s5J0dNrAe3l76Q7zQ/jgXuE0ghf+
 sjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HVEP74diACQvZTcsz7rg+b5tAbQ/pSU9inMps9VNzbw=;
 fh=5B7mkaEET076WYem2sxgV9NDr9+NwGVcOT5DkhO2s+4=;
 b=HZiA1iLuuLeeeA9J9q84NaBUW7oab3Z+ue3XI3VTj9ufUQzufeRpOi9L3nJKlW3iwA
 xiLhnyfmxVfuzjazNPjpt5DoML9z/JKkdVPTn0FvD6wgOb+OQYgCVS/BWW3Re58nAA+I
 1DP6KYyokwtduUqlCgehR2XPlhs+xW77xuornTZw39xVJGWjxRtgngqCFISyv2jPfSJr
 6pFPQqJ3dWQGTVp8Vm3J2Qy1U2svnkUCH2YvxDjYLsOPM4vSewny1AYF+UIH46PhyjtZ
 Bcfk1U2nemprn+bH1CqqTL+QRwwiSAXmDnL9Sj5x0/QvLg82QGtxljA5e7UsoY6wki9P
 CmQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779072607; x=1779677407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HVEP74diACQvZTcsz7rg+b5tAbQ/pSU9inMps9VNzbw=;
 b=lZrylzJ55VCAaJEg85ruIcGtcNYIR2OZIXv7v8rDsaUzLfvXZHXeQl2M7SG7LAYESC
 VXKaGnG1L8GDlYHpmvxvEZMZaUOsVyPIRla9ehLDCYDugKTXUySEh+UdVdLmY1OGqRyO
 CI7UJe3S9BtU9vJ0uO5A4lTPmFHr6zBnbfpK4y/qPQmlal4A0j2QB2DzfBcb8S26z33u
 +reS0e085V7Qm3Nu3l/vFs3k6EXwCsnC8e6CuP4CUVxCqqfKQlLFeaihLwqUoNTLPKTc
 xJWIpMLhh2ptyujgmnCRFYZCEm1iFJ9R9AQEiYkUD+pGFWBvqojA/9dqbMQjcsgQzQbg
 GxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779072607; x=1779677407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVEP74diACQvZTcsz7rg+b5tAbQ/pSU9inMps9VNzbw=;
 b=pWwYzD+K+QDdYW3kEnWm5ddMHos2qQJfQZP1gBYTFqewRXECbTjW07xw147tH1Sc9D
 Clsr+6Jtq/LQuW26pBLUPBSP48bQQBruw4SlzTl335e2lH5jNnRw7YDBpy6f81Tgtt2v
 w8tJ8kWP3qViZgg8FdDrq6p/MoCr1q0cHSw6vTB0n6xdMW3hVOova7Je438HNy/H8Ajf
 p2/DttTOYD6byt12T2dAWON9jJLfFH91zoicHLo+GPyweu2vgbpGDS7o1ZbVBkpph0p3
 I/FCE2A2u9OMxl6pW/gp5HQhvXoPbhJJIosdif6XXdxbAUnbAvsh3P0xO1vnPo8Vyys7
 yeDA==
X-Gm-Message-State: AOJu0Yz+xeud0hNj27vx0Kz8dT0M1mcdsWUK5iu0ReKzPyNkDayzQo9P
 Zx+YRv33+6X5t8x+RuVPSkFHtoHvPdLttLfSSFf+bU0p/Eyq0Xj08wzYTAkg5w9jrBlltX3JJHm
 F8fhU8YqOy27UElPsauMtlAS5ldYiAwdnBlNQw3t8zPFFEwashW0H/Oo=
X-Gm-Gg: Acq92OGVF/Z3X0ishdI5WrKF8RkgFvwCkirzeSM3lzhgzuNhPD3+Py8YkSauyEH8zhu
 3MgGK7bJqVHA7fUufn3DLiN5ZG6hRWEydvn173J5KLm2LcQZNIRdtyr6aXF8o3iVS7ikUdDLaW4
 rRXBk4JjQVVPHrITX1P0ToFiyPd1eO9mrEgeQE9rKFjrvgPCH4aX1XLgxxG45JD44yySh2YmQA/
 Lw9kEZnjR8KYhHdJ/Mj+VPIovVK8zXqFGAf0o04pIxKcF7ok0kv3l5zrjkMVLKu1P5H/1pJ2kVY
 W08AOEXXnA==
X-Received: by 2002:a05:7022:925:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-135044172c4mr5190186c88.17.1779072607077; Sun, 17 May 2026
 19:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251231045000.30120-1-jay.chang@sifive.com>
In-Reply-To: <20251231045000.30120-1-jay.chang@sifive.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Mon, 18 May 2026 10:49:56 +0800
X-Gm-Features: AVHnY4LuoHCBsdU64tCwwYPdRQ3rpDdZaIQ_-rgL1MEmzMK7pomqiVPqx3q3Cg8
Message-ID: <CACNNAjPw1RAQKctNWa5=hVs__qz8uOqzd6VrL8V2XvEfEaepRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] target/riscv: Fix PMP address alignment
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000c657c606520e9eb9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=jay.chang@sifive.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000c657c606520e9eb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch.

Thanks,
Jay Chang

On Wed, Dec 31, 2025 at 12:50=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:

> This series fixes PMP address alignment to comply with the RISC-V
> specification WARL (Write-Any, Read-Legal) semantics.
>
> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> value is smaller than the PMP granularity, it needs to be aligned
> to the PMP granularity.
>
> Changes in v3:
> - Use ROUND_UP() macro for NAPOT address alignment
>
> Changes in v2:
> - Fixed commit message grammar ("it needs to be aligned")
> - Use ROUND_DOWN() macro for TOR address alignment to improve
>   code readability
>
> Jay Chang (2):
>   target/riscv: Align pmp size to pmp-granularity
>   target/riscv: Use macros for PMP address alignment
>
>  target/riscv/pmp.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> --
> 2.48.1
>
>

--000000000000c657c606520e9eb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Gentle=C2=A0ping=C2=A0on this patch.<br><br>Tha=
nks,<br>Jay Chang</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Dec 31, 2025 at 12:50=E2=80=AFPM Jay Chang &lt;<a =
href=3D"mailto:jay.chang@sifive.com" target=3D"_blank">jay.chang@sifive.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
This series fixes PMP address alignment to comply with the RISC-V<br>
specification WARL (Write-Any, Read-Legal) semantics.<br>
<br>
When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the<br>
value is smaller than the PMP granularity, it needs to be aligned<br>
to the PMP granularity.<br>
<br>
Changes in v3:<br>
- Use ROUND_UP() macro for NAPOT address alignment<br>
<br>
Changes in v2:<br>
- Fixed commit message grammar (&quot;it needs to be aligned&quot;)<br>
- Use ROUND_DOWN() macro for TOR address alignment to improve<br>
=C2=A0 code readability<br>
<br>
Jay Chang (2):<br>
=C2=A0 target/riscv: Align pmp size to pmp-granularity<br>
=C2=A0 target/riscv: Use macros for PMP address alignment<br>
<br>
=C2=A0target/riscv/pmp.c | 22 ++++++++++++++++------<br>
=C2=A01 file changed, 16 insertions(+), 6 deletions(-)<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--000000000000c657c606520e9eb9--

