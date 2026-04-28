Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4766FFF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHY6s-0001v7-7M; Mon, 27 Apr 2026 22:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHY6r-0001us-4d
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:23:37 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHY6o-0007Yj-9S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:23:35 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bb3c4d8cc29so262408566b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777343013; cv=none;
 d=google.com; s=arc-20240605;
 b=SeTolNt7clsZ1aqfeHRjf4ufdLYtmDmmE0kCo+J0onpq+SPQmsZI8ozRNMbex6QlcO
 BGB46iCt+GY6kmlYMzm4aGb6no0IJ3M+5rYTGyWMt24235EDg++cMr4afrgdnYd48xMX
 pVxU+xqHZAXN/pWnrdVL+Z0vpoxeSOgImJdGV6/bV4qFZ4UkJ2HnEgJ8gIhxNOU7TEp4
 mzQUi3YPE7Y6cC0FZJ5OJ5xfXVdTkTKfV7c/ZUhuTzjJ2P8jwy25bTK3fDGY1EP9ut0+
 5EAPbsqVpX+fnRZ5FzyK6T3ET/V8BcZSpOmL6sNoW5+IQnOw+D0YEUdpFiS3ZpcW7M9J
 XOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mr+G2hCk1Ov6y0E9/4Hwfj8a+5qO1RQNtC4Kr0hrqyg=;
 fh=q0OM5RabvX/sHt96dG4/MBbaZUOAEhdH4+aKddA+inE=;
 b=XZz0Tgdo/pbwlGq8p2ae/OiHIxTzOOkBqkpUC9RduJlPJ3WHfKtnUEjZ22it1cUdWu
 WjodHfTm1RCv4CooiasVsLDLcuayzIbazztbDnjZmFRaFn+xkJ2uVfRW3GmGchb+ToaV
 ClOIAq0e9ITKX9cmLPdZIvWNYFKvkQ0tQn3Ugbe/SP8+yGJyZ3IKbooRzzF+2NFb9qB+
 SlN7JfibUZJLG4Ux1ynhbJ12frCmqmBtVLO3AK6RbtZPNQxUqQ8OkA6NbFcDp74Xkdmj
 vOvUsjSSSZaUU94MSolyqUmUCTWBkvar0xpt0DffcgsIqyd6SsRZYhhYPZef7HlsDL+2
 +INA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777343013; x=1777947813; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mr+G2hCk1Ov6y0E9/4Hwfj8a+5qO1RQNtC4Kr0hrqyg=;
 b=CupwUyz6lFQvv+hCu9TkCofhTgeVz+IPFh1XZ+tXexqg68l4CRSQ0nR9h7YGajtK8t
 tbt5l0jcivg/kaWT3QWsVlsV9AIN11HnovnQbxdnhpxIavDH7e/waYnJ8S5sHTPsAqf+
 3SU55NBIsWDGBO4/MOOsR18IGB96vofpKtgECofOb/RDk4RmZp7mxP2pt1wvbX+/+hBh
 Se3OuqhZZqIqpcvb44OVNyyw77vb6Y7xyeyBU6PS/v84iR54C3IAFVm6pot0MVKOVYEz
 uIS/TOd95v58/caDaL2PgLskWfR0J3tyLTTcbW4CJBJWORl8ymtiPDofhIZL+PipGqUp
 lG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777343013; x=1777947813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mr+G2hCk1Ov6y0E9/4Hwfj8a+5qO1RQNtC4Kr0hrqyg=;
 b=sEVQzToBELwwR9vKFAHIZYxYT7GbqvAh4HSTSx6KmYVAEa+97siYdpyi+bS4zLqvc2
 GGQftfDQvLQLDFTZt7JUrzT+TpnFfrYkGY5VZfXSZQ7pmHdJMZIlG8E7CfHtqR76LGn7
 PsZEKMnEEuaT7rrVpdwyDqZzttukMMoVEIvshskz5Xbo4TEzMm20mNUSsENfcytP9Mca
 DkjKBRgTNbn7n6dmiflSk+TIbbQ4nYSMHlnat7k4Xi8LeMI3pOFn7EZFERymimIw8lOD
 r5t7Z1+xoLEt4qR99FD4CsNMKHaEMXNDHdQ4MtOKdoAdiKZSoV2DpFbOUClIfU6MVwYK
 A2Eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wSafNdomQNwZzXgoxgcIQPzuOL/CNa6BX0dHYziGWtMG3Z04HnSspZkgwU5NGVd7/h3xhiQ97sOyF@nongnu.org
