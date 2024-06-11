Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E52C27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 01:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGqkh-0007SL-TN; Mon, 10 Jun 2024 21:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGqkg-0007S6-5q
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 21:56:46 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sGqkd-0008NU-WF
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 21:56:45 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57c68c3f8adso579907a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718071002; x=1718675802; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jA9plbGjO19auJGrvFBaMK0jULV71vxMlfivxMbC8X8=;
 b=NPuB1rOU6PA5HecV4xrTvCHS/ubL8TtCuO6amZpmgs/D3xKGtPPIErmSoVk3FgWTP7
 ItfaEY+637BelMHv0TnaxkX/ElV0eT89LLRmE42RaJnoyWGUUL5HLX/Wq8dcD1NpK9Gi
 82iBSr4FP0wMNWrTj/xx5VjVAqkpdCVVClvWnOVbGLlVwmwxqZB6jt6yDfiO+b6T4Vh4
 82Aklo/cy1HJK2K4MtR61uyqOxXX0UJrHAbtRcC9wawL/d/a/JrOtVPvDuOSWk++Qlc9
 Xlrl1NGCZa6C4yV+4uHxON21K65YkDGsv2WAxOo8y9ZpCbGooG7YUH9FjkIH3NlDxfyR
 7hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718071002; x=1718675802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jA9plbGjO19auJGrvFBaMK0jULV71vxMlfivxMbC8X8=;
 b=dKCFK6tcsW2NJ5Twqsoi9NdkqiSGY3Jxd9WDJikDlmXGqfzJCoXF+jbA4YZMO5h4sw
 2OILs1BZrzsSF0Qy9o7XOXqnlgaMruHRAsvl0ll5YlfmJugexmEJZGAryNBY7rSnAh5z
 dfqnqDs81JZ+f1ld6dAJZGewavskxqp7yxdfl5qOBSOiEIt66//Gqtg/kCPMNgGuxjOb
 z0XvWi6xAj+kG09V6lEXNr/jF1U+Prpa7nrJFQSm7nMwb/1vzZo5DvSTMaZ6zxMlbKCr
 UHEiA1npoXUXyndrSpPUH/gA0rMEoZRtja7357GYtdFeUtHwQOHLeHlu8A/eXJlfK9/F
 VQVQ==
X-Gm-Message-State: AOJu0Yxq1w+UjNXgFex33479ULNneM1AWBvd3Q7Xp8YKQ0Tq9nyqsfGo
 L1+znm4vvsnffqXsQHtd6EY0vroPG0OOA1inC0g39QlnWLr9wk5D3mdqJtdGewt0CY2pigPAacr
 goJZqpk65TIsONrbAtS+bWJNX0UIY4RvXhoNrOg==
X-Google-Smtp-Source: AGHT+IF8nCsSuMNAItG5gbTwCQij+80ptnI90P+Od+yRjL3GYo+iAAv2id54Cpfp+bsMwcJ4mrNsf7A0LMNUJhVhd8o=
X-Received: by 2002:a50:96c4:0:b0:57c:5b26:46c9 with SMTP id
 4fb4d7f45d1cf-57c5b264930mr7816692a12.9.1718071001671; Mon, 10 Jun 2024
 18:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063154.31298-1-frank.chang@sifive.com>
 <20240605063154.31298-2-frank.chang@sifive.com>
 <CAKmqyKN8J1g_1XyAVxpjWiSQDDhPuKrQk9x3ys2JCbiaGyf=AA@mail.gmail.com>
In-Reply-To: <CAKmqyKN8J1g_1XyAVxpjWiSQDDhPuKrQk9x3ys2JCbiaGyf=AA@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 11 Jun 2024 09:56:29 +0800
Message-ID: <CAE_xrPhZPghZmv81n4hvV=fpGege0MO0v-SHAKbL_30WNbCtNA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/6] target/riscv: Introduce extension implied
 rules definition
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c10200061a9393c5"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000c10200061a9393c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

