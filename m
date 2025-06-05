Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2208C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uND40-0000du-5D; Thu, 05 Jun 2025 12:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uND3b-0000Ot-G7
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uND3Z-0001t1-CK
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749139382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAL9CeHnD9ON4SeB/yz42X2+sIOKlPXa9PxJOVTL8x8=;
 b=BA1jpSHlRybZA8sEy8bFyArPAVjuMjzKhswyB2srsjEW/lRDgfb7Av0rQrMORFu66t5FLw
 1p+LLriLa3eS5OWAZDZCwUUef3eUE62Cg1J8qC5ZA7G9Xl4D40jaFu88j/J2A+ltOuiYxq
 UfFomSMAjEt3dVM5I2UStSyv5a/jVzo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-sh5IuvB9NK-iuhYdMI_p3Q-1; Thu, 05 Jun 2025 12:02:58 -0400
X-MC-Unique: sh5IuvB9NK-iuhYdMI_p3Q-1
X-Mimecast-MFC-AGG-ID: sh5IuvB9NK-iuhYdMI_p3Q_1749139378
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b2eea1c2e97so828846a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749139377; x=1749744177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAL9CeHnD9ON4SeB/yz42X2+sIOKlPXa9PxJOVTL8x8=;
 b=YCOZczfNXTAavCkokT9AH0xk+NYtYpiK1G1LkyPcGyu5CwrBF3M24i6Gb8lJHSxcA0
 gmSZnEb8+yImbtISvcUZ616q9u6Hbl+0VJQlfyDOe3Kr7AI0sp/EmXqmFenEkDnKoHBn
 ks2o0eu8HCnoqZgAbMmOgmqCse4tohn1Pb9YNHMhrJcpjf5khC0BT1ATRXAU8rs7lom8
 5LbzBn7MMAubcEZ2GtnJbR+k7DEtSNGtiM2NI5nBX6jeMynmhhPvaI8Cm4RJ2IGFuOj4
 o4aSVixkKN3aMmMJhRRsLsrXcFPQuF5IRZ2mx9+S0eowgYcocAURrI10EvFb7Ejgt6PF
 850Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKB/JR1k7X2ISIT/fROBha7h9SmeZfXCZQrZSeV1FPSYFBbY2WvG1pTX6GegX3vCA4HKw+t/9y4Gbp@nongnu.org
X-Gm-Message-State: AOJu0Yyg+YrB76xwC+Fp05bLvUbrMO/eLFNt5QWeufreYPT2QMFPRUCv
 lN8OAxvgdqPvqjiQ3C5o8guEmR/9K5HfhF3TboRl657/kAt1Dg/e0IIzoSKFTBhoH+bZk7q3DA4
 qk8j5FsVH47RikILUdKB9QVSKaRBtAa91RoCux1OVCvvWdgIeFQnJVo3R1sJ04zXTuJqDJ6ciC4
 bbJQZ6KMz6UuMCGVO7Eni5AHACGn242mmTygcRIBE=
X-Gm-Gg: ASbGncu1B8RLYNbfvHVjaCU/f1gssZi7OD7p3SViLdoITZRe873txuawMHtMZIfMRQ9
 GZYNgwIDZQhhW1BgN3E9Bhk81Hlecp8jL7lIG1NXlBK0sWz2Y5wj3hCWCIpx48fQ8LtnjMC/uUt
 YdWQbcL3BYMsvujCtS9lhfCJoo
X-Received: by 2002:a17:90b:1651:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-3134769d8dbmr273552a91.32.1749139376413; 
 Thu, 05 Jun 2025 09:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDoeTK+dxpyadoD7fXjQlfiu8i4rfQPdpOvJjajHgUzy5wd/WM4CJGk4ZsifSEoXZhnwdxhfz5tQeOHr9vDX8=
X-Received: by 2002:a17:90b:1651:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-3134769d8dbmr273498a91.32.1749139375911; Thu, 05 Jun 2025
 09:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250604200354.459501-1-jsnow@redhat.com>
 <20250604200354.459501-5-jsnow@redhat.com>
 <87frgen1dj.fsf@pond.sub.org> <aEFXGXhqHkIioTOH@redhat.com>
In-Reply-To: <aEFXGXhqHkIioTOH@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 5 Jun 2025 12:02:43 -0400
X-Gm-Features: AX0GCFunf-ycim3x14HRoaTTYenQvpSF-eOQ0F0X45wXGn1WZ0eXO6-J5XVtxts
Message-ID: <CAFn=p-YN-38zNXGF3PXQ3wN6Y1c0-hinJHXP2LrGxqGrpsHhbw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] python: add qapi static analysis tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Cleber Rosa <crosa@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002a18940636d53f67"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000002a18940636d53f67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 4:36=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Thu, Jun 05, 2025 at 08:33:44AM +0200, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> >
> > [...]
> >
> > > diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.s=
h
> > > new file mode 100755
> > > index 00000000000..2211b6c7f41
> > > --- /dev/null
> > > +++ b/python/tests/qapi-flake8.sh
> > > @@ -0,0 +1,6 @@
> > > +#!/bin/sh -e
> > > +# SPDX-License-Identifier: LGPL-2.1-or-later
> >
> > Why not GPL-2.0-or-later?
>
> Indeed, checkpatch.pl should be warning about this choice, and requesting
> that it be explained in the commit message.
>

Ah. Well, it's what I have defaulted to for the standalone QMP library, but
I realize now this code isn't anything I will be bothering to sync over to
that library, so GPL is fine. I will adjust it for my pull request.

(And I'll fix the squashed commit message I forgot about! Oops!)

--0000000000002a18940636d53f67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 5, =
2025 at 4:36=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Thu, Jun 05, 2025 at 08:33:44AM +0200=
, Markus Armbruster wrote:<br>
&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">js=
now@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; [...]<br>
&gt; <br>
&gt; &gt; diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flak=
e8.sh<br>
&gt; &gt; new file mode 100755<br>
&gt; &gt; index 00000000000..2211b6c7f41<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/python/tests/qapi-flake8.sh<br>
&gt; &gt; @@ -0,0 +1,6 @@<br>
&gt; &gt; +#!/bin/sh -e<br>
&gt; &gt; +# SPDX-License-Identifier: LGPL-2.1-or-later<br>
&gt; <br>
&gt; Why not GPL-2.0-or-later?<br>
<br>
Indeed, <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_blan=
k">checkpatch.pl</a> should be warning about this choice, and requesting<br=
>
that it be explained in the commit message.<br></blockquote><div><br></div>=
<div>Ah. Well, it&#39;s what I have defaulted to for the standalone QMP lib=
rary, but I realize now this code isn&#39;t anything I will be bothering to=
 sync over to that library, so GPL is fine. I will adjust it for my pull re=
quest.</div><div><br></div>(And I&#39;ll fix the squashed commit message I =
forgot about! Oops!)</div></div>

--0000000000002a18940636d53f67--


