Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7909E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 12:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsgy1-0003Xs-Vp; Wed, 18 Feb 2026 07:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgy0-0003X7-5v
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:47:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgxy-0001ae-Md
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771418862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DTIgg4DtyxMR0x2nf7H4YzzQVN3NVFHNoatTHDgLEI=;
 b=AaE0mhBX1xsPxXvPXpCbUhHKVb9ICrI6zdSVycbECiQbRbhS5Plqire0W0oeEYzHYNGovF
 AXvvh7mOpeXNZuxGIK0S8r9EomULhxFr+SUQQwXQCHYYfmNBGez7ITlzsmLXzDGzb0P2EO
 a7JSYBXQRsOQPsqUgUqUDEKg5MjCahE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-uVncnrSrMXCbKek6xJxfTg-1; Wed,
 18 Feb 2026 07:47:39 -0500
X-MC-Unique: uVncnrSrMXCbKek6xJxfTg-1
X-Mimecast-MFC-AGG-ID: uVncnrSrMXCbKek6xJxfTg_1771418857
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063071955BD9; Wed, 18 Feb 2026 12:47:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F05D19560B7; Wed, 18 Feb 2026 12:47:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39F0921E692D; Wed, 18 Feb 2026 13:47:34 +0100 (CET)
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
Subject: Re: [PATCH v6 20/27] util: don't skip error prefixes when QMP is
 active
In-Reply-To: <20260211152508.732487-21-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:25:01
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-21-berrange@redhat.com>
Date: Wed, 18 Feb 2026 13:47:33 +0100
Message-ID: <875x7ucj6i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

> The vreport() function will print to HMP if available, otherwise
> to stderr. In the event that vreport() is called during execution
> of a QMP command, it will print to stderr, but mistakenly omit the
> message prefixes (timestamp, guest name, program name).
>
> This new usage of monitor_is_cur_qmp() from vreport() requires that
> we add a stub to satisfy linking of non-system emulator binaries.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  stubs/monitor-core.c           | 5 +++++
>  tests/unit/test-util-sockets.c | 1 +
>  util/error-report.c            | 8 ++++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index a7c32297c9..078a5012e9 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
>      return NULL;
>  }
>=20=20
> +bool monitor_cur_is_qmp(void)
> +{
> +    return false;
> +}
> +
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>  {
>      return NULL;
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-socket=
s.c
> index ee66d727c3..b9f2453e29 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -74,6 +74,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
>  Monitor *monitor_cur(void) { return cur_mon; }
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort()=
; }
> +bool monitor_cur_is_qmp(void) { abort(); };
>=20=20
>  #ifndef _WIN32
>  static void test_socket_fd_pass_name_good(void)
> diff --git a/util/error-report.c b/util/error-report.c
> index b34a2bc7bc..052f0f68b8 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -227,6 +227,14 @@ static void vreport(report_type type, const char *fm=
t, va_list ap)
>      Monitor *cur =3D monitor_cur();
>      gchar *timestr;
>=20=20
> +    /*
> +     * When current monitor is QMP, messages must go to stderr
> +     * and have prefixes added

Let's end the sentence with a period.

> +     */
> +    if (monitor_cur_is_qmp()) {
> +        cur =3D NULL;
> +    }
> +
>      if (message_with_timestamp && !cur) {
>          timestr =3D real_time_iso8601();
>          fprintf(stderr, "%s ", timestr);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


