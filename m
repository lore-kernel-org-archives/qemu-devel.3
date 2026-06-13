Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA5CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 05:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYGpS-0004yS-UG; Sat, 13 Jun 2026 01:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wYGpP-0004y5-1D
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 01:22:43 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wYGpM-0003kX-64
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 01:22:42 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so3219403a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 22:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781328158; cv=none;
 d=google.com; s=arc-20240605;
 b=LbVYLrCpj5/yDusowpI0DgPlXH2xAnKwc92ueLueoz2jG5TDWHqKS0nEM27mA0JXFR
 rR0qvK3uqRhLxD6mDOgveOJUiRSudEhCWWp8FWQk1hYcbClQaRsxFXMRuJ2or7bYJKzh
 RA5QvfQrj7LlXAsxfq9UFwCNPZoTsuLAtsk8g6N34j/60G0RNok/xxfb4UX/RLykno3z
 SXxxL67Sa/7fCsDJ1rTVr1ItjGvGsyp9UV9Zn9PjgFe5i/DiQv2HhxaWFOMKuS2Ryulo
 fCGgJru3uQUuRLUan7pUeS71yp9tkze1e45tbTKljerkmv37Xi3HVlysXr+CAFV4X0iv
 55Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8it+egN+vgeOFmSRjEavP5t+0d6gXiZXjFH/DtNplZE=;
 fh=bQ77hYeGxUaKpndQZOZqmQlyf9/Y6hMIykJPPm9URPQ=;
 b=UChKKJ2ipPMTnbZokSy4k3bkZSuvOzRaVhzLxATggp3UHttMQOVS+Gy2lqdLfRIy0v
 HHpg2Q+14CakVIRPxumW6dEVgERS6d3E+KnfbyDE8yMdpSquSbV+FeqtWWhhiEczj0HV
 GB7siiMnKUFS3Qh7bRs1GBb5f/5EiPTtpbbKxM+zwwBf6Q5p5TpJQ3W+qfzi23iLXM0F
 CR24CtwWjr5CL3ywUwLB/umNHt94PyMjdlDctnG2QPdMVPKj4w+bEoCsPlkKK5Oe9FKT
 2ak+47MFpNYgCYNF758CpmCGK+EFro8LYnr3Y98Z73OjC+WvQjlLj+a0y6FqcgFBx/bN
 3Shg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781328158; x=1781932958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8it+egN+vgeOFmSRjEavP5t+0d6gXiZXjFH/DtNplZE=;
 b=o8vwMg42MdXVeN3nCzhZr9CfD/0XY32J3NPfraK6P/07HR633iPQZ/4Sbe1yRiQ4IT
 IK5jwBQIxUxQnz6zPdM1C+88nI/ATWBXQIDczrhcjFqV5Fid8Cwhqaktc7VGPzHpK6tt
 D/7mOmVDvcPhiDAiB6y+DheePUq9MfTF3sWKfvK3BvCjS5wILUOxK1djzlFN2RIMXo2Q
 ywXJ4+z/w9EtyJPb0aGqKPj7wlgwLuY+yDzP80NazRso4W36mAnXO7V4Hwliw6JU0ZoF
 2flr1ikLV5MMVBPQ1RJMjUpJc8YkXd5ecaiVYjOuCaJtezYjl0ZjNNuxk4mzE9JMv+C6
 wAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781328158; x=1781932958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8it+egN+vgeOFmSRjEavP5t+0d6gXiZXjFH/DtNplZE=;
 b=e3uU1wEKoz2GlS3ELx8YRo8naScJVn/KZ7tonck7DaMcTW78r80RSZyH+VLVmTgQ1+
 lqDHfOLbCTcxRNN6Cjs07g5O95rL/Ar+j06IuZUIsghJqmLOXDWEUEDlr6+TXcU1dAfz
 5K5z2ugG7L1neYrSIrSeo75Q98ux5bH38+Yn5I/vrcrtxzdIFZ06OmUU/IK1dhBUQYSW
 SPjTSg99+bwJSmWI1LisfKa8aKWRtNbbbwsmvDITSozTY7vklZ8tYs4l8hcXlaNvYV7R
 vtxtR7xFycWEpPr6JsHt8HXPSwTVZTnXsPAlQ5BHK2WnhC9hbbLhEwqtJwv9zPgjd65O
 RjrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TZIKpwXvZQiQlQrmwbf2x6ZZ4yK04MFIbq1HNEER1Ss2ms6KFyr2Y05o5Qak7oNpLGjGTb1jMcNF3@nongnu.org
