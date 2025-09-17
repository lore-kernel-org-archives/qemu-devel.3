Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F00CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 14:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyst5-0005pp-Sg; Wed, 17 Sep 2025 10:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyst3-0005oM-3p
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyst0-0008Bz-W4
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758118314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuDPmNTuw3rkOGqi7NGB97q2lMmeuNZ4aykp6cvRb6Q=;
 b=RiaJFoJgYCpSDIkZevrUK1NWjS5ORnEIobtJyUlqXwdf/huRuBLwcy/AicIuCyUGwyao4a
 YSi0UCiHAubLb6oWrT+KUYIixX5yxfWl9bX0gGt2J8XKztNC+e5bVBc9UCrInRUZLNaMyA
 zdkRFQa/Sic/kYZZ6y/WJ0pVD4BEIvc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-VOc_S_fJOzmRjj_Ip6XlVA-1; Wed,
 17 Sep 2025 10:11:49 -0400
X-MC-Unique: VOc_S_fJOzmRjj_Ip6XlVA-1
X-Mimecast-MFC-AGG-ID: VOc_S_fJOzmRjj_Ip6XlVA_1758118308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D83618002CB; Wed, 17 Sep 2025 14:11:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 700BD1800447; Wed, 17 Sep 2025 14:11:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B815221E6A27; Wed, 17 Sep 2025 16:11:44 +0200 (CEST)
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
Date: Wed, 17 Sep 2025 16:11:44 +0200
Message-ID: <87wm5x2mov.fsf@pond.sub.org>
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

> Some code makes multiple qemu_log calls to incrementally emit
> a single message. Currently timestamps get prepended to all
> qemu_log calls, even those continuing a previous incomplete
> message.
>
> This changes the qemu_log so it skips adding a new line prefix,
> if the previous qemu_log call did NOT end with a newline.
>

Have you considered

  Fixes: 012842c07552 (log: make '-msg timestamp=3Don' apply to all qemu_lo=
g usage)

?

> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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

Thread-local only because we have @log_per_thread, isn't it?

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
>          va_start(ap, fmt);
>          vfprintf(f, fmt, ap);
>          va_end(ap);
> +        incomplete =3D fmt[strlen(fmt) - 1] !=3D '\n';
>          qemu_log_unlock(f);
>      }
>  }


