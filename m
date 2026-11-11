Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A995606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=V4kpL6Ww
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzt7-0003gq-2a; Tue, 10 Nov 2026 23:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1xQzt4-0003gA-5B
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 23:24:42 -0500
Received: from va-2-42.ptr.blmpb.com ([209.127.231.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1xQzsy-0003Lx-Ni
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 23:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1794371066;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=X1zuBvXZDippIDsXdin+wtDh6l4P12B52OCzhk70jyE=;
 b=V4kpL6Ww+Q72nEWMFdOUGOw7tIABqS8xqASINw9Pu6BZ6jS6p0wEAQeh1GISnrK2Zfc5o7
 BbWd3CBvddZpuDxHJwLuakxZ8RhY5jS5qmFpAR1CGlijSILDZ+GG367v7hGTFz6eMUlDCz
 pfL0Bc+pPvj0o2WdNAtqEw5tmB4C5qy1fbyOez7GzOFcRUIztsfi6iE+xkifSS9vs9NQA4
 yBfECDSqI08C71nJqNJbP0eZliNVuABLViH67Z/1pQ/qdZzmv3HO4QpNBnL1k6W7hJRvPs
 WilHzBnyTLmZAvOI320l2MmEBdFSALJhuUB7kTlzanI6w0UkCEXSPY2aYUhZ7Q==
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
 <20261108143934.129923-2-tanchi25@mails.ucas.ac.cn>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:24:21 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26af3edf8+84146b+nongnu.org+liujingqi@lanxincomputing.com>
In-Reply-To: <20261108143934.129923-2-tanchi25@mails.ucas.ac.cn>
To: "Tan Chi" <tanchi25@mails.ucas.ac.cn>, <qemu-devel@nongnu.org>
Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, 
 <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>, 
 <chao.liu@processmission.com>
Received: from [127.0.0.1] ([116.237.165.236]) by smtp.feishu.cn with ESMTPS;
 Wed, 11 Nov 2026 12:24:23 +0800
Subject: Re: [PATCH 1/3] hw/riscv: iommu: Fix implicit G-stage page-table
 accesses
Message-Id: <e01fa7e2-61d0-44e5-b9e9-b484ac7aa4e6@lanxincomputing.com>
Content-Language: en-US
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Received-SPF: pass client-ip=209.127.231.42;
 envelope-from=liujingqi@lanxincomputing.com; helo=va-2-42.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/2026 10:39 PM, Tan Chi wrote:
> When translating a DMA write, G-stage accesses to first-stage page
> tables are implicit reads. The current implementation checks permissions
> using the original DMA access type, which may incorrectly require write
> permission for these reads.
>
> Use read permission for implicit page-table accesses while preserving
> the original DMA access type for the final translation and fault
> reporting.
>
> Also track the fault address separately from the translation result and
> set the implicit-access flag in iotval2 for guest-page faults. Route
> address-range failures through the common page-fault path to report the
> correct fault address.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---
>   hw/riscv/riscv-iommu.c | 60 ++++++++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 22 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 0e6970773a..2dcc528599 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -273,13 +273,15 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr pp=
n, hwaddr addr, hwaddr *out)
>    * Keeping them separate for now, as error reporting and flow specifics=
 are
>    * sufficiently different for separate implementation.
>    *
> - * @s        : IOMMU Device State
> - * @ctx      : Translation context for device id and process address spa=
ce id.
> - * @iotlb    : translation data: physical address and access mode.
> - * @return   : success or fault cause code.
> + * @s               : IOMMU Device State
> + * @ctx             : Translation context for device id and process
> + *                    address space id.
> + * @iotlb           : translation data: physical address and access mode=
.
> + * @fault_iotval2   : Fault address and implicit-access flags for iotval=
2.
> + * @return          : success or fault cause code.
>    */
>   static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext =
*ctx,
> -    IOMMUTLBEntry *iotlb)
> +    IOMMUTLBEntry *iotlb, uint64_t *fault_iotval2)
>   {
>       IOMMUAccessFlags trans_perm =3D IOMMU_NONE;
>       dma_addr_t addr, base;
> @@ -299,10 +301,10 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>       MemTxResult ret;
>       bool pv =3D !!ctx->process_id;
>       /*
> -     * Keep the request permission separate from iotlb->perm.  G-stage
> +     * Keep the request permission separate from iotlb->perm. G-stage
>        * walks translate S-stage PTE addresses before the real leaf is
>        * reached, but permission checks and fault types must still use th=
e
> -     * original request.  A successful walk leaves iotlb->perm with the
> +     * original request. A successful walk leaves iotlb->perm with the
>        * effective leaf permission for the translation cache.
>        */
>       const IOMMUAccessFlags req_perm =3D iotlb->perm;
> @@ -424,6 +426,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>           const dma_addr_t pte_addr =3D base + idx * sc[pass].ptesize;
>           const bool ade =3D
>               ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_T=
C_SADE);
> +        /*
> +         * G-stage accesses to S-stage page tables are implicit reads.
> +         * The original DMA permission is used for the final data access=
.
> +         */
> +        const bool implicit_read =3D
> +            pass =3D=3D G_STAGE && en_s && sc[S_STAGE].step !=3D sc[S_ST=
AGE].levels;
> +        const IOMMUAccessFlags acc_perm =3D
> +            implicit_read ? IOMMU_RO : req_perm;
>  =20
>           if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
>               /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
> @@ -442,15 +452,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>                   masked_msbs =3D (addr >> (va_len - 1)) & mask;
>  =20
>                   if (masked_msbs !=3D 0 && masked_msbs !=3D mask) {
> -                    return (req_perm & IOMMU_WO) ?
> -                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
> -                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
> +                    goto page_fault;
>                   }
>               } else {
>                   if ((addr & va_mask) !=3D addr) {
> -                    return (req_perm & IOMMU_WO) ?
> -                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> -                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
> +                    goto page_fault;
>                   }
>               }
>           }
> @@ -499,13 +505,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>                * non-user mode leaf PTE and !pv we need to fault.
>                */
>               break;
> -        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
> +        } else if ((acc_perm & IOMMU_RO) && !(pte & PTE_R)) {
>               break;                /* Read access check failed */
> -        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
> +        } else if ((acc_perm & IOMMU_WO) && !(pte & PTE_W)) {
>               break;                /* Write access check failed */
>           } else if (!ade && !(pte & PTE_A)) {
>               break;                /* Access bit not set */
> -        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
> +        } else if ((acc_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
>               break;                /* Dirty bit not set */
>           } else if (pass =3D=3D G_STAGE && !(pte & PTE_U)) {
>               /*
> @@ -587,13 +593,22 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>           }
>       } while (1);
>  =20
> +page_fault:
>       /*
>        * riscv_iommu_translate() will receive a fault and then call
> -     * riscv_iommu_report_fault() using iotlb->translated_addr
> -     * as iotval2.  Update translated_addr it with the latest
> -     * translated addr we have.
> +     * riscv_iommu_report_fault() using fault_iotval2 as iotval2.
> +     * Update fault_iotval2 with the latest translated address.
> +     * For guest-page faults, set the implicit first-stage
> +     * page-table access flag in the low bit.
>        */
> -    iotlb->translated_addr =3D addr;
> +    *fault_iotval2 =3D addr;
> +
> +    if (pass =3D=3D G_STAGE) {
> +        bool implicit_read =3D
> +            en_s && sc[S_STAGE].step !=3D sc[S_STAGE].levels;
One nit pick:
Duplicated `implicit_read` declaration and computation.

Suggest to declare `implicit_read`=C2=A0 within function scope.
Like:
 =C2=A0 =C2=A0 =C2=A0const IOMMUAccessFlags req_perm =3D iotlb->perm;
+=C2=A0 =C2=A0 bool implicit_read;
 =C2=A0 =C2=A0 =C2=A0...
 =C2=A0 =C2=A0 =C2=A0do {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 implicit_read =3D
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass =3D=3D G_STAGE && en_s &&
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc[S_STAGE].step !=3D sc[S_STAGE=
].levels;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
 =C2=A0 =C2=A0 =C2=A0} while (1);

 =C2=A0page_fault:
 =C2=A0 =C2=A0 =C2=A0*fault_iotval2 =3D addr;
 =C2=A0 =C2=A0 =C2=A0if (pass =3D=3D G_STAGE) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*fault_iotval2 =3D (addr & ~3ULL) | (imp=
licit_read ? 1 : 0);
 =C2=A0 =C2=A0 =C2=A0}

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +        *fault_iotval2 =3D (addr & ~3ULL) |
> +                         (implicit_read ? 1 : 0);
> +    }
>  =20
>       return (req_perm & IOMMU_WO) ?
>                   (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> @@ -1740,6 +1755,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>       bool enable_pri;
>       hwaddr phys =3D 0;
>       int fault;
> +    uint64_t fault_iotval2 =3D 0;
>  =20
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
>  =20
> @@ -1776,7 +1792,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
>  =20
>       /* Translate using device directory / page table information. */
> -    fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
> +    fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb, &fault_iotval2);
>  =20
>       if (!fault && iotlb->target_as =3D=3D &s->trap_as) {
>           /* Do not cache trapped MSI translations */
> @@ -1827,7 +1843,7 @@ done:
>           }
>  =20
>           riscv_iommu_report_fault(s, ctx, ttype, fault, enable_pid,
> -                                 iotlb->iova, iotlb->translated_addr);
> +                                 iotlb->iova, fault_iotval2);
>           return fault;
>       }
>

