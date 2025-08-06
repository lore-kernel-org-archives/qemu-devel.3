Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25411C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 14:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujf0Q-0007jl-0U; Wed, 06 Aug 2025 10:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1ujezj-0007Ms-7d; Wed, 06 Aug 2025 10:19:56 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1ujezf-0005m5-SA; Wed, 06 Aug 2025 10:19:54 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae9c2754a00so1595753266b.2; 
 Wed, 06 Aug 2025 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754489989; x=1755094789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kiB9/CR9FZaA8vjWm2cyjJCURhQDb1/QrMBZE15e/Sg=;
 b=V8/l34bn9nv0HfNR77EJaPJwfs/GL6munG4aKP3GzBF9FwP0mhPn3vfWJcr/KEpSbH
 pHh0papc87lRtWsCLkwwNnpkxE2npLYOgjq38ZjrVtuxDy2b82HwPwBdgIElLxRDwvI5
 Z/Nde29Jy0vfGB38Q25octOPGGqL3pvcmiCTSWehoSOQewfiTahwHFHPITsvjuLFrtyW
 quoWbMYAJbukhujoYKGFflSYklwGpI2wIGdfFCruknt3AJzrhbHyaNeAmqezaJ3XWsJW
 IdR7QJJJXaZfisFQe2z1W523CyBMKN/FkVejTPmhsGx6Qzaaz1mIXM7ckYLe50OkoZYp
 lY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754489989; x=1755094789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kiB9/CR9FZaA8vjWm2cyjJCURhQDb1/QrMBZE15e/Sg=;
 b=b/6Y2t//5Rx3+djkx+DZWtBXOfdLFnE23ze2YjquAjnExATn/yMR+X/+R4vIn4QUtC
 eRaCTcGFNZRSwdtQB9OCFTM6Dz9YpG/+KOMrTul4pzulthHxBt4qmO5bRmIDc1RLcQE7
 WlPc5mBSpT/0fmXDdqud0yzKCdtxyuWPfBdVtlvl/5O5z7buwg6C31pyCMumqoaz/Qmv
 P+pCJBNbAn1Nx8Pqme0kmdDoJcyYBnNue4bPqLH4yKi6Osym/rfUVGW/xtHK9EoH4zXK
 hdw6Z6YRZ25FKZaS0l1eqcsekP13P434KAXWBEV93WzP5FgM5ET+EHie7eBG2MNm3dcs
 qg4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURTyQFwPo/rW/9GTEuol9AvAfHhULJKzoopB2h2kkYDSVgZ860yLZa6brMIKVJDVJt+VTcrdK6iPBJ@nongnu.org,
 AJvYcCWD0DERxRVSgqqWnzV3kv3epjUh85zXthAHwBWnA6KeLnsqRQUJwvOEWiB2n5iox5OgZaZQeUBLzUr0ig==@nongnu.org,
 AJvYcCWknHRKEWBOpiLWkRE2MO4ajYXRH1ByGdkQZflLfEc8MrVNAeBTa1jvsLeDPdLx28XVq1Vo0Xtuu9RN7dk=@nongnu.org
X-Gm-Message-State: AOJu0Yx9aT8H1N2OgoWukAwZ7Fx14J+RDCRN67p1eQuy/uqQ9wdwozLN
 HFT1pHPMZZ3enRl9i6HXeLUwwlEbNV1C0536VdOp924G/ocUzQMJsgrg9Uz+ffuyiT6uVMFSz8Z
 oxgMVJk+jxpvb1FQvim+ndiH2zv+i/wA=
X-Gm-Gg: ASbGnctdQYLkn1Y+9JuE7ER7gkBSL7Ol2/xzPoTt2wXojA4mQh+SUb8OfhIORg71ceU
 2AvrAu0p+cIeneY8BCLLqnusBxslLEhDOIs5GvcawOMzZ9jH2y2cJBxZBpwt5yxYpPMc2UY85do
 S9KNW7uGFN6xb76QXbz93USFP/modbbEYBkk/sSZ9lzINvcdrICI0ImKrWG48Tfikm8m8v0YQ9j
 bCMczyHRUI1FFOgXYE=
