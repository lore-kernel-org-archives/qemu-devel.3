Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE364C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 03:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2FM-0007Ow-B0; Wed, 05 Mar 2025 22:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2FA-0007O2-Nu; Wed, 05 Mar 2025 22:49:57 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2F7-00058H-BD; Wed, 05 Mar 2025 22:49:56 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5236d34a37fso86731e0c.3; 
 Wed, 05 Mar 2025 19:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741232991; x=1741837791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8Bdtea+MTgwMLWizuKQfW99ZWm4hCJkAs7pqe/VHrw=;
 b=KW9oHwSNzLhMfibNvyyunMzgZiY/30tQfO2mGYQlNe9mw2biraDvnfDDJUCU+IGMSI
 dofpnTU3X5SVDY0tfzgU5vd3VMW3/fKx70gYoFUoxZ8gF8aD+X00ri8OBBZ8Zmr06jdx
 ofXCbClZZY+VQt+/UgjTv894CnhZgIGLwgosLsr5ix7ygfGBuhIV7OqtRSvKUtZXsB6F
 vcDCauylpmD6jVwBk1k3t1BZ1bT1hXuCEypsMfoBxqlE6KmOvOG/EbpvjP1fLISf4PBC
 A4HGGJCzJdb81Srira2BcmXZDkd0WJKbIGB5gGZxWgsmn87xP+agxDST3AR5Kf7GDJn8
 S/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741232991; x=1741837791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8Bdtea+MTgwMLWizuKQfW99ZWm4hCJkAs7pqe/VHrw=;
 b=E2XfHw1LHDUKa070vCbqzkN4ybVmu6KM8AZbkt7xhpMT4a4YM0ZYjbzjMIbvWMPBWL
 DGXSPFV9EunGzwvr2gqmd9sPYQPlUt9ZmvzIhM8iq92LvHEyfTYRW5u0C3T9UqylSZBh
 LJcy4TL/ndGa+W9vOcFTcUpKNGYB8fZ5Dtx06N9EMte55hLf2fvyWZlwxFvo9Oii1Nns
 OExC4ZJaji9m4X6U4qs/NFqxXLiybRjVDYI0iYcbOB80bxYTGiWpevmt1oUIKd0Rai6X
 aNQVptbujSwUIzg7eX4/xUndyzyOlK6rUJaEJuG3GtLt0GNOiLekjuWrjCpV45dG5u5R
 +g8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUucrUzMQ4TMc34rZ/F30j8ZsmjyDkGkAPs0DG3Zkg0stNLyP2d/xyO3aRkgG8AmnmTEfQeGSRXyvYq@nongnu.org
X-Gm-Message-State: AOJu0YyWKfx9L2DdYIhm+8HL6DXKbXBIMJuUeHrLqq4vQcghu8kUMZFI
 D3ONQQYjHCfqDjgB5qbAiNorfaU8YhkzJ7QVTwdEGYluk9wjMzinnRkjAXTcLhuMo4dMm8TD1gh
 daqX3yJaiZGChh5OeBp5+dQMEkcg=
X-Gm-Gg: ASbGncsnpsZNXcv2QnAE9RLfsqVgqmpIuGstSHndSCS8jsOue+TpZ8vy17CS4F4G1Aw
 AZBbu+pElzcyUdY/MhH+nNYt8w0zNkZKfXELSfjCnx6gCyTl7sT/797IPA+RJ9QqQgOXIc9zMPG
 OWMROmn7P8qj1hgonPBwXYeRn5FkNBc9k/EIb8zNfwPwFbpU5RupMZiXWr
X-Google-Smtp-Source: AGHT+IF1iWSqiJ/c68rEgZ4CfDWgPc77uCApFpcWgw1FRs5hAMWFL+P4FHiR3xgW9bOcVHya9h9c9YV0g74+y0/LMII=
X-Received: by 2002:a05:6102:3e1f:b0:4bb:dfd8:4181 with SMTP id
 ada2fe7eead31-4c2e2745ad4mr3732134137.4.1741232991266; Wed, 05 Mar 2025
 19:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20250304231956.34396-1-philmd@linaro.org>
