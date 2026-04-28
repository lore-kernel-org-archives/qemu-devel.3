Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07B3FF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHY8g-0002VX-O6; Mon, 27 Apr 2026 22:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHY8c-0002V2-U7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:25:26 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHY8b-0008La-0I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:25:26 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so729664766b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777343123; cv=none;
 d=google.com; s=arc-20240605;
 b=D2SQObU991I6QdfhD8NzdWtw7qj9jdKMmgBqWb5tAnFUYLZMSsLc0dQ9C4kbnsCSGZ
 DxWKMo5Afd/GCPh8AXiOWbfwnWes8Ok/dlOoYm740yBm1laDFdBewjFA57lRlenb6Xc4
 mRZlL+RzlSz50cyXTC7ze1OnOfc07yWOXnXzN2DTc3UWS2y73xmN25bf9wdU9IqfdoUC
 Ye9XUUvqMmWew1geW2pIXBNA8iOdQfobfu4UOKoLVDNYeyZ5pAWA42dkDRD/QGOjcvA3
 lhS2SvlbeqCZLfuBpaYRwu8Jc2nLxG9RYGgmTBnwz/JkWSJOAhmxzYSl0xVtqymN7AuB
 AB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GGmEWYLxls8KANOH2+j+eK9MtvdVLC9qr26pYH0HXcM=;
 fh=dFhGIXulk1N4KAOlZEhjLknBn1bqRa0lP8w96jAgcXE=;
 b=QQxpMjskvWhE/jfnO415dlmjVq17pONTmDZFfhvw1dB0uBYtoS/2i+oVk2cqVVQBw7
 2SZVRrKQBJYtOhw3Ls9MVFq4FSS5ZrAlXtQJq4LSQTvftFTatSqQyuvPDjLJ7U3PpwsZ
 bg2J6LV3bhT3P+c6Rxq5Mid/b8RBkNs028IWQmXrDBBR4l+lMR6PXuORsYCG6vcbWOxV
 IQwTvi7wux+nxZVyJHAYo4hOM9JHouiHe6GZT8BJSYRWh6GemlSKGlgyUppblCIuowdx
 FyqTgWhpqb6toYaHGTMkKMUeoqvo7fU0yrqvUe2qFloS1EMfOwlk05DOQ3OwnZdI8CdY
 dJIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777343123; x=1777947923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGmEWYLxls8KANOH2+j+eK9MtvdVLC9qr26pYH0HXcM=;
 b=hqoSN4pv7ssWGjSBLHG5MKuZ0HQKRUkhQg6t6TiBElqz60TRhzd8sbOg95E6AqhZ0j
 4coPLzSlavBI54uuDWxp2ZgvvE01ttTCPKQoRKXNRmMkG786c5pUp9sUMm9mB2ufkZja
 L7mox3WpYzXclvtc2Nx7MDluYXcInOnbesK0K8OgnxUaSIBfsaqS0SNpju9Hoh432ggj
 flXLBE4rHSdvGNGZqykomfSuzYgJPtBCKMh9jMEL+43pewjfiM2/vHu7CFsng7UkwHa8
 g4M0nxpYGJH/DXAPm9inVZatbwRgsQILjdranpBfG0mGarEN68kemYYtBXjcX2n+CetT
 4PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777343123; x=1777947923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGmEWYLxls8KANOH2+j+eK9MtvdVLC9qr26pYH0HXcM=;
 b=R5clOQYPyQ7hRLbuts2b8D75mvICIX4wqiitPMiquezIDeFpJRXsmPjLEPj7fDHJkW
 EIr40OXGP7y/rjnvg7MKox7ctpQ0bmeUCFGW9C6x5Kms0XtKYsVMN36XDmwQrLFOAbHj
 Rkegx7qhRvfREUmUASd1z9qsKssbrXAbMpRqgSnsdTw7KSjIcbmUL2OOqhqzjHKfLTRL
 4YCktufhr7n+kKJWV7VKiWIOrNvVDQyAKgwdVR5z/2U2W9CNqrf6gqroUervlbbLWLed
 W63DYWLDWdK6UrNNh6GlhZSVj33RulQaE5upNyJrVqMdQdb2fofMp2rUmp0/mpTkQe9J
 gx9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SIAB1kByGqVNEWypUmkkACoCBx/A/eB91RJU54oIoqBnlt7wQw8e2pMJPN8nnUfH8PSGjND248l6E@nongnu.org
