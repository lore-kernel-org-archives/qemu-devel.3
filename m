Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B176C9EC9D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbUp-0000SE-30; Tue, 13 Jan 2026 05:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfbUi-0000Mi-M0
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:19:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfbUg-0000zx-9U
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768299560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7xhkILgIoQhxPiu+UT3981CPmnY2WGzO8z4JIZhcik=;
 b=OPWOeXlQkcLWyvTNCvslMxfmTrT0SXG8fZX3dh4zgE5488Ifiigj5Cx0M8mkwIR2Hl3yhz
 DkheO39TKQgnkoWBfhqHkrr2xPd54BQdtv2TueTcjaJPy5DL87rtG9sbOC9bPqvVLpiZhW
 l2GZ/1DNdvORaAlhHaOqKeB9g1Amt6E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-mq8SLJJxNqiz_zmfzMzKKQ-1; Tue,
 13 Jan 2026 05:19:18 -0500
X-MC-Unique: mq8SLJJxNqiz_zmfzMzKKQ-1
X-Mimecast-MFC-AGG-ID: mq8SLJJxNqiz_zmfzMzKKQ_1768299557
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5BE419560AA; Tue, 13 Jan 2026 10:19:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B02C719560B2; Tue, 13 Jan 2026 10:19:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4941221E676C; Tue, 13 Jan 2026 11:19:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  devel@lists.libvirt.org,
 qemu-block@nongnu.org,  qemu-rust@nongnu.org,  Stefan Weil
 <sw@weilnetz.de>,  Kevin Wolf <kwolf@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 10/24] util: avoid repeated prefix on incremental
 qemu_log calls
In-Reply-To: <20260108170338.2693853-11-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:24
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-11-berrange@redhat.com>
Date: Tue, 13 Jan 2026 11:19:13 +0100
Message-ID: <87h5spak7y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> There are three general patterns to QEMU log output
>
>  1. Single complete message calls
>
>       qemu_log("Some message\n");
>
>  2. Direct use of fprintf
>
>       FILE *f =3D qemu_log_trylock()
>       fprintf(f, "...");
>       fprintf(f, "...");
>       fprintf(f, "...\n");
>       qemu_log_unlock(f)
>
>  3. Mixed use of qemu_log_trylock/qemu_log()
>
>       FILE *f =3D qemu_log_trylock()
>       qemu_log("....");
>       qemu_log("....");
>       qemu_log("....\n");
>       qemu_log_unlock(f)
>
> When message prefixes are enabled, the timestamp will be
> unconditionally emitted for all qemu_log() calls. This
> works fine in the 1st case, and has no effect in the 2nd
> case. In the 3rd case, however, we get the timestamp
> printed over & over in each fragment.
>
> One can suggest that pattern (3) is pointless as it is
> functionally identical to (2) but with extra indirection
> and overhead. None the less we have a fair bit of code
> that does this.
>
> The qemu_log() call itself is nothing more than a wrapper
> which does pattern (2) with a single fprintf() call.
>
> One might question whether (2) should include the message
> prefix in the same way that (1), but there are scenarios
> where this could be inappropriate / unhelpful such as the
> CPU register dumps or linux-user strace output.
>
> This patch fixes the problem in pattern (3) by keeping
> track of the call depth of qemu_log_trylock() and then
> only emitting the the prefix when the starting depth
> was zero. In doing this qemu_log_trylock_context() is
> also introduced as a variant of qemu_log_trylock()
> that emits the prefix. Callers doing to batch output
> can thus choose whether a prefix is appropriate or
> not.

I dislike pattern (3), but not nearly enough to chase it out of the tree
myself.  Hard to disagree with this patch then :)

> Fixes: 012842c07552 (log: make '-msg timestamp=3Don' apply to all qemu_lo=
g usage)
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/log.h |  7 +++++++
>  util/log.c         | 49 ++++++++++++++++++++++++++--------------------
>  2 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index e9d3c6806b..95f417c2b7 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -69,6 +69,13 @@ bool qemu_log_separate(void);
>   */
>  FILE *qemu_log_trylock(void) G_GNUC_WARN_UNUSED_RESULT;
>=20=20
> +/**
> + * As qemu_log_trylock(), but will also print the message
> + * context, if any is configured and this caused the
> + * acquisition of the FILE lock
> + */
> +FILE *qemu_log_trylock_context(void) G_GNUC_WARN_UNUSED_RESULT;

