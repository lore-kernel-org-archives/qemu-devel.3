Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A43CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 02:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOo7J-0003Ki-5Z; Sun, 17 May 2026 22:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOo7H-0003KF-Q3
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:54:03 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOo7F-0004C7-Vv
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:54:03 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-135200bc7d2so4878477c88.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 19:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779072839; cv=none;
 d=google.com; s=arc-20240605;
 b=bK+X/C2O6muuNUOVYmCiDrkJjc7U9T6RFgMfY9q8PO9owJ3Zh5HU7pCQpQwcFU54YH
 NMTfVuLiC08JK95pvRtaG/cDg3y3f7J+K6posHTLBkQJXuIEhr9Rtndso8raBG78IyAR
 GLfy98FAV7LgOvMHjAR+PsXJ11CcO55KIb5gz6JB+1sP7A0Ll96+IuU4rnCY907ott8V
 HCJ3us0QcEjY8D8yxXW+l6Y2j100ySnADaVgnP+AelJKxxTZqjnBUbgIywT7PwHSEzMH
 uZz9X9qD5i1qMKCowTWzw9KyL3G6n0Mx0zE9ukh3nRyhXzNt9HHIOuvbmNtEzMsS6owg
 QwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XprUs4LEcnXlJA/HYk1RrGsGoQoOvFtr1OWtOtKF8e4=;
 fh=I0YBYH6NSRkwdjUKvrePNJJmq8Pe0mAFA7wPztLbjQA=;
 b=Z4ZJrtQl9V17nHNh0n60sod/hLguu7rO1irJQb1F69BSD5GVRY1MF1s+ha0bIOF0T2
 gAv72wEB5hue6/AUYmqoy4P6+KS7uZMAcwarPCUIJEL+yAUEvIU0MANL7xuwjPpvY2NQ
 XOBkVhWD+TdJGtmGkKspAMMTWHReeYanIBmOfnZZxGFEZHvQGdmdE/FJJnCgffkGCc2z
 BdqUeg3YIlrw1ce47TTtCW4m7xHclFGV6wmPJM99UIQ1vkrShrHEQlMaBYC/kdG4y/9q
 GH6if4giUcEmmr4REAUBOeaJ65f6Afwa/d1b3WDY+mdeMH8PDfyustmHMevquCdG7dJl
 aBTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779072839; x=1779677639; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XprUs4LEcnXlJA/HYk1RrGsGoQoOvFtr1OWtOtKF8e4=;
 b=FWk7hrp4lDv5TCpaVvrJVez7ETt7F8eGOuZDSpDN2ellJ1KMC/tIm5LaYtDiK5LYK7
 PQPBO2Lqkh8SjDbIh1JIlFpYTJdP0GtA5wPmZjtLg8EV11HEqDXCS9TSzwX7xfkuKXFT
 5uwT7grpm98mmkBq+OkyOR/3OTihiGDAxi9XtRbNDKL/jEVYJIOYxqJJF0dwWNtnHVhj
 TJ3rR3rscC7+tnZcnL0toTAeq78ah3ttSjeOViOnfVAJPTmbCCBr67m0DPHPUmuekQDm
 fpNn0rFXUmQd/6GOJbsQ1Jy+a7wWCmlGJJ9gJ9SoYRvMlfHQNClaIElbAaJedcfzWTLx
 LLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779072839; x=1779677639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XprUs4LEcnXlJA/HYk1RrGsGoQoOvFtr1OWtOtKF8e4=;
 b=r3hKwL9r2WxcI95FspZar3ipGCfBeQ10Vv8twrpPaoyGHsUEk1FJpenrD7DoAholPZ
 bdGBcJY3ynno+0o3/8nJU1kZUnKPRAzhuMh5u3GlOyu75c+Zx1QC3+1cZAFv4GxB//Nm
 0yzdUIIW2AL8zj/gXWGo6yCjsDrDODvtLpqP8srsUy/nzlYz+4ueZZWV4xtJWPWERlg2
 zqWNvfrq0k4MqEyQM3fOX4RCV6Js2H7GFSzVs83KlR/M74vYYOWbhUVDQdn+U4lncyBv
 GkNP7TMdEqOe7+jWHBD9xsNTj/sTnjuIpei+hjsBUvR7KOEGoEQp/tiXdiXEUQbjxvYR
 xkRg==
X-Gm-Message-State: AOJu0YxQ2XikEXFGCq0/z63UgVUtR0wUjF6XHmVVIMPxZ/0/2mxzRcpQ
 Sn34JHjB2lDmpYTKjcuh+U4kzaUIcuy23zuQmy43YREVX5O1fBvodPoqcJyCMRQHmwmgeiDGaNU
 980NkK/X9Vj94dIi8XhTSrTI/DsaqXcSmw111Hm7di4r3Udk9dMwoFndxEw==
X-Gm-Gg: Acq92OH9iut7hxAS4w5S5YFH4OLFQ+pNtRRjcRPq86D7g6sdinrhB4KAr0FgFBM/52E
 e3mFTfg2MBsQaEEkYu67+WMLGwEXA8kx03KOe+CDB+t6Ryas/WaieJ6fr9ZDWzHOVrRT5S30iRS
 NyXSoaOl/SSnzLPFsGV2Sl4j2ZQgDWa/Tw1qKGZRPjMydBDUj/Zr4lSusojhkVlW59sRs5lkuSW
 koEdwKNxmfCxHZESnXAcuLWMN1TzbJkxs0RACOEj5ApVxo2O2LHWHRiZhii4CHazg1hfkqbj43U
 cylVylFP/oc96xjinWdR
