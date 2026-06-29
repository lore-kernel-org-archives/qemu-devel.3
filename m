Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220CDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0CD-0000wR-HG; Sun, 28 Jun 2026 20:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0CA-0000w1-06
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:49:55 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0C8-00040Z-6j
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:49:53 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697ce8cfe65so4460255a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782694190; cv=none;
 d=google.com; s=arc-20260327;
 b=ognvokpMWWKmXLmPWjmEdsdSWqYB+1b1oC8lYgW9hPpQ0Ghi9bPrdPe07kz1vVgi6Y
 Ek6ykEavBRZgaXDsgdeY+nKpy+FrFXCj1yzfoBw/oFmkqSo1eCxbd9QvuUnh6y3LNe7q
 4/Ekg/UoMK284vG9XliUQyJTH8bGW6Ca2z4ip0hFF8oB1Gd3mDiuaXBL4ik4GJv2iRb2
 SOTULfXMLfgQS5IRHldxbq3k0viv+ZXFWZb7Vk3EokwmsQ4HeMDq85+Ly0lpIsCk/tps
 OURtehNZ1UCKRhJRlgUutLXpu9M66RWxTrL2n81i3TSVJP1vVo9qukBjXQ5MoKNwfSmh
 j4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7+Xd7dZ5ugKdPtOkhsNwyL7YPpzq/5LhT91DUyIqTA4=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=sGuwJ1dIV72W7WL5+YG8MyzVWjC9g0Cb2jODMXy9BAlkeMkqci6R6fyQhM/j0BoRQG
 LZok/Jh6iicoaSPsFA3iBdIkeQP9/p57i+vloa4UE0SEGayWvyChqEHqWBtxDbQFgVKl
 eC6h8G1DYfAAihFXHkHZAl38IxadhdfxgHgJJOEoYAnk6/KZW7fXGsU5v+B9R7pWn2n+
 1QLpq4yyvCtj5AqggSLaulVZjWscsudQs1QzlNGdAhiJ5b2DeGcnsoiUWgV3w8yX/r0F
 RpYbkqZXMK4ZuX7muNSUyJqscrXYBPELbpgppvEIIisqTwl4j1Xis8FOGOpv/pxy7Rfc
 Xaww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782694190; x=1783298990; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+Xd7dZ5ugKdPtOkhsNwyL7YPpzq/5LhT91DUyIqTA4=;
 b=KTPsiCB+g/fyxUTZMW8BxumRW0HZGgvwLP/bWGE4CJMEb7PX2wDJxD8kxVtsQ3rn71
 S951RyuyLJKMjlcyjwngMh5Xj5izHDFZeoyWcwP53FXVrx0YuNKMsm0gWX0K+ORrYSjQ
 nEPSMFwQccSQForB1IYu9hXC4kE6vmZfFCEKR3syzLkJQRCf54vSn+wZA8scd4tzhDzV
 wZBuPZNLoPGFavTpmNYMHR+j5KyQbg31Dm0QgV2w4wwNbAxYw4J5P9nBr5qQE306Ft9q
 Pp6wtaiqEqLKcUI0PpVQVMFYUkjNfCqtW2osV0OIBs85O8SXSAVyNGzHvmDq6NFnKhil
 VBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782694190; x=1783298990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7+Xd7dZ5ugKdPtOkhsNwyL7YPpzq/5LhT91DUyIqTA4=;
 b=MP8r5CZn+jI+qHAVgx5uJpWs7R6D2cH40++8KbA8iq6jfKrRnu1JtjQd4bpiwysXPn
 eB125tCfvzcUcrheMsgQhkhw59s4lc09djHx9mtSRl92ufbxcl71y6kNIqgWxBT5dLgG
 O8qA98gQ2fsphbvrFRQ9O/60ccsPuBTOhouJYz5Rual1J4BiEMBaTRVyGGzikhsQIbKE
 knihBs8DNbniloSnZaKygvCHaWXg63Mr6Q8WH8HMf3ENgByh26/JJuvWHb2xe5hlXkJ4
 bRToipbWyzlfvQhQEJwKzS/N4v+fmFWr/RbY7Ap7YLL6GGl5td+1c9oV8HupWAw3+2X5
 Hb6A==
