Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0C1C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0WB8-0003Oe-FY; Thu, 03 Apr 2025 21:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WB6-0003OR-3z; Thu, 03 Apr 2025 21:49:04 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WB4-0006C2-GI; Thu, 03 Apr 2025 21:49:03 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5241abb9761so717723e0c.1; 
 Thu, 03 Apr 2025 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743731341; x=1744336141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+HwvJwjyUxwDkz3tMrTVukg9CtFWpkkBm7Cp9/S2Hg=;
 b=RxclGI53gzUlb86RCYB3yRdyEf1bUkE1qiurkTNvVWInfHidPBxVEcI15rW9QDKcTF
 UO/Jitzyrn96Lu2Rwh/1pDBqrlWm2BcZlYUeggAbQYhk5i5RTEp/+KRudFbRnuztM1mG
 cPp8Nlzr8uoNoPm9QmBklcSS/fH9qVModCNOkvXeyV86xtPb2KNz8WhHHETyw43mPSKD
 XQVEzFC6C1Oq2JqaH/JoOIGs5mvW9pEFepfBgOwdQgHQp/sCYtwg9GxpbHO9O2y3EoRa
 TskfGFxw4AC7Yr2b43VMvlqQyTFgAWx8lhScQh7fwxQbhrPHJi2rbapKQOMKybbHO40w
 qZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743731341; x=1744336141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+HwvJwjyUxwDkz3tMrTVukg9CtFWpkkBm7Cp9/S2Hg=;
 b=gUTlTUuAb31bXwMqQOattX2/OvXux+pQySPV8AMWRfahLgWbULaXZF7zspQWi+3ja3
 mxwZyEolHBdnt+7M3mLl4Ks2uPknOg+PHL4/7ZXLUlTgZy3P3I09Kj+KFIA28Mq1CQKy
 yS0Xczl+HhJgvo7QBBQjJtaQ8lM0Ib7yLCFSZhXW+DhuR9rGTgfRji8qDL6+/DWldgyW
 MW7MzgeYKbhBTJwfdGMjLn9htpP3NdsQZ8gi+Qccwc3DnWPUGMT+Yo/rFSQtSWKqOtjH
 GrY1pF00xeX2LpmFoUFfTBeAM2cGEbmSDql3oJLcqq78R8gnBlzD0+KnVhpnHA6nd56D
 Rliw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8nGNHlZq0PFs7H/dNHvTqwBbi/ium8G1vX5Cu2LkTQo2cOvQPvFiPfMpjQDaNo1FNr92wleyMKyIy@nongnu.org
X-Gm-Message-State: AOJu0Yxl8qcci7jNaJ3uAF7HzRb9Sl4ifb7SGIrCYF2tnSPRsgzkcmyb
 SSwwQwNa/6KjdWBJqOuEREUuh4+KF9iapOllZ8O4Do5l59SVn7lMiv6NEN1z+8cBMnzBoQZ3Q9+
 XJet57N62RfG+AINRBQFTR2luAFVr9A==
X-Gm-Gg: ASbGnctFLovpLQcdk9iu9aMaDx2euXihDrnss1g3TyJLzX+SV5ESSlQSSqg1REQtUGc
 m3Bs+Pt/YqeUo9bfDYhWiTgCrCM5uGgEz42PTtG715pnTAhPgO1etV9Tldb/kbtPV7qndu5ODOk
 zORC22t8MnPS5iixR1wTIvW9Ns5hBD5Ox5mns5YN2TiUKmL+qfAP6EOgti
X-Google-Smtp-Source: AGHT+IGylMMkCJVIoK8sED8rFeiSPFVuJyVOewReLhca3YyYvmYZ4THMDM7IUBaPvpO4S+LYcJ3rywVdjFeXX1Ru0Nw=
X-Received: by 2002:a05:6102:334d:b0:4c3:6393:83f4 with SMTP id
 ada2fe7eead31-4c856889f09mr729309137.2.1743731341078; Thu, 03 Apr 2025
 18:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-2-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250319061342.26435-2-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:48:35 +1000
X-Gm-Features: ATxdqUE32i13qZkXGsO0Mg1vALnBle3PJDILEHnf8JJhlmJ5ANGZz4NSK8XonJQ
Message-ID: <CAKmqyKOdZZOiDocDFw=DmcRwDc_YcD7YYgFKrT1QJNW8rOi3Lw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] hw/misc: Add MPFS system reset support
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Wed, Mar 19, 2025 at 4:13=E2=80=AFPM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/mchp_pfsoc_sysreg.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> index 7876fe0c5b..08196525aa 100644
> --- a/hw/misc/mchp_pfsoc_sysreg.c
> +++ b/hw/misc/mchp_pfsoc_sysreg.c
> @@ -27,7 +27,9 @@
>  #include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "hw/misc/mchp_pfsoc_sysreg.h"
> +#include "system/runstate.h"
>
> +#define MSS_RESET_CR    0x18
>  #define ENVM_CR         0xb8
>  #define MESSAGE_INT     0x118c
>
> @@ -56,6 +58,11 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwad=
dr offset,
>  {
>      MchpPfSoCSysregState *s =3D opaque;
>      switch (offset) {
> +    case MSS_RESET_CR:
> +        if (value =3D=3D 0xdead) {
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        }
> +        break;
>      case MESSAGE_INT:
>          qemu_irq_lower(s->irq);
>          break;
> --
> 2.43.0
>

