Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2CFE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsf4O-0000aF-RR; Wed, 18 Feb 2026 05:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsf4E-0000V1-7y
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsf4C-0002vD-QD
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771411559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2chEJDZ5xJ6PccoIYSFNEnyoWpD1sEsWa9LcVH12gpw=;
 b=ScaN+cWkR6DeTL3EM7GEYkucd5E4oFjxZbppliteRgaT0TJZ3wC3jrsrLZW+nuXQbYJWdl
 sYnBGGlE10MMbM3yTavSLBuNGsycpHJwPIuMEAc4ddqzbHmPH+FJ8spXkRWPgK3FEibiV/
 3yx0sIyFNGqyhuINexMwRk4W21gSCCU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-PAT0JQpmNDKygG-J__wV-Q-1; Wed,
 18 Feb 2026 05:45:55 -0500
X-MC-Unique: PAT0JQpmNDKygG-J__wV-Q-1
X-Mimecast-MFC-AGG-ID: PAT0JQpmNDKygG-J__wV-Q_1771411553
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB271956067; Wed, 18 Feb 2026 10:45:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97ACF180058B; Wed, 18 Feb 2026 10:45:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37C3C21E692D; Wed, 18 Feb 2026 11:45:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  devel@lists.libvirt.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 13/27] util/log: add missing error reporting in
 qemu_log_trylock_with_err
In-Reply-To: <20260211152508.732487-14-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:24:54
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-14-berrange@redhat.com>
Date: Wed, 18 Feb 2026 11:45:50 +0100
Message-ID: <878qcqe3dt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> One codepath that could return NULL failed to populate the errp
> object.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/log.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/log.c b/util/log.c
> index 1644e6814b..1c9c7adb2d 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -118,6 +118,7 @@ static FILE *qemu_log_trylock_with_err(Error **errp)
   static FILE *qemu_log_trylock_with_err(Error **errp)
   {
       FILE *logfile;

       logfile =3D thread_file;
       if (!logfile) {

Slow path: no log file cached for this thread.

           if (log_per_thread) {

We're logging to per-thread log files.  @global_filename is a file name
pattern; derive this thread's log file from it.

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

Logging to a single log file.  Fetch it from @global_file.

               rcu_read_lock();
               /*
                * FIXME: typeof_strip_qual, as used by qatomic_rcu_read,
                * does not work with pointers to undefined structures,
                * such as we have with struct _IO_FILE and musl libc.
                * Since all we want is a read of a pointer, cast to void**,
                * which does work with typeof_strip_qual.
                */
>              logfile =3D qatomic_rcu_read((void **)&global_file);
>              if (!logfile) {

@global_file was null when we fetched it.

It can be null when @daemonized and the user didn't set a log file.

>                  rcu_read_unlock();
> +                error_setg(errp, "Global log file output is not open");

Impact?  The only callers passing non-null @errp is
qemu_set_log_internal(), and it can call only when @log_per_thread.  We
can't reach the new error then.

So this is just a latent bug.  Worth mentioning in the commit message?

>                  return NULL;
>              }

We do not set thread_file.  We'll take the slow path again.  Harmless
enough, but its a bit at odds with how the code is structured here.
Observation, not a demand.

>          }
       }

       qemu_flockfile(logfile);
       return logfile;
   }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


