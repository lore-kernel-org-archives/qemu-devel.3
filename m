Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E73CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welhZ-0001yp-6n; Tue, 30 Jun 2026 23:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1welhW-0001yP-60
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:33:26 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1welhT-0003RX-7X
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:33:25 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664d22d7337so272821d50.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782876796; cv=none;
 d=google.com; s=arc-20260327;
 b=PP2y5+ON0Kh/w4xzr2Sc4D+hNfjfnJNu2Ki9D9lDopDj+KtvJB0ALjOIyAuZYOv6pb
 INe0YeX3UO1MHNEftxDnAlRBXuQfZN9va+KntiRhLXZD+ss5GGwC9RSs5yQFCXp1yT22
 YcZRg0oPOotpow8v2wBa7VejhnIFCz0Dl+wVOfCUx7+ziTj6Wu5yBS+YcHgWQlAxrP7D
 7ley15BFWht0jTPI1q6a5mRGxkuNtu8Ro+liHbuJMQTs+1wX+7aq7evG8QT/SMU6JjoX
 tkg50btxJTRs3dlS2fXXrytYorPYqpscVeOaZEKETuQI+GLSOqfKG78tpLQE6Azbs55i
 CtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+EvaKYc+18wzcN7rBEpFRmVKzhrR3e5zdkTpcoIlLJI=;
 fh=In4yc3tW4PBzt3Ms6Yvg+yoH6TF/Q5gZOSHAI11kZ3U=;
 b=PR46q07qpIYOLqmO3h5cdKhiVjN8bByZs2oRwD8uiojqEcdVnMF5oOhLeHMDasg7M7
 rk/xhkBuONRg5IB1hHreVGcyDOtmfgw4N53TQOq0QKFf4mqP30liDsKc0yRrdPg87Uwe
 FJMjgEjU13knHBfkBw12RR1CDV+bCvR6ybGALBnpLhzCLW7Yn99YUN6o+tnXOKuoTAzO
 iP4uPjn/UozFTNBR9vSMLPM0HYHIo2MlrvZZn9tK5ccIEElzWjuswtBwo6nMfd58iIpe
 fshoT4uvnTV4njlyq76IkPs0ubrLaB7vhc5yiPwREgofD3zre66PJ1C+AvLJFkq0g8N0
 a37g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1782876796; x=1783481596; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+EvaKYc+18wzcN7rBEpFRmVKzhrR3e5zdkTpcoIlLJI=;
 b=jws33jXZ273IFvYaqRFfOKdxpKLCPSOIz80NQ41/0OLgVijEfvR9NwcWe7N5aZIXJc
 2QL4uiUfA8tXOCP5KPSCc+DUe9yn84xzNPMSqZBpgDSv5rs00OnhPmshN2Aalaa2SYzX
 ZANbw6p9nhSR8AJ1XQYm9GXLMnCF+r97oKeIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782876796; x=1783481596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EvaKYc+18wzcN7rBEpFRmVKzhrR3e5zdkTpcoIlLJI=;
 b=JhPgbmgvzaWAtLwKNcYkhesHLmbSiB2Ry8BGtDowUYQwlZIHbAss7stuueBGvLHMjY
 TskQlRAJ7Dd5Sd35LKF9F84u+39Rf1O01RF8SRNpbyXwOqgYNRlGTUqk0VVxRg7tkTZZ
 Dfu2wX9/Kpkl3UiqWdVzt3HkaNR+2OJ43psL5d9bwCyWXQvliFHlVRb5/T5fiahBGjXp
 H9RsJAz2Dmlf+KWpR6jNoDWJ1dIPKfDn/QYYZXZ2qBbHiVitLuUEX4rQ3PFdylovWCnK
 KjYwQ4xK7trpVSVvkY+SnFiZsACoiJ+yzGoLmTCS7FJBysG+OIMQ0MwbKfn/wCLZUjJx
 Ef3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq/LP4f3yf5IE4VfTiOGguo+bYa0L6LWGIxauAdN3SUYozRtlN8qyxWZZh0QRrT/aAV7LO8xEUgKej@nongnu.org
X-Gm-Message-State: AOJu0YwM0agL+6EuiFzUTMs+/geCon2x6HSFS7WGfE8M0vdam1zr9km+
 8+PPeimkXo+jP4ipu0U6vR7VwLZMrC/S+08QhG1fqd30nUDrwuFDmIcdFgcf8qfm84YrbANDErT
 1dVcz3h3kD0i7m+Z+we1Tfz2tk/wJQ9o=
