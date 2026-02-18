Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D99DE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmuv-000319-S2; Wed, 18 Feb 2026 14:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmuq-00030q-Gw
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:08:52 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmuo-0003a6-07
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:08:52 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-649278a69c5so135343d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 11:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441728; cv=none;
 d=google.com; s=arc-20240605;
 b=e6KO9++08DcJJqvN/63DtnWYDbuq5OJdZY7y+EWqkS8uTqjho/U+6Yi6rLmGXMFntQ
 VH7BXf3gEZxx2ES3RCrwOcrhYMa2s6uWS9k1DbfDXX9oXKmHfgtCJKDfMIWjsd0SdcxY
 5jRqTq7Nilkml1YVjrG7tJCeKgyYMZJuaJZKnB15DfbHe/gDStdo0CCsIp9hpwoUuiJW
 e1fS3RMkyiHf1hxmC4sp/KF31SQbCBdgfpVDwSlM/MXyWAx1b9MfGjCcvps5SrOmcLiJ
 miJ0wHLH21mdkE1KXK8nQRkoGpzr+p7BxTe7zARUSENYbHX2o13CAUT/AzwS/HWWqg1E
 ydbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9W7gl2hVXplswO1QhVFR8xnttvo6FvyK8legK6LQVsY=;
 fh=ljsPVrMqM9WEgWa5yaVojVHzX4ehGvtuqRUN4Y5D7gg=;
 b=LUIBkyOy7LF3kvyAKnUaWFCgc7JwtZHL25L4VP2VYFyv98H8RI/q6GMXphj6o5YXIP
 Um617I2vo3dmV9AIImBykdhAIeE1vr7bsPXV94zilUCq1QBqkfNdysXLBgXID01p2MQJ
 RBGvthiC2U3RH6IMscy6sHaXlEUzF55juZRvfWuxFg2mm/k057WUU/Y6ORNCEddQsYlo
 QlxbNUKdNcQViM99IjsanpyrYwsOi/puLDhtsm+zD8KWgfcfqyNOYhO+KiL0Zz7/AEyO
 /rsMrn3fPznv9D3PfgVWjMUnMEOKkMwUy7ZgpEXoUN01e/nDN/wCA3v6D7Z1ZFzYxcE+
 OOag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771441728; x=1772046528; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9W7gl2hVXplswO1QhVFR8xnttvo6FvyK8legK6LQVsY=;
 b=Daf7YdOfu/0pL1tell6kvWZjWHc5/d3oSgRysHkZ6MZEI0LHfhaBUS2uN+gcPAsgoX
 c27nVUoHhs6xyJ94xuOCqh5n2xR6mUXiaeW2Cbz7J4QLeTE4YB1EORQj5yee7nFDU9Mq
 mJfvJfRrjzVxLP6sWGBF6Nx9LeLkoKcaBrGWw1wA7td97t7CeR1CSocKS3kimVAo1oJp
 GeyoI3fpwp8YjL92L9C0BB3g9KD+ApR0OHugcVcahvW2cWsp7A3AcXf/S419EBxstfgx
 eDWdaQ864E4mb0Nd5mbgjhoK1aqcdyjLB+Vp5s5gf69j+Ki7yrwc4Dk3VZ1ciHcjTCrN
 Fnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771441728; x=1772046528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9W7gl2hVXplswO1QhVFR8xnttvo6FvyK8legK6LQVsY=;
 b=Gau4rl43Xpsh4UJVZGLnpAmG75Vkm/f7gaHFolKvhk1/WFu/vza6m0fWo9Cd/tFHGS
 IfRw8V5f4nZSkeWSicll9PDUqiOIGxiAxIRvEnLPJEpEDkvha3rrnr3h48StPyir7vpj
 SsMltdTUqcRB/vXV/FOGL1sECpQawMrKcM2CLovovJLWwXp2KtjxFK0gQyeXK2niZQBH
 e83XWAw3eq9TtS2Y9cH4xzytlAQbGKjR4MUu8kPmtRoSfgIBBUcSQltmqqPMX7YW3+j3
 PpUHvq5Ht53ZB6cINEwM6goMApwRL8vKPH9cyAyoGhT5LySfh+w4DjE1ExHKhcCE5lBr
 2mqA==
