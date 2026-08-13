Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5F1C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuchG-0006cB-Tp; Thu, 13 Aug 2026 17:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1wuchC-0006b8-Gw
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 17:10:38 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1wuchA-0007x0-HM
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 17:10:38 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6ae88f4e4f4so251647eaf.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 14:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786655435; cv=none;
 d=google.com; s=arc-20260327;
 b=F/LBOLckHjyaffH3UQnY/is8asntEQZsgb22Xnzxp3tTsx9BKai92Y0QrFSE+3acZO
 NGirHc5yzjEafBh+CpDHfSwj7qLVK3ySNyIDmmTREvUunpv+28CE4J1loQeZtHuD00Mw
 jmpYt3EYHZ8OL0EmQnJur4Q/LFqLVX7CtAed4KNAdou2FUXaxnkjgAj6bNfGFCmaHvZO
 /MY12Nwu1tJXtxB6dVQZBio3AyZwqIZU2OOwLeUs4Iis3EecKDVgEu+DTQvHsf/1ZQzs
 gCvwiYL8aI1oBLM1Ml3F8/wAZYyvODrXZoCkK0yPbTaMhazWAHsO4MECdbZMA6xk5zbc
 D5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f56CoFxFguticBzD2aaadsF5hA52TrO6cNg9NRRTkBw=;
 fh=8THZ04zpF3kLX/97Wi/+EZPHVfKaalmwxkKpJngdYYo=;
 b=j1RnKOUwn0YvhHR3BzCixs1ib0LQFPk8j5NEoNOVrtuRxOOIBVadwgTqOpKVdTOC5Q
 2IcRmjRwChEjfhleGxRK0s5zBKKHRhSz+6CW1QkUUuHBab2/F12nmRlIRRBK5wp1om2J
 j5kHkF5vZYuCzSsDlYQaCVux4mRnnSJrMO2MEeGvOcDBoyZhBXfYNA+c+3ifxMoSI6B4
 ONwfkUFUS04mrA+yoO9KnEEWyrewQ5RenJxw7o9rL57btR8w48J2LvYhkRo3gjPjFtHl
 KNGV9bKEc8Cs6firPZlSVoAXXhjwYy4uDtUtA4RtqZfMDSVZDGErtktNBZfg+EyW4Jxu
 egLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786655435; x=1787260235; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f56CoFxFguticBzD2aaadsF5hA52TrO6cNg9NRRTkBw=;
 b=QIDAyOV8xBZd64D5lT5e/y0RboNXl3XQgpJ64VtPoHWDyaTHBvrfLc3+D/ZXMzMS4v
 aTxYxnj5Eh4wMMuW/lkXHCh1uGzuA08GvdeJZVprJuuWSknpu6r+G4KxIw0iqAJoACqx
 hSLq2m1uNAVkWAH/FBVVajfJEDpFO2uTMxS8qyO7pMFMdI1HHfxhFlAYPRfMbKr0/w5k
 bkxoSLDCgKxI7i5aULHo+pX8UHYJRAHllX3v0CgkkKZqOlgqKfbrrXGgs7Bs7RyeKLOx
 a2LqV+gvvN6iikvM7ZHLuDrybLNOCORRFrCUDMuQPuuBMGC08AtDy/zzVD22QmLT2vMi
 QzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786655435; x=1787260235;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f56CoFxFguticBzD2aaadsF5hA52TrO6cNg9NRRTkBw=;
 b=WjvfRAB6TxLtKhul5xTtgs6Ic1VxlDvN7/Bm7n9I3GBCu//hnJYBQewXwro0hRJECc
 QkUEv2FM5eHgc8pgTJBARlVBVPL2FiLwVbWv8FT02ccBxwesg7i3vPSmPhnHf5ofxTLR
 KVvKne0gTseInDAu7ZpTNPvXhew+kWgvf75Dej+vyTi9daOT7yZ97Y2vAx0MiKaDgnCX
 fInM3RK1/l4sli5WhWDhjVSuGiVrSTVNPBjN8GTynuFIlthTeA8qUYiSHM1VJlwKxSiY
 oYv/QZcYan4qWTCog5qsCy5xlVwMDSOM5RJZTiAN1a+jys5xOw/YTJWRZo81JSDnBKzA
 A62A==
