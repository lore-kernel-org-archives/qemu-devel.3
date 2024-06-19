Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A61C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 12:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJuhH-0003k5-88; Wed, 19 Jun 2024 08:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJuhE-0003fa-Mp; Wed, 19 Jun 2024 08:45:52 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJuhC-0007c7-NH; Wed, 19 Jun 2024 08:45:52 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d07673185so1217178a12.1; 
 Wed, 19 Jun 2024 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718801148; x=1719405948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rt+vMimWpCZ3tXCuIBMMYYTnbBLTe2/+Fe2vxefBHDE=;
 b=EWvPVmUlF7GW7Z/NyYb835SUXpiYEjN87OiUC/OzZtuesgDgrdE/Zbg1pMzZCRN1gj
 UyvGCEj6Mc0NKdets1Bd3J0slbWgrA8cSAm+K16cXreDMDUrDXbPlVQRX4FHxoviGa7E
 hSayexfCUHsu7jXvcQr6qnMF88xlXZ+DhY6WTvDCmCa3vYKwGcmyxL8VIz9uRf3RHmEr
 ui0DrnWlliyDJ2RRMSmztgfmAIBjxtOrfvqfBCJufvB4MrvNDIQbPZRFB5WOo/2hFQ19
 uv9ENDhtSI1qX6KCohaS298/+IrqIau0iSte3IueO5wfj9yd23n6eaPPf5APWgyGcAvX
 au8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718801148; x=1719405948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rt+vMimWpCZ3tXCuIBMMYYTnbBLTe2/+Fe2vxefBHDE=;
 b=BMkSe7J/VFd2tTB75wogCpYW8NYWiWCGcLXDY1VO/f9kiqoCr6OLJBxfLwt9WUxFY8
 oVCiCnHfEFSVIQ/t2nJlPdb+PvbhBBLd4aUdsOqGgUNU/nDoc/iaAmCnjBOe8BW5CBBu
 HLYSEZ94XCyo/EpETyv46K2oL9AChhjKJHHhqn/z5UNnM3CPieujsBEC77HgjLSFJ0J3
 cNylHv+NejgZzV2kDE2JaIHcAJ9Hle/IXMnD4wLGPflJwx22z5pYHBeVXBsOCE7UqsrZ
 RxtG529o1EQLJQuF2bW8Tdj679DVkmgkMvp01705WtObvPxrDPGxRYrZLR9lqTt73W+S
 WtLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2meGPtsFg3r8zaB+CsYX9DgucS3xSve+5rxtwQgVT3uIzdSmxt1r3E9hQiWbtlJ/27DlYZDizuTH6Bpf8xk/gfNZaPYY=
X-Gm-Message-State: AOJu0Yxx5b0k0cLlkTlBaLqFCyGq2eu/GoV2+kCW4+immzPM9qLsFCQu
 BEK1i3aQHtV/ZcyBWLcQp2BeQu+OanAy3FrWx5YFVZxjXaGi29k3eDgCJgaEGEtICsi5vbjv3M3
 LZ/IiRGxhNiv4eRcDSU+T9/3YAA4=
X-Google-Smtp-Source: AGHT+IHS24KMyJaVmhL/foSbT9+kH0L79z3SmNOHiu84vdMv3uZbhMIm6vPHEgiWZYEOMxRMHEHN7cZ1GMgHtYushg4=
X-Received: by 2002:a50:d74f:0:b0:57c:6c98:b622 with SMTP id
 4fb4d7f45d1cf-57d07ec1fc4mr1853623a12.38.1718801148114; Wed, 19 Jun 2024
 05:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240619091632.2825550-1-sai.pavan.boddu@amd.com>
 <20240619091632.2825550-2-sai.pavan.boddu@amd.com>
In-Reply-To: <20240619091632.2825550-2-sai.pavan.boddu@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 19 Jun 2024 14:45:36 +0200
Message-ID: <CAJy5ezpchrSME7YHE7L7VAtLrnuCdfsOEN51jQn7kmBVhYX62A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/misc/zynq_slcr: Add BootMode property
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, francisco.iglesias@amd.com
Content-Type: multipart/alternative; boundary="000000000000df7fad061b3d93fe"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x529.google.com
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

