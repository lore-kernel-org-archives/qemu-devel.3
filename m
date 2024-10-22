Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C453CDD0FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 22:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3N1R-0000vK-Q6; Tue, 22 Oct 2024 18:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t3N1Q-0000v7-DZ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 18:06:36 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t3N1O-0001kz-6E
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 18:06:36 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e5ffbc6acbso2953120b6e.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729634792; x=1730239592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZpHR0R+/FPs39WrlOF2eDIxYWEFBWShJ3HVfIaflAk=;
 b=GUrB1+n4hQ3yTJ1Maiq5yd+wNvqTSTZlZgHwfy+OYe25xDX2TOKJ9j+bKfv3CFpVH9
 xVQ35Ae9CfvqCItLJVhYNeuR3t2zSldM+0MLSRY5Af7uFDCxLEFHQ/Lawi7YiTtkBYrD
 2Aw9Z0ikzrBcgHOd9vQAnBCnXlnQeRGqFQyLPwD00D5ucApZ2SLx1i6OLAkq1JsCo1dh
 g0BWkW/bS84CjVrm7+s1Kktq2/hN+s2OY3vYmVhXXh6RJJbgmDF38ySchp5E66gZfOGr
 iOtGVllJ/1eF+oPBPmdCXrxCxSVuFSM2uyTgj/M55nKCzaaRqXkHx1LTT058BMJefag/
 1lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729634792; x=1730239592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZpHR0R+/FPs39WrlOF2eDIxYWEFBWShJ3HVfIaflAk=;
 b=KmVLMFfQGUsdeXF1QNB1GE+lx69fP+fTu2RFet6JFL8/6emmWOYsCAVK2qBuP9GF4p
 hentnvhAbnU8Axhiz1la1WmtCVf/1FqVJ3wyLjKL1ZUDzOhQ+OPn15V+0ROPxkam8XZ+
 N+S/tT7xb/WQzlyHVJp9WjcfWJWZJR6xNpkNep8rQmCc7oflFmqwuvXDm34gw55cMCWA
 EA8Th1awYC1jrP3TBvAN9RzBpmVrmOBtS8lbATwLgqCFcu1Q03KQSjLeALGL24MXrGAk
 kv3TXz1nLx8ZATQjWuBqVkPANylxef4KgxGg2dxcoAUUCtjHw+f3ZIsoqI7a7gt+mYzP
 Rqnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/wHm8EIY8+Qx8v05bd2pqC8P/7VaB5ImUVaokhToKxdxWiRVeivU6dSy6xemUWSjtA6x+1VsZ2b25@nongnu.org
X-Gm-Message-State: AOJu0YxGKmzsBxAsvxUowKx9tsAnQ7Dp9m3fxLJZcN7L7RxLC46XCL4C
 lNKe32m4GQBdarxz6T4DqrCQfd2aUmIOgvY/A2KQ/3UYeWdof6d+1qcBAtoahctQuXbQrYMR9jw
 jsy/EiIduAehNyb3dP8ZfpYFJKNI=
X-Google-Smtp-Source: AGHT+IEHhOIlnhqbXdDA02ALTnMFA7O05g3zCjUTJcP21FW5WrYjznmQFaCLchn8yZ+EYZccskHtGHrGHUxzvwF9Wgc=
X-Received: by 2002:a05:6808:1307:b0:3e6:1ed5:1921 with SMTP id
 5614622812f47-3e6245d1fc2mr546358b6e.47.1729634791869; Tue, 22 Oct 2024
 15:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <CAFUsyf+wYJVQHFaJZZ2mE0e3MRXMoQsr+-vk3T0qU3LYd3Dujw@mail.gmail.com>
 <731d741bb01c8157a076a3614d20732a3ea448db.camel@linux.ibm.com>
 <CAFUsyfKhLpZF1RvwVK06jud6ArPEcG7M61cKNoQVWXLRgNaaog@mail.gmail.com>
 <CAFUsyfKgw_DAfowOoFxUpHOR+Jw6hH9oV5JGNXKe0Ph=miRFxw@mail.gmail.com>
In-Reply-To: <CAFUsyfKgw_DAfowOoFxUpHOR+Jw6hH9oV5JGNXKe0Ph=miRFxw@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Tue, 22 Oct 2024 17:06:20 -0500
Message-ID: <CAFUsyf+RZ=NzPVzC0A2-WDym7562cwk-qPyjR+UryP9=RP8Fsw@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Oct 11, 2024 at 1:14=E2=80=AFPM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> On Wed, Oct 2, 2024 at 11:42=E2=80=AFAM Noah Goldstein <goldstein.w.n@gma=
il.com> wrote:
> >
> > On Wed, Oct 2, 2024 at 11:39=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm=
.com> wrote:
> > >
> > > On Wed, 2024-10-02 at 09:05 -0500, Noah Goldstein wrote:
> > > > On Wed, Oct 2, 2024 at 3:08=E2=80=AFAM Ilya Leoshkevich <iii@linux.=
ibm.com>
> > > > wrote:
> > > > >
> > > > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > > > > The new option '-qemu-children' makes it so that on `execve` th=
e
> > > > > > child
> > > > > > process will be launch by the same `qemu` executable that is
> > > > > > currently
> > > > > > running along with its current commandline arguments.
> > > > > >
> > > > > > The motivation for the change is to make it so that plugins
> > > > > > running
> > > > > > through `qemu` can continue to run on children.  Why not just
> > > > > > `binfmt`?: Plugins can be desirable regardless of
> > > > > > system/architecture
> > > > > > emulation, and can sometimes be useful for elf files that can r=
un
> > > > > > natively. Enabling `binfmt` for all natively runnable elf files
> > > > > > may
> > > > > > not be desirable.
> > > > >
> > > > > Another reason to have this is that one may not have root
> > > > > permissions
> > > > > to configure binfmt-misc.
> > > > >
> > > > +1
> > > >
> > > > > There was a similar patch posted to the mailing list some years
> > > > > back,
> > > > > which I used to cherry-pick when I needed this. I'm not sure what
> > > > > happened to that discussion though.
> > > >
> > > > Yes(ish):
> > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/1455515507-26=
877-1-git-send-email-petrosagg@resin.io/
> > >
> > > Thanks for finding this! Don't we need the shebang handling here as
> > > well?
> > >
> > I don't think so. In this case we aren't making it so execve can point =
to
> > some arbitrary impl, just that we propagate the current running qemu
> > env.
> >
>
> ping
ping2
> > > Laurent, do you per chance know why was it not accepted back
> > > then?Unfortunately I cannot find any discussion associated with v3 or
> > > v4
> > > [1]. There were some concerns regarding v1 [2], but from what I can s=
ee
> > > they all were addressed.
> > >
> > > [1]
> > > https://patchew.org/QEMU/20200730160106.16613-1-rj.bcjesus@gmail.com/
> > > [2]
> > > https://patchwork.kernel.org/project/qemu-devel/patch/1453091602-2184=
3-1-git-send-email-petrosagg@gmail.com/

