Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8320DD6ACCD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGI0U-00017v-R1; Wed, 27 Nov 2024 08:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1tGI0S-00017K-Kx; Wed, 27 Nov 2024 08:23:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1tGI0Q-0001pW-VO; Wed, 27 Nov 2024 08:23:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43497839b80so31421835e9.2; 
 Wed, 27 Nov 2024 05:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732713772; x=1733318572; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BoyauqjFPTfQ7cwfUvUc5QJjg2eVMTThqYLshav7Nbc=;
 b=k0h652+9trmlL8HAYuXezK+sKACNoaNga6xvLnXJvrSulhzH2wiKs6GDW1ybrf3+3x
 YotBMWTgVGjtdw7n7nAe4qpepYwvw7phha2n7RUqDm53geDetaQX1+jT+tNA49X2y/U9
 NIPq7tA3wwkAEVb+ejXoUvTQiPgIRM52IkWx1BrgygLESh1GrXBStTi3aZFBp3M0cF54
 HljRPPq2FMdQK1+vEBLnMo71HrMK6OsvrnFJXV4kzVfWi+T3zOO8S3BADCvN9k0Hpk3+
 anAVUBY4TrO0NvGPt7URtfUCt2QoUlSdnEI4SPASvmPK6dCB9/gmoSBnPzRym2dMK7ke
 1iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732713772; x=1733318572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BoyauqjFPTfQ7cwfUvUc5QJjg2eVMTThqYLshav7Nbc=;
 b=nxNHKBm+AkqUFfEnBnoH0LJy+2zVG/RJZzbYj7MnRLujUrD0DmKL/7vL0RgZxPJZHk
 NvZphp/KOunc7yAVeSUiOWbHUE4XuJMGTr/QplDQhRl2T2+geAcf5K7xhou6/2hV2v2C
 0n9QPTp71PsB5iXbjizPGyLtqE4v3qQDmoMWPDJYSN0RJXqHNzyBC9vLubLS8sGJ5Jfl
 /NMCXmvEwAXZlxwztjzLnS/k+HFhz91RgKIa0iVaKlf+7CVo8Ekzjjnh8HOJ//mQCjwZ
 vdoTMnDDLZleVn7feOebNjSQJtwmPyDKWoxEKmaDnqA/XWAHPBDF4077uOR5WmzegGNT
 BYow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPrJ6n2zh8O14AyQ9NC04Pvb15RPeqBe+J0IgJWkFPzMpSkk9qdJ7SgKg3IhPNJMbGS9HTRwP9n8BB@nongnu.org,
 AJvYcCXbUp+qbkcbFZF+w2HqDmraSizgHOMazx6dc+2L8lT3WkE7VIoD0/EKkf1Mb2qKcjE3KrD41DORNuo=@nongnu.org
X-Gm-Message-State: AOJu0YxUtvJ0L23Zynk+MJY3/a275FM4+2LwNYnpRiKVaAxFHNSucr2u
 DjzgYE0Ag4fxSenn1+6cW8pgBc/xYqpra5QBUJ+mgHHua1xWCHZNq7ozJmSNmq4xi6TqpItKw2M
 SL/YyaMuebxHfYuit7avm8zsXQBw=
X-Gm-Gg: ASbGncv6GEd+Fw0M0E1U5JjayRqpStdFif/qziLf/Eh+8Gbp4HymLJN0lje4tZzkGzM
 RbAEz491T5UK4N+Fq45wCw7JvnQ42Rm/4
X-Google-Smtp-Source: AGHT+IEYtWd9tHi07/K6xaTJ3HHlBIRFfb7Zy9Kst9bzpNFL7d5X2YgJB5OSCwN9BiqYZtGU5zsZundH0QQ3opfXLus=
X-Received: by 2002:a5d:5f96:0:b0:382:4f4e:1cd4 with SMTP id
 ffacd0b85a97d-385c6edd2damr1914599f8f.42.1732713771926; Wed, 27 Nov 2024
 05:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20241126171235.362916-1-npiggin@gmail.com>
 <e18a1d0a-7970-4985-80d7-99d0801d22b0@tls.msk.ru>
In-Reply-To: <e18a1d0a-7970-4985-80d7-99d0801d22b0@tls.msk.ru>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Wed, 27 Nov 2024 18:52:39 +0530
Message-ID: <CAEuJdmoqatx0Crrd7hBFmO7sALuK2Cq8koUYwiGvMSZHZUmY7g@mail.gmail.com>
Subject: Re: [PULL 0/6] ppc-for-9.2-2 queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000df8c090627e4dc6e"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000df8c090627e4dc6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 27 Nov, 2024, 3:14=E2=80=AFpm Michael Tokarev, <mjt@tls.msk.ru> wro=
te:

> 26.11.2024 20:12, Nicholas Piggin:
>
> > * Assorted small ppc fixes
> >
> > ----------------------------------------------------------------
> > BALATON Zoltan (1):
> >        hw/ppc/pegasos2: Fix IRQ routing from pci.0
> >
> > Glenn Miles (1):
> >        target/ppc: Fix THREAD_SIBLING_FOREACH for multi-socket
> >
> > Harsh Prateek Bora (1):
> >        ppc/spapr: fix drc index mismatch for partially enabled vcpus
> >


I think at least this ^^^ can be picked for stable.
Nick may confirm about other patches.

Thanks
Harsh


> > Nicholas Piggin (3):
> >        target/ppc: Fix non-maskable interrupt while halted
> >        ppc/pnv: Fix direct controls quiesce
> >        ppc/pnv: Add xscom- prefix to pervasive-control region name
> anything here worth to pick for qemu-stable, or is
> all this "small enough" for this?
>
> Thanks,
>
> /mjt
>
>

--000000000000df8c090627e4dc6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Michael,<br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, 27 Nov, 2024, 3:14=E2=80=AFpm Micha=
el Tokarev, &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">26.11.2024 20:12, Nicholas Pig=
gin:<br>
<br>
&gt; * Assorted small ppc fixes<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; BALATON Zoltan (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/ppc/pegasos2: Fix IRQ routing from pci.0=
<br>
&gt; <br>
&gt; Glenn Miles (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/ppc: Fix THREAD_SIBLING_FOREACH for =
multi-socket<br>
&gt; <br>
&gt; Harsh Prateek Bora (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc/spapr: fix drc index mismatch for parti=
ally enabled vcpus<br>
&gt;</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I think at least this ^^^ can be picked for stable.</div><div dir=3D"auto">=
Nick may confirm about other patches.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Thanks=C2=A0</div><div dir=3D"auto">Harsh</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"> <br>
&gt; Nicholas Piggin (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/ppc: Fix non-maskable interrupt whil=
e halted<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc/pnv: Fix direct controls quiesce<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc/pnv: Add xscom- prefix to pervasive-con=
trol region name<br>
anything here worth to pick for qemu-stable, or is<br>
all this &quot;small enough&quot; for this?<br>
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div></div></div>

--000000000000df8c090627e4dc6e--

