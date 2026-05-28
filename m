Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C8CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaAO-0006K6-1o; Thu, 28 May 2026 08:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaAM-0006HJ-D7
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:48:50 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaAK-0004oJ-Ln
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:48:50 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7ca947f9b00so123339557b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779972527; cv=none;
 d=google.com; s=arc-20240605;
 b=IMgxUFwOF5TY5emHxLK5r9MRYrZ3lOLfIGRrR/xt04iI2fZAUqroWek2iRE0oHs+7t
 TeyU1ZWpxp8A0ZvFCbQUj9l5gRhGa2eZeJPrRPamdG1OFIZiRz2/ymay0WNgrWBcoNJO
 RJnDjyVWO07MLDt1wU2EbJCESSO4LNa43xwTX+qaP4hqQUMgc+yq7MO5hpGW5Y2RZYhS
 z4orpIDsoJIAdeJn99RFYrypNH5/KCzDkyafya7ZY9KlxxFpIkH4mzi3UbDE7xJulpXh
 3qLjbPjn6HKvRX2NJ5exTKxw7DBj0sowLQwCManfuxZ6AyUdDM0xIaYCNyH7LyHy0mjG
 gwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uULkq0CWhvjpVNl16Je4frkQeBm/FWygevV3ElnqYSc=;
 fh=HROkOHGG7+GqwI0QEWLKj167C0Xo3Zn5D803R3bwzGE=;
 b=UmV2DkC9WTLJEkFSRbmFDoQrJl8/0O/y2/NZDii/LoDhRah3b+MBItLskekS/PIwZ1
 HqKLtm4qdJ7eT+fNo3YqyhLKfSpkwOTFtHeAg0dPnCjzhcQwTg0mzLK7Jcm3GJhpN8Sz
 wrD5SjgByYeaoVaklqhXLrGOu377U/w3MnXWPVM5scFGmlhcRJSdLZKurMMEZQzWaull
 TvfLq88PpTUgjFNHKyeXj1oI7VVBMOvYo+QbzBiuvRrl0IVdq/MdNOSlEZNoh5yvxRLd
 QzCvJngLEfGuJoucCsuJAOowh6NjJw9n/b4AE0u1wLdV2RcFl3Hd6Lijy+vrXBwayDwT
 scrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779972527; x=1780577327; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uULkq0CWhvjpVNl16Je4frkQeBm/FWygevV3ElnqYSc=;
 b=jb/NAeCyuiUjaZ5DStKao+1/QInigLPeIokNGEjhGyIryEmhT1vJ1IuDyrpPvmf7xc
 oea7/c51G7Q+TiXXgPtDQ1RySY++KZqJLNpM4d3Xzr3W62ZsJq7e1h7pqztq3JDalkNq
 KQsvU9ceFka792noG2T+UaVxN3nb6/ftD/IUaW8NrfQaNvNYW5nyxDnrjTtDZDSTj8pp
 LJf9c/6ortdMyavpLDzXhumjVNWW+JaIZInEP/8BBxuGjxq7/jjJ1wC7m1U8HkHrUmr+
 c5ukSFWdV8+QTQJAxqTQtj8oDW0mqqmDaRNd5l/tOiilCSf6iKU50o2mqDaD2NxshRFw
 iCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779972527; x=1780577327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uULkq0CWhvjpVNl16Je4frkQeBm/FWygevV3ElnqYSc=;
 b=fsY8OIVhnh7z5FNOAj5E8ido4K8K6jkZ3T92mgmU8Z4eKOXy+nIuhEVGemivQ/IeLJ
 zy5fDSWlfwwRW7HlhibRQCY95cKwwBZmaqPNmhbzNmULu0G75wd6lf2dlEhG2VAKRuUU
 4BSJMl3T72OXnr9Y/ffyPtBPSsBb/RSaj6uOfP1Gtg7x+8Mfqp39pbIVoWcwM8rqOy8s
 dGA9/+IC84I4Xtxfw3zH8QjT1/j04Zh+sGKzbG99WlNtrN0mZvBgXLHluZSj6oC/C7aO
 5G3I3xuiuW6asMgkiXnRDLXtBrk7MG4v4Sj3XqBpC9AG1sE7CE8QQJcgdibUGW32YcGV
 HETA==
X-Gm-Message-State: AOJu0Yz8dwq5EuuZcdhpoUXDwcOVwrmCsHxaY3k/YAM7EfWsEmyeXkXv
 B6vqxqoyV4JVPGFAKsq30koWCiLzrhHCY+jzr1KJfKZOIHzmLmOYcyyxvfBQJ7UuZNgm1VbAmsQ
 hC3MhJYImDvIHO+G49vOIwgr5RcChJsJZqrWapQn7CA==
