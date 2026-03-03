Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F23EDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUXn-0001PN-0A; Tue, 03 Mar 2026 13:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxUXd-0001OP-6e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:32:23 -0500
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxUXb-00071Y-DM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:32:20 -0500
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12732e6a123so2664437c88.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:32:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772562737; cv=none;
 d=google.com; s=arc-20240605;
 b=DhtHkzJV5nuYkBSfLLBJD0FX3AzZD/MlOn91/cCUsTuIwbdeV3pazcEeI8DBVwVDHq
 6kgP73mF0kvUMnGfJg0YKOCy4Vnji/Fc0iuXp7Gk78M30l9n4encHGLKcHrvldOhqGXN
 RGTAxaoWaxH8tWbI7LN0XvO6QFoFfbD794xnZQN4J01R7gpb4r0hrbH7ru2OQTmeaIZY
 POLC3KQrvmEjvs7hBY0uEQHd3AO04FguGCbq5uIdqipEfAB07Idw9IVGm9JTO+Cdn0k2
 8cw6spfg7ENlR7W3RxmTB+8aQaEozBiCY/KNgQcIOBMs4wi8w0vYt2XulPmsRZrtXxFV
 fBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/EdPveg4tGA8FqN+WLX4ITf8szipKUj0T5kGoi73b8s=;
 fh=W8euAw+JXgI3Nge78U5x5AerZ6pRzZDCA364ubWJQYA=;
 b=Iwrab+Mn2nMCQUC9+CDk9XNu3q+MKQgQBtyi8mO1RT2VMmM7RZO0EnX7lZXkI3WnZq
 inaZE6oAcaYu9V/bCmMJ9ykALJFRd84pXsJyR6qTpeKejA+3G6zUusPMpeovOT4cdoTb
 6SVyGXcsjoRYp4dAxYwl1Dyaa5GqJVkZD5r7d9DVUmByt+ejlFlNf30naM5h0VkLidjQ
 TXgwRaS7ytHp5vQgTyaEhSkjOnb5Gyw787gzx8L+ojXqJo0QjxhdUYLdHQDs9uTHt8EG
 irbiMvTq0IT1z5XiPN+uLRPB97zx12igbQ6Vo59USV6u4MRQ9DEHM1+dyMNdQWPRKabx
 mJqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772562737; x=1773167537; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/EdPveg4tGA8FqN+WLX4ITf8szipKUj0T5kGoi73b8s=;
 b=mrZo0kkB+nUpjGAWRMsWYE2wJNs1Hhpv9hoeX3jGI1w6nc4YscDp/2Ag+HQ2SlGFDc
 esKBnKiqCMhko393QYzh0naPjDASx3bHcszsolp1grJM96hhJQcWc/MMK67xU97i1XFX
 Dbb0GM38CTMcuh8Kt8grQ8itCb+hFkPzrIS+zJQUfwgZHyimarSxL55bmxY1pUpuH5sI
 3hY2VWMVIEwlp9rKLiyMYVpYTUM0KfuycvQkQ6sIoPPGA8lG5qhB7LREXW9GmT0CaLbn
 Z5DgZ68KhdGXG1nLNCRa7J5MOAO+U+ERNjsZndKeQaQT2jHXqF15Wi+aZ+jddzIVgBYY
 /uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772562737; x=1773167537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EdPveg4tGA8FqN+WLX4ITf8szipKUj0T5kGoi73b8s=;
 b=reW9tiD9Sg6GspOFmQoWRGrRUyBk1GZBuqXpHu3346rfzIa3oCve8kjE1ZweKTuR7K
 8Ky3qnnUUIuirwrN22F63TmoJ/l0TIBio439LN+/MjzIzk2WZlO/kQEr4ZoIeVDIx5bM
 Rxn8TwilIsxwDPDNiy9Pzf1A6cBIRK0rbzZm2f+VcHrdOeU5GHs4Vyg9cP8msCuCesei
 yZaIip0retPJnRkeDyFtA9FI2E95VqYpm8DqYjss1JLelcp8WnwZr+DFmrGSBC4orVK0
 k0cym8I2a+dktOnEIVp1TXOzEk29B4VcZBUHLU4D78rxfBE/JU3M7MzyjNzPZod1mPYs
 fqgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFjq7lQjK2XG0YdgqDwdAtIhZ9RRmlX0PjeV6pl/CNfUzOkTfBQzeI85B1yh3UqCQB9MfC+7bM5Nxb@nongnu.org
