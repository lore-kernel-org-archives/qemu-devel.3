Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BA8C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 17:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUUyD-0000aM-O0; Thu, 18 Jul 2024 13:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sUUyB-0000ZZ-MO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 13:31:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sUUy9-0003VJ-2y
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 13:31:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-368584f9e36so52033f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721323862; x=1721928662; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJzIyQJMK6X/dofHlCmvePnLt9wPeiJirjt9S+2u/zU=;
 b=yNrcP0K+qOAmKf5moqmN81gRCkmRmfVH0iDSgbdoQr0KIKjvOy6wQdHqYyhnXC3v55
 CBjUjO8l+EbZscooNzk8EQxB/TtHQpB6UZGQTf6+iuTgUQIdFf4Bmm8Q5mB/2zVgtdPC
 WRH8Otq2n9F3sOANcdusKu2Lg1Ct2DIJ9RFU9gN2VoPSuEmm1/q8A7vn7emoovZJNcom
 gv4/Aj5HjyNspQ9lqYLSYC3q1ZHjyd8DQWz8firi/3RJJju1nApeSYV5AmsQzks/dGmu
 VX9XM5S+SocW9manrh1z8+Tg8m87BoJRT+30VDFrNBG3SdzETG/sMkoeLiy5zrD6CSIM
 kNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721323862; x=1721928662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJzIyQJMK6X/dofHlCmvePnLt9wPeiJirjt9S+2u/zU=;
 b=hcDbe8G5/0Nw1kPlmNwIM8XnWIkhDqLoi/XzB8409sJyK9500L0h3FuqeQ++FCui2s
 SpVi0g1Nnq7fduPbz6p+nyd2joq4MtPIgMPT3x0OKfj41xUOM3HmuuUwImMQSYV3F4UQ
 s2z2UnmqWYDME4RzUp8XOOmcPMlAn9j6XbtxhrygNRvUEdRLJd4a5nM/hW6vV+Ua9WSW
 7NcXU13aFubXXrRcjBlS1D+lETiqWtnladYAvvl8VEpN1f9u1Znhs28btlwkV895y1nt
 D2yBKsLWwFmPLfP3P4c1fF4Q6dQEmpCvQ9+InFAzJ0BHkqRaDxHk4y4lSKQ2t+Muuvd4
 S4Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxwhiQmTtYiFTuPGRKwZjgDn9xqOYnuV2pKDJb793wygIM1+BFQ5Jr2wt35Jcvf3KGWkvU22I+MIvKYN84Q6JJ3M24b9M=
X-Gm-Message-State: AOJu0YwIc0lRUXfJMdRgdZqW/ayfSuvsSMhkMx83Im9mTJwvzaoMqloj
 nEYaLhuFW2uD64K+0gnwIheG3RgKoTj2uyqQfz2i5+KufaqB6yyZZCePmH2wDqwkc46EWcn3T4Y
 njzbOzP2E3U79kRtNX5Q5ZPxAavT6Oo9rZD7q
X-Google-Smtp-Source: AGHT+IHkul1Y7f3ZFTle9yUJ7WjDQck26SYyNF8A4g6UwLym0F7pDO6+FbJdZa1GVFjZvQpSCpigj8bGJaQEgmy1r5A=
X-Received: by 2002:a05:6000:1a45:b0:368:36e6:b248 with SMTP id
 ffacd0b85a97d-36836e6b450mr3966741f8f.23.1721323861453; Thu, 18 Jul 2024
 10:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240605185050.1678102-1-tavip@google.com>
 <87r0br8bve.fsf@pond.sub.org>
 <ZpjhwFpnHK1d3yVZ@redhat.com> <87a5ifknjv.fsf@pond.sub.org>
In-Reply-To: <87a5ifknjv.fsf@pond.sub.org>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 18 Jul 2024 10:30:50 -0700
Message-ID: <CAGWr4cS4AMfLCZBV=8TSrbk-OVc=cX17ku=6UC0vKXQGeq4hvw@mail.gmail.com>
Subject: Re: [PATCH v3] chardev: add path option for pty backend
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com, eblake@redhat.com, 
 peter.maydell@linaro.org, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=tavip@google.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jul 18, 2024 at 3:22=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Thu, Jul 18, 2024 at 08:15:01AM +0200, Markus Armbruster wrote:
