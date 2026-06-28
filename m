Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B52C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 23:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdyxH-0006ww-8k; Sun, 28 Jun 2026 19:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdyxG-0006vt-BS
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 19:30:26 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdyxE-0001N2-Op
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 19:30:26 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6978f1eeb87so4812287a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 16:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782689422; cv=none;
 d=google.com; s=arc-20260327;
 b=ivF/HSqEAEkq6tY8Ysu+EbFiAkt6sZrv9a4J8iMh4QjPqg7yzxj4xh9vahDFpc2lRb
 CTiL0FM7D0dINS1dsEk9bx0CfAFRcuyGG3KGboIoRO5B+WOTAn1WCSt2MpwF/2SP/Nku
 Jg5U4MNJycw3NpJFLZo6Am5mTTBoRzve1txiCmOBeg7YLkCcHBgSPjSfug+ZMWqU92rW
 NVJ3C5fi62Q4yi4koGbU1jNEwiOXIIxU3ccWAzmWG9PjuZBdlV+gDr6Iti548LBVPDPq
 +dBBUdYdAYbCD6ZqQXL20oJD++6HBwbvUQUXHkRQwc5aV/Xqnsc/bMuiySNjQgmgSALq
 tmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bAwUwdm66U+P5EfWF9HLID7LGqV52wZrK+nliMLVhsY=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=FhZSOfwYh6oZvlE+Zq5qhd97DhKyH+v0ItF5Dx4y9hoDOczzN05M2mSiT1TevyUvDs
 5dp2HCIPCtWN8YYqjNDsVot7vgeRDuZEfydKJHfszcIt9cqlM5ehSOUmLqpigGtPdXpm
 IK7wwQ4tsnxqxLyZWxZ1MurKzrTZExk7NSYICoU4dfhtieRsFXDagbxZVOiq0WIW7HcJ
 8JR0JPS1BO4g087m5w2SlUu+Dc6DAqFowwvtczeiaWrtsFoJUmWQ3E0XgaERBfLK054r
 VcCZG1ndcWTzFHiw5lEN2UzyOqJSd4JwOuaV/QYqViHL1wwBPkzdeBaSBw4Z1GXgCv7d
 3AYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782689422; x=1783294222; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAwUwdm66U+P5EfWF9HLID7LGqV52wZrK+nliMLVhsY=;
 b=RFcqSmrVJM7kUdFhTRxjPq2CLoZP2iOJZ3Zv2mkafnXvYVvxuwqpcKdunCSBp+mWOk
 zC5DrR0yu1FnDmc9aIy5xPCFrsxbkqNJpgClgYcSWyfyqw7166u16ROBoOvWeLyxZOEX
 JlcQSRGnjwE5OcP3ZsYk1zgIvTwm14qSB/tZARHtERcCXKqQR+eKgi4RkK1qMGUEAX3R
 KGeqGdhv38l22M12qN2F4y/C9om2S+cn88LOgrroI3NYDveSJeicwSYlzigYboFVf67i
 /NVqkkLjUVoNENpLmUdjLGAhjMVrMgqgKJT5VV6lrPfVk1Ce/WHm6nH/mh8zCwcbfJhV
 uFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782689422; x=1783294222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bAwUwdm66U+P5EfWF9HLID7LGqV52wZrK+nliMLVhsY=;
 b=oGb6nzHd6W17lZFSekt7lPtzJ95fmmQruJacSD4sjDgvhc0/iANo5D14dWf8fVL81X
 QVZWqUUYM8/JUbacl6z9p3m5RnVs8bKZxv3Hb7I9y8Ogkj84PhlV+p5myvlKl0fx7iHv
 SfuRdPQNjazqB+m9b+UZZXBU6GB+3ZhvZ1LuGTMRP+h7KTGHkvML00sxgupIR8Z0HD+r
 lnAw2hQDtiqrhkVeZy20/obe10sSu0lUd7bpJkT5T170buwXCKyYwpQz09CUA4iErO7V
 9sxtPrdCuFBdq7DYQ3j5wG8u6bXgwcI6MBYjqTOBB1IRY2RADuVtwyAc8f1t6ZBSUQbZ
 9mjg==
X-Gm-Message-State: AOJu0Yz5m6/vfP9KF4QbDEaKHQkx9zbfb2df2h0vzHQqmh+72kAyh8y1
 SbRyaj+X6smrRmVjpUGhKRZ/lBJxhWf9OGwp4nRyQcLSvORwfkjkuf5ifS1v7eESm+hAB+Szlpe
 FGrj5H1zJrdBRm3CIzw5XPQPxI+JnPSo=
X-Gm-Gg: AfdE7ckR/TCs/wdDsT2o/aV9LT5Gfjm/aw4yKKGqtGwRL2E36bObqf+xWcmF1kKj8U+
 Y5uRnyz2+0Ic92I7R0/piCgC0cDCxQ/X38k15UxSVu58XaujzUdwAj/Wuy/j1dvKuxbW/nFztrr
 WQGMRwpbUqKfGShVobYZk7KHlQzCseeE1k/ntchOxvoKNd9Cl45ViL5CzziwxwPw29xJCwZOlp1
 KCh0wO96P5FCz2lhg1CkswoRpuLRe7T5VsjsI41R50+BAl2CBxerGnnj6E49bc5CYKENTv0ZRto
 wURy7lO58lWCE4eGtDOt+Ut+mhP5MlMXT1TseA==
X-Received: by 2002:a05:6402:4012:b0:698:954:484e with SMTP id
 4fb4d7f45d1cf-69810b5dffemr5377304a12.14.1782689421931; Sun, 28 Jun 2026
 16:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260627194640.4130073-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260627194640.4130073-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 09:29:55 +1000
X-Gm-Features: AVVi8CevfnhJwG3rGgMrPNZub_Rxen2FbZwWvDpy53DB2fSAr3B3YREtbRGlOmo
Message-ID: <CAKmqyKNjb3M7YkgqBmD_oEYP9L7MUnboTAWoQ-Th_QDtvLS=Ow@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: check DC.TC reserved bits
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

