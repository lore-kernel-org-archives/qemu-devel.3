Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F92C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 08:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue8M0-00027y-RK; Tue, 22 Jul 2025 04:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ue8LQ-0001rb-GS
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 04:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ue8LO-000532-6j
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 04:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753172841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0xiDH8hv89FBL1aZAQj0fqwDUgAsrN+DRO7C0SAW8o=;
 b=K5hcq4gDqXmL6bfAu4Y2wW3MsbBmzTyzOpE+DBkkgekyPF1U37VWjotsVzJtkYdP/qSmCa
 a71T4H2QZiXMoIfwVe8tKphYF3FeYh36CHulawnVkt2rhn/4uQZD6yO0bS4q5UcJhaSvvk
 64WqSVTFqWTU84AOk2hHytP84gBG3WA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Ga8hweSbNgeKtcyjxR1rRg-1; Tue,
 22 Jul 2025 04:27:17 -0400
X-MC-Unique: Ga8hweSbNgeKtcyjxR1rRg-1
X-Mimecast-MFC-AGG-ID: Ga8hweSbNgeKtcyjxR1rRg_1753172836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB5E195FE16; Tue, 22 Jul 2025 08:27:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74739195608D; Tue, 22 Jul 2025 08:27:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCD1D21E6A27; Tue, 22 Jul 2025 10:27:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH] log: make '-msg timestamp=on' apply to all qemu_log usage
In-Reply-To: <20250721185452.3016488-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 21 Jul 2025 19:54:52
 +0100")
References: <20250721185452.3016488-1-berrange@redhat.com>
Date: Tue, 22 Jul 2025 10:27:12 +0200
Message-ID: <87cy9sy6jj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Currently the tracing 'log' back emits special code to add timestamps
> to trace points sent via qemu_log(). This current impl is a bad design
> for a number of reasons.
>
>  * It changes the QEMU headers, such that 'error-report.h' content
>    is visible to all files using tracing, but only when the 'log'
>    backend is enabled. This has led to build failure bugs as devs
>    rarely test without the (default) 'log' backend enabled, and
>    CI can't cover every scenario for every trace backend.
>
>  * It bloats the trace points definitions which are inlined into
>    every probe location due to repeated inlining of timestamp
>    formatting code, adding MBs of overhead to QEMU.
>
>  * The tracing subsystem should not be treated any differently
>    from other users of qemu_log. They all would benefit from
>    having timestamps present.
>
>  * The timestamp emitted with the tracepoints is in a needlessly
>    different format to that used by error_report() in response
>    to '-msg timestamp=3Don'.
>
> This fixes all these issues simply by moving timestamp formatting
> into qemu_log, using the same approach as for error_report.
>
> The code before:
>
>   static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * cr=
eds, const char * filename, const char * path)
>   {
>       if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu=
_loglevel_mask(LOG_TRACE)) {
>           if (message_with_timestamp) {
>               struct timeval _now;
>               gettimeofday(&_now, NULL);
>               qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS cr=
eds path creds=3D%p filename=3D%s path=3D%s" "\n",
>                        qemu_get_thread_id(),
>                        (size_t)_now.tv_sec, (size_t)_now.tv_usec
>                        , creds, filename, path);
>           } else {
>               qemu_log("qcrypto_tls_creds_get_path " "TLS creds path cred=
s=3D%p filename=3D%s path=3D%s" "\n", creds, filename, path);
>           }
>       }
>   }
>
> and after:
>
>   static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * cr=
eds, const char * filename, const char * path)
>   {
>       if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu=
_loglevel_mask(LOG_TRACE)) {
>           qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=3D=
%p filename=3D%s path=3D%s" "\n", creds, filename, path);
>       }
>   }
>
> The log and error messages before:
>
>   $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=3Dtls0,d=
ir=3D$HOME/tls -msg timestamp=3Don
>   2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 lo=
ad creds=3D0x55d925bd9490 dir=3D/var/home/berrange/tls
>   2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path cre=
ds=3D0x55d925bd9490 filename=3Dca-cert.pem path=3D<none>
>   2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access creden=
tials /var/home/berrange/tls/ca-cert.pem: No such file or directory
>
> and after:
>
>   $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=3Dtls0,d=
ir=3D$HOME/tls -msg timestamp=3Don
>   2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 =
load creds=3D0x55bf5bf12380 dir=3D/var/home/berrange/tls
>   2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path c=
reds=3D0x55bf5bf12380 filename=3Dca-cert.pem path=3D<none>
>   2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access creden=
tials /var/home/berrange/tls/ca-cert.pem: No such file or directory
>
> The binary size before:
>
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
>   $ strip qemu-system-x86_64
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64
>
> and after:
>
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
>   $ strip qemu-system-x86_64
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/tracetool/backend/log.py | 14 +-------------
>  util/log.c                       | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index 17ba1cd90e..bd6739ae41 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -20,7 +20,6 @@
>=20=20
>  def generate_h_begin(events, group):
>      out('#include "qemu/log-for-trace.h"',
> -        '#include "qemu/error-report.h"',
>          '')
>=20=20
>=20=20
> @@ -36,20 +35,9 @@ def generate_h(event, group):
>          cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
>=20=20
>      out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> -        '        if (message_with_timestamp) {',
> -        '            struct timeval _now;',
> -        '            gettimeofday(&_now, NULL);',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",=
',
> -        '                     qemu_get_thread_id(),',
> -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> -        '                     %(argnames)s);',
> +        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        } else {',
> -        '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
> -        '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        }',
>          '    }',
>          cond=3Dcond,
>          event_lineno=3Devent.lineno,
> diff --git a/util/log.c b/util/log.c
> index 58d24de48a..abdcb6b311 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -145,10 +145,28 @@ void qemu_log_unlock(FILE *logfile)
>=20=20
>  void qemu_log(const char *fmt, ...)
>  {
> -    FILE *f =3D qemu_log_trylock();
> +    FILE *f;
> +    g_autofree const char *timestr =3D NULL;
> +
> +    /*
> +     * Prepare the timestamp *outside* the logging
> +     * lock so it better reflects when the message
> +     * was emitted if we are delayed acquiring the
> +     * mutex
> +     */
> +    if (message_with_timestamp) {
> +        g_autoptr(GDateTime) dt =3D g_date_time_new_now_utc();
> +        timestr =3D g_date_time_format_iso8601(dt);
> +    }

Duplicates real_time_iso8601() from error-report.c.  Tolerable.

> +
> +    f =3D qemu_log_trylock();
>      if (f) {
>          va_list ap;
>=20=20
> +        if (timestr) {
> +            fprintf(f, "%s ", timestr);
> +        }
> +
>          va_start(ap, fmt);
>          vfprintf(f, fmt, ap);
>          va_end(ap);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


