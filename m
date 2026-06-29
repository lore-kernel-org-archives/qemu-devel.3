Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90965C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdzQy-0001he-CH; Sun, 28 Jun 2026 20:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzQw-0001gt-H8
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:01:06 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzQu-0008WA-2c
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:01:06 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69857dc1d5eso1363217a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782691262; cv=none;
 d=google.com; s=arc-20260327;
 b=i8fC3RIZpYwlxIsNpVnZU8oh3xSIl0JEWgHOLJcqE275ffgd7UmkY8adpqjmhirgNY
 sl0i3jj/jgGIeEEL4aGOU3cKikw+l1YEeDe92RUVm+FDcorKNXXImJazmbGZEVrkSbFQ
 ah2t/03HrjSqEP6oSq1aW7gIdigqk+VdMfmVtbuyAmWFEvp9Cggza2j4aSs+JYYSHjSX
 aRZ2H2saWMjb1c6x5ijVWzR0SnZk8cQ80ycOkB67JHZOdB+wmfT466MMnKEZkYDc9jlz
 GVGYQ9Fybohs1guGxjn4Ap2WX//eyaSPKhMjAB8l8az3LX699Vu8P9n6+LFQyneUjTOe
 cT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2aarkSTCtP1tNWtsc+x4BsJLyqTOaYD/qR94YreBArI=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=DM4ywPw5w8Y1bcvDYXaON4E12F9jbdUKV4n9linYxXYQg63hf4ySp+F/zwWc9CXesb
 N95ZC9FsEng70hOkpNsTTMSeyabpLNpQHQiCK4QpizqaUR5BBj7xM7UeSLlrlhF/E+Rr
 /HzAeDBms5cQ69KfEBPjsxXeWtbaXXuv8OcTp5xWS7KQU0A8x8f8qkMgtixWoUE1pQI+
 HIYBGA3nzzb1GGXWy9gwsTkZE+twBKk+ZelPT4ifo5wWdD62oi3/oYLiq1cRYH1wR4Qu
 fskO1mjkLseFHbCwRPOzyldObww+R+G03FwDI8JSpz7XFj6L7riWDEs9KblESOWrPwVq
 k7dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782691262; x=1783296062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aarkSTCtP1tNWtsc+x4BsJLyqTOaYD/qR94YreBArI=;
 b=T85dfvJ8yC10Fh6dCKfjU4iCIrsuQ3+JdhmIqBNBk8QmzVfiEDOdLrtZraCNOmlIdA
 4q9S23bLcZFsHqcvQv5e77TC6H0Q9V+ii1OjAx7tcN7NKZ0sdR65OOTmX18lHOul0+mf
 XY4358RHlaE4q8fb/NJ4Zz95fNwWzwZM7Q9YKj9/Lo5bFEn8lhES+ebheBOSvVb5qvru
 pBBcqUaqX/ql4WQQPFoBVtU7zi/Cw+KaB4hBsgKIrf6iCHNZ+DL1PjMsxnqfcSA++qkN
 VjDK9u3W5bvq/1sN2KCqI1/l9wz4bG75iaWs4UEWP8St8wikYwNOjKScH0Da75Kn6mEI
 ptzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782691262; x=1783296062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2aarkSTCtP1tNWtsc+x4BsJLyqTOaYD/qR94YreBArI=;
 b=Ky5nFBksWZJWpTeoWrN8FZth0Lnr+A3nQHp+ZCzTX7pfPJYQ+HxmJj0V4TZQQOPlZR
 EyahUr2/1G4FvJ4MQkaabnMjJCDu+djOERHW8A15SGnBcuXYfOtBLAYONOz1rc2z0z7m
 RtW4GR2hXKtsMhIOH29p8G7XhD2zFlQlzewKGLK5CwzksXrwQL3WRn/IhlAEPdzzjWoA
 p7NPE5YEyJ5CvEHJM5hqDkHnM8Eu8AfIHF/PWRLuyEJyGRjHOp8FoJkG04yGUT1wg9zQ
 2ikHXxTgPAcdPlH/oMLpzQ+bTfb8yNsf3pBuaRu7EiVjFA8EH0RKnywI1CNxfMcXmjAI
 tANw==
X-Gm-Message-State: AOJu0YwiAAON8TvbEca9nCU30ZwfqJUzSiAZXsmV9QizWQ7Lpmsmtxew
 GeVDU/0pQwng4M/MKIb0L34p+STUcutf9ruxCpHahNN0jfkoeLSuix+7DbgugpFOwPqbIFaYN8M
 yf7qB7aS0xeIItgjcz3TPHjegy++R04A=
X-Gm-Gg: AfdE7cmemaxmcPQRD+kmj3IPkS4cgi8TPrINmtyYgz/mdZ+x2HyDo0sIzVsEJydosDs
 w7xAo0HxWk2R1RA2iOXhA4DJqyPWK+2tFir3MXxalhrW0EuDAnmYRwVhhCQie4CfC2+7zTkT0hX
 AbwwAxrl3cSBmOuRgcoVn0qvxgX4ulQK133T4VIocTjppgNr6EvJTMpNMX/pT1tNpNjpljawCTp
 wT3AkojnHJ8wS8jtw14+61fz6/UZCjOJP0TCizXV5c+PEEoFeBWPRj3JS4Xl9hodUtb0/xJgo/6
 TX3iXvDu97dXuEP6qkjL4meO9KzNuMbdtTUBSA==
X-Received: by 2002:a05:6402:3585:b0:695:9b77:7c3a with SMTP id
 4fb4d7f45d1cf-69810ae8134mr4907717a12.24.1782691261869; Sun, 28 Jun 2026
 17:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260627194640.4130073-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260627194640.4130073-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:00:34 +1000
X-Gm-Features: AVVi8CeJ8Xxlmepx-apf0OTHzeJ9GpVbonRgxYAI_VBmVHwalzaYy376RFL-gec
Message-ID: <CAKmqyKMT5ig-g0cny038UnYSAHfw4fP83YygEb-w-ekp_omnXg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: check DC.TC reserved bits
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Sun, Jun 28, 2026 at 5:48=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We are not checking for reserved TC bits being set during device context
> validation.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3548
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 3 +++
>  hw/riscv/riscv-iommu.c      | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index a938fd3eb4..f9b6f35170 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -308,6 +308,9 @@ struct riscv_iommu_dc {
>  #define RISCV_IOMMU_DC_IOHGATP_GSCID    GENMASK_ULL(59, 44)
>  #define RISCV_IOMMU_DC_IOHGATP_MODE     RISCV_IOMMU_ATP_MODE_FIELD
>
> +#define RISCV_IOMMU_DC_TC_RESERVED      (GENMASK_ULL(23, 12) \
> +                                         | GENMASK_ULL(63, 32))
> +
>  enum riscv_iommu_dc_iohgatp_modes {
>      RISCV_IOMMU_DC_IOHGATP_MODE_BARE =3D 0,
>      RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 =3D 8,
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..c2c470b5df 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -752,6 +752,10 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOM=
MUState *s,
>      uint32_t fsc_mode, msi_mode;
>      uint64_t gatp;
>
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_RESERVED) {
> +        return false;
> +    }
> +
>      if (!(s->cap & RISCV_IOMMU_CAP_ATS) &&
>          (ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS ||
>           ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI ||
> --
> 2.43.0
>
>

