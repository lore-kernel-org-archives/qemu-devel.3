Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F66108B8FF
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 04:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3nYV-0006Tx-Pu; Sat, 21 Mar 2026 00:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1w3nYT-0006TX-E3
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 00:03:17 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1w3nYQ-0006qE-HA
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 00:03:16 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-667cc4ec065so4077182a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 21:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774065790; cv=none;
 d=google.com; s=arc-20240605;
 b=H02iQj3csuPzFocmDQ66QPAei5kfL2WlTm7NELNbrIXbNID67D6RKwTAgR3ENQT9ze
 jjjRXm8Glk86OOgKRfq+BEGNBUdA1NILcgO9maxttrtK+A8Towiog2GVhOXoG5lAU+CK
 0EwMiIgRL5FdwIDP8cBiIWtDftXZ3O6tqXioy6fOi0ORLB13/9qKf0eoh4ZeBQZUKLny
 AWowa0OHkJqtBfODSpwxj3ahkuFdJEwYaQskJ7b05Nn3mY3nMxOvIrrT5sTHeoZpax14
 8mkbCvdFNdWO6cA/TJwQoADSo48L+zPVR5+BtbCPGvDpoJ6IFIUEuz2ex7YuR3gDjfSM
 UCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RfoxCWs8ZgWQgjrWjCnp1ckQx5KqVcobLSuSM1vEtGg=;
 fh=6BtXo4SmHNyYim4r0XvEZef/5nVzHBUpoe//e6zRwTI=;
 b=BnR5FJY2tOv2tBv3hoZdCyOfDA4NdazDa1s3NBifsOGJQ9QtwqpGnWMj+FOL+CNGDL
 zA3BLoYGYBfKjOeOZO9GXl5yksdyUYcs2oan0b+rtMyQCOV43b15ME2HtEIhHiI6H0m2
 Jtcuj58rVQ+WHSleGGQK+N00Ufw8e+DxF/WzWRtwshhyKx1HBi7SiiIQU+WtNNvv3bf0
 DBMdFZpWDLWUC69DigfmKJDD+XJ1CSCihXYKMdLAchmP5AUWqXp2MsSGth3t+6UdXeHF
 UD3W9cTk+L12JxCId0gCH8mqHz6vqmtgH/SAIuEgJsRmHf9zxFJeZWrnfQyMx28+qYpr
 hIaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774065790; x=1774670590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfoxCWs8ZgWQgjrWjCnp1ckQx5KqVcobLSuSM1vEtGg=;
 b=Di8XMOC2dC8kTiScpuyfbF2kUQ+TqJyzlqoiKQX2up9Ec+r5f8Vo80fxk4bXd9bnvY
 wSIXfSu536TeoRhDlWu4ZtiBtTpZ2g9T9sXicjDNU2n2nvUpGsQP0l+gmKf6ex51gqq9
 bCgBccq5SqMzeX27DuyXOZCBQBoI1IyHnhLrAegARG37EpgySyTCJUDJ6uEOjetR+Ca3
 L0Krh9FzYoaWc0UVl9FS7V/F03Sdjc/LiMRlanFHgL046/guvcbk1tznzK+xghQ559Uh
 WTLwW413JJZl2vh7pFKgl6+pvFdyzndZ6eFLH2bPVUd3XimSS6MP6GMVOHFuoTaSTxEX
 xtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774065790; x=1774670590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RfoxCWs8ZgWQgjrWjCnp1ckQx5KqVcobLSuSM1vEtGg=;
 b=mIHgIYUqhpH/uomDKhqFLHC+x+qFLlnGBhRzvvvHNANkIqYHjq5byS+Jxh+4wyWGqh
 uV6Ao1klzmp4M9QzoyrLBKSm6P4fTGhzTqmv8vfxQTBRsy9LIQ3wdDRfcVHzHkqu7ilc
 5tDEXBwS5ci153jzQ0GYc6UaaiWndpX/x77btPvhaLMEB+JjJYJVYfx5Kkr3XMf8i9G5
 NZkyrb2Hsxvb/iKIkTWwiS8DMlLnFLPj1C6PVIXthynQPFlxhnKHA5JUJbYXOLgY4i0n
 41M8mRqJz+rVOFQSyh2J6ckDIBlzvYXktnSJejOZC9y0JEp3np543BvS4j6u5XP+p333
 GdqQ==
