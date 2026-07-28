Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD883C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woiUW-00062C-KA; Tue, 28 Jul 2026 10:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huang.botsz@gmail.com>)
 id 1woiUU-00061b-R8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:09:06 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <huang.botsz@gmail.com>)
 id 1woiUT-0003rA-04
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:09:06 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7ee50eb2db4so3132432a34.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785247743; cv=none;
 d=google.com; s=arc-20260327;
 b=g2fylVAxbaOjqXWoXk/VdUhbILuyAlpQAT6NmVzws6a3nBCHamsDK/2o/Es4TX0PBw
 GcbM1X74C2zaW5hWIoB2hqrlhslN0P3d/Z8EoIa+NGxC87GhSVoBaQ7/5nVrGeu8T3Kc
 NRJuETitMaT0XoV9P6LwLGJSHHUHasa5mwVUcwH/EkGAoObNiFuumbEK5oUUwvzTxGoI
 8eq8LkyOk8VidDLrYXaqiUj1CCb7fS2g8yLv/cErtmv5pURdjGyy1zM4aBB0lBrMzAex
 5TtfSSj5NimsEzG738Siz6oHZ+nqi05+Kg4Nu32N/wQENaVt5sZUnuqsiNztWsdVXi+9
 cGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w8VPkSPT7sWevU5cAFZw5DWgr97KdkfvaaLraanPR2o=;
 fh=v1p9TD2qHziwhYeF1a/EamknYRJiam1BaPt8Qa1kYs4=;
 b=Zk86Cj3ep2bSCRUBRiEMiWQAKnVYkr51MO6al8xhxDo3dw3AviTgfj8H6nqO0RZNZz
 uzTTXHk0OtKDGdBRNB+cIZ1xhbTA5lAb006cOlKeMYblwRrDmhr57SBL8Dm9bafoXQbO
 on/wqijUmC2IwL2R2aSvWyIZJsIJhaknP/8TJdJG8uE4HpO6fSyr8F0t3WzD6n0wupts
 JrSl6KL70OR4K17hzIJZkGZ9oLGLq3m8Kn54ktIgU/5ARP5JbrobpAQQ2xUWkrwl9WiP
 Nvtbw3AFDkrab0qEnCHOS5DEMsjG71PL03s0HILLxpZXyH4rFjg3YyUNcOvEx2efJaRp
 rHLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785247743; x=1785852543; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w8VPkSPT7sWevU5cAFZw5DWgr97KdkfvaaLraanPR2o=;
 b=njpHtGS6uvfsPeWGTvaQ5GV2Z17v6JdnC7y0NWfLMRJ7U+WwnKhF1NNKUkFxYe0QJz
 Md3MXR8GuUGumib8irrLEPaw70lG3eLuOXLRDKmPbrt5xnzqDEWZl42dl8X86bm0ner+
 5aWB+Lm+hUwjCV0Dyw0PcYJkcjjayoznPhjOj6IYUME2cOOvGvXqT65yZcRRZ+VZdprz
 7oAmA+dVXBf4qkASrTjJk64CBy64dY6ePMsRMGm9P6avm62akjFXtURCAp+PFgPFNMsA
 vKcdPGTXndstI+RNrQzim3dCiHueJfzD2eK/OEZVqhTlJBTu6CPBGZ8cIu/NjR2lfAt+
 5ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247743; x=1785852543;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w8VPkSPT7sWevU5cAFZw5DWgr97KdkfvaaLraanPR2o=;
 b=sYBUJNvAY4eGOOkFLYq1FihF47S+No2QdQWpdSC3UGq58BMC6Jlm3uAReAOqxk7pEb
 uHTwqXckD/Rbot1tW9bLvL5ogo14jfHBsVlOwczaGo8LbJsTpwKJZLIWutaixJppUr9n
 zNLr+COOVSoteRRXX8ev84OR+E2ke6xpDPNkuEr/Dpey1A1tlillGsKUSMEV6X4FUBcm
 K5+EPcLphILaVzcXMauhpqJ2Vx7Gia7uWZ/gqdmToE5tfzqvRKgAM6nUbBRQyVWcigUx
 4rNRwLxPi++2CdxPKKU+4VXaalUGevQD9vqVSFSQNCHpID6p0B3T1c9qt4B9ky5gTQIX
 QM2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RodIEHXL2bs8dY1+8YmJkWb9Dc00ufAcOmFT+Mual6GkX0XvPX3hkxAUo+NnG14bccoOn05HC+gyr0S@nongnu.org
