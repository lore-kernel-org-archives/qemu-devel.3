Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C01CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 03:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYxt9-0003x9-5A; Sun, 14 Jun 2026 23:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYxt7-0003wk-Cv
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 23:21:25 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYxt5-0002Ns-VE
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 23:21:25 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68cec9f4c6cso3671919a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 20:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781493681; cv=none;
 d=google.com; s=arc-20240605;
 b=QZw0SRdT+DU9YVI1aY+S/NhsIgBpFSs+vk0A7iZAiNbyz7Bp7h9ZEo84GKy+BVTajs
 c2CKICfzktjEkr8Py/Mg0MHpU7qKJFxFdL8DNpZeWsdRZ85xQTf6fTs68EmDyh7GFpEQ
 tIwpGylenG6Gximg0j5VuIxbtyd4GGeIk/UdSFtge72DySrf60xxS9/uxMIYTEj8jo2y
 9rTCRpI71EnB2lKp3Jf2pGeEuilNQwK6jcAQrgDfGSmZwxp64wSouh1yX54+LRXPmjJR
 LRUgKiBTjlHjioCvUsYHLdoDRlK/WsOYYoI+NLtIcnBiTvILL1f5iaGWeTOQkxniTlHt
 M3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6+zjqdkCNMmJ84r7dOg5uxcLfVrYTRBYhD/tLDl2Dyk=;
 fh=oslkxwDRatS+3eorDa6EjpN5Z4+YmbvWdWsjgtNXJA0=;
 b=Vg1SUCU4qlY+vQrI271SxeHIVbBiOSAIfskFIthgBdh4PaquyFPJAg63epT2/JD9Xo
 b2UfsXsfxT87ZB4RAMN6b77xaIVdBeHXZeAIMrB9lf4pYv7SzNZebA6Lg1rVQJ8+ctdq
 y7YoYAhlamFdZujvBsBhLTm6DQcpx4sYX92iqPAdLTEm5/Iy/EVfCyBLSlPSR24q5eQI
 g0M75yxJZ9E3Uu50KiJ5rLj7MACQWPK4qwA+V6OCBDeQrcYcGy4MbtAxk9LX8jGE3Fj1
 uk9WKJL8vnsYaJPxGW0rV4m1PafDZQXFvhAHDE5p6x81yl8x/b92rtS6cEF6JYF0gHRT
 vfeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781493681; x=1782098481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+zjqdkCNMmJ84r7dOg5uxcLfVrYTRBYhD/tLDl2Dyk=;
 b=Mz3fJHYdcGNyqP7OtziinSX6YtM/U6ZKqqHmWQuWTw/P6WjEhrgFIuzfkBo5Vv0twm
 46tA3RkObogf7JuZw8Ly+5zrUgPIGaIbNnVN08IuM3Ry3WgslxiMl/Q4OrJlDMEzyHnK
 bsCkUUExMDmPD91fyXVFd4UAghnBBO1aw8ct+ydF7H0d7vaFbABRrz6ykfuZX0COU7Ld
 gYnk6qLzpRF5MLjmL35pCty4pu0qrvWMR81PJYhEQ75/Xa659SXX5KqLQLsKyVzYdf6W
 O4C6KpGwIU3C7dVpn/YtNeicfj7qCWjfl5vd1ELMbOMuuRiAkNsdo1zGwNQBIvA+TRXV
 sdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781493681; x=1782098481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6+zjqdkCNMmJ84r7dOg5uxcLfVrYTRBYhD/tLDl2Dyk=;
 b=P5HRAYfIVENoBnKSwey/bkPXBDVo/WlLCtp/dmslnHoaYhq9bhxNKLevTrQtUXrUBO
 IW59TNqeh+zZAw6iMqm5sxLb7ifmZfzQ0S2qV7d9vyJluCY3LYUG2d6pyd5fRikrzXQP
 6V77y9JOuyBespkjNN/4oJOzBXHWgASDRRxiDqhpGZ0KbZ4iJL1zSm4SSCvNc2uyBl3z
 +af386fy1ImxpRgZ2N9YyOdgdIR2t+OhmoLzvWdLc9iMSVIw0vGFKo/UwmEQlOyiWgWZ
 A++l9npFfaVtcVtDTHoO8l8YaMrCONQx1fCfLVs5EFtfc7fszL9/URjjgPUop6z1C/J/
 0CaQ==
