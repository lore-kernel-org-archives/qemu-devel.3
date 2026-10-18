Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E328CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIS0k-0001nR-FI; Sun, 18 Oct 2026 10:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xIS0h-0001n5-V4
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:37:15 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xIS0f-0006pH-KW
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:37:15 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-53a448f86e0so809862b6e.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 07:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792334231; cv=none;
 d=google.com; s=arc-20260327;
 b=LeK9UsBEuNdyGqLJ8SgB5VFKtHYs99q8yyj6JDVdip4xCAmxICaiMquCDXp2tupr4c
 OGPRMc/TS6mmmBcQ9uTBxdgG5wCW8APj026Z+SaMEPvdoP85jBreKq6r/BbELvaUUn7a
 W/vZUQzoso/YrT0PfRWIMXX9woRrVsrWOwcedsqQX1Pti2EdP/ZjjMmmJm+i7u9kp1R0
 Zg48SMkfKGy4P0Bm3QqekI4cc6IAPmiG/Lxa0wx/y+C11b8PPgEa4p9dpHBzC3YOG2Tc
 CZ5a+UciNd/xjWGm9OyoCYqldCg2ZFCinwllYTsRL2Bl2TE+NfZ4H70OIYRPDt2rn31R
 6Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uDn+gOsi2g9C4o4gMZMZaFbY/BuUJt1abLL49NQYbJQ=;
 fh=LI9aekGwGBHYPRDMpgVmM6TEkl/g4MNgSCqW5BVJNKg=;
 b=qYsAnOMGe63UsEyffLXCVJ/u9aesCYl3GXZGMWvF6VXkIa4MgXbzeiZBSYfo7jnBNQ
 Jsi1poMZQtCW+ZIB8cWs4w0/NasyogHYDlqBAGOJrf9saRAZLlLo2a7YYdUQyD+ERTue
 iAol/2tveUbaLhxtKCIArmdj/d9nMU7SHq6OLyEfH3axFs1H8ptzyTBvxEgqdbhswV5n
 ZPWrTxFaQzD+FCrnm0Q9h6+m3zApvuu57XZ22IUeBgu+XLEX0mN5rulGaFOcnZbZCL1/
 7qhaUWiNnYpVBLT7KzVHqBablgc6bUBdUTttkoi3JS7Jz1U3+ADxwqHpOrkx13zMr1T0
 PHYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792334231; x=1792939031; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uDn+gOsi2g9C4o4gMZMZaFbY/BuUJt1abLL49NQYbJQ=;
 b=T72pS466Bl/OZvqCcPp/+Qxy4Ulc+2MXV1KnVTAJ0dqxINYlDqvLetXQOViD8g6Vcy
 2DTqqgSuiunkQLCJFyAi33QJH/uEfZCiUqjEx3WPYEEFblftTlewrhDKDBcWvmq12UkU
 FGv7Mk9JjuN6uR9V8XWBF7t58tUMBuCHmPf3O/v3sglQc0iX9Kp6dGaZA3CRROeULLgG
 qSfXBHBwyDvLtbtbaISv1qg+IjtYurgWYY2W4jiGi/FEmT9Rt8FbMImHKPUyRrRrTAMm
 hrjt1tpzJxqKGzzfFexP8LpFHhTP2O0FZXlxXNzosUZmlYvCy31rR94vAq1jTccKSUaY
 HUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792334231; x=1792939031;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uDn+gOsi2g9C4o4gMZMZaFbY/BuUJt1abLL49NQYbJQ=;
 b=qcnD0XU6WhDZk9GfOugAlvGtLJ/h+GYtOU/Xf3/CYzMwEk0tbdseSWpytJN2X1qX7+
 DG+yBsjwqjqomGLNJo6/THKrIomT/5ro57JWmCshfDMGapaHicQcc6RYAeBqWmIXaofn
 SAUqlQcET0OjWSDvCwCqfdCpXL/gT2K9wMQM0spWtI520hbIf5Djn8pyS0lOcOwn3zEQ
 HEadeqoZVeALQLhXJVfVDICe1432rfZ7jmyUJeLTyj3wf5M3Z94soSwtfrHWtUpENyiU
 9h7ottxqreYKCqLqJo8M8ptUfYtEHsWEK/isPw6SMaNpYPc9q8uhTcaty34f/4C6FXZY
 yyWA==
X-Gm-Message-State: AFq9FYIqkhw/JAKosLeAH6vWLAN4KuIBkCWVxzplQXeoCzQAmRrJqSHE
 fAVAqqv4wDDRbIv5z7CzP5N9W8UViqnRrak4RhCBcUwSmRSkw7iKNJXAIYNDB+mQoKISoj6BDid
 SmOJiz+QHjOSyfDGQ5ykdAmZ1LEP4+d0=
