Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BC6FB5EA1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2JIU-0006p8-Lj; Mon, 16 Mar 2026 21:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1w2JIR-0006ol-Tu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:32:36 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1w2JIQ-0005HD-6h
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:32:35 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9793fa5371so302206966b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 18:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773711151; cv=none;
 d=google.com; s=arc-20240605;
 b=XYRSbDjug2FsH3X8LktdoFWIvf480+XD86+QpyddAV9aeuD0mpbMSi6oeWcxGyDluR
 KMzrF6yQcJvK1ssAFoyj3hqXoKAL5txCfSHnxByrf/w/CFhoKMlxg7t7/Wh5vxwBhWae
 aW1nnq9GwFn+a/hTwr/aYf9ZnJBWn0oj1WJcxqUHQNeqMAtwZklH77MhXR9XqKYXPSD6
 7HKLc2vx/2gF62T+rGYkKEumkOZAOBI9TTM0LOrK96s56u43wq+EQN6dqPswsbWScn+T
 G9fy9jXNBRQVrbAU3uYSM1IQEc4MmYLas53kRFyf6Cvv6tcUoRanmB+a/n0gy36mzciE
 YHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iz9MzvmHhzfsCOkEyZ2MOhAvmJYDgZeukeeO4anI6W4=;
 fh=fFdeUiMyqWJXu1bhsGjkMqb62mk26lKJBayd2/f+IqI=;
 b=N4DwM1C3B/dVL2xnnYrtW3vEotav/t9cdfenlVFB2RzdSM66nT2AXasTbdHVYF/Xg3
 baUNPkH5D2oBMvO4CC4z4SIuRgKDa8bRzJQkUGahE2VcadJFfix8JdEg2+dNgFRn4Zrr
 R6XNM9d2mPsCyBY4dizglsV2AveyMWkV4yrvsXpl+e9y4x95l7exant+hyJ5Vj9VS0D1
 2xnjJo/D6WB873Dw08FHKwQoqpPxZM23OFkCw8n9abmLeo0sWWQ5fw8fWFZeomUpPUft
 UzqfYf5ZLMfl2BOcI9KdCKHXFnL/D1RTRFSnmSULHiAobLjmqr2htUlJ2GG8B53+5xo2
 deCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773711151; x=1774315951; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iz9MzvmHhzfsCOkEyZ2MOhAvmJYDgZeukeeO4anI6W4=;
 b=ReV9yOR5hs1PWXclGd+Z+i6wrnkjbzbReU8ifrbKTuKZC0LN4X0/Goi+FMavA58LoU
 YSlKM6EiwOimFPT+G97uJ/0F6RShv4du21TOPMRpzGso6KcmnQpJqOOVspgIymvPq1KC
 w8fNQbBkou/LW/15Mu0XNgFRKiKsweP88WTVqxAeOVdzNGDFHUxHQjta/cD18PnzKXnW
 siSslU0ZpzV1cZ3v/f0vZcFqRWAVXgi/EIAEFNM4qmmE2SSBG7GYgCc6ZPHCOHLWpcVI
 IofCPWHFsScUumQSLHAvIwrrfRJc5V8bgfdqI+zaL0j+DJPlhxuTLj3QnzU5+9AuRL+G
 EpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773711151; x=1774315951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iz9MzvmHhzfsCOkEyZ2MOhAvmJYDgZeukeeO4anI6W4=;
 b=LMfDXA/zI5upvvKMzBUDolVPMvqTR7fxmOD/XyRMO4DQmkpDmsz1T6FTbnNSjRoVWY
 XuimzfNEnPeRZHr4hyZU2kvC+X2/2SRrjrGRuzu3flteR3o8C2PmbUdPmZyE3VQCm3Le
 GK57r5eRYp9NnUgo6PiuGNwF2WJCo8dfu9wI7W5KpV+gqNzWZiDlLV784vhX2qb1zl/B
 lGXA5D0eyJKHh5Dl8mCfmUoahrMNVsg77vFQmmgx2qBkvpdIFZ1SZWyjGcvxvn6V1Uve
 CXjnbmlrlTfv+FPfoMyBSXl4q9Zx7DuetZqiSBoSH79Ln3XCIomNnP13M3IsRmUYMrGi
 93Dg==
X-Gm-Message-State: AOJu0Yw3Dna7Ob2eAgj1W11Zoc4mdX5PM6BZu3+bR7SjVNgrc7CViBip
 /3P87jxNSeIywMvcRJbcAscRAVMVONMb3A4iK/JCq7AojvfO+ICaoIBwqEm1nzYI6a2UXrKcY1/
 ksuVFtAc39gtF/TNBJtZXvD2aaLB8z8enQtGussM=
X-Gm-Gg: ATEYQzyn9pkhr9cHVDDTiXVqc5RETeUTyWuHrSsu8EFNC7j2vQrW4xsb24SBzxkoW5q
 3BkflvXEmFr9OeRhQ1RLLegYEpzklDABX5wy2emsRJ9epKyTrzE43jZ+OGKIeq20FGJ3eCcXkoM
 rBIpjB1ewFpycT2J34NdCsaYIHB+AgsV9qTAjTyYQKOevB4SjwqMIRqxeZ4xWKnLW6No3f9rMiL
 4xPHuzHd7Sy7T1xgdrhIe4UJLzLBoBqe79SeZhBGH0QzZbs3k/J5y8uPP09QfcUfwUJDQtQfCPY
 eC9r
