Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFF0C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6se8-0004KO-Em; Wed, 16 Sep 2026 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6se5-0004K0-H7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6se3-0007N4-O7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789576682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVvcgQyh77ZcKMO1+ziKp0e1G90xIx/hzSr5MRdK/FU=;
 b=MohMFicsjb/ZOU3i0oMc8AE93gyxnFMDMR/o6CmX9ehARscHFBrwCqz4vtbxzHiInves2O
 Ed6uH33O4bUUiYvGbnxwuFm3ALVWViRcSQO7ciOvtKLWUaOXf1WaWvLwwL4Kym9pnrhvc6
 ua91sXQfOrOOt6o/uPDE/Y6gEVVjNOk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-6FoLv4cqMsqX23G7slBccw-1; Wed, 16 Sep 2026 12:38:00 -0400
X-MC-Unique: 6FoLv4cqMsqX23G7slBccw-1
X-Mimecast-MFC-AGG-ID: 6FoLv4cqMsqX23G7slBccw_1789576679
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48706ee8fbaso1474596f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789576679; cv=none;
 d=google.com; s=arc-20260327;
 b=OZMVL4rpAEeMXkJ/HeOJ7hdsloULKOpzztDtKjfZlhtxOcLuMRnY3HWrjEPw4cYXeZ
 x4449vo16FxZmWgLILxFKx03hbYjS0or/VEAi+xl2D5CIKmT4gLqcbicHuDQI98IxFg0
 LRzAaHTPZUaaQaVu/UNYCLyPHLw876ZFmIQBIy/CklycAvTiSs7rllo1xu4n30XA1+u8
 EXTgZks6HqTE8SVDDnlcxP1UrfYbVRYaoeSor4KC3eic2q9nkQorjYn5lI1kjz6YA9RM
 2BHWvUXc7gJkB4vTpx2chmtnfgsCzofOZ6NgmMa9ta7+ClY7Mqucj93ManhK2FQysVBP
 vN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sVvcgQyh77ZcKMO1+ziKp0e1G90xIx/hzSr5MRdK/FU=;
 fh=VS9952aFriFZSc9oEcQMKTkpMtXhEpA9rsMre9zmkRI=;
 b=bygybxVukDHF71m+k/Eboipi6ytPwzpKwQpD0OPu9WvmaXyEoetmpy5coo74FVctWB
 ZHK5jG0os9iXMDXBvvj7evjdBize+08tMp2PNKCOSQ27CyVPdqFlbpylBHQD6jQnCzhT
 zAEjjU84pmQ2tzw7B1tjc+VKql+EYUXMaq9dW4MBXnhMGbJwANclawYf/4vZOS+62bJj
 iIFm9d7qG/PIZaMCEM+QUuNMAZcj4goBYQ32eSmvznnFy+Y+DuVnX2xdOKrYMx28M4qq
 2oMS23UoMweSrNA2X5xXTYQKn7/uJOj+eP6V4OV0WQhe9GS0iobPV5HNEIs0p4Hca/C9
 47ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789576679; x=1790181479; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sVvcgQyh77ZcKMO1+ziKp0e1G90xIx/hzSr5MRdK/FU=;
 b=jK6NYmdfZfW2l3m9raGhT1FS8DdYof6Rqo5+J3dmA4Xr7LLfmnCo2enhZq6s/cUN67
 Rnmqzghgg9wDzzjFOlG3STBdD8UJtRbt709rZSSFR+sipB8QVmTJflxSgLsJTfBoFXJk
 wQ218J7D6GkWkGTMw2rCm35PoWqDr4jpUPvxVNnJsJ5UHLr/MDMZODHmYUl3S5SBFUVF
 Tr6w0JrPBXcJQJfaLqaxufVFfIzFAjvYiyUa7Ge0I5PLB2EXAshS2NOy9tPe+zOdyUbc
 KqkBjR2XI3UNtFfjBVbBet+p35jtt/PiV3aWH5UR7Uh5/kwMRFpxws6uOITnWajRoJHs
 r3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576679; x=1790181479;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sVvcgQyh77ZcKMO1+ziKp0e1G90xIx/hzSr5MRdK/FU=;
 b=BgPdcBcLr/1Yk91PV3OgykBSpo1KWzqUpPOWoSQbxOpjsICbOIbC812oIW3kFbFri3
 hSZDWRLABwp9Skfd0ykqRgmg0z3SPa3gu+s9cskdogJlhc0+QiQsGCcSfIVKaq+I8oi4
 EoEjXfvn7OqYm4Xj1JHAEF/T89CBi1pjmZe0a/1lHsb6fCOA36YafRs6vWZ/aOAZjaCa
 4VHMZXjWqoqa5N9c/2txl4nr3dEdCsdkugK5kg3pwURlM62ulhjRVljZyVh05/kLswQ2
 KBho21+x7JPQi7B6gp/c7DRxezsXaxoqrsSqIFIdzWvGeHcWShr07ZVb5C9pVmUrERzl
 doAg==
