Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9DBC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgZhR-00079L-2A; Sun, 05 Jul 2026 23:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZhP-000795-EH
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 23:08:47 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZhN-0005Es-PL
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 23:08:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6989c0ec3c5so4926614a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 20:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783307324; cv=none;
 d=google.com; s=arc-20260327;
 b=npazLHDKNERuyKy7/NLYBBLQ6Cuu97p4iB8jxXpVbNo3zAmTxC6mDbZc8D1rGOuoAb
 RCz7AmholBnzXiw6iuMs7UPpONZVVLJzp0LfLxtB8yp8R4FvPTm+FgJnPEHBnxq1Vz2z
 a/LVakN6LzfE/8ObXlJvqHMi17Yn50g7J2F07ORvg4Y3hE56XFLfd+edcShdrIWjStZA
 5Da1beli8PST9RBkMEns7doQagQDLBIVpFGr9Ytz3uTUAHRlfPHfyAzxBOSND5kYUAjX
 yDGbtoyMRLMzQ/93V22Z77zoO0OstUvuC+8DRmneuR8KDOx+/TbR8BZ1iHqp5kVZ8Q68
 nTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+fEU8KCl5H6eCgChunSpz0tlr6WLAYy/RfoYgPqJ93U=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=ErjijVppEavJbGm+flz44PSx3C89CdWSXwDVbT10e8fzRk/n715aERe2gpH0rDuHpM
 QY66Vqia79cBNVsl0gmAmgAzaVcSerbjERx0G0zYfKqqdwAva4LrO4+BCTc3jolEJveD
 ojBB4mTVlOvVJL3WsItNCelewSuvYyYN1OumigtLh7X9vM26l7FbJTaKxizZsnUD9yiV
 MXhANkQGKxn4fN6SW5U26vTQIH3DnxzLkD9RyOUs38CLBMszTZbW6GSLqT1E14z87tbS
 GSqCWp4KrF79UqRREuryn0nmvI8gj448NfnX1nWTWVKfrbDy1963ptQNVB+U5kDg3vrY
 ZofQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783307324; x=1783912124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+fEU8KCl5H6eCgChunSpz0tlr6WLAYy/RfoYgPqJ93U=;
 b=B/9cJx4ltGuI50ppsSMqAq4rwoIszSxwaWDMV6ta5jlJwbDHnrJWVei3UV1/ByqQzl
 L2FpkzUp1Sv6x32HCXagQipCGxEBURtEQQmKmaHbO/e423ZMVJvljXFHvZEs3XsreVyk
 Uf7gnI9B95JXr0Q2dnSxy+MYAGyU7P5C7BYuPb2K+JIO92TOKtTFHYZMl6B1ssyMbnss
 l3TOWoeuA3wOwnW3Sm6oui87reD/d2Ry4IoC47COTZf6ep/h6O+xx+R0Cw6zB/UK0N0h
 GSjDvb+R+odnSNpOSR0pnXkdi+pTNXmwt/gsdP2Li4mc35YWBe8VxPSK9e1NlCxd6tz8
 ++NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783307324; x=1783912124;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+fEU8KCl5H6eCgChunSpz0tlr6WLAYy/RfoYgPqJ93U=;
 b=cyjWXzXLBAk4H3g18+iGyEe6vp62IBg8OdzjAHqAB8G0q0vRtrdVzIyxqdZ1ngAkpj
 tcO4RosvRH3m8SSt05qefXz0iM+RlvrCnbfX3ddgTpheSIfc/WFRleNidU6BOzk4lSEF
 2Fk9t5bmJRuqofc3YLCSlQ43umP1HG0BXoePo9g33UDisSaCo9Kj8ysskY4Y3eE4vWl1
 KiaNqKFGrAAoo3UQQtcUV47rDZ3tvfh7irO0AsbtYYNwfQP5z6L/yeIGF+VqAORve33q
 8XNurgZbKSp0crhP58Dxv2FPwk0mC7TGVKK0r1voo3e5XS34/Cut20zDUrqjZaQ5vZ4C
 ChFA==
X-Gm-Message-State: AOJu0Yxjj1+ehb/ZKKSCrU1BuIyJ4ImkI0xFO7cNzAT9wWmuXNeKqYFi
 OWrhNU0QQr5uOahgUsN398MyAGTjtxOEwQ7iEBlzZAmhPFGy4EeUnu2KKsN4NoLVGb6f+dRxwr5
 zKc5m7DkvWotvxMfgFR11YSNGvwL/2aE=
X-Gm-Gg: AfdE7cm4V3yvivyjcI/4c/0B09ANYo+DylS5oJLm6JDYTx8kN1lxVuUYAbwMBIiIHMn
 QfTv9FmdERBUUW8Pns+TSeURmsatylqG/y6S35wKC929vrMsSlIKMB+MJxgXUgSrRldpG5vuZ5i
 LclKv+jyAB6ASvQInDU750oCCgDZxZy+PNowNPhcDdMLle6SW5leu46b79ncptuEglZJCe2Of9c
 3HWpfgd8lIU8ID7Y1F6M5HZd9IEu6EeMB7Jbfy3MVHn94m07mhZSsSAInkiR3IV0y5heG/LZPY7
 E2oZbVBbZTlSVoKR0fJKclqW1kQ=
X-Received: by 2002:a17:907:199a:b0:c12:6b39:2211 with SMTP id
 a640c23a62f3a-c12e6bacc2amr292762066b.43.1783307323952; Sun, 05 Jul 2026
 20:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260630172110.1866951-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260630172110.1866951-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 13:08:17 +1000
X-Gm-Features: AVVi8Ccdi79T6SUC83q1XLITGdUO1uVOoYJimnQlmR7mht-O6CxrqPbB0WU5uU4
Message-ID: <CAKmqyKNRq+jhcXN8yn5U+iWXeio6Qh612dZSDJAWZHjtafMxpw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD
 is zero
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Jul 1, 2026 at 3:22=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> When capabilities.AMO_HWADD isn't set, DC.tc.GADE and DC.tc.SADE are
> reserved bits and setting them throws a DDT_MISCONFIGURED error.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3549
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 1 +
>  hw/riscv/riscv-iommu.c      | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index a938fd3eb4..2e8bc19dca 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -86,6 +86,7 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>  #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>  #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
> +#define RISCV_IOMMU_CAP_AMO_HWAD        BIT_ULL(24)
>  #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
>  #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..891a56e731 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -416,6 +416,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>          const bool ade =3D
>              ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC=
_SADE);
>
> +        if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
> +            /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +        }
> +
>          /* Address range check before first level lookup */
>          if (!sc[pass].step) {
>              const uint64_t va_len =3D va_skip + va_bits;
> --
> 2.43.0
>
>

