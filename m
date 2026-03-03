Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B324CEDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUyU-0002mL-8E; Tue, 03 Mar 2026 14:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxUyT-0002kV-8F
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:00:05 -0500
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxUyP-0003Oa-Dx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:00:04 -0500
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2be1c918173so2963606eec.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564400; cv=none;
 d=google.com; s=arc-20240605;
 b=OEtp1YTBI7bj9gj6Z8qtX2o/mAsHqa4dSVv6e5nBhWUCUHoUQyak+TXS7VgzbZYMsz
 55py4LyWMYLM+S2ixHkfv8UL0T3fOjNLnir0fq5Q8Cb4WVq9CrH9ECYLVuVhSyX7XeZn
 DVs+U+a2x9TjU9G1ZTJUF/0uTeCZTaaWbw1d/LYtNvbW6D2loCV5BBKhltUtvhKRZX+V
 sxMPhSVG0W4bDDjtS7y/z8Rt6vXaQpcyb7w/JHr7w+/iE0y05mJZePXMZTc4WY3FBBOl
 5gGWGm64r8fTiv17L7NL/yzKqzE1ribUo1h4OersE5kOaf+0zigHcvjSUZVh8+Rt/uD8
 Kzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nvwiln5lOyTukgj15yad9ekqwEEhjh8aFmNXkPGIXcs=;
 fh=KZ88V8sQllVRL3wSPJa7hmTbAk5xPL98qAea2zjJmlM=;
 b=KdwnjPLW4TkR5vzGCPzBewiFOOjb04ilw/cq2e9VLECIfd9AvW32y7bwalfhYD7aPx
 DAJ4Esh3q7t82iKAPkgdt4z9Nw0tT4umAcUwH0YjlaTszRxhkKBfKvLUX7Xxe/C+4k7L
 pEpQYZBH45iuHxpUJjMd7vnNSRS7AzwIzeBNSdrEcIauKOSo2TFccH2uPXQdcInC3bJO
 SZvOi26x3YjtLwWyUiek5TF3KssbuByhbstk83CWYJEBdX+PBLfmZTJuqHec5Dm7avsY
 kaQbbdSgzkzqkbGWZIT4JrgkBZ3lVXyEndOi20+SPigWKhlg55wNsID/ztH1s4byg+LG
 gRFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772564400; x=1773169200; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nvwiln5lOyTukgj15yad9ekqwEEhjh8aFmNXkPGIXcs=;
 b=JsSuAGUYmLqIQImyuIfXJ7kTVu/Fd5Mj8capxd2osDFKKdYAl4dmrXRfRMXV1flYXe
 p62bIAOyRDmvm2eEZALH2ZCZc9oMztqN+/rNM9Cf0eGTTRFhVF+iIKXJR5zMFdTXwRuS
 i+7jt8LfJag2VRwUS9IHeIr92tKxJKEJtTN8bodTkxxFEkdStbXSfv/jYvoGkBAJhljQ
 5FoTiwuw0QFh3nZUtZcdvt7Yz+lWFqUZJX5a5eqKoOqXQ2VRYfSLw9f5R7Hdt29AK9Tn
 uSoC1CiqC0GrFPWVt3ORL+9ZssG5oVgH+invaB3/TS/ExAYdm8z1E3QVzODOJzAQGdNd
 KPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564400; x=1773169200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvwiln5lOyTukgj15yad9ekqwEEhjh8aFmNXkPGIXcs=;
 b=DUqTptFGjYNmnHQXwdCb3x2mSLeycFPilTGiKOlCUeB2xFIjAF9AlUJkd7LX3dC2Bh
 2k+F8J6n/QiZkIimpdAyLU1obVapYroJmrjydsaOyEPH6nTtviijs76vcNRCBapWKU1p
 kexGdAzWBYu+nREV/O8eBlpYuHQa98l7BRw2jP3OK8fNw0ZSbzUgc96s7WeMG0zlISn1
 Mt32D6UhICBG99Oks6HFrMvqdudcdLnIYo78xOGZaI/bfOm3+h1Nas7gX2Yiyupv38FF
 o2WMQqllKRZ3i1JxEsKtBsGwi/v5gQUxtNHLiFc6cJZjZgcUR31WQrGOFLJzqVcV6bq1
 5BQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFKWfEySVWpQxSLbF6VNNqNb2WpGf1wNNzjHjea0ceq5C9NDJdgad6TQRjrzkUZNgfzAan5voWlZki@nongnu.org
