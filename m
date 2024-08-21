Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2D1C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgm1H-0001zM-AS; Wed, 21 Aug 2024 10:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sgm1F-0001xl-KG; Wed, 21 Aug 2024 10:09:01 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sgm1D-0001Qm-LC; Wed, 21 Aug 2024 10:09:01 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5334b0e1a8eso556534e87.0; 
 Wed, 21 Aug 2024 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724249337; x=1724854137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HPeH/DTwx6cdM/tyeKlg//aAx1mxPlCPo5ZJZWF1rJQ=;
 b=PNUu9CBjDlRFwlgDwP6E8T54mmlCMOo6TT/4DncVaqdoVe4JNi4lYXLGts/8xJunqo
 7VX8pnujHx73AN/LKGelkLHsAElNN5vNFiTSC5SXeslwP+d5IPUTK/q0tPnjV4NzAPc8
 y/h5aXQCRz7Hz+2G9ikcqdC5VrwQ0TklgEl3ihfkT27cfIojMK9Hb+665r0RJhLkGxA5
 1kJ+WLUBlhKxaMLvS7PNBxc2MkbjMD4SBlqlerzk57ipRBYFuFo3LpLwNYPveaeMs6b+
 Mb20rLK8t0ngPUberMBKj7YZ+IE2w1cKpPoZq9ygUn9IdHH/5n2AEgdzL9emfeLIjVdY
 uHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724249337; x=1724854137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HPeH/DTwx6cdM/tyeKlg//aAx1mxPlCPo5ZJZWF1rJQ=;
 b=Vtxvs2zXtm3QJJAByBhBHcnhZJSYuhcxI777KRFHy2K7dm1MWjJVVBSMB4OAL1JHWj
 iTglYdnxcueF7Xb0HpEccbicf4qm6YGIoBkxo1yJP6pKDbmYzB2+KBh38XPcOtfwOx16
 d0W3PT6Odvj+2UztE4v4Vk56t3PK1Er2sY6sXApf//wpcVeAsfljITC2srsEq2g3XsbQ
 l5F01zFIbt8t+uVBJTbELIzBcQlf+cuBNmS7KfmRj9ioKnUvk/3AL33q/g50xK5p5KVS
 u3D6ntEioxbOkyixHbAtMbZkm9LptC/dHvNktM8cUzwZJkiqmCS4c9R4Wq3KGWJFcP+e
 Dw3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7MsEhGJO4E1Ia8u3Jkq5Ebgjre8KeosSEpb5DqCBVkAAIsRYsGR6E4ijKSOVNn/0e7uggqntrkQ==@nongnu.org
X-Gm-Message-State: AOJu0Yy3fnU/pamm5BQd3V5WL7wec6a4JY7XisZ4TQRcbYFq7DKRR38d
 0GNfheQbD0q+VPnmXMX2korCcpiDwFHQhH7Ci9aaHgmhfXZLKW/q9FP7Pqpre+Pa2MiVL4V9rxH
 AcrBSrLkj3y1402xsWMC4awmfZkY=
X-Google-Smtp-Source: AGHT+IEX5WcPmUR2Sa5kyBd3E2GmWHptA7lTwUB67ynWYRh7ywAJT1DVQiZtDP6X5vAD3ORYqvt6OtycyL26I46elkw=
X-Received: by 2002:a05:6512:114d:b0:52c:dac3:392b with SMTP id
 2adb3069b0e04-53348564d0bmr1989619e87.33.1724249336445; Wed, 21 Aug 2024
 07:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145514.63046-1-nabiev.arman13@gmail.com>
 <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
In-Reply-To: <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
From: =?UTF-8?B?UGh5c2ljcyDQndCw0LHQuNC10LI=?= <nabiev.arman13@gmail.com>
Date: Wed, 21 Aug 2024 17:08:44 +0300
Message-ID: <CAGMt57c=Nv2Teu_=cqteCGs1yjPWQT7vfUs42hFL+MCZjbJEeQ@mail.gmail.com>
Subject: Re: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000034021506203215a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=nabiev.arman13@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000034021506203215a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for not providing enough argumentation for my patch. I found a
configuration where this error occurs. Please take a look at
https://gitlab.com/qemu-project/qemu/-/issues/2522.

