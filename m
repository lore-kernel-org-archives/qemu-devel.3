Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC1109E53D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aSn-0005MP-02; Wed, 25 Mar 2026 22:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aSg-0005LU-EC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:28:42 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aSe-0003tM-1S
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:28:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66a922a3a05so697203a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774492117; cv=none;
 d=google.com; s=arc-20240605;
 b=c4kbxVBn//vaeOw5FQhdhYPaHZD7e90qgnVOgOYkK15S5LuRg8ARWyJnKzzXlliHwl
 38JrRC+tnE+YO2SaW3QLc6nAZMvwV9n+1ooqjiUN/lejyjDG0Mg/GLY1Lg+TUkXl6kQv
 dSjrOKRbwS8G9TzKVpGRnvpNDnJIGBYs46OTJ6UH7H9J0hHuJu018ojKNQA5FyNX+cNb
 tI0dS0dEvWoST1Qq8IhDaj0/n3lkGXoYB49jmB4DZwyunr8IQaBYh1kI7KqtbIKDlCk2
 wEStJ2tOs+0Cb/k4NFeAbzC2Q+fF8y1tbFPwv84P+GkpNAvU3kQh9I/lWykgqKj4HVXg
 vykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zBkks+YbE/dGsEnJfl7QqTmNN/tijC+zkNp79whWMJ4=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=KPdYLLH5Tlnld2JQqW/Q9J2PZUX0mt4tV9d6ni1NFGApGVideArG4ZFt0N2MDmYyCE
 HUxpH3yHiDQD10uoDJrDloYnY+JPcFkubFwcP1aMfc190EUbV4qe33Y/OcjaRzGaAlEo
 3NdofDriWwWziLNUnqpQ4TIDreHOTzmiSisoOO2sqloSXlhZ6/ZlP5RPo/T3a5cB7T59
 c1uZN+dm1lp5tYu92eH2H4I0R9RajvdS7U5YdZ536RvjcTrYj1gTxVwuJAYzUjvFN8Hp
 yxuMcZ0mi6Kg6Fc6mEY3lcGnOuSPE8qOV+Um2pApK9NHuUFSUa/FW+tMYxCQMbuxaFDe
 V2fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774492117; x=1775096917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBkks+YbE/dGsEnJfl7QqTmNN/tijC+zkNp79whWMJ4=;
 b=addGSrXTcgWa7lXFqgOfoUGORP7nUW55Uyyl0LsLTAxFro9TXWyuus6FC1yXkd6QeN
 7MRPE3XbOHF27nWv1d03zvLFzePkUeBLyuYTKih7VIu9HASfXNbiR7WnSEWnaUMKpqHd
 1KqIf1v0DTgqXgt1+zHyDihl4VltHKS/ST+zwb3ppCXLujfuLTitaW2jZ9rHn3156JXK
 MgKB+hrMfiOU5o+D823EuPtTJ1lvMhgB0lcOp0vg/Vu7630Er5JsU00erNYzMdpkcJuZ
 TGBs4fjARms7uBqvZbdMtTl+AkF9CYZ5M4AO0tDJX9jMAINzFdlw5a+TA6SxhrIpBbAa
 GcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774492117; x=1775096917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zBkks+YbE/dGsEnJfl7QqTmNN/tijC+zkNp79whWMJ4=;
 b=aeicElgloEWYa7nX8jdiFi2Ov8ugz87+RocpHJd3yCkqolv4tMSzU959rQw9vguZ82
 /OIupBjw7/c9jqMwbWQDVrdPheDbCOkkhvQeY5074nEC5pVEY78NO/WKq3hhaRxudWDF
 /JxFiVPBCL/JKRjDJyoXTQIRDr9R9ZN3I6GfTdjQe+AYHeLe1Tn2fFQmdg7wZFJqonRK
 28MZQMUafo4JtHkMp9G/kKPREs64qJROEKBTUKDsJQtxE8+m0ZWvmbseI6KYMlPfXrf6
 FGEbtMHD/ywOymu76pIKWw31Yt38bsO+qXvXdXUAsoydSPvKKk1ZKWKzdCskf8rBW7ew
 ClyQ==
X-Gm-Message-State: AOJu0Yw3am5SJC5TiI3l86DINQBWMjcxarCZdpKZvdEbW0byAJBQnjqp
 xv3+RSiUdMZju3cPu2Qs5+j3sc/2nL0WzyJDjsbAIFC3/8GxZBEbFKyDAVok+11m8FTEcrMOPb+
 +fyaXgsQv48XtzCnXAa66tXdesW60L6E=
