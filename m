Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E980C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI4mh-00066H-Ep; Fri, 14 Jun 2024 07:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sI4mf-000656-5g; Fri, 14 Jun 2024 07:07:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sI4mc-0000AI-UO; Fri, 14 Jun 2024 07:07:52 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57c923e03caso2221204a12.3; 
 Fri, 14 Jun 2024 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718363263; x=1718968063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+qFK3vcKlDVOP4/ltWPGwA7q/khSRTrFYIyxE6c1n9Q=;
 b=mj020RQMzumfCDNSxsJTEgZT+ZqT/s/phNi1xSaraIJDXhyMZE2Khts4fpiHKYiNa3
 rAEOja6mYiOvz7iXEQ51Gqpc5QWhQ8aSfvzWqZaeHXFtPklL30GH0ei5zpVzVV/Tvnu+
 OjNodoofXY336eDNPcKLcBJHkUg+F/ntsoZLLeW+xSjzuQg+a+xFyJ0ZoJC8BdY/C65y
 FuqrzltRuF/NWBOA8rIPmGYYDnlQaYeZDgC6BCWVfmD5RfNzMqGf3O1upDhNrmWRso3C
 a0Q/g98B8qBfYBakzHnLpsFtjbiQCt2+TQD2KEKq/bi7lx8AzPPD1QYsPk234pGlZtGW
 H7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718363263; x=1718968063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+qFK3vcKlDVOP4/ltWPGwA7q/khSRTrFYIyxE6c1n9Q=;
 b=GhSJVHTW4KOiKZ/2vApgJxX1Ai6aajIp+mYpFdyRLSrwlgkzioHDrvOaZ7l2VzAeeQ
 5aqlEz4XIl1AKvCT4wplf6v/DLtE4Qee23pPiUXVw4ASMeC/sE4LYeb0SZm7q6zhQcKu
 Jqf7fzZC6SqPic4RF75ifltEE7eGG2HD914XzeUxgSuMSMumYEw9oHgyIQ4a4V6at6a3
 iDjuOWsSYTeVBcowrkGubXmkyG21hfVRU0GQVdBoH/oiy8CMqV+Ljcmr3C+gZjPUsbz0
 KKjVkFLfxN9geBMBTjAp2FG+xodwa+KtZ4/sgrnkMeol2XJ4eA1SNJsc/RpRKXp5utED
 R1Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/f8trxKsdbADeasqhS/L6N35tM+HGIESjV9kWCRHz+rhji7Y3gEnh/CAI2mQlKls9V/2gn2z4TBdwp2U0rklQhNqweFE=
X-Gm-Message-State: AOJu0YzvhaeHDkH8PM9ji3hY9MMERiAI837ZfpaEeJ30w4qordHKrCFV
 TIJJyRwELnRoGyJdVVCbEukJtyFyZEUplEG3tvdHigxlLd0/LDGvmT8eb9B/GpVv95JMKj+2jhf
 xC3mj6nPTDWjija5csH/Is+4ZU07LL16rWcMd2A==
X-Google-Smtp-Source: AGHT+IECb2gm5BV7nrmZie0Dz+FxS240D5aVwNFsLDMxzWwWwcH0UVvUXV0T6XrAfEhmR8q/O0e/QLozcHvTOLNfARY=
X-Received: by 2002:a50:d502:0:b0:57c:a570:960f with SMTP id
 4fb4d7f45d1cf-57cbd67dba6mr1597881a12.21.1718363262819; Fri, 14 Jun 2024
 04:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240613153638.3858853-1-sai.pavan.boddu@amd.com>
 <20240613153638.3858853-3-sai.pavan.boddu@amd.com>
In-Reply-To: <20240613153638.3858853-3-sai.pavan.boddu@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 14 Jun 2024 13:07:30 +0200
Message-ID: <CAJy5ezoo5bCMVG6GETvWTYn-y0VEFths0Uj3foXMQbyKPduU=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/xilinx_zynq: Add boot-mode property
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, francisco.iglesias@amd.com
Content-Type: multipart/alternative; boundary="000000000000e02385061ad79f6e"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000e02385061ad79f6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:36=E2=80=AFPM Sai Pavan Boddu <sai.pavan.boddu@am=
d.com>
wrote:

> Read boot-mode value as machine property and propagate that to
> SLCR.BOOT_MODE register.
>
>
Hi Sai,

Directly exposing the register field to the user to set on the command-line
probably makes usability a little too rough (user has to check the register
specs in the TRM to change boot-mode).
We could perhaps add friendly names that we internally map to the register
field values.

