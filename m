Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD2109E53D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aL0-0002qa-07; Wed, 25 Mar 2026 22:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aKv-0002qF-Ax
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:20:41 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aKt-00015f-Pf
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:20:41 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-668e55bd36bso522256a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491638; cv=none;
 d=google.com; s=arc-20240605;
 b=WadUg4T3BUQCugjjOMSBvXZ5R1IAKAC9wlTMkSLWIdjAlchslZlGekC0Nu10PCM5Ax
 MF4IdmUOJxQocqEIuwDtqAyNMFVtLNBCjW8UVuCprPlHI+Obvcuv6r8EzsgHMgT35WcC
 j29ftjzUIbeTmVB81ueYjRmd1a6NSj5ZZiYoM/rEDURKPyd7dU8/WQm0cjHvxKfJwGhW
 a32M9KXBpavTCSFK9snbnIk64r5BDSzr0Qlp5PXKnw6MLFD6Y6eF8u5xhdqpSuHDzIgm
 SqvypHrwEI6Po478vJxDT5ra+K9szWiA0kFfCVBVQ9uaCTW9nQzZoWB5H74CzUS+WvfI
 l37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RLdObwDIQPh0SGwSIgXboIIxH75VFBhHEGME3xV5NQU=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=Z30viwpHFvB5X1Yk6CnhTQgTTjWtShNPWHMWWKsptGJ18uMVtMld6dTtCdRQL4M+fB
 RoaKokcQ1tzjL/iY1E1G1JlvRDRO3M0J4IYab8pacfaWOUcdLNJCX9pJgHJKOTBXc1jr
 zSU3m6w8rrQakOMjanGhKDBgQ1jxQjgoWi17f8pdI8uPGiC1p04YhK2N4tdwUZ0UVl0s
 kVJmQbKZeDqzH/XDduGqp6+3zBEd+3Unc/Ny6odDrDHUHqLfdyDWgyeXWS4agdIzLCI8
 AwK95gd8Tj4F9kbccqjcNCJ4cadweVO1SP6wW+kh/2bETCFWmaOIpvRSIqhlUAJh9Rrb
 4IEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491638; x=1775096438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLdObwDIQPh0SGwSIgXboIIxH75VFBhHEGME3xV5NQU=;
 b=jbUqe+utUnhYlPT+SHrySDyd3s959M1kXUETAIpJ6jwUu94bLSrhKY/HaGqoaK1UcJ
 FcO9CyPlABmICWk2MTaoRXn0d0aJfbeETtetlo6A2HoT01bOJsALzQCNhpGTdIZBd6k1
 mRayil8ISLVwLFiApwH5IbbuA4kL5eHUoxyUmz/avetfV9JLZq4KIlgz8bIbr+z/s4NG
 Y7DlXlHVLR+8CGZl80J/f2s4x37h2SQKVohUzTPauf7Fs2sW+AomUAlxS2BEv/X5PUPM
 seeEPXNNNJ51u0vgRyzpmikbSkhoFoaW3Qtd6ZWwLLYO/e50S+83jTP+BLEEnKY55aBa
 AG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491638; x=1775096438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RLdObwDIQPh0SGwSIgXboIIxH75VFBhHEGME3xV5NQU=;
 b=V0u8hHMuuIiMVDziwHro/FB71PArMVOX136KTyn2pLhTEX45FiajFsfo1tVMX3gH5L
 rHt6n+20n0pQd9/TcHGz69xBPey9VX7Y1+xhVd5v7kVbkGghl0CZW3E8LXv1HK2iUzCH
 AL5R9986mvx9FiuIo+tWK8jWBI4o1VjNl1k2t0x5PknPhv0nrj8nAPBLC+HJlTYu0iai
 0x/+7yFCI8qRXz+S1eGt2yVfwowBFlDFdRUqddW+wTVE/9gJ2Gn04iqNgri0H13d9AN+
 O+ozv6sPaLRlJQo12qUXo4YjvF1PtCf1JTIWKvbx9N9C0sgFivLPC5QeXexWHXxaFg7W
 zudA==
X-Gm-Message-State: AOJu0Yx/A2p7cbRhudGlB5ySnFiJ0cbzvnDlbJQSywlONLFLD38lLUoi
 9+jgR2g0X1DUp9ve14pBmTXTZ8mYBL+vDrmtyFLe9n0oCOp3KxyAT+3cFDOaQTlGjRppvsCVmBA
 40CJF2NTHJsYbn8ZhPxHsGWQVhFQIDNw=
X-Gm-Gg: ATEYQzyf7eRNJAhAjEFWZTUnf1E5NEbbhXj0HUQfy9woaLPPQZOsk5BG9sF3tvZdDvi
 l6z1mJCQQc7M3UQavx1DI9RXNHqnxVLirI/CdoXkZVp+4Ys1WbT5G2mjA4YZtEM+6I7RV/g79CJ
 KtgUxtF1qkwhHPP0ZJOPh6016aPm9wymP2JN3g9rPODtONdEYYOVm2Oy4OWRBD4xZOkF2KDawtX
 GE7dsclpO29z1dr9TjmRC4nPvCxfz1GXyoqTQOT2rf/7o/VAinZwmtyqVM0DUcNwwV0rGplVpMU
 7gUdap1/Xx17L/X6rqK+JMn0JBqkF4QlqMFmrgP7gIrmY9hk
X-Received: by 2002:a17:907:a68a:b0:b8f:e46f:8079 with SMTP id
 a640c23a62f3a-b9a3f1a7ed5mr384701266b.22.1774491638285; Wed, 25 Mar 2026
 19:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-14-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-14-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:20:12 +1000
X-Gm-Features: AQROBzBd6giFhlywblyCzTtVOnWZVz_sc3ijV9EzbUQNX0GN8pvZ6O_fE5-E9RQ
Message-ID: <CAKmqyKMujwYtw_NiDdbox4Dba6HyhDBFWSWrMRrX2S+rRRxinQ@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 13/16] target/riscv: Replace MO_TE by mo_endian
 (Zalasr extension)
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
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, Mar 18, 2026 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Replace compile-time MO_TE evaluation by runtime mo_endian()
> one, which expand target endianness from DisasContext.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
insn_trans/trans_rvzalasr.c.inc
> index 2b1f73f650b..0f307affecf 100644
> --- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_=
aqrl *a, MemOp memop)
>          return false;
>      }
>
> -    memop |=3D MO_ALIGN | MO_TE;
> +    memop |=3D MO_ALIGN | mo_endian(ctx);
>      memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>
>      tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
> @@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb=
_aqrl *a, MemOp memop)
>          return false;
>      }
>
> -    memop |=3D MO_ALIGN | MO_TE;
> +    memop |=3D MO_ALIGN | mo_endian(ctx);
>      memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>
>      /* Add a memory barrier implied by RL (mandatory) and AQ (optional) =
*/
> --
> 2.53.0
>
>