X-Gm-Message-State: AOJu0YwWcadOz2qADTAtoGjIEtolWByMfhvUxLCkMIUepZZC76aoNovw
 lLhWehNRqgjt+7FRF4KyngrIGo8jY2y4IyfRi91M3mtkfd+dQwqZU0d6XByvEktTQznBbG6RAfW
 2z7c7/zFXPq1PHGRT5bZw3XYoiq0nrgo=
X-Gm-Gg: AR+sD12USZv+aP8HGrv12tgU7exyaKWC93Vwqd1PvnyNLZHOsHrVcZnRNdTQOeH7OoJ
 /+ceJjWcF3gB8/auZfe7BLyiYpgVluu5rrKTQYekCuR25Vm60SS9xygWD1MTnCaWgPxSxQE8SQc
 BTr/m5VNCM7YHuiRVWL025WMQJADBQWi/pXNLKz1uy5CP/5oo1AbR3ywFjqcfC2+UG6Iy5EiHMW
 E51YewWRapKFEaP+0oSW3rqPzw8GLSnaKTDE5TP/zCjkF5YIhTmSXBaKE3c9JRzo2t/2ZKEpk6V
 uZ9qe26aypncYUB4wmdwXz1cZWKpaKPXFFfja8FH8ctbn8knmSBnCITtKhX0Ef1JNMae3ohCArF
 nIw==
X-Received: by 2002:a05:6830:3741:b0:7e6:dc7a:f459 with SMTP id
 46e09a7af769-7effef433b6mr1542620a34.11.1785247743346; Tue, 28 Jul 2026
 07:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
 <CAFEAcA-q5ihYpgYtEosQ3+SgbMdw7e7=xk4motLFL-A==g1k0w@mail.gmail.com>
 <a9ad33dc-b487-4ce7-9b8e-d437b6cc5d12@oss.qualcomm.com>
In-Reply-To: <a9ad33dc-b487-4ce7-9b8e-d437b6cc5d12@oss.qualcomm.com>
From: B H <huang.botsz@gmail.com>
Date: Tue, 28 Jul 2026 22:08:27 +0800
X-Gm-Features: AUfX_mx5Vv5DM91K48rp0bgZcpGc6s6ZOGvX3SHDJJ68-x55560VvR9PkJTpZ6w
Message-ID: <CAJQXNd3D6R1bA65sthKMWLGkCnk0ZjJu-fcmhnJpvquS4ihe0Q@mail.gmail.com>
Subject: Re: [PATCH] fix BCM2835_I2C_CLKT
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 philmd@mailo.com, qemu-arm@nongnu.org, sef1548@gmail.com
Content-Type: multipart/alternative; boundary="000000000000940a8b0657ac61f4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=huang.botsz@gmail.com; helo=mail-ot1-x32a.google.com
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

--000000000000940a8b0657ac61f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear all,

Thanks for applying the patch and for the detailed explanation!

You are completely right=E2=80=94my commit message reasoning was flawed. QE=
MU's
macro doesn't change the guest's behavior, it only affects how QEMU handles
the guest's access (logging a guest error and returning read-as-zero, as
you noted). I appreciate you clarifying that.

