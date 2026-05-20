Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23CDCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmk7-00078b-3N; Wed, 20 May 2026 15:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wPmjj-000727-Sq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:37:57 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wPmjh-0006Ix-Jj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:37:47 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a877510541so6246112e87.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779305863; cv=none;
 d=google.com; s=arc-20240605;
 b=ICO9Nnr8VTMczIiR2O7HS2iUE/q/vywsJyAFtlDCkj4ymt0I3zSDIJKjFl4/envuVM
 DgJIxfSXDJcPr2XJA5EELeD6Gc6qPkZmG7v7KVC73EdP2ny0Hsjin/c5A9ETZjiazjdw
 zRduZaQvc/xrTvK8K0080VR86Qz0efCW8KNbMD08+me60aPvd+Hb+416ChdiBI97r/et
 5fzAR53Tqmm38AjjSzr+K7mccQNlwx0PQkvcIuYsjWEos+6eBId87FC9s6r9R2DaiuG8
 mBJezQ9SGyMIzDGhwCMiKoISAPCSZ28XRJAhq0K3Rhxxra4j5cTr+HPtreQu2K4sDcC4
 XtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pR7YPrifZPPRywBGt8eDjeNPQr6b6EZrFjHBZYUFTzI=;
 fh=7d+eDs1Zqko+mFtjv8NQI3f4QimVpmTOMJe4tPdyAlc=;
 b=EH5OskV12Wc1EUZlhcB6k4RLCTzBxucn1vh3UHr764Wfzdu7NchXoxIpspI+JbOA3L
 mmCT3cyaZtqej5f7TPLHQ3e0Giohgv2DGO4eKlffx40+OrjbocHgMpObnWHExseXDWyE
 O0b+BTCqKw1HX6iO38sgCaxdNl4FDS0sFuHi+2mu21z+p2w13bnZBzKfz9Zi+sOXD3rJ
 130fWxzs1C3Nnmr1SpDUTUouggno86JozfFKKU8Mra8pjRzJpk26eP60iPNGX45eFiUY
 KDw9lmiBR+00bdWauSzmOJGigF5fqsPRXvAU9jaDLakBYrgcltBXYlec9f2CSRwWNotr
 cd4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1779305863; x=1779910663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pR7YPrifZPPRywBGt8eDjeNPQr6b6EZrFjHBZYUFTzI=;
 b=Isg5BXs0vJ7xz8F6Iu7VzTmrkk+HGnKBqRFCxgSZr6WKYduiCxVFuUz6yTyshK+VG5
 gvSAjqE92oKb5JqaQyYDq3CMxJV1KsdQmnotI6xFZOQ/sbPbtSpBxpFXoICI3Xye0w9i
 IWnuimYMjxzZNb2xYShTvkKvsUvws/9jD9HMuAUUxkk+W7owdxblBtya50MDnexaUwHL
 plG+2VZR50lgLhQFp6QDkKH4WLXQCiX+h+V8oNZ0/WUiyVR7kKPLVsdBL0JViu2r4inr
 85rCzb1sm/GNsTAgZp6pCAXFhlvBIR/bZaQKznNXHkE2J+u8opK4fct4239UOWpwGghL
 UrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305863; x=1779910663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pR7YPrifZPPRywBGt8eDjeNPQr6b6EZrFjHBZYUFTzI=;
 b=EmvH5LHMeiPkhB4cfM9rISOZNkKwo6UxWjUBMXEbwInG1zS910XW+BBE81SJZgPi5L
 D2KGzRKJdrMv9rSX0LbfvF6QmQY91SPGrB9LAtH7UdzuE+Jk0uPRxd0JzBv0aw6vHk6b
 diEPMMPOiWFiH5jrOFzuYxoGEZnvKPoFwNEkZd42L+jcpwOOw6HAz/D0ClpGN3CLb+E4
 FIpcqMlq2i/015Y/+ZC/WkI09jBk6THPf/Z6YeSyxqB1soqbBDWDyG2uSmEWvXu/XIGQ
 9LcS0ddEdzWx3/Yu5xFk7BeurS37bXs2UhKx2JZNVBTbhRlaUZjHEGxU98dpSeheJhcO
 Y/Ww==
X-Gm-Message-State: AOJu0YzLTQ0dtPZ8Th/UKxhs2TzfR/88wEpJP0cvEearxA+CpOCwr1kg
 VsTdkClLDeyH5kyMpqYpVgLSS4zISejq6yNqREGbc4WAYI4yeSYcoQbu4hqeoum3WuKKPeOCX+V
 XLFPxKu5mLc0D5EY66ryQ+p2XZNsS9F6Zvl/DarsKKg==
X-Gm-Gg: Acq92OGQR2uXuDJmLTDFtK0FbNqbBtzrlPJdBzK5m0MfG5PowC9P8z3nJmNJLFDlBqF
 174mX4qEkZ9IuDW4asTp9rwCeS7tUm50ZtkCNziAf3aOJeYabK2Yet7/ndzSMQBsNMOWtmK4rns
 du1fKVfuXZ1JcuZ1ouusIr063EZxYTC+r5trb0VDD7gwutMAjjXO/Xl6OI0gSP2I/XkhrRX7Uix
 /xboWxmjfXhj3tOdUXUnbiV6WaF0q3+NMWJ7app/RlUihSRvSNYqoH6ZXw/rIBH8rVT9g1cfnwf
 rwMX9DlvCKBrk2pNoCnEzaVxtew1lx8=
