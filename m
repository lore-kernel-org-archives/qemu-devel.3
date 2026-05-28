Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD01ECD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSX4t-0005zl-I8; Thu, 28 May 2026 05:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSX4j-0005g7-Ag
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:30:53 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSX4h-0008Bp-0h
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:30:49 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66039d3efcbso1010081d50.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779960645; cv=none;
 d=google.com; s=arc-20240605;
 b=TyOzkp+GjSuSKBXn3PGDJAU1zBHHaMl7VoCWsHZunkFzaUjwKJFnMmyCTwJEV+2g/9
 KDCPpmEzbcCjDE9yPLHGVyOIKJSnF/39agBoWBE0XrKyhZGyKVosuGIyNSwbN4S2jmZU
 SsCHmkDl0oZ9VLmujky5l4A94nKKLwfJveUhyRB+YtVaQEW3E/qcBlDdTBut+MJ0Afhz
 H40uc1tadGCs+DrUNGxFJOTmno7zTomQL9Nj5hNHkf+ZikrcnefmjRLH1hf1t7qy7+qq
 9Nm96VcKVLRE2ujl9X3pAN+1gJlI9hZDn3e5fzQK2FgSoFyVpRhtDTjmNJZukM4QTAI5
 J8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KK3J7jJtAUB/spMD9R7PufZBHtQmYtVNixMMDvQ7EWU=;
 fh=FZXuIRDqNqniMoFUEman2r9HUc8sit5zcqcJjhIbXe8=;
 b=d4QjdFkooH+e1AvJK0rg+RzFgEBB2udRoKZqKywMJPKDDsN4ygVa+mFKacRD0V06xR
 hm8aFIvd3/iMJGUyMTmXqf3qhk+h6JBvOc4GAB+nZ89ZCJ4fg8F3oAgoOMc8XXAxsc8d
 5dz8fJYOjC4OJq80nnf5WDkd8BZJNaCOjhFM6ysCweIHZw/Io7whYoBxxQizM999V35Z
 O3Usaku6ZcehdhqrWPJOVQwvvmqSk+j5vREuhAzc6OVswjHd8fRIxZ9YdgBpdNdQXhEg
 zeDwonIB3Tk8Bi7QAEdeSC0U6hA+eet5yZMsCu7I+xWLACrE6zWqhNZUPl6ldAllFnaD
 dojw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779960645; x=1780565445; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KK3J7jJtAUB/spMD9R7PufZBHtQmYtVNixMMDvQ7EWU=;
 b=WlJKqfNGrIpjp98NwlkXYDSNaHImnKt3J2ogf5l+scypFs/4svj4O666zYQllPxeP6
 hvlMrPsUj3r1JgQfeL445UjLj7mYJe2ZfwjteWB5zoma+NP0OsphXPB6N4ct9Cfocqwc
 d6x+oe5HltuB7bAIdhpzWLV91DLUvAkSTC3/KtQN7hCU8uVbN4K8EI1vM55aEMoEhhP/
 uyGnfLRXdYYYm8wU/ymFDcAYtluEGlsjWDkatHqHHnLPmhbRYZG9130HVgXYAn3QXNzj
 UdwbiJqAfnQxt5oGs4a7G2i82tzMBh6GWlJ+q1K7BCvFZAR9yyoTXEyWtMcIFOOzxNw5
 DtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779960645; x=1780565445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK3J7jJtAUB/spMD9R7PufZBHtQmYtVNixMMDvQ7EWU=;
 b=JTcu1qJc1fW+Ht0OVZJOrYQW87UaorIKZWWkK9uKgCjA0uKmqyLk0tQAy4gXN539/R
 JVkl8H/ESVY4yRIEx7pa38hO6UUpmTS4b//1AQ33Nm+HO1zZAXF7W2RYKuDWwB9h7EVy
 ruEs3phFQLz1xF8LfZRXUfjk8HKz1NOSvrNhdlSnFbVfPHKA2g4ZyGD+Bk3Ovb/k9z4H
 f8JQp7MEdTOWBsxlw0skDgqostwLgemQpjYE6kWQi+8pnQKHJP+CRqDxPK6aC2vojj9j
 GtTRuVkTpnPWr+ti8rCLEGX/1U3qpL+4zGpmGUkkajjrcRS4VxQrC8UCMVDAe4TZB7qc
 xLmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dP3WrH2WjIARqUfXQjCXtRA0dDwS47PpNh479Aa4+rxzJWPRx0bH0KZrzHGqlO6bFF5ndbSmlknZK@nongnu.org
X-Gm-Message-State: AOJu0Yy/QoMnjoYn3+0Z6xTa06z4ivz6NkEFFPSHdhVkrU0MLjkYE7RV
 GpvEmiTKGPvqULpCp8VGsFIlK1WQi8HyefMPM46wmMWQY8NprLU8OFaVqYjZDJ4loXmlXPIMuK5
 CoLrLQaaE0Gu684eexgwMhkiAtFjeLBmkm0CQ/JghRA==