X-Gm-Gg: AfdE7cnaikO4v44O2DvZKQh9vr/6KlJ5ji+KvC0rcVeZYIv9YSNiFhkrkvbfuJW9yez
 3tfX/06E9qZDQt/jINH5kRe076/6251H9ys+34B72vj4Cfs90h3ffvqFn5tuZUWvQYGa7I4hj9N
 5hfVALA3F4/fkYRPQChRfqdOba5WsHhz5w+3urMJ2dPeDTkwkCt0vTjmALgKe3ZvaLmt01cDvEV
 UIrgd/K5K1jXyDG8gcOyX64ypJuYvEOWeSPVcRSPyl9buD/Pb6XUDeHNcYbUnIDxU1SPUM+QfIs
 lPlqb/KWfLlvuEUfPSCxz0R8vQA82+syrLtLRvtPtOJ0INubwKqO5HrjSlmh4nH9XgXTVUYLsQ8
 TGDYqS+0TWKVsbg==
X-Received: by 2002:a05:690e:11c1:b0:65e:15fb:240e with SMTP id
 956f58d0204a3-66507acff23mr3499917d50.12.1782876795822; Tue, 30 Jun 2026
 20:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-5-visitorckw@gmail.com>
In-Reply-To: <20260616190147.1286316-5-visitorckw@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Jul 2026 13:03:04 +0930
X-Gm-Features: AVVi8CfMLGGbnK6dxabPFN7dHif5QxgskR8rc-PxTIQqcttSTjh3JjXjwlJK8YQ
Message-ID: <CACPK8XdFhs7vy-e4peyKcAwk3wzcJFct5HTaAzB4nrbNeMnKtA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] hw/riscv: Add Milk-V Duo board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 17 Jun 2026 at 04:31, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the Milk-V Duo development board, which is powered by
> the Sophgo CV1800B SoC.
>
> The implementation includes:
> - Board-level machine initialization with 64mb of default ram.
> - Integration of the CV1800B SoC.
> - Support for loading external FDT, kernel, and initrd images.
> - Proper setup of the reset vector to match the CV1800B's boot flow.

Can you add something to docs/riscv too? A brief description of the
the board as you have here, how to boot it, where to find
firmware/images for it.

> --- /dev/null
> +++ b/hw/riscv/milkv_duo.c

> +static void milkv_duo_init(MachineState *machine)
> +{
> +    MilkVDuoState *s = MILK_V_DUO(machine);
> +    MemoryRegion *system_memory = get_system_memory();
> +    RISCVBootInfo boot_info;
> +    hwaddr firmware_load_addr, firmware_end_addr;
> +    hwaddr fdt_load_addr = 0;
> +    int fdt_size = 0;
> +    uint64_t kernel_entry = 0;
> +
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_CV1800B_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    memory_region_add_subregion(system_memory,
> +                                cv1800b_memmap[CV1800B_DEV_DRAM].base,
> +                                machine->ram);
> +
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
> +    firmware_load_addr = cv1800b_memmap[CV1800B_DEV_DRAM].base;
> +    firmware_end_addr = firmware_load_addr;
> +    if (machine->firmware) {

This means the board will not run any firmware unless specified on the
command line. Was this the intent?

If your board can boot with the in-tree opensbi, the usual pattern is:

const char *firmware_name = riscv_default_firmware_name(&s->soc.cpus);
firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                 &firmware_load_addr, NULL);

This handles checking if machine->firmware was set, falling back to
the default riscv64 opensbi, and handles `-bios none` and `-bios
default`.

> +        firmware_end_addr = riscv_find_and_load_firmware(machine, machine->firmware,
> +                                                         &firmware_load_addr, NULL);
> +    }
> +

> +    if (machine->dtb) {
> +        fdt_load_addr = riscv_compute_fdt_addr(cv1800b_memmap[CV1800B_DEV_DRAM].base,
> +                                               machine->ram_size, machine, &boot_info);
> +        rom_add_blob_fixed_as("fdt", machine->fdt, fdt_size, fdt_load_addr,
> +                              &address_space_memory);

This can be riscv_load_fdt().

> +
> +static const TypeInfo milkv_duo_machine_type_info = {
> +    .name = TYPE_MILK_V_DUO,
> +    .parent = TYPE_MACHINE,
> +    .instance_size = sizeof(MilkVDuoState),
> +    .class_init = milkv_duo_machine_class_init,
> +    .interfaces = riscv64_machine_interfaces,
> +};
> +
> +static void milkv_duo_machine_register_types(void)
> +{
> +    type_register_static(&milkv_duo_machine_type_info);
> +}
> +
> +type_init(milkv_duo_machine_register_types)

You can avoid some boiler plate by making milkv_duo_machine_type_info
an array and using DEFINE_TYPES()

