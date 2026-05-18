Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB6DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmCE-0007jV-4z; Sun, 17 May 2026 20:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmCB-0007jD-8u
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:51:00 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmC9-0001i0-1C
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:50:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67e24b8ef55so3140917a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779065454; cv=none;
 d=google.com; s=arc-20240605;
 b=PUE9LQpvVn8RMkQ0VjA99AyCxdvo+OAFugSPptHNy31Ecd9nzV4jn1TzB+HIIYixob
 58LIe5sd0wU0hApW1doovHKVobZeNfU83xRGJPbLat6b3JESiqMYlgcQdrIODHLVNqlo
 tANeZdp3ZkuHjD0veAVPZs+3ZVN8cHK+Lfjd1CmF1XAx6QmZvvFtJjHVT95JVgUGcSCZ
 /VEQOBQY/h6VwsdKrBbqG35BmXT+KiRYRyLmAg73KX0neQFL0BiVJL/vu7oIOK8pyj9M
 0t1D+VnXLIEv4NC4iL/dampIZHrI7KP2n7JvZH8CC24hne8P7GreujCkMjP1qQbk7n6S
 yhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1QwjIw9dYy4zhBtgKhWHeAgjwsyQhOe116YsaThWpvA=;
 fh=mNvwrgRDW27qPzXFRvj5VM3jGJdRqaIN2QkMevA1WLw=;
 b=Fpx7xcsdgo95gl2XxaEXw78YDhFXlcN4JP3rM9ttZ1KasV8ZERxQHEHH136RSKA8XH
 fEFiu5UmsRjIOlcbQL59UqTdOpvyGQ+9PrCJHEYxxe1S9NR3o8gQiSYGIg8CYoIzVTuy
 333ZimIHOuUPukk1J9MPEnpA6KaA5c0j18+XteqnseKe29Vio5alhRFGVg+0+yvkavJy
 CGeGfQ13q+VcodALFUy6C1WWnp4g2XR1BJTYlcKd8cG8sktiD6QI3w2WDDDv9aXbtzWd
 +qI0rKVcJ9WWHtgM9cG4pTmSY1WU/pZmf8MaO1T6Sfip5A9jbWyAGuNZxkg63S9QnV0R
 jJFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779065454; x=1779670254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QwjIw9dYy4zhBtgKhWHeAgjwsyQhOe116YsaThWpvA=;
 b=I043vyqHsyRF4fRmTuS8YF4YsJsAr5l0WLrRGsZb+9HgTEq0DdfyTc3yBvqjxhyzGN
 YA6OkGr41gRg/pcu3wMXUZH8B9gYUasWTmc9/+++W6wmHp1dER4LQ7eBGdWI8S8FySNb
 67YbxYHSzRrLyDTjvQYpHCldV87ZhLyh2BotfLZXX/v4ZRbRXB0++5ZWTCl0x7etwmY6
 5sB3EPhETARNnNqXtBM2b4WQkVjj4fNPYzFLd8yU1jehfUurPqxnW9AMOatrC1DFCoA2
 YG7XTVULD+o6dwAOiHyzzgWXoBdrXpP8aqvNLL4jB1KH75j8h4sFYPv+mBX1AMwlMY5r
 z68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779065454; x=1779670254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QwjIw9dYy4zhBtgKhWHeAgjwsyQhOe116YsaThWpvA=;
 b=Tgl0kpF0ZuoluMBTlrFVS77et9BHs7LLIlmH0tht6ux+Qy9MyZUDgp2+msEckuEEqo
 35tZdfZMGQvVczaYOPA7UnY3X5uD3sp35GRwHOD4uT3hJvVTBoTYuOQqL5dz85DpwKVI
 wEVfsXtrCr4Q9B3EiOz8FtLSj6CiCGPIgMJCfwbwtLPVyM6HjDVhADUuSGRs3u9cO3Me
 eHdXATiJ2hzo/0+qctugCb4tOCy7F+CcDJivaQnbdPG/WRcGcmgOHshvvV4GRwvVw71X
 2Nf3g9FVyRUNmBHABxHWPUzJJBZnFAiu682Y+vybWlPrRuqxGssJKfb/KsY0Ow0R9SDO
 iukA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dDesH6fUMKy4VD1eTIK2SMYd1bEXPQiWSXD+f5N4Ht6W1dTSP+7I+DBCDSPS89YF7IJh7+DjODNs/@nongnu.org
