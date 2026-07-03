Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2BFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTS4-0001TC-QF; Thu, 02 Jul 2026 22:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfTRy-0001SV-CO
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:16:18 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfTRv-0008Gq-5q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:16:17 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so171368a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 19:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783044973; cv=none;
 d=google.com; s=arc-20260327;
 b=htjxT5Kbr+8DGWXmTmGqlgPBRTA6ARCJQxafpwU4/9ui1KFqNtWGDmFSo2QhPEMJ99
 t9kKcoj9JFOw9e03GkeqwTl2fBLQ2pPSUFK9fe2yimKuyzzyOxTLn6uIa/L4nHjjQvMU
 jAT7NsMvV/jzkCNeBkr1gq0GpPZVqbJZoJJQjp05UbRYJfBx7F4UqVWBvmwxp0wIjM4T
 1UVYJhTw5A3RFnK/dmljlTMUEOS3QGUgrOHwgG8fNoHVdkjBOpfV+v2dvJpqOP9W2QKt
 O9uMubpIz18SGNOb1Abs4fTm4wMcb8k/dLTKIEAAl1xO3lnMXDkRf4DlZDhnAs0FbYbA
 GELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hi3BG2S4Oq2JxEk9R6XNSK8TycyPNIWjCMmsfwGzv9U=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=ZtI/qLQEYVsrNgfIFWkG4msc5EqFp4fhbEPDcdbf/YWpBmyZMjn8sOJCBcvblzNcGB
 zbDD0vKexTh11vuSUCOt5rZArE4IGhj+wC/7BiziPaGBlThXCgLOfJY9yQ9bLJIvZxWU
 Doz06aJWcdqJez+8tGWbAL1q8J+aTYLFVAPVgBr9kKMP2I3FnxL3pLBmlaZhnuZeI5/U
 R47FC76XC5eCfCLFgb0+m5n6YOwJrnONE1yHWrfB8gaoF+Trvd/I12JrfMNTg4zSxxgV
 Qqhs2Ju0FPFVe/ajmLeLT3w7awlHJ0iL2QsELHUM7qFFU0hp24gT2DqZ4tccnofHiHwp
 3YYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783044973; x=1783649773; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi3BG2S4Oq2JxEk9R6XNSK8TycyPNIWjCMmsfwGzv9U=;
 b=RE18Eh+NJSQjdRosjdurdNruQ08k0iUZSlDPkDc+QffVD0/vBeD34S4cyEc3xgLfBD
 WHOq9GwfEjadDq1bEHddWt1aIm5u/yr/ZJ32iihtARhJ8vQTdhUjpakQHsWdWgrd9jxi
 erBvEhwT99mURuuHlI/JxfZuWhFUtq3/3K/Vwc0tR2h8573GpY9CmVAP8VjohZFVXotZ
 dE5KUsUqfVeakEL6Vihw1wkqhhb3l5dTK0vuxjvBPoCTj0+Os0BnlrkwdA5Zn84ZPuz/
 gHjzbyQpoArw/dHagDL+LFgaMebh5EyrQzI1uJ77Uqr4wu8y9jY0/YZVeoG7YT8DHcN3
 hqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783044973; x=1783649773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hi3BG2S4Oq2JxEk9R6XNSK8TycyPNIWjCMmsfwGzv9U=;
 b=YOdl7LACdRDeni9sly6Zc/mF7AJbqNMegfRD5KgsMfnI8AdhDyCZKXB1uZyN3Gx9M+
 Noeg2tDQsWdFJY6lWUT+IpQ/tyDXWUXRskMdzcG54VnAM0fbtuLffJZISQw0GFFkptIr
 3JnrwB3oC8F7lwcN0x5UKzcP8golM2tjUWIXbq+QAwOUsbuHiAgm6B/Qi4HJSHIJnUPJ
 WkerjvjwMoBcRrnpODs41434oQF263zSGBNW6vHKDBVHs4J4wO2bDmaTBTytuMMkzhhY
 kYpdYkfwmEuE9lAFtX3wZ8yLAuEUGrHHUd+e5X/vzfSjrVPJJkWJ0h1KJzHV1CXsseZ2
 kVZg==
X-Gm-Message-State: AOJu0YxvBND3fV17Glf4HX5kpYBKq8AOP7GSE0sRXHpnjYvGXqeU9+Q/
 qT5CQ38yNqca9zKRZakWqkVUwxP+2Qv9HSuIAii0xagHqlYkfQdR1vSTM3EKFt/i+DrvQgt3lQZ
 J0Wc7FnfF9ikJf/lOS4OU3E/Sse5qifw=
