Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F8CC5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtJ37-0007SZ-C3; Mon, 10 Aug 2026 01:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtJ34-0007QS-7R
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:59:46 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtJ32-0008An-9P
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:59:45 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so2271166a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 22:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786341582; cv=none;
 d=google.com; s=arc-20260327;
 b=eIttHIzPBO6O0JdozenjVSWKpD2bO7vMpkokHiaLE5Cq7KZ3lUqtFJCN57XHAQAP8+
 NaOacD2smhrcSFk207lk00sSr0IChd3I2TiTyJaPyhtGQsnuYH77K0Ysph+EsYiAkEWf
 k+Uj0LmOG21/x/unf8/BS6P5VUsJWMDuQcqPRutxbj+a/vnq6Oc2dNp2iQs2D53BXmKA
 bV2XFXp2oMqHjeYCB5Gdh8HKmg98GZgDiESHCmJ9ZnHL+DrcFjizJ08Egj3o+GzwT7RU
 Tn3TqTAzf/plySpn90ML4Oa1BTmD1aKTuHxja97rbuXk9d3rLrwSN9Zy3wifEw3435Kt
 NTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qNKYrIqi4VQVj1jd9Wxmt3C/DiIje5TlJdX3XScfTyg=;
 fh=YfaUHuIIljKaZoeu4cVBi2p6IHamIXuQ0zRCEROCZYc=;
 b=VKEhtH3neFAHgGG7xVll7JkFteCacdCuwpXDwML3oRYPAZnBfhVUIhj9FMY8NvWbV6
 kN8R3k2a4JEQUlUJ6dHVJ0YjE7inAdq3OKyuGzkNilM7APoFmd5xmvMhCBFk7XqZ/tFl
 8wHPSMl193Isii2d4+2eWTQjQHF5TZca8aBX2bJ8Mc3rt2eVFXT7kFl8silumJ9WLlC3
 ShZW79zaTYpd4ORIjjfsyRJXGr8NQ435+7TME0nizpr6HGVudwtzHFOCGrLKzsr+lcpp
 E/E1EnDPfqJifYvtIUTtXY2gXPxLsFxGF7zVC2se1EnTQJ0aDoFICLwbQgq4wXB/pJw5
 GdNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786341582; x=1786946382; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qNKYrIqi4VQVj1jd9Wxmt3C/DiIje5TlJdX3XScfTyg=;
 b=QRiVcxu2C+/j9UsDNRVgFyV8/Tzt+hjp9roJ4tKJ80/VBxdSHsJRwPpmjLD2KyScLk
 5NJqlseWnFQpwBYMBv2qU/Hy3wOIdzi13eW2GT3qsQzqIzxl2F0BiqH/OGYhfwqdOcPh
 olbsxU6WejAjBmvWdCdPja2RmnU+XXq5P9OvqKN/UN7hZowqA/llUG/YCYblMtSe6h+Y
 XE583JWaJaYOcln8GAhuty1Uvi1V4ZEmYCpNisI0sppc/Qeln7FJud08TkeD45DSlEQr
 1T6mD4zOnuunqbqQpBub6FfAtbzvFIJbpr5hQ2iOd7QRSmxSXkQM/6E5Vp783R/ja2XP
 l7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786341582; x=1786946382;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qNKYrIqi4VQVj1jd9Wxmt3C/DiIje5TlJdX3XScfTyg=;
 b=o50/5qSPwILUUQ/8ZwsMjo7MTg63mA+N1QUF5aFRVkj8mcUXoZR7uuYhUAt6ko3jzz
 EGzueK8esdDD8ujPd78VLakABi+S9z+vrg+ohiQ/3TvAxKurZegDoJDmmaT45oNO6sYU
 KxDP1nn6I9Yk/qHubWF/PdtVzkFP2HOCL9axVg0SFWbcx/QyHauM4pQyJKBxXM50zHM1
 ZWNkfUWOPo8SEoHfsB3A+nvhbQsriZv+gesVpeXqGTN7fifFraMYgx3Je9LgNc4kU+zX
 Cyh80MA/oCvVjKpnQV8smh9upTOyc25Fkn40y52gfb0eU2ScGhJ+o0KEifXey7/DKdJX
 KDkw==
X-Gm-Message-State: AOJu0YyLG1/WVqd0SUdkRBZrGSexprea4jTWkCQN8uKKYgzFG82wjWdI
 i6eAln995kcdwHqAUfwxASsjHZ7pGpJUGL83yJljubAzEP2qdlG0r7+25LRDJ6bkvnG0/oUyTVx
 n+y3jUoFKDCpvNY6EdYb4+t6waeivvb+yR7jqZ2/7gA==
X-Gm-Gg: AR+sD11MQtdeK6uHqHEDfr07+j9weZBTG2WlGfixfqZ/bzI3tOcCEnOUjY/buUEIOBs
 XBYYNiLxXpOvDY+O9RGKIJAezHGsNvR9vNaH5QMB2b/BVX9TgwrkEJ148jPglLK0H4JmRioYmr6
 kbTPNVPums1lYRIxjj37CcJsDA6fJ+Ym+zSMimz+iylQmq8B3lKzeD2uQVhuFL1SpFFq1lVQKhz
 CKcFlmpA1IiJaamqBiKNxPmn0dAGLZT/TU5zUgC3HjiPloQjNLls8nt8RlNX5B3XBVvfvOVrOrY
 tA/kd53IMPh/bck2PHnJaY6H6qPQ0ZPFP0uERzNTLToewD7/v8+bfW1w/g==
