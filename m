Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76967C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 12:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJus5-0004mY-0h; Wed, 19 Jun 2024 08:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJus3-0004m0-5q; Wed, 19 Jun 2024 08:57:03 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJus1-0001US-1m; Wed, 19 Jun 2024 08:57:02 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57c68682d1aso7564029a12.3; 
 Wed, 19 Jun 2024 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718801818; x=1719406618; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GykKotq+Xu6NBL9HsTh683SxXw7P1fYNZfL+DkQRrLY=;
 b=KYivfY22OxBpabK2hfZzLEJHkT0liyr91DKInaJuzIeRG3PgpvY7HGv4A0xqflgYgn
 m9wOsUS6yIZpBLG0tG3bo9/lHBjIF7Irtb/FbUSupk0JGcjs2Ht3xFoYGKSq5zJadVFY
 ZvpySqJfQ/fgtJ3pPKkJdVHXPjjlalu2as9C9yPh6VZ1vJgNVJ9ovgG4MFphbm9V8/oA
 BlkJ44F1AVF7Rv0crT4IREPDDwIwXyBc59eU69I4dGWQVvq9C162fqkl+f3LUZswgQzL
 YA3XXowWSsCfPJbz0hLzxaQ/HRL+OGXYrI6jqE8RiLZ+KN5cqb08txne929giQJsGoBT
 S8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718801818; x=1719406618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GykKotq+Xu6NBL9HsTh683SxXw7P1fYNZfL+DkQRrLY=;
 b=dp4jcYmFdtiUuNNzSIyazvSG56FzjsJFWCM6wof1tPLVZOCcVFA6g3M29dnTQ9mejR
 zyolO0lPz9GQ9YANQxnQ5rhRvC8h0asCrGmQ2W3E0WZ9B8wNVdnukeE21GHmXJeohZ9E
 mMIDcgZvZnJW9x9nWYtPYes4rh0vZ+HdwUTEb9zWi4PB05SDICIO+V5fFjQSFRZ4K942
 t/1GEd0FpJJtA820yo9L/tG5VjBiFDaLWxAKvLNaAXbc285HwMFyKCHiCqDJ6pPpJEXV
 qsL9jwCJbeo2/vYTufCGUyEF8bihiJw423q4tEUxymKH6uHyWUiRKvPZuN6iSSV9jKQZ
 8q7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdwhx+DJ8KfP/oUI1i4IgayJCoGZ9zLymPml0WNuVoiDFtNfJHn8f27pfeg5Z2QVBpUqs+oWkh3+2oeBP5WmN1dMu5x4E=
X-Gm-Message-State: AOJu0YyZv9Z450Mc7pBTuB/yyIosk5HJnSQY3KS0pRrGUIN+cVBi7nou
 JyNIjvKW0XO3SpR5zNZTS2itpytrVRm0Wzxd5W5Cu/2wdRKoDAtsqhEnRtzQ80MnJL+YEM8c4qd
 FZTFvqL7m/BO4ZJ7IM+wDg5gy5mQ=
X-Google-Smtp-Source: AGHT+IEI674xXk3SxGjKgNjyODm2+p/sFr9A9l97NImERkuBsMrV96mJBL5T0ODXZkclgXIgroATm+qvr3l3VRoCtw4=
X-Received: by 2002:a50:d5dd:0:b0:578:649e:e63e with SMTP id
 4fb4d7f45d1cf-57d07e43795mr1303341a12.16.1718801818374; Wed, 19 Jun 2024
 05:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240619091632.2825550-1-sai.pavan.boddu@amd.com>
 <20240619091632.2825550-3-sai.pavan.boddu@amd.com>
In-Reply-To: <20240619091632.2825550-3-sai.pavan.boddu@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 19 Jun 2024 14:56:46 +0200
Message-ID: <CAJy5ezqp5suYCceq-=7Q=_kvuj2tvkoNm=_TxmP4JEXwBpObaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/arm/xilinx_zynq: Add boot-mode property
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, francisco.iglesias@amd.com
Content-Type: multipart/alternative; boundary="000000000000d2d91f061b3dbb1b"
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