X-Gm-Gg: Acq92OGecML2WFdb9TT+xearrTkhgqLNHyJR2bSUQT4Z1jI+85K+NvOgo2w1xkZtPOa
 +L60xlyVrhaLqxdgWco8iw6gEhMRgvX6GvSsTfa0+C4m9bbM7Bw0sbrbq3OH0BXlezwM+tnMKs5
 Tot6gIlT072TTN80cqXuEViRRLHPCbr7ilXPfhtrkHVBzcraW766k39ecy+6yLk95LLUnRqFC2i
 A3QIIRN70fobJXA8Gh735D23Fvh4nXiqeSCKwzk0BAXGJQUIbau56a8J6MTYhHVr4j9zIlcu/IE
 sGP4GR4Qv2skpWiNzTj3bOO3Gj2Kps2nYya3lO8yzzdPnZLCLgMkn+/F1oG5FXBrWMdmEil6oPs
 1XAATeX2Vtt1d
X-Received: by 2002:a05:690c:a58a:10b0:7dc:4ba:ee15 with SMTP id
 00721157ae682-7dc04baef44mr37166067b3.43.1779972527179; Thu, 28 May 2026
 05:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-17-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-17-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 13:48:35 +0100
X-Gm-Features: AVHnY4LMTX3iMcz9UD3K4nrUcZbmV_dsNctcTQSu1TAWCS_GQkSkd5NSVDalGjc
Message-ID: <CAFEAcA-n+KnJG94SoMK=9AxzrW2kv1tLAShSUdi5SuWT7wM-5g@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] docs/system/arm: Add support for Beckhoff CX7200
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> This commit offers some documentation on the Beckhoff CX7200
> qemu emulation.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/arm/beckhoff-cx7200.rst | 62 +++++++++++++++++++++++++++++
>  docs/system/target-arm.rst          |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 docs/system/arm/beckhoff-cx7200.rst
>
> diff --git a/docs/system/arm/beckhoff-cx7200.rst b/docs/system/arm/beckho=
ff-cx7200.rst
> new file mode 100644
> index 0000000000..6163a0cfa5
> --- /dev/null
> +++ b/docs/system/arm/beckhoff-cx7200.rst
> @@ -0,0 +1,62 @@

Checkpatch will complain about the lack of an SPDX tag here.
For documentation, the syntax to put this in a comment is to
start the line with ".. ", like this:

.. SPDX-License-Identifier: GPL-2.0-or-later

> +Beckhoff CX7200 (``beckhoff-cx7200``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

One "=3D" too many. The title underlining needs to match the title string
(some Sphinx versions will complain about this, but not all).

> +The Beckhoff CX7200 is based on the same architecture as the Xilinx Zynq=
 A9.
> +The Zynq 7000 family is based on the AMD SoC architecture. These product=
s
> +integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
> +processing system (PS) and AMD programmable logic (PL) in a single devic=
e.
> +The Beckhoff Communication Controller (CCAT) can be found in the PL of Z=
ynq.
> +
> +You can find more detail about this board on
> +`the manufacturer's product page <https://www.beckhoff.com/en-en/product=
s/ipc/embedded-pcs/cx7000-arm-r-cortex-r/cx7293.html?>`__.
> +The SoC is documented in the
> +`Zynq 7000 Technical Reference manual <https://docs.amd.com/r/en-US/ug58=
5-zynq-7000-SoC-TRM>`__.
> +
> +The CX7200 supports the following:
> +
> +- Arm Cortex-A9 MPCore CPU
> +
> +  - Cortex-A9 CPUs
> +  - GIC v1 interrupt controller
> +  - Generic timer
> +  - Watchdog timer
> +
> +- OCM 256KB
> +- SMC SRAM 64MB
> +- Zynq SLCR
> +- SPI x2
> +- QSPI
> +- UART
> +- TTC x2
> +- Gigabit Ethernet Controller x2
> +- SD Controller x2
> +- XADC
> +- Arm PrimeCell DMA Controller
> +- DDR Memory
> +- USB 2.0 x2
> +- DDR Controller
> +- Beckhoff Communication Controller (CCAT)
> +
> +  - EEPROM Interface
> +  - DMA Controller

Just to check, are these indented because they're
sub-features of the CCAT ?

> +
> +The following is not supported:
> +    - I2C

You need to have this with the bullet point not indented, and with a
newline in front of it:

The following is not supported:

- I2C

Otherwise it will be interpreted as an RST definition list, and
rendered oddly.

> +Directly loading an ELF file to the CPU of the CX7200 to run f.e. TC/RTO=
S (based on FreeRTOS):

I would drop "f.e." which is a slightly nonstandard abbreviation.

Also this line is a bit overlong -- generally worth breaking
lines at about 70-75 chars.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

