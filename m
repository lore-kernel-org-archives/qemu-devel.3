Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7887DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCG1-0004OW-JE; Tue, 19 May 2026 00:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCFz-0004OE-Lp
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:40:39 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCFw-0003uy-0o
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:40:37 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so553055266b.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779165635; cv=none;
 d=google.com; s=arc-20240605;
 b=LnVEUD4vnpKVCqTYWo3XnED7uGdwQ/pbPghCICKxrSs8ogwiEuGZkFjnFxMGzuoGoe
 fqYnWbLORTSZ5fEmomr+vLeyDprU7Dxf6uYMPT90rvSPlDE5fSL1Wrv03b+7fB4e6vCV
 N/jqdpaupk+Wp6zAXmze7Tp5akLvuGpCkVLBuaIQG1gjMSrGK8VkBroE3YkGikkAHzp+
 a99FJOYOepJ5aOzhApJiWc4BCNQ6bNX8PMkPu7OSU3Xf8IDztGh/dufoq11ryFs84qqV
 yuabbnmLs06lLLixMSQGIL/nMkZWvY7Hr6GbFsta+7be7Ai1hHBTPUQVKQVrZ9c4Wa5/
 BXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=09M15YEmGZ8eGFqz26DM6q7dUnRGnfTW1Lg4SR65g/A=;
 fh=C8LBNVjOworYcSc1Rwb9o7lZjjJ8pYkXhOru7KiQ21k=;
 b=IjBZKqjtQmyV90QlndJHj7HUqFSitOFIxWf8KOolQ0GYs5p+Pv2Juww4wDGlo7DLAc
 jgHGQ4kYgvVm5cLoENWCYvJtcMcW3zD8ZRYjrGz6C+IdoQKruGBeDoYq04UXsEnjZUxR
 7VRofWq+nKDB3bVYTVLBwMFGwi7Yq0jbd/B9tI0AmEZqwjC/oCg3la3UBMALYBUx6GQS
 wTq1P4JN8xTDr596u0EvodCCAJjtj+T9TrdA6yAaZgM5c5gIvejJwnThLtkV9u3IQ/ml
 jo35JBaomghIIuNt20gpCIaSNpvVGTEI/K9hjl/u9FsctL1jAYVsCjsfhudjrG6aaDvT
 S8GA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165635; x=1779770435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09M15YEmGZ8eGFqz26DM6q7dUnRGnfTW1Lg4SR65g/A=;
 b=k3nk61dEUbicfSAY97LjKqmel2r9XRawpOwe3pwKsAQE0jRtzNelAh2rAN5Eo2xHzO
 dvtMD7ZB1E8Bc0wH1H1/VCgHLoIBm1/ya2Yaj8l1ibJ1j4JiXrzhRxxZvoEXlCZZO6Ce
 VUwcYbdx8d/cgQzZABY/lYXM3XhCar/mlNadEvTRwDQCU0tzdXzttOvC77OnCY5XOH09
 w/GWrK8jMKkQ3EbdkZOqHNwUHF4QMLMe7isR8v5XYwkWjRpaovY8c8PYmgkBi010F/Pu
 N2h8mw4fzta+iMvUooNd1v5z6JPc5ixPa1S02BctrCTF7IIu5IgU9nJCQm+qUo/OAJgv
 Yw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165635; x=1779770435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=09M15YEmGZ8eGFqz26DM6q7dUnRGnfTW1Lg4SR65g/A=;
 b=ZD3oIvCcMHc9v+bdEXEyOzj9H06D5PhMOIuK+iiHbjICbl69/XtZAIZI3PBis/K4O8
 UqjH/5BftpJUbe/j+ZmpnL22clEmPJOGwT4nQGJEEpp4n8XH9nfKrRGZpyve4/yEsrdQ
 ZimddOs+f66WeB97QWUNSLjV/DTXwxjAeI4hEC4AoY1nSdb/eK8cUD5lJSBiDPFoJplU
 f67Vp6Uf/FTKREHVSmcVvY1n3UhqLHuUtKdtOlokcpcgqtbNwelDnsIrmMgbqzl1vGWo
 HCuqVMfmHAYhfy+eoYiX5jAbGuRl3IH1UNZuiz3YIl/D3RODo8yH0tjpPH+mGnMppYKw
 UYyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/M1JQVRe4XYL084CDyiipRub9z7/ATRRz6a2oHYBbE7W9R1RUa4MFFsDcpJkIVrfGAdF0P9WcrJp0P@nongnu.org
X-Gm-Message-State: AOJu0Yx8MrLOflQXLupQtbkvDofy4G4QQyQRDB3xQf1H9qMxZVlICUuv
 pVPm1V6zbLVxThZqHxWpz3a74fBpvpjomImbSEd4cXmV4iTccU6v9FCh8DA2htRBAaaCruOVQBW
 bLpl9lPo7r3lDSiuMpqMUyKUv8iuWBdE=
X-Gm-Gg: Acq92OGedEHf7w1+yv3JH3i7RgRK8hdocp9gR7v7GuCfZw02Drn3fbmNrodfhtyyWFF
 0yyIQSR7ro670/RwTj+ABofSfSzBi/vhRfWT7hOUsm2P09woyKjz75x9T0mtIp1AYMTJf82FOFk
 MLYV30xofR0YfIdIJFK6K7m0R/bhErhTKIMzUmvPUJcVaBeTy4Dkv59yBZNduTQcU7y8hQxETkK
 D7Fxm63nprpTTzyY2gU0FDEzT+n1Un2devYTDHQd6rtHSETExsGBNxACa+ZRO6UZ60aAcY8vk8I
 ClVBntRtcYRiu7JHKNRJVJBi+VZAIKvwnqeZ4goYdHthB8gP
X-Received: by 2002:a17:907:8b85:b0:bd4:f7ee:d334 with SMTP id
 a640c23a62f3a-bd517966f7dmr994297866b.26.1779165634503; Mon, 18 May 2026
 21:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260512062310.348208-1-vulab@iscas.ac.cn>
In-Reply-To: <20260512062310.348208-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:40:07 +1000
X-Gm-Features: AVHnY4JvAunM0vtNsT7vy78XpNr6Bu__5fV_HR2qp_BG5AZkoyUI3bR1km0ZbfI
Message-ID: <CAKmqyKM8X923cN4G-O7NuVMsDPGQS2wdt65tXX0kRbeG+r_hhQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

