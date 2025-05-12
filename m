Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61B0C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXyO-0001Nd-0p; Mon, 12 May 2025 14:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEXyN-0001NU-1I
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEXyI-0003l8-DG
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747074827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gu/osO7xx5SuJYbmUtWb5U0BaLQTz2o+OZLEvswXu7o=;
 b=EQvRoGHdqpP8IKBfQhRf2MamTyQJkH9GwfLrfX9is+MGCE0cSRIWk2HWUdfZeXsgSaPeln
 tiL1QHAD/PLkCvpGfooZR112lMBc6Mk6z/YL+U6hZPnaNV2xmCtZD/FY8UfY7zc3Gr1VGA
 xM7vtsF2ncK/aHJ6Vl/I4zUoc1daKrw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-in2AkurANNiVaqV5rgpX_w-1; Mon,
 12 May 2025 14:33:46 -0400
X-MC-Unique: in2AkurANNiVaqV5rgpX_w-1
X-Mimecast-MFC-AGG-ID: in2AkurANNiVaqV5rgpX_w_1747074824
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1A191955DE8; Mon, 12 May 2025 18:33:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02391195396E; Mon, 12 May 2025 18:33:42 +0000 (UTC)
Date: Mon, 12 May 2025 19:33:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/10] qapi: expose rtc-reset-reinjection command
 unconditionally
Message-ID: <aCI_A7ymWf-f3fOT@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-2-berrange@redhat.com>
 <87ldr4zt3d.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldr4zt3d.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, May 10, 2025 at 11:57:10AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This removes the TARGET_I386 condition from the rtc-reset-reinjection
> > command. This requires providing a QMP command stub for non-i386 target.
> > This in turn requires moving the command out of misc-target.json, since
> > that will trigger symbol poisoning errors when built from target
> > independent code.
> >
> > Rather than putting the command into misc.json, it is proposed to create
> > misc-$TARGET.json files to hold commands whose impl is conceptually
> > only applicable to a single target. This gives an obvious docs hint to
> > consumers that the command is only useful in relation a specific target,
> > while misc.json is for commands applicable to 2 or more targets.
> 
> Starting with this patch, the series structures the manual like this:
> 
>     = Machines
>     ... contents of machine.json ...
>     == Specific to S390
>     ... contents of machine-s390.json ...
> 
> and
> 
>     = Miscellanea
>     ... contents of misc.json ...
>     == Specific to ARM
>     ... contents of misc-arm.json ...
>     == Specific to i386
>     ... contents of misc-i386.json ...
> 
> Except it doesn't add == subsection headers, but that's detail.  The
> text I show for them here is crap.
> 
> Possible alternative: collect the target-specific stuff in one place
> rather than two:
> 
>     = Targets
>     == ARM
>     == i386
>     == S390
> 
> Again the header text is crap.
> 
> Is separating the current contents of misc-<target>.json from
> machine-<target>.json useful?

I'm fairly confused what the intended difference is between
stuff in 'misc.json' and stuff in 'machine.json' already,
and just preserved that split rather than try to think about
it in more detail.


> > diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
> > new file mode 100644
> > index 0000000000..d5bfd91405
> > --- /dev/null
> > +++ b/qapi/misc-i386.json
> > @@ -0,0 +1,24 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> 
> Might be cleaner to add this to all qapi/*.json first, and in a separate
> patch.

Adding SPDX-License-Identifier to existing files is something we're
not generally doing, only newly created files are getting it.


> > +
> > +##
> > +# @rtc-reset-reinjection:
> > +#
> > +# This command will reset the RTC interrupt reinjection backlog.  Can
> > +# be used if another mechanism to synchronize guest time is in effect,
> > +# for example QEMU guest agent's guest-set-time command.
> > +#
> > +# Use of this command is only applicable for x86 machines with an RTC,
> > +# and on other machines will silently return without performing any
> > +# action.
> 
> This paragraph replaces ...
> 
> > +#
> > +# Since: 2.1
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "rtc-reset-reinjection" }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'rtc-reset-reinjection' }
> > diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> > index 42e4a7417d..5d0ffb0164 100644
> > --- a/qapi/misc-target.json
> > +++ b/qapi/misc-target.json
> > @@ -2,23 +2,6 @@
> >  # vim: filetype=python
> >  #
> >  
> > -##
> > -# @rtc-reset-reinjection:
> > -#
> > -# This command will reset the RTC interrupt reinjection backlog.  Can
> > -# be used if another mechanism to synchronize guest time is in effect,
> > -# for example QEMU guest agent's guest-set-time command.
> > -#
> > -# Since: 2.1
> > -#
> > -# .. qmp-example::
> > -#
> > -#     -> { "execute": "rtc-reset-reinjection" }
> > -#     <- { "return": {} }
> > -##
> > -{ 'command': 'rtc-reset-reinjection',
> > -  'if': 'TARGET_I386' }
> 
> ... the conditional.
> 
> Before, attempting to execute the command fails with CommandNotFound.
> 
> Afterwards it succeeds without doing anything.  I think it should fail
> instead.  CommandNotFound would be a lie, so change it to GenericError.

See also my comment in the commit message that this has different
behaviour on x86 vs non-x86, when no RTC is present - x86 treats
"no RTC" as a no-op, but non-x86 treats it as an error.

I don't mind if we preserve this inconsistency though.


> > diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
> > new file mode 100644
> > index 0000000000..ee2e60d95b
> > --- /dev/null
> > +++ b/stubs/monitor-i386-rtc.c
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qapi-commands-misc-i386.h"
> > +
> > +void qmp_rtc_reset_reinjection(Error **errp)
> > +{
> > +    /* Nothing to do since non-x86 machines lack an RTC */
> > +}
> 
> I think I'd create one stub file per qapi/<foo>-<target>.json.

That's what I started doing but I forgot that doesn't work out well
with the linker.

The linker's granularity for dropping stubs is per-file, not per-symbol.

If /any/ method in a stub/nnn.c file is needed, the linker will pull in
all methods. This results in duplicate symbol errors if only a subset
of stub methods were actually needed.

This forces us to have a separate stub file per build configuration
scenario that can affect use of stubs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


