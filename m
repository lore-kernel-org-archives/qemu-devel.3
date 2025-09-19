Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927A2CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzaT5-0003gE-0g; Fri, 19 Sep 2025 08:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzaT3-0003fE-Qm
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzaSx-0003I6-6F
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758285829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZH6M/G8z9UjjpH8Vku58fpTVtFVYrf5nk3lrykAhzw=;
 b=hYwxdTovW6m6LCtSKBfhyZEQ1wk628ele/ZJHpsDyC4FkrLpMUFPjXUFqdaW1wX+HYILrr
 HJ58Ht0OGgadrem/uO15x3EyHmksKanVk0r+OhEAlP8YQdcD06KPQFXqv3UDJB2cYTr/NJ
 L0C/XydxBfpwnj9ggKLhgi8KOA6REXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-imrxfF8OOhyS_cPHXcTYOw-1; Fri,
 19 Sep 2025 08:43:46 -0400
X-MC-Unique: imrxfF8OOhyS_cPHXcTYOw-1
X-Mimecast-MFC-AGG-ID: imrxfF8OOhyS_cPHXcTYOw_1758285825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAECC19560B1; Fri, 19 Sep 2025 12:43:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 386ED1955F21; Fri, 19 Sep 2025 12:43:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C17421E6A27; Fri, 19 Sep 2025 14:43:41 +0200 (CEST)
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
Subject: Re: [PATCH v3 12/20] monitor: introduce monitor_cur_hmp() function
In-Reply-To: <20250910180357.320297-13-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:49
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-13-berrange@redhat.com>
Date: Fri, 19 Sep 2025 14:43:41 +0200
Message-ID: <87zfaqwr2a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
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

> A number of callers use monitor_cur() followed by !monitor_cur_is_qmp().

"A number of"?  I can see just one:

    int error_vprintf(const char *fmt, va_list ap)
    {
        Monitor *cur_mon =3D monitor_cur();

        if (cur_mon && !monitor_cur_is_qmp()) {
            return monitor_vprintf(cur_mon, fmt, ap);
        }
        return vfprintf(stderr, fmt, ap);
    }

> This is undesirable because monitor_cur_is_qmp() will itself call
> monitor_cur() again, and monitor_cur() must acquire locks and do
> hash table lookups. Introducing a monitor_cur_hmp() helper will
> combine the two operations into one reducing cost.

This made me expect the patch replaces the undesirable uses.  It does
not; the new function remains unused for now.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/monitor/monitor.h      |  1 +
>  monitor/monitor.c              | 14 ++++++++++++++
>  stubs/monitor-core.c           |  5 +++++
>  tests/unit/test-util-sockets.c |  1 +
>  4 files changed, 21 insertions(+)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 296690e1f1..c3b79b960a 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -14,6 +14,7 @@ typedef struct MonitorOptions MonitorOptions;
>  extern QemuOptsList qemu_mon_opts;
>=20=20
>  Monitor *monitor_cur(void);
> +Monitor *monitor_cur_hmp(void);
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
>  bool monitor_cur_is_qmp(void);
>=20=20
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index e1e5dbfcbe..cff502c53e 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -84,6 +84,20 @@ Monitor *monitor_cur(void)
>      return mon;
>  }
>=20=20
> +Monitor *monitor_cur_hmp(void)
> +{
> +    Monitor *mon;
> +
> +    qemu_mutex_lock(&monitor_lock);
> +    mon =3D g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
> +    if (mon && monitor_is_qmp(mon)) {
> +        mon =3D NULL;
> +    }
> +    qemu_mutex_unlock(&monitor_lock);
> +
> +    return mon;
> +}
> +
>  /**
>   * Sets a new current monitor and returns the old one.
>   *
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index b498a0f1af..1e0b11ec29 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
>      return NULL;
>  }
>=20=20
> +Monitor *monitor_cur_hmp(void)
> +{
> +    return NULL;
> +}
> +
>  bool monitor_cur_is_qmp(void)
>  {
>      return false;
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-socket=
s.c
> index bd48731ea2..d40813c682 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -72,6 +72,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
>   * otherwise we get duplicate syms at link time.
>   */
>  Monitor *monitor_cur(void) { return cur_mon; }
> +Monitor *monitor_cur_hmp(void) { return cur_mon; }

@cur_mon is a fake here.  Why do you make this fake monitor HMP?  If we
somehow call error_vprintf(), it'll call monitor_vprintf(), which will
dereference the fake monitor.  Best possible outcome would be an
immediate crash.

>  bool monitor_cur_is_qmp(void) { return false; }
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort()=
; }