On Tue, Jun 11, 2024 at 9:35=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Wed, Jun 5, 2024 at 4:35=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > RISCVCPUImpliedExtsRule is created to store the implied rules.
> > 'is_misa' flag is used to distinguish whether the rule is derived
> > from the MISA or other extensions.
> > 'ext' stores the MISA bit if 'is_misa' is true. Otherwise, it stores
> > the offset of the extension defined in RISCVCPUConfig. 'ext' will also
> > serve as the key of the hash tables to look up the rule in the followin=
g
> > commit.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >  target/riscv/cpu.c |  8 ++++++++
> >  target/riscv/cpu.h | 18 ++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index cee6fc4a9a..c7e5cec7ef 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -2242,6 +2242,14 @@ RISCVCPUProfile *riscv_profiles[] =3D {
> >      NULL,
> >  };
> >
> > +RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] =3D {
> > +    NULL
> > +};
> > +
> > +RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] =3D {
> > +    NULL
> > +};
> > +
> >  static Property riscv_cpu_properties[] =3D {
> >      DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 1501868008..b5a036cf27 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -122,6 +122,24 @@ typedef enum {
> >      EXT_STATUS_DIRTY,
> >  } RISCVExtStatus;
> >
> > +typedef struct riscv_cpu_implied_exts_rule RISCVCPUImpliedExtsRule;
> > +
> > +struct riscv_cpu_implied_exts_rule {
> > +    /* Bitmask indicates the rule enabled status for the harts. */
> > +    uint64_t enabled;
>
> I'm not clear why we need this
>

This is because a rule may be implied more than once.
e.g. Zcf implies RVF, Zfa also implies RVF.
There's no need to check RVF's implied rule again for Zfa after Zcf's
implied rules are enabled.

The implied rules are checked recursively, so once the rule has been
enabled (per-CPU basis),
the rule (and all its implied rules) will not be rechecked.

Regards,
Frank Chang


> Alistair
>
> > +    /* True if this is a MISA implied rule. */
> > +    bool is_misa;
> > +    /* ext is MISA bit if is_misa flag is true, else extension offset.
> */
> > +    const uint32_t ext;
> > +    const uint32_t implied_misas;
> > +    const uint32_t implied_exts[];
> > +};
> > +
> > +extern RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[];
> > +extern RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[];
> > +
> > +#define RISCV_IMPLIED_EXTS_RULE_END -1
> > +
> >  #define MMU_USER_IDX 3
> >
> >  #define MAX_RISCV_PMPS (16)
> > --
> > 2.43.2
> >
> >
>

--000000000000c10200061a9393c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alistair,</div><div dir=3D"ltr"><br></div><div dir=
=3D"ltr">On Tue, Jun 11, 2024 at 9:35=E2=80=AFAM Alistair Francis &lt;<a hr=
ef=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br><=
/div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Wed, Jun 5, 2024 at 4:35=E2=80=AFPM &lt;<a href=3D"mailto:frank.c=
hang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt; wrote:<br=
>
&gt;<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; RISCVCPUImpliedExtsRule is created to store the implied rules.<br>
&gt; &#39;is_misa&#39; flag is used to distinguish whether the rule is deri=
ved<br>
&gt; from the MISA or other extensions.<br>
&gt; &#39;ext&#39; stores the MISA bit if &#39;is_misa&#39; is true. Otherw=
ise, it stores<br>
&gt; the offset of the extension defined in RISCVCPUConfig. &#39;ext&#39; w=
ill also<br>
&gt; serve as the key of the hash tables to look up the rule in the followi=
ng<br>
&gt; commit.<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 target/riscv/cpu.h | 18 ++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 26 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index cee6fc4a9a..c7e5cec7ef 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -2242,6 +2242,14 @@ RISCVCPUProfile *riscv_profiles[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NULL,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; +RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] =3D {<br>
&gt; +=C2=A0 =C2=A0 NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] =3D {<br>
&gt; +=C2=A0 =C2=A0 NULL<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 static Property riscv_cpu_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;debug&quot;, RISCVCPU, cfg.=
debug, true),<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index 1501868008..b5a036cf27 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -122,6 +122,24 @@ typedef enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 EXT_STATUS_DIRTY,<br>
&gt;=C2=A0 } RISCVExtStatus;<br>
&gt;<br>
&gt; +typedef struct riscv_cpu_implied_exts_rule RISCVCPUImpliedExtsRule;<b=
r>
&gt; +<br>
&gt; +struct riscv_cpu_implied_exts_rule {<br>
&gt; +=C2=A0 =C2=A0 /* Bitmask indicates the rule enabled status for the ha=
rts. */<br>
&gt; +=C2=A0 =C2=A0 uint64_t enabled;<br>
<br>
I&#39;m not clear why we need this<br></blockquote><div><br></div><div>This=
 is because a rule may be implied more than once.</div><div>e.g. Zcf implie=
s RVF, Zfa also implies RVF.</div><div>There&#39;s no need to check RVF&#39=
;s implied rule again for Zfa after Zcf&#39;s implied rules are enabled.</d=
iv><div><br></div><div>The implied rules are checked recursively, so once t=
he rule has been enabled (per-CPU basis),</div><div>the rule (and all its=
=C2=A0implied rules) will not be rechecked.</div><div>=C2=A0</div><div>Rega=
rds,</div><div>Frank Chang</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
Alistair<br>
<br>
&gt; +=C2=A0 =C2=A0 /* True if this is a MISA implied rule. */<br>
&gt; +=C2=A0 =C2=A0 bool is_misa;<br>
&gt; +=C2=A0 =C2=A0 /* ext is MISA bit if is_misa flag is true, else extens=
ion offset. */<br>
&gt; +=C2=A0 =C2=A0 const uint32_t ext;<br>
&gt; +=C2=A0 =C2=A0 const uint32_t implied_misas;<br>
&gt; +=C2=A0 =C2=A0 const uint32_t implied_exts[];<br>
&gt; +};<br>
&gt; +<br>
&gt; +extern RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[];<br>
&gt; +extern RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[];<br>
&gt; +<br>
&gt; +#define RISCV_IMPLIED_EXTS_RULE_END -1<br>
&gt; +<br>
&gt;=C2=A0 #define MMU_USER_IDX 3<br>
&gt;<br>
&gt;=C2=A0 #define MAX_RISCV_PMPS (16)<br>
&gt; --<br>
&gt; 2.43.2<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--000000000000c10200061a9393c5--