> >> Looks like this one fell through the cracks.
> >>
> >> Octavian Purdila <tavip@google.com> writes:
> >>
> >> > Add path option to the pty char backend which will create a symbolic
> >> > link to the given path that points to the allocated PTY.
> >> >
> >> > This avoids having to make QMP or HMP monitor queries to find out wh=
at
> >> > the new PTY device path is.
> >>
> >> QMP commands chardev-add and chardev-change return the information you
> >> want:
> >>
> >>     # @pty: name of the slave pseudoterminal device, present if and on=
ly
> >>     #     if a chardev of type 'pty' was created
> >>
> >> So does HMP command chardev-add.  HMP chardev apparently doesn't, but
> >> that could be fixed.
> >
> > It does print it:
> >
> >   (qemu) chardev-add  pty,id=3Dbar
> >   char device redirected to /dev/pts/12 (label bar)
>
> I fat-fingered "HMP chardev-change".
>
> >> So, the use case is basically the command line, right?
> >
> > Also cli prints it
> >
> >   $ qemu-system-x86_64 -chardev pty,id=3Dfoo -monitor stdio -display no=
ne
> >   char device redirected to /dev/pts/10 (label foo)
>
> Good enough for ad hoc use by humans.
>
> Management applications should use QMP, which returns it.
>
> I guess there's scripts in between.
>
> >> > Based on patch from Paulo Neves:
> >> >
> >> > https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@=
gmail.com/
> >> >
> >> > Tested with the following invocations that the link is created and
> >> > removed when qemu stops:
> >> >
> >> >   qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
> >> >   -chardev pty,path=3Dtest,id=3Dcompat_monitor0
> >> >
> >> >   qemu-system-x86_64 -nodefaults -monitor pty:test
> >> >
> >> > Also tested that when a link path is not passed invocations still wo=
rk, e.g.:
> >> >
> >> >   qemu-system-x86_64 -monitor pty
> >> >
> >> > Co-authored-by: Paulo Neves <ptsneves@gmail.com>
> >> > Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> >> > [OP: rebase and address original patch review comments]
> >> > Signed-off-by: Octavian Purdila <tavip@google.com>
> >> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> [...]
>
> >> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> >> > index cc2f7617fe..5c6172ddba 100644
> >> > --- a/chardev/char-pty.c
> >> > +++ b/chardev/char-pty.c
> >> > @@ -29,6 +29,7 @@
> >> >  #include "qemu/sockets.h"
> >> >  #include "qemu/error-report.h"
> >> >  #include "qemu/module.h"
> >> > +#include "qemu/option.h"
> >> >  #include "qemu/qemu-print.h"
> >> >
> >> >  #include "chardev/char-io.h"
> >> > @@ -41,6 +42,7 @@ struct PtyChardev {
> >> >
> >> >      int connected;
> >> >      GSource *timer_src;
> >> > +    char *symlink_path;
> >> >  };
> >> >  typedef struct PtyChardev PtyChardev;
> >> >
> >> > @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
> >> >      Chardev *chr =3D CHARDEV(obj);
> >> >      PtyChardev *s =3D PTY_CHARDEV(obj);
> >> >
> >> > +    /* unlink symlink */
> >> > +    if (s->symlink_path) {
> >> > +        unlink(s->symlink_path);
> >> > +        g_free(s->symlink_path);
> >> > +    }
> >>
> >> Runs when the chardev object is finalized.
> >>
> >> Doesn't run when QEMU crashes.  Stale symlink left behind then.  Can't
> >> see how you could avoid that at reasonable cost.  Troublesome all the
> >> same.
> >
> > Do we ever guarantee that the finalizer runs ?  eg dif we have
> >
> >   error_setg(&error_exit, ....
> >
> > that's a clean exit, not a crash, but I don't think chardev finalizers
> > will run, as we don't do atexit() hooks for it.
>
> Point.
>

I agree this is a shortcoming. But this can easily be fixed externally
at the invocation path.

> >> The feature feels rather doubtful to me, to be honest.
> >
> > On the one hand I understand the pain - long ago libvirt had to deal
> > with parsing the console messages
> >
> >   char device redirected to /dev/pts/10 (label foo)
> >
> > before we switched to using QMP to query this.
> >
> > On the other hand, in retrospect libvirt should never have used the 'pt=
y'
> > backend in the first place. The 'unix' socket backend is a  choice as i=
t
> > has predictable filenames, and it has proper connection oriented semant=
ics,
> > so QEMU can reliably detect when clients disconnect, which has always b=
een
> > troublesome for the 'pty' backend.
> >
> > So while I can understand the desire to add a 'path' option to 'pty'
> > to trigger symlink creation, I think we could choose to tell people
> > to use the 'unix' socket backend instead if they want a predictable
> > path. This would avoid us creating the difficult to fix bug for
> > symlink deletion in error conditions.
> >
> > What's the key benefit of the 'pty' backend, that 'unix' doesn't
> > handle ?
>
> I think this is the question to answer.
>

In my case the user of the serial device does not support unix sockets.

