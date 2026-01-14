Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4A1D2A01A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0Ud-000767-1k; Wed, 14 Jan 2026 08:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0UV-000723-MH
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0UT-0004T0-Ow
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768395649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mU+sDDwabNoFz6mM0jvwgmYqz2ZD0GuEAIbrjRwxeog=;
 b=N2GqWZ0BTg3lu2+9YixrgjAPjHF7/WCftTrc0lzJ/+R7vAMLRBFk85ZF6JvSMdcEuBZNem
 ZX8X3GpciyO9DQK+zhTmhW/A5yhpOGEe9Vaittx0uX3qLYMAEB3DOxcW4XWnM56jFD/2oE
 HXZdEbPN1NV+Bbvx2nlstdPdfs4DdSA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-mC6IrrukP7av2MSDAYgeUQ-1; Wed,
 14 Jan 2026 08:00:47 -0500
X-MC-Unique: mC6IrrukP7av2MSDAYgeUQ-1
X-Mimecast-MFC-AGG-ID: mC6IrrukP7av2MSDAYgeUQ_1768395645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 511401954B0B; Wed, 14 Jan 2026 13:00:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68BE21800285; Wed, 14 Jan 2026 13:00:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0EFA21E692D; Wed, 14 Jan 2026 14:00:41 +0100 (CET)
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
Subject: Re: [PATCH v5 17/24] util: fix interleaving of error & trace output
In-Reply-To: <20260108170338.2693853-18-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:31
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-18-berrange@redhat.com>
Date: Wed, 14 Jan 2026 14:00:41 +0100
Message-ID: <87a4yg2vt2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The monitor_cur_hmp() function will acquire/release mutex locks, which
> will trigger trace probes, which can in turn trigger qemu_log() calls.
> vreport() calls monitor_cur() multiple times through its execution
> both directly and indirectly via error_vprintf().
>
> The result is that the prefix information printed by vreport() gets
> interleaved with qemu_log() output, when run outside the context of
> an HMP command dispatcher. This can be seen with:
>
>  $ qemu-system-x86_64 \
>      -msg timestamp=3Don,guest-name=3Don \
>      -display none \
>      -object tls-creds-x509,id=3Df,dir=3Dfish \
>      -name fish \
>      -d trace:qemu_mutex*
>    2025-09-10T16:30:42.514374Z qemu_mutex_unlock released mutex 0x560b033=
9b4c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:30:42.514400Z qemu_mutex_lock waiting on mutex 0x560b033=
983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:30:42.514402Z qemu_mutex_locked taken mutex 0x560b033983=
e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:30:42.514404Z qemu_mutex_unlock released mutex 0x560b033=
983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>    2025-09-10T16:30:42.516716Z qemu_mutex_lock waiting on mutex 0x560b033=
98560 (../monitor/monitor.c:91)
>    2025-09-10T16:30:42.516723Z qemu_mutex_locked taken mutex 0x560b033985=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:30:42.516726Z qemu_mutex_unlock released mutex 0x560b033=
98560 (../monitor/monitor.c:96)
>    2025-09-10T16:30:42.516728Z qemu_mutex_lock waiting on mutex 0x560b033=
98560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842057Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842058Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>    2025-09-10T16:31:04.842055Z 2025-09-10T16:31:04.842060Z qemu_mutex_loc=
k waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842061Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842062Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>    2025-09-10T16:31:04.842064Z qemu_mutex_lock waiting on mutex 0x564f5e4=
01560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842065Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842066Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>    fish 2025-09-10T16:31:04.842068Z qemu_mutex_lock waiting on mutex 0x56=
4f5e401560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842069Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842070Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>    2025-09-10T16:31:04.842072Z qemu_mutex_lock waiting on mutex 0x564f5e4=
01560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842097Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842099Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>    qemu-system-x86_64:2025-09-10T16:31:04.842100Z qemu_mutex_lock waiting=
 on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842102Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842103Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:04.842105Z qemu_mutex_lock waiting on mutex 0x564f5e=
401560 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842106Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842107Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>    Unable to access credentials fish/ca-cert.pem: No such file or directo=
ry2025-09-10T16:31:04.842109Z qemu_mutex_lock waiting on mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842110Z qemu_mutex_locked taken mutex 0x564f5e4015=
60 (../monitor/monitor.c:91)
>    2025-09-10T16:31:04.842111Z qemu_mutex_unlock released mutex 0x564f5e4=
01560 (../monitor/monitor.c:96)
>
> To avoid this interleaving (as well as reduce the huge number of
> mutex lock/unlock calls) we need to ensure that monitor_cur_is_hmp()
> is only called once at the start of vreport(), and if no HMP is
> present, no further monitor APIs can be called.
>
> This implies error_[v]printf() cannot be called from vreport().
> Instead we must introduce error_[v]printf_mon() which accept a
> pre-acquired Monitor object. In some cases, however, fprintf
> can be called directly as output will never be directed to the
> monitor.
>
>  $ qemu-system-x86_64 \
>      -msg timestamp=3Don,guest-name=3Don \
>      -display none \
>      -object tls-creds-x509,id=3Df,dir=3Dfish \
>      -name fish \
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
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/error-report.c | 67 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 21 deletions(-)
>
> diff --git a/util/error-report.c b/util/error-report.c
> index 872158ad90..14b170ca4c 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -29,9 +29,12 @@ bool message_with_timestamp;
>  bool error_with_guestname;
>  const char *error_guest_name;
>=20=20
> -int error_vprintf(const char *fmt, va_list ap)
> +/*
> + * Print to current monitor if we have one, else to stderr.
> + */