X-Gm-Message-State: AOJu0Yw5I07qDUABCJeKcFwRS30mVPdIiPhOUSdjfBhCCpb/fh1s7+PM
 HPG+iI9K29hpUCGhXQ9/1QGQxP5Zp9xg5e1emKaEhVbrNw9W/kyFvuYKYW04qAxtOn9TRB4DfsG
 BkMO8DryqkE48Bz86q0nmXzvdy+0z1LM=
X-Gm-Gg: AR+sD11jVHQR2EXmyLFjUVsdtFtm8kmv5cb9pcyw6yCl0Nu4q8aRoEFbn6rIbJYGmtN
 Fwbof4c0SV7wALI7Nq5ZUULjU5Ua9AHXZxZ4erWy1gpQDoaUXCU4RDXQTvhGS9tAh42rw2P6lX8
 A1+72JLsVyVBd7pkQ5uO441rDHwG3GxR1G+40OMWveq3sDwoyB5WX1KegE/DSY9p6/s0/jiCoLm
 t38WnjSidmDS8O7LkPMHDLpCBj+dtTJ6lCH4LcN9VqdbPgHMSslrKE5pPgLmZ/arvhynaJifuXf
 MCIg4c7CKBomXpSn2F6SbdyNHdS629Rjsudm2Wk64TsqcpM6HHLPVKx/KlxUgbW1ON0KmZ8nzm/
 4qZg10XVNcmxROMeXpsSWdEv1i1VAUQ==
X-Received: by 2002:a05:6820:4ccc:b0:6a3:7341:f6ed with SMTP id
 006d021491bc7-6b0d5fca9famr1250294eaf.1.1786655434868; Thu, 13 Aug 2026
 14:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260813154918.996812-1-bin.meng@processmission.com>
 <20260813154918.996812-17-bin.meng@processmission.com>
In-Reply-To: <20260813154918.996812-17-bin.meng@processmission.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 13 Aug 2026 23:10:23 +0200
X-Gm-Features: AUfX_mxetUI3LzQGsQe_zY8IZFIeRFbSFh3N1oolDgO64cqiD4UkDiLhv3x6PYQ
Message-ID: <CAPan3WoTubzEHGdCKs0tbDKLAms3Y9JG2QVd2Uydh4sVec7u4w@mail.gmail.com>
Subject: Re: [PATCH 16/20] hw/arm: orangepi: Store boot info in the machine
 state
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000880a240658f42277"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-oo1-xc2e.google.com
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

--000000000000880a240658f42277
Content-Type: text/plain; charset="UTF-8"

Op do 13 aug. 2026 17:51 schreef Bin Meng <bin.meng@processmission.com>:

> arm_load_kernel() keeps a pointer to the boot info struct for the
> lifetime of the VM, so the struct logically belongs to the machine
> rather than to a file scoped static object.
>
> Move it into a new OrangePiMachineState and register the machine type
> explicitly instead of through the DEFINE_MACHINE_ARM macro.
>
> As in the xlnx-zcu102 and raspi machines, the boot info belongs to
> the machine rather than to a static object:
>
> 4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
> 0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to
> RaspiMachineState")
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

