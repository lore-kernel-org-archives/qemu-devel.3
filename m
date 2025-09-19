Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B55CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbEq-0004Yz-4U; Fri, 19 Sep 2025 09:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbEm-0004Y3-Gt
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbEc-0002XC-4o
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288756;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKls2lJBiWd0JbNnI5zgTZdPIw8lhfZv5UhyAfFizRs=;
 b=ZKAEjWn8iil904uL+3icREkcelo3+AB7DfD5sWzZpAj/ltVITywlRWk0HrrcUV6+nnMK0p
 gHCeaSVBUtAQYU/EnErYiKhgJ/9XdpL7DRVglgb1V1NhNO4NkiEJ/IoHonpv8xgrQ8CXON
 fWeGpuko0CrNOgAzL02sPoO+4fIu6HI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-ITtLettAMqC9EO9MfBIlRg-1; Fri,
 19 Sep 2025 09:32:32 -0400
X-MC-Unique: ITtLettAMqC9EO9MfBIlRg-1
X-Mimecast-MFC-AGG-ID: ITtLettAMqC9EO9MfBIlRg_1758288746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A63618004D8; Fri, 19 Sep 2025 13:32:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E268C19560BB; Fri, 19 Sep 2025 13:32:21 +0000 (UTC)
Date: Fri, 19 Sep 2025 14:32:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 03/20] system: unconditionally enable thread naming
Message-ID: <aM1bYpUcXkQJl-95@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-4-berrange@redhat.com>
 <87zfaq6efw.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfaq6efw.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 19, 2025 at 10:20:51AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > When thread naming was introduced years ago, it was disabled by
> > default and put behind a command line flag:
> >
> >   commit 8f480de0c91a18d550721f8d9af969ebfbda0793
> >   Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >   Date:   Thu Jan 30 10:20:31 2014 +0000
> >
> >     Add 'debug-threads' suboption to --name
> >
> > This was done based on a concern that something might depend
> > on the historical thread naming. Thread names, however, were
> > never promised to be part of QEMU's public API. The defaults
> > will vary across platforms, so no assumptions should ever be
> > made about naming.
> >
> > An opt-in behaviour is also unfortunately incompatible with
> > RCU which creates its thread from an constructor function
> > which is run before command line args are parsed. Thus the
> > RCU thread lacks any name.
> >
> > libvirt has unconditionally enabled debug-threads=yes on all
> > VMs it creates for 10 years. Interestingly this DID expose a
> > bug in libvirt, as it parsed /proc/$PID/stat and could not
> > cope with a space in the thread name. This was a latent
> > pre-existing bug in libvirt though, and not a part of QEMU's
> > API.
> >
> > Having thread names always available, will allow thread names
> > to be included in error reports and log messags QEMU prints
> > by default, which will improve ability to triage QEMU bugs.
> >
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/about/deprecated.rst |  7 +++++++
> >  include/qemu/thread.h     |  1 -
> >  system/vl.c               | 11 ++++++-----
> >  util/qemu-thread-posix.c  | 18 +-----------------
> >  util/qemu-thread-win32.c  | 27 ++++++---------------------
> >  5 files changed, 20 insertions(+), 44 deletions(-)
> >
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index b2420732e1..7187ea15fa 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -81,6 +81,13 @@ kernel since 2001. None of the board types QEMU supports need
> >  ``param_struct`` support, so this option has been deprecated and will
> >  be removed in a future QEMU version.
> >  
> > +``debug-threads`` option for ``-name``
> > +''''''''''''''''''''''''''''''''''''''
> > +
> > +Thread ``debug-threads`` option for the ``-name`` argument is now
> 
> Do you mean "The ``debug-threads`` option"?

Opps, yes indeed.

> 
> "option for" or "option of"?  Not a native speaker...

"of" is probably better.

> 
> > +ignored. Thread naming is unconditionally enabled for all platforms
> > +where it is supported.
> > +
> >  QEMU Machine Protocol (QMP) commands
> >  ------------------------------------
> >  
> > diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> > index f0302ed01f..3a286bb3ef 100644
> > --- a/include/qemu/thread.h
> > +++ b/include/qemu/thread.h
> > @@ -215,7 +215,6 @@ void *qemu_thread_join(QemuThread *thread);
> >  void qemu_thread_get_self(QemuThread *thread);
> >  bool qemu_thread_is_self(QemuThread *thread);
> >  G_NORETURN void qemu_thread_exit(void *retval);
> > -void qemu_thread_naming(bool enable);
> >  
> >  struct Notifier;
> >  /**
> > diff --git a/system/vl.c b/system/vl.c
> > index 3b7057e6c6..a64fd90d4a 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -403,9 +403,7 @@ static QemuOptsList qemu_name_opts = {
> >          }, {
> >              .name = "debug-threads",
> >              .type = QEMU_OPT_BOOL,
> > -            .help = "When enabled, name the individual threads; defaults off.\n"
> > -                    "NOTE: The thread names are for debugging and not a\n"
> > -                    "stable API.",
> > +            .help = "DEPRECATED: thread names are always set where supported",
> 
> Please don't shout :)

Hmmm, yes.

> We rarely note deprecation notes in command line help texts.  I found
> two.
> 
> block/qcow.c:
> 
>         {
>             .name = BLOCK_OPT_ENCRYPT,
>             .type = QEMU_OPT_BOOL,
>             .help = "Encrypt the image with format 'aes'. (Deprecated "
>                     "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",
>         },
> 
> block/qcow2.c:
> 
>         {                                                               \
>             .name = BLOCK_OPT_ENCRYPT,                                  \
>             .type = QEMU_OPT_BOOL,                                      \
>             .help = "Encrypt the image with format 'aes'. (Deprecated " \
>                     "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",    \
>         },                                                              \
>         {                                                               \
> 
> Suggest something like
> 
>             .help = "Enable thread names"
>                     " (deprecated, always enabled where supported)",

Sure.

> 
> >          },
> >          { /* End of list */ }
> >      },
> > @@ -554,9 +552,12 @@ static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
> >  {
> >      const char *proc_name;
> >  
> > -    if (qemu_opt_get(opts, "debug-threads")) {
> > -        qemu_thread_naming(qemu_opt_get_bool(opts, "debug-threads", false));
> > +    if (qemu_opt_get(opts, "debug-threads") &&
> > +        !qemu_opt_get_bool(opts, "debug-threads", false)) {
> > +        fprintf(stderr, "Ignoring deprecated 'debug-threads=no' option, " \
> > +                "thread naming is unconditionally enabled\n");
> 
> Not sure this is worth the trouble, but since you wrote and tested it
> already...

As a general rule I like there to be a printf() in any code path that
touches a deprecation, because we know  people often won't actually
read the docs. The message is helping them know what's coming soon


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