X-Gm-Message-State: AFuF++k2klZR9EnULumrJN9zwTnKn22FQHIxs6C5zgh+6LSqTxGmRWWu
 U5eAOElS8CCogWXkoQic/NWMPj7Xa3l1F6Y0WWNptyDDmPO3kXhksIDqNz9LoxVwfQeum4gWqt5
 6a3zJpLwF0IrVANyc+XaAc4EBcb8cLXxftkMulZPz1Jpe7t9pgJXouXdhRQDGUhZYScYsotjyEY
 tmrpBTBdFMTAwCwZt7h1k0hwHw2tt8R1I=
X-Gm-Gg: AYBFou3pQTgNFA9Vu9A5t3WFX4ZocHRs3mXVR5awVPxV/etkHgzMIOo59UAk5x5jBem
 4B/++EVL1NpgHc3hvA6ipv+vpz1CZMeFDAZH206t3mS4NS3A0ZdS8jb8KXCSpsVzDk//NkKFcXv
 COu6rRx1CEYZASK/FCxDWVwArvU66EKYKIp3AoSgLG+t3Jrr3a4r7A8TkrK0JE35I7OMQGB+093
 /LHelhiCR8qHYY4sU8KdkE2P1VAiEWX40K6LP0tD1F2Czbf+29gnu5aEKwiWA==
X-Received: by 2002:a05:6000:1861:b0:487:40d:af29 with SMTP id
 ffacd0b85a97d-4870d269967mr4447194f8f.36.1789576679456; 
 Wed, 16 Sep 2026 09:37:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1861:b0:487:40d:af29 with SMTP id
 ffacd0b85a97d-4870d269967mr4447153f8f.36.1789576678944; Wed, 16 Sep 2026
 09:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260916132120.860910-1-pbonzini@redhat.com>
 <1a8ee1d3-88a5-4827-a306-43df82caea87@gmx.de>
In-Reply-To: <1a8ee1d3-88a5-4827-a306-43df82caea87@gmx.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Sep 2026 18:37:45 +0200
X-Gm-Features: AcwNN1WfmXHkwHzXIb5IRnmd8WqKRbyrURGYgqwscaDfKyAew0SfAQiwBprodkA
Message-ID: <CABgObfZqj_drVQQu8JPqxb6O1jfeAq-UAsQiWGq86oA-kTxzzA@mail.gmail.com>
Subject: Re: [PATCH 0/8] ncr710: cleanups and fixes for request lifetime
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Keith Monahan <keith@techtravels.org>
Content-Type: multipart/alternative; boundary="0000000000003f4ab4065b9c4a7f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

--0000000000003f4ab4065b9c4a7f
Content-Type: text/plain; charset="UTF-8"

Il mer 16 set 2026, 16:49 Helge Deller <deller@gmx.de> ha scritto:

> Hello Paolo,
>
> On 9/16/26 15:21, Paolo Bonzini wrote:
> > The ncr710 HBA code is similar to lsi53c895a, but it can be simplified
> > due to lack of support for tagged command queuing.  Perform a bunch
> > of cleanups and copy over the fixes from commits up to
> > d459131ff590c517bc89fa5867d4878b5eacbc30.
>
> I haven't tested your patches yet, but the current version of the ncr710
> driver hangs on HP-UX and *BSD guests (works only with Linux guests).
> I assume your cleanups will not fix this?
>

It's not intended to have any functional changes, except for fixing crashes.

In addition, Keith Monahan posted two weeks ago a patch which replaces
> this driver by a new version which is based on top of the lsi53c895a
> code base and which I tested successfully with Linux, HP-UX and *BSD
> guests.
> There were some discussions about it here:
> https://patchew.org/QEMU/20260701213359.1855870-1-keith@techtravels.org/
>
> Isn't there a chance to use his driver instead of trying to clean up
> the existing driver?
>

