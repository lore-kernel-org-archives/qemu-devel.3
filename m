Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB39CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zxE-0005tm-OM; Tue, 23 Sep 2025 06:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v0zxC-0005t3-I6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:08:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v0zx3-0001Xs-Kn
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:08:58 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80D943F475
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1758622123;
 bh=099/PqO0/ld4mqz6Qpknk+8TyGUJ6QdDQqoau6D09fw=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=dXKtw4gW3aBFXhgOJs/rsq5ifsUonmse4c37bWDvAasv0ShbZjAjGbGYisJ46A4vo
 W/QEDjoI0Iou6lLece3Qhhp+m6x5oXIHkdvPlo1FiNzF0wWA0ybJQCAC2fHTkhCAly
 c+mZ1iyzpreaXz+N/VAZ1nr4a5effi/g1IA0B8lETh/V0eiqVsgFSX98MZyqsdBbZh
 xUTijz59RrCDD3rioaOKyK+nj+xJYU6gnFsm/Mzh6cHaIBGBIQrWZkDxY/6qL2QeQO
 BL0mNydj7FdrrF9z4VyyHYX1AFVcSkN+ejw1zQAvouiIxDL93OPwzGkxErBy0hsNUM
 eCwnW0VpbCj1A==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6339aa08acfso2231899a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758622122; x=1759226922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=099/PqO0/ld4mqz6Qpknk+8TyGUJ6QdDQqoau6D09fw=;
 b=TRaDjOfojLm8QEYp3Jbl8jd2vUIRpm2WmMWEcuobWu3dlK0zPtUta+H2Nw9SsjfGUK
 /KJJR1wR+vRGeLO2DrjjfzsbJj6jTMzq8+hNj/17t3F4y4wgTSWhQx47wGm+3IMxHopc
 ma4FJTTAdYirVzQayjRacpxLEWB4RSwjZ4mQibiWinTnpoRU97fae/Sxa4QzJ+1nSp9w
 iPalpjpLO1XpZ5od0mO3/DUlkyTJ0ujxhwK6X7N6W0eAo/BvlY4xfwjpsq6JHsp2ehiJ
 cPIFVEqYCpi0pQPR03ENnvsPo8U6TErLGKO1Fx4PA22AYX4fkeJ0LBFvuqSF0JsUr1dQ
 inkQ==
X-Gm-Message-State: AOJu0YyFyG3AXyXlEkw49WevwzjC7wpFaCDCHjKiqPcAnMGOraOlJtEW
 LxC5W7Llbxoto3QjrS5F/7S3sxMy/fSgTE4pGfpnixYjBkgu1Pi1moqIY1BZZr80xUIaSTrW+7v
 iOuFOL1sEO6852lE3+TjxUooKOvh9Qq0+K+H81JV2wfYo/8i7q2jlAkoEUm/89U15vOcb72PoNg
 tKxw9eNTCUp7MX2Wxi+tmASzN6xVTqofeUD7nbeh/+mGzFlDPxDe0FnP8=
X-Gm-Gg: ASbGncudyh1iuKu+KA7LiiQZELAtU1A+TqhDCNjlQTKasJPJTdDUaLv3468rIR//6dc
 /oPY4bwolB7XsubS4rm2kSoRCdrCFsLBDICk6GtH50cgGTpueTeCWXSEAvCODTYKMGxJcn5rRxV
 OBkfMTnRazTkcIA4iF5nwrmwUiZkEdMSig1/nPO5zp1T6IqW3BzKacG1TCA1RavTTBAWX8v0XYh
 a0=
X-Received: by 2002:a05:6402:5204:b0:632:466d:5d08 with SMTP id
 4fb4d7f45d1cf-63467c35438mr1874931a12.10.1758622122274; 
 Tue, 23 Sep 2025 03:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3I9jItMP4fKnSc7EmCMseSCd5rrnVEb70L31XIaI5BG1xk0etmri4yqrZsq6bUgbPXn9SliwNkh2zZfXSL8o=
X-Received: by 2002:a05:6402:5204:b0:632:466d:5d08 with SMTP id
 4fb4d7f45d1cf-63467c35438mr1874917a12.10.1758622121828; Tue, 23 Sep 2025
 03:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
 <20250910115733.21149-1-hector.cao@canonical.com>
 <b2fb1e8c-4b30-4bde-9b16-b9a0cd314b70@redhat.com>
In-Reply-To: <b2fb1e8c-4b30-4bde-9b16-b9a0cd314b70@redhat.com>
From: Hector Cao <hector.cao@canonical.com>
Date: Tue, 23 Sep 2025 12:08:22 +0200
X-Gm-Features: AS18NWDNx91Ccj8kRxX7LVyefqb13jLxPc1T-7xGBS7KzHQmNTIOOMj3dnxSqk8
Message-ID: <CABjvBV6YZvufYXcUeBjY3Av=_VALWy2Dw9o6jGeL2FQTf1CgOA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ddae7a063f751e0c"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_IMAGE_ONLY_32=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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

--000000000000ddae7a063f751e0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Paolo,

