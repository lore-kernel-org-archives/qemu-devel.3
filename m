Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB2FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fTa-0001ld-QO; Mon, 22 Sep 2025 08:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0fTP-0001iA-DE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0fTL-0002Ul-MS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758543405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYsXQZJMLDculF/W/t4gCe2Ldg9AHRWejFoAC4H5/n4=;
 b=ijkMnBInKrZcBdMvCS3+jB6AvFOMnyhJz2vVOc3OrN81g45phRzkC6DAn/NFDUFGToqHz0
 yF8mh3AZH55OOZGIz8nnYRt3LDw316fE1BGde31i1N17nUaqQpPkLwmo8lvMzSXzjZF38n
 2o1OPh4GTXacFKkfLbGoWJ0ikJOudzc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-2G5XGVI9O3KCL7WSFHy2Qg-1; Mon,
 22 Sep 2025 08:16:41 -0400
X-MC-Unique: 2G5XGVI9O3KCL7WSFHy2Qg-1
X-Mimecast-MFC-AGG-ID: 2G5XGVI9O3KCL7WSFHy2Qg_1758543400
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C64C01956096; Mon, 22 Sep 2025 12:16:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B38C19560BB; Mon, 22 Sep 2025 12:16:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E590C21E6A27; Mon, 22 Sep 2025 14:16:35 +0200 (CEST)
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
Subject: Re: [PATCH v3 14/20] util: fix interleaving of error & trace output
In-Reply-To: <20250910180357.320297-15-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:51
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-15-berrange@redhat.com>
Date: Mon, 22 Sep 2025 14:16:35 +0200
Message-ID: <87v7lak7h8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> The monitor_cur_hmp() function will acquire/release mutex locks, which
> will trigger trace probes, which can in turn trigger qemu_log() calls.
> vreport() calls monitor_cur() multiple times through its execution
> both directly and indirectly via error_vprintf().

This issue goes back to commit e69ee454b5f9 (monitor: Make current
monitor a per-coroutine property).  I've always disliked the hash table
(which is why we need to take the mutex), and now I dislike it even
more.  See also my review of PATCH 02.

I'd love to have a lockless monitor_cur() again.  But I don't have one
up my sleeve, so we need to work around the issue somehow.

> The result is that the prefix information printed by vreport() gets
> interleaved with qemu_log() output, when run outside the context of
> an HMP command dispatcher. This can be seen with:

[...]

