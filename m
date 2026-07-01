Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93160C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemLV-0001vE-6r; Wed, 01 Jul 2026 00:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wemLT-0001uP-Bx
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:14:43 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wemLR-0007oC-5S
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:14:43 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so363723a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 21:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782879280; cv=none;
 d=google.com; s=arc-20260327;
 b=ZKMePApXWo/o28sSLHntsPr8eYBBzGBBWNznzXe3ofvyN8O+0zaqmQi23Q2FrZXiyD
 XDtEzmslGc1ziAg1iRdXJKSL+jV8l+PA0GvxQvhbcwtzzObAefHbq45mehtc2ru/Djiw
 q3Xl2yV5K8YbGrHk1FdScimC7KCsOz0YQtHwupaYjf3CYkoopo7oEYjw999uVcwF+9VT
 +W6sT8HtL4UKhAp/he3jt68vZFY2uhYFqIlOpRRO6hNbj7GJxbJtLd4DrVPDtWzT5nss
 F7dasLLSePHgKH1XcQHRTvzsaN2KPqRlQTma1XgeEvM9k2/TBFjinwL6lIjc25PwrvpC
 rGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7+9sRjRXYDFcrkBxnSLybCqsBXTjkR7NSKgdE34tPL4=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=R+Hwog3hewmIhUpM3Fba/3ZbPO3Szw7NvYkdP3Te6KxrVeVHBFgP0m7vvlGH1+pKE/
 x71M21ZtEFxvEXJkX5+snhIawL8EhXA3iBhUjTng57uJysOgRL9EZ78LqXvw3/DvuGPS
 jV0vEHdXJlAh3wMIhqLn/kgXZM+JZSHD8xnveAa6XNwNjJ/xb0FglAjvYra8cpRHcOlM
 OzD5xMMMeGUUPqBewU2GgqgcQ0UClTSV7Qg4C2rEVeulP7IchagbZD+7aKsX66GTd3u3
 P+NbRfIKH3710N0vyEvPobyiCPmF9ho+cYJjS77TVtEQnfDN2hQPKu3SLhGTjUFg+Zro
 V8PQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782879280; x=1783484080; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+9sRjRXYDFcrkBxnSLybCqsBXTjkR7NSKgdE34tPL4=;
 b=fCi1H2VFnZzs7QS0OkgdGiPPeWOqrO6jX4NOvY+csqJrXvghdHh0PnwK/Tm6yRp2Lw
 NrmEjOIDqF5izZw0x8fAONm9rn3l+fIK44SBrUtN7YBsEhaX7ADst7BScxGpJWYjWmDE
 DblfxFXu107h0vv+cj9KPH0a7w+m/cPtRrUsHlAszY+AyQ8uYMV8NO3ISOuLwklSTZwI
 v1t7LZYpRFs+nmzNZLuB7o9afbFK8+DnDXV49bhr4Lc/nuro2mZo5kDMZ+eDkX9svDC/
 t78oXeIcPOC830W1oEwMadGdwWe05ltZg5qaMff6408N5ToYx46VPnDRdnS7NVUHZsTi
 xyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782879280; x=1783484080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7+9sRjRXYDFcrkBxnSLybCqsBXTjkR7NSKgdE34tPL4=;
 b=Gg+ZS/6RLYW+JCbD3gIuE/XYTqYKqzZoTjYlmQxaqft6EQUL79/mJ4HvJdQV8F3tM1
 P0PQ9IGP/lkKnBu1eVzpDbX7cPWWQ+dXAKe39dbdPTV3re0olYGu9wGoGIV726F8iggz
 P8cXOc2J/UQyGKO6dlFwWOjCBtZhh3k0XSocPsDzbOVSi2SnYKDfBp0n3HSkYyhuFYin
 anQnS0AYuGcWEIeUBpzDzgLY0pqog1uNJJZOJHOO+d1zjZQmtyt03g2BfGin5iIong8u
 qwAgiNZ7FktVFGj0vx8qaEi25eJdxz3k8zBfOAu16h0ytXIr07cdnxVYHv3nOdoBQmIa
 rmJQ==
X-Gm-Message-State: AOJu0YxboQoJW2idpHMuK+Jn6snSMw5tnnRWfDYMFCm24JZWoWosVp/1
 XJxqFrHSiy03Xi07niNo576ltVDUhxPswyCTj/sK05r8P2KrBA9ieyNZDfWes9Jye154MYcZCaG
 UUSfibDZbcun0Vxctkaz7eSvYJVXnQpU=
X-Gm-Gg: AfdE7cmCR2hioxRXSqMxz9xrisywd3B/FGdlHNbAAENaQQUs4THE5HrLba04VfNTbm9
 B1/bO7EParRp71QVgV/QKUe+OE4+fBKrQZE2HZYQ6rdczl5kLeOZ2m8n/ZNIa0cZ0Em8fw6kM45
 mNrDkxrkNI7z1Kas0jwtFiTsiBY+7ut1G3CjHr8xdvZfUcnGoeHqYXUyoIuluFQDFRnzb+jHVi7
 W5O1ZzPQ681hABs+bVhqXy2NHaeKOX4yutBWwGg67JsHU6OOYpkHvMD1V0bluABsZcjAG0xAtiz
 qaEn1atEh1c5AGLNO1EssCcqR1s=
X-Received: by 2002:a05:6402:4307:b0:698:3b7c:7e4c with SMTP id
 4fb4d7f45d1cf-69879e0c993mr3141926a12.34.1782879279431; Tue, 30 Jun 2026
 21:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Jul 2026 14:14:12 +1000
X-Gm-Features: AVVi8CeQSCmgrhRiDUQiOTdIXTeZQjc5vS9pCvh_yvPp0J9DvJ2wsdQDrKVzr70
Message-ID: <CAKmqyKNMYoxcjNN+zH4cv=r+RfmjvHpO7s8Np0Wg+fr8hSmynQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
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

On Wed, Jul 1, 2026 at 7:11=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv-iommu spec: "If SADE is 1, the IOMMU updates A and D bits in
> first-stage PTEs atomically. If SADE is 0, the IOMMU causes a
> page-fault corresponding to the original access type if the
> A bit is 0 or if the memory access is a store and the D bit is 0.".
>
> Note that SADE=3D0 and A=3D0 will always cause a fault regardless of the
> original access type.  Right now we're faulting in this case just for
> reads.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3551
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..70eede3f14 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -480,7 +480,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx,
>              break;                /* Read access check failed */
>          } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
>              break;                /* Write access check failed */
> -        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
> +        } else if (!ade && !(pte & PTE_A)) {
>              break;                /* Access bit not set */
>          } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
>              break;                /* Dirty bit not set */
> --
> 2.43.0
>
>