X-Gm-Message-State: AOJu0YyPixotUYr50OOhtpIcLnp1UlnyGoOM2P2HJyrOBn56NfwDn/71
 VZy6s6jTR96+P7lTRu3tm6Q/kb1gmC5PFX3JIe4anrYPyOetp1arjC2XiF6eFroZPYe7sDFyjAw
 QKotxnu1v6vc7FBDPd2aFNrCIdptXHZ4=
X-Gm-Gg: ATEYQzw3EOsmbntNy6KKr37pCsi97Dzrhk9WfUPK3nhbGmpyEFgfQ0EzCHtx4a4QyNW
 AWA23ARyQPmmzgFkWqjWzzaHD9I8ow8X29HsJNXr6eP5GOX1gv1qBmCctrgQ5exoGoRwINL/e6Y
 9+coSikMY9f3wDGuC6jydSRwOhWOU/tzXQdHKlYgU/sRzM5r8UXElKMHS/odVeB21KPx7p8ppbr
 3M2mz1OcdXFqVw4DgX/xpIUn92Gt867nUcfkJUCkKnxuB+GyOjXcBoSXCCsmsE+6w2CgzOdhbPR
 9LIUG64=
X-Received: by 2002:a05:7300:3b0c:b0:2bd:dd33:7996 with SMTP id
 5a478bee46e88-2bde1d49fb0mr8541854eec.19.1772564399626; Tue, 03 Mar 2026
 10:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
 <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
 <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
 <CAFEAcA8mC4TkicLy9bcS8NYMDNcSUjsataGGmkMpViw4wBvmCA@mail.gmail.com>
In-Reply-To: <CAFEAcA8mC4TkicLy9bcS8NYMDNcSUjsataGGmkMpViw4wBvmCA@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 3 Mar 2026 12:59:47 -0600
X-Gm-Features: AaiRm52lD6xxTOQqc8b9w-PVQRhTPGDBftkxBj7k40ujpJ_jy5rW0-qJ9TjrlNM
Message-ID: <CAJy5ezqTAMr=A3uAfmuWLepK66AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com>
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair@alistair23.me
Content-Type: multipart/alternative; boundary="000000000000619da5064c234fd9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-dy1-x1329.google.com
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

--000000000000619da5064c234fd9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 12:44=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 3 Mar 2026 at 18:32, Edgar E. Iglesias <edgar.iglesias@gmail.com>
> wrote:
> >
> >
> >
> > On Tue, Mar 3, 2026 at 2:33=E2=80=AFAM Kuan-Jui Chiu <kchiu@axiado.com>=
 wrote:
> >>
> >> Hi
> >>
> >> I was referring this commit of upstream kernel which xilinx added BXRS
> >> register in Cadence UART driver
> >> serial: xuartps: Adds RXBS register support for zynqmp =C2=B7
> >> torvalds/linux@3816b2f
> >> <
> https://github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203a=
b905a889
> >
> >>
> >> Peter Maydell =E6=96=BC 2026/2/16 =E4=B8=8B=E5=8D=88 06:53 =E5=AF=AB=
=E9=81=93:
>
> >> > Where is this register documented? The cadence_uart.c file
> >> > references the Zynq 7000 Soc TRM UG585; its URL for that
> >> > is out of date, but looking at the copy on the AMD website,
> >> > there is a table giving the register summary for the UART:
> >> >
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART
> >> > and it lists only registers from offsets 0 to 0x44.
>
> > There's documentation here for zynqmp:
> >
> https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO_byt=
e_status-UART-Register
> >
> > I haven't looked to carefully, it may be a register that didn't exist i=
n
> the version of the UART on zynq and was added in the version of the uart =
in
> the zynqmp.
>
> Thanks. On the subject of Xilinx specs, do you have an opinion on
> https://gitlab.com/qemu-project/qemu/-/issues/3297 ?
> Our Xilinx AXI ethernet device model lets software write to
> the PHY registers for the PHY ID, and it's not clear to me
> whether these registers are supposed to be read-only or not.
>
>
Yes, they should be read-only, there's probably more registers and fields
that have the wrong access restrictions as well. The PHY model is super
simple, created just to get guests to not get stuck on boot or fail to use
the PHY...