=D0=B2=D1=82, 20 =D0=B0=D0=B2=D0=B3. 2024=E2=80=AF=D0=B3. =D0=B2 19:20, Pet=
er Maydell <peter.maydell@linaro.org>:

> On Tue, 20 Aug 2024 at 17:03, <nabiev.arman13@gmail.com> wrote:
> >
> > From: armanincredible <nabiev.arman13@gmail.com>
> >
> > Signed-off-by: armanincredible <nabiev.arman13@gmail.com>
>
> [cc'd the ppc maintainers and list]
>
>
>
> > ---
> >  target/ppc/machine.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 731dd8df35..d433fd45fc 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)
> >  }
> >
> >  static const VMStateDescription vmstate_tlbemb =3D {
> > -    .name =3D "cpu/tlb6xx",
> > +    .name =3D "cpu/tlbemb",
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> >      .needed =3D tlbemb_needed,
>
> This does look clearly a mistake, but on the other hand the
> name field in a VMStateDescription is part of the on-the-wire
> format, so changing it breaks migration compatibility.
>
> Before we make this change we need to confirm that it is
> not used on any machine types where we care about cross
> version migration compat.
>
> Alternatively if we need to keep the compatibility across
> versions we could leave it as is and add a comment about
> why. (I don't think we'll have a problem with incorrectly
> interpreting a tlbemb as a tlb6xx, it will mismatch for
> other reasons.)
>
> thanks
> -- PMM
>

--00000000000034021506203215a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry for not providing enough argumentation for my patch.=
 I found a configuration where this error occurs. Please take a look at <a =
href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2522">https://gitlab.=
com/qemu-project/qemu/-/issues/2522</a>.<br></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 20 =D0=B0=D0=B2=
=D0=B3. 2024=E2=80=AF=D0=B3. =D0=B2 19:20, Peter Maydell &lt;<a href=3D"mai=
lto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 20 Aug 2024 at 17:0=
3, &lt;<a href=3D"mailto:nabiev.arman13@gmail.com" target=3D"_blank">nabiev=
.arman13@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: armanincredible &lt;<a href=3D"mailto:nabiev.arman13@gmail.com" =
target=3D"_blank">nabiev.arman13@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: armanincredible &lt;<a href=3D"mailto:nabiev.arman13@gm=
ail.com" target=3D"_blank">nabiev.arman13@gmail.com</a>&gt;<br>
<br>
[cc&#39;d the ppc maintainers and list]<br>
<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 target/ppc/machine.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/target/ppc/machine.c b/target/ppc/machine.c<br>
&gt; index 731dd8df35..d433fd45fc 100644<br>
&gt; --- a/target/ppc/machine.c<br>
&gt; +++ b/target/ppc/machine.c<br>
&gt; @@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static const VMStateDescription vmstate_tlbemb =3D {<br>
&gt; -=C2=A0 =C2=A0 .name =3D &quot;cpu/tlb6xx&quot;,<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;cpu/tlbemb&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .needed =3D tlbemb_needed,<br>
<br>
This does look clearly a mistake, but on the other hand the<br>
name field in a VMStateDescription is part of the on-the-wire<br>
format, so changing it breaks migration compatibility.<br>
<br>
Before we make this change we need to confirm that it is<br>
not used on any machine types where we care about cross<br>
version migration compat.<br>
<br>
Alternatively if we need to keep the compatibility across<br>
versions we could leave it as is and add a comment about<br>
why. (I don&#39;t think we&#39;ll have a problem with incorrectly<br>
interpreting a tlbemb as a tlb6xx, it will mismatch for<br>
other reasons.)<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--00000000000034021506203215a9--

