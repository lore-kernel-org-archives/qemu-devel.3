Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221D606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fahvm2F2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMLVz-0002hz-Pr; Thu, 29 Oct 2026 04:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMLVy-0002hr-1e
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMLVw-0000Es-85
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793262573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKNcAJz3sISh+OBOhDJnM0A4M2G7581aRLKjwyVUh94=;
 b=Fahvm2F2oJY6MJbbgAQcABv9oG/11aLl5fryxnbnnHlvjI5s3ZLv+A1DRIExOdaWqsn+Ik
 D9PD/I2lodiYNMCe+t62pSvBzL7RfUGKw3TttOj1/aDQagepE+nfqvSXNB8uZF3UvVZXrO
 7Y+xGyr1+nWcwgOwC1BN1UzkbovLb3I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-rB2iujWUMQ614rNQHGIexQ-1; Thu,
 29 Oct 2026 04:29:31 -0400
X-MC-Unique: rB2iujWUMQ614rNQHGIexQ-1
X-Mimecast-MFC-AGG-ID: rB2iujWUMQ614rNQHGIexQ_1793262570
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03589180059B; Thu, 29 Oct 2026 08:29:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04CE930002CF; Thu, 29 Oct 2026 08:29:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A133221E6A04; Thu, 29 Oct 2026 09:29:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake
 <eblake@redhat.com>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 07/21] util: introduce 'tldr', a system data recorder
 for crash handling
In-Reply-To: <20261015112044.1999748-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 15 Oct 2026 12:20:30
 +0100")
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-8-berrange@redhat.com>
Date: Thu, 29 Oct 2026 09:29:26 +0100
Message-ID: <87ecd8gba1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Introduce a new subsystem "tldr" aka "thrifty live data recorder"
> that will be able to continuously collect certain information at
> runtime and dump that in a crash report when QEMU exits abnormally.
> As a second use case, it will support manual triggering on interesting
> events such as guest OS panic.

What's manual about that?

> Initially the framework does nothing except print the signal
> information. Later commits will introduce broader data collection.
> This relies on the dummy siginfo_t struct for portability to Windows.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 49f222796ab..1c9031fba9a 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1233,6 +1233,19 @@
>    'data': { '*pretty': 'bool',
>              '*close-action': 'MonitorQMPCloseAction' } }
>=20=20
> +##
> +# @QTLDRConfigProperties:
> +#     Configuration for data recorder
> +#
> +# @crash-target: fully qualified path to perserve data recorder
> +#                contents on QEMU crash

What's a "fully qualified path"?

Do you mean what POSIX calls "absolute pathname"?

Please format member descriptions like this:

   # @crash-target: fully qualified path to perserve data recorder
   #     contents on QEMU crash

> +#
> +# Since: 11.2.0
> +##
> +{ 'struct': 'QTLDRConfigProperties',
> +  'data': { '*crash-target': 'str' }
> +}
> +
>  ##
>  # @ObjectType:
>  #
> @@ -1302,6 +1315,7 @@
>      's390-pv-guest',
>      'tdx-guest',
>      'throttle-group',
> +    'tldr-config',
>      'tls-creds-anon',
>      'tls-creds-psk',
>      'tls-creds-x509',
> @@ -1379,6 +1393,7 @@
>        'tdx-guest':                  'TdxGuestProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
> +      'tldr-config':                'QTLDRConfigProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',
>        'tls-creds-psk':              'TlsCredsPskProperties',
>        'tls-creds-x509':             'TlsCredsX509Properties',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2f6863180b0..2f63d86b635 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6682,6 +6682,20 @@ SRST
>          ::
>=20=20
>              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> +
> +
> +    ``-object tldr-config,id=3Did,crash-target=3Dpath``
> +        Creating the ``tldr-config`` object enables the thrifty live data
> +        recorder, which continuously captures important information about
> +        the operation of the QEMU process. When a SIGSEGV, SIGBUS,
> +        SIGILL, SIGFPE or SIGABRT are seen the contents of the data
> +        recorder will be dumped to the stderr stream. If the
> +        ``crash-target`` parameter was given, that specifies a fully
> +        qualified file path to write the dump to instead of stderr.
> +
> +        The ``tldr-config`` object can be added at initial startup
> +        or via QMP at runtime. Once created, however, it is not
> +        permitted to disable it.

Call the object "tldr"?

>  ERST
>=20=20
>=20=20

[...]

> diff --git a/util/tldr-internal.h b/util/tldr-internal.h
> new file mode 100644
> index 00000000000..193d8425eee
> --- /dev/null
> +++ b/util/tldr-internal.h
> @@ -0,0 +1,21 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * TL;DR: Thrifty Live Data Recorder
> + *
> + * Copyright (C) 2026 Red Hat Inc.
> + */
> +
> +#ifndef QEMU_TLDR_INTERNAL_H__
> +#define QEMU_TLDR_INTERNAL_H__
> +
> +#include "qemu/tldr.h"
> +
> +#define QTLDR_DUMP_LEADER "\n=F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8 QEMU D=
ata Recorder Start =F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8\n"
> +#define QTLDR_DUMP_TRAILER "\n=F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8 QEMU =
Data Recorder End =F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8\n\n"
> +#define QTLDR_DUMP_TRIGGER_PREFIX "\n=F0=9F=94=8D Trigger:"
> +#define QTLDR_DUMP_OPEN_ERROR "=F0=9F=94=A5 Unable to dump to '"

The emojis make the dump file UTF-8.  Fine, I guess?

> +
> +void qtldr_crash_dump_internal(int fd, siginfo_t *si);
> +
> +#endif /* QEMU_TLDR_INTERNAL_H__ */

[...]


