Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D0C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 18:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgqVB-00054L-2g; Wed, 21 Aug 2024 14:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sgqV7-00051f-Ve; Wed, 21 Aug 2024 14:56:09 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sgqV4-0000aM-QF; Wed, 21 Aug 2024 14:56:09 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53349ee42a9so24322e87.3; 
 Wed, 21 Aug 2024 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724266564; x=1724871364; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L9NkqNCbL0HiJ9fErAOwu/Rk53NSUP7ZR2r9G/J58R0=;
 b=J+hXxf+Yi2EE56TRqby+cAcsXIYww75B2IhYv3YdlcgVSWmPaw2KWOABwV31yfcD8U
 Lik83rjmWF/kUrvpSRrj+y2+GbeJV3MYQEG833FTcryITp1dUHByDINHmuERyRrKkbhb
 mxuu8nNoNoBalIi/tFKrQYc84Rq+rcZtWj1urvPN25YOH2uY8PNI/KLzeIant+Jixlhm
 q84L9x+/tgDvV3Pnk4F+YFcrpA9g+pMTmvziFXXh36csdq41rpM86wT4GBXHccKRTWy4
 lsBZIUgrCk8XECoSakwQuoJ/DiNNh3pudxb9RUMLLIIPt+yolPveYdfaVfXJln417sP2
 M07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724266564; x=1724871364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9NkqNCbL0HiJ9fErAOwu/Rk53NSUP7ZR2r9G/J58R0=;
 b=Fp1kaxaz9pNWu52ZZ88LlqLc7wsPEz+X2NoPqYfOhph4leHV4L9Ws1hPw55oZELnyI
 3ixefSOPyIk4UE5hkiN0CS1NEZiGIuRDAJDoCIWknQeA3moOBaxmNOtZWaMhysKuqQ9C
 36vFyV+s0UA+ms+jo0BxwnEd5A8Zr75HzxoI8yveaQTHAYTm5ACbnozl7XJ6JvEVYa9e
 vhax50DP9B+oar69AF/NDYvNTPKuRP0wGayj/NQj/3UWWLnN2p6yt+FnIsuNRNia6w3l
 Dr4Efy1VpnDnyPpYCDnkLFFgJ7MnqvUqOgGCm1LMJtI/oklk8Yga1KwYjbl/cHDZ286p
 qmUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeoEfJr1NC/LzhDps5zLj/YZu/kn46tSRuQqeOs9ncuRe1bfzeInm5tNzyySPoYmvEmdXS7cOETQ==@nongnu.org
X-Gm-Message-State: AOJu0YyPkJpA++yXBYvKiBpxdYvqkD9X993FCU13RHPZ+sMBshBCO7ps
 N/Z/BpZVaVWSDxj+zyYXPlu1LbRarG3Gl2kyQj51P80p9ShHU7FQiRzvfbltz1FizHq4HtAxa2f
 t8YEEcyFqkWawvtheZxH/XlqHwbE=
X-Google-Smtp-Source: AGHT+IFKp/EJoNUOVOihDpFO6s9m4rjI5q1WS/Vi2Osan/FFIrke63Mj80P4Mq/U2NrYk15n2YK+pRK6VYv2wSwT5Nk=
X-Received: by 2002:a05:6512:118d:b0:530:e323:b1cd with SMTP id
 2adb3069b0e04-53348590ef0mr1521167e87.40.1724266563642; Wed, 21 Aug 2024
 11:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145514.63046-1-nabiev.arman13@gmail.com>
 <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
 <CAGMt57c=Nv2Teu_=cqteCGs1yjPWQT7vfUs42hFL+MCZjbJEeQ@mail.gmail.com>
 <CAFEAcA_wpbEaX+iEz7syNd1tB7A77UVT75vzups=yZogJmiEaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_wpbEaX+iEz7syNd1tB7A77UVT75vzups=yZogJmiEaQ@mail.gmail.com>
From: Arman Nabiev <nabiev.arman13@gmail.com>
Date: Wed, 21 Aug 2024 21:55:52 +0300
Message-ID: <CAGMt57d7f1WwfvoCoOtFSEDm8eqMZAEP17DsZuo09dLi0j-A9w@mail.gmail.com>
Subject: Re: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000062d9b0620361834"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=nabiev.arman13@gmail.com; helo=mail-lf1-x134.google.com
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