X-Gm-Message-State: AOJu0YxJKsc4NaBfCqHZ/heR7tvWpzLoMaQmHSY0Dvoiv3viMGk1Lbw1
 cfJuGB/41cbCiJbr01ThozId29tW7ZrbgYVcQxHnC6OznSViLsiwO7Xkv64RRFo6YDxfm7Nyb/i
 NPTRLflH+E73+/OzFI0CR31tqT3VrwDE=
X-Gm-Gg: Acq92OG3iIKsvFLPgO5rrfExEYOHadhNGAJkd9lZRQuaYaIA0vBS11/lBAwADStzFcn
 HUNuCMBs59cBPYmEfekya2w5YzzzM4PFsJjsR0HvDpu+l6pf4SjDu3hwXEUbL12g4Ak+pftvG1a
 FPdORcaLwqdMee5gS+J3pYi8r5d1L8+8eFU+7KOiAbRPxWLlK17/j70aDyyjKAkHQJR69WH9q0c
 i1a5GS3JK2cDvhQm/0VV8T5alyQZThoLY1eRSAtHYR9bSi+7hkhGdRhx3RL714XvBwZvwnPicRg
 5YA=
X-Received: by 2002:a17:906:8a4b:b0:bd1:fe8f:59ab with SMTP id
 a640c23a62f3a-bfe2a2198eamr194270566b.23.1781328157761; Fri, 12 Jun 2026
 22:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260605034729.2874861-1-kylefoxaustin.github@gmail.com>
 <CAFEAcA_=2j+jHuqcCF0S9X=4q3dhY8=EKJuGCkuuUSG1jaO0bQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_=2j+jHuqcCF0S9X=4q3dhY8=EKJuGCkuuUSG1jaO0bQ@mail.gmail.com>
From: kylefoxaustin <kylefoxaustin.github@gmail.com>
Date: Sat, 13 Jun 2026 00:22:26 -0500
X-Gm-Features: AVVi8CdAsw54szzgiQrTO3kXZFGcrF7r9CpU5YPZlpAAF0-7zH1CKVJm9hvnYr0
Message-ID: <CANqqvPeUAHNpw5_h=Lq4ts=W6sE49occngXga+o=Yezem0dr3g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: align down misaligned PMSAv7 MPU region base
 instead of dropping it
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001264a006541bc874"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-ed1-x531.google.com
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

--0000000000001264a006541bc874
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,
yeah sorry for sending this in.   Based on your feedback I went a bit deepe=
r
and realized what you pointed out: I was chasing a software bug that
exists in the guest and QEMU shouldn't emulate one particular
implementation's choice as if it were architectural.

It is based on NXP's proprietary M7 sdk firmware which I can't modify.
Plan is to clearly document local workaround and see if I can
later convince NXP to fix it on their end.

Please drop this one; thanks for the review!!.

-- Kyle