X-Gm-Gg: AYBFou3yep/RKu09/34OUDSmtnxEQ02vp1WZ8jEiORO+0tkiRai2StxJwpurE8rD/aJ
 UkoM4y2F5fT3kAc67APYfaB7j9tNDtQvGCjcb60Z669rz2dFD/7Fxz1ci8cycEqJ8BNq1L4LzRI
 EnonTzd6M4BnFRZOQ8zGDWRJXuu2CzLsVMKtVXq2HgTSvsuax69tlv9H1q8Z2TVz00ZPU14ICe1
 2Ty5HQvMU+IxbmZ8lfz9pz/gvIuge02xha0c+A5/SQ8s4HD9XGft9nG7K4jcVRc8F7EhjOSXdtE
 OR1EYVmOl0WbPdTp/KvkAbUL7Lz8vw+Sm/+DhYQqxpxAiuPLTTMbqmM=
X-Received: by 2002:a05:6808:3514:b0:4eb:e665:bd01 with SMTP id
 5614622812f47-53cd4783f09mr4886945b6e.34.1792334231269; Sun, 18 Oct 2026
 07:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1791803914.git.waysorrypub@gmail.com>
 <8e36ee3baff3e6abef94cda37d564aeb690b161b.1791803914.git.waysorrypub@gmail.com>
 <7a2c2a6c-7ece-7e94-7216-6918558cda74@loongson.cn>
 <3c7bb90f-7b94-5d88-4f92-1b0d99c3d0e6@loongson.cn>
In-Reply-To: <3c7bb90f-7b94-5d88-4f92-1b0d99c3d0e6@loongson.cn>
From: way sorry <waysorrypub@gmail.com>
Date: Sun, 18 Oct 2026 22:36:59 +0800
X-Gm-Features: AclHuK-ZLGKw2G1FDP1r1__sfyS0KBAbPuPKxlgVjqNSnDyv71H54lIx78Hwfn0
Message-ID: <CAECqSzWofrjJgj14DB=dQOpJP-OQ5qBPM1mwJ--FKpC=g_zVTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Fix clock property name typo and
 order
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, lixianglai@loongson.cn, 
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com, 
 anisinha@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002c75f7065e1e5598"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=waysorrypub@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002c75f7065e1e5598
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Thanks for the comments. v2 drops `_CCA` from the UART and adds
`_STA =3D 0x0f`. The expected DSDT blobs have been updated, and the
5 ACPI subtests pass.

On the DT side: with Linux 7.0, removing `clock-frequency` makes all
4 UARTs report `failed to get clock`, and the real driver fails to
probe, so we are keeping the property for now. Logs:

[    0.702431] of_serial 1fe001e0.serial: error -ENOENT: failed to get cloc=
k
[    0.702884] of_serial 1fe001e0.serial: probe with driver of_serial
failed with error -2
[    0.703468] of_serial 1fe002e0.serial: error -ENOENT: failed to get cloc=
k
[    0.703718] of_serial 1fe002e0.serial: probe with driver of_serial
failed with error -2
[    0.704127] of_serial 1fe003e0.serial: error -ENOENT: failed to get cloc=
k
[    0.704371] of_serial 1fe003e0.serial: probe with driver of_serial
failed with error -2
[    0.704762] of_serial 1fe004e0.serial: error -ENOENT: failed to get cloc=
k
[    0.705013] of_serial 1fe004e0.serial: probe with driver of_serial
failed with error -2

On the ACPI side: after removing it, all 4 UARTs still register, but
`base_baud` changes from 6250000 to 115200. Logs:

With clock-frequency:
[    0.813488] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, base_baud =3D
6250000) is a 16550A
Without clock-frequency:
[    0.843528] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, base_baud =3D
115200) is a 16550A
[    0.844663] printk: legacy console [ttyS0] enabled
[    0.845209] printk: legacy bootconsole [uart0] disabled
[    0.869343] 00:01: ttyS1 at MMIO 0x1fe002e0 (irq =3D 21, base_baud =3D
115200) is a 16550A
[    0.892556] 00:02: ttyS2 at MMIO 0x1fe003e0 (irq =3D 22, base_baud =3D
115200) is a 16550A
[    0.914867] 00:03: ttyS3 at MMIO 0x1fe004e0 (irq =3D 23, base_baud =3D
115200) is a 16550A

The reason is that Linux provides a default clock of 1,843,200 Hz in
`8250_pnp.c`, which matches the current QEMU UART model:

https://github.com/torvalds/linux/blob/028ef9c96e96197026887c0f092424679298=
aae8/drivers/tty/serial/8250/8250_pnp.c

So the property is optional under Linux ACPI, but that does not mean
Linux does not use it.

So far I have only verified boot, UART registration, and console
output. I have not tested other kernels or full TX/RX behavior. We
would prefer to keep an explicit and accurate frequency description
rather than rely on a kernel-specific default. But keeping the
property does not mean keeping the current 100 MHz; the correct value
still needs discussion.

