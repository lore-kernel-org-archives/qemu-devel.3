Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D8C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 10:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUOH4-0003Qy-6X; Thu, 18 Jul 2024 06:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUOH2-0003Q1-RR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUOH0-0001HQ-Qa
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721298124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehb6jZNUCEuAZoXTEiZ5GkArIOHs6STjyNrlaIP1VOU=;
 b=bt9eVud1pV+tQVOczyGZ1RNQhUoQdwxk1OLqq808mWd3feItr85ICLRVTI7D9e59K/SVOc
 kMss82oWOvKtK9bC2vGSjS8fTntM+JmzRjnmKcqG92IdPKsnzOPVeT1fenFc7EsA4WEv0H
 YWwZ02mdLQls2DIdch1cwz42befspro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-WjZfSW8UMp-q0FkaPc-P4A-1; Thu,
 18 Jul 2024 06:22:01 -0400
X-MC-Unique: WjZfSW8UMp-q0FkaPc-P4A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2704C1955F69; Thu, 18 Jul 2024 10:22:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC22D1955D4A; Thu, 18 Jul 2024 10:21:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91BD921E66A7; Thu, 18 Jul 2024 12:21:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Octavian Purdila <tavip@google.com>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  eblake@redhat.com,
 peter.maydell@linaro.org,  Paulo Neves <ptsneves@gmail.com>
Subject: Re: [PATCH v3] chardev: add path option for pty backend
In-Reply-To: <ZpjhwFpnHK1d3yVZ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 18 Jul 2024 10:34:56 +0100")
References: <20240605185050.1678102-1-tavip@google.com>
 <87r0br8bve.fsf@pond.sub.org> <ZpjhwFpnHK1d3yVZ@redhat.com>
Date: Thu, 18 Jul 2024 12:21:56 +0200
Message-ID: <87a5ifknjv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jul 18, 2024 at 08:15:01AM +0200, Markus Armbruster wrote:
>> Looks like this one fell through the cracks.
>>=20
>> Octavian Purdila <tavip@google.com> writes:
>>=20
>> > Add path option to the pty char backend which will create a symbolic
>> > link to the given path that points to the allocated PTY.
>> >
>> > This avoids having to make QMP or HMP monitor queries to find out what
>> > the new PTY device path is.
>>=20
>> QMP commands chardev-add and chardev-change return the information you
>> want:
>>=20
>>     # @pty: name of the slave pseudoterminal device, present if and only
>>     #     if a chardev of type 'pty' was created
>>=20
>> So does HMP command chardev-add.  HMP chardev apparently doesn't, but
>> that could be fixed.
>
> It does print it:
>
>   (qemu) chardev-add  pty,id=3Dbar
>   char device redirected to /dev/pts/12 (label bar)

I fat-fingered "HMP chardev-change".

>> So, the use case is basically the command line, right?
>
> Also cli prints it
>
>   $ qemu-system-x86_64 -chardev pty,id=3Dfoo -monitor stdio -display none
>   char device redirected to /dev/pts/10 (label foo)

Good enough for ad hoc use by humans.

Management applications should use QMP, which returns it.

I guess there's scripts in between.

>> > Based on patch from Paulo Neves:
>> >
>> > https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gm=
ail.com/
>> >
>> > Tested with the following invocations that the link is created and
>> > removed when qemu stops:
>> >
>> >   qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
>> >   -chardev pty,path=3Dtest,id=3Dcompat_monitor0
>> >
>> >   qemu-system-x86_64 -nodefaults -monitor pty:test
>> >
>> > Also tested that when a link path is not passed invocations still work=
, e.g.:
>> >
>> >   qemu-system-x86_64 -monitor pty
>> >
>> > Co-authored-by: Paulo Neves <ptsneves@gmail.com>
>> > Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>> > [OP: rebase and address original patch review comments]
>> > Signed-off-by: Octavian Purdila <tavip@google.com>
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

>> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>> > index cc2f7617fe..5c6172ddba 100644
>> > --- a/chardev/char-pty.c
>> > +++ b/chardev/char-pty.c
>> > @@ -29,6 +29,7 @@
>> >  #include "qemu/sockets.h"
>> >  #include "qemu/error-report.h"
>> >  #include "qemu/module.h"
>> > +#include "qemu/option.h"
>> >  #include "qemu/qemu-print.h"
>> >=20=20
>> >  #include "chardev/char-io.h"
>> > @@ -41,6 +42,7 @@ struct PtyChardev {
>> >=20=20
>> >      int connected;
>> >      GSource *timer_src;
>> > +    char *symlink_path;
>> >  };
>> >  typedef struct PtyChardev PtyChardev;
>> >=20=20
>> > @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
>> >      Chardev *chr =3D CHARDEV(obj);
>> >      PtyChardev *s =3D PTY_CHARDEV(obj);
>> >=20=20
>> > +    /* unlink symlink */
>> > +    if (s->symlink_path) {
>> > +        unlink(s->symlink_path);
>> > +        g_free(s->symlink_path);
>> > +    }
>>=20
>> Runs when the chardev object is finalized.
>>=20
>> Doesn't run when QEMU crashes.  Stale symlink left behind then.  Can't
>> see how you could avoid that at reasonable cost.  Troublesome all the
>> same.
>
> Do we ever guarantee that the finalizer runs ?  eg dif we have
>
>   error_setg(&error_exit, ....
>
> that's a clean exit, not a crash, but I don't think chardev finalizers
> will run, as we don't do atexit() hooks for it.

Point.

>> The feature feels rather doubtful to me, to be honest.
>
> On the one hand I understand the pain - long ago libvirt had to deal
> with parsing the console messages
>
>   char device redirected to /dev/pts/10 (label foo)
>
> before we switched to using QMP to query this.
>
> On the other hand, in retrospect libvirt should never have used the 'pty'
> backend in the first place. The 'unix' socket backend is a  choice as it
> has predictable filenames, and it has proper connection oriented semantic=
s,
> so QEMU can reliably detect when clients disconnect, which has always been
> troublesome for the 'pty' backend.
>
> So while I can understand the desire to add a 'path' option to 'pty'
> to trigger symlink creation, I think we could choose to tell people
> to use the 'unix' socket backend instead if they want a predictable
> path. This would avoid us creating the difficult to fix bug for
> symlink deletion in error conditions.
>
> What's the key benefit of the 'pty' backend, that 'unix' doesn't
> handle ?

I think this is the question to answer.


