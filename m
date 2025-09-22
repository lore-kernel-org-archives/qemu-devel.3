Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0c98-0005Tp-7h; Mon, 22 Sep 2025 04:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0c96-0005TQ-G5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0c8w-0006ZW-84
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758530607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXUjlgRC3Uhc0NS4B/RX/052Kpk/T6T8tQ2S6QRVUCI=;
 b=XbcWy8qx0GPKjjKcsd4e+U1o1R6PRvOLX4BgT97BsvRoTZ9hhVrsZ3WQRBTlDsZb4srYPi
 gtBdEgbxUMJgwLUYhLl1IvKjABLBZwBRtAMzynuvN6Q5fPu6sSEacctRY3DJdWyj8Wx1xx
 cE/sUb8ppW6AO4sMK7FAbA0wShSmbto=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-87cRom1uPHq304M_ySq0aA-1; Mon,
 22 Sep 2025 04:43:23 -0400
X-MC-Unique: 87cRom1uPHq304M_ySq0aA-1
X-Mimecast-MFC-AGG-ID: 87cRom1uPHq304M_ySq0aA_1758530602
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08FBD180057B; Mon, 22 Sep 2025 08:43:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66D823000198; Mon, 22 Sep 2025 08:43:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C488721E6A27; Mon, 22 Sep 2025 10:43:18 +0200 (CEST)
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
Subject: Re: [PATCH v3 13/20] util: don't skip error prefixes when QMP is
 active
In-Reply-To: <20250910180357.320297-14-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:50
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-14-berrange@redhat.com>
Date: Mon, 22 Sep 2025 10:43:18 +0200
Message-ID: <87ms6mnahl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

> The vreport() function will print to HMP if available, otherwise
> to stderr. In the event that vreport() is called during execution
> of a QMP command, it will print to stderr, but mistakenly omit the
> message prefixes (timestamp, guest name, program name).
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/error-report.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/util/error-report.c b/util/error-report.c
> index 79b6f23e64..c0fcf388de 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -34,9 +34,9 @@ const char *error_guest_name;
>   */
>  int error_vprintf(const char *fmt, va_list ap)
>  {
> -    Monitor *cur_mon =3D monitor_cur();
> +    Monitor *cur_mon =3D monitor_cur_hmp();
>=20=20
> -    if (cur_mon && !monitor_cur_is_qmp()) {
> +    if (cur_mon) {
>          return monitor_vprintf(cur_mon, fmt, ap);
>      }
>      return vfprintf(stderr, fmt, ap);

This isn't part of the fix, it merely puts monitor_cur_hmp() to use.  It
we decide we want that function (see discussion of previous patch), then
I'd squash this hunk into the patch that creates it.

> @@ -157,7 +157,7 @@ static void print_loc(void)
>      int i;
>      const char *const *argp;
>=20=20
> -    if (!monitor_cur() && g_get_prgname()) {
> +    if (!monitor_cur_hmp() && g_get_prgname()) {
>          error_printf("%s:", g_get_prgname());
>          sep =3D " ";
>      }
> @@ -201,14 +201,14 @@ static void vreport(report_type type, const char *f=
mt, va_list ap)
>  {
>      gchar *timestr;
>=20=20
> -    if (message_with_timestamp && !monitor_cur()) {
> +    if (message_with_timestamp && !monitor_cur_hmp()) {
>          timestr =3D real_time_iso8601();
>          error_printf("%s ", timestr);
>          g_free(timestr);
>      }
>=20=20
>      /* Only prepend guest name if -msg guest-name and -name guest=3D... =
are set */
> -    if (error_with_guestname && error_guest_name && !monitor_cur()) {
> +    if (error_with_guestname && error_guest_name && !monitor_cur_hmp()) {
>          error_printf("%s ", error_guest_name);
>      }

Yup, these fix a bug.


