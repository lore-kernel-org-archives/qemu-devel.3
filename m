Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19166606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=honzp6Gv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMLc0-0004Sx-M0; Thu, 29 Oct 2026 04:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMLby-0004SX-Tc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMLbx-00012R-2r
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793262947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzIxPrIzP/DoNov39+WHtWPHDveERPeB+031I+j3LFw=;
 b=honzp6Gv3u4w19gRvI+i3PQ5wdJfBQ6Ua67mHBGgqkXi8oxaKc4XylBYrnGG61C0aK/nZF
 VwwUBxbRNyTkVDcM6Oek5Sdg9LCCnxe2WJEhBnH9sd7EGAZxdFNDv5mWuO3jwqsl8Z5AEc
 Z7wIqvv1Uq615wXkN69wzdWc4JpFljs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-R6sewDbpMo6IFvRi7CTIwQ-1; Thu,
 29 Oct 2026 04:35:43 -0400
X-MC-Unique: R6sewDbpMo6IFvRi7CTIwQ-1
X-Mimecast-MFC-AGG-ID: R6sewDbpMo6IFvRi7CTIwQ_1793262942
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DC161955F14; Thu, 29 Oct 2026 08:35:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F7C11800446; Thu, 29 Oct 2026 08:35:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB30021E6A04; Thu, 29 Oct 2026 09:35:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 08/21] qapi: add 'tldr-dump' command for on-demand data
 recorder output
In-Reply-To: <20261015112044.1999748-9-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 15 Oct 2026 12:20:31
 +0100")
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-9-berrange@redhat.com>
Date: Thu, 29 Oct 2026 09:35:38 +0100
Message-ID: <87a4nwgazp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> While the data recorder is designed to dump its contents in
> response to various signals that result in a QEMU crash, it
> is also interesting to explicitly request dump.
>
> This could be simply as an adhoc debugging activity, or could
> be in response to a specific event like a guest OS panic
> notification.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS           |  1 +
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  qapi/tldr.json        | 28 ++++++++++++++++++++++++++++
>  qemu-options.hx       |  2 ++
>  util/tldr.c           | 32 ++++++++++++++++++++++++++++++++
>  6 files changed, 65 insertions(+)
>  create mode 100644 qapi/tldr.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fa68810c1e..54265d987cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4780,3 +4780,4 @@ F: util/tldr.c
>  F: util/tldr-internal.h
>  F: include/qemu/tldr.h
>  F: tests/unit/test-util-tldr.c
> +F: qapi/tldr.json
> diff --git a/qapi/meson.build b/qapi/meson.build
> index a46269b5a0c..f8aecb61284 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -49,6 +49,7 @@ qapi_all_modules =3D [
>    'run-state',
>    'sockets',
>    'stats',
> +  'tldr',
>    'trace',
>    'transaction',
>    'vfio',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b93dd68d94c..b36777970d1 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -76,3 +76,4 @@
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
>  { 'include': 'uefi.json' }
> +{ 'include': 'tldr.json' }
> diff --git a/qapi/tldr.json b/qapi/tldr.json
> new file mode 100644
> index 00000000000..8e2b7cda324
> --- /dev/null
> +++ b/qapi/tldr.json
> @@ -0,0 +1,28 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=3Dpython
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# @QTLDRDumpOptions:
> +#     Options for `tldr-dump`.
> +#
> +# @target: the fully qualified file path to dump
> +#     the data recorder to

We're not dumping the data recorder, we're dumping recorded data.

> +#
> +# Since: 11.2.0
> +##
> +{ 'struct': 'QTLDRDumpOptions',
> +  'data': { 'target': 'str' } }
> +
> +##
> +# @tldr-dump:
> +#     Dump the data recorder to a file
> +#
> +# Since: 11.2.0
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "tldr-dump", "arguments": { "target": "/tmp/qemu.t=
xt" } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'tldr-dump', 'data': 'QTLDRDumpOptions' }

Why do you use a separate type for the arguments?

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2f63d86b635..5f96257cef0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6692,6 +6692,8 @@ SRST
>          recorder will be dumped to the stderr stream. If the
>          ``crash-target`` parameter was given, that specifies a fully
>          qualified file path to write the dump to instead of stderr.
> +        The ``tldr-dump`` QMP command can also be used at any time to
> +        save the captured data to an arbitrary file.
>=20=20
>          The ``tldr-config`` object can be added at initial startup
>          or via QMP at runtime. Once created, however, it is not
> diff --git a/util/tldr.c b/util/tldr.c
> index 13e9881bc9b..ea7c26b8e9b 100644
> --- a/util/tldr.c
> +++ b/util/tldr.c
> @@ -12,6 +12,7 @@
>  #include "qom/object.h"
>  #include "qom/object_interfaces.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-commands-tldr.h"
>=20=20
>  struct QTLDRConfig {
>      Object parent;
> @@ -436,3 +437,34 @@ qtldr_crash_dump_signal(siginfo_t *si)
>          close(fd);
>      }
>  }
> +
> +
> +/*
> + * WARNING: Code below this marker provides a QMP handler
> + * WARNING: for use in normal execution. It calls into
> + * WARNING: the common crash report outputting APIs, but
> + * WARNING: this specific method is not restricted to async
> + * WARNING: signal safe POSIX functions.
> + */

Why is this a WARNING WARNING WARNING?  Looks scary, then isn't.

Put it elsewhere, so the comment isn't needed?

> +
> +
> +void
> +qmp_tldr_dump(const char *target, Error **errp)
> +{
> +    int fd;
> +
> +    if (!qatomic_read(&qtldr_active)) {
> +        error_setg(errp, "No 'tldr-config' object has been creted");
> +        return;
> +    }
> +
> +    fd =3D qemu_create(target, O_WRONLY | O_TRUNC, 0600, errp);
> +    if (fd < 0) {
> +        return;
> +    }
> +
> +    qtldr_crash_dump_internal(fd, NULL);
> +
> +    qemu_fdatasync(fd);
> +    close(fd);
> +}


