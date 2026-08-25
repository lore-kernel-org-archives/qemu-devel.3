Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEB7C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyxkq-0003wl-AS; Tue, 25 Aug 2026 16:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1wyxko-0003wL-0w
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 16:28:18 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1wyxkl-0005fz-Ug
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 16:28:17 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66d1663c00dso301696d50.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 13:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787689694; cv=none;
 d=google.com; s=arc-20260327;
 b=gUKxt3bgFIFSKnUryGaEfGrBhC+EMC6Tlcdw32TgreH8/BIlB1AHPs+krbRBc6iNSS
 9/xwtNaVWUt+47ErF5b+Vv8oBVnsb0I3STtBXnI5kd6/L0MaehuldR+tRLlOIS41Geh3
 ydMqedN4T+vcNNYi932R9U1poSvnHBbn20dYSYIZpixv+bvFyWAh1IZqn4x9E2+c4iSW
 DestYf8gI+G6wSpsYchW66u8TwIKTbO12lgQmJEJ2zT2r9AYty+JU73i+lxITm1nP7MC
 nGq3KALQsLQbIJV78Rnp5vOcUMgdcK+BUc0IPa7gJxE3LTqVxXgLhDU3yDcVxeprPupl
 ln9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F3QhrohopVBpQ0k+0yAWhp4MAlB2PhAZNw4lP6AkXFI=;
 fh=rO+FnZSMbJmc07j8EUyt+AK9Zw1Wp6odfIj03GqMDr0=;
 b=Dyri0vA6H3Ph2nanufFD14NGlfOHaHjMrKcIkntkQO7xA9TbrFkl6JgrGoEizDgyHV
 Ijk3viMRsnmyKcsirUblcnDrGtvbIDXMPeptXJrv7EXTxBDg8f0alqZH1dZJ+3QPCaor
 fFtpY8bLudolQZUHRulC5ytvklZiEiizP0doOZNbyUnFjnEjhaWCiTtYCOsn/F+e3zSb
 WECk4sNPaICTQtJKUOZJJ1+Qr2E1APYPLEUOfOwExz3/839tu6GwpiKaqYQITS7w2AdC
 cN32iy0saRpHZu3gQ/euo1ImdDVj5F0K/+xu/zu5H4pEVTFHuZYlkyMqtPtrw17ilFqZ
 Z2/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787689694; x=1788294494; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F3QhrohopVBpQ0k+0yAWhp4MAlB2PhAZNw4lP6AkXFI=;
 b=grtlnHgk2CPYMbrawOIZzFwu+g5EG97ylCMmL44OF3y44jyFO4evp/UhtCmadN5dda
 2D5yHn/28oDE18svw3jTF0cbNDab1hH5/yg5eCI74MfBh/jVekS6Bol5rs3+/6EgO5Oq
 6rqm/aJoQB50bsdnCzjH+2ecVBEqpf2hyx7qKaUlfBtN8nnIHQjKrME5XpR5DnDGycOT
 W+LKul6uvqPmEVpUm+hlWolBCaz5SWvBWHMuHWkgAlG5RX5NmeHhc/zQT0jA1TPMup3z
 2Ce7O720rAYw9kM4NgfRyZg7eadeGEM3a3zWHNuzjCqygLyq2it5d2XDWJDmSRHHt3sp
 LFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787689694; x=1788294494;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F3QhrohopVBpQ0k+0yAWhp4MAlB2PhAZNw4lP6AkXFI=;
 b=MrZzSE1UNtgvukDmgnYoqwjR8OZcH6QoB7oNTjJnYwhNj61sYrGvHnVo30XPD/EYC3
 sWUF2OlDw3N0hZcLJ9NZQc98oKhPXOXzizbgoAuytK0WgC9DXt/A82SBbkLf13khBl61
 nvMM7ejzMA53id1fmRUIkFzQn+BmOU+tJgDjiHcsuMH5SyuYa+CC/v/n1xVkAP/L3aS+
 c6ISVkvQ6KPvr4DCDuAEUTnAWy9KGeHnM0c1MacrS2rslpdv5xpjc41Q3pDJiYVVCv9n
 r75ouOb77ug0k+QZxAH9m6CWoshlgdrKdPu/1CJn4+ixUJh34UsOZSIJduR+BxpyzweC
 oewA==
X-Gm-Message-State: AFuF++nhSIRcuYn4fBapwcsGvVusuZMcZrK/tiQ2ekV8uUUrsvsAuY+3
 WrzVQcW2bkVLmuXgOZPfRBFyaDa4j41YbpwhIwLT6cj88QNzaWksypXi8hHFWtxoSVsOrJcQPyP
 6kWE9bS/9dSCP1jZKiLBl7QJF1OkRopc=
X-Gm-Gg: AR+sD102+sNgis2wwJ5xYVjnM81cgw7Rf0r5gHNuZ8hZBI2UiPGFKijdivKqPIXor1x
 hGbjpqvy7uuHg99rzLNXlRowIdoUSxYq3e5948lqDuQPb9bNj9S0op0O9vUWAlCS90+Sn0L9pAW
 C0UcS1D7rP6zYRuNAdN27/MsKVKqxpo8OcXMXAOxpJkVP6vZI+opL3VwZMdYuGtvdT0EHHX1EP/
 hh4Jtm1PGxwSW2dINxYOAnTbMrK+8LDotuPK5Esku7ELj9ZFcjQo7hVmdqFMQj9vMeT0TljosrT
 GDhli92qG3T7wJwQ0u7wocaLrY8PPsPmoSkmzapGVjQCFw==