This is used just once, in qemu_log().  Could be inlined into
qemu_log().

If you prefer to keep it as a function, you could make it static.

I wouldn't guess that this prints from the function name.  Dunno,
qemu_log_start_line()?  Might want to pair it with a qemu_log_end_line()
then.

Telling function name is less important if it's static.

> +
>  /**
>   * Releases the lock on the log output, previously
>   * acquired by qemu_log_trylock().
> diff --git a/util/log.c b/util/log.c
> index c44d66b5ce..2ce7286f31 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -127,13 +127,39 @@ static FILE *qemu_log_trylock_with_err(Error **errp)

Not this patch's fault, but here goes anyway:

   static FILE *qemu_log_trylock_with_err(Error **errp)
   {
       FILE *logfile;

       logfile =3D thread_file;
       if (!logfile) {
           if (log_per_thread) {
               g_autofree char *filename
                   =3D g_strdup_printf(global_filename, log_thread_id());
               logfile =3D fopen(filename, "w");
               if (!logfile) {
                   error_setg_errno(errp, errno,
                                    "Error opening logfile %s for thread %d=
",
                                    filename, log_thread_id());
                   return NULL;
               }
               thread_file =3D logfile;
               qemu_log_thread_cleanup_notifier.notify =3D qemu_log_thread_=
cleanup;
               qemu_thread_atexit_add(&qemu_log_thread_cleanup_notifier);
           } else {
               rcu_read_lock();
               /*
                * FIXME: typeof_strip_qual, as used by qatomic_rcu_read,
                * does not work with pointers to undefined structures,
                * such as we have with struct _IO_FILE and musl libc.
                * Since all we want is a read of a pointer, cast to void**,
                * which does work with typeof_strip_qual.
                */
               logfile =3D qatomic_rcu_read((void **)&global_file);
               if (!logfile) {
                   rcu_read_unlock();
                   return NULL;

Fails without setting @errp.

               }
           }
       }

       qemu_flockfile(logfile);
>      return logfile;
>  }
>=20=20
> +/*
> + * Zero if there's been no opening qemu_log_trylock call,
> + * indicating the need for message context to be emitted
> + *
> + * Non-zero if we're in the middle of printing a message,
> + * possibly over multiple lines and must skip further
> + * message context
> + */
> +static __thread uint log_depth;
> +
>  FILE *qemu_log_trylock(void)
>  {
> -    return qemu_log_trylock_with_err(NULL);
> +    FILE *f =3D qemu_log_trylock_with_err(NULL);
> +    log_depth++;
> +    return f;
> +}
> +
> +FILE *qemu_log_trylock_context(void)
> +{
> +    FILE *f =3D qemu_log_trylock();

This can fail, and if it does...

> +    if (log_depth =3D=3D 1 && message_with_timestamp) {
> +        g_autofree const char *timestr =3D NULL;
> +        g_autoptr(GDateTime) dt =3D g_date_time_new_now_utc();
> +        timestr =3D g_date_time_format_iso8601(dt);
> +        fprintf(f, "%s ", timestr);

... we crash here.

> +    }
> +    return f;
>  }
>=20=20
>  void qemu_log_unlock(FILE *logfile)
>  {
> +    assert(log_depth);
> +    log_depth--;
>      if (logfile) {
>          fflush(logfile);
>          qemu_funlockfile(logfile);
> @@ -145,28 +171,9 @@ void qemu_log_unlock(FILE *logfile)
>=20=20
>  void qemu_log(const char *fmt, ...)
>  {
> -    FILE *f;
> -    g_autofree const char *timestr =3D NULL;
> -
> -    /*
> -     * Prepare the timestamp *outside* the logging
> -     * lock so it better reflects when the message
> -     * was emitted if we are delayed acquiring the
> -     * mutex
> -     */
> -    if (message_with_timestamp) {
> -        g_autoptr(GDateTime) dt =3D g_date_time_new_now_utc();
> -        timestr =3D g_date_time_format_iso8601(dt);
> -    }
> -
> -    f =3D qemu_log_trylock();
> +    FILE *f =3D qemu_log_trylock_context();
>      if (f) {
>          va_list ap;
> -
> -        if (timestr) {
> -            fprintf(f, "%s ", timestr);
> -        }
> -
>          va_start(ap, fmt);
>          vfprintf(f, fmt, ap);
>          va_end(ap);


