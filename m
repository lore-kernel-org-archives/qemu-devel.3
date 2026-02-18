Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C1CE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 12:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsgsB-0001ho-LO; Wed, 18 Feb 2026 07:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgs7-0001gS-Lj
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgs4-0005Iw-Qs
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771418495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7wGntR1j1Bw0SBS1npXrK23dTnsf4jxV4PETaq4nTc=;
 b=TcGE98wWYTbuw7OheusRkpHCp2zf5jXLAmHiIQOGgg5zSrWUrfyfVjYjhkhd0va4kIUpwr
 NpgJgulhdAi87OJygU4wz0XyDpCdiOlSki3lIlOfGvzFWCn5+EYyPduqcEvpo/hhSBgKSg
 2s4LPSk5nSLdk71HUejkD1Qvjeos/QE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-xTjfNj6zMVit3Akj2UA98w-1; Wed,
 18 Feb 2026 07:41:32 -0500
X-MC-Unique: xTjfNj6zMVit3Akj2UA98w-1
X-Mimecast-MFC-AGG-ID: xTjfNj6zMVit3Akj2UA98w_1771418490
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FBDA1956054; Wed, 18 Feb 2026 12:41:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B43930001A5; Wed, 18 Feb 2026 12:41:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 016F021E692D; Wed, 18 Feb 2026 13:41:26 +0100 (CET)
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
Subject: Re: [PATCH v6 19/27] util: fix interleaving of error & trace output
In-Reply-To: <20260211152508.732487-20-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:25:00
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-20-berrange@redhat.com>
Date: Wed, 18 Feb 2026 13:41:26 +0100
Message-ID: <87fr6ycjgp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/error-report.c | 63 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 21 deletions(-)
>
> diff --git a/util/error-report.c b/util/error-report.c
> index f3aa24ec22..b34a2bc7bc 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -32,9 +32,9 @@ const char *error_guest_name;
>  /*
>   * Print to the current human monitor if we have one, else to stderr.

This is now misleading.  Let's use

    * Print to @cur_mon if non-null, else to stderr.

>   */
> -int error_vprintf(const char *fmt, va_list ap)
> +static int G_GNUC_PRINTF(2, 0)
> +error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
>  {
> -    Monitor *cur_mon =3D monitor_cur();
>      /*
>       * This will return -1 if 'cur_mon' is NULL, or is QMP.
>       * IOW this will only print if in HMP, otherwise we
> @@ -47,13 +47,33 @@ int error_vprintf(const char *fmt, va_list ap)
>      return ret;
>  }
>=20=20
> +/*
> + * Print to the current human monitor if we have one, else to stderr.

Likewise.

> + */
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

Keep its function comment, i.e.

   /*
    * Print to the current human monitor if we have one, else to stderr.
    */
> +int error_vprintf(const char *fmt, va_list ap)
> +{
> +    return error_vprintf_mon(monitor_cur(), fmt, ap);
> +}
> +

This one lost its function comment in commit 397d30e9401.  Let's correct
that accident:

   /*
    * Print to the current human monitor if we have one, else to stderr.
    */
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

With these trivial touch-ups
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]