X-Gm-Gg: ATEYQzxA/J9Cn0lb+cE1w3EKXWjr8W8/TCcleqzBqmSyU5IRDQDHiSiF9MMWrKfHpgT
 1f/dhl89QN12nDaX54rRhCoqYsL0hjYbYdTyHlKSYyXWPkRD70pg1t/HVXYDLp9CpiTCCigfWOl
 MWfxIpvYL1H+0VFiNqcRZyY+4FxmxJ5I+53dbjcVvfLvHfx8TycscncYAxQnV+dLvJcYHzsCaLy
 Gc8SaqT1iuqR9in8ctrEVJaP6Ac8cNjDpp4zm+SHkFEOXwpVyBi0fd+zRTMnQUBUUGgb99VPp4j
 FL3tSXWqqBKq8mRK2BpL9zsYS/9HcinV0ermM5LLDQuMjNzp
X-Received: by 2002:a17:907:d303:b0:b97:7616:3362 with SMTP id
 a640c23a62f3a-b9a542719b8mr358561866b.44.1774492117290; Wed, 25 Mar 2026
 19:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:28:09 +1000
X-Gm-Features: AQROBzBqeSrnkg-dvUZZsDZAnVYn5Gyj1rh3nPBNEqi5i-hKQdsRSM6ADReBkA0
Message-ID: <CAKmqyKMs2km=xn3SH7-D1VqNDrJVhxgO9JxQ5c9rEGH7t7gpVw@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 00/16] target/riscv: Forbid to use legacy native
 endianness API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Mar 18, 2026 at 8:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Thanks to Fr=C3=A9d=C3=A9ric patch on 128-bit registers, we can now
> remove all legacy native endianness API uses of RISC-V.
>
> Djordje: You should (re)base your "Add RISC-V big-endian
> target support" [*] series on this (after addressing the
> review comments) before posting your v4.
>
> [*] https://lore.kernel.org/qemu-devel/20260311115910.564481-1-djordje.to=
dorovic@htecgroup.com/
>
> Djordje Todorovic (1):
>   target/riscv: Use MO_LE for instruction fetch
>
> Fr=C3=A9d=C3=A9ric P=C3=A9trot (2):
>   target/riscv: Make LQ and SQ use 128-bit ld/st
>   target/riscv: Remove MTTCG check for x-rv128 CPU model
>
> Philippe Mathieu-Daud=C3=A9 (13):
>   hw/riscv: Mark RISC-V specific peripherals as little-endian
>   target/riscv: Use explicit little-endian LD/ST API
>   target/riscv: Explode MO_TExx -> MO_TE | MO_xx (again)
>   target/riscv: Conceal MO_ALIGN|MO_TE within load_acquire /
>     store_release
>   target/riscv: Factor tiny ldn() helper in gdbstub
>   target/riscv: Simplify riscv_cpu_gdb_write_register()
>   target/riscv: Expose mo_endian_env()
>   target/riscv: Have gdbstub consider CPU endianness
>   target/riscv: Replace MO_TE by mo_endian (MIPS extension)
>   target/riscv: Replace MO_TE by mo_endian (Zilsd extension)
>   target/riscv: Replace MO_TE by mo_endian (Zalasr extension)
>   target/riscv: Replace MO_TE -> MO_LE
>   configs/targets: Forbid RISC-V to use legacy native endianness APIs

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  configs/targets/riscv32-linux-user.mak       |  1 +
>  configs/targets/riscv32-softmmu.mak          |  1 +
>  configs/targets/riscv64-bsd-user.mak         |  1 +
>  configs/targets/riscv64-linux-user.mak       |  1 +
>  configs/targets/riscv64-softmmu.mak          |  1 +
>  target/riscv/internals.h                     | 12 ++++++
>  hw/char/ibex_uart.c                          |  2 +-
>  hw/char/shakti_uart.c                        |  2 +-
>  hw/char/sifive_uart.c                        |  2 +-
>  hw/misc/sifive_e_aon.c                       |  2 +-
>  hw/misc/sifive_e_prci.c                      |  2 +-
>  hw/misc/sifive_u_otp.c                       |  2 +-
>  hw/misc/sifive_u_prci.c                      |  2 +-
>  hw/riscv/riscv-iommu.c                       |  2 +-
>  hw/sd/cadence_sdhci.c                        |  2 +-
>  hw/timer/ibex_timer.c                        |  2 +-
>  hw/timer/sifive_pwm.c                        |  2 +-
>  target/riscv/cpu_helper.c                    |  4 +-
>  target/riscv/gdbstub.c                       | 42 ++++++++------------
>  target/riscv/op_helper.c                     | 14 -------
>  target/riscv/tcg/tcg-cpu.c                   | 10 -----
>  target/riscv/translate.c                     | 10 ++---
>  target/riscv/insn_trans/trans_rvi.c.inc      | 32 +++++++++++----
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 18 +++++----
>  target/riscv/insn_trans/trans_xmips.c.inc    | 24 +++++++----
>  target/riscv/insn_trans/trans_zilsd.c.inc    |  4 +-
>  26 files changed, 104 insertions(+), 93 deletions(-)
>
> --
> 2.53.0
>
>

