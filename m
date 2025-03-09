Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68EEC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 22:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPDP-0000lx-Hs; Sun, 09 Mar 2025 18:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPDO-0000la-W5; Sun, 09 Mar 2025 18:33:47 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPDN-0007ST-Fg; Sun, 09 Mar 2025 18:33:46 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86d30c329f2so3671418241.0; 
 Sun, 09 Mar 2025 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741559624; x=1742164424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZt39XP6czpEK3Q/IABd/Gd5rSB6/M1eKNQS1jsJZrQ=;
 b=EBq94RezrJsqfYoziEcWaB1llrjfyAZyipFiqRnsmgFrlS+ZHysd2JjqMox1Dl1zLR
 /EheZsYbdoQeGXxlZiO3KDuflVc7VQfjMekgpp8FhsIsCwXT7R24KL7grbBe22QUlAET
 GzsuJoMcCbdc6l1TA+zZFt4yUabT8R6a9QBaMTRW7FiZ4bu6m4qhBTXYg6dnA5fCH0R+
 /SKAPhgLRgPvljFJlZyxXjCckqCDoJfzBC54xaoYM3ij7126TfWWVrULw+2PqX+U2793
 yWca2N8ZPIS3bM65YRM5pzk1bHxvFTaD5tqM0Wl5rjlw+2km9SfgpH3KmxvVLoX/kyO+
 RLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741559624; x=1742164424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZt39XP6czpEK3Q/IABd/Gd5rSB6/M1eKNQS1jsJZrQ=;
 b=d2R6hIvszIr0kj7Hqn15wLKs67xYGBkVCeGBnOCstOXpqYJAdNm7j8VU6IX7KYRCaH
 DTnhOA6gFxksA1NSf2+FIg03o8FpHil16LVkdrC+PSCZOCgRgt25cT98olzQBk4/EdZR
 ICm4XrZHyBBucyT918+8WOPsuuBCzTn/6m/bf1FMh61vig/HhsozBZ7xkxBBWqz6MK5a
 u9an/WxHpUm0RxK0g4U20k+GPS8Kk/BCQGAvleA5syZveq+Gh+X7SCSESbn/7IxjKPMz
 kcTFUBNQPd6U7CCOdvO79Aht2qn5na/wgiqGJUgeqfhT+HG/d2vgs29ufHqTEn7yUq6d
 LUAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkjErPdLkevhk7z9veEOSOxIZ67Ebds9haMs8U9Xm/nYmmyEQTj3Npn1rd43FdpqcdiRaxMeVUF2Rz@nongnu.org
X-Gm-Message-State: AOJu0Yz/aIOTpw5fYGRAlDp7U3iiyEEnI96LL6fGwkOaDDQ3aNpnhor2
 Gupe3xsnUPfv4L8r667Uvi5/KsntF4Lkzs0fGNTdaYqEZ9K6xtOfDUPoIOXrsc4o5eFJzq9NXRt
 thUiqvP+ACJ5axhR/7C8xzprPeJ4=
X-Gm-Gg: ASbGncubdoi8IAqPrYKgljtOD0ruFsnd4+b6gy84WroUd8FqCnjBUoqMHfaVz95Ws3k
 ZjwRi04ARbDyPKLH20UW5gZW6RvZYmG4CvpYVcdlhxJB/KGWIbC1vQXmNkVyRCB2UAMhijU/8nR
 pXK504j17L+KEmj1gtK3cgtg/pMfJZWH2h3wiygLLiJyl+PKFmkRcOKy+i7F4kY03JhQ==
X-Google-Smtp-Source: AGHT+IGNyxDnLTki6bU1Uygr/sFuMCHeHh511Av7faNbbDVgrwU7eW9ohBLplB4pEeaOFOIz3iAH0e5Etskw4EjezxI=
X-Received: by 2002:a05:6102:1626:b0:4c2:fd52:c2c4 with SMTP id
 ada2fe7eead31-4c31b758b61mr3821909137.12.1741559623704; Sun, 09 Mar 2025
 15:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250301173751.9446-1-jason.chien@sifive.com>
In-Reply-To: <20250301173751.9446-1-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Mar 2025 08:33:17 +1000
X-Gm-Features: AQ5f1JpCfoIHen0vuGccLJoTlyLxfAA0BWCT42aGOLicsoA6N_oHvPULsivgKJA
Message-ID: <CAKmqyKOQAhj14C8QBoMiVPUiJGr33xqN+QfmeT5z6eZQvAW+Gw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: Fix process directory table walk
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Sun, Mar 2, 2025 at 3:39=E2=80=AFAM Jason Chien <jason.chien@sifive.com>=
 wrote:
>
> The PPN field in a non-leaf PDT entry is positioned differently from that
> in a leaf PDT entry. The original implementation incorrectly used the lea=
f
> entry's PPN mask to extract the PPN from a non-leaf entry, leading to an
> erroneous page table walk.
>
> This commit introduces new macros to properly define the fields for
> non-leaf PDT entries and corrects the page table walk.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 6 +++++-
>  hw/riscv/riscv-iommu.c      | 4 ++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index b7cb1bc736..1017d73fc6 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -415,12 +415,16 @@ enum riscv_iommu_fq_causes {
>  #define RISCV_IOMMU_DC_MSIPTP_MODE_OFF  0
>  #define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT 1
>
> +/* 2.2 Process Directory Table */
> +#define RISCV_IOMMU_PDTE_VALID          BIT_ULL(0)
> +#define RISCV_IOMMU_PDTE_PPN            RISCV_IOMMU_PPN_FIELD
> +
>  /* Translation attributes fields */
>  #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
>  #define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
>
>  /* First stage context fields */
> -#define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> +#define RISCV_IOMMU_PC_FSC_PPN          RISCV_IOMMU_ATP_PPN_FIELD
>  #define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
>
>  enum riscv_iommu_fq_ttypes {
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d46beb2d64..76e0fcd873 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1042,10 +1042,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState =
*s, RISCVIOMMUContext *ctx)
>              return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>          }
>          le64_to_cpus(&de);
> -        if (!(de & RISCV_IOMMU_PC_TA_V)) {
> +        if (!(de & RISCV_IOMMU_PDTE_VALID)) {
>              return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
>          }
> -        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
> +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PDTE_PPN));
>      }
>
>      riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
> --
> 2.43.2
>
>