X-Gm-Message-State: AOJu0Yyzrw8piXGn+4Po+H67ysWPBOEYrs/qrlmCvWVj72GLOsmwKxOK
 xWInavr2xmJlrTLpJ8PI1Bg/uTpiSzf2cYp10TbQ4iLCx8B0gabfSVh91hbfsYxwAMbylkhKCnX
 6ZcJAIZpKn1TquttkPvIxvsOEMrTlYILqmQ==
X-Gm-Gg: AeBDievlLi3zMTsybYw/Fko1D0Ues14vcVtWVLwcwrvLl6rWDt+rUpNwAL+mWPkBEMc
 J8SgGxl6biiY9WNSupeac97F17haXRTtiXgLsI4DHCJuMPtT3m67v7T8Tb5cMphhfjQyAeS0QRp
 PQCqNSQEValxzbX7zrudkZ/T6lRPciVgUJM46IZhqHN49gty3mm3HpKhgY8TDhUjpilSlPemTGl
 ZrdDMEGCeFHTxhZT4CxvhZWlUmp3WK7MCh7xZixq4UxpNeLgcqRcnwr0bKzdRuv/WKFa4Trb76a
 KcRnMc2b/ZG/uxd2BNeKU6BKuIqJxJAYaZZrwdIwzWafe+RS0AYk6u5o0mU=
X-Received: by 2002:a17:907:15c6:b0:ba7:8dd9:cede with SMTP id
 a640c23a62f3a-bb801dd77b2mr40776366b.13.1777343122334; Mon, 27 Apr 2026
 19:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260427080738.77138-1-philmd@linaro.org>
 <20260427080738.77138-21-philmd@linaro.org>
In-Reply-To: <20260427080738.77138-21-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 12:24:53 +1000
X-Gm-Features: AVHnY4LbgUJFPARMEeCqCJHpdVX23fOHmNcHngNz0TzZBb2nLTKgo8WCrkORXGk
Message-ID: <CAKmqyKPhYE+uYtvAweZ2db-CyE4rtT3fC10Uu40U5=b_0tXOmQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/32] target/riscv: Register target_get_monitor_def in
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
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
> Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
> and register it as SysemuCPUOps::monitor_get_register() handler.
> Take care to sign-extend values for 32-bit HARTs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/internals.h |  3 +++
>  target/riscv/cpu.c       |  1 +
>  target/riscv/monitor.c   | 11 +++++++----
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 35b923c4bf5..47becca37f2 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -233,4 +233,7 @@ static inline int insn_len(uint16_t first_word)
>      return (first_word & 3) =3D=3D 3 ? 4 : 2;
>  }
>
> +int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
> +                                      int64_t *pval);
> +
>  #endif
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8ac935ac06e..dbd88fa6655 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2720,6 +2720,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops =
=3D {
>      .get_phys_page_debug =3D riscv_cpu_get_phys_page_debug,
>      .write_elf64_note =3D riscv_cpu_write_elf64_note,
>      .write_elf32_note =3D riscv_cpu_write_elf32_note,
> +    .monitor_get_register =3D riscv_monitor_get_register_legacy,
>      .legacy_vmsd =3D &vmstate_riscv_cpu,
>  };
>  #endif
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index bca04a7580c..3898595a3cb 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -27,6 +27,7 @@
>  #include "monitor/hmp.h"
>  #include "monitor/hmp-target.h"
>  #include "system/memory.h"
> +#include "internals.h"
>
>  #ifdef TARGET_RISCV64
>  #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
> @@ -311,16 +312,18 @@ static bool reg_is_vreg(const char *name)
>      return false;
>  }
>
> -int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pva=
l)
> +int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
> +                                      int64_t *pval)
>  {
> -    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> +    RISCVCPU *hart =3D RISCV_CPU(cs);
> +    CPURISCVState *env =3D cpu_env(cs);
>      target_ulong val =3D 0;
>      uint64_t val64 =3D 0;
>      int i;
>
>      if (reg_is_ulong_integer(env, name, &val, false) ||
>          reg_is_ulong_integer(env, name, &val, true)) {
> -        *pval =3D val;
> +        *pval =3D riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
>          return 0;
>      }
>
> @@ -369,7 +372,7 @@ int target_get_monitor_def(CPUState *cs, const char *=
name, uint64_t *pval)
>           * to do the filtering of the registers that are present.
>           */
>          if (res =3D=3D RISCV_EXCP_NONE) {
> -            *pval =3D val;
> +            *pval =3D riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
>              return 0;
>          }
>      }
> --
> 2.53.0
>
>

