Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC10CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 03:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEgHo-0002Tv-6d; Thu, 30 Oct 2025 23:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEgHl-0002Tc-9z
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:58:45 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEgHi-0004Fb-A2
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:58:44 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63c523864caso3730973a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761883116; x=1762487916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BokiKp9qTUNyh6rzgGYHS36tM4lwyXsDRyewuQc6pY8=;
 b=ASfpWjjwX/tCq+fzLyzvyEa4mk9vJUuvbryh3GuvFnrxRpZF2AjhROwMB+Nkjb5KxZ
 1aUetRoGkhHP8zH+ht+Pw3gVFWTZ3eYHZ19seUwBP6j9h/upUVnKzLikubgOgy21IsLE
 D8aBheS/BfYXGxm4e4tjKka+144eHu21Mb5K//iId2O2e8LxSJzEt0sTy/PDWFIEzOVz
 nPZcDrWE8gEV16KNmcIJikKqyxYWJpXr/YPDOHZGU/LHopvG0pOgERHSQU5BDim8DN7p
 5TyFNdJHRWKQ5flOfWEO/OgAnpXaWBqsERR3gEVDcewtFH4eFldLOqp55YqbkMYQOlsc
 xkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761883116; x=1762487916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BokiKp9qTUNyh6rzgGYHS36tM4lwyXsDRyewuQc6pY8=;
 b=KVrboFXp0omi0dXNCOdcqUDwU1bAgKzldPV1+gj5cBQlrb+PbpTHResl4P/nhhhmyh
 45C1VeuIcfISR33LHnHIcWxpRVhqBmumvhVqHBnWnyn7ueAipMkRKX7/ZQnEb7MKRwpk
 o8LIvBziS5ES4E2ochMfHX5WyGeGafNaRdMu1hSKIiGN3uG2NeJdq86HgIWKBVCy5ImA
 UfXoauKFUzOgk5hfhgNlJ6jGfp2WVXQ6YFlQU/Dq+jiux1e4ykPv2agbRPETp51vmu0R
 ZxvIDRFwPmnsCsAyqbVl+rFK2XqZN7dppm8LsZfPEW1amkKCfwdOwUJUVIHo9GTu6cy1
 biqQ==
X-Gm-Message-State: AOJu0YyfnnTw8uoR2+ue6ypFsQy++nbWGsM0R0C315M19mPqk/UAR3Np
 XqaO4EKWrKsM3DibxMCeL8gfp3gvD908wljkr7EtDa0ZH0SzzcKuEyYM1P0iOwFNky0zBXDIiuu
 1kLsmrNFdEjM+eH3xTHqZ7PH5k3NBQqo=
X-Gm-Gg: ASbGncscgWuJkDVHeGH5aVp2I6aJPgTm5YtVzDx6kCx/MQDEu0Y2RxNTVajvXbPVuN4
 j6jTiUczBsNN3MuxOkOEC8LaNNo/20/pxw7Bd2idKb/dwqaZ64DI6qp3rRmUu4gOECvp8RILaot
 ZR0wBkDlJDvGPG4V5dRFU58vf0yNDaYTfHY05fL3fMm2WYVezp3nHRTFdFzEW+bsSn8nh5YeWl2
 XblwvFppjXmk4d5BEI5B9ZxBuKIhRaxYYo7TYI9i2zjQkOkmjuJlIaRd16MsPX+IOldocjp4wHH
 MjfjTCajo+MezARi7wSlVd4nNQ==
X-Google-Smtp-Source: AGHT+IHZwTFDrPREnrsfj9gwbv1h2cnf7MXKpBdQ5HZ8aHojq9OikDTXpFbf4USOSSQWfMVPOifH8Kg61eyQ72MUqWw=
X-Received: by 2002:a05:6402:50cb:b0:634:ab80:d84b with SMTP id
 4fb4d7f45d1cf-640770403admr1524959a12.32.1761883116398; Thu, 30 Oct 2025
 20:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 13:58:10 +1000
X-Gm-Features: AWmQ_bm_dus-q2D7bfKBZY0JcC3WoyxuokwhueMUeBG2PKrFnMFVJ6f39IPWRbA
Message-ID: <CAKmqyKOMaBRGJ_p_7Ht1s4y=hWubS_Zt_c0Gz6EaT7xa-o8EeA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix MemoryRegion owner
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Mon, Oct 27, 2025 at 3:39=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> as points to the MemoryRegion itself. s is the device that owns the
> MemoryRegion.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b33c7fe3259e..51c28d4f8c57 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1362,7 +1362,7 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUSt=
ate *s, uint32_t devid)
>          /* IOVA address space, untranslated addresses */
>          memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
>              TYPE_RISCV_IOMMU_MEMORY_REGION,
> -            OBJECT(as), "riscv_iommu", UINT64_MAX);
> +            OBJECT(s), "riscv_iommu", UINT64_MAX);
>          address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr), na=
me);
>
>          QLIST_INSERT_HEAD(&s->spaces, as, list);
>
> ---
> base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
> change-id: 20251027-iommu-94d68e7a85d2
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>