X-Google-Smtp-Source: AGHT+IFrDbrpCzcZgHV4pBiyROCV0OAlX7z20UzYmzmjRPPjvGp/4yin59RDH4Y/oKSCXYqVfhe0Thybd3n6+pGPorQ=
X-Received: by 2002:a17:906:ef0a:b0:ae6:c9b3:57cb with SMTP id
 a640c23a62f3a-af990108b04mr299342866b.5.1754489988865; Wed, 06 Aug 2025
 07:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250804171238.354493-1-guoren@kernel.org>
In-Reply-To: <20250804171238.354493-1-guoren@kernel.org>
From: wei li <liwei1518@gmail.com>
Date: Wed, 6 Aug 2025 22:19:36 +0800
X-Gm-Features: Ac12FXxS0CCPEx5sYpNjMRzYkwCF6mflO_4ebjR3tz9fdRsfOd4NcxDmTjx1p34
Message-ID: <CADCiS9+FkT2pQCTOjm-=jbtwGVJqj7Rs-axdLUBg19H_BdgJdw@mail.gmail.com>
Subject: Re: [PATCH V2] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
To: guoren@kernel.org
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com, seb@rivosinc.com, 
 tjeznach@rivosinc.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008c61aa063bb308b1"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=liwei1518@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000008c61aa063bb308b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<guoren@kernel.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=885=E6=97=A5=E5=91=A8=E4=
=BA=8C 01:12=E5=86=99=E9=81=93=EF=BC=9A

> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Current implementation is wrong when iohgatp !=3D bare. The RISC-V
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
>  - Remove nested param to make patch clearer.
>
>  hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 2 deletions(-)
>
> LGTM.

*"3.3.2. Process to locate the Process-context*

*
The device-context provides the PDT root page PPN (pdtp.ppn). When
DC.iohgatp.mode is not
*

*
Bare, pdtp.PPN as well as pdte.PPN are Guest Physical Addresses (GPA)
which must be translated
*

*
into Supervisor Physical Addresses (SPA) using the second-stage page
table pointed to by
*

*
DC.iohgatp. The memory accesses to the PDT are treated as implicit
read memory accesses by the
*

* second-stage."*

Reviewed-by: Weiwei Li <liwei1518@gmail.com>

Regards,

Weiwei Li


diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 96a7fbdefcf3..ded3f7b2fdce 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -866,6 +866,143 @@ static bool
> riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
>      return true;
>  }
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
> +    dma_addr_t base =3D addr;
> +
> +    /* G stages translation mode */
> +    gatp_mode =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    if (gatp_mode =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE)
> +        goto out;
> +
> +    /* G stages translation tables root pointer */
> +    base =3D PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
> +
> +    /* Start at step 0 */
> +    sc.step =3D 0;
> +
> +    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
> +        /* 32bit mode for GXL =3D=3D 1 */
> +        switch (gatp_mode) {
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 2;
> +            sc.ptidxbits =3D 10;
> +            sc.ptesize   =3D 4;
> +            break;
> +        default:
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +    } else {
> +        /* 64bit mode for GXL =3D=3D 0 */
> +        switch (gatp_mode) {
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 3;
> +            sc.ptidxbits =3D 9;
> +            sc.ptesize   =3D 8;
> +            break;
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 4;
> +            sc.ptidxbits =3D 9;
> +            sc.ptesize   =3D 8;
> +            break;
> +        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +            sc.levels    =3D 5;
> +            sc.ptidxbits =3D 9;
> +            sc.ptesize   =3D 8;
> +            break;
> +        default:
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +    }
> +
> +    do {
> +        const unsigned va_bits =3D (sc.step ? 0 : 2) + sc.ptidxbits;
> +        const unsigned va_skip =3D TARGET_PAGE_BITS + sc.ptidxbits *
> +                                 (sc.levels - 1 - sc.step);
> +        const unsigned idx =3D (addr >> va_skip) & ((1 << va_bits) - 1);
> +        const dma_addr_t pte_addr =3D base + idx * sc.ptesize;
> +
> +        /* Address range check before first level lookup */
> +        if (!sc.step) {
> +            const uint64_t va_mask =3D (1ULL << (va_skip + va_bits)) - 1=
;
> +            if ((addr & va_mask) !=3D addr) {
> +                return MEMTX_ACCESS_ERROR;
> +            }
> +        }
> +
> +        /* Read page table entry */
> +        if (sc.ptesize =3D=3D 4) {
> +            uint32_t pte32 =3D 0;
> +            ret =3D ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
> +            pte =3D pte32;
> +        } else {
> +            ret =3D ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
> +        }
> +        if (ret !=3D MEMTX_OK)
> +            return ret;
> +
> +        sc.step++;
> +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> +
> +        if (!(pte & PTE_V)) {
> +            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D PTE_W) {
> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W
> */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D (PTE_W | PTE_X=
)) {
> +            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W
> + PTE_X */
> +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
> +            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> +            base =3D PPN_PHYS(ppn); /* Inner PTE, continue walking */
> +        } else {
> +            /* Leaf PTE, translation completed. */
> +            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            break;
> +        }
> +
> +        if (sc.step =3D=3D sc.levels) {
> +            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
> +        }
> +    } while (1);
> +
> +out:
> +    return dma_memory_read(s->target_as, base, buf, len, attrs);
> +}
> +
>  /*
>   * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
>   *
> @@ -1038,7 +1175,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
,
> RISCVIOMMUContext *ctx)
>           */
>          const int split =3D depth * 9 + 8;
>          addr |=3D ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
> -        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
>                              MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>              return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>          }
> @@ -1053,7 +1190,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s=
,
> RISCVIOMMUContext *ctx)
>
>      /* Leaf entry in PDT */
>      addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
> -    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2=
,
> +    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
>                          MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
>          return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>      }
> --
> 2.40.1
>
>

