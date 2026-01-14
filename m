Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF16D2A008
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0Nu-0001PG-5Z; Wed, 14 Jan 2026 07:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0NE-0001Em-VC
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0NA-00033I-Hd
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768395195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZgBvPtSls1neXDeFffgJHJxieERvA4B6ga+aPABvRk=;
 b=IQvP8LRqyULyrhGA66ISbta571R4rv54ziG+gJ5qWDGjmQPU4X4h6Vs8kOjVBoCNTgscG3
 HsSQPKmH09peZ6sSRBJ5ED3Wb6BJAbXindwR2AD7byvA1hwujfgGHhZWIeeXavZRRpMYWM
 zru3eoAEwANZ61Ib8PKMoTDL0EJvmwg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-BnEgrLeVNyuvpAhTfh9A9g-1; Wed,
 14 Jan 2026 07:53:12 -0500
X-MC-Unique: BnEgrLeVNyuvpAhTfh9A9g-1
X-Mimecast-MFC-AGG-ID: BnEgrLeVNyuvpAhTfh9A9g_1768395191
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C275C1800371; Wed, 14 Jan 2026 12:53:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 496821956053; Wed, 14 Jan 2026 12:53:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D57F721E692D; Wed, 14 Jan 2026 13:53:07 +0100 (CET)
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
Subject: Re: [PATCH v5 16/24] util: don't skip error prefixes when QMP is
 active
In-Reply-To: <20260108170338.2693853-17-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:30
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-17-berrange@redhat.com>
Date: Wed, 14 Jan 2026 13:53:07 +0100
Message-ID: <87ecns2w5o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> The vreport() function will print to HMP if available, otherwise
> to stderr. In the event that vreport() is called during execution
> of a QMP command, it will print to stderr, but mistakenly omit the
> message prefixes (timestamp, guest name, program name).
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/error-report.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/util/error-report.c b/util/error-report.c
> index b262ad01cb..872158ad90 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -159,7 +159,7 @@ static void print_loc(void)
   /*
    * Print current location to current monitor if we have one, else to std=
err.

This comment is now wrong.  Obvious fix: "to current HMP monitor".

Losely related: "[PATCH 0/3] Doc fixes around "current monitor" printing".

    */
   static void print_loc(void)
   {
       const char *sep =3D "";
>      int i;
>      const char *const *argp;
>=20=20
> -    if (!monitor_cur() && g_get_prgname()) {
> +    if (!monitor_cur_is_hmp() && g_get_prgname()) {
>          error_printf("%s:", g_get_prgname());
>          sep =3D " ";
>      }
> @@ -203,14 +203,14 @@ static void vreport(report_type type, const char *f=
mt, va_list ap)
   /*
    * Print a message to current monitor if we have one, else to stderr.

Likewise.

    * @report_type is the type of message: error, warning or informational.
    * Format arguments like vsprintf().  The resulting message should be
    * a single phrase, with no newline or trailing punctuation.
    * Prepend the current location and append a newline.
    */
   G_GNUC_PRINTF(2, 0)
   static void vreport(report_type type, const char *fmt, va_list ap)
>  {
>      gchar *timestr;
>=20=20
> -    if (message_with_timestamp && !monitor_cur()) {
> +    if (message_with_timestamp && !monitor_cur_is_hmp()) {
>          timestr =3D real_time_iso8601();
>          error_printf("%s ", timestr);
>          g_free(timestr);
>      }
>=20=20
>      /* Only prepend guest name if -msg guest-name and -name guest=3D... =
are set */
> -    if (error_with_guestname && error_guest_name && !monitor_cur()) {
> +    if (error_with_guestname && error_guest_name && !monitor_cur_is_hmp(=
)) {
>          error_printf("%s ", error_guest_name);
>      }