X-Gm-Message-State: AOJu0Yw2SVqgFiGu78b7QYjG6fgOgVNb0zJlrwbfb1+ufDVbWdcL4Zfx
 ykrnWY5zVXnUsnBNO/MbOc8I2pmRmBnlh3YnWHiXfslqE3YzOzYQM9OlcQ4luggof0ImbkHYO3M
 +9M74nlGeOQy4+59Yp7Q9wFP4EOYmZ8M=
X-Gm-Gg: Acq92OGkacDJK/N4ysqQ8+2sOIFLHpVQiPpBcD39rsfuadwrpZvz3z76qarz2FsDReD
 tQJmHu/E456VibGNw2KfaozndQG+JCDnqeSkvY1hq4Bf3M8/qLvLxO2TVERS0le+h5P/M3PWYmr
 Okh9+OHpJyvmYZFK6j/TIrJGnTzvnYZWMmBryEVhBLCkkN03mKlH0WwauvXWy7zd89nOpiX2syj
 rV1diDAsMoMhi85NK1o24hJZW9f1r4vHVXyF2p66bnin2nIt5SZtutaRvgpUhiknLPFDCwJ8jDI
 xvw0fdCOoOp3TiIQ5RV7sshIxhyvkHeqXE+xcA==
X-Received: by 2002:a05:6402:524d:b0:692:4759:ac53 with SMTP id
 4fb4d7f45d1cf-693c69ffab8mr3829691a12.3.1781493681364; Sun, 14 Jun 2026
 20:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260606145520.34152-1-imaginos32@gmail.com>
 <20260614141315.17320-1-imaginos32@gmail.com>
In-Reply-To: <20260614141315.17320-1-imaginos32@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 13:20:54 +1000
X-Gm-Features: AVVi8Ce0s0CT7WKAJArdFH8HZ5NyQ4SUZQ6On179ddMgKq8R30d1sDYnlBWQ6_w
Message-ID: <CAKmqyKMwTzbnZsgDzsWwrLkAbDqLkwK+Ud+wMnbCqLc0mC_ctA@mail.gmail.com>
Subject: Re: [PATCH v2] disas/riscv: enable `mnret` disassembly
To: imaginos <imaginos32@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jun 15, 2026 at 12:15=E2=80=AFAM imaginos <imaginos32@gmail.com> wr=
ote:
>
> The translator has supported mnret since commit 3157a553ec6b9a
> ("target/riscv: Add Smrnmi mnret instruction"), but the
> disassembler still renders it as illegal. Add it unguarded,
> since the encoding does not overlap any other extension.
>
> Signed-off-by: imaginos <imaginos32@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2: rebase on riscv-to-apply.next
>
>  disas/riscv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index b8ec546883..7f1b262773 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -989,6 +989,7 @@ typedef enum {
>      rv_op_cbo_clean =3D 957,
>      rv_op_cbo_flush =3D 958,
>      rv_op_cbo_zero =3D 959,
> +    rv_op_mnret =3D 960,
>  } rv_op;
>
>  /* register names */
> @@ -2263,6 +2264,7 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>     { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
>     { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
>     { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -4077,6 +4079,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>                      case 64: op =3D rv_op_mret; break;
>                      }
>                      break;
> +                case 1792:
> +                    switch ((inst >> 15) & 0b1111111111) {
> +                    case 64: op =3D rv_op_mnret; break;
> +                    }
> +                    break;
>                  case 1952:
>                      switch ((inst >> 15) & 0b1111111111) {
>                      case 576: op =3D rv_op_dret; break;
> --
> 2.43.0
>
>

