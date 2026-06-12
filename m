Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB00CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 04:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXtAb-00043o-DM; Fri, 12 Jun 2026 00:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXtAZ-00042o-58
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 00:06:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXtAW-0007Qa-Tv
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 00:06:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6913160c9ddso1000995a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 21:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781237215; cv=none;
 d=google.com; s=arc-20240605;
 b=Rf4ibev5+9iuRJcCj40sZ45N52k4DrNjgcOaLVtdUxpN249YPDaYtHtrV2usQi3VY6
 3F6EGzhLx9729c33YK2ul5UtuBGPOtDQ7i6U/xOU5cVKj7IVjjNVV2zXVdKeO2wrJqvD
 /jaEP0MOqXZRxZy1jER2KQiCuIs8dj57GmfO8TUuKDbHM6u1PXZiLxxdBFw2NvPYOWA1
 9WsOSN9kHQ8Y+Rm2QBSoHqfnVJBxzqMKQ0ATIdg4VFrI72Z96b6Z5p2H8ETHYR3TCMWv
 Une4VpbcuW6cvm5wcO/OGTbTa1k4be2m9hpA7y8X7o6LItll+COKUeZWEKXI1POWIbdy
 8p0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=miGF1yHVafpVx2qupDeuM3gVrtYBw2ce86jlAdHCQAI=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=ISPiIZC38dctvRKC8S1HilF7WbZ39Pl4j21faGKYQwyfL7+j6SKdIwDXao8KqgPAbA
 GsKTD3aZqt/YBff7+WTyUI9o8FF2BaXybe0Zdd0Fxq0LFbkPmYvsPx4bB6EtlqXdcqDR
 Tk6hqQTeSeqJq3M2s9sTSxsr//MU3miQVhu/3Pdxu9yxzw7cnoO9p10HF1NxvsutMy5q
 uvjm/A6xSs33k1AzE/FitFNtFPPaDtsK+8g9TfiJ9Xni/RK/bLlbP5/elja5wGl9NP7C
 eUkag0ZbXs6TBL9q6OQaENiH8dsKh7Yii+LNI5S296TthOXwgFk1DQ0Rf1W9ROp3o06R
 2vtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781237215; x=1781842015; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miGF1yHVafpVx2qupDeuM3gVrtYBw2ce86jlAdHCQAI=;
 b=iV4lGdienJnsB9bA52n9773fZYMNvtsKh8FJltsKnKyA2kT4cQJP6bBDfMQzpfbwqK
 /TLFoajUqkbQh6DgKbawMY2tdrT27fl2G21BrS6HW/N+5GRaOo+/hxUPls53NYp/Tkl+
 buyRM3cbbwKSj5u6bGJMyMvb+zR5BEO0QPRJiztznNliFjDHwJRrRTX6J2DHGRmZTgp/
 ibvOw9WgnpxE1qFp0kQ2QdV0yjGmqZTe1qSnrTrcr9ytF5UY8B2YH/Ew3LLAHF1ml1yG
 Ih9thHQNxkAh4fE+VPTBg81axQjrk3NIJR7IMWrjcd0nCdm7/XbUn1kxTWll7q2Fj615
 2eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781237215; x=1781842015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=miGF1yHVafpVx2qupDeuM3gVrtYBw2ce86jlAdHCQAI=;
 b=OF51FgIH/IAAui4GAi4FPrqsSNc1HBIVYxJBu07hNs9D2UkVS/t35LYlApK4cZ9IbC
 2KYP0xddIOZ2yYJjB5ahilSqrqbG7HiM9evBNNe7PA8VvGGPZ/08rRb5cLDt9xY0umCW
 VmBv0qPwmKJJuJ49eGCTOjNlGF7uifUihnzMG3ACxTjVBcYchCXRf9NLI8jj4tl2hKGV
 aRGuFkol8IGhes8RkzY/To+faE1EGwTan9CG24NnR/UPt8krYYKs0Ag97gS15MjT9VSL
 wBDH6uTkNYSWXPjuehaqOJggiB0yVf7238yZTY8+j/h2xuyQLD9oo43HdzaUNb7KnpVm
 zfsQ==
