Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2478D6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfMl-0000wL-UU; Wed, 20 Nov 2024 02:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfMh-0000vd-A1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:43:07 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfMf-0005fI-LK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:43:07 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21263dbbbc4so11625695ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088584; x=1732693384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVJZWACSwns+cB2QZpdi34uCMXdJgVwzTrF6flYqclU=;
 b=B+TtEOyZncYllh/I/IrlJCUKpciMcMh6MOZgVlpHV6NjI12e3/ql8juk5Q3Ahlrw0y
 cemOIBryyZb5OgQyXUgTcQIFdoG5vcB2avLX51BYMMN8CkCZj6yQ42TCF5VzQUvAeKB3
 hB4eN4gG3969wR0lYq00Ap4FFQkCtmC75jvPcyAVlIhEN0gbwJUc3k3Mb8FB5+n647Fa
 QP/j+1azQJBLkRK4u3VANS8lS/KBbVV2WQpEHbMV7Q2CW9r7To09m9uDhNPoyAQWi2v4
 FDBtz50QCmmYq6FxBGl/iu4uPh4wcqheJiiC8vwTu2fyrgyZAg9q63LOk/YVJsYys/8s
 /ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088584; x=1732693384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVJZWACSwns+cB2QZpdi34uCMXdJgVwzTrF6flYqclU=;
 b=dIiTu+koFR6bti/cm+BwJSIH1K/o4KoyWas9tg/hYV0RUVMcCBHrcsQbCxB33J+BNk
 eQ6mmqHOiHTBFpb0BAAsZ/yltQveVfJCoRS8GKa1hUW1KTuvxp351Haj+K7VL/UhnbDx
 LU4IN1BPnel87wLyLjlfQTSOW4wL9SwsYpevgkuJrVr2rMZ7Qnf8RT89Ow6dBIDXiOdi
 dx/2EFNPstdCeeuL7NWay6B1jBZXqv+ZRlrlOVQnYCHK1NLAsqeKeqkpvpb8rw5U23As
 icMJSj58k6OXtzSsrXZNJBnhW7srrAarz9QAfn5UeR/i8tLQnVDKg7QEYk1aaVI7CKCy
 4wQQ==
X-Gm-Message-State: AOJu0YzWoXEy2oVNzBEP7U4exQWtrYXAfD4AJxQyF5Av0MykMlhl2qzo
 u4h26MXO7TVAV6ZWOq8v1a6X3m2VrRvwn03C7aiDY1lq6ApHqnrVJkOhRD1cFNpJ+BacO/xYieV
 bpNy69p/fhbzia6LK6MQPqil5iyRio7ZXCrqQBA==
X-Google-Smtp-Source: AGHT+IHKxwj6M9QPc3/9mCOQAk54bWa+HFAjJwi4V4688nG+LYGS5Rea5AFSi0MA7PAwWgOwCmLJfJaMrpKOnP13f5Q=
X-Received: by 2002:a05:6a21:3d95:b0:1dc:2365:a114 with SMTP id
 adf61e73a8af0-1ddaebcdd0amr2118276637.24.1732088584201; Tue, 19 Nov 2024
 23:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-6-fea.wang@sifive.com>
 <CAKmqyKMc2rL24MfRQsU-ahQsLw=BQUQ83=+OZ8B-6YNPAA0A0A@mail.gmail.com>
In-Reply-To: <CAKmqyKMc2rL24MfRQsU-ahQsLw=BQUQ83=+OZ8B-6YNPAA0A0A@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Wed, 20 Nov 2024 15:42:52 +0800
Message-ID: <CAKhCfsdiGN+hSbQ1KqVo=0Rv-X_jbHRTrYPkj1wNcTxZiDBwfg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] target/riscv: Expose svukte ISA extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000c811c50627534cf3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x636.google.com
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

--000000000000c811c50627534cf3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, I will add a new commit for checking the extension in RV32.
Thank you.

Sincerely,
Fea

On Tue, Nov 19, 2024 at 11:34=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com>
wrote:

> On Tue, Nov 12, 2024 at 7:14=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wr=
ote:
> >
> > Add "svukte" in the ISA string when svukte extension is enabled.
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  target/riscv/cpu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index f219f0c3b5..6d3e9d563d 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -199,6 +199,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> >      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> >      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> > +    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
> >      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> >      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
> >      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
> > @@ -1595,6 +1596,7 @@ const RISCVCPUMultiExtConfig
> riscv_cpu_vendor_exts[] =3D {
> >
> >  /* These are experimental so mark with 'x-' */
> >  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> > +    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>
> There should be a check to make sure this isn't enabled for RV32
>
> Alistair
>

--000000000000c811c50627534cf3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK, I will add a new commit for checking the extension in =
RV32.<div>Thank you.</div><div><br></div><div>Sincerely,</div><div>Fea</div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Tue, Nov 19, 2024 at 11:34=E2=80=AFAM Alistair Francis &lt;<a href=3D"m=
ailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Nov 12, 2024 at 7:1=
4=E2=80=AFPM Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=3D"=
_blank">fea.wang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add &quot;svukte&quot; in the ISA string when svukte extension is enab=
led.<br>
&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" target=
=3D"_blank">jim.shu@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index f219f0c3b5..6d3e9d563d 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -199,6 +199,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, e=
xt_svinval),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, e=
xt_svnapot),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ex=
t_svpbmt),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svu=
kte),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ex=
t_svvptc),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, =
ext_xtheadba),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, =
ext_xtheadbb),<br>
&gt; @@ -1595,6 +1596,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_ex=
ts[] =3D {<br>
&gt;<br>
&gt;=C2=A0 /* These are experimental so mark with &#39;x-&#39; */<br>
&gt;=C2=A0 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {=
<br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;x-svukte&quot;, ext_svukte, fa=
lse),<br>
<br>
There should be a check to make sure this isn&#39;t enabled for RV32<br>
<br>
Alistair<br>
</blockquote></div>

--000000000000c811c50627534cf3--