--000000000000df7fad061b3d93fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:16=E2=80=AFAM Sai Pavan Boddu <sai.pavan.boddu@a=
md.com>
wrote:

> BootMode property sets user values into BOOT_MODE register, on hardware
> these are derived from board switches.
>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
>  hw/misc/zynq_slcr.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index 3412ff099ea..ad814c3a79b 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -24,6 +24,8 @@
>  #include "hw/registerfields.h"
>  #include "hw/qdev-clock.h"
>  #include "qom/object.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
>
>  #ifndef ZYNQ_SLCR_ERR_DEBUG
>  #define ZYNQ_SLCR_ERR_DEBUG 0
> @@ -121,6 +123,7 @@ REG32(RST_REASON, 0x250)
>
>  REG32(REBOOT_STATUS, 0x258)
>  REG32(BOOT_MODE, 0x25c)
> +    FIELD(BOOT_MODE, BOOT_MODE, 0, 4)
>
>  REG32(APU_CTRL, 0x300)
>  REG32(WDT_CLK_SEL, 0x304)
> @@ -195,6 +198,7 @@ struct ZynqSLCRState {
>      Clock *ps_clk;
>      Clock *uart0_ref_clk;
>      Clock *uart1_ref_clk;
> +    uint8_t boot_mode;
>  };
>
>  /*
> @@ -371,7 +375,7 @@ static void zynq_slcr_reset_init(Object *obj,
> ResetType type)
>      s->regs[R_FPGA_RST_CTRL]  =3D 0x01F33F0F;
>      s->regs[R_RST_REASON]     =3D 0x00000040;
>
> -    s->regs[R_BOOT_MODE]      =3D 0x00000001;
> +    s->regs[R_BOOT_MODE]      =3D s->boot_mode & R_BOOT_MODE_BOOT_MODE_M=
ASK;
>
>      /* 0x700 - 0x7D4 */
>      for (i =3D 0; i < 54; i++) {
> @@ -588,6 +592,15 @@ static const ClockPortInitArray zynq_slcr_clocks =3D=
 {
>      QDEV_CLOCK_END
>  };
>
> +static void zynq_slcr_realize(DeviceState *dev, Error **errp)
> +{
> +    ZynqSLCRState *s =3D ZYNQ_SLCR(dev);
> +
> +    if (s->boot_mode > 0xF) {
> +        error_setg(errp, "Invalid boot mode %d specified", s->boot_mode)=
;
> +    }
> +}
> +
>  static void zynq_slcr_init(Object *obj)
>  {
>      ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
> @@ -610,15 +623,22 @@ static const VMStateDescription vmstate_zynq_slcr =
=3D {
>      }
>  };
>
> +static Property zynq_slcr_props[] =3D {
> +    DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, boot_mode, 1),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void zynq_slcr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>
>      dc->vmsd =3D &vmstate_zynq_slcr;
> +    dc->realize =3D zynq_slcr_realize;
>      rc->phases.enter =3D zynq_slcr_reset_init;
>      rc->phases.hold  =3D zynq_slcr_reset_hold;
>      rc->phases.exit  =3D zynq_slcr_reset_exit;
> +    device_class_set_props(dc, zynq_slcr_props);
>  }
>
>  static const TypeInfo zynq_slcr_info =3D {
> --
> 2.34.1
>
>

--000000000000df7fad061b3d93fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 19, 2024 at 11:16=E2=80=AFAM =
Sai Pavan Boddu &lt;<a href=3D"mailto:sai.pavan.boddu@amd.com">sai.pavan.bo=
ddu@amd.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">BootMode property sets user values in=
to BOOT_MODE register, on hardware<br>
these are derived from board switches.<br>
<br></blockquote><div><br></div><div><br></div><div>Reviewed-by: Edgar E. I=
glesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.co=
m</a>&gt;<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
Signed-off-by: Sai Pavan Boddu &lt;<a href=3D"mailto:sai.pavan.boddu@amd.co=
m" target=3D"_blank">sai.pavan.boddu@amd.com</a>&gt;<br>
---<br>
=C2=A0hw/misc/zynq_slcr.c | 22 +++++++++++++++++++++-<br>
=C2=A01 file changed, 21 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c<br>
index 3412ff099ea..ad814c3a79b 100644<br>
--- a/hw/misc/zynq_slcr.c<br>
+++ b/hw/misc/zynq_slcr.c<br>
@@ -24,6 +24,8 @@<br>
=C2=A0#include &quot;hw/registerfields.h&quot;<br>
=C2=A0#include &quot;hw/qdev-clock.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
<br>
=C2=A0#ifndef ZYNQ_SLCR_ERR_DEBUG<br>
=C2=A0#define ZYNQ_SLCR_ERR_DEBUG 0<br>
@@ -121,6 +123,7 @@ REG32(RST_REASON, 0x250)<br>
<br>
=C2=A0REG32(REBOOT_STATUS, 0x258)<br>
=C2=A0REG32(BOOT_MODE, 0x25c)<br>
+=C2=A0 =C2=A0 FIELD(BOOT_MODE, BOOT_MODE, 0, 4)<br>
<br>
=C2=A0REG32(APU_CTRL, 0x300)<br>
=C2=A0REG32(WDT_CLK_SEL, 0x304)<br>
@@ -195,6 +198,7 @@ struct ZynqSLCRState {<br>
=C2=A0 =C2=A0 =C2=A0Clock *ps_clk;<br>
=C2=A0 =C2=A0 =C2=A0Clock *uart0_ref_clk;<br>
=C2=A0 =C2=A0 =C2=A0Clock *uart1_ref_clk;<br>
+=C2=A0 =C2=A0 uint8_t boot_mode;<br>
=C2=A0};<br>
<br>
=C2=A0/*<br>
@@ -371,7 +375,7 @@ static void zynq_slcr_reset_init(Object *obj, ResetType=
 type)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_FPGA_RST_CTRL]=C2=A0 =3D 0x01F33F0F;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_RST_REASON]=C2=A0 =C2=A0 =C2=A0=3D 0x00000=
040;<br>
<br>
-=C2=A0 =C2=A0 s-&gt;regs[R_BOOT_MODE]=C2=A0 =C2=A0 =C2=A0 =3D 0x00000001;<=
br>
+=C2=A0 =C2=A0 s-&gt;regs[R_BOOT_MODE]=C2=A0 =C2=A0 =C2=A0 =3D s-&gt;boot_m=
ode &amp; R_BOOT_MODE_BOOT_MODE_MASK;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* 0x700 - 0x7D4 */<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 54; i++) {<br>
@@ -588,6 +592,15 @@ static const ClockPortInitArray zynq_slcr_clocks =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0QDEV_CLOCK_END<br>
=C2=A0};<br>
<br>
+static void zynq_slcr_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ZynqSLCRState *s =3D ZYNQ_SLCR(dev);<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;boot_mode &gt; 0xF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Invalid boot mode %d sp=
ecified&quot;, s-&gt;boot_mode);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0static void zynq_slcr_init(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ZynqSLCRState *s =3D ZYNQ_SLCR(obj);<br>
@@ -610,15 +623,22 @@ static const VMStateDescription vmstate_zynq_slcr =3D=
 {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
+static Property zynq_slcr_props[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT8(&quot;boot-mode&quot;, ZynqSLCRState, boot=
_mode, 1),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
+};<br>
+<br>
=C2=A0static void zynq_slcr_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
=C2=A0 =C2=A0 =C2=A0ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_zynq_slcr;<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D zynq_slcr_realize;<br>
=C2=A0 =C2=A0 =C2=A0rc-&gt;phases.enter =3D zynq_slcr_reset_init;<br>
=C2=A0 =C2=A0 =C2=A0rc-&gt;phases.hold=C2=A0 =3D zynq_slcr_reset_hold;<br>
=C2=A0 =C2=A0 =C2=A0rc-&gt;phases.exit=C2=A0 =3D zynq_slcr_reset_exit;<br>
+=C2=A0 =C2=A0 device_class_set_props(dc, zynq_slcr_props);<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo zynq_slcr_info =3D {<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000df7fad061b3d93fe--

