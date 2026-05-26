Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D7CD6E42
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsSx-0001Pq-MJ; Tue, 26 May 2026 10:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wRsSv-0001OR-L7
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:09:05 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wRsSt-0002v9-LM
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:09:05 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68914995e35so4347648a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804541; cv=none;
 d=google.com; s=arc-20240605;
 b=RDziEb6rJUl1bOHouoHWgRbiUZht8TEokeaUkMoWP2BilhGODsxCy74k0Rgi19h62H
 VLIL7acR46EXPuTvyb2v0eajsedcCjpm8Aoul23XYK0VNEic2qHj8i8eWF48wr4L1c15
 TUtSsUeO1IOQWBpaAomGD+lU9zrhdJ7bONiQZxWKPEuM/p2isQI2VfGGS/0MweIhigyo
 EZfMrIK/ziFhIgnxf2PDytk8sSj50fgJPrTc0j1VTZd2K05LNdSr+6RDnHNYAU4JddKo
 /l3ERLUOdIxCbwUKs1eIa/p/BclytSpkjmOoPBxXWIonfrULXAvOEDT4B/b4AgE7yNno
 IEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L/oMCPv/V3yXwFEFrWayKTaj0fYgDM5LpxOzXAwB2s4=;
 fh=wdExOGUA/m8RExRK2HO3y8T1Q/sNGEwty+NzzW43jHE=;
 b=Wa9zaNXcsvWpJ3fnEtobX5GZBTg/i846vywVNVfUQP9ppQrHtHyPOyQO/y/uVVx+wN
 iJ5JaDdrnXsIrtgaD3Ubb5nQYWgPaWWNkcMfise99Wwfqq6gxZ5VCRqqAjSTv1LWtz3U
 iXum0dvdXYlHE17uzMNZtGU2a9Q0HE5rSAMtV3BGOKMHfpvsJTpDymjhcImGjnoT83IU
 HlomvT1aUa/v0XZWS23NkHTtyqHmsftjIX8g8Pou95wF7mGu7aYRsjpwKutVYnf7Xe88
 Xb12Vw1TE4l1jTAZ7yv94+BYpT1DqFcnAcKf/fPQpJNMDZ1TR44OBAM0MjIUkLWFkXqG
 8geQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779804541; x=1780409341; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L/oMCPv/V3yXwFEFrWayKTaj0fYgDM5LpxOzXAwB2s4=;
 b=KzJoWmcKUa5JWgposgXL4ci8/2e/y9js1HHLmpLdQYXlx0/frNhwNTTLZzQeqNNz+v
 eNnNAZ/b2xdCI57EAKcdYpuK6BNwMin84HB9ylNgW4zHXXyCei4HyTErgF03D4QtkkTS
 V9vrQWcLiUGwUrS8VahZJXHqgXvmYY2T6lS5eeSvOK80bJAqJED/dc4W8QdT6gP7kzhM
 VdqdOmzNo+BLbcSGcE9Pi3UnmYbLsbbAUZSoUsBo6HxZ9/3tdjMNvRmEAVSVU7diY5Ky
 cXarJq+5ttYrw5WlMr6SngKy0xAb6sjU4K/sHSddo7VrdSnO/xCf11SuFsVKpyUzrYBN
 pw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804541; x=1780409341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/oMCPv/V3yXwFEFrWayKTaj0fYgDM5LpxOzXAwB2s4=;
 b=KN4IgkQslvLC4cWmdDWBBsn+NI8X2d7Wvqn58HSHV/7VIMGaQxlOCzODKTjhZsTCVR
 xod/zetBGPWf4y32iit/s9HOZYCppBN4Tek8yFQe2fjfkCvItbtyqiu0YsuFRpAHYKgn
 uMt6NdO4dsMQob3lgcYUdLZRz9siw1T2AQnhrWQpa7EdHU11Zmb1eP57ryrmQ+rhVQoe
 03ddI5xJRD1hLmJjwdpyt9RW7RfR8MrBWBZCzTIiPzyFhrjZocNWIzy/nb8iFwirlhRo
 exG2fKEeBtgb5gBj46ofhYgozNRC68vhTq/2bIq1bxipGpwFOkR8zL9xK0WgMp3LjH/R
 rgCQ==