Regarding the register layout, since the CLKT register is at offset 0x1c
(and assuming it's the last 32-bit register), the total memory region size
should technically be 0x20 instead of 0x24.

Do you think we should also reduce the region size, as shown in the diff
below? If it looks good to you, I can send this as a separate follow-up
patch.

-- >8 --
diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
index 34de1f36e5b..5f6093087dd 100644
--- a/hw/i2c/bcm2835_i2c.c
+++ b/hw/i2c/bcm2835_i2c.c
@@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceState *dev, Error
**errp)
       s->bus =3D i2c_init_bus(dev, NULL);

       memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_i2c_ops, s,
-                          TYPE_BCM2835_I2C, 0x24);
+                          TYPE_BCM2835_I2C, 0x20);
       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
   }
---

Best regards,
Botsz HUANG
Signed-off-by: botszhuang <botszhuang@gmail.com>

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E6=96=BC 2026=E5=B9=
=B47=E6=9C=8827=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:54=E5=AF=AB=
=E9=81=93=EF=BC=9A

> On 27/7/26 12:04, Peter Maydell wrote:
> > On Fri, 24 Jul 2026 at 13:51, botszhuang <huang.botsz@gmail.com> wrote:
> >>
> >> hw/i2c/bcm2835_i2c: Correct CLKT register offset
> >>
> >> The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C
> controller is actually located at offset 0x1c, not 0x20.
> >>
> >> The previous incorrect value caused the guest OS to read from and writ=
e
> to the wrong memory address when configuring the I2C timeout, which could
> lead to unexpected controller behavior.
> >>
> >> Update the BCM2835_I2C_CLKT macro to match the hardware specification.
> >
> > Checking the datasheet, this is definitely the wrong value,
> > so the fix is correct. I'm a bit confused by your commit message,
> > though. The value here in QEMU can't cause the guest OS to write
> > to the wrong memory address, because the guest OS doesn't ever
> > see what we have defined here. It has the offset hardcoded into
> > its own source code.
> >
> > It looks to me like the effect of getting this wrong is that when
> > the guest writes to CLKT (at its actual 0x1c offset) we will log
> > a guest error and give read-as-zero behaviour. That's not correct,
> > but I expect for most guest OSes it'll be pretty harmless because
> > the guest probably doesn't write the value it wants to configure
> > and then read it back to check. (QEMU ignores the value written
> > anyway.)
> >
> > I've applied this to target-arm.next.
>
> Should we also reduce the region size?
>
> -- >8 --
> diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
> index 34de1f36e5b..5f6093087dd 100644
> --- a/hw/i2c/bcm2835_i2c.c
> +++ b/hw/i2c/bcm2835_i2c.c
> @@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceState *dev,
> Error **errp)
>       s->bus =3D i2c_init_bus(dev, NULL);
>
>       memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_i2c_ops, s,
> -                          TYPE_BCM2835_I2C, 0x24);
> +                          TYPE_BCM2835_I2C, 0x20);
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>   }
> ---
>

--000000000000940a8b0657ac61f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Dear all,<br><br><div>Thanks for applying=
 the patch and for the detailed explanation!=C2=A0</div><div><br></div><div=