X-Gm-Message-State: AOJu0YysO1Y695zkFptWEwpY/hA1Egz3GLMSKcSTmeRgh7rxkrZcMJjz
 m6Q33/6fWF5werqRtjOKU4TFtfhGo0kJcBUcbJ1ZNwEplWSQoySjW9v0vv6zRAKQ5BAeO1j9g+n
 GGf3nytCq8402I1i7FrxWdQjcO0AwgB/nXQ==
X-Gm-Gg: AeBDievd6s5T5kAJRoZGkcFsv0bkblE8iNhBlTax8J2A/e+lVywGD7s6sZ9SPLI77Yd
 DyQ7BWlfZcGNl7AHvBeHNi036BR5K68OUydDThIO5NV19NhWg7/zt0Gsm4q9Rmf9OS5/wbB85jO
 /tQZxKzGausez1Xj5e2r3ehaTVnpDyrXmk/bJCohyltpgJmjnbN0Gp7T8GztCd73w5emDOavCR+
 HJG26LiuRoV1vG27nDqFx2v1a7LDzVXcAQMFuwMy26dQCUaSPH4Y0D5lmestU3OMVseyIsSPYo5
 ogMjZ3lmM0m475MN6rXmlWvStkYWEIu2vr37IhCsGQSO6x+J
X-Received: by 2002:a17:906:f588:b0:baa:1d9:66ff with SMTP id
 a640c23a62f3a-bb802da69dbmr69703166b.20.1777343012549; Mon, 27 Apr 2026
 19:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260427080738.77138-1-philmd@linaro.org>
 <20260427080738.77138-18-philmd@linaro.org>
In-Reply-To: <20260427080738.77138-18-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 12:23:05 +1000
X-Gm-Features: AVHnY4L5IgmFfU1GrvFcbEtRdC4bQA8uvVVVq0DbNVfoQUAR-Z4-6HLTCWy9tO4
Message-ID: <CAKmqyKNySBeoVkHdMUM7SY4oQyeS7OPNMqGoRcPs9JhHifFwEA@mail.gmail.com>
Subject: Re: [PATCH v4 17/32] monitor: Do not check TARGET_I386/RISCV to build
 'info mem' command
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Apr 27, 2026 at 6:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> This command is filtered at build-time for i386/x86_64 and
> riscv32/riscv64 binaries. By using the recently introduced
> HMPCommand::arch_bitmask flag we can filter it at runtime,
> making it possible to compile hmp-commands-info.hx once.
>
> Since the method depends on a pair of distinct targets,
> define it in its own stub file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  stubs/hmp-cmd-info_mem.c | 12 ++++++++++++
>  hmp-commands-info.hx     |  3 +--
>  stubs/meson.build        |  1 +
>  3 files changed, 14 insertions(+), 2 deletions(-)
>  create mode 100644 stubs/hmp-cmd-info_mem.c
>
> diff --git a/stubs/hmp-cmd-info_mem.c b/stubs/hmp-cmd-info_mem.c
> new file mode 100644
> index 00000000000..8a53e367a9f
> --- /dev/null
> +++ b/stubs/hmp-cmd-info_mem.c
> @@ -0,0 +1,12 @@
> +/*
> + * Human Monitor 'info mem' stub
> + *
> + * Copyright (c) Linaro
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "monitor/hmp.h"
> +
> +HMP_STUB(info_mem)
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 336ab870a2c..2d0a8f7d48f 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -209,15 +209,14 @@ SRST
>      Show virtual to physical memory mappings.
>  ERST
>
> -#if defined(TARGET_I386) || defined(TARGET_RISCV)
>      {
>          .name       =3D "mem",
>          .args_type  =3D "",
>          .params     =3D "",
>          .help       =3D "show the active virtual memory mappings",
>          .cmd        =3D hmp_info_mem,
> +        .arch_bitmask =3D QEMU_ARCH_I386 | QEMU_ARCH_RISCV,
>      },
> -#endif
>
>  SRST
>    ``info mem``
> diff --git a/stubs/meson.build b/stubs/meson.build
> index f086521cde4..33053d932c8 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -87,6 +87,7 @@ if have_system
>    stub_ss.add(files('qmp-cpu.c'))
>    stub_ss.add(files('qmp-cpu-s390x.c'))
>    stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
> +  stub_ss.add(files('hmp-cmd-info_mem.c'))
>    stub_ss.add(files('hmp-cmd-info_sev.c'))
>    stub_ss.add(files('hmp-cmds-hw-s390x.c'))
>    stub_ss.add(files('hmp-cmds-target-i386.c'))
> --
> 2.53.0
>
>

