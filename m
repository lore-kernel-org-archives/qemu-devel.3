Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7B5D2D11E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffph-00088y-1I; Tue, 13 Jan 2026 09:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vffpf-00088T-2A
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vffpd-00029F-9i
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768316236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqMmFKgJWyqaR+4Rqq2Zws8yekYXMLnUp/IFNTcw2k4=;
 b=UxXvqxe2+g2WxzmF7Hd1FHIIz1aQAeU68DO0MDG3aXehMkDzIFPHrH0+HjdO2bHtqzXjEo
 EZqnXbGxnsJhT5n1eksm9ShY6YORbRUFiipQEm5LEhHZdmSQNrXwxI9RIl2Me/9cql31WG
 hBOYQP4KTIEfm4UOYCNSRhJ1pZTWU1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-Z5zLhOcDPOWLdW5FriIREQ-1; Tue,
 13 Jan 2026 09:57:15 -0500
X-MC-Unique: Z5zLhOcDPOWLdW5FriIREQ-1
X-Mimecast-MFC-AGG-ID: Z5zLhOcDPOWLdW5FriIREQ_1768316233
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C7B418002CC; Tue, 13 Jan 2026 14:57:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD8721800998; Tue, 13 Jan 2026 14:57:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5109521E676C; Tue, 13 Jan 2026 15:57:09 +0100 (CET)
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
Subject: Re: [PATCH v5 15/24] monitor: introduce monitor_cur_is_hmp() helper
In-Reply-To: <20260108170338.2693853-16-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:29
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-16-berrange@redhat.com>
Date: Tue, 13 Jan 2026 15:57:09 +0100
Message-ID: <874iop8ssa.fsf@pond.sub.org>
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

> Note that this is not simply the inverse of monitor_cur_is_qmp(),
> as both helpers require that monitor_cur() is first non-NULL.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/monitor/monitor.h      |  1 +
>  monitor/monitor.c              | 10 ++++++++++
>  stubs/monitor-core.c           |  6 ++++++
>  tests/unit/test-util-sockets.c |  1 +
>  4 files changed, 18 insertions(+)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 296690e1f1..9c71e6cf3c 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -16,6 +16,7 @@ extern QemuOptsList qemu_mon_opts;
>  Monitor *monitor_cur(void);
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
>  bool monitor_cur_is_qmp(void);
> +bool monitor_cur_is_hmp(void);
>=20=20
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 6dc5a7016d..b81cc7d2ed 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -116,6 +116,16 @@ bool monitor_cur_is_qmp(void)
>      return cur_mon && monitor_is_qmp(cur_mon);
>  }
>=20=20
> +/**
> + * Is the current monitor, if any, a HMP monitor?

"an HMP"?  Not a native speaker...

> + */
> +bool monitor_cur_is_hmp(void)
> +{
> +    Monitor *cur_mon =3D monitor_cur();
> +
> +    return cur_mon && !monitor_is_qmp(cur_mon);
> +}
> +

The only use at the end of this series looks like this:

    Monitor *cur =3D NULL;

    if (monitor_cur_is_hmp()) {
        cur =3D monitor_cur();
    } else {
        // some stderr code
    }

Meh.  Could do

    Monitor *cur =3D monitor_cur();

    if (monitor_cur_is_qmp(cur)) {
        cur =3D NULL;
        // some stderr code
    }

Or with a helper returning the HMP monitor, we could have something like

    cur =3D monitor_cur_hmp();

    if (!cur) {
        // some stderr code
    }

Doesn't mirror monitor_cur_is_qmp() then.  But I just pointed out in
reply to PATCH 11 that we don't actually need monitor_cur_is_qmp()>

Ideas, not demands.

>  /**
>   * Is @mon is using readline?
>   * Note: not all HMP monitors use readline, e.g., gdbserver has a
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index a7c32297c9..674211f48f 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -7,6 +7,12 @@ Monitor *monitor_cur(void)
>      return NULL;
>  }
>=20=20
> +bool monitor_cur_is_hmp(void)
> +{
> +    /* since monitor_cur() above returns NULL, this can't be true */

Maybe

       /* We can't have a monitor, let alone an HMP monitor */

Up to you.

> +    return false;
> +}
> +
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>  {
>      return NULL;
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-socket=
s.c
> index ee66d727c3..4b7f408902 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -74,6 +74,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
>  Monitor *monitor_cur(void) { return cur_mon; }
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort()=
; }
> +bool monitor_cur_is_hmp(void) { return false; }

Fine.  abort() would also be fine.  Matter of taste.

>=20=20
>  #ifndef _WIN32
>  static void test_socket_fd_pass_name_good(void)