X-Received: by 2002:a53:ebc5:0:b0:66d:1be8:9f08 with SMTP id
 956f58d0204a3-66d2568d05emr421023d50.16.1787689694298; Tue, 25 Aug 2026
 13:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260819-allwinner-gpio-v1-1-2a64866dff11@gmail.com>
 <F3E16C1D-C4C9-46AC-9762-FB0081B6A27A@gmail.com>
In-Reply-To: <F3E16C1D-C4C9-46AC-9762-FB0081B6A27A@gmail.com>
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Tue, 25 Aug 2026 22:28:02 +0200
X-Gm-Features: AcwNN1WCwNv2hc-nFjaSMJ_drTNjjZeF0Flxp9Z5zf6gXwb3rQmAGtEDktKG0g0
Message-ID: <CABtshVRRm=vwTXagZ=C9kEVvuhadiD3hMbnsAfLxAzeS8J+jug@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/gpio: Allwinner A10 GPIO emulation
To: Jack Wang <77239050qq@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, 
 qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com, farosas@suse.de, 
 lvivier@redhat.com
Content-Type: multipart/alternative; boundary="0000000000003288910659e4f162"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yx1-xb130.google.com
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

--0000000000003288910659e4f162
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jack,

Thanks for reviewing the changes.

On Thu, Aug 20, 2026 at 5:05=E2=80=AFAM Jack Wang <77239050qq@gmail.com> wr=
ote:

> Hi,jankovic,I read datasheet of Allwinner and confirm basic address and
> most function do well. But there are still some place needing improvement=
.
>
> > +static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)
> > +{
> > +    uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;
> > +    uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> > +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1)
> =3D=3D
> > +        CFG_OUTPUT_MASK);
> > +}
> > +
> > +static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)
> > +{
> > +    uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;
> > +    uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> > +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1)
> =3D=3D
> > +        CFG_INPUT_MASK);
> > +}
> > +
> > +static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)
> > +{
> > +    unsigned int_cfg_n =3D s->regs[REG_INDEX(GPIO_INT_CFG0) + irq_line=
 /
> 8];
> > +    return extract32(int_cfg_n,
> > +                     (irq_line % INT_CFG_IRQ_PER_REG) *
> INT_CFG_IRQ_STRIDE,
> > +                     INT_CFG_IRQ_STRIDE - 1);
> > +}
> > +
> there you use 'INT_CFG_IRQ_STRIDE - 1=E2=80=99 as stride for both two fun=
ction=E3=80=82For
> int_ctl_cfg the stride is supposed to be 4
> https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf in
> page 333 you can find it, now all qtest pass because double edge do not b=
e
> designed in qtest=EF=BC=88better add this test=EF=BC=89. But for input an=
d output function
> it is right due to byte 3 is reserved.
>

The stride is set to 4 bits, but I am using only 3 bits when extracting the
value for specific interrupt pin configuration, since the maximum
non-reserved value that can be configured is 4 (for double edge). I will
add the double edge test as well in the v2 patches.

Best regards,
Strahinja Jankovic


>
> Jack Wang
>

--0000000000003288910659e4f162
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Jack,<div><br></div><div>Thanks for re=
viewing the changes.</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 20, 2026 at 5:0=
5=E2=80=AFAM Jack Wang &lt;<a href=3D"mailto:77239050qq@gmail.com">77239050=
qq@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Hi,jankovic,I read datasheet of Allwinner and confirm basic add=
ress and most function do well. But there are still some place needing impr=
ovement.<br>
<br>
&gt; +static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;<br>
&gt; +=C2=A0 =C2=A0 uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_P=
IN_STRIDE;<br>
&gt; +=C2=A0 =C2=A0 return (extract32(port-&gt;cfg[cfg_n], pin_shift, CFG_P=
IN_STRIDE - 1) =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CFG_OUTPUT_MASK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;<br>
&gt; +=C2=A0 =C2=A0 uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_P=
IN_STRIDE;<br>
&gt; +=C2=A0 =C2=A0 return (extract32(port-&gt;cfg[cfg_n], pin_shift, CFG_P=
IN_STRIDE - 1) =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CFG_INPUT_MASK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 unsigned int_cfg_n =3D s-&gt;regs[REG_INDEX(GPIO_INT_CF=
G0) + irq_line / 8];<br>
&gt; +=C2=A0 =C2=A0 return extract32(int_cfg_n,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(irq_line % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0INT_CFG_IRQ_STRIDE - 1);<br>
&gt; +}<br>
&gt; +<br>
there you use &#39;INT_CFG_IRQ_STRIDE - 1=E2=80=99 as stride for both two f=
unction=E3=80=82For int_ctl_cfg the stride is supposed to be 4 <a href=3D"h=
ttps://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf" rel=
=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/images/1/1e/Allwi=
nner_A10_User_manual_V1.5.pdf</a> in page 333 you can find it, now all qtes=
t pass because double edge do not be designed in qtest=EF=BC=88better add t=
his test=EF=BC=89. But for input and output function it is right due to byt=
e 3 is reserved.<br></blockquote><div><br></div><div>The stride is set to 4=
 bits, but I am using only 3 bits when extracting the value for specific in=
terrupt pin configuration, since the maximum non-reserved value that can be=
 configured is 4 (for double edge). I will add the double edge test as well=
 in the v2 patches.</div><div><br></div><div>Best regards,</div><div>Strahi=
nja Jankovic</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Jack Wang<br>
</blockquote></div></div>

--0000000000003288910659e4f162--

