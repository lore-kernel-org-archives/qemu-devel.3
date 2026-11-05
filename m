Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89B606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=noycc0Qb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvbP-0005L4-Gv; Thu, 05 Nov 2026 06:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOvbC-0005Gj-5J
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:25:42 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOvbA-0003uu-A2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:25:41 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b12b1ee403so12854937b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 03:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793877938; cv=none;
 d=google.com; s=arc-20260327;
 b=fk0uXM4eA2k1eYh7vwIcOXHlb3xPgaqSRwLPrn4PzFsWI2/b1c50mkW9eA+H45N6WL
 b2OAWzJam9+wpwc2sld5FvO7cRYtLMt9LeCnzXhRkTErK1qFenol9lg3LsGc7235LXva
 TS4C2um6IPS97bmviww/BQp3tNGMHpHJcFHrkNeC9CofcbqJF9YbaQTXSuqVxWZH9a8M
 /28vjcUcTpqcHZgS4iNe03lKkyO/UbHuuwk6FvjaRQBbTVF0AZxvsWfzN0nsv0gFBWTY
 nBQWP7kXQs3/piXEoRp/XgaB0hotLqRijeDexEqHtSeiCFJuMJSDUNopwX5bYK5/P1EI
 3yNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l43J2+cGBr/gpc6Ss7LKu2tILJbeySpsDjKKtgQVKZY=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=llcTGRdUh1EiRqjjS7b2ePH2XcLAjFMI/iZ/sSnXl6Q29+6UCb3dKLsnhIYPGUezAA
 lNYLCpIldWCnRIUm9EIn0J3XJI7pmObvBDyaZoLigg6IM4CdSWQnAY/bzaPm80fdxgqR
 UtA+rQM6evss+NB/IBP+uPh7OVXgDJQBG/MCunO2bkuXahWIWqxokoWl5aDwFDKi9974
 +JC9Oo2aG8fk6lIytk4xxvyRft2fhRK6RlkJxvcO8amHCycANtx9nwSUqw4Awga8o9yS
 vm0ouWn9coczeaKijwZ9g12ycs7Al67XZUQKqenlRy1utr3JxqQF2CMGCOL441GZ83hZ
 0nyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793877938; x=1794482738; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=l43J2+cGBr/gpc6Ss7LKu2tILJbeySpsDjKKtgQVKZY=;
 b=noycc0QbBmRP3glyoYy9YJJ0KbnJx5pzZ6qbkByekXj9dql/9TX4/t2N/kLpfhQQaU
 NYEytcxN92P1qfNtoA8LkxLd7XSZj4o8hqU84fOxl1aTmWV7nYWOMLYug5dlpL4XVbfi
 Uq6wIt1nk7LlVHdcvlrrwSWYqgyHMsgK7+qJvipxNtL3Qekw9k7t24T/14be9h2nyquG
 7w/o66kTBFKC55ibpd3dhYrSjfFFq1v1U7+4rfc2KXNBjY3pDuNMdKSKtldSrcKCK0eO
 8Om/bjzTdODF6Msz+ETqqxMOAMyQ3ls2DqAjZmGnJxg1zt+QoHF34usKr8ZK4vWbopnC
 Hgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793877938; x=1794482738;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l43J2+cGBr/gpc6Ss7LKu2tILJbeySpsDjKKtgQVKZY=;
 b=VSYYmbMMZKNFf+whp2o7LYe9o1kna1DskMCbj7lZnrrdJk/G+3dFHqXKzloNLcbAiR
 cnMmJFmieE51sc3713lS9gkBsesXM34xi5jdXF8gqj9mN4230PLxhQXqnGjajq6kgXL8
 IY81SeQN/hNbdaY+uEvbJ/lqLC7/CZkVRiMLgH600jqL4tQhuvR3sT4t0FyT7H9Wzsms
 FLUULesKR/ZepQjRWNhaK1qrLtXhtZmbKTg4mieYE8j00RxDA20Hw+Pz31RIi4jG57HS
 Z5MeeriT01o7Tn0MOE7LCOSx3XTxlrpgCmq7XohhErtv83UdxC6PMGH7Y+0iRZWZJCIo
 MCdw==
X-Gm-Message-State: APuU4Z98oi23MdZaUabMdtkatkMU1dcQfd0BWt+7PiU8/KgAN5MQ6TsR
 DCZqrZrG6C4SUwPhe7UiRpl4f/FJK/4r6P5lwkkur4RpTSjTP/BE/YYlKuE/+x2aDP6B42NRzF8
 YwDaX7rP3aTUc0IaI7P7eRCRWWN537Jry5uenq00ELA==
X-Gm-Gg: AYBFou0LQLRzzemTShAVg81Tj97SOtsF79TVv/Nl5EP4JpKwI8v2Z8gXA7/7WlSfb9L
 46f/D0d0ExEBVEKumWd5kLnyqSJM/Qt2XDmSu94cC1akoKfSE8pyz0f8clB9Ig8O0JUhPwucysZ
 lVbljaU9S6Fo6RSJtXsrJMIf8V5a9O3Tac7i0GuFyuTpPb5TcLGl4U8rVHImhNbvhK5vgGBigvo
 f5og71tWBjf0v9PDtavDdisJQehbXYwJSINyLQq8I02k7jXg+TGEHVvblqE7+aHASKdqOyih34f
 W5fGfwyWRFk60Ws35aH/rRrQ6pbAn9hXiEawqbjnEnYF3Rk94Q0if6JXxw2uEy8b1Ej4+kmhjMj
 P2GTv/WWpR44VbcM6iVFv6+i1vSoI9NamNHfe2m3/M4T3gqiIxdvn6ZjEDCPH3zrk5IdQIHujuo
 cvu5R3qnqe+Dt1wzlYcYwp
X-Received: by 2002:a05:690c:3481:b0:8b1:5222:93d7 with SMTP id
 00721157ae682-8b2b683d076mr132144017b3.68.1793877938277; Thu, 05 Nov 2026
 03:25:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103133500.2295582-1-pbonzini@redhat.com>
 <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
In-Reply-To: <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 11:25:26 +0000
X-Gm-Features: AclHuK-GO8dWyYTuPHy-2SYrZdZ75qWGf1fY1KQ75kXThqcpLUO7n0jkq49w1yE
Message-ID: <CAFEAcA8bGODxRfRzrimhGN1v2HtcWvApRsyucemZbMUUBVkYwA@mail.gmail.com>
Subject: Re: [PULL v2 00/10] i386, AGENTS.md,
 meson changes for QEMU 11.2 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 10:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 3 Nov 2026 at 13:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > ----------------------------------------------------------------
> > * target/i386/tcg: bugfixes and cleanups
> > * AGENTS.md: add final instructions
> > * meson: rewrite scripts/qemu-version.sh directly in meson.build
> >
> > ----------------------------------------------------------------
>
> The qemu-version.h changes here seem to have broken incremental builds:
>
> In file included from ../../monitor/qmp-cmds-control.c:28:
> /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> qemu-version.h: No such file or directory
>    11 | #include "qemu-version.h"
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
>
> This happens even though the incremental rebuild decided it had
> to re-run configure.
>
> Blowing away the build tree and doing a complete rebuild avoids the
> error, but it would be nice for incremental builds to work.

Also, if you delete qemu-version.h from the build tree, then
re-run make, nothing notices that it needs to recreate the file
and the build fails. Perhaps there is a dependency missing ?

thanks
-- PMM

