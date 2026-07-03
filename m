Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727F0C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVeu-00018q-Qs; Fri, 03 Jul 2026 00:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfVe3-00013x-HQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:37:00 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfVdz-0001Uz-LB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:36:53 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba3e6so322755a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 21:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783053407; cv=none;
 d=google.com; s=arc-20260327;
 b=DU2ZJAL5cOBEVJ27w7W4g9zFpizSaMwvjW9qBFoyS/LeRbL8SdqJ92HBy+zgTlLrY3
 6CwN6TxgtFPfluVyq9lS8LYFrlx5aLd8JtaenEC7ctiqHKjKiugNrcih+AM58hbX6kat
 kN9QFYxT2KJJTvPLAq7K27iP4Pobej5qsXm76rerC4VmW5yfyGefSpHOVYzzZHphFXJE
 BtPkJSE34jMyMstDHfNlnMoW3tRzv9oGfgGUi/uXKki6bm6AYjWT+GmuGOsMt6GWOAin
 NEaBMlJkdcO5jyZWE3rGH4x2JVu9ljzsFBKcF3a+fJd/Q3fARJeppAMhyX9lHr7F0v+3
 RgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G+46/Dpi0EvwPiK3I+01DnAKPbD3h383JDUavSOz30o=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=iDOEEqddhUBaSGJVuy0O1NNi+muFI4fzeopdvg1Jha9hEAyACPinctzN5DQA3xB7Ho
 0/ghFh0c2vtH/WTYcjB7juvNNSIUgt9fNjRjT39PjPkIt5KxSO1AqlyLgyvjGPNivPgA
 bHFoBW+04l1/j+4HtQvaGJi5gDtaNtl9K6EkHtFKMp3GZgmqh+4QX66n1bzbzYoDBA/+
 Z9gDrDXiTFWRoshEV3BtJVZlJWQNF8O3ckO77KWcBX7LZQm1vOrwPQeXglnrghgTcMQd
 Za8m0TytSb41fWCE/PEVdZrmJ/Q+1lOXd3imRGZ3noUnwzUVsL1VubxdSGxBNLHIUXWG
 ZOfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783053407; x=1783658207; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+46/Dpi0EvwPiK3I+01DnAKPbD3h383JDUavSOz30o=;
 b=UE6bdo/4HNuH0hjk39L+GorkSNG7Xbqw7eyTdUvXTWuxd4GXn07JUbtlYQQCtcMpPX
 ++rdcla/FvBAzuljbvDATQshZSjnQlblBRXyp+jOQrqG9PTo+ESuPcWSZEhnwexTQ7Xb
 VCM9yjXvBAh1xp/WJGGvv7LOGYeo5mVHr+R+Ty4wmzXOAqv8lrLd/Qc1aRw/9SJOkKvj
 Q9IA6UUfSUa/8GimbdunMfHrxCojIZr7a2LnF55wGl+TNHExJdtLVoYZ1/HXLXbTC7u2
 sxmeSgzACBabA/zY5MZ9WAXy2Xg4RjmBtQMQlMQzYaL3ZsyFdpsVPm9PODa1z+xG8Juc
 jqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783053407; x=1783658207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+46/Dpi0EvwPiK3I+01DnAKPbD3h383JDUavSOz30o=;
 b=SmuMoQb+lzhv9JQYt5piXPVJuk70slIPUvAgeghiDqcmQQ+KIYQeSvQ44Yab9M5csa
 cFOVgtF/6a6adESP30GRh2fUOUh7nawZB6tkJ+9GD7OWirfjdftLepGj553E+2X2QrSt
 Y4AkmWStwB3bLG3l/wqSiG60oyMdMSpHB6gTsLek+GUb0AZ2E0+7d+HJ04BOENh+mhFa
 n3wADHBTotcEFj53G4gcEuoCPok/t5J7Of561YAcDfCpf8STLJ05eefRO6DIkQdT0C1d
 9QbwW4WXPIpGj/KSDzI+TDEYZe4bLD7gf+/0X/fPLwkNpSgTLop+0+ZoeFDqt68QIF5t
 7Twg==
X-Gm-Message-State: AOJu0YwkV58ZjLA9dJGzbEmO6Gy2Tn1JD8eaXqBtqrwkPDAK9ilQsNnd
 Hv8CZ8z3qGmazAmVv20r1vGDgbb3H78WCcnfcmnazNUTD5NzwhdZWr+3m01fZxetGf3J/bRMKVh
 p+r0gaJFC/wtkzqAETgAnldE+FQhgUcg=
X-Gm-Gg: AfdE7clVLyL4FFUU3yj3d8O8Fmke9VEGxnylaFfBKkMq3mplZMALH/IsALx3XyCb3j7
 QU1RQq3bvWnmZW6Hc2dXY6Z6ybfp/VfrPFtnM2Xh4ley/jbTw122JC3eXHXvdyldJ9US+jYgkNT
 D/KSdKwguEryBCbUsAn6MuFviPUgAfT2rA5PhXFGx6WezRk7MLdWS5vkFzNyAHZFHUDxFqSCmlQ
 G71Gq2Kmf5y9ZHKQU8yQyQ6f8UDPF0c+RoZlwAemDbmGCjZyUfiEsi1vC5i4xo/zfdDciy1l6V5
 d0KO/csGmpZ1lvRBkgD0BYoX5TdFiclzqyGK7Q==
X-Received: by 2002:a17:907:c205:b0:c12:79aa:828c with SMTP id
 a640c23a62f3a-c12a9efd3bdmr363520166b.18.1783053407164; Thu, 02 Jul 2026
 21:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260629125719.679626-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260629125719.679626-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Jul 2026 14:36:20 +1000
X-Gm-Features: AVVi8CeVezXY7p6RsGHwSmKl7IiwxtwIanaGHAGgHfjcu_ETbDCAoeU6BV4nvTc
Message-ID: <CAKmqyKM3ugvt_5jdXN5O07bXeX_rwgWMTh4GsdougiRO6JMAXA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Mon, Jun 29, 2026 at 10:58=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We need to throw an MSI_MISCONFIGURED error when any of the reserved PTE
> bits (first doubleword only) are set.
>
> Fixes: Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3563
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..6828349fe3 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -648,6 +648,27 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUS=
tate *s,
>
>      switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
>      case RISCV_IOMMU_MSI_PTE_M_BASIC:
> +        /*
> +         * riscv-iommu spec MSI PTE basic translate mode:
> +         * "When an MSI PTE has fields V =3D 1, C =3D 0, and M =3D 3
> +         *  (basic translate mode), the PTE's complete format is:
> +         *  First doubleword:  bit 63      C, =3D 0
> +         *                     bits 53:10  PPN
> +         *                     bits 2:1    M, =3D 3
> +         *                     bit 0       V, =3D 1
> +         *  All other bits of the first doubleword are reserved
> +         *  and must be set to zeros by software.  The second
> +         *  doubleword is ignored by an IOMMU so is free for
> +         *  software to use."
> +         *
> +         * In other words, bits 62:54 and 9:3 of pte[0] are reserved.
> +         */
> +        if (pte[0] & (GENMASK_ULL(62, 54) | GENMASK_ULL(9, 3))) {
> +            res =3D MEMTX_DECODE_ERROR;
> +            cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> +            goto err;
> +        }
> +
>          /* MSI Pass-through mode */
>          addr =3D PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
>
> --
> 2.43.0
>
>

