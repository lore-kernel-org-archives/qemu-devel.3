Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F04C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenfd-0008WA-F3; Wed, 01 Jul 2026 01:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wenfX-0008Vl-SL
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:39:32 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wenfW-0004QT-11
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:39:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c0868ca8738so41279066b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782884367; cv=none;
 d=google.com; s=arc-20260327;
 b=YBiizNrBtLRPHO6IXZFJmQ4CuKjZxsjmcDp0B/WIYwTiofIPCNEvtMM377RX6as4Pp
 DPTCRk+/ZOFoN+BuK0V3/U9oAiNygcL9tnm3p0XvTskyHYUmjLsVRnzKz1OSs+RQm55r
 TDCY1qcsKiuWwcq7iXMhVvieFGfJ0fiQqDQc5oJAQWgVUm+4JSoHLJiZE1VpGifvMNXS
 WqUjeP9GEz/Loco2/eIEDlSfo08/zQhiJRiNVgxIBWEzv5lPyGWnF0lPAGhPMPznq+5w
 mSrHzwu5qlsMU25zwATxz4H5JxlZ5oZImDv0vTg9GeJnL1K45VqSe5KB0TlcqviFzz0h
 XeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KYp1JzS80HQSdAHxYVhqKVkD15bXuIjv4eeqFTsrsTw=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=IyCoTsGdOVj1unV6nENI73ZHfUuD0PTlu1uOyiUVJ7TVwhcoyrVM7Br1zOKF+NNqB9
 lw4C849bj3G/hY6JUHQT61kYsgLAb5VWN9lvM1S+NIg8GPMyCv4r294in37lREYO6zGG
 Ijv4kVCSGS6C1A7Rvel6+wRwzS2xjXXEBPd+vOauHwlmQgBWZA3yfX31/9Q75iofzPoE
 +MHLWjUOK+0ZV65smPSstcuUm8g27C+Nsv9sKcNG/NhFmLiiCiC9QRWpMkSv9RFZME6q
 7BV/BVMHNwbvO20Z/l8xdC+99pBK9DMWkFJHYWF4VvwmtqXuvRQlDctPcUs1KEKO1Jyx
 uFjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782884367; x=1783489167; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYp1JzS80HQSdAHxYVhqKVkD15bXuIjv4eeqFTsrsTw=;
 b=Bcc2oMzY1KKdtkAvz5rNbBkIOGex0cZJT6yKP0fJjrHUNNq5OfMNRqLFadsGVUgfHf
 WK7WTBDd16rK8XTyLmaiaD2JLc1s9fzLdXEnrtjYvClJm0dKU0i78QuxZsQEMSgOoTTD
 MV7VUlRm8XrHUQ7Z32mKo4EjQ5ggCRYWf/9neYtmb1fLLp2Uhro02X0KYQHTHknQX8lA
 Rd7e9vMSRbx2u2S+XHv1imVG5KZ0GpBg5oW23IEBjB4aRLHM9Z3qc6E7IqHqp7Q2oHk2
 yk2aQwgHFwQVGwTQBifqaUjXQ1vHcO6O+FbQKw0tHh7DYdYsBi1cpYwVEKYwYV5g1qVx
 ivBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782884367; x=1783489167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KYp1JzS80HQSdAHxYVhqKVkD15bXuIjv4eeqFTsrsTw=;
 b=jl+AGQuWcfvQ13TAlSSaMlvjQSPxNrZfSGaVhyc9qW15XWQL/M3XJiBHgFvbalyMAF
 mpXSISKDT1s4ad/em1Ck+G2RKM5SlI8h/COabruCtz/gPFx/P/+lQkwUzWepa+lnzRgp
 dUXL+esho79BRqNyf1UAWUYAViTOWqDtNh85CTMRTSF1B+NRQBfcYa16XVxFCMfoALtQ
 icp3J+Kmq/4ZW06MfCIogZOPWx8KCIY22rs43W0EMXFScsU5F7hklSBoIVuR8Ve93+e6
 D50DRs4oydGps0CTtS0HrMbvzP4NOgEtbsnscjNttJ/kHz7Vxjgb0QR8PDNSKyowLiER
 Q6jA==
X-Gm-Message-State: AOJu0YxKMrtIJMp1Nf1eLemkYvWbBV/qtHiurgcum+SVenI8hPECQC0i
 3vdt13W5cGfB2jytFzr3tNHoCUyTrqEiWLJIKJFLnNYAREeav3MgoU0ai5ZrFAfcpsxfSO8xwpM
 GrpC0pz8m3ZC+4qDYFuqKHHtpHKBpA2I=
X-Gm-Gg: AfdE7clIO4W5D0kZA+GWM5rFoPqRN44GMLwBb/Y2TjN4YT7M7ztVZ8E6vaXA4sLiNwJ
 ByhKxFGYNKjuIHPcq0Nmurk9fpeeT13jmQIPman7OBCC48vHcKUQKZmcIcNEpvQLQ+2R0aqN7zX
 oev2FNbixF7mcIgFPTZDeF6KHDCjV/Lw6PmG0CmOCzqeNC7sY7VBqEe/IvGgb+6b5B0DaZK4Ju2
 Cxwk2bq3VGqddJXY5Pt9JKToeTIaTcBG9udEixKITfV1JglrGpsFO3lCmLGWMqggdE+Vq826uue
 /v5rQQCP86XZKsS6weJgkm0R/CrRdlzSoegtgw==
X-Received: by 2002:a17:907:a80b:b0:c12:695b:8864 with SMTP id
 a640c23a62f3a-c12a9d715admr1863566b.18.1782884367254; Tue, 30 Jun 2026
 22:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Jul 2026 15:39:00 +1000
X-Gm-Features: AVVi8CfN1qBHm1SW_wvwduVF3g_ASOT8GWiF7_bn2xE026xWHvPRRH73HufOYE4
Message-ID: <CAKmqyKOoOf0qX183TDVY5cJsBFrJk7sSvfsEudBx7ytuxzBa_w@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

