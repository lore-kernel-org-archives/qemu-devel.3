Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15912C88E77
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68Et-0001J2-E0; Mon, 14 Sep 2026 11:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1x68EQ-00013s-Dw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:04:41 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1x68EO-0007dB-8E
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:04:29 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab20a33so1921267d50.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789398265; cv=none;
 d=google.com; s=arc-20260327;
 b=oFb71nmPc8A5hpTFBFoTvnbP+BLhZiYMCzws+vPQ0GuyX8454on8+n2d9Hmb/LDZ1F
 bpnfW4aaSkdpRaR36rvgM+P3S1Uo42G24kkuqiQHflxmaqYItjSnJPnX/YOuMXkdfSkN
 LyChuSmj6ngrJLrdM1888YxIAnwI8rd7g/8E2M0nwuWAOcHLursh6IPLy1yb1cd78311
 JNo5CXn7vdH+xV/FW4ltAj3/h1XQas2xMLLGS+R2gfvGceRB0/Zd9TiZR4zg9qM5KXE3
 Rm3HK5u2CubF+JsKdoYpUqn3hSeWfopBCycnDINTdrMdQTjHWTy6jnNc9AMo4eDr5Tmd
 n2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zEiBoKHET1yJkId8dW9GIBPKw1CXl96YMW9ueIbgyNw=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=otowKCJYCp8lD50qJrTHlhlQxrELH0Aqu6c2P8mhlTSVUhnK/5FkZZRlNonNEuEHkA
 YCedeJZxxbd5OXg5dMSeatawFO8Qn4TFBR8iiV15r3u73CRCQEIG2SKk2KSIUB72jSJj
 TuOBgSug7ehB48lHQNFNQwTU5OxCsXBstYJ6VRcvMtE6NxWB+uEI6mncS3jQx441fsGI
 RIw5VZrkEqS/F9ES2lopoin6NU9QTES+hkAqhg5k/XBqofzvy+T5kj/qNaECnH2ZTjxx
 PZOFM2TCsN6Oi1HCu70zTX7/5VQ4mKk+JcIBfGoNnv11wFjJmY8rsQJkg/Lo3MXyFifY
 izBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789398265; x=1790003065; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zEiBoKHET1yJkId8dW9GIBPKw1CXl96YMW9ueIbgyNw=;
 b=QW+DkcfN12AjjJ0YlPT3DABT/s8ArqgM8L15YTzSWb88KxNmJDjbQx9DRFq/MezUgt
 FeJaKCZzLKITcOdZSNu27i61YsmJOmiWZtfok4L+ZUh/cvLAHro3ucVjRGpjy/btMvNg
 MHNbEqrgqWuEqHvDHJu9KB5/FCUt6f3PjfWhAjg2jMutApBlcQNRqgJGLoR35TQKfnTE
 muTLS7U1lqY8fjqelxyTMx/q2N5NZnHghn9i+766XiQjZfHfSRuf9MtMA2S1qdYWVZm2
 y4tvIPJVc9QD4OgUEKaPcEmsWL7aaQ4sZuAshzaWnoWlYKyiHL+YIlMJN87z/ad2Ojqi
 /sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789398265; x=1790003065;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zEiBoKHET1yJkId8dW9GIBPKw1CXl96YMW9ueIbgyNw=;
 b=mMNXzNbrtwu7rpqEyRKJA7nEa9a1LVTQvchDkc7fgxNA+7DC64GnpwMS4Ta6rC216M
 OypUbXSgnio/1qLRMSIijEsJbR8xlPIbXQEiBb3rWIz+dARHy0DOhFVPqKkx/udhpiKD
 syC6xnVc5FPP7DhAogLy3yjeL8E3nZMbGrwklkWu1gFoIBUNJT5XyXVzY4CmDM/zwRRZ
 Adbzz/k8X6OIkR2CRxZ2qfUhLHWcAkvWh96nZxqDmqn3e+VBunaTNCc7KQWzGDS9SSU4
 FoJfYKjoL9MnAV18P46pfDZz04graC5Xzd8kWQu8Rail1gVLW25SmHVY4M4EFEaCng55
 Jw3w==
