Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CEFC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 06:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR3kM-0006Rv-JR; Mon, 16 Jun 2025 02:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR3kJ-0006RS-6i
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:55:07 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR3kG-00078H-8t
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:55:06 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-607ea238c37so8863516a12.2
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750056902; x=1750661702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QOJw6+ZU8CCekCDyARaBfcq1IrCtnYZhTQ6MIvKT2yE=;
 b=neggQ3MbUc+96i9zKGQ01Mqr8RHG5PHoHCab0vMEKFSLmNdJ8FBPcXApqv4oad4CbL
 WxiHJ9vyITzwsmVq9aYm0taXt+i58DWVzb97R3PjCw5Hhr2bK+fjQwZaTo+NiocCL5yx
 +Ep/aoc8yleNvobUXNww10YlCTpaOgpBzUixz5CPZJKE65Gbx+38SFIwsG67/VS7I2xy
 TNwOsP2hLTbuZgwj22rP0yG2yBofTGmkIXsHsEtFGBYn01h0ysoxKsi9f3efnNa9aB2G
 vYtgtKYUlfw8TGEqaaR8ec9oB8AXbenuXqIp40Dx/3ep5yuLvZGpVmCjlMOAsEvJmg2C
 Te/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750056902; x=1750661702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOJw6+ZU8CCekCDyARaBfcq1IrCtnYZhTQ6MIvKT2yE=;
 b=IBNQgp6Pga46qO5T0oGhbLn8zqmvnT4Lj5zhZz0nQrG2ymm+Quveyx6r2+RL3VXWjp
 KvVbQj8cShhU1wR/WOafsayWfWNmE0w6TsvN78Y4jaXW2JL51UIxFqaxfW1RTD7tIiCl
 gBm+SO6BSorbo8Lb160WuOt47m+cZDXOxD+fPCI0/KOw18A/C6pcxdW2ee5KKK12DoLs
 XjHpiL9FXCdgMEVl1etZp1d9u82JhdSvV6J/97uw16WNoFdrotxV2ENt58ZYK5Cdc78r
 cn6EIcO5MTK0XjSvNvuB/oB3ATjkLbw5qYbNgVfILGzSCa2NdG9uOT3gFE4JBbK/eflc
 /nFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlc33pkxASvPuktDxWtaVzEbn1lR1P9k9g+UiHv+Jma2VXQzdRb+gxSpTNqwBrgy+F+/UqokgIzp4I@nongnu.org
X-Gm-Message-State: AOJu0YyuhiSE7d7g7ekfxKHQx51M3uxbmN8Pp0A3hYyKgSIkbLbDwHKt
 CzsS63sXAx48Gzuwxjt2a4PFYTivj+RZYEKZfY9MkxpewdT7lDUWGGM1g/BbDP2d9kA=
X-Gm-Gg: ASbGncsjta1m3O2qOHCm2gHhE2NSBMC1YGmiww+/ge0+AnaGx7WsdIW6u6pDD28mjbP
 NshHleLebqnHXnCgoAVOCsDYvcZ6kUE9w1LucYLGpqFlnX0YdcGATxZ6W/VeqFi/RS8RKv3eQZO
 PKnRZQZ8WRe178QvwuDf+5dUa8umEeiWNZDn6Anf1AZikSvy+4xICpEc757Z6oo/RuLFbLBkPde
 t3fmpbpyAzCqT9lxGqxjNX9tMTk9DkgRWdE8POKHe6cYBbMRzCQ08I7WDQycwGsjPjGeRvnBNam
 /c2IV/xPwmrnTUjUqU3zMLaSv6+yHLCo7bEjS5Mh3GKhUPO/54HfCykiz4RRiyhPMz0Dn8slptU
 2z3At9QaLq3Daar77t7nG2RBkq1G2ETrn3QDjqYxZ
X-Google-Smtp-Source: AGHT+IHGv951Sb9YGU6IzzG/dwIMPtJT2IQd0mIC1mAvuTYXOVeB20zwjdFC9nYn6Fld3qFAir/3/g==
X-Received: by 2002:a05:6402:34d3:b0:5f3:f04b:5663 with SMTP id
 4fb4d7f45d1cf-608d097a052mr6677922a12.24.1750056902369; 
 Sun, 15 Jun 2025 23:55:02 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b4a9298asm5593591a12.56.2025.06.15.23.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 23:55:01 -0700 (PDT)
Message-ID: <4f60c8d7-a706-4f7b-97ee-4a5c7c925240@linaro.org>
Date: Mon, 16 Jun 2025 08:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Yoshinori Sato email address has been updated
To: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp, Thomas Huth <thuth@redhat.com>
References: <20250612131632.137155-1-yoshinori.sato@nifty.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250612131632.137155-1-yoshinori.sato@nifty.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/6/25 15:16, Yoshinori Sato wrote:
> The email address <ysato@users.sourceforge.jp> has been suspended.
> I have prepared a new email address.

Thanks for the update! I wonder how we can check this is you and
not someone impersonating an obsolete email address... Anyway,
not a critical area, so patch LGTM ;)

> 
> Signed-off-by: Yoshinori Sato <yoshinori.sato@nifty.com>
> ---
>   MAINTAINERS | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa6763077e..f28b908e62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -351,7 +351,7 @@ F: target/riscv/insn_trans/trans_xventanacondops.c.inc
>   F: disas/riscv-xventana*
>   
>   RENESAS RX CPUs
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   S: Orphan
>   F: target/rx/
>   
> @@ -367,7 +367,7 @@ F: tests/tcg/s390x/
>   L: qemu-s390x@nongnu.org
>   
>   SH4 TCG CPUs
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   S: Orphan
>   F: target/sh4/
>   F: hw/sh4/
> @@ -1693,7 +1693,7 @@ F: docs/system/riscv/microblaze-v-generic.rst
>   RX Machines
>   -----------
>   rx-gdbsim
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   S: Orphan
>   F: docs/system/target-rx.rst
>   F: hw/rx/rx-gdbsim.c
> @@ -1702,7 +1702,7 @@ F: tests/functional/test_rx_gdbsim.py
>   SH4 Machines
>   ------------
>   R2D
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   R: Magnus Damm <magnus.damm@gmail.com>
>   S: Odd Fixes
>   F: hw/char/sh_serial.c
> @@ -2753,7 +2753,7 @@ F: tests/qtest/*xive*
>   F: docs/*/*xive*
>   
>   Renesas peripherals
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   R: Magnus Damm <magnus.damm@gmail.com>
>   S: Odd Fixes
>   F: hw/char/renesas_sci.c
> @@ -2765,7 +2765,7 @@ F: include/hw/sh4/sh.h
>   F: include/hw/timer/renesas_*.h
>   
>   Renesas RX peripherals
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   S: Orphan
>   F: hw/intc/rx_icu.c
>   F: hw/rx/


