Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AD4C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNXi-0002o4-7E; Thu, 18 Jul 2024 05:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUNXg-0002ii-Qy
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUNXd-0004gQ-Nl
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721295311;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8iguRIACEO2H+vCKROWWxkqs61CdK6rPXgTBtqOYKB8=;
 b=JAHw0JU6H70PpHlTnD7Q3nUc1nYjKdqFPAAIpDx5DQm90kJgGFjMTkgFs4gfautvGj/Hvg
 XxSjz3APz46nEXaBc8w/vMhz3Ae3dYOn2rvWz4xIAQqAojdD7Zl5U5Btz/9U8TXXx6410w
 fOBIPm/wAUJ0IcJTK9NEuO7YfglJevE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-TI03QDCHOimK5AMtrQ7x2w-1; Thu,
 18 Jul 2024 05:35:04 -0400
X-MC-Unique: TI03QDCHOimK5AMtrQ7x2w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 575CB1955D59; Thu, 18 Jul 2024 09:35:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7869919560AA; Thu, 18 Jul 2024 09:35:00 +0000 (UTC)
Date: Thu, 18 Jul 2024 10:34:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org, Paulo Neves <ptsneves@gmail.com>
Subject: Re: [PATCH v3] chardev: add path option for pty backend
Message-ID: <ZpjhwFpnHK1d3yVZ@redhat.com>
References: <20240605185050.1678102-1-tavip@google.com>
 <87r0br8bve.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0br8bve.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 18, 2024 at 08:15:01AM +0200, Markus Armbruster wrote:
> Looks like this one fell through the cracks.
> 
> Octavian Purdila <tavip@google.com> writes:
> 
> > Add path option to the pty char backend which will create a symbolic
> > link to the given path that points to the allocated PTY.
> >
> > This avoids having to make QMP or HMP monitor queries to find out what
> > the new PTY device path is.
> 
> QMP commands chardev-add and chardev-change return the information you
> want:
> 
>     # @pty: name of the slave pseudoterminal device, present if and only
>     #     if a chardev of type 'pty' was created
> 
> So does HMP command chardev-add.  HMP chardev apparently doesn't, but
> that could be fixed.

It does print it:

  (qemu) chardev-add  pty,id=bar
  char device redirected to /dev/pts/12 (label bar)


> So, the use case is basically the command line, right?

Also cli prints it

  $ qemu-system-x86_64 -chardev pty,id=foo -monitor stdio -display none
  char device redirected to /dev/pts/10 (label foo)


> > Based on patch from Paulo Neves:
> >
> > https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail.com/
> >
> > Tested with the following invocations that the link is created and
> > removed when qemu stops:
> >
> >   qemu-system-x86_64 -nodefaults -mon chardev=compat_monitor \
> >   -chardev pty,path=test,id=compat_monitor0
> >
> >   qemu-system-x86_64 -nodefaults -monitor pty:test
> >
> > Also tested that when a link path is not passed invocations still work, e.g.:
> >
> >   qemu-system-x86_64 -monitor pty
> >
> > Co-authored-by: Paulo Neves <ptsneves@gmail.com>
> > Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> > [OP: rebase and address original patch review comments]
> > Signed-off-by: Octavian Purdila <tavip@google.com>
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> > Changes since v2:
> >
> >  * remove NULL path check, g_strdup() allows NULL inputs  
> >
> > Changes since v1:
> >
> >  * Keep the original Signed-off-by from Paulo and add one line
> >     description with further changes
> >
> >  * Update commit message with justification for why the new
> >     functionality is useful
> >
> >  * Don't close master_fd when symlink creation fails to avoid double
> >     close
> >
> >  * Update documentation for clarity
> >
> > chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++
> >  chardev/char.c     |  5 +++++
> >  qapi/char.json     |  4 ++--
> >  qemu-options.hx    | 24 ++++++++++++++++++------
> >  4 files changed, 58 insertions(+), 8 deletions(-)
> >
> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > index cc2f7617fe..5c6172ddba 100644
> > --- a/chardev/char-pty.c
> > +++ b/chardev/char-pty.c
> > @@ -29,6 +29,7 @@
> >  #include "qemu/sockets.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/module.h"
> > +#include "qemu/option.h"
> >  #include "qemu/qemu-print.h"
> >  
> >  #include "chardev/char-io.h"
> > @@ -41,6 +42,7 @@ struct PtyChardev {
> >  
> >      int connected;
> >      GSource *timer_src;
> > +    char *symlink_path;
> >  };
> >  typedef struct PtyChardev PtyChardev;
> >  
> > @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
> >      Chardev *chr = CHARDEV(obj);
> >      PtyChardev *s = PTY_CHARDEV(obj);
> >  
> > +    /* unlink symlink */
> > +    if (s->symlink_path) {
> > +        unlink(s->symlink_path);
> > +        g_free(s->symlink_path);
> > +    }
> 
> Runs when the chardev object is finalized.
> 
> Doesn't run when QEMU crashes.  Stale symlink left behind then.  Can't
> see how you could avoid that at reasonable cost.  Troublesome all the
> same.

Do we ever guarantee that the finalizer runs ?  eg dif we have

  error_setg(&error_exit, ....

that's a clean exit, not a crash, but I don't think chardev finalizers
will run, as we don't do atexit() hooks for it.


> The feature feels rather doubtful to me, to be honest.

On the one hand I understand the pain - long ago libvirt had to deal
with parsing the console messages

  char device redirected to /dev/pts/10 (label foo)

before we switched to using QMP to query this.

On the other hand, in retrospect libvirt should never have used the 'pty'
backend in the first place. The 'unix' socket backend is a  choice as it
has predictable filenames, and it has proper connection oriented semantics,
so QEMU can reliably detect when clients disconnect, which has always been
troublesome for the 'pty' backend.

So while I can understand the desire to add a 'path' option to 'pty'
to trigger symlink creation, I think we could choose to tell people
to use the 'unix' socket backend instead if they want a predictable
path. This would avoid us creating the difficult to fix bug for
symlink deletion in error conditions.

What's the key benefit of the 'pty' backend, that 'unix' doesn't
handle ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


