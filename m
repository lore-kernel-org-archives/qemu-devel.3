Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B350CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCC6-0003XZ-1E; Tue, 19 May 2026 00:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCC2-0003WW-1G
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:36:34 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCC0-00085q-Ba
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:36:33 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so616083066b.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779165391; cv=none;
 d=google.com; s=arc-20240605;
 b=OTRtrI2fgB6X7jCUehfQrgEKa9maN5HVvhAFx3pvrg6WL4J20cKP7c+PVKLjX0Z8Ah
 CRTRMsgpTSZUKUnnN15P59faDl7IBoLZwQPVRV6mthUgeX/9pLb/z/9R2pRfMfcZHiGw
 7LnyFt3QhXHkGnDWMiEajygL+YTOMSs9l4FN3MwnxStFVQpScSycy9R/gUF0OZUc+YAr
 DXrjQaO8iCOnpn2nlWEa3IzleRhag4OlYzeeLxEN9AquugXarc0uaX/5Q+UAOGiALrtM
 3kTVUlD4Zb+JChldehpu+AvMt8VK9GgF45nfa2x9M8TjnfhM1ON7F1tsj4VhTn4ouAd3
 Fnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m+x5cQ3oq2+9HThdLhv+PKH3GMjIO4JQ6XX1QcXpXuA=;
 fh=UWFUpkZbyi3drMh7JaseWoxnnIT8mucxwav29rTVikM=;
 b=MMROGdfaa6TrjevuZROCGtQmFS6IWVb5W+zQfnZkzX7ZDghyWLKyM1K/aozl+Qcuao
 bJLkPqI2N5aAZTDNZtyVrSZX3uw5Yc/5RoUbqBW0hqsrUbJD9YSWLSMoaFfJ/zaG35wW
 g+RUjbG8tqzXBdcu8SbaPm448J0DgfcFTNP4Yh2ml7TdJCNCkTVgPut8UhoNaazeONX5
 JDAgH3GwYFo8TFdHgtWtadUHKLfFW8ItB53NFDH4JzAzyhsjQr8xTjSzwBZFioXT+nXk
 c/avrsQIBMAENccpnXW2B0qctrXbCy0qQFr6XhGJYk/jaDpWG19N41gGoUO9MiUOPI26
 2oZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165391; x=1779770191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+x5cQ3oq2+9HThdLhv+PKH3GMjIO4JQ6XX1QcXpXuA=;
 b=QQz+u+e/6YjjaPxYb01ET1QkrWRpviUCe6Km/h2/uwYvFLP4mMSWy0OtZuGMg3e2Nk
 Q6MNn/OM+L+fAITbD0Q1oyy9cX+MageLXADN7uaMEgJo8qDZTQ6iwE09k9Ln1LS2cVtv
 Mzs5HqQva2owqVowDhotzuk+FZlv+uz0jQL4Emy7xWgDGuHh/34++hcjTyGfRxmdBEbk
 KxSqy+U7YlTWsDAzwrDX6Xx0yf6ge64s3w8IxvTPoQvKWakHc/l2A4vLfsXTQZfrQm+9
 g9klZi1da2zPE5ryinGMYKaDCqzYAg5TuuR5Le7SMJAT9Djik9MG1kxA1gKBFOgvKcO3
 Qy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165391; x=1779770191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+x5cQ3oq2+9HThdLhv+PKH3GMjIO4JQ6XX1QcXpXuA=;
 b=WktUxhWA7DB35jkie++clQ6NdNsPMAUZkgMIboQunajcqf/W5rGjYP72JaaTCedlrv
 z+hm8iMjEasYJBiCdzrhXCfJ/zKN7N9IzpkOq4M2xOLGTcMi+hyhHpjDYyKSD3yHSxJu
 AP7SLXLRgZl2hONvVdYi6iwK65Vtzsvo51M8hsK8PJ/apLHsI6tVjUMUln3q/k5TEhnk
 BOCfGtuh7VyMf2uQMGKQjTEYdd1u4MYoCOF5tlSV1jrJAc3Mkavye6BQyX6y5cwxD3Md
 6GbGhh9YGvjjp9zQPeRut/ktx94EvMu/V7Os13HQgeRF1LQREdlpoyVF+aqAGTEhm2sb
 PJfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8luAlErwJ2MWrIFKTmKPJI+cZQ7O/wFNXIzF/+6f4rzpLHwjFFRVdFlxAxBYVNEd5H+AhJTG3e5mvI@nongnu.org
