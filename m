Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73893CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiSG-00053U-RC; Wed, 03 Sep 2025 04:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1utiQy-0002nc-4s
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1utiQv-0006jF-RN
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756886491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ldld9n2gWWwiOv5VN6eg5bBSoFDexYlgVkL2KSABJKo=;
 b=UFcVrTNuMqC851D0CuZiA9wCEd5hPBtB4mpjHyLUcirIYrbWFR7IZKqwEzalHTIrflhE3r
 cAa7gmNmSic5I3rwQdwuLx+RiSzZa8lb6443mMjSiWxqb//pp5UyZM74+DQWKKKHf4PN8B
 fytLnGXzdFTAzGL9g6Az++WR3oTWn7A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-laIygS8zMDe0Fx4poIqjyg-1; Wed, 03 Sep 2025 04:01:29 -0400
X-MC-Unique: laIygS8zMDe0Fx4poIqjyg-1
X-Mimecast-MFC-AGG-ID: laIygS8zMDe0Fx4poIqjyg_1756886489
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70dfcc589d8so61578456d6.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 01:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886489; x=1757491289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ldld9n2gWWwiOv5VN6eg5bBSoFDexYlgVkL2KSABJKo=;
 b=wk/X9iqsBJApjpf7WCzYo2mDH63VcnC5BAZZe9Ycbum/q+wb+OSJM+0U1s0zq9+tif
 aVfkXc1rui+MRemLCSH7/q7cJ8weRhs+I2FpZOVchJPv8wVmPHx+Od+t4f6g73fhOVx8
 WqzXZTK6JSeEJELDQsUlw6k5NHJciwB42OC2Tt8Hu6ylmmma5KLexhEouwIVwoi6bBZP
 ah0mM3dDVa+XpLYSlrO7GiAxDHyHI4TVlY78csGIZVbYqe3vPHsjpOsZyOOtHyRXJ6V0
 VzSC1K9swlcRiiiqgaBczwvkyQnvb2XZ7aRgBopGuDAYXdbqK6twpdoarQCezQHrW2lM
 k5Cw==
X-Gm-Message-State: AOJu0Yz5hLP9nplqrL4rZ3L3bB9tq5LwNjRyOplrDlOBkJZQ5rof28ho
 /Xn/OCrqXSTSncFpY3wfyFMYlYxxEouKhcG2hShtZmJ3eq41VSIsDE7YtxlRF7ZG1bPZOxwgJei
 VnT4WSrJ31kbvlHIdlBOfbySCBD/TZSGbmo3dhVpDoWLqg0Wk/pFPn83tUzCEPv5IokK7acjINn
 a4Q7axtuuq1NhhOTXq8GOwJHZ5IbLagP8=
X-Gm-Gg: ASbGnctJRei9UON4bR1XS8PW0E7g77pxRgDMS83+LZkEYBTwzu1LwArMgBMkpj0clW0
 vPwX7/3qTRl7qBYB9zMrwhLqsrIocfOpnE6z85LleIxTguzXU3XGQxJ+SrCR6WHO9X0p60nz4aI
 2x7yZT4nuKIYtM4ti1VWuwWVY=
X-Received: by 2002:a05:6214:2249:b0:717:ccef:6ee8 with SMTP id
 6a1803df08f44-717ccfeb40bmr101683436d6.37.1756886488596; 
 Wed, 03 Sep 2025 01:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpHngPJG7+iqx4K1UV6jGW4QN5x3yfPuBbnj/XyTVwYfYLvKfHKocn2qKrmUYTedwIzumcf2dsk79ILQMUFf0=
X-Received: by 2002:a05:6214:2249:b0:717:ccef:6ee8 with SMTP id
 6a1803df08f44-717ccfeb40bmr101682916d6.37.1756886487984; Wed, 03 Sep 2025
 01:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250825143155.160913-1-kkostiuk@redhat.com>
 <5d2f2ea7-07ee-438c-86d6-aff7a3ae7fff@tls.msk.ru>
In-Reply-To: <5d2f2ea7-07ee-438c-86d6-aff7a3ae7fff@tls.msk.ru>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 3 Sep 2025 11:01:16 +0300
X-Gm-Features: Ac12FXzZ_AaiBbLhPsNh6Dwj3qs2e_COYJ31h7znRc5vu6ZuVO_3BGkzf4xtsLw
Message-ID: <CAPMcbCpfSPPUOxFU9pw2UZFLDzeK0D71Lh5Gvy+sE-UtZPhuEw@mail.gmail.com>
Subject: Re: [PATCH] qga/installer: Remove QGA VSS if QGA installation failed
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000007028a063de103ef"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000007028a063de103ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Please also pick
https://lore.kernel.org/qemu-devel/20250825135311.138330-1-kkostiuk@redhat.=
com/
for stable as it provides more detailed error logs.

Best Regards,
Kostiantyn Kostiuk.


On Wed, Sep 3, 2025 at 10:09=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 25.08.2025 17:31, Kostiantyn Kostiuk wrote:
> > When QGA Installer failed to install QGA service but install
> > QGA VSS provider, provider should be removed before installer
> > exits. Otherwise QGA VSS will has broken infomation and
> > prevent QGA installation in next run.
>
> I'm picking this up for qemu-stable (10.0 & 10.1).
> Please let me know if I shouldn't.
>
> Thanks,
>
> /mjt
>
>

--00000000000007028a063de103ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Michael,</div><div><br></div><div>Please also=
 pick=C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/20250825135311.138=
330-1-kkostiuk@redhat.com/">https://lore.kernel.org/qemu-devel/202508251353=
11.138330-1-kkostiuk@redhat.com/</a> for stable as it provides=C2=A0more de=
tailed error logs.</div><div><br></div><div><div dir=3D"ltr" class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best R=
egards,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Sep 3, 2025 at 10:09=E2=80=AFAM Michael Tokarev &lt;<a =
href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 25.08.2025 17:31, Kostianty=
n Kostiuk wrote:<br>
&gt; When QGA Installer failed to install QGA service but install<br>
&gt; QGA VSS provider, provider should be removed before installer<br>
&gt; exits. Otherwise QGA VSS will has broken infomation and<br>
&gt; prevent QGA installation in next run.<br>
<br>
I&#39;m picking this up for qemu-stable (10.0 &amp; 10.1).<br>
Please let me know if I shouldn&#39;t.<br>
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div>

--00000000000007028a063de103ef--