X-Gm-Gg: Acq92OFxmczQsV5FV+V0/v4cmQsSCaMfUv3D//SqIyvv/+FsPedcck18YppBiOrAA76
 XIbYOvoTiUvoe4G/cftwB8TLJw5JnUuljBqNuJl/HWMqu70q2Y9eTH1ZQoo3sAQwKo7o5Q6skKs
 FzdjSPobP963Ch0RFPJLfaIIyZ8LLNRWDFcBX/puyrLbtuiL7r63B5eOVQ9dkfj0YgQ3iP9GxYp
 GnrM4UdgrgAvbVgMnhh6+X7Fjdv5TYYcK8p4JRfPwmYs+tGBrNX9S87PSpRPzV7ljNewxV9qe/m
 AuGsnQp4qSZCCicvcvb/yf440Y9I7v6QLAjdFBOeSVNCfqTDoRhmGqwgZys6YHuzhWc6wxf9E+b
 Myw==
X-Received: by 2002:a05:690e:d07:b0:660:3f57:9fc4 with SMTP id
 956f58d0204a3-6603f57a19dmr1757667d50.28.1779960645480; Thu, 28 May 2026
 02:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <0de640a2-8807-69cf-4429-672263e3e759@redhat.com>
In-Reply-To: <0de640a2-8807-69cf-4429-672263e3e759@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 10:30:34 +0100
X-Gm-Features: AVHnY4J50SPTw5dRwU5508n8l8p2zVU1xQyYcFODcW8m5r2GVOt_8Jm2cRZIWBE
Message-ID: <CAFEAcA-PkO3aeGoaAzpbJGrrE-_-RjJy9Q4D4MnQ=9W61--3hA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
To: Sebastian Ott <sebott@redhat.com>
Cc: mst@redhat.com, Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 28 May 2026 at 10:23, Sebastian Ott <sebott@redhat.com> wrote:
>
> ACPI PCI hotplug of a PCI device using a bar > 2M fails on ARM
> with a resource allocation failure in the guest kernel (Linux):
>
> qemu-system-aarch64 [..] -device pcie-root-port,id=rp1,bus=pcie.0 \
>                     -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on \
>                     -pflash /usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.qcow2
>
> (qemu) device_add pci-testdev,bus=rp1,membar=4M
>
> [   55.106283] pci 0000:01:00.0: [1b36:0005] type 00 class 0x00ff00 conventional PCI endpoint
> [   55.107627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> [   55.107864] pci 0000:01:00.0: BAR 1 [io  0x0000-0x00ff]
> [   55.108015] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x003fffff 64bit pref]
> [   55.118609] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
> [   55.118653] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
> [   55.118671] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
> [   55.122828] pci 0000:01:00.0: BAR 1 [io  0x1000-0x10ff]: assigned
> [   55.127090] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: releasing
> [   55.127098] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
> [   55.127102] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
> [   55.127106] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
>
> This behavior is exactly the same on x86 - except the busses are created
> with a default window size of 256M there. If the PCI devices being
> hotplugged use a bar > 256M you get the same failure like on ARM.
>
> The workaround on x86 is to specify "pref64-reserve=" for the PCIe
> root-port. On ARM this is currently ignored.

From the perspective of somebody who doesn't know much about
ACPI or PCI, this commit message doesn't really tell me why
QEMU needs to change. The above reads like "this is a kernel
problem" to me. Why is the kernel unable to allocate this BAR?

> The following patch changes ACPI DSM #5 to return 0 (only when
> ACPI HP is used) which basically tells the guest kernel to keep
> all PCI resource allocations.

If this makes things work why isn't it the default for all ACPI?
Why doesn't the kernel ignore the ACPI table setting and do
the thing that works all the time? Do we break some other use
case by setting it to 0 ?

> ------->8
> From 92cd64b8398f13e51b67ff8baf62f15cac300c94 Mon Sep 17 00:00:00 2001
> From: Sebastian Ott <sebott@redhat.com>
> Date: Wed, 20 May 2026 10:39:26 -0400
> Subject: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
>
> Change ACPI DSM #5 to return 0 when ACPI PCI hotplug is used
> to tell the guest kernel to keep all PCI resource allocations.
>
> This allows to use the pref64-reserve= option for pcie-root-ports
> and thus enables hotplug of PCI devices with a barsize > 2M.
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>   hw/arm/virt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b090233893..293a0c2163 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1094,6 +1094,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>           pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
>                                                     vms->memmap[VIRT_ACPI_PCIHP].base);
>           assert(pcihp_region_index >= 0);
> +        vms->pci_preserve_config = true;
>       }

If we set this here, do we still need to set it in
virt_machine_device_pre_plug_cb(), or is that now redundant?

>       sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
> --

thanks
-- PMM