X-Gm-Message-State: AOJu0YxEOvfm9oVWmN6oKt3CDlNhVPcZBA1ypix3K8URBZI1zo/1ZW2R
 N4UvW105GdBW06W43SDU25RuLT0r5b0dWywv6nPRfkFa1AJpD83opku38KdPUsoeSz/GmS7QGwW
 QQPf0eurbliMu7XDWmpwxrWWhGch4QiW+/JDieMg62w==
X-Gm-Gg: Acq92OGBPEWRkRfIPX5Kb9xinWkTc4inQuO71jhx2gFxdNExOtO8NTJl8gWS+F5+OPw
 E+MalBYw9UwKsTEHMM4/t5tmLsDnZc6UfLW6ZNgdjTRSU2qFoUIOjPiDpXAos35G/opAMnZxY6e
 s79JXsWmJ4hqT2nK4WKP5yata21aWiWhak9dkTz0/tZykgba4GrHg9hsdEP8hAK1VnTBMwa/UgF
 6iu9C5tkima46VZKLdWhCExcYGZPJ3vcI+7vkkfcfq5RFYZRHp13pvriIYjPS9yrfdLjnLGAzCU
 tBBl8+rd4w==
X-Received: by 2002:a17:906:6a0b:b0:bd4:99f5:52f6 with SMTP id
 a640c23a62f3a-bdd264bf66bmr1069798166b.34.1779804541194; Tue, 26 May 2026
 07:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260513030503.3665414-1-frank.chang@sifive.com>
 <edaff76e-115a-470c-b5cb-a45f6f2c4e75@tls.msk.ru>
 <d6e638b0-d3cc-4f93-a4fa-7ef428f90f95@tls.msk.ru>
In-Reply-To: <d6e638b0-d3cc-4f93-a4fa-7ef428f90f95@tls.msk.ru>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 26 May 2026 22:08:49 +0800
X-Gm-Features: AVHnY4JBICqaoPDyaFRwfd3yuOWBHpSwO4XxYUqPt1GZjhNCv-gcwl1IIqm0rLg
Message-ID: <CAE_xrPhYbXfbPmBdXPdsuR-6y2UDemTomHueQD307mwpVBqSXA@mail.gmail.com>
Subject: Re: [PATCH] hw/char: Check interrupt after txctrl register is written
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000072b1670652b90922"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000072b1670652b90922
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:44=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 26.05.2026 10:00, Michael Tokarev wrote:
> > On 13.05.2026 06:05, frank.chang@sifive.com wrote:
> >> From: Frank Chang <frank.chang@sifive.com>
> >>
> >> It's possible that the transmit watermark level (txctrl.txcnt) is
> >> updated when the user writes to txctrl register, which may decrease th=
e
> >> transmit watermark level to less than the number of entries in the
> >> transmit FIFO. In such a case, the interrupt should be raised so we
> >> need to
> >> call sifive_uart_update_irq() to check and update interrupt when txctr=
l
> >> register is written. Otherwise, the interrupt will have to be delayed
> >> until next TX FIFO transmission is processed.
> >>
> >> Suggested-by: Chao Liu <chao.liu.zevorn@gmail.com>
> >> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> >> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> >> ---
> >>   hw/char/sifive_uart.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> >> index b4de662d616..b9bbaaef595 100644
> >> --- a/hw/char/sifive_uart.c
> >> +++ b/hw/char/sifive_uart.c
> >> @@ -213,6 +213,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
> >>           if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s-
> >> >tx_fifo)) {
> >>               sifive_uart_trigger_tx_fifo(s);
> >>           }
> >> +        sifive_uart_update_irq(s);
> >>           return;
> >>       case SIFIVE_UART_RXCTRL:
> >>           s->rxctrl =3D val64;
> >
> >
> > Is this change independent on e6051fa61b9 "hw/char: sifive_uart:
> > Implement txctrl.txen and rxctrl.rxen", - the one which added the
> > previous "if SIFIVE_UART_TXEN" code block here?
> >
> > I mean, should this patch be applied to older qemu stable series too,
> > namely, 10.0.x (LTS) and 10.2.x, where the above code is not present?
> > (It applies fine to 11.0.x).
>
> Or maybe I can just pick up the mentioned change - e6051fa61b9 - to 10.0
> and 10.2 too, it shouldn't hurt, and I've less differences to carry :)
>