X-Gm-Gg: AfdE7clKOln/fp5JjFCARsyMkI7U89q2lkID+se6kmQlufIRP/qYj5qK2FKd52LvAaX
 Z7kmIbMP9RtU7Ijz5YRHIKLi2zzQinoE/yUwU+GRLzQkJuiMtluwGIZliVn/m9N8CPOuJzXn5cE
 rQvE8q6DEngLwtm5rsmUqnL6ae923yAg95kWHxv1O5kxKOMkbm/1v5LzRZrXT5evcepxvsig+TP
 78ycBsMT2tAlAUkZcUyshSte4rthcF6/9nUJ2YuMmpAk3UFmpYQD+iv00E/RYUEzifVUv6QWVfy
 44YGAOqlbk2LMDutU6e1pA0mBbI=
X-Received: by 2002:aa7:cd75:0:b0:698:aeaf:2d9 with SMTP id
 4fb4d7f45d1cf-698c1039a8amr611045a12.2.1783044972587; Thu, 02 Jul 2026
 19:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260701124034.552271-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260701124034.552271-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Jul 2026 12:15:44 +1000
X-Gm-Features: AVVi8CdRN8JpEpdu-8OGjC9yOJHwoMtShyYL0ewZLKP3dioqEOfRzznMAYzFzP4
Message-ID: <CAKmqyKPTWMmO4p0Rc1rfinDc0vP-JQkrR5X3UPkEuwvmv1dXjQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: fix fault type for spa_fetch()
 faults
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 1, 2026 at 10:41=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Under certain circunstances, like the one described in [1] and [2],
> a read operation that faults will be logged as a write fault instead,
> and vice-versa, if they happen after the translation phase in
> riscv_iommu_spa_fetch().
>
> The first problem is that we're overwriting iotlb->perm with PTE flags,
> so an IOMMU_RO access flag can be overwritten by whatever flags
> the PTE has.  This will cause the wrong fault type to be thrown at
> the end of the function in case a fault happens.
>
> To solve the iotlb->perm overwrite we'll bit_and the original
> iotlb->perm access flags with the PTE access flags, preserving the
> original access type.  So a IOMMU_RO access in a R+W PTE will result in
> a IOMMU_RO perm.
>
> Second, the resulting fault is received by riscv_iommu_translate(), which
> will then report the fault.  To do that we require a transaction type
> (ttype).  We're prioritizing checking "perm & IOMMU_RW" to set a
> UADDR_WR ttype, and then checking "perm & IOMMU_RO" to set UADDR_RD
> ttype.  The issue with that is IOMMU_RO=3D1 and IOMMU_RW=3D3, thus checki=
ng
> "perm & IOMMU_RW" for a write then "perm & IOMMU_RO" for a read will
> cause the read fault to always be diagnosed as write.
>
> Make the iotlb->perm matches more strict: "perm & IOMMU_RW" must be
> exactly IOMMU_RW, ensuring that 'perm' has both flags.  Then we can
> check perm & IOMMU_WO and perm & IOMMU_RO without worrying about
> overlapping with the RW flag.
>
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3557
> [2] https://gitlab.com/qemu-project/qemu/-/work_items/3577
>
> Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3557
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3577
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 974042d017..7f94ce152e 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -282,6 +282,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn,=
 hwaddr addr, hwaddr *out)
>  static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
>      IOMMUTLBEntry *iotlb)
>  {
> +    IOMMUAccessFlags pte_perm;
>      dma_addr_t addr, base;
>      uint64_t satp, gatp, pte;
>      bool en_s, en_g;
> @@ -509,8 +510,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>              }
>              /* Translation phase completed (GPA or SPA) */
>              iotlb->translated_addr =3D base;
> -            iotlb->perm =3D (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : =
IOMMU_WO)
> -                                                         : IOMMU_RO;
> +
> +            /*
> +             * Do a bit_and between the PTE bits and the original
> +             * request flags to determine the exact permission we
> +             * need, i.e. if the original request is RO and the
> +             * PTE has RW flags the actual perm is RO.
> +             */
> +            pte_perm =3D (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOM=
MU_WO)
> +                                     : IOMMU_RO;
> +            iotlb->perm &=3D pte_perm;
>
>              /* Check MSI GPA address match */
>              if (pass =3D=3D S_STAGE && (iotlb->perm & IOMMU_WO) &&
> @@ -1727,7 +1736,8 @@ done:
>      if (fault) {
>          unsigned ttype =3D RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ;
>
> -        if (iotlb->perm & IOMMU_RW) {
> +        if ((iotlb->perm & IOMMU_RW) =3D=3D IOMMU_RW
> +            || iotlb->perm & IOMMU_WO) {
>              ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
>          } else if (iotlb->perm & IOMMU_RO) {
>              ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
> --
> 2.43.0
>
>

