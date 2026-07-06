Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A73C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgZSe-00050C-LU; Sun, 05 Jul 2026 22:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZSd-0004zN-0l
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:53:31 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZSb-000235-Be
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:53:30 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698b899b4c8so2202725a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 19:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783306408; cv=none;
 d=google.com; s=arc-20260327;
 b=aSYb46P9YlFGB+gPco1NOWGfMjInlJaLD/hyCdvWQKFFuo039gzuBS9xUc7QzRmLrk
 zcHBnn6gH9oiFtON4SCiWM8Al0cU4HznXpHnu+BVLYPDWBEeZgvyiBZwcfnp/BjBhl+O
 xW6C0xPYU3IS5g5kk9AfOo6XhTeJXf8dUNroOLyS2Iq2t0N3gx82U6CeNVLoz4Sldeud
 R53Ic45L8+NhjjfLFVCcUH/qQ5jM23zPiXOQqql4uYJCfb7RNJJV5AIkM11MrbhhGbxu
 13Wtq+fJnaBZJXbUIkBwX8XkWDUdsvZcddpbpenP3qH5KLNirmxyaiZhqaqWyzV288Vr
 un7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Arc2Od2f3ANGbXM98pUy8eEy42FzSXo2KHCJm4qE/sY=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=oF6NU3rfhekyjmKw2xUyF0mANE1OY0i/ZCNDiRrmqztblKKdNgAVE68sYpswuuLNyu
 gcP3sVBXYnORwpRlwx5VcAdsbxpNFg4rwJdfExwq9M2NR/uGKJxOMVLZQWjrEzHBBm60
 X+xANNMtJDlMshqjtzfvqsh/pO+itYx1AP/tfpB9FY0kKsMA4GSsKxr+uXb0PVn0n5fU
 nnxDTahtTpJdxCPg9bqDGWtaAVpY1Yd0B1c7qqiU/55xVeSgzfTrGkaj8cLf2tC9fI9w
 nGLMvMwWkp2TRe5Z2LuxuM7LXvUy8oS9rB4tB/atoL7O+rAm88sLuEMpgQ4WTmBW7Vuy
 07Mg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783306408; x=1783911208; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Arc2Od2f3ANGbXM98pUy8eEy42FzSXo2KHCJm4qE/sY=;
 b=YvMdmWu7nPlebuK693tXdZ1cXpZnvDBkeckuJ84Ogmomrr12bgE8tQaO8W/NQfNNVy
 ie3wGz/hkbL0L/6L8j+5XOF12Ea66zrWG04moJAR1TLRiuWXZEPKWIEDkJhuXL7YwrEM
 +Obm681QO89BiacLIulyucoImW6JTDn547/eMz8vnIFq99jKSXZOl8KS65r0nA9AvlB/
 63Bq5JierHySzi5/PtxO/BID00+OvbXUhDs297sQbbKRIupeNp+SpAohzOaMD2a6cJVS
 wvbXY36vdhKm2vWKRldDKo3n8rSFecuASkiwn+aGah9R51zAlIoiS004Ddtkh6Uu0VQC
 +6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783306408; x=1783911208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Arc2Od2f3ANGbXM98pUy8eEy42FzSXo2KHCJm4qE/sY=;
 b=THdmy4tFKXqHod6hg5ZAL+rrUehMe58Q0e2IRwNgSrzDOpo9oP/grcW8PE5ci3D6G1
 NYfUNeGZWctyY0k5Knusv/7ELChxvfW4zDvnKrCU42KYS6vPyIYqDUycwjhonQH5jzan
 jp2eAu919CclsFvCo/J819U7XyMfhIiRiO7j1UUvW9PFkKv2QG4wjtDOJ2McFf/AKlHs
 B6HnYeQjkJVUZdys2bsJPWC/YPAs9nfXWSkt4z21H3ZzaMPtlq2IU2HxnEhB9ZT3hn7D
 nsOYw7o8KHSJts0zQv0gNZWtv/FmM8+x1nFlZ6KB45bZZpFZpci08oqGtdrw7rs18AlO
 0ubw==
X-Gm-Message-State: AOJu0YyipPvXqpgmAPW8ZrHIEnyTVKIGS58M4WGEFLWPAERwsIDpjT06
 czf2P+6mU37ptVGgYdU9Fdbg+U6utkOrrYss8QNp3IxJ374Y+PkMS17zfYCym5cyj8fob8HU8Fa
 z1HtjqI4RpKpPtkmJJyLzdpxQIZNxkKo=
X-Gm-Gg: AfdE7clC1JpeUmGuTYc5fkLSGi+Td40VvNKSpe+YUKrWYyyEhFe5PhShmcwsgnNjdJu
 pUcBZ+E2KKTLZ6D5Ku5NzCMtOfP/TJQ5zDVR5m/h+RX7VMAP3XhwrLm40/pEV9HAVac7J9c66VX
 PbkgkD8xfiZdJJIggZe6Eb1AltYp4tMpJShbl6OuklV6NDYRr1IRCOzLpnzKXFwJBpa2qC0PfE7
 Al6C2mSFfKiOUp7Ql0PitoM3Ws/vs9/2nFpYMjZgfjSb7HIrNYElhRdCS+eXzSmHP+znU0ZbP7S
 I1I09e/OYm2+3OjbSDVrrHG2zGc=
X-Received: by 2002:a05:6402:3908:b0:698:1504:bb1c with SMTP id
 4fb4d7f45d1cf-69a1a3b1f86mr2732790a12.29.1783306407435; Sun, 05 Jul 2026
 19:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260702171202.1322493-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260702171202.1322493-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 12:53:01 +1000
X-Gm-Features: AVVi8CeRXiFLLXIyhCJYRQbwnudRX945Y8IcVhMQ6zc6hLYIfRpbGjwlk_3md1E
Message-ID: <CAKmqyKMxLjAaG2YUbjC-HkYHg2iUyW1mBp2Yfm_WzTvk4bJhCA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: update ioval2 when faulting in
 spa_fetch()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Fri, Jul 3, 2026 at 3:12=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_iommu_translate(), the only caller of riscv_iommu_spa_fetch(),
> will use riscv_iommu_report_fault() for all faults it detects.  And it
> will use iotlb->translated_addr as 'iotval2' every time.
>
> At this moment we're updating iotlb->translated_addr only after a
> translation step is completed, meaning any fault that occur before that
> will have a zeroed iotlb->translated_addr, and as a result iotval2 will
> also be zero later on.
>
> Keep iotlb->translated_addr updated with the latest translated addr we
> have.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3559
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 974042d017..6761b77f95 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -546,6 +546,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>          }
>      } while (1);
>
> +    /*
> +     * riscv_iommu_translate() will receive a fault and then call
> +     * riscv_iommu_report_fault() using iotlb->translated_addr
> +     * as iotval2.  Update translated_addr it with the latest
> +     * translated addr we have.
> +     */
> +    iotlb->translated_addr =3D addr;
> +
>      return (iotlb->perm & IOMMU_WO) ?
>                  (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
>                          RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
> --
> 2.43.0
>
>

