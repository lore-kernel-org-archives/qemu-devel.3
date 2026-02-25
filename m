Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE14FFD3772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHap-0005Wk-AE; Wed, 25 Feb 2026 11:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHan-0005W7-86
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHal-0005WX-2f
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772036305;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R27996lVvl/s4LVxlDfB3oEaWl5JadXUCVbdiXR9RxM=;
 b=QNePCXgA800mVE7cLAAURdblBePVayoYUleWfQpoqo5r+5fzDXp4pUTnRCC4nUBNpbPTrV
 hrWrvIGW4KS+7aNdsS8UWGr5IK2baMfL01evqO+0fgrSJgYG6mD932oRB8o/sy+osJBG73
 itBfxolY1s2B5tNkXiK5Eknxm6dw26M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-H-NyjRDLPwev-X5gWX2SfQ-1; Wed,
 25 Feb 2026 11:18:15 -0500
X-MC-Unique: H-NyjRDLPwev-X5gWX2SfQ-1
X-Mimecast-MFC-AGG-ID: H-NyjRDLPwev-X5gWX2SfQ_1772036292
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 099BC1955F23; Wed, 25 Feb 2026 16:18:12 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4761800352; Wed, 25 Feb 2026 16:18:05 +0000 (UTC)
Date: Wed, 25 Feb 2026 16:18:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 22/27] util: introduce common helper for error-report
 & log code
Message-ID: <aZ8gui1kR5mRDVHx@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-23-berrange@redhat.com>
 <87342yb120.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87342yb120.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 18, 2026 at 03:04:23PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The error-report and log code both have a need to add prefixes
> > to messages they are printing, with the current example being
> > a timestamp.
> >
> > The format and configuration they use should be consistent, so
> > providing a common helper will ensure this is always the case.
> > Initially the helper only emits a timestamp, but future patches
> > will expand this.
> >
> > This takes the liberty of assigning the new file to the same
> > maintainer as the existing error-report.c file, given it will
> > be extracting some functionality from the latter.
> 
> Fair.
> 
> > While vreport() dynamically changes between reporting to the
> > monitor vs stderr, depending on whether HMP is active or not,
> > message prefixes are only ever used in the non-HMP case. Thus
> > the helper API can take a FILE * object and not have to deal
> > with the monitor at all.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  MAINTAINERS            |  2 ++
> >  include/qemu/message.h | 28 ++++++++++++++++++++++++++++
> >  util/meson.build       |  1 +
> >  util/message.c         | 23 +++++++++++++++++++++++
> >  4 files changed, 54 insertions(+)
> >  create mode 100644 include/qemu/message.h
> >  create mode 100644 util/message.c

snip

> > diff --git a/util/message.c b/util/message.c
> > new file mode 100644
> > index 0000000000..99a403f9d0
> > --- /dev/null
> > +++ b/util/message.c
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "qemu/message.h"
> > +#include "monitor/monitor.h"
> 
> Superfluous #include.
> 
> It'll become used in PATCH 26, for qemu_thread_get_name().  Should
> include qemu/thread.h there instead.

opps, yes.

> > +
> > +static int message_format;
> > +
> > +void qmessage_set_format(int flags)
> > +{
> > +    message_format = flags;
> > +}
> > +
> > +void qmessage_context_print(FILE *fp)
> > +{
> > +    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
> > +        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> > +        g_autofree char *timestr = g_date_time_format_iso8601(dt);
> > +        fputs(timestr, fp);
> > +        fputc(' ', fp);
> 
> The context string is either empty, or it ends with a space, for ease of
> use.  Okay.
> 
> I'd go for
> 
>            fprintf(fp, "%s ", timestr);

Previous reviewer comments preferred fputs/c to avoid
redundant printf string interpolation since qemu_log
could be used in fairly hot code paths  at times.

> 
> > +    }
> > +}
> 
> Alright, everybody's favorite topic: naming.
> 
> message.[ch] aren't about messages, but message *prefixes*.  You call
> them "context" in qmessage_context_print().  I'm fine with "context".

The use of "message" was a somewhat forward looking thing, guessing
at possible other needs related to message ouput.

In particular I think there's scope for the Location handling APIs to
be in this file instead of error-report.c.

So one could imagine  qmessage_loc_push/pop  APis later.

> External symbols are prefixed with qmessage_.  I prefer such prefixes to
> match the filename.

My view is that they do match if you pretend the 'q' is implicit by
this living inside qemu.git ;-P

> Prefix in util/ overwhelmingly start with qemu_.

Naturally my choice was based on what I've previously done for
naming in io/, crypto/ and auth/, etc where all the C APIs have
a leading 'q' to scope them to QEMU, but this is omitted in the
directory/file names :-)

> Somewhat long prefixes feel okay here, as these symbols are used only a
> couple of times.  qemu_message_context_ might be too long, though.
> 
> Could use the classic technique of murdering vowels: to qemu_msg_ctxt_.
> 
> Thoughts?

IMHO, despite the existing usage in util/, "qemu_" is overkill as a
naming prefix.

A plain 'q' prefix is most liable to clash with "Qt" library functions,
but we don't consume that in QEMU so largely not neccessary to worry
about unless perhaps dragged in indirectly via a 3rd party dep

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


