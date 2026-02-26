Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C983DFC5913
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 09:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvY1p-0007Gh-2d; Thu, 26 Feb 2026 04:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvY1b-0007Du-UC
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvY1Y-0007KC-Uo
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772099471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rU0aKfvKOzw75Cb25bqDjXPDevHPqqpxwKjEYcpa2o8=;
 b=EK6vkxoJIf3olM9CTBo/sA/ilQK6ueYn2up0C0WPShK66m2o2GhXaqJLJXRfBpzX1oQ8lI
 l7V21CWIoaCaNHQQkKRgxRn9r2Uto3fhhuTJ/+4HlniWClsZwRrBa665XGhOaVxo1ejNS7
 P4syyYEWRaNGw807mlmH2wTZxdVf7ig=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-rJB6MOJ3Pi6G8lipVpxcOg-1; Thu,
 26 Feb 2026 04:51:07 -0500
X-MC-Unique: rJB6MOJ3Pi6G8lipVpxcOg-1
X-Mimecast-MFC-AGG-ID: rJB6MOJ3Pi6G8lipVpxcOg_1772099465
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12BFB195609E; Thu, 26 Feb 2026 09:51:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08FEA30001A5; Thu, 26 Feb 2026 09:51:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8351A21E6932; Thu, 26 Feb 2026 10:51:01 +0100 (CET)
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
Subject: Re: [PATCH v6 00/27] util: sync error_report & qemu_log output more
 closely
In-Reply-To: <20260211152508.732487-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:24:41
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
Date: Thu, 26 Feb 2026 10:51:01 +0100
Message-ID: <874in3hlyy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
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

> This series is a tangent that came out of discussion in
>
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00903.html

This was about error messages providing sufficient information both for
users and for developers.

Manos proposed to print a stack backtrace on programming errors and
fatal errors (&error_abort and &error_fatal), enabled at configure time.
He found this useful for debugging a use-after-free.

Daniel pointed out that GDB shows better stack backtraces, and that we
could not enable this feature in distro builds.  He wondered whether
showing just thread names would do.

> In thinking about adding thread info to error_report,

I understand why that can be useful for developers in certain scenarios,
but I feel it results in error reporting that is overly vebose and
unwieldy for users.  I'd prefer optional, default off.

>                                                       I
> came to realize we should likely make qemu_log behave
> consistently with error_report & friends. We already
> honour '-msg timestamp=3Don', but don't honour 'guest-name=3Don'
> and also don't include the binary name.

I'm willing to accept a message format common to error reporting and log
if that's useful.  Backed by shared code, obviously.

Why could it be useful, and to whom?

Error messages are both for users and developers.  Both need them to be
clear and detailed enough to figure out what's gone wrong, and what to
do about it.

Developers can use additional detail.  Lots and lots of it at times.  No
excuse for dumping it all on users.

Carefully designed logs can also be for both.  Much of what QEMU can log
is just for developers, and that's *fine*.  Sometimes developers want to
log lots of detail per message, sometimes they don't, to keep the logs
managable, as Peter pointed out.

When the error message needs of users and developers conflict, I put
users first.

When the logging needs of users and developers conflict, I put
developers first.

> As an example of the current state, consider mixing error and
> log output today:

Having the errors in the log can clearly be useful.  The easiest way to
have them in the log is --- wait for it --- logging them.

We don't do that now.  Instead, you can log to stderr, or you can piece
together log file contents and error messages.  The format differences
can be inconvenient either way.

Could we log errors?

> - Default context:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish \
>                        -d 'trace:qcrypto*'
>   qcrypto_tls_creds_x509_load TLS creds x509 load creds=3D0x55ac6d97f700 =
dir=3Dfish
>   qcrypto_tls_creds_get_path TLS creds path creds=3D0x55ac6d97f700 filena=
me=3Dca-cert.pem path=3D<none>
>   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No s=
uch file or directory
>
> - Full context:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish \
>                        -d 'trace:qcrypto*' \
>                        -msg guest-name=3Don,timestamp=3Don \
>                        -name "fish food"
>   2025-08-19T20:14:16.791413Z qcrypto_tls_creds_x509_load TLS creds x509 =
load creds=3D0x55e9a3458d10 dir=3Dfish
>   2025-08-19T20:14:16.791429Z qcrypto_tls_creds_get_path TLS creds path c=
reds=3D0x55e9a3458d10 filename=3Dca-cert.pem path=3D<none>
>   2025-08-19T20:14:16.791433Z fish food qemu-system-x86_64: Unable to acc=
ess credentials fish/ca-cert.pem: No such file or directory
>
> And after this series is complete:
>
> - Default context:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish \
>                       -d 'trace:qcrypto*'
>   qemu-system-x86_64(1184284:main): qcrypto_tls_creds_x509_load TLS creds=
 x509 load creds=3D0x55a24ad5cb30 dir=3Dfish
>   qemu-system-x86_64(1184284:main): qcrypto_tls_creds_get_path TLS creds =
path creds=3D0x55a24ad5cb30 filename=3Dca-cert.pem path=3D<none>
>   qemu-system-x86_64(1184284:main): Unable to access credentials fish/ca-=
cert.pem: No such file or directory
>
> - Full context:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish \
>                       -d 'trace:qcrypto*' \
>                       -msg guest-name=3Don,timestamp=3Don \
>                       -name "fish food"
>   2025-08-19T20:12:50.211823Z [fish food] qemu-system-x86_64(1168876:main=
): qcrypto_tls_creds_x509_load TLS creds x509 load creds=3D0x5582183d8760 d=
ir=3Dfish
>   2025-08-19T20:12:50.211842Z [fish food] qemu-system-x86_64(1168876:main=
): qcrypto_tls_creds_get_path TLS creds path creds=3D0x5582183d8760 filenam=
e=3Dca-cert.pem
> +path=3D<none>
>   2025-08-19T20:12:50.211846Z [fish food] qemu-system-x86_64(1168876:main=
): Unable to access credentials fish/ca-cert.pem: No such file or directory
>
> The main things to note:
>
>  * error_report/warn_report/qemu_log share the same
>    output format and -msg applies to both

I fear this is a bad idea.  I apologize for being so late with this.  I
didn't think hard enough until now.

Unified format with separate configuration controls and defaults could
be okay.

>  * -msg debug-threads=3Don is now unconditionally enabled
>    and thus the param is deprecated & ignored

This part just makes sense.

>  * Thread ID and name are unconditionally enabled
>
>  * Guest name is surrounded in [...] brackets
>
>  * The default output lines are typically 15 chars
>    wider given that we always include the thread
>    ID + name now
>
>  * This takes the liberty of assigning the new file
>    to the existing error-report.c maintainer (Markus)
>    Since splitting it off into message.c instead of
>    putting it all in error-report.c felt slightly
>    nicer.
>
> One thing I didn't tackle is making the location
> info get reported for qemu_log. This is used to
> give context for error messages when parsing some
> CLI args, and could be interesting for log messages
> associated with those same CLI args.