That would be great.
Thanks.

Regard,
Frank Chang


>
> Thanks,
>
> /mjt
>

--00000000000072b1670652b90922
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 26,=
 2026 at 6:44=E2=80=AFPM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.=
ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 26.05.2026 10:00, Michael Tokarev wrote:<br>
&gt; On 13.05.2026 06:05, <a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a> wrote:<br>
&gt;&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" ta=
rget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s possible that the transmit watermark level (txctrl.txcnt)=
 is<br>
&gt;&gt; updated when the user writes to txctrl register, which may decreas=
e the<br>
&gt;&gt; transmit watermark level to less than the number of entries in the=
<br>
&gt;&gt; transmit FIFO. In such a case, the interrupt should be raised so w=
e <br>
&gt;&gt; need to<br>
&gt;&gt; call sifive_uart_update_irq() to check and update interrupt when t=
xctrl<br>
&gt;&gt; register is written. Otherwise, the interrupt will have to be dela=
yed<br>
&gt;&gt; until next TX FIFO transmission is processed.<br>
&gt;&gt;<br>
&gt;&gt; Suggested-by: Chao Liu &lt;<a href=3D"mailto:chao.liu.zevorn@gmail=
.com" target=3D"_blank">chao.liu.zevorn@gmail.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifiv=
e.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;&gt; Reviewed-by: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" tar=
get=3D"_blank">jim.shu@sifive.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/char/sifive_uart.c | 1 +<br>
&gt;&gt; =C2=A0 1 file changed, 1 insertion(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c<br>
&gt;&gt; index b4de662d616..b9bbaaef595 100644<br>
&gt;&gt; --- a/hw/char/sifive_uart.c<br>
&gt;&gt; +++ b/hw/char/sifive_uart.c<br>
&gt;&gt; @@ -213,6 +213,7 @@ sifive_uart_write(void *opaque, hwaddr addr,<b=
r>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (SIFIVE_=
UART_TXEN(s-&gt;txctrl) &amp;&amp; !fifo8_is_empty(&amp;s- <br>
&gt;&gt; &gt;tx_fifo)) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sifive_uart_trigger_tx_fifo(s);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sifive_uart_update_irq=
(s);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SIFIVE_UART_RXCTRL:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;rxctr=
l =3D val64;<br>
&gt; <br>
&gt; <br>
&gt; Is this change independent on e6051fa61b9 &quot;hw/char: sifive_uart:<=
br>
&gt; Implement txctrl.txen and rxctrl.rxen&quot;, - the one which added the=
<br>
&gt; previous &quot;if SIFIVE_UART_TXEN&quot; code block here?<br>
&gt; <br>
&gt; I mean, should this patch be applied to older qemu stable series too,<=
br>
&gt; namely, 10.0.x (LTS) and 10.2.x, where the above code is not present?<=
br>
&gt; (It applies fine to 11.0.x).<br>
<br>
Or maybe I can just pick up the mentioned change - e6051fa61b9 - to 10.0<br=
>
and 10.2 too, it shouldn&#39;t hurt, and I&#39;ve less differences to carry=
 :)<br></blockquote><div><br></div><div>That would be great.</div><div>Than=
ks.</div><div><br></div><div>Regard,</div><div>Frank Chang</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
/mjt<br>
</blockquote></div></div>

--00000000000072b1670652b90922--