In-Reply-To: <20250304231956.34396-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 13:49:25 +1000
X-Gm-Features: AQ5f1JrlGgMs97-L4OfMSr7YZEuivxZckHW74aeMi37yCsXSw2MWQt2BN_tp-Js
Message-ID: <CAKmqyKMmsgBMW1iQX9ZPrGTpywu5y+DFnes+Cx0GJQr_NTFNVA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Get target page info using runtime
 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Weiwei Li <liwei1518@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Wed, Mar 5, 2025 at 9:20=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Prefer runtime helpers to get target page size / mask / bits
> rather than compile time definitions. This will help to build
> these files once for all RISC-V binaries.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-pci.c |  4 +++-
>  hw/riscv/riscv-iommu.c     | 29 +++++++++++++++--------------
>  2 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 12451869e41..e2b893c5898 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -23,6 +23,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "migration/vmstate.h"
> +#include "exec/target_page.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/host-utils.h"
> @@ -102,7 +103,8 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, E=
rror **errp)
>      qdev_realize(DEVICE(iommu), NULL, errp);
>
>      memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
> -        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_S=
IZE));
> +                       QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr)=
,
> +                                     qemu_target_page_size()));
>      memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
>
>      pcie_endpoint_cap_init(dev, 0);
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index e7568ca227a..8bbb33b8b53 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -23,6 +23,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "migration/vmstate.h"
> +#include "exec/target_page.h"
>  #include "qapi/error.h"
>  #include "qemu/timer.h"
>
> @@ -300,14 +301,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>          riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>          iotlb->target_as =3D &s->trap_as;
>          iotlb->translated_addr =3D iotlb->iova;
> -        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        iotlb->addr_mask =3D ~qemu_target_page_mask();
>          return 0;
>      }
>
>      /* Exit early for pass-through mode. */
>      if (!(en_s || en_g)) {
>          iotlb->translated_addr =3D iotlb->iova;
> -        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        iotlb->addr_mask =3D ~qemu_target_page_mask();
>          /* Allow R/W in pass-through mode */
>          iotlb->perm =3D IOMMU_RW;
>          return 0;
> @@ -390,7 +391,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx,
>      do {
>          const unsigned widened =3D (pass && !sc[pass].step) ? 2 : 0;
>          const unsigned va_bits =3D widened + sc[pass].ptidxbits;
> -        const unsigned va_skip =3D TARGET_PAGE_BITS + sc[pass].ptidxbits=
 *
> +        const unsigned va_skip =3D qemu_target_page_bits() + sc[pass].pt=
idxbits *
>                                   (sc[pass].levels - 1 - sc[pass].step);
>          const unsigned idx =3D (addr >> va_skip) & ((1 << va_bits) - 1);
>          const dma_addr_t pte_addr =3D base + idx * sc[pass].ptesize;
> @@ -448,7 +449,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx,
>              break;                /* Reserved leaf PTE flags: PTE_W */
>          } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D (PTE_W | PTE_X=
)) {
>              break;                /* Reserved leaf PTE flags: PTE_W + PT=
E_X */
> -        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
> +        } else if (ppn & ((1ULL << (va_skip - qemu_target_page_bits())) =
- 1)) {
>              break;                /* Misaligned PPN */
>          } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
>              break;                /* Read access check failed */
> @@ -480,7 +481,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx,
>                  riscv_iommu_msi_check(s, ctx, base)) {
>                  /* Trap MSI writes and return GPA address. */
>                  iotlb->target_as =3D &s->trap_as;
> -                iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +                iotlb->addr_mask =3D ~qemu_target_page_mask();
>                  return 0;
>              }
>
> @@ -950,7 +951,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)
>           *   device index: [23:16][15:7][6:0]
>           */
>          const int split =3D depth * 9 + 6 + dc_fmt;
> -        addr |=3D ((ctx->devid >> split) << 3) & ~TARGET_PAGE_MASK;
> +        addr |=3D ((ctx->devid >> split) << 3) & ~qemu_target_page_mask(=
);
>          if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
>                              MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>              return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> @@ -968,7 +969,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)
>      }
>
>      /* index into device context entry page */
> -    addr |=3D (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
> +    addr |=3D (ctx->devid * dc_len) & ~qemu_target_page_mask();
>
>      memset(&dc, 0, sizeof(dc));
>      if (dma_memory_read(s->target_as, addr, &dc, dc_len,
> @@ -1037,7 +1038,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx)
>           * level. See IOMMU Specification, 2.2. Process-Directory-Table.
>           */
>          const int split =3D depth * 9 + 8;
> -        addr |=3D ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
> +        addr |=3D ((ctx->process_id >> split) << 3) & ~qemu_target_page_=
mask();
>          if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
>                              MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>              return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> @@ -1050,7 +1051,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx)
>      }
>
>      /* Leaf entry in PDT */
> -    addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
> +    addr |=3D (ctx->process_id << 4) & ~qemu_target_page_mask();
>      if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2=
,
>                          MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>          return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> @@ -1440,7 +1441,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>      perm =3D iot ? iot->perm : IOMMU_NONE;
>      if (perm !=3D IOMMU_NONE) {
>          iotlb->translated_addr =3D PPN_PHYS(iot->phys);
> -        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        iotlb->addr_mask =3D ~qemu_target_page_mask();
>          iotlb->perm =3D perm;
>          fault =3D 0;
>          goto done;
> @@ -1481,7 +1482,7 @@ done:
>                                 RISCV_IOMMU_PREQ_HDR_PID, ctx->process_id=
);
>          }
>          pr.hdr =3D set_field(pr.hdr, RISCV_IOMMU_PREQ_HDR_DID, ctx->devi=
d);
> -        pr.payload =3D (iotlb->iova & TARGET_PAGE_MASK) |
> +        pr.payload =3D (iotlb->iova & qemu_target_page_mask()) |
>                       RISCV_IOMMU_PREQ_PAYLOAD_M;
>          riscv_iommu_pri(s, &pr);
>          return fault;
> @@ -1683,7 +1684,7 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUS=
tate *s)
>                                         RISCV_IOMMU_CMD_IOTINVAL_GSCID);
>              uint32_t pscid =3D get_field(cmd.dword0,
>                                         RISCV_IOMMU_CMD_IOTINVAL_PSCID);
> -            hwaddr iova =3D (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> +            hwaddr iova =3D (cmd.dword1 << 2) & qemu_target_page_mask();
>
>              if (pscv) {
>                  /* illegal command arguments IOTINVAL.GVMA & PSCV =3D=3D=
 1 */
> @@ -1715,7 +1716,7 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUS=
tate *s)
>                                         RISCV_IOMMU_CMD_IOTINVAL_GSCID);
>              uint32_t pscid =3D get_field(cmd.dword0,
>                                         RISCV_IOMMU_CMD_IOTINVAL_PSCID);
> -            hwaddr iova =3D (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> +            hwaddr iova =3D (cmd.dword1 << 2) & qemu_target_page_mask();
>              RISCVIOMMUTransTag transtag;
>
>              if (gv) {
> @@ -1928,7 +1929,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState=
 *s)
>              iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault)=
 << 10);
>          } else {
>              iova =3D iotlb.translated_addr & ~iotlb.addr_mask;
> -            iova >>=3D TARGET_PAGE_BITS;
> +            iova >>=3D qemu_target_page_bits();
>              iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
>
>              /* We do not support superpages (> 4kbs) for now */
> --
> 2.47.1
>
>