X-Gm-Message-State: AOJu0YzF6YxChSyVZplvkEo5ENhkl/N11vS7+nt6q/lugHUA0pqsebln
 MEb1symcspsrw0NuI7iuw4k6xfjWE1KtyC9PUgMO3/8YzozptBQM2KmC2HEUf4GFhh9B+RchZQC
 5dddHRYBwiHYP8HCrO+ztoGlQ2zKcyeoaT531wY0=
X-Gm-Gg: ATEYQzxW1QOaJlZcI7y5ku9SdhWOSxp24ylJwSutKKg5dj3OzT9PBSxtKEvpeKOYNMY
 /u/XwCZqlSo9rE269eZI1bVhcBlNi72/FfhMP40bl8dPzm00ZhgjgZh/jGfjR1tlFU+mcTBovZj
 4sRDFWz95hvdJSjVJtcvWLtoAgNYQG3oDE64+rSABnyvBnWZyC0bX7SGws5p9qUJQM3pumhwrRt
 n3WRA3tFJLlfWMpQ2npYutQDKQZxJ/EWI4qBobslyhU/JyM4ARVL3Xf2KLXAe4PWR0JGagKOygz
 FqB2KEeYNPDBd0xOnw==
X-Received: by 2002:a17:906:6da:b0:b8f:a174:3186 with SMTP id
 a640c23a62f3a-b982f3e783dmr319674466b.57.1774065789885; Fri, 20 Mar 2026
 21:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260312021350.1052791-1-lixianglai@loongson.cn>
 <CABDp7VqCb6R9h8WYsseaD34fJEyhYNAoCAgC2QHFc7D-dVFzdw@mail.gmail.com>
 <a845bc6a-8ba7-cec6-1a38-41732b738b02@loongson.cn>
In-Reply-To: <a845bc6a-8ba7-cec6-1a38-41732b738b02@loongson.cn>
From: chen huacai <zltjiangshi@gmail.com>
Date: Sat, 21 Mar 2026 12:02:54 +0800
X-Gm-Features: AaiRm53sFgUr5hOIUWXdpY3SBfDqng-TMMG0LKJ6z5RP6M6OM_VC64gYuuDWH7k
Message-ID: <CABDp7Vp=xvz=D9AjQaqZNVteLX=UrbLyaQBBiNjGA2E6qc6WbQ@mail.gmail.com>
Subject: Re: [PATCH V2] hw/loongarch: add rtc acpi table
To: lixianglai <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=zltjiangshi@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, Mar 19, 2026 at 10:35=E2=80=AFAM lixianglai <lixianglai@loongson.cn=
> wrote:
>
> Hi huacai :
> > Hi, Xianglai,
> >
> > On Thu, Mar 12, 2026 at 10:40=E2=80=AFAM Xianglai Li <lixianglai@loongs=
on.cn> wrote:
> >> Add the acpi table to the loongson rtc hardware so that the virtual ma=
chine
> >> kernel can use the loongson RTC-related drivers.
> >>
> >> Delete the interrupt information in the rtc fdt table.
> > Why not use virtio-rtc? In this way we don't need to modify the ls7a rt=
c driver.
> Sorry for the late reply.
> However, I did not find the device simulation model of virtio-rtc under
> the hw/rtc directory.
virtio-rtc was added to the Linux kernel some time ago, it is very
new. But goldfish_rtc is another virtual rtc which is widely used and
has a long time in QEMU, you can consider it.

>
> But, there is a simulation model for the ls7a rtc device, which is
> strongly related to
> the virtualization of our loongarch platform.
>
> So it makes perfect sense to use the ls7a rtc here. Otherwise, no
> platform would need to use the ls7a rtc,
> and changing the simulation model of the rtc device at this stage,
> our bios would also need to be modified accordingly. This would result
> in a very high cost of modification.
I don't strongly object to ls7a rtc, but if you use it please try your
best to make it the same as real hardware. It is unacceptable to
modify the kernel driver to adapt the virtual ls7a rtc.

Huacai