On Mon, Jun 8, 2026 at 4:37=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Fri, 5 Jun 2026 at 04:47, Kyle Fox <kylefoxaustin.github@gmail.com>
> wrote:
> >
> > When a PMSAv7 (ARMv7-M) MPU region's DRBAR base is not aligned to its
> > DRSR region size, get_phys_addr_pmsav7() logged a guest-error and
> > skipped the region entirely (continue). The architecture calls a
> > misaligned base UNPREDICTABLE, but real Cortex-M hardware does not
> > disable the region: RBAR.ADDR is only bits [31:log2(size)], so the
> > sub-size low bits are simply ignored and the region matches against the
> > aligned-down base.
> >
> > NXP's i.MX95 Cortex-M7 firmware (and the MCUXpresso SDK demos) rely on
> > this. The M7 sets up a deny-all background region (region 0, whole
> > address space, AP=3D000) and then grants the peripheral space with a
> > 512 MiB region programmed as DRBAR=3D0x4c800000 - misaligned, intended =
as
> > 0x40000000. QEMU dropped that region, so a privileged access to e.g.
> > LPUART3 at 0x42570000 fell through to the deny-all region and took a
> > MemManage fault (CFSR.DACCVIOL), trapping the firmware in its default
> > fault handler before it could print anything.
>
> This is a guest software bug -- software must not rely on UNPREDICTABLE
> behaviour, even if the hardware implementation happens to do the
> same thing every time. Other M-profile CPUs might do something different.
> The right thing to do here is to fix the broken software...
>
> thanks
> -- PMM
>

--0000000000001264a006541bc874
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><div>yeah sorry for sending this in.=
=C2=A0 =C2=A0Based on your feedback I went a bit deeper<br>and realized wha=
t you pointed out: I was chasing a software bug that=C2=A0<br>exists in the=
 guest and QEMU shouldn&#39;t emulate one particular=C2=A0<br>implementatio=
n&#39;s choice as if it were architectural.</div><div><br>It is based on NX=
P&#39;s proprietary M7 sdk firmware which I can&#39;t modify.=C2=A0=C2=A0<b=
r>Plan is to clearly document local workaround and see if I can=C2=A0<br>la=
ter convince NXP to fix it on their end.=C2=A0</div><div><br></div>Please d=
rop this one; thanks for the review!!.<br><br>-- Kyle</div><div dir=3D"ltr"=
><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Jun 8, 2026 at 4:37=E2=80=AFAM Peter Maydell =
&lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.may=
dell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Fri, 5 Jun 2026 at 04:47, Kyle Fox &lt;<a href=3D"mailto:=
kylefoxaustin.github@gmail.com" target=3D"_blank">kylefoxaustin.github@gmai=
l.com</a>&gt; wrote:<br>
&gt;<br>
&gt; When a PMSAv7 (ARMv7-M) MPU region&#39;s DRBAR base is not aligned to =
its<br>
&gt; DRSR region size, get_phys_addr_pmsav7() logged a guest-error and<br>
&gt; skipped the region entirely (continue). The architecture calls a<br>
&gt; misaligned base UNPREDICTABLE, but real Cortex-M hardware does not<br>
&gt; disable the region: RBAR.ADDR is only bits [31:log2(size)], so the<br>
&gt; sub-size low bits are simply ignored and the region matches against th=
e<br>
&gt; aligned-down base.<br>
&gt;<br>
&gt; NXP&#39;s i.MX95 Cortex-M7 firmware (and the MCUXpresso SDK demos) rel=
y on<br>
&gt; this. The M7 sets up a deny-all background region (region 0, whole<br>
&gt; address space, AP=3D000) and then grants the peripheral space with a<b=
r>
&gt; 512 MiB region programmed as DRBAR=3D0x4c800000 - misaligned, intended=
 as<br>
&gt; 0x40000000. QEMU dropped that region, so a privileged access to e.g.<b=
r>
&gt; LPUART3 at 0x42570000 fell through to the deny-all region and took a<b=
r>
&gt; MemManage fault (CFSR.DACCVIOL), trapping the firmware in its default<=
br>
&gt; fault handler before it could print anything.<br>
<br>
This is a guest software bug -- software must not rely on UNPREDICTABLE<br>
behaviour, even if the hardware implementation happens to do the<br>
same thing every time. Other M-profile CPUs might do something different.<b=
r>
The right thing to do here is to fix the broken software...<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--0000000000001264a006541bc874--