X-Gm-Message-State: AOJu0YzCikVt1boqlMI2R4ny1ByJ6p251ZECg1TjeRUhv+ey+neZGjKU
 8CmtpeJDaS3GRZM4fI2f+/+SZjj3CezMFS4pKcT58SVLXaTsY+7y54upWlp6ovhocU5Yyr1mAr2
 yO8ksVs5mjYOzUc7C6wM/RgXIxA906dw=
X-Gm-Gg: ATEYQzwZg6UuT2oJCgl/jUirJbQ0weuXiT4vWp/+/4AvT98hhv+HEaOowfIFz8O3yjz
 L2tPSSs5gAax7Wc9YJaLoSrljeCW1bY0DRrRbB/dlIRhC479z/CYYlrb1jBAYF/Qmk+0LvrhNgH
 DBhpjuivhoxQJ0XrBww+vVCZ0PeJNInmvjqQj+QB7MJbAy+yJ0IvbwfJ+TYh54L3CAN9QGBaan+
 GFcXpRVmtS10Zfw/EFVHq25NO3eaYYs8bqWJtJ91A5tkxpyMNcoTmw1hp/2mFAUmbyLl9jXDMOr
 x1/+US9Z1SrkawZH6g==
X-Received: by 2002:a05:7022:90f:b0:11b:9386:a3c8 with SMTP id
 a92af1059eb24-1278fd7b7d5mr7481974c88.41.1772562736313; Tue, 03 Mar 2026
 10:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
 <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
In-Reply-To: <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 3 Mar 2026 12:32:03 -0600
X-Gm-Features: AaiRm50TlLO9zmZIRLd-fBZFSb0JSKwzkeJQUS3HRbcMX-n_cyGgN19ih5MFIUs
Message-ID: <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair@alistair23.me
Content-Type: multipart/alternative; boundary="0000000000003d783f064c22ece9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000003d783f064c22ece9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 2:33=E2=80=AFAM Kuan-Jui Chiu <kchiu@axiado.com> wro=
te:

> Hi
>
> I was referring this commit of upstream kernel which xilinx added BXRS
> register in Cadence UART driver
> serial: xuartps: Adds RXBS register support for zynqmp =C2=B7
> torvalds/linux@3816b2f
> <
> https://github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203a=
b905a889
> >
>
> Peter Maydell =E6=96=BC 2026/2/16 =E4=B8=8B=E5=8D=88 06:53 =E5=AF=AB=E9=
=81=93:
> > CAUTION: This email originated from outside of the organization. Do not
> click links or open attachments unless you recognize the sender and know
> the content is safe.
> >
> >
> > On Thu, 12 Feb 2026 at 10:47, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
> >> The new CADENCE UART driver in upstream kernel access BXRS register
> >> This patch adds BXRS (RX FIFO byte status register) or there would be
> >> kernel panic if user are using the new CADENCE UART driver
> >>
> >> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> > Hi; thanks for this patch.
> >
> >> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> >> index eff6a3c4d1..f57cad57a8 100644
> >> --- a/hw/char/cadence_uart.c
> >> +++ b/hw/char/cadence_uart.c
> >> @@ -120,6 +120,7 @@
> >>   #define R_PMIN     (0x3C/4)
> >>   #define R_PWID     (0x40/4)
> >>   #define R_TTRIG    (0x44/4)
> >> +#define R_RXBS     (0x48/4)
> > Where is this register documented? The cadence_uart.c file
> > references the Zynq 7000 Soc TRM UG585; its URL for that
> > is out of date, but looking at the copy on the AMD website,
> > there is a table giving the register summary for the UART:
> >
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART
> > and it lists only registers from offsets 0 to 0x44.
> >
> > thanks
> > -- PMM
>


Hi,