X-Received: by 2002:a17:907:3cc4:b0:c12:3059:4071 with SMTP id
 a640c23a62f3a-c2087572c2bmr934037766b.15.1786341580766; Sun, 09 Aug 2026
 22:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260805164345.698208-1-frank.chang@sifive.com>
 <20260805164345.698208-2-frank.chang@sifive.com>
 <a26fb578-54bd-40c4-ab4f-59ee61f3c843@oss.qualcomm.com>
In-Reply-To: <a26fb578-54bd-40c4-ab4f-59ee61f3c843@oss.qualcomm.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 10 Aug 2026 13:59:29 +0800
X-Gm-Features: AUfX_mxpY9unEVo-3UXk2lCX_rrnbjJNp7EJGgcqWeSlknGIQ-W_Udl8ngwoCPY
Message-ID: <CAE_xrPhGq0v_-b8PGj2rdfv7qZ_pkBmz-XTFHzOQou8UB-f8OQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] target/riscv: Add Zicclsm CPU option
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, 
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000005e8e4c0658ab0ff4"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x536.google.com
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

--0000000000005e8e4c0658ab0ff4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, Aug 7, 2026 at 9:49=E2=80=AFPM Daniel Henrique Barboza <
daniel.barboza@oss.qualcomm.com> wrote:

> Hi Frank!
>
> On 8/5/2026 1:43 PM, frank.chang@sifive.com wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Add Zicclsm CPU option so that user can turn on/off misaligned loads
> > and stores support.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Max Chou <max.chou@sifive.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   target/riscv/cpu_cfg_fields.h.inc | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/target/riscv/cpu_cfg_fields.h.inc
> b/target/riscv/cpu_cfg_fields.h.inc
> > index 9eb47af0a76..f8c27a574f8 100644
> > --- a/target/riscv/cpu_cfg_fields.h.inc
> > +++ b/target/riscv/cpu_cfg_fields.h.inc
> > @@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
> >   /* Always enabled for TCG if has_priv_1_11 */
> >   BOOL_FIELD(ext_ziccrse)
> >
> > +BOOL_FIELD(ext_zicclsm)
> > +
>
> This is a needed step but, as is, it's not adding a new CPU option for
> users as
> the commit msg says.  This is being done in patch 7.
>
> I think this change should be squashed into patch 2, where ext_zicclsm is
> being
> added in eligible CPUs.
>

Thanks for the review.

I've squashed patch 1 into patch 2 and sent out the v8 patchset:
https://lore.kernel.org/qemu-riscv/20260810055618.1175500-1-frank.chang@sif=
ive.com/

Regards,
Frank Chang


>
>
> Thanks,
> Daniel
>
> >   /* Vendor-specific custom extensions */
> >   BOOL_FIELD(ext_xtheadba)
> >   BOOL_FIELD(ext_xtheadbb)
>
>

--0000000000005e8e4c0658ab0ff4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Daniel,</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, A=
ug 7, 2026 at 9:49=E2=80=AFPM Daniel Henrique Barboza &lt;<a href=3D"mailto=
:daniel.barboza@oss.qualcomm.com">daniel.barboza@oss.qualcomm.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Frank!<=
br>
<br>
On 8/5/2026 1:43 PM, <a href=3D"mailto:frank.chang@sifive.com" target=3D"_b=
lank">frank.chang@sifive.com</a> wrote:<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; <br>
&gt; Add Zicclsm CPU option so that user can turn on/off misaligned loads<b=
r>
&gt; and stores support.<br>
&gt; <br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" targe=
t=3D"_blank">max.chou@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@w=
dc.com" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg_fields.h.inc | 2 ++<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_=
fields.h.inc<br>
&gt; index 9eb47af0a76..f8c27a574f8 100644<br>
&gt; --- a/target/riscv/cpu_cfg_fields.h.inc<br>
&gt; +++ b/target/riscv/cpu_cfg_fields.h.inc<br>
&gt; @@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)<br>
&gt;=C2=A0 =C2=A0/* Always enabled for TCG if has_priv_1_11 */<br>
&gt;=C2=A0 =C2=A0BOOL_FIELD(ext_ziccrse)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +BOOL_FIELD(ext_zicclsm)<br>
&gt; +<br>
<br>
This is a needed step but, as is, it&#39;s not adding a new CPU option for =
users as<br>
the commit msg says.=C2=A0 This is being done in patch 7.<br>
<br>
I think this change should be squashed into patch 2, where ext_zicclsm is b=
eing<br>
added in eligible CPUs.<br></blockquote><div><br></div><div>Thanks for the =
review.</div><div><br></div><div>I&#39;ve squashed patch 1 into patch 2 and=
 sent out the v8 patchset:</div><div><a href=3D"https://lore.kernel.org/qem=
u-riscv/20260810055618.1175500-1-frank.chang@sifive.com/">https://lore.kern=
el.org/qemu-riscv/20260810055618.1175500-1-frank.chang@sifive.com/</a></div=
><div><br></div><div>Regards,</div><div>Frank Chang</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
Thanks,<br>
Daniel<br>
<br>
&gt;=C2=A0 =C2=A0/* Vendor-specific custom extensions */<br>
&gt;=C2=A0 =C2=A0BOOL_FIELD(ext_xtheadba)<br>
&gt;=C2=A0 =C2=A0BOOL_FIELD(ext_xtheadbb)<br>
<br>
</blockquote></div></div>

--0000000000005e8e4c0658ab0ff4--