X-Gm-Message-State: AFuF++lXyTO49VyFZeVriGDlpS/kVQ9yNUJ2nL8tw632ockeCw9zi7aX
 Uvj98LTknQYINq/UxQ43sS2ocrf0OAsF061CIwiw4y1V9UEaRgKETi4OguK1vGdnEqr4mhrx14p
 ngYZTlmHhu0idV/Sse4zG34VfjyFdv70=
X-Gm-Gg: AYBFou0FnMHDkGMiRs5TMzWtfA0LHXjsuUgUSoV3+MMxgBv5q9swL2MfEC0H1WxSTvm
 knAX4sy9VPQeJcYXXQdMKEw7fXef2HLRHutqMNzC9JHww5yw7TbzTxUn8waAsntQ97A+13TXA5v
 mRCtmz9X0SjAG+j5peJAI2/y3e5LQiCwqOFhpOTlv3ht7eWfjhtd0SOUrhr7UctEY+EgYjtYEau
 QNtFRHpTUCDz1G3rs2doF23sVsNdVuSmLq7jXEFq/hYs40S+iji8iskytFDd+KabJz1ixVKUeR0
 +5KdUE6sATXhGt/frkgjPmBDH4NXx5GhOg8pl2ZUE0yGYJAARY1Am+F94bETM+kE278aHmSOElS
 xtfTuRSPlCeLh4kI2r7mxyHxV0ka7+Lmi0K1hl4D3bzuXV1DG4632nIgQJv2lMgaAn+UG7EjFi9
 690niU+vfww1FaOyE9Vk38u74nXz3Tgw==
X-Received: by 2002:a53:ac87:0:b0:66f:c8e4:f013 with SMTP id
 956f58d0204a3-6714e060f40mr870418d50.50.1789398265074; Mon, 14 Sep 2026
 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260817011008.652105-1-satur9nine@gmail.com>
 <CAFEAcA9DGEO3yr0hgeyHjmenVvnYemqXUCHChPa9HDUsUvivGg@mail.gmail.com>
In-Reply-To: <CAFEAcA9DGEO3yr0hgeyHjmenVvnYemqXUCHChPa9HDUsUvivGg@mail.gmail.com>
From: Jacob Abrams <satur9nine@gmail.com>
Date: Mon, 14 Sep 2026 08:04:13 -0700
X-Gm-Features: AcwNN1WowIMFylkNigZV4rloXLzbGT1Os3GFeCXGw3kS8wn-6u5QawX1nl2i9cs
Message-ID: <CAN_B+pAENp-HoAe9=Lh9RwgBxmQTRavmdu=shYkfHwGQ9YifuQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Support writes smaller than
 32-bit
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f39985065b72bff7"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=satur9nine@gmail.com; helo=mail-yx2-x10.google.com
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

--000000000000f39985065b72bff7
Content-Type: text/plain; charset="UTF-8"

I started the effort back then but I never fully finished. This is to
complete that work.

Regards,
Jacob

On Mon, Sep 14, 2026, 02:23 Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 17 Aug 2026 at 06:03, Jacob Whitaker Abrams
> <jwhitakera@gmail.com> wrote:
> >
> > Official STM32CubeL4 drivers use and require support for 16-bit writes to
> > UART registers for proper function.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
>
> This is a bug that was closed in 2024...
>
> -- PMM
>


Jacob

--000000000000f39985065b72bff7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><div>I started the effort back then but=
 I never fully finished. This is to complete that work.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Regards,=C2=A0</div><div dir=3D"auto">Jacob=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Mon, Sep 14, 2026, 02:23 Peter Maydell &lt;<a href=3D"mailto:peter=
.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@lin=
aro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Mon, 17 Aug 2026 at 06:03, Jacob Whitaker Abrams<br>
&lt;<a href=3D"mailto:jwhitakera@gmail.com" rel=3D"noreferrer noreferrer" t=
arget=3D"_blank">jwhitakera@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Official STM32CubeL4 drivers use and require support for 16-bit writes=
 to<br>
&gt; UART registers for proper function.<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/254=
0" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://gitla=
b.com/qemu-project/qemu/-/issues/2540</a><br>
<br>
This is a bug that was closed in 2024...<br>
<br>
-- PMM<br>
</blockquote></div>
<br><br><div data-smartmail=3D"gmail_signature"><font color=3D"#666666">Jac=
ob</font></div></div>

--000000000000f39985065b72bff7--