Questions: what is the advantage of omitting the ACPI clock property
here? Is there any compatibility rationale from other guest OSes that
supports omitting it?

Thanks,
pillow

On Thu, Oct 15, 2026 at 6:03=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:

>
>
> On 2026/10/15 =E4=B8=8B=E5=8D=882:57, Bibo Mao wrote:
> >
> >
> > On 2026/10/12 =E4=B8=8B=E5=8D=887:39, pillow wrote:
> >> The original code had a typo in the clock preperty name, and the
> >> property name and frequency value were in reversed order.
> >> According to the _DSD format rules, the property name string comes
> >> first, followed by the property value:
> >>
> https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#data-forma=
t-definition
> >>
> >>
> >> Signed-off-by: pillow <waysorrypub@gmail.com>
> >> ---
> >>   hw/loongarch/virt-acpi-build.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/loongarch/virt-acpi-build.c
> >> b/hw/loongarch/virt-acpi-build.c
> >> index 54965f0..4081730 100644
> >> --- a/hw/loongarch/virt-acpi-build.c
> >> +++ b/hw/loongarch/virt-acpi-build.c
> >> @@ -336,8 +336,8 @@ static void build_uart_device_aml(Aml *table, int
> >> index)
> >>                                     AML_SHARED, &uart_irq, 1));
> >>       aml_append(dev, aml_name_decl("_CRS", crs));
> >>       pkg0 =3D aml_package(0x2);
> >> +    aml_append(pkg0, aml_string("clock-frequency"));
> >>       aml_append(pkg0, aml_int(0x05F5E100));
> >> -    aml_append(pkg0, aml_string("clock-frenquency"));
> >>       pkg1 =3D aml_package(0x1);
> >>       aml_append(pkg1, pkg0);
> >>       pkg2 =3D aml_package(0x2);
> >>
> > Hi,
> >
> > yes, there is spelling issue with LoongArch virt machine UART acpi
> > table. It seems that clock-frequency is not used by serial port. is it
> > possible to remove pkg0/pkg1/pkg2 property like ISA serial acpi table
> > defined in function serial_isa_build_aml()?
> >
> > Also "_CCA" property should be removed since the emulated serial port
> > does not support DMA, and add "_STA" property.
> Also maybe property clock-frequency of uart fdt table in
> fdt_add_uart_node() can be removed.
>
> Regards
> Bibo Mao
> >
> > Regards
> > Bibo Mao
>
>

--0000000000002c75f7065e1e5598
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>Thanks for the comments. v2 drops `_CCA` fr=
om the UART and adds<br>`_STA =3D 0x0f`. The expected DSDT blobs have been =
updated, and the<br>5 ACPI subtests pass.<br><br>On the DT side: with Linux=
 7.0, removing `clock-frequency` makes all<br>4 UARTs report `failed to get=
 clock`, and the real driver fails to<br>probe, so we are keeping the prope=
rty for now. Logs:<br><br>[ =C2=A0 =C2=A00.702431] of_serial 1fe001e0.seria=
l: error -ENOENT: failed to get clock<br>[ =C2=A0 =C2=A00.702884] of_serial=
 1fe001e0.serial: probe with driver of_serial failed with error -2<br>[ =C2=
=A0 =C2=A00.703468] of_serial 1fe002e0.serial: error -ENOENT: failed to get=
 clock<br>[ =C2=A0 =C2=A00.703718] of_serial 1fe002e0.serial: probe with dr=
iver of_serial failed with error -2<br>[ =C2=A0 =C2=A00.704127] of_serial 1=
fe003e0.serial: error -ENOENT: failed to get clock<br>[ =C2=A0 =C2=A00.7043=
71] of_serial 1fe003e0.serial: probe with driver of_serial failed with erro=
r -2<br>[ =C2=A0 =C2=A00.704762] of_serial 1fe004e0.serial: error -ENOENT: =
failed to get clock<br>[ =C2=A0 =C2=A00.705013] of_serial 1fe004e0.serial: =
probe with driver of_serial failed with error -2<br><br>On the ACPI side: a=
fter removing it, all 4 UARTs still register, but<br>`base_baud` changes fr=
om 6250000 to 115200. Logs:<br><br>With clock-frequency:<br>[ =C2=A0 =C2=A0=
0.813488] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, base_baud =3D 625000=
0) is a 16550A<br>Without clock-frequency:<br>[ =C2=A0 =C2=A00.843528] 00:0=
0: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, base_baud =3D 115200) is a 16550A<=
br>[ =C2=A0 =C2=A00.844663] printk: legacy console [ttyS0] enabled<br>[ =C2=
=A0 =C2=A00.845209] printk: legacy bootconsole [uart0] disabled<br>[ =C2=A0=
 =C2=A00.869343] 00:01: ttyS1 at MMIO 0x1fe002e0 (irq =3D 21, base_baud =3D=
 115200) is a 16550A<br>[ =C2=A0 =C2=A00.892556] 00:02: ttyS2 at MMIO 0x1fe=