Wrong.  Suggest "to current HMP monitor if we have one".  Or drop the
comment.

> +static int G_GNUC_PRINTF(2, 0)
> +error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)

Call the argument @hmp_mon?

>  {
> -    Monitor *cur_mon =3D monitor_cur();
>      /*
>       * This will return -1 if 'cur_mon' is NULL, or is QMP.
>       * IOW this will only print if in HMP, otherwise we
> @@ -44,13 +47,30 @@ int error_vprintf(const char *fmt, va_list ap)
>      return ret;
>  }
>=20=20

If error_vprintf_mon() deserves a function comment, then
error_printf_mon() deserves one, too.

> +static int G_GNUC_PRINTF(2, 3)
> +error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
> +{
> +    va_list ap;
> +    int ret;
> +
> +    va_start(ap, fmt);
> +    ret =3D error_vprintf_mon(cur_mon, fmt, ap);
> +    va_end(ap);
> +    return ret;
> +}
> +
> +int error_vprintf(const char *fmt, va_list ap)
> +{
> +    return error_vprintf_mon(monitor_cur(), fmt, ap);
> +}
> +
>  int error_printf(const char *fmt, ...)
>  {
>      va_list ap;
>      int ret;
>=20=20
>      va_start(ap, fmt);
> -    ret =3D error_vprintf(fmt, ap);
> +    ret =3D error_vprintf_mon(monitor_cur(), fmt, ap);
>      va_end(ap);
>      return ret;
>  }
> @@ -153,34 +173,34 @@ void loc_set_file(const char *fname, int lno)
>  /*
>   * Print current location to current monitor if we have one, else to std=
err.

Not this patch's fault: this comment is inaccurate.  Fixed in my "[PATCH
0/3] Doc fixes around "current monitor" printing".

>   */
> -static void print_loc(void)
> +static void print_loc(Monitor *cur)

Call the argument @hmp_mon?

>  {
>      const char *sep =3D "";
>      int i;
>      const char *const *argp;
>=20=20
> -    if (!monitor_cur_is_hmp() && g_get_prgname()) {
> -        error_printf("%s:", g_get_prgname());
> +    if (!cur && g_get_prgname()) {
> +        fprintf(stderr, "%s:", g_get_prgname());
>          sep =3D " ";
>      }
>      switch (cur_loc->kind) {
>      case LOC_CMDLINE:
>          argp =3D cur_loc->ptr;
>          for (i =3D 0; i < cur_loc->num; i++) {
> -            error_printf("%s%s", sep, argp[i]);
> +            error_printf_mon(cur, "%s%s", sep, argp[i]);
>              sep =3D " ";
>          }
> -        error_printf(": ");
> +        error_printf_mon(cur, ": ");
>          break;
>      case LOC_FILE:
> -        error_printf("%s:", (const char *)cur_loc->ptr);
> +        error_printf_mon(cur, "%s:", (const char *)cur_loc->ptr);
>          if (cur_loc->num) {
> -            error_printf("%d:", cur_loc->num);
> +            error_printf_mon(cur, "%d:", cur_loc->num);
>          }
> -        error_printf(" ");
> +        error_printf_mon(cur, " ");
>          break;
>      default:
> -        error_printf("%s", sep);
> +        error_printf_mon(cur, "%s", sep);
>      }
>  }
>=20=20
> @@ -201,34 +221,39 @@ real_time_iso8601(void)
>  G_GNUC_PRINTF(2, 0)
>  static void vreport(report_type type, const char *fmt, va_list ap)
>  {
> +    Monitor *cur =3D NULL;
>      gchar *timestr;
>=20=20
> -    if (message_with_timestamp && !monitor_cur_is_hmp()) {
> +    if (monitor_cur_is_hmp()) {
> +        cur =3D monitor_cur();
> +    }

See my review of PATCH 15.

Rename @cur to @hmp_mon?

> +
> +    if (message_with_timestamp && !cur) {
>          timestr =3D real_time_iso8601();
> -        error_printf("%s ", timestr);
> +        fprintf(stderr, "%s ", timestr);
>          g_free(timestr);
>      }
>=20=20
>      /* Only prepend guest name if -msg guest-name and -name guest=3D... =
are set */
> -    if (error_with_guestname && error_guest_name && !monitor_cur_is_hmp(=
)) {
> -        error_printf("%s ", error_guest_name);
> +    if (error_with_guestname && error_guest_name && !cur) {
> +        fprintf(stderr, "%s ", error_guest_name);
>      }
>=20=20
> -    print_loc();
> +    print_loc(cur);
>=20=20
>      switch (type) {
>      case REPORT_TYPE_ERROR:
>          break;
>      case REPORT_TYPE_WARNING:
> -        error_printf("warning: ");
> +        error_printf_mon(cur, "warning: ");
>          break;
>      case REPORT_TYPE_INFO:
> -        error_printf("info: ");
> +        error_printf_mon(cur, "info: ");
>          break;
>      }
>=20=20
> -    error_vprintf(fmt, ap);
> -    error_printf("\n");
> +    error_vprintf_mon(cur, fmt, ap);
> +    error_printf_mon(cur, "\n");
>  }
>=20=20
>  /*


