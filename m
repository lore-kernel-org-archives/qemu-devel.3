Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1A6CE7AA5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 23:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smM69-0001jk-Jm; Thu, 05 Sep 2024 19:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smM68-0001hy-9t; Thu, 05 Sep 2024 19:41:08 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smM63-0003Bl-8F; Thu, 05 Sep 2024 19:41:08 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-49bd3bf3b4cso450235137.3; 
 Thu, 05 Sep 2024 16:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725579661; x=1726184461; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aliWrq2cb0vbBWecsfUMonOxJVnwaOBuwxLBop/4zeE=;
 b=YLP7BT7/b2S3fLviIJEqzNUBgkmHQknY48lTpyaEx51Djex7oEuWhegI8tsF4TW+SV
 IQAeh8W5QJbttQLINgnrEEaf8s5x2yLXu7R7lzJcbe03cNXDkybKVfsErUb1OGrqDUa+
 x6Q21pSdWAEPfge3WcVpovb+htaDl/I/geq1kXdjz7AKQ5tsJN5DrRdCO3FBOHWmIsuK
 8quRMimb2wcCv4+1inSaPM7cWBCEQ0PX5AAFNGQ9JjRK9X1yVKtLQZCvPY7+vbPBHEeE
 jFEYSW8wf/S4CSjcsJ6i1F85fZ8WgSHS5Uh2XqnDcDDnIah96S2K5Wb+96r7+2s6B8nM
 XDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725579661; x=1726184461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aliWrq2cb0vbBWecsfUMonOxJVnwaOBuwxLBop/4zeE=;
 b=Tl+KQJ36+Jan2zrBUDE2XBIJMF4AYHQVmdROd9tvzYv1MuuiRsTgrHSxrrOnLBGmFB
 Atu2YDrJIXhh76K4nh0JICey3uMMkRow1Cs7sW8IjeYDrWNDL0I6IwMtdocjPvU5456h
 xNQW18YqHUTOuhRtDyUEUOCyC/vzV1jnyqit2nGR2GwZSoPyTLTsI9S+iJIPP5T1I1la
 wFcOEDLgFWYdJbXu/XD95Q1K3rI6zmlHKgon9loUac/k3NCUv73X195LHBkE6URFgaDz
 52jwqAyxu7qfsBB3CzSaF+CGSTnQJMVWWc1HdcEviXSkfjB4ewkw9m2ducZ2LOAiWk2Y
 N7Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4iiTU0EagwMiJAhLihNz8ERrHcxauvA2eha1cPvIL53nKCSc3iHuKIY9Z0yGMVfui6AyTRwV0DrU=@nongnu.org,
 AJvYcCUESFF7qpnoOlG43OVwWeMsVvpTVLa+bydc3gdhOutQuJLs317usXx/tYfaHggSdNnB7+Jh4o7QMo7VjQ==@nongnu.org,
 AJvYcCV9trc2LHrrUQoE6so46Nya811kd7x4fwhCvoY/WGv9VWRTPm/1W+wSV2Bh3ooAAFx7LShTkt1ORw==@nongnu.org
X-Gm-Message-State: AOJu0Yyq5CFoci3lPjhiZSRp4qCfRrIy3bC1efyZ78OjTy8yn50Tdjsn
 cer5v+iAIuKunDVYR1UrRGEFgQ8bPIhqRhKt1ccFDuX9shQc3Bz2JRkhyvUeUiTXJneI58tQxU+
 kwXcHV5VRYpAg9GYZrfWb/H5xaxo=
X-Google-Smtp-Source: AGHT+IGCrpA+Emdr8Txp3EwCMBtlMEBRlJeaQIvnkxEfqJqsXEv1xj/sTPIRd42ughxi+Xpqo5AmkuxAgyqcG96AAkI=
X-Received: by 2002:a05:6102:2aca:b0:493:b9ae:3208 with SMTP id
 ada2fe7eead31-49a5af48ac5mr30295616137.24.1725579660625; Thu, 05 Sep 2024
 16:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240905073832.16222-1-shentey@gmail.com>
 <20240905073832.16222-2-shentey@gmail.com>
In-Reply-To: <20240905073832.16222-2-shentey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 09:40:34 +1000
Message-ID: <CAKmqyKNtNB3Nc3tqCR3mvcd+40Mwx8=mRjWAnjhpvyOYyC4Z8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw: Remove unused inclusion of hw/char/serial.h
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Stafford Horne <shorne@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Wu <wuhaotsh@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Sergio Lopez <slp@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Sep 5, 2024 at 5:40=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/riscv_htif.c | 1 -
>  hw/ppc/prep.c        | 1 -
>  hw/riscv/sifive_e.c  | 1 -
>  hw/riscv/sifive_u.c  | 1 -
>  4 files changed, 4 deletions(-)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 9bef60def1..54fd55c3e6 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -24,7 +24,6 @@
>  #include "qapi/error.h"
>  #include "qemu/log.h"
>  #include "hw/char/riscv_htif.h"
> -#include "hw/char/serial.h"
>  #include "chardev/char.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/timer.h"
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 4eb5477069..fb58c312ac 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -25,7 +25,6 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/rtc/m48t59.h"
> -#include "hw/char/serial.h"
>  #include "hw/block/fdc.h"
>  #include "net/net.h"
>  #include "hw/isa/isa.h"
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 87d9602383..5a1959f2a9 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -35,7 +35,6 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> -#include "hw/char/serial.h"
>  #include "hw/misc/unimp.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/riscv_hart.h"
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index af5f923f54..efc8443c84 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -43,7 +43,6 @@
>  #include "hw/irq.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> -#include "hw/char/serial.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/sd/sd.h"
> --
> 2.46.0
>
>

