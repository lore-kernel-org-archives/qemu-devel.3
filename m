Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EE8D2D115
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffdF-0004bX-7q; Tue, 13 Jan 2026 09:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vffd8-0004YI-3s
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vffd2-0008Qe-MB
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768315455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGRvfGvJYFJWMewtXKMSHVh60jwS1MoLGDpEtvLt2lM=;
 b=b64YXjQFSmqhvhs5CWdrJKCnjOlNPriimwO3FlaFNcw2baQyKg6R2r+4IBNycign18BS0i
 LOPvzNyhOdAeZwlX3SQhiOu/O861Zvl+l6JUHHeaYxnvJ1gnfS2rQVkBKjIlZusNS+iCgq
 b/wGmMWj2RJxGi0GD7p725Gli403mQ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-j3gIKTYAO2WYkqyzxtCpqQ-1; Tue,
 13 Jan 2026 09:44:12 -0500
X-MC-Unique: j3gIKTYAO2WYkqyzxtCpqQ-1
X-Mimecast-MFC-AGG-ID: j3gIKTYAO2WYkqyzxtCpqQ_1768315451
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D59DF19560A2; Tue, 13 Jan 2026 14:44:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 603C9180009E; Tue, 13 Jan 2026 14:44:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED29A21E6683; Tue, 13 Jan 2026 15:44:07 +0100 (CET)
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
Subject: Re: [PATCH v5 11/24] ui/vnc: remove use of error_printf_unless_qmp()
In-Reply-To: <20260108170338.2693853-12-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:25
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-12-berrange@redhat.com>
Date: Tue, 13 Jan 2026 15:44:07 +0100
Message-ID: <875x958te0.fsf@pond.sub.org>
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

> The error_printf_unless_qmp() will print to the monitor if the current
> one is HMP, if it is QMP nothing will be printed, otherwise stderr
> will be used.
>
> This scenario is easily handled by checking !monitor_cur_is_qmp() and
> then calling the error_printf() function.
>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/vnc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index a61a4f937d..a209c32f6d 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3534,8 +3534,10 @@ int vnc_display_password(const char *id, const cha=
r *password)
>          return -EINVAL;
>      }
>      if (vd->auth =3D=3D VNC_AUTH_NONE) {
> -        error_printf_unless_qmp("If you want use passwords please enable=
 "
> -                                "password auth using '-vnc ${dpy},passwo=
rd'.\n");
> +        if (!monitor_cur_is_qmp()) {
> +            error_printf("If you want to use passwords, please enable "
> +                         "password auth using '-vnc ${dpy},password'.\n"=
);
> +        }
>          return -EINVAL;
>      }
>=20=20
> @@ -3574,9 +3576,11 @@ static void vnc_display_print_local_addr(VncDispla=
y *vd)
>          qapi_free_SocketAddress(addr);
>          return;
>      }
> -    error_printf_unless_qmp("VNC server running on %s:%s\n",
> -                            addr->u.inet.host,
> -                            addr->u.inet.port);
> +    if (!monitor_cur_is_qmp()) {
> +        error_printf("VNC server running on %s:%s\n",
> +                     addr->u.inet.host,
> +                     addr->u.inet.port);
> +    }
>      qapi_free_SocketAddress(addr);
>  }

These are the only remaining uses of monitor_cur_is_qmp() at the end of
this series.  Hmm.


The first hunk is arguably sub-par error reporting.
vnc_display_password() is called by qmp_set_password() and
qmp_change_vnc_password().

Here's HMP:

    (qemu) set_password vnc 1234
    If you want to use passwords, please enable password auth using '-vnc $=
{dpy},password'.
    Error: Could not set password


QMP is even worse:

    {"execute": "set_password", "arguments": {"protocol": "vnc", "password"=
: "1"}}
    {"error": {"class": "GenericError", "desc": "Could not set password"}}

Better would be something like

    error_setg(errp, "VNC password authentication is disabled");
    error_append_hint(errp, "To enable it, use ...");

where ... is the preferred way to enable it (not sure it's -vnc).

HMP should then report

    Error: VNC password authentication is disabled
    To enable it, use ...

and QMP

    {"error": {"class": "GenericError", "desc": "VNC password authenticatio=
n is disabled"}}

No need for monitor_cur_is_qmp() then.


The second hunk applies in vnc_display_print_local_addr(), called by
qemu_init() via qemu_init_displays(), vnc_init_func(), and
vnc_display_open().  Can't be QMP; the monitor_cur_is_qmp() check could
be dropped.

Better: move the call up the call chain until "can't be QMP" is
perfectly obvious.

By the way, vnc_display_open() could be static.