X-Gm-Message-State: AOJu0Yz7MyqAQU7+6x4gGFDgjMGxavlKbK9mZ+D/anemphIU0E8pfWkX
 J4EMWEGdVCGGMwhr70rqXFjELuQSs/SnhUma4efutO7H226J0024zUDIcI4hv6yN0yF/CEI5gES
 iJ1yFPOK8srGYNqEFM+Zag1RK5aQf39c=
X-Gm-Gg: Acq92OGayg5mVkD7hbCetJj63BTGjiFKGh+Mt0be1mLyrTVT+wnYuARHpzjIrbpVm1a
 x91umRIinfmZbTQwvKpupNn0KS4yR5wJWa6hwu6JcZQbtZtVfUynnsdp+OBraojDy0lJNPHuId6
 ytpUbehgnAO2rPRingH4lTQyosNakR9pCGAJKQob2gXTPd4KOk/mMAGjDpIH5kwI9w3tfc2CULQ
 qWbZAi6RvClyq9Qpg4g579jqCBXDR9Yq3bYvph3E/T9oNZxvoI3RcshPpC1Gs1DtTS0FPVIgw7O
 z7fzvrhirZ9rCJigQKLHxObfzqJvDLETW/rRvw==
X-Received: by 2002:a17:907:8b98:b0:bd3:413d:c51a with SMTP id
 a640c23a62f3a-bd5178848demr665850166b.17.1779065453794; Sun, 17 May 2026
 17:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260513051841.1671987-1-alistair.francis@wdc.com>
In-Reply-To: <20260513051841.1671987-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:50:27 +1000
X-Gm-Features: AVHnY4Ijw6YN6Y71fvbFodsdRqkA06BUmHXSr0VbiOf3DrjWZUnNIsDJ2TMpAQs
Message-ID: <CAKmqyKO6BUwvKZHAQnY0j6XnzCMywK3jghw+JX-+LOdyBix97Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Update the local interrupt mask
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, May 13, 2026 at 3:18=E2=80=AFPM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The RISC-V spec describes bits 0-15 as standard fixed interrupts. The
> AIA spec on the other hand describes bits 0-12 as standard fixed
> interrupts. This conflict causes issues for us as we don't dynamically
> determine if AIA is enabled when setting the *delegable_ints consts.
>
> This means currently we incorrectly treat the LCOFIP bit as delegable,
> even if AIA is disabled, which is incorrect (see the issues mentioned
> below).
>
> The AIA spec indicates that implementations can determine which bits of
> 13-63 in mvien are writable, so let's just make it bits 15-63 to match
> the main spec.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3134
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3135
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3138
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3140
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e1cd4a299c..db886aeed1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1777,13 +1777,13 @@ static RISCVException write_stimecmph(CPURISCVSta=
te *env, int csrno,
>  #define VSTOPI_NUM_SRCS 5
>
>  /*
> - * All core local interrupts except the fixed ones 0:12. This macro is f=
or
> + * All core local interrupts except the fixed ones 0:15. This macro is f=
or
>   * virtual interrupts logic so please don't change this to avoid messing=
 up
>   * the whole support, For reference see AIA spec: `5.3 Interrupt filteri=
ng and
>   * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupt=
s for
>   * VS level`.
>   */
> -#define LOCAL_INTERRUPTS   (~0x1FFFULL)
> +#define LOCAL_INTERRUPTS   (~0xFFFFULL)
>
>  static const uint64_t delegable_ints =3D
>      S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
> --
> 2.53.0
>

