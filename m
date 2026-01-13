Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E86D2D0E4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfd0h-0006Ct-8S; Tue, 13 Jan 2026 06:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfd0Y-0006Aj-Io
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:56:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfd0U-0006gY-9m
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768305376;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AceUXHTl+ZnYM6QlCLoO/rXHTCu2lYmMUrjaVdxnwO4=;
 b=K+fqt/Ux0TWVZZpOaZtErrbVhybbRz8GoFSWWbSD/tuxTDyCq9mUvIDWGXGMkIOTLh0eT1
 KThYVzqWJJIKtD41ZcGXxsxsaDM4MPfblwqetZ08fa664w3OU0RFpvHZ+xaUyI4nYKowCl
 50/VbKkgUL7R3Jkgtx0bQ0nfFJgbXHI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-9pNpgyPoMEO7fDWyKF-6nw-1; Tue,
 13 Jan 2026 06:56:13 -0500
X-MC-Unique: 9pNpgyPoMEO7fDWyKF-6nw-1
X-Mimecast-MFC-AGG-ID: 9pNpgyPoMEO7fDWyKF-6nw_1768305371
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DD6418005B8; Tue, 13 Jan 2026 11:56:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91EA830001A2; Tue, 13 Jan 2026 11:56:06 +0000 (UTC)
Date: Tue, 13 Jan 2026 11:56:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org,
 qemu-rust@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 10/24] util: avoid repeated prefix on incremental
 qemu_log calls
Message-ID: <aWYy0yQtcaLLdnzE@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-11-berrange@redhat.com>
 <87h5spak7y.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5spak7y.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 13, 2026 at 11:19:13AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > There are three general patterns to QEMU log output
> >
> >  1. Single complete message calls
> >
> >       qemu_log("Some message\n");
> >
> >  2. Direct use of fprintf
> >
> >       FILE *f = qemu_log_trylock()
> >       fprintf(f, "...");
> >       fprintf(f, "...");
> >       fprintf(f, "...\n");
> >       qemu_log_unlock(f)
> >
> >  3. Mixed use of qemu_log_trylock/qemu_log()
> >
> >       FILE *f = qemu_log_trylock()
> >       qemu_log("....");
> >       qemu_log("....");
> >       qemu_log("....\n");
> >       qemu_log_unlock(f)


> > Fixes: 012842c07552 (log: make '-msg timestamp=on' apply to all qemu_log usage)
> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/qemu/log.h |  7 +++++++
> >  util/log.c         | 49 ++++++++++++++++++++++++++--------------------
> >  2 files changed, 35 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/qemu/log.h b/include/qemu/log.h
> > index e9d3c6806b..95f417c2b7 100644
> > --- a/include/qemu/log.h
> > +++ b/include/qemu/log.h
> > @@ -69,6 +69,13 @@ bool qemu_log_separate(void);
> >   */
> >  FILE *qemu_log_trylock(void) G_GNUC_WARN_UNUSED_RESULT;
> >  
> > +/**
> > + * As qemu_log_trylock(), but will also print the message
> > + * context, if any is configured and this caused the
> > + * acquisition of the FILE lock
> > + */
> > +FILE *qemu_log_trylock_context(void) G_GNUC_WARN_UNUSED_RESULT;
> 
> This is used just once, in qemu_log().  Could be inlined into
> qemu_log().
> 
> If you prefer to keep it as a function, you could make it static.

The intent was that some, but not all, places which currently use
qemu_log_trylock() really ought to be including configured message
prefix, and hence would need to call this method. No such updates
of callers are done in this series though.

> I wouldn't guess that this prints from the function name.  Dunno,
> qemu_log_start_line()?  Might want to pair it with a qemu_log_end_line()
> then.
>
> Telling function name is less important if it's static.

Personally the inclusion of "log" in its filename is sufficiently
suggestive. I'll rename it to qemu_log_trylock_with_context
which is the name Richard originally requested.


> > diff --git a/util/log.c b/util/log.c
> > index c44d66b5ce..2ce7286f31 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -127,13 +127,39 @@ static FILE *qemu_log_trylock_with_err(Error **errp)
> 
> Not this patch's fault, but here goes anyway:
> 
>    static FILE *qemu_log_trylock_with_err(Error **errp)
>    {
>        FILE *logfile;
> 
>        logfile = thread_file;
>        if (!logfile) {
>            if (log_per_thread) {
>                g_autofree char *filename
>                    = g_strdup_printf(global_filename, log_thread_id());
>                logfile = fopen(filename, "w");
>                if (!logfile) {
>                    error_setg_errno(errp, errno,
>                                     "Error opening logfile %s for thread %d",
>                                     filename, log_thread_id());
>                    return NULL;
>                }
>                thread_file = logfile;
>                qemu_log_thread_cleanup_notifier.notify = qemu_log_thread_cleanup;
>                qemu_thread_atexit_add(&qemu_log_thread_cleanup_notifier);
>            } else {
>                rcu_read_lock();
>                /*
>                 * FIXME: typeof_strip_qual, as used by qatomic_rcu_read,
>                 * does not work with pointers to undefined structures,
>                 * such as we have with struct _IO_FILE and musl libc.
>                 * Since all we want is a read of a pointer, cast to void**,
>                 * which does work with typeof_strip_qual.
>                 */
>                logfile = qatomic_rcu_read((void **)&global_file);
>                if (!logfile) {
>                    rcu_read_unlock();
>                    return NULL;
> 
> Fails without setting @errp.

Trivial to fix, I'll include a patch for that in next posting.

> 
>                }
>            }
>        }
> 
>        qemu_flockfile(logfile);
> >      return logfile;
> >  }



> > +FILE *qemu_log_trylock_context(void)
> > +{
> > +    FILE *f = qemu_log_trylock();
> 
> This can fail, and if it does...
> 
> > +    if (log_depth == 1 && message_with_timestamp) {
> > +        g_autofree const char *timestr = NULL;
> > +        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> > +        timestr = g_date_time_format_iso8601(dt);
> > +        fprintf(f, "%s ", timestr);
> 
> ... we crash here.

Opps, yes will fix.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