> To avoid this interleaving (as well as reduce the huge number of
> mutex lock/unlock calls) we need to ensure that monitor_cur_hmp() is
> only called once at the start of vreport(), and if no HMP is present,
> no further monitor APIs can be called.
>
> This implies error_[v]printf() cannot be called from vreport().
>
> Instead a decision about whether output will go to monitor_[v]printf()
> or fprintf() must be made upfront, and then those functions called
> directly.
>
>  $ qemu-system-x86_64
>      -msg timestamp=3Don,guest-name=3Don
>      -display none
>      -object tls-creds-x509,id=3Df,dir=3Dfish
>      -name fish
>      -d trace:qemu_mutex*
>    2025-09-10T16:31:22.701691Z qemu_mutex_unlock released mutex 0x5626fd3=
b84c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:31:22.701728Z qemu_mutex_lock waiting on mutex 0x5626fd3=
b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:31:22.701730Z qemu_mutex_locked taken mutex 0x5626fd3b53=
e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:31:22.701732Z qemu_mutex_unlock released mutex 0x5626fd3=
b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:31:22.703989Z qemu_mutex_lock waiting on mutex 0x5626fd3=
b5560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:22.703996Z qemu_mutex_locked taken mutex 0x5626fd3b55=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:22.703999Z qemu_mutex_unlock released mutex 0x5626fd3=
b5560 (../monitor/monitor.c:96)
>    2025-09-10T16:31:22.704000Z fish qemu-system-x86_64: Unable to access =
credentials fish/ca-cert.pem: No such file or directory
>
> This change requires adding a stub for monitor_printf() since that
> is now called directly by vreport(), where monitor_vprintf() was
> only needed previously.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  stubs/monitor-core.c           |  5 +++
>  tests/unit/test-util-sockets.c |  1 +
>  util/error-report.c            | 60 ++++++++++++++++++++++++----------
>  3 files changed, 48 insertions(+), 18 deletions(-)
>
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index 1e0b11ec29..70b1f7a994 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -30,3 +30,8 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_l=
ist ap)
>  {
>      abort();
>  }
> +
> +int monitor_printf(Monitor *mon, const char *fmt, ...)
> +{
> +    abort();
> +}
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-socket=
s.c
> index d40813c682..53733163dd 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -76,6 +76,7 @@ Monitor *monitor_cur_hmp(void) { return cur_mon; }
>  bool monitor_cur_is_qmp(void) { return false; }
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort()=
; }
> +int monitor_printf(Monitor *mon, const char *fmt, ...) { abort(); }
>=20=20
>  #ifndef _WIN32
>  static void test_socket_fd_pass_name_good(void)
> diff --git a/util/error-report.c b/util/error-report.c
> index c0fcf388de..6c887047e3 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -29,6 +29,9 @@ bool message_with_timestamp;
>  bool error_with_guestname;
>  const char *error_guest_name;
>=20=20
> +typedef void (*error_print_func)(void *opaque, const char *fmt, ...);
> +typedef void (*error_print_vfunc)(void *opaque, const char *fmt, va_list=
 ap);