>
> Thanks!
> Xianglai.
>
> > Huacai
> >
> >> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> >> ---
> >> Cc: Song Gao <gaosong@loongson.cn>
> >> Cc: Bibo Mao <maobibo@loongson.cn>
> >> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>
> >> change:
> >> V1->V2:
> >> 1.Add a comment to explain why the acpi table no longer provides inter=
rupt numbers
> >> 2.Delete the interrupt number from the rtc fdt table
> >>
> >>   hw/loongarch/virt-acpi-build.c | 25 +++++++++++++++++++++++++
> >>   hw/loongarch/virt-fdt-build.c  | 16 ++++++++--------
> >>   2 files changed, 33 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-b=
uild.c
> >> index 3e34bedcd6..42820001d7 100644
> >> --- a/hw/loongarch/virt-acpi-build.c
> >> +++ b/hw/loongarch/virt-acpi-build.c
> >> @@ -460,6 +460,30 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongAr=
chVirtMachineState *vms)
> >>   }
> >>   #endif
> >>
> >> +static void acpi_dsdt_add_rtc(Aml *scope)
> >> +{
> >> +    Aml *dev =3D aml_device("RTC");
> >> +
> >> +    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
> >> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> >> +
> >> +    Aml *crs =3D aml_resource_template();
> >> +    aml_append(crs,
> >> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED=
,
> >> +                         AML_NON_CACHEABLE, AML_READ_WRITE,
> >> +                         0, VIRT_RTC_REG_BASE,
> >> +                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
> >> +                         0, VIRT_RTC_LEN));
> >> +    /*
> >> +     * The virtual machine model does not support suspend and wake-up=
,
> >> +     * and rtc is no longer the wake-up source. Therefore, the curren=
t
> >> +     * rtc table no longer provides the rtc alarm interrupt number to
> >> +     * avoid the software initializing alarm.
> >> +     */
> >> +    aml_append(dev, aml_name_decl("_CRS", crs));
> >> +    aml_append(scope, dev);
> >> +}
> >> +
> >>   /* build DSDT */
> >>   static void
> >>   build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *mac=
hine)
> >> @@ -475,6 +499,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,=
 MachineState *machine)
> >>       for (i =3D 0; i < VIRT_UART_COUNT; i++) {
> >>           build_uart_device_aml(dsdt, i);
> >>       }
> >> +    acpi_dsdt_add_rtc(dsdt);
> >>       build_pci_device_aml(dsdt, lvms);
> >>       build_la_ged_aml(dsdt, machine);
> >>       build_flash_aml(dsdt, lvms);
> >> diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-bui=
ld.c
> >> index 6c06b36fca..42f014a7bd 100644
> >> --- a/hw/loongarch/virt-fdt-build.c
> >> +++ b/hw/loongarch/virt-fdt-build.c
> >> @@ -458,8 +458,7 @@ static void fdt_add_uart_node(LoongArchVirtMachine=
State *lvms,
> >>       g_free(nodename);
> >>   }
> >>
> >> -static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
> >> -                             uint32_t *pch_pic_phandle)
> >> +static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms)
> >>   {
> >>       char *nodename;
> >>       hwaddr base =3D VIRT_RTC_REG_BASE;
> >> @@ -470,12 +469,13 @@ static void fdt_add_rtc_node(LoongArchVirtMachin=
eState *lvms,
> >>       qemu_fdt_add_subnode(ms->fdt, nodename);
> >>       qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
> >>                               "loongson,ls7a-rtc");
> >> +    /*
> >> +     * The virtual machine model does not support suspend and wake-up=
,
> >> +     * and rtc is no longer the wake-up source. Therefore, the curren=
t
> >> +     * rtc table no longer provides the rtc alarm interrupt number to
> >> +     * avoid the software initializing alarm.
> >> +     */
> >>       qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, =
2, size);
> >> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> >> -                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
> >> -                           FDT_IRQ_TYPE_LEVEL_HIGH);
> >> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> >> -                          *pch_pic_phandle);
> >>       g_free(nodename);
> >>   }
> >>
> >> @@ -550,7 +550,7 @@ void virt_fdt_setup(LoongArchVirtMachineState *lvm=
s)
> >>           fdt_add_uart_node(lvms, &pch_pic_phandle, base, irq, i =3D=
=3D 0);
> >>       }
> >>
> >> -    fdt_add_rtc_node(lvms, &pch_pic_phandle);
> >> +    fdt_add_rtc_node(lvms);
> >>       fdt_add_ged_reset(lvms);
> >>       platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
> >>                                      VIRT_PLATFORM_BUS_BASEADDRESS,
> >> --
> >> 2.39.1
> >>
> >>
> >
>


--=20
Huacai Chen