IIRC, there's been several attempts on list to create a better MDIO/PHY
interface with shared PHY models but never got merged.

Cheers,
Edgar

--000000000000619da5064c234fd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 3, =
2026 at 12:44=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, 3 Mar 2026 at 18:32, Edgar E. I=
glesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" target=3D"_blank">e=
dgar.iglesias@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Mar 3, 2026 at 2:33=E2=80=AFAM Kuan-Jui Chiu &lt;<a href=3D"ma=
ilto:kchiu@axiado.com" target=3D"_blank">kchiu@axiado.com</a>&gt; wrote:<br=
>
&gt;&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; I was referring this commit of upstream kernel which xilinx added =
BXRS<br>
&gt;&gt; register in Cadence UART driver<br>
&gt;&gt; serial: xuartps: Adds RXBS register support for zynqmp =C2=B7<br>
&gt;&gt; torvalds/linux@3816b2f<br>
&gt;&gt; &lt;<a href=3D"https://github.com/torvalds/linux/commit/3816b2f886=
d0918d8a8ae593b2db203ab905a889" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203ab905a889=
</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Peter Maydell =E6=96=BC 2026/2/16 =E4=B8=8B=E5=8D=88 06:53 =E5=AF=
=AB=E9=81=93:<br>
<br>
&gt;&gt; &gt; Where is this register documented? The cadence_uart.c file<br=
>
&gt;&gt; &gt; references the Zynq 7000 Soc TRM UG585; its URL for that<br>
&gt;&gt; &gt; is out of date, but looking at the copy on the AMD website,<b=
r>
&gt;&gt; &gt; there is a table giving the register summary for the UART:<br=
>
&gt;&gt; &gt; <a href=3D"https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-T=
RM/UART-Controller-UART" rel=3D"noreferrer" target=3D"_blank">https://docs.=
amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART</a><br>
&gt;&gt; &gt; and it lists only registers from offsets 0 to 0x44.<br>
<br>
&gt; There&#39;s documentation here for zynqmp:<br>
&gt; <a href=3D"https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registe=
rs/Rx_FIFO_byte_status-UART-Register" rel=3D"noreferrer" target=3D"_blank">=
https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO_byte_=
status-UART-Register</a><br>
&gt;<br>
&gt; I haven&#39;t looked to carefully, it may be a register that didn&#39;=
t exist in the version of the UART on zynq and was added in the version of =
the uart in the zynqmp.<br>
<br>
Thanks. On the subject of Xilinx specs, do you have an opinion on<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3297" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/3297=
</a> ?<br>
Our Xilinx AXI ethernet device model lets software write to<br>
the PHY registers for the PHY ID, and it&#39;s not clear to me<br>
whether these registers are supposed to be read-only or not.<br>
<br></blockquote><div><br></div><div>Yes, they should be read-only, there&#=
39;s probably more registers and fields that have the wrong access restrict=
ions as well. The PHY model is super simple, created just to get guests to =
not get stuck on boot or fail to use the PHY...</div><div><br></div><div>II=
RC, there&#39;s been several attempts on list to create a better MDIO/PHY i=
nterface with shared PHY models but never got merged.</div><div><br></div><=
div>Cheers,</div><div>Edgar</div></div></div>

--000000000000619da5064c234fd9--

