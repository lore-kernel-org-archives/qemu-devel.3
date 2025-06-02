Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F898C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLy0l-00079H-U5; Mon, 02 Jun 2025 01:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy0J-0006N1-SJ; Mon, 02 Jun 2025 01:46:37 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy0I-0006mY-DJ; Mon, 02 Jun 2025 01:46:35 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6fada2dd785so22260316d6.2; 
 Sun, 01 Jun 2025 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843193; x=1749447993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W48rNXSt6u8jcvm5ZiFTJv2uoY5wSZUOH3/y4WAWp+I=;
 b=NqxS/Gqs/fa3ZB98QQW7qZ6GqojgV3qOhIu+tv5tyjsCgOY52G6yFY8qLZliJqrb3E
 QmiYasubvdGYNLzi/O0whamjE/nfgN8AL0Hsfjv0kWL0JcWMZU3/B5DqI7MJOjY4XbS/
 TygCssKhWFVBGWI73LCRqwEff0BCc3Ut4Ua2RYTC15Ts8l/+SNWuatPH1aZLpX2vyeqF
 2U3CSpvQq5ZgPM1xbVg/FLcAwPCrxCxGtv3DljSP8UdU6xeYfRAJSGdnYWQlDmPPweKw
 rGKkiGoMudrFTQhxwy5dl/E78bnyh5rV+mLQ0to5kNst6EhpFaGRax7MCC8vEOK2AKsl
 ACtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843193; x=1749447993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W48rNXSt6u8jcvm5ZiFTJv2uoY5wSZUOH3/y4WAWp+I=;
 b=EBi8bjJDp01hGy92lsM4/UAAY2WOoridlDYz10ec+vPH6UpIWineitysCOFlZvubGi
 kevP4TF+v125JmfoCxdCzCd31hqOGhcGYOK9mribPusESHBGoTmF7stb26vmqtOtW60q
 3DAcWvJ6kYO80D2ZxyVLYzMe61V2pdGU5hn7jCMeJu0Ga4ac/MrrjbOl/5oNxOA3hyrp
 oohQfYaZRMd1bcuUPur/2lJJq5wzB8bEcJDzBST1zCdH1A8Rsl73TgH2WLPoak57K9qe
 vXYcwhm4bds2ZvKOe8bHEkl5GhMrswvjVI1KI9u3kpau+fFeV8I6B4EMJMOO8RTc1i8w
 v3vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0WRWFh0rrsCSi1VhsuhCpBZmXWgzI8pNb2da1A5baqW/IX5TK3jfL6AMkEq1m7Vrem8ihqzwYVpniew==@nongnu.org,
 AJvYcCWLe0kCuw0/9m/TW9Hq9tUwoK6wXUq1V+MQ9AFYYYHoYwpVibra2lwkby2Eai/aoQrQ+0FyRj0SYz6h@nongnu.org
X-Gm-Message-State: AOJu0YwVKCDfsYD0YEeoKxjoyJrDByNs3FVlXf+UuuLq0DCQQEyNqi4b
 fBoHIqRoDMQiLtmFlBdW/onDUK9Tmz5EEe0zIOy17Cx/H1zOzpTfz0hW90f326xNBQn1+j80MUc
 283VMLGAMFfuXbkyRKcv5Kqa0cSchXy0I6z7u
X-Gm-Gg: ASbGncuiT7XMeQtqJJByqee77OnyWofNq9zW53XrzPzyN/xGM6Nb2IaD+iVd8926ZEZ
 JIVPLGBEkOUr01S5Onqy59JN9mVZWn2B3H6N84YIA7HiS8LqbEp2bs4ggBjnPXukzE2fghGiNI7
 X19DaDtvr4OCBqx9Y/uUvXQDLFdM0Zk6u6jkJ+olfHM+cLPcDCWmaHPhBM1uhJfZs=
X-Google-Smtp-Source: AGHT+IEvfiqVSLeTJ6Go885ho7Sz1nVsSa7hKhebVKATj/0B0bJAA5xUYtKTz2099qAAqSuvanS/kd5/46ZyIXcoVhM=
X-Received: by 2002:a05:6102:3750:b0:4dd:b9bc:df71 with SMTP id
 ada2fe7eead31-4e6ecd66b88mr7811286137.10.1748841138530; Sun, 01 Jun 2025
 22:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250529092632.4367-1-liujingqi@lanxincomputing.com>
In-Reply-To: <20250529092632.4367-1-liujingqi@lanxincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 15:11:52 +1000
X-Gm-Features: AX0GCFvW2VEV8T9n9m9kUQgBjvo3aHDR0hMv9LiqGszZkuwLFIxdGxAl2OEVa0Q
Message-ID: <CAKmqyKPKLHk97s-eVGANq7hYfny1g-WgFQA32eoNo9UYLC9ixA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix PPN field of
 Translation-reponse register
To: Nutty Liu <liujingqi@lanxincomputing.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=alistair23@gmail.com; helo=mail-qv1-xf2c.google.com
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

On Thu, May 29, 2025 at 10:52=E2=80=AFPM Nutty Liu
<liujingqi@lanxincomputing.com> wrote:
>
> The original implementation incorrectly performed a bitwise AND
> operation between the PPN of iova and PPN Mask, leading to an
> incorrect PPN field in Translation-reponse register.
>
> The PPN of iova should be set entirely in the PPN field of
> Translation-reponse register.
>
> Signed-off-by: Nutty Liu <liujingqi@lanxincomputing.com>
> ---
>  hw/riscv/riscv-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index a877e5da84..f529a6a3d7 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1935,8 +1935,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState=
 *s)
>              iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault)=
 << 10);
>          } else {
>              iova =3D iotlb.translated_addr & ~iotlb.addr_mask;
> -            iova >>=3D TARGET_PAGE_BITS;
> -            iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
> +            iova =3D set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(=
iova));

I don't see how this is different.

PPN_DOWN(iova)
is the same as
iova >> TARGET_PAGE_BITS

and

set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova))
should just return
(0 & ~RISCV_IOMMU_TR_RESPONSE_PPN) |
    (RISCV_IOMMU_TR_RESPONSE_PPN & PPN_DOWN(iova))

Can you describe the issue with the original implementation and why
this fixes it in the commit message?

Alistair

>
>              /* We do not support superpages (> 4kbs) for now */
>              iova &=3D ~RISCV_IOMMU_TR_RESPONSE_S;
> --
> 2.49.0.windows.1
>