There's documentation here for zynqmp:
https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO_byte_=
status-UART-Register

I haven't looked to carefully, it may be a register that didn't exist in
the version of the UART on zynq and was added in the version of the uart in
the zynqmp.

Cheers,
Edgar

--0000000000003d783f064c22ece9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 3, =
2026 at 2:33=E2=80=AFAM Kuan-Jui Chiu &lt;<a href=3D"mailto:kchiu@axiado.co=
m">kchiu@axiado.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi<br>
<br>
I was referring this commit of upstream kernel which xilinx added BXRS <br>
register in Cadence UART driver<br>
serial: xuartps: Adds RXBS register support for zynqmp =C2=B7 <br>
torvalds/linux@3816b2f <br>
&lt;<a href=3D"https://github.com/torvalds/linux/commit/3816b2f886d0918d8a8=
ae593b2db203ab905a889" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203ab905a889</a>&gt;<=
br>
<br>
Peter Maydell =E6=96=BC 2026/2/16 =E4=B8=8B=E5=8D=88 06:53 =E5=AF=AB=E9=81=
=93:<br>
&gt; CAUTION: This email originated from outside of the organization. Do no=
t click links or open attachments unless you recognize the sender and know =
the content is safe.<br>
&gt;<br>
&gt;<br>
&gt; On Thu, 12 Feb 2026 at 10:47, Kuan-Jui Chiu &lt;<a href=3D"mailto:kchi=
u@axiado.com" target=3D"_blank">kchiu@axiado.com</a>&gt; wrote:<br>
&gt;&gt; The new CADENCE UART driver in upstream kernel access BXRS registe=
r<br>
&gt;&gt; This patch adds BXRS (RX FIFO byte status register) or there would=
 be<br>
&gt;&gt; kernel panic if user are using the new CADENCE UART driver<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Kuan-Jui Chiu &lt;<a href=3D"mailto:kchiu@axiado.co=
m" target=3D"_blank">kchiu@axiado.com</a>&gt;<br>
&gt; Hi; thanks for this patch.<br>
&gt;<br>
&gt;&gt; diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c<br>
&gt;&gt; index eff6a3c4d1..f57cad57a8 100644<br>
&gt;&gt; --- a/hw/char/cadence_uart.c<br>
&gt;&gt; +++ b/hw/char/cadence_uart.c<br>
&gt;&gt; @@ -120,6 +120,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0#define R_PMIN=C2=A0 =C2=A0 =C2=A0(0x3C/4)<br>
&gt;&gt;=C2=A0 =C2=A0#define R_PWID=C2=A0 =C2=A0 =C2=A0(0x40/4)<br>
&gt;&gt;=C2=A0 =C2=A0#define R_TTRIG=C2=A0 =C2=A0 (0x44/4)<br>
&gt;&gt; +#define R_RXBS=C2=A0 =C2=A0 =C2=A0(0x48/4)<br>
&gt; Where is this register documented? The cadence_uart.c file<br>
&gt; references the Zynq 7000 Soc TRM UG585; its URL for that<br>
&gt; is out of date, but looking at the copy on the AMD website,<br>
&gt; there is a table giving the register summary for the UART:<br>
&gt; <a href=3D"https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-C=
ontroller-UART" rel=3D"noreferrer" target=3D"_blank">https://docs.amd.com/r=
/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART</a><br>
&gt; and it lists only registers from offsets 0 to 0x44.<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br></blockquote><div><br></div><div><br></div><div>Hi,</div><di=
v><br></div><div>There&#39;s documentation here for zynqmp:</div><div><a hr=
ef=3D"https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO=
_byte_status-UART-Register">https://docs.amd.com/r/en-US/ug1087-zynq-ultras=
cale-registers/Rx_FIFO_byte_status-UART-Register</a></div><div><br></div><d=
iv>I haven&#39;t looked to carefully, it may be a register that didn&#39;t =
exist in the version of the UART on zynq and was added in the version of th=
e uart in the zynqmp.</div><div><br></div><div>Cheers,</div><div>Edgar</div=
></div></div>

--0000000000003d783f064c22ece9--