X-Received: by 2002:a17:906:140c:b0:b83:b7c5:de2c with SMTP id
 a640c23a62f3a-b9764f7e684mr739966766b.10.1773711151203; Mon, 16 Mar 2026
 18:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260312021350.1052791-1-lixianglai@loongson.cn>
In-Reply-To: <20260312021350.1052791-1-lixianglai@loongson.cn>
From: chen huacai <zltjiangshi@gmail.com>
Date: Tue, 17 Mar 2026 09:32:24 +0800
X-Gm-Features: AaiRm52SePd6U6VqdL7O4rZkXF1sbwEbD6OTM1srDDhZMcbNaiA1Ym7pU-lx7gA
Message-ID: <CABDp7VqCb6R9h8WYsseaD34fJEyhYNAoCAgC2QHFc7D-dVFzdw@mail.gmail.com>
Subject: Re: [PATCH V2] hw/loongarch: add rtc acpi table
To: Xianglai Li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zltjiangshi@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, Xianglai,

On Thu, Mar 12, 2026 at 10:40=E2=80=AFAM Xianglai Li <lixianglai@loongson.c=
n> wrote:
>
> Add the acpi table to the loongson rtc hardware so that the virtual machi=
ne
> kernel can use the loongson RTC-related drivers.
>
> Delete the interrupt information in the rtc fdt table.
Why not use virtio-rtc? In this way we don't need to modify the ls7a rtc dr=
iver.

Huacai

>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> change:
> V1->V2:
> 1.Add a comment to explain why the acpi table no longer provides interrup=
t numbers
> 2.Delete the interrupt number from the rtc fdt table
>
>  hw/loongarch/virt-acpi-build.c | 25 +++++++++++++++++++++++++
>  hw/loongarch/virt-fdt-build.c  | 16 ++++++++--------
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-buil=
d.c
> index 3e34bedcd6..42820001d7 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -460,6 +460,30 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchV=
irtMachineState *vms)
>  }
>  #endif
>
> +static void acpi_dsdt_add_rtc(Aml *scope)
> +{
> +    Aml *dev =3D aml_device("RTC");
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs =3D aml_resource_template();
> +    aml_append(crs,
> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                         AML_NON_CACHEABLE, AML_READ_WRITE,
> +                         0, VIRT_RTC_REG_BASE,
> +                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
> +                         0, VIRT_RTC_LEN));
> +    /*
> +     * The virtual machine model does not support suspend and wake-up,
> +     * and rtc is no longer the wake-up source. Therefore, the current
> +     * rtc table no longer provides the rtc alarm interrupt number to
> +     * avoid the software initializing alarm.
> +     */
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>  /* build DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine=
)
> @@ -475,6 +499,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Ma=
chineState *machine)
>      for (i =3D 0; i < VIRT_UART_COUNT; i++) {
>          build_uart_device_aml(dsdt, i);
>      }
> +    acpi_dsdt_add_rtc(dsdt);
>      build_pci_device_aml(dsdt, lvms);
>      build_la_ged_aml(dsdt, machine);
>      build_flash_aml(dsdt, lvms);
> diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.=
c
> index 6c06b36fca..42f014a7bd 100644
> --- a/hw/loongarch/virt-fdt-build.c
> +++ b/hw/loongarch/virt-fdt-build.c
> @@ -458,8 +458,7 @@ static void fdt_add_uart_node(LoongArchVirtMachineSta=
te *lvms,
>      g_free(nodename);
>  }
>
> -static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
> -                             uint32_t *pch_pic_phandle)
> +static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms)
>  {
>      char *nodename;
>      hwaddr base =3D VIRT_RTC_REG_BASE;
> @@ -470,12 +469,13 @@ static void fdt_add_rtc_node(LoongArchVirtMachineSt=
ate *lvms,
>      qemu_fdt_add_subnode(ms->fdt, nodename);
>      qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
>                              "loongson,ls7a-rtc");
> +    /*
> +     * The virtual machine model does not support suspend and wake-up,
> +     * and rtc is no longer the wake-up source. Therefore, the current
> +     * rtc table no longer provides the rtc alarm interrupt number to
> +     * avoid the software initializing alarm.
> +     */
>      qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, s=
ize);
> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> -                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
> -                           FDT_IRQ_TYPE_LEVEL_HIGH);
> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> -                          *pch_pic_phandle);
>      g_free(nodename);
>  }
>
> @@ -550,7 +550,7 @@ void virt_fdt_setup(LoongArchVirtMachineState *lvms)
>          fdt_add_uart_node(lvms, &pch_pic_phandle, base, irq, i =3D=3D 0)=
;
>      }
>
> -    fdt_add_rtc_node(lvms, &pch_pic_phandle);
> +    fdt_add_rtc_node(lvms);
>      fdt_add_ged_reset(lvms);
>      platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
>                                     VIRT_PLATFORM_BUS_BASEADDRESS,
> --
> 2.39.1
>
>


--=20
Huacai Chen