I didn't know about it and I wrote these patches long ago (right after
fixing the lsi53c895a reference counting).

Weirdly enough it removes more lines than it adds, so I guess it's fine??
:) It also includes some of the same fixes, since it copies the fixed code
from lsi53c895a. If his work is accepted, I can rebase on top of it and see
if there are any cleanups that survive.

Paolo


Helge
>
> >
> > Paolo Bonzini (8):
> >    ncr710: simplify ncr710_clear_pending_irq
> >    ncr710: reuse ncr710_clear_pending_irq in ncr10_do_command
> >    ncr710: remove weird p->req == NULL case
> >    ncr710: clean up ncr710_transfer_data
> >    ncr710: do not load s->current in advance
> >    ncr710: remove dead message in actions
> >    ncr710: copy reference counting fixes over from lsi53c895a
> >    ncr710: unify two conditionals
> >
> >   hw/scsi/ncr53c710.h |   3 +-
> >   hw/scsi/ncr53c710.c | 167 ++++++++++++++++++++------------------------
> >   2 files changed, 76 insertions(+), 94 deletions(-)
> >
>
>

--0000000000003f4ab4065b9c4a7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 16 set 2026, 16:49 Helge =
Deller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx.de</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello Paolo,<=
br>
<br>
On 9/16/26 15:21, Paolo Bonzini wrote:<br>
&gt; The ncr710 HBA code is similar to lsi53c895a, but it can be simplified=
<br>
&gt; due to lack of support for tagged command queuing.=C2=A0 Perform a bun=
ch<br>
&gt; of cleanups and copy over the fixes from commits up to<br>
&gt; d459131ff590c517bc89fa5867d4878b5eacbc30.<br>
<br>
I haven&#39;t tested your patches yet, but the current version of the ncr71=
0<br>
driver hangs on HP-UX and *BSD guests (works only with Linux guests).<br>
I assume your cleanups will not fix this?<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s not intended to have any =
functional changes, except for fixing crashes.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
In addition, Keith Monahan posted two weeks ago a patch which replaces<br>
this driver by a new version which is based on top of the lsi53c895a<br>
code base and which I tested successfully with Linux, HP-UX and *BSD guests=
.<br>
There were some discussions about it here:<br>
<a href=3D"https://patchew.org/QEMU/20260701213359.1855870-1-keith@techtrav=
els.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patchew.o=
rg/QEMU/20260701213359.1855870-1-keith@techtravels.org/</a><br>
<br>
Isn&#39;t there a chance to use his driver instead of trying to clean up<br=
>
the existing driver?<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">I didn&#39;t know about it and I wrote these patches lo=
ng ago (right after fixing the lsi53c895a reference counting).</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Weirdly enough it removes more lines=
 than it adds, so I guess it&#39;s fine?? :) It also includes some of the s=
ame fixes, since it copies the fixed code from lsi53c895a. If his work is a=
ccepted, I can rebase on top of it and see if there are any cleanups that s=
urvive.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
Helge<br>
<br>
&gt; <br>
&gt; Paolo Bonzini (8):<br>
&gt;=C2=A0 =C2=A0 ncr710: simplify ncr710_clear_pending_irq<br>
&gt;=C2=A0 =C2=A0 ncr710: reuse ncr710_clear_pending_irq in ncr10_do_comman=
d<br>
&gt;=C2=A0 =C2=A0 ncr710: remove weird p-&gt;req =3D=3D NULL case<br>
&gt;=C2=A0 =C2=A0 ncr710: clean up ncr710_transfer_data<br>
&gt;=C2=A0 =C2=A0 ncr710: do not load s-&gt;current in advance<br>
&gt;=C2=A0 =C2=A0 ncr710: remove dead message in actions<br>
&gt;=C2=A0 =C2=A0 ncr710: copy reference counting fixes over from lsi53c895=
a<br>
&gt;=C2=A0 =C2=A0 ncr710: unify two conditionals<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/scsi/ncr53c710.h |=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 =C2=A0hw/scsi/ncr53c710.c | 167 ++++++++++++++++++++------------=
------------<br>
&gt;=C2=A0 =C2=A02 files changed, 76 insertions(+), 94 deletions(-)<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000003f4ab4065b9c4a7f--