--000000000000062d9b0620361834
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In my example in https://gitlab.com/qemu-project/qemu/-/issues/2522 the
.needed function returns true for vmstate_tlbemb, but not for
vmstate_tlb6xx. I tried to do some tests without fixing the typo. When I
changed the .fields in the two structures to the same value so that the
size of the data they stored matched, everything worked. I also changed the
order of vmstate_tlb6xx and vmstate_tlbemb in the subsections field of
vmstate_ppc_cpu, everything worked as well.
According to
https://www.qemu.org/docs/master/devel/migration/main.html#:~:text=3DOn%20t=
he%20receiving%20side%2C%20if,that%20didn%E2%80%99t%20send%20the%20subsecti=
on
and on my own tests I think the problem is that when reading saved data,
qemu uses the device name to determine an object that extracts a certain
size of data. Since the names are the same for vmstate_tlb6xx and
vmstate_tlbemb, it uses the functions for the first one due to a certain
order, which leads to an error, since the data from the second one was
saved.

On Wed, 21 Aug 2024 at 18:45, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 21 Aug 2024 at 15:08, Physics =D0=9D=D0=B0=D0=B1=D0=B8=D0=B5=D0=
=B2 <nabiev.arman13@gmail.com>
> wrote:
> >
> > Sorry for not providing enough argumentation for my patch. I found a
> configuration where this error occurs. Please take a look at
> https://gitlab.com/qemu-project/qemu/-/issues/2522.
>
> Hmm. I don't understand why fixing this field name would
> fix record-and-replay, because I would have thought that
> all that should matter is that the name that we write out
> in the record matches the one we read in in the replay...
>
> -- PMM
>

--000000000000062d9b0620361834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">In my example in=C2=A0<a href=3D"https://=
gitlab.com/qemu-project/qemu/-/issues/2522">https://gitlab.com/qemu-project=
/qemu/-/issues/2522</a> the .needed function returns true for vmstate_tlbem=
b, but not for vmstate_tlb6xx. I tried to do some tests without fixing the =
typo. When I changed the .fields=C2=A0in the two structures to the same val=
ue so that the size of the data they stored matched, everything worked. I a=
lso changed the order of vmstate_tlb6xx and vmstate_tlbemb in the subsectio=
ns field of vmstate_ppc_cpu, everything worked as well.<br>According to=C2=
=A0<a href=3D"https://www.qemu.org/docs/master/devel/migration/main.html#:~=
:text=3DOn%20the%20receiving%20side%2C%20if,that%20didn%E2%80%99t%20send%20=
the%20subsection">https://www.qemu.org/docs/master/devel/migration/main.htm=
l#:~:text=3DOn%20the%20receiving%20side%2C%20if,that%20didn%E2%80%99t%20sen=
d%20the%20subsection</a> and on my own tests I think the problem is that wh=
en reading saved data, qemu uses the device name to determine an object tha=
t extracts a certain size of data. Since the names are the same for vmstate=
_tlb6xx and vmstate_tlbemb, it uses the functions for the first one due to =
a certain order, which leads to an error, since the data from the second on=
e was saved.<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, 21 Aug 2024 at 18:45, Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 21 Aug 202=
4 at 15:08, Physics =D0=9D=D0=B0=D0=B1=D0=B8=D0=B5=D0=B2 &lt;<a href=3D"mai=
lto:nabiev.arman13@gmail.com" target=3D"_blank">nabiev.arman13@gmail.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; Sorry for not providing enough argumentation for my patch. I found a c=
onfiguration where this error occurs. Please take a look at <a href=3D"http=
s://gitlab.com/qemu-project/qemu/-/issues/2522" rel=3D"noreferrer" target=
=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/2522</a>.<br>
<br>
Hmm. I don&#39;t understand why fixing this field name would<br>
fix record-and-replay, because I would have thought that<br>
all that should matter is that the name that we write out<br>
in the record matches the one we read in in the replay...<br>
<br>
-- PMM<br>
</blockquote></div></div>

--000000000000062d9b0620361834--

