Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC9AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 00:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfRRq-00077F-HG; Thu, 02 Jul 2026 20:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfRRl-00076K-MZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:07:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfRRj-0008Dv-FZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:07:57 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so40771a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 17:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783037271; cv=none;
 d=google.com; s=arc-20260327;
 b=pQppTGZYPQ8zOgDCMQAC7/ep+7RjYS7qKXlo8VylxgSp642btZ5r3SChZkYsGREDEm
 yWlXAXtCojrSsC874b9fBWdOvJZyFLsVo1GoVI+8TtXf1RVVhsmbwDSkSuagHOz6bGZR
 dCybdpg/NrZctXCaHoGoyMdU2P/3RPVYjtbNw8NMWCS+ziWazUmE7k/AZAx066hZSMl5
 64Gv9ZpLStaLKqV/sXpdSmZ/qP63bOyFnxeQw2vjl//FYbD8wKJQXCBpF6j35PhBtIgY
 uRYPXIQwPu+c6HnLp7m9cNU3oZkDCtgKRAhiS7OlvwnHj229spmHHhSYKjsqVlGMxvAb
 0Qkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LsIVRyBGuModU7s/j97tfSkR9yWnGQ92IQpv7UDlGpI=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=nuBBk110hdXt0KUzCuzG7UQKWnepks7usQPI9GAFw2djQt3y+1NWzoQTe+9OZLbmmZ
 4gxTDx1J5IKBLtL09o33Pp7rFUwRpHpgnR5fzc4fWDq52yoVZa1ECFfbfcCIxEuXZJmM
 o8gSH+4GzMATDVitfif5iyiJN+xTM8Eh8SLCqrG11jrIwla+BkGlYslHW2UjXrDmgak+
 j0otSMDj9rAg2XXyYGU90GMyjInsV+5uh2iAeETEaB1AzedqT89Lr0VLoLZhvo+QkUzL
 1W1ehMa+LNqDBQoGVc+f1sMaAqoS72pwNzXDm9HwRLaTPytEJFv6nlrtFlfO/Kk+oNUF
 HYzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783037271; x=1783642071; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsIVRyBGuModU7s/j97tfSkR9yWnGQ92IQpv7UDlGpI=;
 b=O6+kS37ZM+irrN4FTqBghlBu4AsRsRp+Awy8HvYLYlbTTlvZLoltfp5SLnVym3Ey0o
 gkirFmjw1F76djwRgvaiqnfJVRdmk2dB7tke7AJE+pI5UTu0P0BLMhKtmS+SU8y360NT
 sFmRz8h7jaah/NrQCjXxp5yLLmmurEFLUE6Rrt0OW5kYqUegluFp1FGyephbwee3pkat
 1KkoRWTgAJjgzEd2wMGkANjO/VOUI5onwXybHQfItSKjqcwjXhVJU6/0buu/1aoKFBWq
 aKSc/LrmwoPiHXaUzdhVUmHRbC0mM2pDuqErYH7btElTdZHj2dFpRFWvM0Ys6OiOzM2C
 e5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783037271; x=1783642071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LsIVRyBGuModU7s/j97tfSkR9yWnGQ92IQpv7UDlGpI=;
 b=MiZ45y1Xwxu2VrAcnh7J4oB06h4j9SlsNewzQe26gvue0GFMHWBK6hMzLEl3YoV/Wu
 vHQjLUfvmDOmHty/JCgPhBjB60OIStP2UsOhvOZ7emesIpOIXIl/dRj5JvpidIXd+Zjg
 siTc0+zlwjaIznM2mktTs3Mio4L1gABC6F8PAkrO2zIIbGiZDaiFwWxQPSuNCds0RXmb
 xEmfDtkSvbJMmnWqN92gl2mID0+opNMfHVhghEu28Ky3ECa3I+HfW8k93Rc2f9mouCvj
 682d3RCSe0FEoFA0NDCgjdjmx1AEHTpyeBxcqK25nhymnipD57ZVZD4s+CP2aT1Y/GI7
 DiuA==
X-Gm-Message-State: AOJu0Yxch7YuAMcnJ+dhgi9+9Ug4Qjyi0QQV5sRagF+uAQb/gPRC/OCo
 vKq4uuvpkT2fGodNk4BbntCDG2aac0GYvBiRd8Rvnp473UMz9OxWporfwEAujfLlc71xnNLUT9E
 qRTi8gY1qrSqnsqSAah8m3k3dJSkUh78=
X-Gm-Gg: AfdE7cmkaArImxrJKgrJS2VWm0sa2CrTYWjsn9Scf3CRhJvPrmp16wp9OaNalIRo6U1
 Q3hdCKEGOVCw0dU9NcCkGYmYD35pMsIxX2Xv3t0Y2VjX7k5wxWIWgEQqsy7F6SIxDflzKaIneX+
 C65bgkcxTgbMcU5ztk89yAGgbLwvaCXrluwMyjH2u0X2bjYAj3pXcX27ZO6sSX4bpQX5LxnhxwB
 ujYAGukkGV7h0v3d9aT+CaMv2+1/wzdDMa8kBP2/1RNjQm4kz4VwABNhp7lYSx+JfvpDKuB1Kk+
 26SigHmcQiezVw9os0vCvoLThNu/etGJjt3vcw==
X-Received: by 2002:a05:6402:11cb:b0:698:480b:2dd1 with SMTP id
 4fb4d7f45d1cf-6989f2f2915mr3730818a12.13.1783037271076; Thu, 02 Jul 2026
 17:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260701124034.552271-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260701124034.552271-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Jul 2026 10:07:24 +1000
X-Gm-Features: AVVi8Cc5PadjDBb9dMRS-7BQketjGIFwWX8MV3dRu7ug6pA-cNtFcyQAP9PFAd8
Message-ID: <CAKmqyKP=9gTF4DdvXHLJCO7Lbor-=mC1K7+14yxUDxA1a=8meA@mail.gmail.com>
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