>You are completely right=E2=80=94my commit message reasoning was flawed. Q=
EMU&#39;s macro doesn&#39;t change the guest&#39;s behavior, it only affect=
s how QEMU handles the guest&#39;s access (logging a guest error and return=
ing read-as-zero, as you noted). I appreciate you clarifying that.</div><br=
>Regarding the register layout, since the CLKT register is at offset 0x1c (=
and assuming it&#39;s the last 32-bit register), the total memory region si=
ze should technically be 0x20 instead of 0x24.<br><br>Do you think we shoul=
d also reduce the region size, as shown in the diff below? If it looks good=
 to you, I can send this as a separate follow-up patch.<br><br>-- &gt;8 --<=
br>diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c<br>index 34de1f=
36e5b..5f6093087dd 100644<br>--- a/hw/i2c/bcm2835_i2c.c<br>+++ b/hw/i2c/bcm=
2835_i2c.c<br>@@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceSta=
te *dev, Error **errp)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bus =3D i2c_init=
_bus(dev, NULL);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_init=
_io(&amp;s-&gt;iomem, OBJECT(dev), &amp;bcm2835_i2c_ops, s,<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0TYPE_BCM2835_I2C, 0x24);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_BCM2835_I2C, 0x20)=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_mmio(SYS_BUS_DEVICE(dev), &amp;=
s-&gt;iomem);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_irq(SYS_BUS_DEVICE(=
dev), &amp;s-&gt;irq);<br>=C2=A0 =C2=A0}<br>---<br><br>Best regards,<br>Bot=
sz HUANG<br>Signed-off-by: botszhuang &lt;<a href=3D"mailto:botszhuang@gmai=
l.com" target=3D"_blank">botszhuang@gmail.com</a>&gt;</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Dau=
d=C3=A9 &lt;<a href=3D"mailto:philmd@oss.qualcomm.com" target=3D"_blank">ph=
ilmd@oss.qualcomm.com</a>&gt; =E6=96=BC 2026=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:54=E5=AF=AB=E9=81=93=EF=BC=9A<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On 27/7/26 12:04, Pete=
r Maydell wrote:<br>
&gt; On Fri, 24 Jul 2026 at 13:51, botszhuang &lt;<a href=3D"mailto:huang.b=
otsz@gmail.com" target=3D"_blank">huang.botsz@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; hw/i2c/bcm2835_i2c: Correct CLKT register offset<br>
&gt;&gt;<br>
&gt;&gt; The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C cont=
roller is actually located at offset 0x1c, not 0x20.<br>
&gt;&gt;<br>
&gt;&gt; The previous incorrect value caused the guest OS to read from and =
write to the wrong memory address when configuring the I2C timeout, which c=
ould lead to unexpected controller behavior.<br>
&gt;&gt;<br>
&gt;&gt; Update the BCM2835_I2C_CLKT macro to match the hardware specificat=
ion.<br>
&gt; <br>
&gt; Checking the datasheet, this is definitely the wrong value,<br>
&gt; so the fix is correct. I&#39;m a bit confused by your commit message,<=
br>
&gt; though. The value here in QEMU can&#39;t cause the guest OS to write<b=
r>
&gt; to the wrong memory address, because the guest OS doesn&#39;t ever<br>
&gt; see what we have defined here. It has the offset hardcoded into<br>
&gt; its own source code.<br>
&gt; <br>
&gt; It looks to me like the effect of getting this wrong is that when<br>
&gt; the guest writes to CLKT (at its actual 0x1c offset) we will log<br>
&gt; a guest error and give read-as-zero behaviour. That&#39;s not correct,=
<br>
&gt; but I expect for most guest OSes it&#39;ll be pretty harmless because<=
br>
&gt; the guest probably doesn&#39;t write the value it wants to configure<b=
r>
&gt; and then read it back to check. (QEMU ignores the value written<br>
&gt; anyway.)<br>
&gt; <br>
&gt; I&#39;ve applied this to target-arm.next.<br>
<br>
Should we also reduce the region size?<br>
<br>
-- &gt;8 --<br>
diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c<br>
index 34de1f36e5b..5f6093087dd 100644<br>
--- a/hw/i2c/bcm2835_i2c.c<br>
+++ b/hw/i2c/bcm2835_i2c.c<br>
@@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceState *dev, <br>
Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 s-&gt;bus =3D i2c_init_bus(dev, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(dev), &=
amp;bcm2835_i2c_ops, s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_BCM2835_I2C, 0x24);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_BCM2835_I2C, 0x20);<br>
=C2=A0 =C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(dev), &amp;s-&gt;iomem=
);<br>
=C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(dev), &amp;s-&gt;irq);<=
br>
=C2=A0 }<br>
---<br>
</blockquote></div>
</div>

--000000000000940a8b0657ac61f4--