X-Gm-Message-State: AOJu0YzhHi9uy6MzJN3H74A0WoE8qAM6fq0paYCu3GSM+qQq3AKyxdI/
 vwjSEJCRsrJ0IUMxaQazdsT8KovKkEh2jsE5b0KzzFuz+MRQiSx0fuvMTwG7wnep7HNn78Ctd8l
 XSEsPSLHJDvw5mWta80P1InujBlCUg5Q=
X-Gm-Gg: AfdE7cl5IVjPxXgasi7x2JKXL3SHesFuI/4eFgRMet0p8wKES24c6d5pb5lJhI0ajKp
 0v1hoScO1CEa1bkht4yWz8doNfmVqy7Z4iecck/K3mk9oHxxXy6k9CsF75+0Lu1KY3e0l3WDQEX
 ADwi5g1IiHuljNB+0pPGjk8Z0z4TsumwnfWk6hMD8HzXXSD0gWVeBaO0wvWikc/kceMcJwxf/Rc
 ttKHbSrQEE7Zv9LwW43LPBMhxldQAzVjjjd3uklAwsSSQTTJGSzTgXQVhEzZnBv22X4AVClsq4U
 GeAHoDBDT0/byEkBH7Zbalj8yiuAKOPmcVd64g==
X-Received: by 2002:a05:6402:401d:b0:698:3b7c:7e55 with SMTP id
 4fb4d7f45d1cf-6983b7c7fabmr3720531a12.33.1782694190156; Sun, 28 Jun 2026
 17:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260626220529.3800372-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260626220529.3800372-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:49:23 +1000
X-Gm-Features: AVVi8Ce5JbfS8IgjYkYBXYZRjk0AlO745IMGi3UQ0ob_K7GyPi1iDF4I-hGjSpg
Message-ID: <CAKmqyKMf9Q3zVw_E5xLK7BbDywQofCW8gETW3+OVK9So5JVOzw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending
 offset
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
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

On Sat, Jun 27, 2026 at 8:06=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We're doing a wrong shift when calculating the offset for the
> interrupt-pending bits, off by one right shift order.
>
> This went undercover for awhile because the calculation works for
> interrupt entities 1 to 63.  The math goes wrong when using interrupt
> entities 64 or greater.
>
> Instead of fixing the issue and running we're also adding some notes
> on where this calc comes from.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3561
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 3ea9130860..792729cfd5 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -686,7 +686,26 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUS=
tate *s,
>
>      /* MRIF pending bit address */
>      addr =3D get_field(pte[0], RISCV_IOMMU_MSI_PTE_MRIF_ADDR) << 9;
> -    addr =3D addr | ((data & 0x7c0) >> 3);
> +    /*
> +     * AIA spec section "Format of a memory-resident interrupt file":
> +     * address offset 0x000 contains interrupt-pending bits for
> +     * identities 1-63, offfset 0x010 for identities 64-127, and
> +     * so it goes up to 0x1F0 for identities 1984-2047.
> +     *
> +     * Hence each batch of identities advances offset by 16 (0x010)
> +     * for every interrupt-pending bits.  This means that doing
> +     * (data & 0x7c0) will filter out the first 6 bits, then
> +     * a >> 2 will turn the result in the 0x10 steps we need.
> +     *
> +     * E.g:
> +     *
> +     * - (1-63 & 0x7c0) =3D 0, 0 >> 2 =3D 0, offset 0x000
> +     * - (64-127 & 0x7c0) =3D 64, 64 >> 2 =3D 16, offset 0x010
> +     * - (128-191 & 0x7c0) =3D 128, 128 >> 2 =3D 32, offset 0x020
> +     *
> +     * and so on.
> +     */
> +    addr =3D addr | ((data & 0x7c0) >> 2);
>
>      trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
>                            PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
> --
> 2.43.0
>
>