> +
>  /*
>   * Print to current monitor if we have one, else to stderr.
>   */
> @@ -151,34 +154,34 @@ void loc_set_file(const char *fname, int lno)
>  /*
>   * Print current location to current monitor if we have one, else to std=
err.
>   */
> -static void print_loc(void)
> +static void print_loc(bool cur, error_print_func print_func, void *print=
_opaque)
>  {
>      const char *sep =3D "";
>      int i;
>      const char *const *argp;
>=20=20
> -    if (!monitor_cur_hmp() && g_get_prgname()) {
> -        error_printf("%s:", g_get_prgname());
> +    if (!cur && g_get_prgname()) {
> +        print_func(print_opaque, "%s:", g_get_prgname());
>          sep =3D " ";
>      }
>      switch (cur_loc->kind) {
>      case LOC_CMDLINE:
>          argp =3D cur_loc->ptr;
>          for (i =3D 0; i < cur_loc->num; i++) {
> -            error_printf("%s%s", sep, argp[i]);
> +            print_func(print_opaque, "%s%s", sep, argp[i]);
>              sep =3D " ";
>          }
> -        error_printf(": ");
> +        print_func(print_opaque, ": ");
>          break;
>      case LOC_FILE:
> -        error_printf("%s:", (const char *)cur_loc->ptr);
> +        print_func(print_opaque, "%s:", (const char *)cur_loc->ptr);
>          if (cur_loc->num) {
> -            error_printf("%d:", cur_loc->num);
> +            print_func(print_opaque, "%d:", cur_loc->num);
>          }
> -        error_printf(" ");
> +        print_func(print_opaque, " ");
>          break;
>      default:
> -        error_printf("%s", sep);
> +        print_func(print_opaque, "%s", sep);
>      }
>  }
>=20=20
> @@ -199,34 +202,55 @@ real_time_iso8601(void)
>  G_GNUC_PRINTF(2, 0)
>  static void vreport(report_type type, const char *fmt, va_list ap)
>  {
> +    /*
> +     * Calling monitor_cur_hmp() will acquire/release mutexes,
> +     * which triggers trace probes, which can trigger
> +     * qemu_log calls, which would interleave with output
> +     * from this. Hence cache the monitor handle upfront
> +     * so any tracing appears before we start outputting.
> +     */
> +    Monitor *cur =3D monitor_cur_hmp();
> +    error_print_func print_func;
> +    error_print_vfunc print_vfunc;
> +    void *print_opaque;
>      gchar *timestr;
>=20=20
> -    if (message_with_timestamp && !monitor_cur_hmp()) {
> +    if (cur) {
> +        print_func =3D (error_print_func)monitor_printf;
> +        print_vfunc =3D (error_print_vfunc)monitor_vprintf;
> +        print_opaque =3D cur;
> +    } else {
> +        print_func =3D (error_print_func)fprintf;
> +        print_vfunc =3D (error_print_vfunc)vfprintf;
> +        print_opaque =3D stderr;
> +    }

print_func is is void (*)(void *, const char *, ...).

monitor_printf() is int (*)(Monitor *, const char *, ...).

fprintf() is int (*)(FILE *, const char *, ...)

ISO/IEC 9899:1999 =C2=A76.3.2.3 Pointers:

       [#8] A pointer to a function of one type may be converted to
       a pointer to a function of another type and back again;  the
       result  shall  compare  equal to the original pointer.  If a
       converted pointer is used to call a function whose  type  is
       not  compatible  with  the  pointed-to type, the behavior is
       undefined.

For this to work in practice, three conditions need to hold:

1. Both Monitor * and FILE * arguments are passed exactly like void *
arguments.  Holds on sane machines.

2. A function returning void is called the same way as a function
returning int when the value is ignored.  Holds on sane machines.  We
can easily eliminate this condition: just change print_func from void to
int.

3. The guys writing the compiler refrain from making use of their
self-granted license to ruin our day because our program has undefined
behavior.  Since improving some SPEC benchmark by half a percent is
clearly worth breaking any number of working programs, ...

If we want to stay out of this swamp, we need to define wrapper
functions taking void * and returning it.

> +
> +    if (message_with_timestamp && !cur) {
>          timestr =3D real_time_iso8601();
> -        error_printf("%s ", timestr);
> +        print_func(print_opaque, "%s ", timestr);
>          g_free(timestr);
>      }
>=20=20
>      /* Only prepend guest name if -msg guest-name and -name guest=3D... =
are set */
> -    if (error_with_guestname && error_guest_name && !monitor_cur_hmp()) {
> -        error_printf("%s ", error_guest_name);
> +    if (error_with_guestname && error_guest_name && !cur) {
> +        print_func(print_opaque, "%s ", error_guest_name);
>      }
>=20=20
> -    print_loc();
> +    print_loc(!!cur, print_func, print_opaque);
>=20=20
>      switch (type) {
>      case REPORT_TYPE_ERROR:
>          break;
>      case REPORT_TYPE_WARNING:
> -        error_printf("warning: ");
> +        print_func(print_opaque, "warning: ");
>          break;
>      case REPORT_TYPE_INFO:
> -        error_printf("info: ");
> +        print_func(print_opaque, "info: ");
>          break;
>      }
>=20=20
> -    error_vprintf(fmt, ap);
> -    error_printf("\n");
> +    print_vfunc(print_opaque, fmt, ap);
> +    print_func(print_opaque, "\n");
>  }
>=20=20
>  /*

The code becomes more complicated.  Hmm.

As long as monitor_cur() hits trace points, we really want to call it
just once, before we start printing the error message.

Calls during vreport() (in master, because I can't be bothered to
recompile):

(1) At the beginning of vreport().  Fine.

(2) In the middle of vreport().  Easy to avoid: reuse the value gotten
at (1).

(3) In print_loc().  Easy to avoid: called only by vreport(), so pass
the value gotten at (1).

(4) In error_vprintf(), called multiple times from vreport() and
print_loc() directly and via error_printf().  Obvious, stupid solution:
have error_vprintf() and error_printf() take a Monitor *argument.  But
that's no good, because we have numerous callers, and we'd rather not
change these to pass monitor_cur().  So create two new functions, and
make the existing ones wrap around them.

Thoughts?