--0000000000008c61aa063bb308b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">&lt;<a href=3D"=
mailto:guoren@kernel.org">guoren@kernel.org</a>&gt; =E4=BA=8E2025=E5=B9=B48=
=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=8C 01:12=E5=86=99=E9=81=93=EF=BC=9A<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">From: &quot;Guo Ren =
(Alibaba DAMO Academy)&quot; &lt;<a href=3D"mailto:guoren@kernel.org" targe=
t=3D"_blank">guoren@kernel.org</a>&gt;<br>
<br>
Current implementation is wrong when iohgatp !=3D bare. The RISC-V<br>
IOMMU specification has defined that the PDT is based on GPA, not<br>
SPA. So this patch fixes the problem, making PDT walk correctly<br>
when the G-stage table walk is enabled.<br>
<br>
Fixes: 0c54acb8243d (&quot;hw/riscv: add RISC-V IOMMU base emulation&quot;)=
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Cc: Sebastien Boeuf &lt;<a href=3D"mailto:seb@rivosinc.com" target=3D"_blan=
k">seb@rivosinc.com</a>&gt;<br>
Cc: Tomasz Jeznach &lt;<a href=3D"mailto:tjeznach@rivosinc.com" target=3D"_=
blank">tjeznach@rivosinc.com</a>&gt;<br>
Signed-off-by: Guo Ren (Alibaba DAMO Academy) &lt;<a href=3D"mailto:guoren@=
kernel.org" target=3D"_blank">guoren@kernel.org</a>&gt;<br>
---<br>
Changes in V2:<br>
=C2=A0- Remove nested param to make patch clearer.<br>
<br>
=C2=A0hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++=
-<br>
=C2=A01 file changed, 139 insertions(+), 2 deletions(-)<br>
<br></blockquote><div>LGTM.=C2=A0=C2=A0</div><div><br></div><div><i>&quot;3=
.3.2.=C2=A0Process=C2=A0to=C2=A0locate=C2=A0the=C2=A0Process-context</i></d=
iv>
<p><i>
The=C2=A0device-context=C2=A0provides=C2=A0the=C2=A0PDT=C2=A0root=C2=A0page=
=C2=A0PPN=C2=A0(pdtp.ppn).=C2=A0When=C2=A0DC.iohgatp.mode=C2=A0is=C2=A0not
</i></p><p><i>
Bare,=C2=A0pdtp.PPN=C2=A0as=C2=A0well=C2=A0as=C2=A0pdte.PPN=C2=A0are=C2=A0G=
uest=C2=A0Physical=C2=A0Addresses=C2=A0(GPA)=C2=A0which=C2=A0must=C2=A0be=
=C2=A0translated
</i></p><p><i>
into=C2=A0Supervisor=C2=A0Physical=C2=A0Addresses=C2=A0(SPA)=C2=A0using=C2=
=A0the=C2=A0second-stage=C2=A0page=C2=A0table=C2=A0pointed=C2=A0to=C2=A0by
</i></p><p><i>
DC.iohgatp.=C2=A0The=C2=A0memory=C2=A0accesses=C2=A0to=C2=A0the=C2=A0PDT=C2=
=A0are=C2=A0treated=C2=A0as=C2=A0implicit=C2=A0read=C2=A0memory=C2=A0access=
es=C2=A0by=C2=A0the
</i></p><p><i>
second-stage.&quot;</i></p><p>Reviewed-by:=C2=A0<span style=3D"color:rgb(0,=
0,0)">Weiwei Li &lt;<a href=3D"mailto:liwei1518@gmail.com">liwei1518@gmail.=
com</a>&gt;</span></p><p><span style=3D"color:rgb(0,0,0)">Regards,</span></=
p><p><span style=3D"color:rgb(0,0,0)">Weiwei Li</span></p><p><span style=3D=
"color:rgb(0,0,0)"><br></span></p><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c<br>
index 96a7fbdefcf3..ded3f7b2fdce 100644<br>
--- a/hw/riscv/riscv-iommu.c<br>
+++ b/hw/riscv/riscv-iommu.c<br>
@@ -866,6 +866,143 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOM=
MUState *s,<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
+/**<br>
+ * pdt_memory_read: PDT wrapper of dma_memory_read.<br>
+ *<br>
+ * @s: IOMMU Device State<br>
+ * @ctx: Device Translation Context with devid and pasid set<br>
+ * @addr: address within that address space<br>
+ * @buf: buffer with the data transferred<br>
+ * @len: length of the data transferred<br>
+ * @attrs: memory transaction attributes<br>
+ */<br>
+static MemTxResult pdt_memory_read(RISCVIOMMUState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUContext *ctx,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buf, dma_addr_t l=
en,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs attrs)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t gatp_mode, pte;<br>
+=C2=A0 =C2=A0 struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char step;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char levels;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char ptidxbits;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char ptesize;<br>
+=C2=A0 =C2=A0 } sc;<br>
+=C2=A0 =C2=A0 MemTxResult ret;<br>
+=C2=A0 =C2=A0 dma_addr_t base =3D addr;<br>
+<br>
+=C2=A0 =C2=A0 /* G stages translation mode */<br>
+=C2=A0 =C2=A0 gatp_mode =3D get_field(ctx-&gt;gatp, RISCV_IOMMU_ATP_MODE_F=
IELD);<br>
+=C2=A0 =C2=A0 if (gatp_mode =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+<br>
+=C2=A0 =C2=A0 /* G stages translation tables root pointer */<br>
+=C2=A0 =C2=A0 base =3D PPN_PHYS(get_field(ctx-&gt;gatp, RISCV_IOMMU_ATP_PP=
N_FIELD));<br>
+<br>
+=C2=A0 =C2=A0 /* Start at step 0 */<br>
+=C2=A0 =C2=A0 sc.step =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;fctl &amp; RISCV_IOMMU_FCTL_GXL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 32bit mode for GXL =3D=3D 1 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (gatp_mode) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(s-&gt;cap &amp; RISCV_IOMM=
U_CAP_SV32X4)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCES=
S_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.levels=C2=A0 =C2=A0 =3D 2;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptidxbits =3D 10;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptesize=C2=A0 =C2=A0=3D 4;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCESS_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 64bit mode for GXL =3D=3D 0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (gatp_mode) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(s-&gt;cap &amp; RISCV_IOMM=
U_CAP_SV39X4)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCES=
S_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.levels=C2=A0 =C2=A0 =3D 3;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptidxbits =3D 9;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptesize=C2=A0 =C2=A0=3D 8;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(s-&gt;cap &amp; RISCV_IOMM=
U_CAP_SV48X4)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCES=
S_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.levels=C2=A0 =C2=A0 =3D 4;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptidxbits =3D 9;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptesize=C2=A0 =C2=A0=3D 8;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(s-&gt;cap &amp; RISCV_IOMM=
U_CAP_SV57X4)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCES=
S_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.levels=C2=A0 =C2=A0 =3D 5;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptidxbits =3D 9;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.ptesize=C2=A0 =C2=A0=3D 8;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCESS_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned va_bits =3D (sc.step ? 0 : 2) +=
 sc.ptidxbits;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned va_skip =3D TARGET_PAGE_BITS + =
sc.ptidxbits *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sc.levels - 1 - sc.step);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned idx =3D (addr &gt;&gt; va_skip)=
 &amp; ((1 &lt;&lt; va_bits) - 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const dma_addr_t pte_addr =3D base + idx * sc.=
ptesize;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Address range check before first level look=
up */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!sc.step) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint64_t va_mask =3D (1ULL=
 &lt;&lt; (va_skip + va_bits)) - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((addr &amp; va_mask) !=3D ad=
dr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCES=
S_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read page table entry */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sc.ptesize =3D=3D 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pte32 =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ldl_le_dma(s-&gt;target_=
as, pte_addr, &amp;pte32, attrs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte =3D pte32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ldq_le_dma(s-&gt;target_=
as, pte_addr, &amp;pte, attrs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D MEMTX_OK)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc.step++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr ppn =3D pte &gt;&gt; PTE_PPN_SHIFT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(pte &amp; PTE_V)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCESS_ERROR; /* In=
valid PTE */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((pte &amp; (PTE_R | PTE_W | PTE_X))=
 =3D=3D PTE_W) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCESS_ERROR; /* Re=
served leaf PTE flags: PTE_W */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((pte &amp; (PTE_R | PTE_W | PTE_X))=
 =3D=3D (PTE_W | PTE_X)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCESS_ERROR; /* Re=
served leaf PTE flags: PTE_W + PTE_X */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ppn &amp; ((1ULL &lt;&lt; (va_skip =
- TARGET_PAGE_BITS)) - 1)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCESS_ERROR; /* Mi=
saligned PPN */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!(pte &amp; (PTE_R | PTE_W | PTE_X)=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D PPN_PHYS(ppn); /* Inner=
 PTE, continue walking */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Leaf PTE, translation complet=
ed. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D PPN_PHYS(ppn) | (addr &=
amp; ((1ULL &lt;&lt; va_skip) - 1));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sc.step =3D=3D sc.levels) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ACCESS_ERROR; /* Ca=
n&#39;t find leaf PTE */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } while (1);<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 return dma_memory_read(s-&gt;target_as, base, buf, len, attr=
s);<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk<b=
r>
=C2=A0 *<br>
@@ -1038,7 +1175,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int split =3D depth * 9 + 8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr |=3D ((ctx-&gt;process_id &gt;&gt; s=
plit) &lt;&lt; 3) &amp; ~TARGET_PAGE_MASK;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dma_memory_read(s-&gt;target_as, addr, &am=
p;de, sizeof(de),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pdt_memory_read(s, ctx, addr, &amp;de, siz=
eof(de),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_IOMMU_FQ_CAUSE=
_PDT_LOAD_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1053,7 +1190,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Leaf entry in PDT */<br>
=C2=A0 =C2=A0 =C2=A0addr |=3D (ctx-&gt;process_id &lt;&lt; 4) &amp; ~TARGET=
_PAGE_MASK;<br>
-=C2=A0 =C2=A0 if (dma_memory_read(s-&gt;target_as, addr, &amp;dc.ta, sizeo=
f(uint64_t) * 2,<br>
+=C2=A0 =C2=A0 if (pdt_memory_read(s, ctx, addr, &amp;dc.ta, sizeof(uint64_=
t) * 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAUL=
T;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div>

--0000000000008c61aa063bb308b1--