--000000000000d2d91f061b3dbb1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:16=E2=80=AFAM Sai Pavan Boddu <sai.pavan.boddu@a=
md.com>
wrote:

> Read boot-mode value as machine property and propagate that to
> SLCR.BOOT_MODE register.
>
>
Hi Sai,

It seems a little odd to have -machine boot-mode and -boot. Perhaps someone
else has a better idea how this could be done?

Anyway, I'm OK with your approach:
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
>  hw/arm/xilinx_zynq.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 7f7a3d23fbe..39f07e6dfd8 100644
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
> +    uint8_t boot_mode;
>  };
>
>  static void zynq_write_board_setup(ARMCPU *cpu,
> @@ -176,6 +178,27 @@ static inline int zynq_init_spi_flashes(uint32_t
> base_addr, qemu_irq irq,
>      return unit;
>  }
>
> +static void zynq_set_boot_mode(Object *obj, const char *str,
> +                                               Error **errp)
> +{
> +    ZynqMachineState *m =3D ZYNQ_MACHINE(obj);
> +    uint8_t mode =3D 0;
> +
> +    if (!strcasecmp(str, "QSPI")) {
> +        mode =3D 1;
> +    } else if (!strcasecmp(str, "SD")) {
> +        mode =3D 5;
> +    } else if (!strcasecmp(str, "NOR")) {
> +        mode =3D 2;
> +    } else if (!strcasecmp(str, "JTAG")) {
> +        mode =3D 0;
> +    } else {
> +        error_setg(errp, "%s bootmode is not supported", str);
> +        return;
> +    }
> +    m->boot_mode =3D mode;
> +}
> +
>  static void zynq_init(MachineState *machine)
>  {
>      ZynqMachineState *zynq_machine =3D ZYNQ_MACHINE(machine);
> @@ -241,6 +264,7 @@ static void zynq_init(MachineState *machine)
>      /* Create slcr, keep a pointer to connect clocks */
>      slcr =3D qdev_new("xilinx-zynq_slcr");
>      qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
> +    qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->boot_mode);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
>
> @@ -372,6 +396,7 @@ static void zynq_machine_class_init(ObjectClass *oc,
> void *data)
>          NULL
>      };
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    ObjectProperty *prop;
>      mc->desc =3D "Xilinx Zynq Platform Baseboard for Cortex-A9";
>      mc->init =3D zynq_init;
>      mc->max_cpus =3D ZYNQ_MAX_CPUS;
> @@ -379,6 +404,12 @@ static void zynq_machine_class_init(ObjectClass *oc,
> void *data)
>      mc->ignore_memory_transaction_failures =3D true;
>      mc->valid_cpu_types =3D valid_cpu_types;
>      mc->default_ram_id =3D "zynq.ext_ram";
> +    prop =3D object_class_property_add_str(oc, "boot-mode", NULL,
> +                              zynq_set_boot_mode);
> +    object_class_property_set_description(oc, "boot-mode",
> +                                          "Supported boot modes:"
> +                                          " JTAG QSPI SD NOR");
> +    object_property_set_default_str(prop, "QSPI");
>  }
>
>  static const TypeInfo zynq_machine_type =3D {
> --
> 2.34.1
>
>

--000000000000d2d91f061b3dbb1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 19, 2024 at 11:16=E2=80=AFAM =
Sai Pavan Boddu &lt;<a href=3D"mailto:sai.pavan.boddu@amd.com">sai.pavan.bo=
ddu@amd.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Read boot-mode value as machine prope=
rty and propagate that to<br>
SLCR.BOOT_MODE register.<br>
<br></blockquote><div><br></div><div>Hi Sai,</div><div><br></div><div>It se=
ems a little odd to have -machine boot-mode=C2=A0and -boot. Perhaps someone=
 else has a better idea how this could be done?</div><div><br></div><div>An=
yway, I&#39;m OK with your approach:</div><div>Acked-by: Edgar E. Iglesias =
&lt;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt=
;<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
Signed-off-by: Sai Pavan Boddu &lt;<a href=3D"mailto:sai.pavan.boddu@amd.co=
m" target=3D"_blank">sai.pavan.boddu@amd.com</a>&gt;<br>
---<br>
=C2=A0hw/arm/xilinx_zynq.c | 31 +++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 31 insertions(+)<br>
<br>
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c<br>
index 7f7a3d23fbe..39f07e6dfd8 100644<br>
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
+=C2=A0 =C2=A0 uint8_t boot_mode;<br>
=C2=A0};<br>
<br>
=C2=A0static void zynq_write_board_setup(ARMCPU *cpu,<br>
@@ -176,6 +178,27 @@ static inline int zynq_init_spi_flashes(uint32_t base_=
addr, qemu_irq irq,<br>
=C2=A0 =C2=A0 =C2=A0return unit;<br>
=C2=A0}<br>
<br>
+static void zynq_set_boot_mode(Object *obj, const char *str,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ZynqMachineState *m =3D ZYNQ_MACHINE(obj);<br>
+=C2=A0 =C2=A0 uint8_t mode =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (!strcasecmp(str, &quot;QSPI&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 1;<br>
+=C2=A0 =C2=A0 } else if (!strcasecmp(str, &quot;SD&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 5;<br>
+=C2=A0 =C2=A0 } else if (!strcasecmp(str, &quot;NOR&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 2;<br>
+=C2=A0 =C2=A0 } else if (!strcasecmp(str, &quot;JTAG&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 0;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s bootmode is not supp=
orted&quot;, str);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 m-&gt;boot_mode =3D mode;<br>
+}<br>
+<br>
=C2=A0static void zynq_init(MachineState *machine)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ZynqMachineState *zynq_machine =3D ZYNQ_MACHINE(machine=
);<br>
@@ -241,6 +264,7 @@ static void zynq_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0/* Create slcr, keep a pointer to connect clocks */<br>
=C2=A0 =C2=A0 =C2=A0slcr =3D qdev_new(&quot;xilinx-zynq_slcr&quot;);<br>
=C2=A0 =C2=A0 =C2=A0qdev_connect_clock_in(slcr, &quot;ps_clk&quot;, zynq_ma=
chine-&gt;ps_clk);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint8(slcr, &quot;boot-mode&quot;, zynq_machin=
e-&gt;boot_mode);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &amp;err=
or_fatal);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);<b=
r>
<br>
@@ -372,6 +396,7 @@ static void zynq_machine_class_init(ObjectClass *oc, vo=
id *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+=C2=A0 =C2=A0 ObjectProperty *prop;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;desc =3D &quot;Xilinx Zynq Platform Baseboard fo=
r Cortex-A9&quot;;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D zynq_init;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D ZYNQ_MAX_CPUS;<br>
@@ -379,6 +404,12 @@ static void zynq_machine_class_init(ObjectClass *oc, v=
oid *data)<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;ignore_memory_transaction_failures =3D true;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;valid_cpu_types =3D valid_cpu_types;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_id =3D &quot;zynq.ext_ram&quot;;<br>
+=C2=A0 =C2=A0 prop =3D object_class_property_add_str(oc, &quot;boot-mode&q=
uot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zynq_set_boot_mode);<br>
+=C2=A0 =C2=A0 object_class_property_set_description(oc, &quot;boot-mode&qu=
ot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;Supported boot modes:&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot; JTAG QSPI SD NOR&quot;);<br>
+=C2=A0 =C2=A0 object_property_set_default_str(prop, &quot;QSPI&quot;);<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo zynq_machine_type =3D {<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000d2d91f061b3dbb1b--

