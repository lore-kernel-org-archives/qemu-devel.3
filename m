Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0592FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v140p-0008Bc-EQ; Tue, 23 Sep 2025 10:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v140o-0008Az-4V
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v140l-0001bX-KC
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758637734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnpNet/N0eOOuS1v935zhpn2HJ+vMI7D9yXcytwUTNc=;
 b=LffkKQ3kKkEicW7Fq9BcANE499ohBd7HdWd9765AmFl4+oOcTWEDtnoE5Fs+ezT1cYG6Fh
 5L3Iq4V3o3kMqmBMIsczra9Iw7op2P0uUqBXtIVWWhpdS4ZbFHszJd3AeAvMmex1Zkv+ZS
 gD5hGL69V8+SzGhTTvtGhvRI0vfB3dU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-am8CBa-lNHKqcl313N7Cag-1; Tue,
 23 Sep 2025 10:28:49 -0400
X-MC-Unique: am8CBa-lNHKqcl313N7Cag-1
X-Mimecast-MFC-AGG-ID: am8CBa-lNHKqcl313N7Cag_1758637727
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A98418002A0; Tue, 23 Sep 2025 14:28:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67A151955F21; Tue, 23 Sep 2025 14:28:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9910121E6A27; Tue, 23 Sep 2025 16:28:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 08/20] log: avoid repeated prefix on incremental
 qemu_log calls
In-Reply-To: <20250910180357.320297-9-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:45
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-9-berrange@redhat.com>
Date: Tue, 23 Sep 2025 16:28:42 +0200
Message-ID: <87plbh8cpx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Some code makes multiple qemu_log calls to incrementally emit
> a single message. Currently timestamps get prepended to all
> qemu_log calls, even those continuing a previous incomplete
> message.
>
> This changes the qemu_log so it skips adding a new line prefix,
> if the previous qemu_log call did NOT end with a newline.
>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

This patch has kept nagging me in the back of my brain.  So I'm back for
a second look.

> ---
>  util/log.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/util/log.c b/util/log.c
> index abdcb6b311..2642a55c59 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -143,6 +143,12 @@ void qemu_log_unlock(FILE *logfile)
>      }
>  }
>=20=20
> +/*
> + * 'true' if the previous log message lacked a trailing '\n',
> + * and thus the subsequent call must skip any prefix
> + */
> +static __thread bool incomplete;
> +
>  void qemu_log(const char *fmt, ...)
>  {
>      FILE *f;
> @@ -154,7 +160,7 @@ void qemu_log(const char *fmt, ...)
>       * was emitted if we are delayed acquiring the
>       * mutex
>       */
> -    if (message_with_timestamp) {
> +    if (message_with_timestamp && !incomplete) {
>          g_autoptr(GDateTime) dt =3D g_date_time_new_now_utc();
>          timestr =3D g_date_time_format_iso8601(dt);
>      }
> @@ -170,6 +176,7 @@ void qemu_log(const char *fmt, ...)
       f =3D qemu_log_trylock();
       if (f) {
           va_list ap;

           if (timestr) {
               fprintf(f, "%s ", timestr);
           }

>          va_start(ap, fmt);
>          vfprintf(f, fmt, ap);
>          va_end(ap);
> +        incomplete =3D fmt[strlen(fmt) - 1] !=3D '\n';
>          qemu_log_unlock(f);
>      }
>  }

Two cases:

(A) Single log

    qemu_log_trylock() returns @global_file, and uses RCU to ensure it
    remains valid until qemu_log_unlock().  I think.

(B) Log split per thread (-d tid)

    qemu_log_trylock() returns thread-local @thread_file.

In addition, qemu_log_trylock() locks the FILE it returns with
flockfile(), so no other thread can write to it until qemu_log_unlock()
unlocks it with funlockfile().  This ensures the entire output of in
between stays together.

Let's see how this plays with @incomplete.

(B) Log split per thread (-d tid)

    @incomplete is thread-local.  It records wether the last qemu_log()
    in this thread was an incomplete line.  If it was, the next
    qemu_log() continues the line.  Unless something else wrote to
    @thread_file in between, but that's not supposed to happen.  Good.

(A) Single log

    All thread log to the same FILE.  Consider:

    1. Thread 1 starts.  Its @incomplete is initialized to false.

    2. Thread 2 starts.  Its @incomplete is initialized to false.

    3. Thread 1 logs "abra".  Its @incomplete is set to true.

    4. Thread 2 logs "interrupt\n".  Its @incomplete remains false.

    5. Thread 2 logs "cadbra\n".  Its @incomplete goes back to false.

    Resulting log file contents:

        PREFIX "abra" PREFIX "interrupt\n"
        "cadabra\n"

    Not good.

We could complicate this code further to mitigate.  For instance, we
could use a thread-local @incomplete for (B), and a global one for (A).
This ensures log lines start with PREFIX as they should, but does
nothing to avoid mixing up line parts from different threads.  My
example would then produce

        PREFIX "abrainterrupt\n"
        PREFIX "cababra\n"

My take: "Doctor, it hurts when I do that!"  "Don't do that then."
Logging incomplete lines with qemu_log() can hurt.  Don't do that then.


