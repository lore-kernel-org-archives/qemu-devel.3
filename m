Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338AFC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZz1-0000VU-Gh; Wed, 06 Aug 2025 04:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1ujZyy-0000Uf-MC
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:58:48 -0400
Received: from sg-1-13.ptr.blmpb.com ([118.26.132.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1ujZyn-00054E-Gi
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754470698;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=KKulyDUcp/MKSScQH30vuFfwgiub77DSBg8m9vS1Qi0=;
 b=qblMZ3AsBjWsgNE70TS7NHtDLVKXXSWT65Jh9Fk+Rhfy1DljuGT1uRtZtJVd7+oK7ZfjzJ
 2hmjztXe0TmSS1tKHeERqjthamRYR49y/jHRcC9KFKeYQiS8uG3pf2tyYHA//mp1f+83km
 INaM1cLQN+3gUburfRpXemfQsHGH9JEVhUEDtDXTgXyI+bPHrmaxAC6qF4Dszd2pv4IeOa
 bqjcPZWXJUAwR9v27/tNykKQ/svyFC3g561cPgqBkB2s2p8fkf9YJ5hdp8QYd6NVJn70H3
 o3PWI3sk5tADQbPt71A5YC+qDlzWx3ZT0/2Qy8Ou/UGRLRjGfgMO6BtHM+XwOQ==
References: <20250804171238.354493-1-guoren@kernel.org>
Content-Transfer-Encoding: 7bit
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Message-Id: <524ac37c-cdd3-4010-aba9-9dacfdd123cc@lanxincomputing.com>
X-Lms-Return-Path: <lba+268931928+7955a0+nongnu.org+liujingqi@lanxincomputing.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Wed, 06 Aug 2025 16:58:15 +0800
In-Reply-To: <20250804171238.354493-1-guoren@kernel.org>
To: <guoren@kernel.org>, <zhiwei_liu@linux.alibaba.com>, 
 <liwei1518@gmail.com>, <alistair.francis@wdc.com>, <seb@rivosinc.com>, 
 <tjeznach@rivosinc.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Date: Wed, 6 Aug 2025 16:58:14 +0800
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH V2] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
Mime-Version: 1.0
Content-Language: en-US
Received-SPF: pass client-ip=118.26.132.13;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-13.ptr.blmpb.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/2025 1:12 AM, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Current implementation is wrong when iohgatp != bare. The RISC-V
> IOMMU specification has defined that the PDT is based on GPA, not
> SPA. So this patch fixes the problem, making PDT walk correctly
> when the G-stage table walk is enabled.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Cc: qemu-stable@nongnu.org
> Cc: Sebastien Boeuf <seb@rivosinc.com>
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
> Changes in V2:
>   - Remove nested param to make patch clearer.
>
>   hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 139 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 96a7fbdefcf3..ded3f7b2fdce 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -866,6 +866,143 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
>       return true;
>   }
>   
> +/**
> + * pdt_memory_read: PDT wrapper of dma_memory_read.
> + *
> + * @s: IOMMU Device State
> + * @ctx: Device Translation Context with devid and pasid set
> + * @addr: address within that address space
> + * @buf: buffer with the data transferred
> + * @len: length of the data transferred
> + * @attrs: memory transaction attributes
> + */
> +static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
> +                                   RISCVIOMMUContext *ctx,
> +                                   dma_addr_t addr,
> +                                   void *buf, dma_addr_t len,
> +                                   MemTxAttrs attrs)
> +{
> +    uint64_t gatp_mode, pte;
> +    struct {
> +        unsigned char step;
> +        unsigned char levels;
> +        unsigned char ptidxbits;
> +        unsigned char ptesize;
> +    } sc;
> +    MemTxResult ret;
> +    dma_addr_t base = addr;
> +
> +    /* G stages translation mode */
> +    gatp_mode = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    if (gatp_mode == RISCV_IOMMU_DC_IOHGATP_MODE_BARE)
> +        goto out;
> +
> +    /* G stages translation tables root pointer */
> +    base = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
> +
> +    /* Start at step 0 */
> +    sc.step = 0;
> +
> +    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
> +        /* 32bit mode for GXL == 1 */
> +        switch (gatp_mode) {
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    = 2;
> +            sc.ptidxbits = 10;
> +            sc.ptesize   = 4;
> +            break;
> +        default:
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +    } else {
> +        /* 64bit mode for GXL == 0 */
> +        switch (gatp_mode) {
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    = 3;
> +            sc.ptidxbits = 9;
> +            sc.ptesize   = 8;
> +            break;
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    = 4;
> +            sc.ptidxbits = 9;
> +            sc.ptesize   = 8;
> +            break;
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    = 5;
> +            sc.ptidxbits = 9;
> +            sc.ptesize   = 8;
> +            break;
> +        default:
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +    }
How about moving the variables of 'gatp_mode', 'base' and 'sc' out of 
this wrapper function ?
Since all of them are the same except for 'sc.step' during the traversal 
of PDT.

Otherwise,
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
> +
> +    do {
> +        const unsigned va_bits = (sc.step ? 0 : 2) + sc.ptidxbits;
> +        const unsigned va_skip = TARGET_PAGE_BITS + sc.ptidxbits *
> +                                 (sc.levels - 1 - sc.step);
> +        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
> +        const dma_addr_t pte_addr = base + idx * sc.ptesize;
> +
> +        /* Address range check before first level lookup */
> +        if (!sc.step) {
> +            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
> +            if ((addr & va_mask) != addr) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +        }
> +
> +        /* Read page table entry */
> +        if (sc.ptesize == 4) {
> +            uint32_t pte32 = 0;
> +            ret = ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
> +            pte = pte32;
> +        } else {
> +            ret = ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
> +        }
> +        if (ret != MEMTX_OK)
> +            return ret;
> +
> +        sc.step++;
> +        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> +
> +        if (!(pte & PTE_V)) {
> +            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W + PTE_X */
> +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
> +            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> +            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
> +        } else {
> +            /* Leaf PTE, translation completed. */
> +            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            break;
> +        }
> +
> +        if (sc.step == sc.levels) {
> +            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
> +        }
> +    } while (1);
> +
> +out:
> +    return dma_memory_read(s->target_as, base, buf, len, attrs);
> +}
> +
>   /*
>    * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
>    *
> @@ -1038,7 +1175,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
>            */
>           const int split = depth * 9 + 8;
>           addr |= ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
> -        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
>                               MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
>               return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>           }
> @@ -1053,7 +1190,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
>   
>       /* Leaf entry in PDT */
>       addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
> -    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
> +    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
>                           MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
>           return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>       }