X-Gm-Message-State: AOJu0YzJJM1jo2gnPhokfOwMcM5mECbkUOAQoeCA/D1HnoD/Fc1shfxo
 Dbbe5oE86EYwzy/XY0B3IZ/7TB8ewb0EIrsXjXnZTXRCRaVRHj8hUyIErpbeD3MMXFU/b0gRn/N
 klwUyfVtMOl3FQv+f4T5gfr4Y5w7LY9+2rvhNIm0MbQ==
X-Gm-Gg: AZuq6aKosEeVEWWdHXg/9XrNXCeNiR8NmI5MFAirOUrPxwz5GkBQBEypUj20BZHxbai
 q3CqL+nzw+1tJVZJGsYioZHbOZ9RT/1v3QPDSgR4DCmklp8MZbxcCsFiOIPneg5HsLm/7ppVrUi
 pTu6TLGzpJr7yaZ+0DGfb1m+xGxgLHmwIhEJsOTllxA3A4dcDdldHxf21X8yP+JBMyomUSpmaKi
 5USKuWOKw/r1JkVx17XUt5oMZhgVCB4IOLAecv3SaW4dZPZDUjWwu0CGG1ayc11pAWD8LQbaKVg
 2jkMRyzmKVaHF4AM5rK/ih+XVt9Ev7QaNBYHbxg1yo8Yi2iNfxMbcI1mBFIst8QwgCs=
X-Received: by 2002:a53:e1d1:0:b0:649:c3be:a36b with SMTP id
 956f58d0204a3-64c14e04ea0mr11041986d50.94.1771441728546; Wed, 18 Feb 2026
 11:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-9-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 19:08:36 +0000
X-Gm-Features: AZwV_QjGHmkJIvlZIT7Few9fbvc6nK1MdW3kkZHc9FurM0wg2PtDFz478IiJxWE
Message-ID: <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 6 Feb 2026 at 13:15, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Add SBSA generic watchdog to virt machine type with
> all necessary wiring for ACPI watchdog. Which includes
> setting its frequency to 1KHz (max that WDAT is able to handle).
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 390845c503..caf5700ed2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -93,6 +93,7 @@
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_host.h"
>  #include "qemu/guest-random.h"
> +#include "hw/watchdog/sbsa_gwdt.h"
>
>  static GlobalProperty arm_virt_compat[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> @@ -194,6 +195,8 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>      [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
> +    [VIRT_GWDT_REFRESH] =       { 0x090d0000, 0x00001000 },
> +    [VIRT_GWDT_CONTROL] =       { 0x090d1000, 0x00001000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -245,12 +248,32 @@ static const int a15irqmap[] = {
>      [VIRT_GPIO] = 7,
>      [VIRT_UART1] = 8,
>      [VIRT_ACPI_GED] = 9,
> +    [VIRT_GWDT_WS0] = 10,
>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>  };
>
> +static void create_wdt(const VirtMachineState *vms)
> +{
> +    hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
> +    hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
> +    int irq = vms->irqmap[VIRT_GWDT_WS0];
> +    DeviceState *dev = qdev_new(TYPE_WDT_SBSA);
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +    /*
> +     * Set watchdog tick freq to 1Kz as it's the max WDAT driver
> +     * is able to handle.
> +     */
> +    qdev_prop_set_uint64(dev, "clock-frequency", 1000 /* 1KHz */);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_mmio_map(s, 0, rbase);
> +    sysbus_mmio_map(s, 1, cbase);
> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> +}

Please can you also add support for exposing this device
in the device tree ?

> +
>  static void create_randomness(MachineState *ms, const char *node)
>  {
>      struct {
> @@ -2515,6 +2538,9 @@ static void machvirt_init(MachineState *machine)
>      vms->highmem_ecam &= (!firmware_loaded || aarch64);
>
>      create_rtc(vms);
> +    if (machine->acpi_watchdog) {
> +        create_wdt(vms);
> +    }

Can we have a command line option name that isn't ACPI
specific, please? There's nothing inherent to ACPI about
"I would like a watchdog device".

thanks
-- PMM