003e0 (irq =3D 22, base_baud =3D 115200) is a 16550A<br>[ =C2=A0 =C2=A00.91=
4867] 00:03: ttyS3 at MMIO 0x1fe004e0 (irq =3D 23, base_baud =3D 115200) is=
 a 16550A<br><br>The reason is that Linux provides a default clock of 1,843=
,200 Hz in<br>`8250_pnp.c`, which matches the current QEMU UART model:<br><=
br><a href=3D"https://github.com/torvalds/linux/blob/028ef9c96e96197026887c=
0f092424679298aae8/drivers/tty/serial/8250/8250_pnp.c">https://github.com/t=
orvalds/linux/blob/028ef9c96e96197026887c0f092424679298aae8/drivers/tty/ser=
ial/8250/8250_pnp.c</a><br><br>So the property is optional under Linux ACPI=
, but that does not mean<br>Linux does not use it.<br><br>So far I have onl=
y verified boot, UART registration, and console<br>output. I have not teste=
d other kernels or full TX/RX behavior. We<br>would prefer to keep an expli=
cit and accurate frequency description<br>rather than rely on a kernel-spec=
ific default. But keeping the<br>property does not mean keeping the current=
 100 MHz; the correct value<br>still needs discussion.<br><br>Questions: wh=
at is the advantage of omitting the ACPI clock property<br>here? Is there a=
ny compatibility rationale from other guest OSes that<br>supports omitting =
it?<br><br>Thanks,<br>pillow</div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 15, 2026 at 6=
:03=E2=80=AFPM Bibo Mao &lt;<a href=3D"mailto:maobibo@loongson.cn">maobibo@=
loongson.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
<br>
On 2026/10/15 =E4=B8=8B=E5=8D=882:57, Bibo Mao wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 2026/10/12 =E4=B8=8B=E5=8D=887:39, pillow wrote:<br>
&gt;&gt; The original code had a typo in the clock preperty name, and the<b=
r>
&gt;&gt; property name and frequency value were in reversed order.<br>
&gt;&gt; According to the _DSD format rules, the property name string comes=
<br>
&gt;&gt; first, followed by the property value:<br>
&gt;&gt; <a href=3D"https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-gui=
de.adoc#data-format-definition" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#data-format-defini=
tion</a> <br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: pillow &lt;<a href=3D"mailto:waysorrypub@gmail.com"=
 target=3D"_blank">waysorrypub@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/loongarch/virt-acpi-build.c | 2 +-<br>
&gt;&gt; =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/loongarch/virt-acpi-build.c <br>
&gt;&gt; b/hw/loongarch/virt-acpi-build.c<br>
&gt;&gt; index 54965f0..4081730 100644<br>
&gt;&gt; --- a/hw/loongarch/virt-acpi-build.c<br>
&gt;&gt; +++ b/hw/loongarch/virt-acpi-build.c<br>
&gt;&gt; @@ -336,8 +336,8 @@ static void build_uart_device_aml(Aml *table, =
int <br>
&gt;&gt; index)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AML_S=
HARED, &amp;uart_irq, 1));<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl(&quot=
;_CRS&quot;, crs));<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg0 =3D aml_package(0x2);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 aml_append(pkg0, aml_string(&quot;clock-freque=
ncy&quot;));<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(pkg0, aml_int(0x05F5E100=
));<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 aml_append(pkg0, aml_string(&quot;clock-frenqu=
ency&quot;));<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg1 =3D aml_package(0x1);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(pkg1, pkg0);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg2 =3D aml_package(0x2);<br>
&gt;&gt;<br>
&gt; Hi,<br>
&gt; <br>
&gt; yes, there is spelling issue with LoongArch virt machine UART acpi <br=
>
&gt; table. It seems that clock-frequency is not used by serial port. is it=
 <br>
&gt; possible to remove pkg0/pkg1/pkg2 property like ISA serial acpi table =
<br>
&gt; defined in function serial_isa_build_aml()?<br>
&gt; <br>
&gt; Also &quot;_CCA&quot; property should be removed since the emulated se=
rial port <br>
&gt; does not support DMA, and add &quot;_STA&quot; property.<br>
Also maybe property clock-frequency of uart fdt table in <br>
fdt_add_uart_node() can be removed.<br>
<br>
Regards<br>
Bibo Mao<br>
&gt; <br>
&gt; Regards<br>
&gt; Bibo Mao<br>
<br>
</blockquote></div>

--0000000000002c75f7065e1e5598--