X-Gm-Message-State: AOJu0YyuU334j5WwSymBPD8VxpZyRLeo1jz2KZ1UA+pshUsGkv6EccsF
 bE/1tu1BGYjOyzfL8cTXC6HFXE1WFrytLL/MxoHi0q0zYenCQ8PTuau5W4tonBFTSLyMpswazfo
 DsZ04yrR9lkisRm4sU7awxvtBZQzf4AY=
X-Gm-Gg: Acq92OGnEVjp7XsxihU7E21IgSyS9x+ClwM535HSGwbXfU0WHZsrYNwUf75ZFrnkBa7
 uVJnzL51cbZffXpNaKNFuLEcBNQvtKRsFxbiYIfWeTXhbMZXs+63zJdX/2/cbzqlpz4Cm9crRmy
 Q/SaVurby0z6u3QucqAGiJRyxV0y1BNyyM1ZaxcHVma5e97TPH09GcYOS0rqVLLYLFmjCELUVpY
 Zwmj2jOo2+YteZMgDjTuojJWY7vOeMOtz7CB/M4BCis0rf+Nh/dhU6kKagnVLGrLvyYOORiRzqc
 TUfDaSdkN3aWsupSv3uTOR+/wp/6i0NPVMI0rA==
X-Received: by 2002:a17:907:a807:b0:bd4:f854:27b5 with SMTP id
 a640c23a62f3a-bd5177da46bmr1096779866b.9.1779165390680; Mon, 18 May 2026
 21:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260512062310.348208-1-vulab@iscas.ac.cn>
In-Reply-To: <20260512062310.348208-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:36:04 +1000
X-Gm-Features: AVHnY4J6B3sicAS5aBK8i_n9w1VAYCAv3ISGwqylxY212-OsT-N9h6-mUIeiwDQ
Message-ID: <CAKmqyKO=t47bvWWdfqXzzd1YgH=gj1eMZ=P+8y4n_GufJ5DJ_Q@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build: Fix off-by-one error in RIMT ID
 mapping
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Tue, May 12, 2026 at 4:26=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> In build_rimt(), the calculation of `num_ids` for the ID mapping array
> incorrectly uses the same formula (`0xffff - s->pci_iommu_bdf`) for both
> System IOMMU and PCI IOMMU topologies.
>
> For a System IOMMU, `s->pci_iommu_bdf` is 0. This results in a `num_ids`
> value of 0xffff. Since the source ID base starts at 0, the mapping only
> covers Requester IDs from 0 to 0xfffe. The final valid PCI Requester ID
> (0xffff) is erroneously omitted from the RIMT table.
>
> Fix this by decoupling the `num_ids` calculation. For System IOMMUs,
> explicitly set `num_ids` to 0x10000 to cover the entire PCI Requester ID
> space.
>
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/c78dacf66c8acd677b3538c=
837fde310bb71a97b/output/riscv-server-platform/pr-102/qemu.txt#L32
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index fd6ca5dbc4ff..413d47d70ef1 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -802,10 +802,11 @@ static void build_rimt(GArray *table_data, BIOSLink=
er *linker,
>          range =3D &g_array_index(iommu_idmaps, AcpiRimtIdMapping, i);
>          if (virt_is_iommu_sys_enabled(s)) {
>              range->source_id_base =3D 0;
> +            range->num_ids =3D 0x10000;
>          } else {
>              range->source_id_base =3D s->pci_iommu_bdf + 1;
> +            range->num_ids =3D 0xffff - s->pci_iommu_bdf;
>          }
> -        range->num_ids =3D 0xffff - s->pci_iommu_bdf;
>          build_rimt_id_mapping(table_data, range->source_id_base,
>                                range->num_ids, iommu_offset);
>      }
> --
> 2.51.2
>
>

