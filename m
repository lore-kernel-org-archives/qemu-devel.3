Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1D606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q0tcfZsU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSA6-0004Ow-9Y; Thu, 29 Oct 2026 11:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMSA3-0004Lf-H2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMSA0-0005JA-Jg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793288123;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iv1U2dZd1BB1z1IQ2jlltvoEOnaBXVnyfqCjSRZ0Ez8=;
 b=Q0tcfZsUKlVkylvLqFYIVfHSrML0gV62O/+f7l05CPKe1joOVkAdjmBPeOFdhKgDmC47LL
 lY+R54V6zW8GRFtOlcaJdw8BLzIIMckA9zJvhEbG2wgkj60VXTU7TDEiXq0NDqdOTykY7F
 0A/qWaOFppThzjiDb19sAu8KyjtK1r0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-xCc49j7WNWCxI1uX8EDgyQ-1; Thu,
 29 Oct 2026 11:35:13 -0400
X-MC-Unique: xCc49j7WNWCxI1uX8EDgyQ-1
X-Mimecast-MFC-AGG-ID: xCc49j7WNWCxI1uX8EDgyQ_1793288112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF7EB19540CF; Thu, 29 Oct 2026 15:35:11 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6358C18004D2; Thu, 29 Oct 2026 15:35:08 +0000 (UTC)
Date: Thu, 29 Oct 2026 15:35:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 07/21] util: introduce 'tldr', a system data recorder for
 crash handling
Message-ID: <auNnqSCB-1fNrAlb@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-8-berrange@redhat.com>
 <87ecd8gba1.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecd8gba1.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 09:29:26AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Introduce a new subsystem "tldr" aka "thrifty live data recorder"
> > that will be able to continuously collect certain information at
> > runtime and dump that in a crash report when QEMU exits abnormally.
> > As a second use case, it will support manual triggering on interesting
> > events such as guest OS panic.
> 
> What's manual about that?

Manual in the sense that the mgmt app has to explicitly request
the data recorder contents when a guest OS panics, vs automatic
dump when QEMU dies with a fatal signal.

> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 49f222796ab..1c9031fba9a 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1233,6 +1233,19 @@
> >    'data': { '*pretty': 'bool',
> >              '*close-action': 'MonitorQMPCloseAction' } }
> >  
> > +##
> > +# @QTLDRConfigProperties:
> > +#     Configuration for data recorder
> > +#
> > +# @crash-target: fully qualified path to perserve data recorder
> > +#                contents on QEMU crash
> 
> What's a "fully qualified path"?
> 
> Do you mean what POSIX calls "absolute pathname"?

Yes.


> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 2f6863180b0..2f63d86b635 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -6682,6 +6682,20 @@ SRST
> >          ::
> >  
> >              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> > +
> > +
> > +    ``-object tldr-config,id=id,crash-target=path``
> > +        Creating the ``tldr-config`` object enables the thrifty live data
> > +        recorder, which continuously captures important information about
> > +        the operation of the QEMU process. When a SIGSEGV, SIGBUS,
> > +        SIGILL, SIGFPE or SIGABRT are seen the contents of the data
> > +        recorder will be dumped to the stderr stream. If the
> > +        ``crash-target`` parameter was given, that specifies a fully
> > +        qualified file path to write the dump to instead of stderr.
> > +
> > +        The ``tldr-config`` object can be added at initial startup
> > +        or via QMP at runtime. Once created, however, it is not
> > +        permitted to disable it.
> 
> Call the object "tldr"?

Yes, that's an option.

> > diff --git a/util/tldr-internal.h b/util/tldr-internal.h
> > new file mode 100644
> > index 00000000000..193d8425eee
> > --- /dev/null
> > +++ b/util/tldr-internal.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * TL;DR: Thrifty Live Data Recorder
> > + *
> > + * Copyright (C) 2026 Red Hat Inc.
> > + */
> > +
> > +#ifndef QEMU_TLDR_INTERNAL_H__
> > +#define QEMU_TLDR_INTERNAL_H__
> > +
> > +#include "qemu/tldr.h"
> > +
> > +#define QTLDR_DUMP_LEADER "\n🚨🚨🚨 QEMU Data Recorder Start 🚨🚨🚨\n"
> > +#define QTLDR_DUMP_TRAILER "\n🚨🚨🚨 QEMU Data Recorder End 🚨🚨🚨\n\n"
> > +#define QTLDR_DUMP_TRIGGER_PREFIX "\n🔍 Trigger:"
> > +#define QTLDR_DUMP_OPEN_ERROR "🔥 Unable to dump to '"
> 
> The emojis make the dump file UTF-8.  Fine, I guess?

Personally I consider UTF-8 to be acceptable/expected to work for
any OS platform since the mid 2000s, certainly for platforms that
QEMU targets.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