X-Received: by 2002:a05:7022:68a1:b0:134:c6ab:bead with SMTP id
 a92af1059eb24-1350484e8fcmr5363653c88.24.1779072839416; Sun, 17 May 2026
 19:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260106080520.28711-1-jay.chang@sifive.com>
 <a696a6c1-c1b0-40ed-8788-da7bd4d0d73d@ventanamicro.com>
In-Reply-To: <a696a6c1-c1b0-40ed-8788-da7bd4d0d73d@ventanamicro.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Mon, 18 May 2026 10:53:48 +0800
X-Gm-Features: AVHnY4KIu3sRVkbV34UVIYbNoB2-lvd-GXtCw-DKwpiZeMlaelRv6uaGPAFlfww
Message-ID: <CACNNAjMsNS4RUR+nR5aPhsb-w-QwUDNTNXYpim4fxRrqvNKW+A@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000009f8d6706520eac21"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=jay.chang@sifive.com; helo=mail-dl1-x1230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000009f8d6706520eac21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch.

Thanks,
Jay Chang

On Wed, Jan 7, 2026 at 9:52=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 1/6/26 5:05 AM, Jay Chang wrote:
> > When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
> > the IOMMU should re-check the command queue and continue processing
> > pending commands if head !=3D tail.
> >
> > Per RISC-V IOMMU specification, the software error recovery sequence:
> >
> >    1. Read the head pointer
> >    2. Software has two options:
> >       - Option 1: Set tail =3D head to re-start from an empty queue
> >       - Option 2: Overwrite the illegal command with a valid one
> >    3. Re-enable the command queue by writing 1 to cqcsr.cmd_ill
> >
> >    "At this point, IOMMU will start working on the first command
> >     in the queue."
> >
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>
> >   hw/riscv/riscv-iommu.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index b46b337375..e89a262a63 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -1992,6 +1992,16 @@ static void
> riscv_iommu_process_cq_control(RISCVIOMMUState *s)
> >       }
> >
> >       riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set,
> ctrl_clr);
> > +
> > +    /*
> > +     * After clearing error bits (CMD_ILL, CQMF), if queue is still
> active,
> > +     * re-process pending command.
> > +     */
> > +    ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> > +    if ((ctrl_set & RISCV_IOMMU_CQCSR_CQON) &&
> > +        !(ctrl_set & (RISCV_IOMMU_CQCSR_CMD_ILL |
> RISCV_IOMMU_CQCSR_CQMF))) {
> > +        riscv_iommu_process_cq_tail(s);
> > +    }
> >   }
> >
> >   static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
>
>

--0000000000009f8d6706520eac21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Gentle=C2=A0ping=C2=A0on this patch.<br><br>Tha=
nks,<br>Jay Chang</div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 7, 2026 at 9:52=E2=80=AF=
PM Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com"=
>dbarboza@ventanamicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><br>
<br>
On 1/6/26 5:05 AM, Jay Chang wrote:<br>
&gt; When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,=
<br>
&gt; the IOMMU should re-check the command queue and continue processing<br=
>
&gt; pending commands if head !=3D tail.<br>
&gt; <br>
&gt; Per RISC-V IOMMU specification, the software error recovery sequence:<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 1. Read the head pointer<br>
&gt;=C2=A0 =C2=A0 2. Software has two options:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Option 1: Set tail =3D head to re-start fr=
om an empty queue<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Option 2: Overwrite the illegal command wi=
th a valid one<br>
&gt;=C2=A0 =C2=A0 3. Re-enable the command queue by writing 1 to cqcsr.cmd_=
ill<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 &quot;At this point, IOMMU will start working on the firs=
t command<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the queue.&quot;<br>
&gt; <br>
&gt; Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" t=
arget=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
<br>
Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:daniel.barboza@o=
ss.qualcomm.com" target=3D"_blank">daniel.barboza@oss.qualcomm.com</a>&gt;<=
br>
<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu.c | 10 ++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 10 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c<br>
&gt; index b46b337375..e89a262a63 100644<br>
&gt; --- a/hw/riscv/riscv-iommu.c<br>
&gt; +++ b/hw/riscv/riscv-iommu.c<br>
&gt; @@ -1992,6 +1992,16 @@ static void riscv_iommu_process_cq_control(RISC=
VIOMMUState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQC=
SR, ctrl_set, ctrl_clr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* After clearing error bits (CMD_ILL, CQMF), if q=
ueue is still active,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* re-process pending command.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_C=
QCSR);<br>
&gt; +=C2=A0 =C2=A0 if ((ctrl_set &amp; RISCV_IOMMU_CQCSR_CQON) &amp;&amp;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !(ctrl_set &amp; (RISCV_IOMMU_CQCSR_CMD_I=
LL | RISCV_IOMMU_CQCSR_CQMF))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_process_cq_tail(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void riscv_iommu_process_fq_control(RISCVIOMMUState=
 *s)<br>
<br>
</blockquote></div>

--0000000000009f8d6706520eac21--

