Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44092D41173
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLyy-0002uV-38; Thu, 15 Jan 2026 06:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgLyv-0002tA-6G
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:57:42 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgLyo-00044o-Lb
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:57:40 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-78fdb90b670so6970007b3.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768478252; x=1769083052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhSQBKfxXI2WsQjOVZiYLAiw51bdDJWmLOFxmvaZu5g=;
 b=WSF8uMykznuMrV8KcA6V01i5Wy5gczge6rB7ALAlBr14G5xxHQItngdaIP7DvJE6LK
 dEH4VFTsVzOeudbITp3a1bCPvrl0Nwurn1ZLAnBpXpym9ydW1wRKOMSG09D0ScoTa0CC
 wdPvwrqVPxVucwDuPv6JyeIPxs/2EHHt0DWi2mzn+nUyoFhIo0FX6G1unRVd5XxMHUis
 JGpgedqLFDhCqCkOrr4F5K0dwApZJKrjcJG8XCdsjrLYBCqkgZlz8QPhV2bxSXyFGO83
 IDIuRwET1S6K3GmOfLjTqvGbV4ITWL9PtwwtT4qdxf8+au+N6+o0FSPZH8o1bSR7ixSM
 SryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768478252; x=1769083052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hhSQBKfxXI2WsQjOVZiYLAiw51bdDJWmLOFxmvaZu5g=;
 b=PJ/OtJn9nkEdQWuCs7C8VQKFxEvfGGhcOw3iRoSvCAICLF1+8yc2Vt+MaLUA4sAWV9
 4b19GrIirrNZe0sqE9t7oLCr99Mq0/kaZRvcyl74alBD2Vm3jyYpCFDMV80WWzz6cCTb
 ep9GiYwzlmyd0Ssu0a7kk0RVi29bQmAB/BLYipuBJJaGQc0bJ1ynJLUmaYEom2Rnpncf
 Nib/F+svhjasRbDIbuIuWL2eAtdKJ1RAJ4sTQypSOfnHQwbDP5wZ0pzKLha2Kbc8Qd0C
 oAnEXtN7iAJBqmETHcxgUbIkZ7pGipnfE8uh03YUnaiaFxZDEKokEDJeRwAqpm00Oa1s
 9cRw==
X-Gm-Message-State: AOJu0YyL/UGAgwCBdSystdBb60BpweC5X3aUun5h/kvVCGTHPoG6YN/D
 eMzbZ0iIcVDhPqRBWWSQA8cBis2XmTgj+MyX3D57hmRdkb2VKnyQSNSMZUaByz+6EMVeXFUF426
 5KtezpCgzr5yRqG25jJu6BjxT9vTI+idEP2iGaGupGQ==
X-Gm-Gg: AY/fxX7o9NNecssnB0SmP/NWRvu8FZNL38AEREwazK0aFaW6UAMWUSXz6K1bQMcUIpE
 TK7j1iSOoc+SPzfiNjT1rtO1Z1qr3mnVE5jBw2HBg72UaKqoHw4z3G6vFH+xSkHuwGyjz3aaB4Q
 TiX+CSzZNSKP0A3uTVsPDMZNlMwZYHWSjyjGSId0E3p145JiGph8WVo8lr/Vd/oVV4fxtcUCDal
 bSGUUXUuIwCMJsKzaEmRMdG/cwY99G69Flu5nBFTGw5VhXbbholRw2Jbd/cdFv+gOxU0teeNm6A
 s+KgigAd30ATb+xCGpwz1pg=
X-Received: by 2002:a05:690e:1898:b0:646:ba5e:4cf4 with SMTP id
 956f58d0204a3-64903b45b26mr4252154d50.51.1768478251501; Thu, 15 Jan 2026
 03:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
 <20251204093502.50582-16-corvin.koehne@gmail.com>
In-Reply-To: <20251204093502.50582-16-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 11:57:20 +0000
X-Gm-Features: AZwV_Qg2qS95djnbs1LQP81AeoC4hcz9OBzeKUlAiFOlXgF8vAqjY1OMyOaxDBE
Message-ID: <CAFEAcA-fU1qxTCoHaEQfGOmPPHyFL2Q74DXvLyti+28xe2bM+Q@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] docs/system/arm: Add support for Beckhoff CX7200
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 4 Dec 2025 at 09:35, Corvin K=C3=B6hne <corvin.koehne@gmail.com> wr=
ote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> This commit offers some documentation on the Beckhoff CX7200
> qemu emulation.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>  docs/system/arm/beckhoff-cx7200.rst | 57 +++++++++++++++++++++++++++++
>  docs/system/target-arm.rst          |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 docs/system/arm/beckhoff-cx7200.rst
>
> diff --git a/docs/system/arm/beckhoff-cx7200.rst b/docs/system/arm/beckho=
ff-cx7200.rst
> new file mode 100644
> index 0000000000..f060319b0f
> --- /dev/null
> +++ b/docs/system/arm/beckhoff-cx7200.rst
> @@ -0,0 +1,57 @@
> +Beckhoff CX7200 (``beckhoff-cx7200``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +More details here:
> +https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Techn=
ical-Reference-Manual
> +https://www.beckhoff.com/de-de/produkte/ipc/embedded-pcs/cx7000-arm-r-co=
rtex-r/cx7293.html

This doesn't render very nicely in the HTML documentation,
because it comes out as two bare URLs with no line break
between them. Can you write this as something which uses
the rST syntax for links, please, e.g:

You can find more detail about this board on
`the manufacturer's product page <https://....>`__.
The SoC is documented in the
`Zynq 7000 Technical Reference manual <https://...>`__.

Also, is there an English language version of the product
page? Since QEMU's documentation is in English that would
be the better link if it exists. Otherwise we should warn
the reader by adding "(in German)" when we point them at it.

> +
> +The CX7200 supports following devices:

"the following"

> +    - A9 MPCORE
> +        - cortex-a9
> +        - GIC v1
> +        - Generic timer
> +        - wdt
> +    - OCM 256KB
> +    - SMC SRAM@0xe2000000 64MB

The "SRAM@0xe2000000" renders as an email address hyperlink,
which probably isn't what you intended. I don't think the
address of the RAM is particularly important to the reader
of the docs, so we could just omit it.

For docs changes, I recommend making sure your build
is building the docs by passing --enable-docs to configure.
Then you can look at the HTML that is generated in your
build directory under docs/manual/ to check that it hasn't
come out with any unintentional markup issues

> +    - Zynq SLCR
> +    - SPI x2
> +    - QSPI
> +    - UART
> +    - TTC x2
> +    - Gigabit Ethernet Controller
> +    - SD Controller
> +    - XADC
> +    - Arm PrimeCell DMA Controller
> +    - DDR Memory
> +    - DDR Controller
> +    - Beckhoff Communication Controller (CCAT)
> +        - EEPROM Interface
> +        - DMA Controller
> +
> +Following devices are not supported:

"The following"

> +    - I2C

thanks
-- PMM