X-Received: by 2002:a05:6512:39cb:b0:5a8:d1ef:caad with SMTP id
 2adb3069b0e04-5aa0e733fb7mr7391152e87.4.1779305863314; Wed, 20 May 2026
 12:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com>
 <ag4HBdzJXGdKgy50@x1.local>
In-Reply-To: <ag4HBdzJXGdKgy50@x1.local>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Thu, 21 May 2026 03:37:32 +0800
X-Gm-Features: AVHnY4KU8zWrlxAlBh9tDVNTKixRF5CSHwUEoH9HhnPQGdxzNxzIWyi2IHfheMU
Message-ID: <CAFWXh4y9OO6z-5TDtw6GxnzZ19t+SYRn_YNjFFVj2gdpp3cqsg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email of Yong Huang
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@bitdeer.com>
Content-Type: multipart/alternative; boundary="000000000000ee1073065244ed25"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lf1-x129.google.com
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

--000000000000ee1073065244ed25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, infra.ai.cloud@bitdeer.com works!

Peter Xu <peterx@redhat.com>=E4=BA=8E2026=E5=B9=B45=E6=9C=8821=E6=97=A5 =E5=
=91=A8=E5=9B=9B03:10=E5=86=99=E9=81=93=EF=BC=9A

> Hi, Yong,
>
> On Tue, May 19, 2026 at 04:18:12PM +0800, infra.ai.cloud@bitdeer.com
> wrote:
> > From: Hyman Huang <yong.huang@bitdeer.com>
>
> Just to mention you still have this different address ^^^.
>
> Do you want to stick with infra.ai.cloud@bitdeer.com?  What is the best
> address to reach you?
>
> Thanks,
>
> >
> > I left SmartX two weeks ago. Update my email to stay reachable.
> >
> > Signed-off-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
> > ---
> >  MAINTAINERS | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b75f3222f2..1308ee5a0b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3784,7 +3784,7 @@ F: migration/rdma*
> >  F: scripts/rdma-migration-helper.sh
> >
> >  Migration dirty limit and dirty page rate
> > -M: Hyman Huang <yong.huang@smartx.com>
> > +M: Hyman Huang <infra.ai.cloud@biitdeer.com>
> >  S: Maintained
> >  F: system/dirtylimit.c
> >  F: include/system/dirtylimit.h
> > @@ -3794,7 +3794,7 @@ F: include/system/dirtyrate.h
> >  F: docs/devel/migration/dirty-limit.rst
> >
> >  Detached LUKS header
> > -M: Hyman Huang <yong.huang@smartx.com>
> > +M: Hyman Huang <infra.ai.cloud@biitdeer.com>
> >  S: Maintained
> >  F: tests/qemu-iotests/tests/luks-detached-header
> >  F: docs/devel/luks-detached-header.rst
> > --
> > 2.43.0
> >
>
> --
> Peter Xu
>
>

--000000000000ee1073065244ed25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, <a href=3D"mailto:infra.ai.cloud@bitdeer.com">infra.=
ai.cloud@bitdeer.com</a> works!</div><div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Xu &lt;<a h=
ref=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&gt;=E4=BA=8E2026=E5=
=B9=B45=E6=9C=8821=E6=97=A5 =E5=91=A8=E5=9B=9B03:10=E5=86=99=E9=81=93=EF=BC=
=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Hi, Yong,<br>
<br>
On Tue, May 19, 2026 at 04:18:12PM +0800, <a href=3D"mailto:infra.ai.cloud@=
bitdeer.com" target=3D"_blank">infra.ai.cloud@bitdeer.com</a> wrote:<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@bitdeer.com" target=
=3D"_blank">yong.huang@bitdeer.com</a>&gt;<br>
<br>
Just to mention you still have this different address ^^^.<br>
<br>
Do you want to stick with <a href=3D"mailto:infra.ai.cloud@bitdeer.com" tar=
get=3D"_blank">infra.ai.cloud@bitdeer.com</a>?=C2=A0 What is the best<br>
address to reach you?<br>
<br>
Thanks,<br>
<br>
&gt; <br>
&gt; I left SmartX two weeks ago. Update my email to stay reachable.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:infra.ai.cloud@bitdee=
r.com" target=3D"_blank">infra.ai.cloud@bitdeer.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index b75f3222f2..1308ee5a0b 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -3784,7 +3784,7 @@ F: migration/rdma*<br>
&gt;=C2=A0 F: scripts/rdma-migration-helper.sh<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Migration dirty limit and dirty page rate<br>
&gt; -M: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D=
"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; +M: Hyman Huang &lt;<a href=3D"mailto:infra.ai.cloud@biitdeer.com" tar=
get=3D"_blank">infra.ai.cloud@biitdeer.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: system/dirtylimit.c<br>
&gt;=C2=A0 F: include/system/dirtylimit.h<br>
&gt; @@ -3794,7 +3794,7 @@ F: include/system/dirtyrate.h<br>
&gt;=C2=A0 F: docs/devel/migration/dirty-limit.rst<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Detached LUKS header<br>
&gt; -M: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D=
"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; +M: Hyman Huang &lt;<a href=3D"mailto:infra.ai.cloud@biitdeer.com" tar=
get=3D"_blank">infra.ai.cloud@biitdeer.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: tests/qemu-iotests/tests/luks-detached-header<br>
&gt;=C2=A0 F: docs/devel/luks-detached-header.rst<br>
&gt; -- <br>
&gt; 2.43.0<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div></div>

--000000000000ee1073065244ed25--