Is it still time for me to submit the v2 of this patch ? I would like do
add 2 changes:
- add fixes:xxx line suggested by Daniel
- fix link error for qemu-user build (since it has no access to migration
code)

Best,
Hector

<https://launchpad.net/~hectorcao>

Le mar. 23 sept. 2025, 09:53, Paolo Bonzini <pbonzini@redhat.com> a =C3=A9c=
rit :

> On 9/10/25 13:57, Hector Cao wrote:
> > Hello,
> >
> > Since it is a blocking issue for us, we went further and ended up with =
a
> solution along [1]
> > that allows us to get out of this situation.
> >
> > The idea is to add compatibility properties to restore legacy behaviors
> for machine types
> > with older versions of QEMU (<10.1). 2 compatiblity properties have bee=
n
> added to address
> > respectively the 2 missing features, each one is done in a separate
> patch.
> >
> > We know that 10.1 has been released and it's final, but working on a
> solution towards 11.0
> > would allow everyone to settle on the fix and even consider backporting
> where not yet released
> > like Ubuntu 25.10 for us.
>
> Thanks, I have applied the patch.  It's better to have the fix in 10.1.1.
>
> Sorry for the delay, I was on vacation for one week and working reduced
> hours the next.
>
> Paolo
>
> > It is important to have upstream support going forward in this or any
> other way
> > and therefore reach out with this RFC to ask you to think about it with
> us.
> >
> > [1]
> https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/migration/c=
ompatibility.rst
> >
> > Hector Cao (2):
> >    target/i386: add compatibility property for arch_capabilities
> >    target/i386: add compatibility property for pdcm feature
> >
> >   hw/core/machine.c     |  2 ++
> >   migration/migration.h | 23 +++++++++++++++++++++++
> >   migration/options.c   |  6 ++++++
> >   target/i386/cpu.c     | 17 ++++++++++++++---
> >   target/i386/kvm/kvm.c |  5 ++++-
> >   5 files changed, 49 insertions(+), 4 deletions(-)
> >
>
>

--000000000000ddae7a063f751e0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Thanks Paolo,</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Is it still time for me to submit the v2 of this patch ? I wou=
ld like do add 2 changes:</div><div dir=3D"auto">- add fixes:xxx line sugge=
sted by Daniel</div><div dir=3D"auto">- fix link error for qemu-user build =
(since it has no access to migration code)</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Best,</div><div>Hector</div><div data-smartmail=3D"gmail=
_signature"><div dir=3D"ltr"><div style=3D"text-align:left">
<p style=3D"line-height:100%;margin-bottom:0in"> =20
<a href=3D"https://launchpad.net/~hectorcao" target=3D"_blank"><img width=
=3D"96" height=3D"81" src=3D"https://ci3.googleusercontent.com/mail-sig/AIo=
rK4z5yECcB4DOFqFQjPXjogBAVC5Vv1klgihEnAZXkqybF5lNxe9SeDqtm-9dmSwj3Sbw2kDL58=
U"></a></p>

</div></div></div></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">Le mar. 23 sept. 2025, 09:53, Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>=
&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 9/10/=
25 13:57, Hector Cao wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; Since it is a blocking issue for us, we went further and ended up with=
 a solution along [1]<br>
&gt; that allows us to get out of this situation.<br>
&gt; <br>
&gt; The idea is to add compatibility properties to restore legacy behavior=
s for machine types<br>
&gt; with older versions of QEMU (&lt;10.1). 2 compatiblity properties have=
 been added to address<br>
&gt; respectively the 2 missing features, each one is done in a separate pa=
tch.<br>
&gt; <br>
&gt; We know that 10.1 has been released and it&#39;s final, but working on=
 a solution towards 11.0<br>
&gt; would allow everyone to settle on the fix and even consider backportin=
g where not yet released<br>
&gt; like Ubuntu 25.10 for us.<br>
<br>
Thanks, I have applied the patch.=C2=A0 It&#39;s better to have the fix in =
10.1.1.<br>
<br>
Sorry for the delay, I was on vacation for one week and working reduced <br=
>
hours the next.<br>
<br>
Paolo<br>
<br>
&gt; It is important to have upstream support going forward in this or any =
other way<br>
&gt; and therefore reach out with this RFC to ask you to think about it wit=
h us.<br>
&gt; <br>
&gt; [1] <a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/docs=
/devel/migration/compatibility.rst" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/migr=
ation/compatibility.rst</a><br>
&gt; <br>
&gt; Hector Cao (2):<br>
&gt;=C2=A0 =C2=A0 target/i386: add compatibility property for arch_capabili=
ties<br>
&gt;=C2=A0 =C2=A0 target/i386: add compatibility property for pdcm feature<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/core/machine.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0migration/migration.h | 23 +++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0migration/options.c=C2=A0 =C2=A0|=C2=A0 6 ++++++<br>
&gt;=C2=A0 =C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0| 17 ++++++++++++++--=
-<br>
&gt;=C2=A0 =C2=A0target/i386/kvm/kvm.c |=C2=A0 5 ++++-<br>
&gt;=C2=A0 =C2=A05 files changed, 49 insertions(+), 4 deletions(-)<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000ddae7a063f751e0c--