Another question, can we use the existing -boot command-line arg for this?
Something along the lines of what x86 PC does:
https://github.com/qemu/qemu/blob/master/hw/i386/pc.c#L395

I don't know if the framework allows for long names but something like the
following would be nice:
qemu -boot spi,ethernet,jtag,uart,etc

Would also be great to document a small example, perhaps in
https://github.com/qemu/qemu/tree/master/docs/system/arm

Best regards,
Edgar



> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
>  hw/arm/xilinx_zynq.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 7f7a3d23fb..4dfa9184ac 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -38,6 +38,7 @@
>  #include "qom/object.h"
>  #include "exec/tswap.h"
>  #include "target/arm/cpu-qom.h"
> +#include "qapi/visitor.h"
>
>  #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
>  OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
> @@ -90,6 +91,7 @@ struct ZynqMachineState {
>      MachineState parent;
>      Clock *ps_clk;
>      ARMCPU *cpu[ZYNQ_MAX_CPUS];
> +    uint8_t BootMode;
>  };
>
>  static void zynq_write_board_setup(ARMCPU *cpu,
> @@ -176,6 +178,19 @@ static inline int zynq_init_spi_flashes(uint32_t
> base_addr, qemu_irq irq,
>      return unit;
>  }
>
> +static void zynq_set_boot_mode(Object *obj, Visitor *v,
> +                               const char *name, void *opaque,
> +                               Error **errp)
> +{
> +    ZynqMachineState *m =3D ZYNQ_MACHINE(obj);
> +    uint8_t val;
> +
> +    if (!visit_type_uint8(v, name, &val, errp)) {
> +        return;
> +    }
> +    m->BootMode =3D val;
> +}
> +
>  static void zynq_init(MachineState *machine)
>  {
>      ZynqMachineState *zynq_machine =3D ZYNQ_MACHINE(machine);
> @@ -241,6 +256,7 @@ static void zynq_init(MachineState *machine)
>      /* Create slcr, keep a pointer to connect clocks */
>      slcr =3D qdev_new("xilinx-zynq_slcr");
>      qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
> +    qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->BootMode);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
>
> @@ -372,6 +388,7 @@ static void zynq_machine_class_init(ObjectClass *oc,
> void *data)
>          NULL
>      };
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    ObjectProperty *prop;
>      mc->desc =3D "Xilinx Zynq Platform Baseboard for Cortex-A9";
>      mc->init =3D zynq_init;
>      mc->max_cpus =3D ZYNQ_MAX_CPUS;
> @@ -379,6 +396,11 @@ static void zynq_machine_class_init(ObjectClass *oc,
> void *data)
>      mc->ignore_memory_transaction_failures =3D true;
>      mc->valid_cpu_types =3D valid_cpu_types;
>      mc->default_ram_id =3D "zynq.ext_ram";
> +    prop =3D object_class_property_add(oc, "boot-mode", "uint8_t", NULL,
> +                              zynq_set_boot_mode, NULL, NULL);
> +    object_class_property_set_description(oc, "boot-mode",
> +                                          "Update SLCR.BOOT_MODE
> register");
> +    object_property_set_default_uint(prop, 1);
>  }
>
>  static const TypeInfo zynq_machine_type =3D {
> --
> 2.34.1
>
>

--000000000000e02385061ad79f6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jun 13, 2024 at 5:36=E2=80=AFPM S=
ai Pavan Boddu &lt;<a href=3D"mailto:sai.pavan.boddu@amd.com">sai.pavan.bod=
du@amd.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Read boot-mode value as machine proper=
ty and propagate that to<br>
SLCR.BOOT_MODE register.<br>
<br></blockquote><div><br></div><div>Hi Sai,</div><div><br></div><div>Direc=
tly exposing the register field to the user to set on the command-line prob=
ably makes usability a little too rough (user has to check the register spe=
cs in the TRM to change boot-mode).</div><div>We could perhaps add friendly=
 names that we internally map to the register field values.</div><div><br><=
/div><div>Another question, can we use the existing -boot command-line arg =
for this?</div><div>Something along the lines of what x86 PC does:</div><di=
v><a href=3D"https://github.com/qemu/qemu/blob/master/hw/i386/pc.c#L395">ht=
tps://github.com/qemu/qemu/blob/master/hw/i386/pc.c#L395</a><br></div><div>=
<br></div><div>I don&#39;t know if the framework allows for long names but =
something like the following would be nice:</div><div>qemu -boot spi,ethern=
et,jtag,uart,etc</div><div><br></div><div>Would also be great to document a=
 small example, perhaps in=C2=A0<a href=3D"https://github.com/qemu/qemu/tre=
e/master/docs/system/arm">https://github.com/qemu/qemu/tree/master/docs/sys=
tem/arm</a></div><div><br></div><div>Best regards,</div><div>Edgar</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Signed-off-by: Sai Pavan Boddu &lt;<a href=3D"mailto:sai.pavan.boddu@amd.co=
m" target=3D"_blank">sai.pavan.boddu@amd.com</a>&gt;<br>
---<br>
=C2=A0hw/arm/xilinx_zynq.c | 22 ++++++++++++++++++++++<br>
=C2=A01 file changed, 22 insertions(+)<br>
<br>
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c<br>
index 7f7a3d23fb..4dfa9184ac 100644<br>
--- a/hw/arm/xilinx_zynq.c<br>
+++ b/hw/arm/xilinx_zynq.c<br>
@@ -38,6 +38,7 @@<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
=C2=A0#include &quot;exec/tswap.h&quot;<br>
=C2=A0#include &quot;target/arm/cpu-qom.h&quot;<br>
+#include &quot;qapi/visitor.h&quot;<br>
<br>
=C2=A0#define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME(&quot;xilinx-zynq-a9&quot=
;)<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)<br>
@@ -90,6 +91,7 @@ struct ZynqMachineState {<br>
=C2=A0 =C2=A0 =C2=A0MachineState parent;<br>
=C2=A0 =C2=A0 =C2=A0Clock *ps_clk;<br>
=C2=A0 =C2=A0 =C2=A0ARMCPU *cpu[ZYNQ_MAX_CPUS];<br>
+=C2=A0 =C2=A0 uint8_t BootMode;<br>
=C2=A0};<br>
<br>
=C2=A0static void zynq_write_board_setup(ARMCPU *cpu,<br>
@@ -176,6 +178,19 @@ static inline int zynq_init_spi_flashes(uint32_t base_=
addr, qemu_irq irq,<br>
=C2=A0 =C2=A0 =C2=A0return unit;<br>
=C2=A0}<br>
<br>
+static void zynq_set_boot_mode(Object *obj, Visitor *v,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *opaque,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ZynqMachineState *m =3D ZYNQ_MACHINE(obj);<br>
+=C2=A0 =C2=A0 uint8_t val;<br>
+<br>
+=C2=A0 =C2=A0 if (!visit_type_uint8(v, name, &amp;val, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 m-&gt;BootMode =3D val;<br>
+}<br>
+<br>
=C2=A0static void zynq_init(MachineState *machine)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ZynqMachineState *zynq_machine =3D ZYNQ_MACHINE(machine=
);<br>
@@ -241,6 +256,7 @@ static void zynq_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0/* Create slcr, keep a pointer to connect clocks */<br>
=C2=A0 =C2=A0 =C2=A0slcr =3D qdev_new(&quot;xilinx-zynq_slcr&quot;);<br>
=C2=A0 =C2=A0 =C2=A0qdev_connect_clock_in(slcr, &quot;ps_clk&quot;, zynq_ma=
chine-&gt;ps_clk);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint8(slcr, &quot;boot-mode&quot;, zynq_machin=
e-&gt;BootMode);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &amp;err=
or_fatal);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);<b=
r>
<br>
@@ -372,6 +388,7 @@ static void zynq_machine_class_init(ObjectClass *oc, vo=
id *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+=C2=A0 =C2=A0 ObjectProperty *prop;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;desc =3D &quot;Xilinx Zynq Platform Baseboard fo=
r Cortex-A9&quot;;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D zynq_init;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D ZYNQ_MAX_CPUS;<br>
@@ -379,6 +396,11 @@ static void zynq_machine_class_init(ObjectClass *oc, v=
oid *data)<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;ignore_memory_transaction_failures =3D true;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;valid_cpu_types =3D valid_cpu_types;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_id =3D &quot;zynq.ext_ram&quot;;<br>
+=C2=A0 =C2=A0 prop =3D object_class_property_add(oc, &quot;boot-mode&quot;=
, &quot;uint8_t&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zynq_set_boot_mode, NULL, NULL);<br>
+=C2=A0 =C2=A0 object_class_property_set_description(oc, &quot;boot-mode&qu=
ot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;Update SLCR.BOOT_MODE register&quot;);<br>
+=C2=A0 =C2=A0 object_property_set_default_uint(prop, 1);<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo zynq_machine_type =3D {<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000e02385061ad79f6e--