X-Gm-Message-State: AOJu0YziOQTuMSj1K79DaBI9bdPjOZhLc2PzcOLhGfQYtPeHIJnC1Odu
 we2lH9Ir54ITlq7fuBcU+N6MsZpuRhbTc7Syy5ub+J+KpBY1JVkvtoz5oLcTRqolo6rHKmCksfw
 +AaYVZSphMwHbexEH3/NX9fPqz9HES4o=
X-Gm-Gg: Acq92OEowbq3RplbmhwcziIxwibo/QrUYF6eFjdnyyfE6JNcvTZCapckHQmk3KNVVSS
 PgVHY9q/p6A5x8jhdW32xk3irpuPDjtSj54Ov1lFMWijRP772hSMLG4s1/FUufvP7b5vSwU+H0J
 xC0izvNTNlNaiaSAwEGXL4cthggxJZc3m5PyC2BIhItUHJUUN5eZHfe97ns3/bEZy7GEZ/iBRMX
 717dmkDTdj4t5ZLYoY9egUDxVmicA5nNPd9z7serBTdQ883syG/JOdrhgkcN5Y+Y4Kj9W3yNf2P
 Kwc64drNfCMir61Dnf4cQXhinnDcG6ri65lTww==
X-Received: by 2002:a17:907:1c9f:b0:bee:bcf6:6a22 with SMTP id
 a640c23a62f3a-bfe2a115631mr38111966b.44.1781237214765; Thu, 11 Jun 2026
 21:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260608210642.464131-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260608210642.464131-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jun 2026 14:06:28 +1000
X-Gm-Features: AVVi8Cd9v6dNE8XnFn6MAya34l9CzA6tHQObG0ihfchmlQmM6lxFNIXEi3MggV8
Message-ID: <CAKmqyKOHR78hiHePh_q_c36k4QXcX-5RLRKH13Jx_RQp464MAA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt.c: fix 'iommu-map' FDT entry
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
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

On Tue, Jun 9, 2026 at 7:08=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Based on the DT documentation of 'iommu-map':
>
> https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-iomm=
u.txt
>
> - iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifi=
er
>   data.
>
>   The property is an arbitrary number of tuples of
>   (rid-base,iommu,iommu-base,length).
>
> ----------
>
> We're adding a no-op entry (length =3D 0) in iommu-map:
>
>          qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
>                                 0, iommu_sys_phandle, 0, 0, 0,
>                                 iommu_sys_phandle, 0, 0xffff);
>
> This is easily seen in the generated DT:
>
> iommu-map =3D <0x00 0x8000 0x00 0x00 0x00 0x8000 0x00 0xffff>;
>
> The tuple (0 0 0x8000 0) does nothing since it has length =3D 0.  The
> information we want to advertise is in the second tuple only.  Thus
> remove the empty tuple.
>
> While we're at it, seems like we've mistaken the API and we're using
> 0xffff as 'last address', but in fact it is length.  This means that
> we're telling the DT we're mapping 0x0 -> 0xfffe, which wasn't our
> intention.  Therefore change size to '0x10000' to reflect the address
> mapping we want (0x0 -> 0xffff).
>
> Found while reviewing the RISC-V Server Platform DT generation, which
> happens to copy a lot of code from the 'virt' board, and this nit is
> also present there.
>
> Fixes: 2c12de1460 ("hw/riscv/virt: Add IOMMU as platform device if the op=
tion is set")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/virt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ce64eaaef7..0c489bb412 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -900,8 +900,7 @@ static void create_fdt_pcie(RISCVVirtState *s,
>
>      if (virt_is_iommu_sys_enabled(s)) {
>          qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> -                               0, iommu_sys_phandle, 0, 0, 0,
> -                               iommu_sys_phandle, 0, 0xffff);
> +                               0, iommu_sys_phandle, 0, 0x10000);
>      }
>
>      create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
> --
> 2.43.0
>
>