---
>
>  hw/arm/orangepi.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index d84443bb7b..5b2c13f364 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -28,10 +28,18 @@
>  #include "hw/arm/boot.h"
>  #include "hw/arm/machines-qom.h"
>
> -static struct arm_boot_info orangepi_binfo;
> +#define TYPE_ORANGEPI_MACHINE MACHINE_TYPE_NAME("orangepi-pc")
> +OBJECT_DECLARE_SIMPLE_TYPE(OrangePiMachineState, ORANGEPI_MACHINE)
> +
> +struct OrangePiMachineState {
> +    MachineState parent;
> +
> +    struct arm_boot_info bootinfo;
> +};
>
>  static void orangepi_init(MachineState *machine)
>  {
> +    OrangePiMachineState *opms = ORANGEPI_MACHINE(machine);
>      AwH3State *h3;
>      DriveInfo *di;
>      BlockBackend *blk;
> @@ -98,14 +106,16 @@ static void orangepi_init(MachineState *machine)
>          /* Use Boot ROM to copy data from SD card to SRAM */
>          allwinner_h3_bootrom_setup(h3, blk);
>      }
> -    orangepi_binfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
> -    orangepi_binfo.ram_size = machine->ram_size;
> -    orangepi_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
> -    arm_load_kernel(&h3->cpus[0], machine, &orangepi_binfo);
> +    opms->bootinfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
> +    opms->bootinfo.ram_size = machine->ram_size;
> +    opms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
> +    arm_load_kernel(&h3->cpus[0], machine, &opms->bootinfo);
>  }
>
> -static void orangepi_machine_init(MachineClass *mc)
> +static void orangepi_machine_class_init(ObjectClass *oc, const void *data)
>  {
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
>      static const char * const valid_cpu_types[] = {
>          ARM_CPU_TYPE_NAME("cortex-a7"),
>          NULL
> @@ -125,4 +135,17 @@ static void orangepi_machine_init(MachineClass *mc)
>      mc->auto_create_sdcard = true;
>  }
>
> -DEFINE_MACHINE_ARM("orangepi-pc", orangepi_machine_init)
> +static const TypeInfo orangepi_machine_typeinfo = {
> +    .name = TYPE_ORANGEPI_MACHINE,
> +    .parent = TYPE_MACHINE,
> +    .class_init = orangepi_machine_class_init,
> +    .instance_size = sizeof(OrangePiMachineState),
> +    .interfaces = arm_machine_interfaces,
> +};
> +
> +static void orangepi_machine_register_types(void)
> +{
> +    type_register_static(&orangepi_machine_typeinfo);
> +}
> +
> +type_init(orangepi_machine_register_types)
> --
> 2.53.0
>
>

--000000000000880a240658f42277
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div><br></div><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">Op do 13 aug. 2026 17:51 =
schreef Bin Meng &lt;<a href=3D"mailto:bin.meng@processmission.com">bin.men=
g@processmission.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">arm_l=
oad_kernel() keeps a pointer to the boot info struct for the<br>
lifetime of the VM, so the struct logically belongs to the machine<br>
rather than to a file scoped static object.<br>
<br>
Move it into a new OrangePiMachineState and register the machine type<br>
explicitly instead of through the DEFINE_MACHINE_ARM macro.<br>
<br>
As in the xlnx-zcu102 and raspi machines, the boot info belongs to<br>
the machine rather than to a static object:<br>
<br>
4d1ac883a7 (&quot;hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102&q=
uot;)<br>
0f15c6e338 (&quot;hw/arm/raspi: Move arm_boot_info structure to RaspiMachin=
eState&quot;)<br>
<br>
Signed-off-by: Bin Meng &lt;<a href=3D"mailto:bin.meng@processmission.com" =
target=3D"_blank" rel=3D"noreferrer">bin.meng@processmission.com</a>&gt;<br=
></blockquote></div></div><div dir=3D"auto">Reviewed-by: Niek Linnenbank &l=
t;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&=
gt;</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
<br>
=C2=A0hw/arm/orangepi.c | 37 ++++++++++++++++++++++++++++++-------<br>
=C2=A01 file changed, 30 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
index d84443bb7b..5b2c13f364 100644<br>
--- a/hw/arm/orangepi.c<br>
+++ b/hw/arm/orangepi.c<br>
@@ -28,10 +28,18 @@<br>
=C2=A0#include &quot;hw/arm/boot.h&quot;<br>
=C2=A0#include &quot;hw/arm/machines-qom.h&quot;<br>
<br>
-static struct arm_boot_info orangepi_binfo;<br>
+#define TYPE_ORANGEPI_MACHINE MACHINE_TYPE_NAME(&quot;orangepi-pc&quot;)<b=
r>
+OBJECT_DECLARE_SIMPLE_TYPE(OrangePiMachineState, ORANGEPI_MACHINE)<br>
+<br>
+struct OrangePiMachineState {<br>
+=C2=A0 =C2=A0 MachineState parent;<br>
+<br>
+=C2=A0 =C2=A0 struct arm_boot_info bootinfo;<br>
+};<br>
<br>
=C2=A0static void orangepi_init(MachineState *machine)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 OrangePiMachineState *opms =3D ORANGEPI_MACHINE(machine);<br=
>
=C2=A0 =C2=A0 =C2=A0AwH3State *h3;<br>
=C2=A0 =C2=A0 =C2=A0DriveInfo *di;<br>
=C2=A0 =C2=A0 =C2=A0BlockBackend *blk;<br>
@@ -98,14 +106,16 @@ static void orangepi_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use Boot ROM to copy data from SD card=
 to SRAM */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allwinner_h3_bootrom_setup(h3, blk);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 orangepi_binfo.loader_start =3D h3-&gt;memmap[AW_H3_DEV_SDRA=
M];<br>
-=C2=A0 =C2=A0 orangepi_binfo.ram_size =3D machine-&gt;ram_size;<br>
-=C2=A0 =C2=A0 orangepi_binfo.psci_conduit =3D QEMU_PSCI_CONDUIT_SMC;<br>
-=C2=A0 =C2=A0 arm_load_kernel(&amp;h3-&gt;cpus[0], machine, &amp;orangepi_=
binfo);<br>
+=C2=A0 =C2=A0 opms-&gt;bootinfo.loader_start =3D h3-&gt;memmap[AW_H3_DEV_S=
DRAM];<br>
+=C2=A0 =C2=A0 opms-&gt;bootinfo.ram_size =3D machine-&gt;ram_size;<br>
+=C2=A0 =C2=A0 opms-&gt;bootinfo.psci_conduit =3D QEMU_PSCI_CONDUIT_SMC;<br=
>
+=C2=A0 =C2=A0 arm_load_kernel(&amp;h3-&gt;cpus[0], machine, &amp;opms-&gt;=
bootinfo);<br>
=C2=A0}<br>
<br>
-static void orangepi_machine_init(MachineClass *mc)<br>
+static void orangepi_machine_class_init(ObjectClass *oc, const void *data)=
<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0static const char * const valid_cpu_types[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARM_CPU_TYPE_NAME(&quot;cortex-a7&quot;),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL<br>
@@ -125,4 +135,17 @@ static void orangepi_machine_init(MachineClass *mc)<br=
>
=C2=A0 =C2=A0 =C2=A0mc-&gt;auto_create_sdcard =3D true;<br>
=C2=A0}<br>
<br>
-DEFINE_MACHINE_ARM(&quot;orangepi-pc&quot;, orangepi_machine_init)<br>
+static const TypeInfo orangepi_machine_typeinfo =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_ORANGEPI_MACHINE,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,<br>
+=C2=A0 =C2=A0 .class_init =3D orangepi_machine_class_init,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(OrangePiMachineState),<br>
+=C2=A0 =C2=A0 .interfaces =3D arm_machine_interfaces,<br>
+};<br>
+<br>
+static void orangepi_machine_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;orangepi_machine_typeinfo);<br>
+}<br>
+<br>
+type_init(orangepi_machine_register_types)<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div></div>

--000000000000880a240658f42277--

