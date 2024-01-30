Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE46C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjdR-00065M-NZ; Tue, 30 Jan 2024 03:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUjdR-00065C-3m
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:38:25 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUjdF-0005F0-GR
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:38:24 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so2853218a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706603891; x=1707208691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSbnHp6i12NuDgLGZnfA5/XL/oEtURbfq35a98ilu7I=;
 b=T10BffwK+InD11HVrDWyEcE7FJJX1b5gLnTzVqy31ft7jygtWq0ka1TjvixH3pu0uA
 E9e+ZMB7ddx8T9Mj6Y40uf9IiLWKtpe1a21auvhXxZ5uv3rTHn8Gqwb+VVklfx07BqEr
 ++mfohoCcuIlRX8rHWPKcbcNS2Txgep84Z3XMCcySzhN3smywOItvQytg06Os9uHZacq
 k3kenfHAGGAYCE0Idg/+fMlLU1+BOGOUY0EyvHclzTeXeEQZF71B4CwUHZd3mKOLu47J
 w39qbfkzKztiwIy8II7ONLow++iN2dlmRQgw64q1lrVbVvLQH4dEADohQX1aQo/Kbh5j
 2fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706603891; x=1707208691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSbnHp6i12NuDgLGZnfA5/XL/oEtURbfq35a98ilu7I=;
 b=C/WsQ92OkKPp6eaxOlzJMn3ZXU0T1X0UQHsKjJBZjlC6RQ3Mo4gCr7eiPrElcFudCQ
 hkpPu38kjnSNIB4NC2ShS/tPDfAtXAazeTkpGmt07uW0I1D+Fa3iklHHY6F4Y6pvyzcU
 NskKnxkLOp3IladZhCYyH5FeE9Bgrq1MgWQrXDuvXTfM1jdX8iAj6StwyErg5697epPn
 gmG0Z8HnD6HdgjlvMjHQoQfsVC5ClJqoycwtcj10tpLPqGT6ZBs8EUfCYEjkcfdWdh2o
 qe9GVZFYFIWueuo0Q6KooESBkseeEcR73Jwt4+09kh699GwkYlmlUCTL2u6kcJN9EKQM
 MVtA==
X-Gm-Message-State: AOJu0Yx/SuO66QHv73FrftoGwlgGuZiVrhERtcvmcEOe/Z32faYL3ln1
 bn/FHJG8+AILbisI4C2csPZ/maysGGGJ7vKuXyxaOxQx6Yu2VjHFOIVXzR/fsUFXOTpDyGi6S06
 HUVEiHykQab/Jy/RxUoyYXLEP/d61k8PmXGo0atKlN1/xo90=
X-Google-Smtp-Source: AGHT+IGMYRynEdDH1x/xv71CH4xy+mSwNQYLwXJov1pFLz6YHMEpdEfmG/2ZReWj7Iub0jUL+KU6YA1zSdVSD0Hmzmw=
X-Received: by 2002:a05:6a20:c281:b0:19c:8d73:721b with SMTP id
 bs1-20020a056a20c28100b0019c8d73721bmr6047952pzb.57.1706603891355; Tue, 30
 Jan 2024 00:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20240116130213.172358-1-chigot@adacore.com>
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 30 Jan 2024 09:38:00 +0100
Message-ID: <CAJ307EiG-evcBey_VdaOZ6X3VyR24FC3+A_DvP+5sWp+6CwTEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] sparc/leon3: Add support for -smp
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hey Philippe,

Gentle ping on this serie

Thanks,
Cl=C3=A9ment



On Tue, Jan 16, 2024 at 2:02=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:
>
> V2 modifications
>  - Patch1: Add SPDX copyright tags.
>  - Patch3: Add defines for MP_STATUS fields. Improve comments.
>  - Patch4: Improve a comment.
>  - Patch6: Dropped as already merged.
>
> ---
>
> This series allows leon3 emulations to record up 4 CPUs.
>
> It requires some enhancements in the grlib_irqmp device and adding the
> cpu_index field in the asr17 instruction.
>
> It has been tested locally with various bareboard runtimes.
>
>
> Cl=C3=A9ment Chigot (8):
>   sparc/grlib: split out the headers for each peripherals
>   intc/grlib_irqmp: add ncpus property
>   intc/grlib_irqmp: implements the multiprocessor status register
>   intc/grlib_irqmp: implements multicore irq
>   target/sparc: implement asr17 feature for smp
>   leon3: implement multiprocessor
>   leon3: check cpu_id in the tiny bootloader
>   MAINTAINERS: replace Fabien by myself as Leon3 maintainer
>
>  MAINTAINERS                                   |   2 +-
>  hw/char/grlib_apbuart.c                       |   6 +-
>  hw/intc/grlib_irqmp.c                         | 112 ++++++++++-----
>  hw/sparc/leon3.c                              | 135 +++++++++++++-----
>  hw/timer/grlib_gptimer.c                      |   6 +-
>  include/hw/char/grlib_uart.h                  |  32 +++++
>  .../hw/{sparc/grlib.h =3D> intc/grlib_irqmp.h}  |  18 +--
>  include/hw/timer/grlib_gptimer.h              |  32 +++++
>  target/sparc/helper.c                         |  16 +++
>  target/sparc/helper.h                         |   1 +
>  target/sparc/translate.c                      |  13 +-
>  11 files changed, 278 insertions(+), 95 deletions(-)
>  create mode 100644 include/hw/char/grlib_uart.h
>  rename include/hw/{sparc/grlib.h =3D> intc/grlib_irqmp.h} (83%)
>  create mode 100644 include/hw/timer/grlib_gptimer.h
>
> --
> 2.25.1
>

