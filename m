Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB6C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 07:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEkU6-0005tC-8R; Tue, 13 May 2025 03:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEkTx-0005sl-Q0
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEkTu-0002Lu-87
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747122916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9M1aGMEY8GGfR8Y/XSN4mu3UMt23cDLZfkfSrgCxMNA=;
 b=SEST2ud7qM6F4zH3VVnehOyKUq7UzOO0m1X1aUjlNK4nw1yd8XOUa8gw7p0AFFlB1w5MS5
 F+pUDzmqLDGnp3cDonLsu/p8u68MVys3JhEgBZIJjKYYVVAfPC56V8hbalPBoDdJu4oKar
 3BkVsCT8atwpnZOHvpwvmhCRB7Wf3TM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-vgi-3JnQPOueXi_ikJkoLA-1; Tue,
 13 May 2025 03:55:14 -0400
X-MC-Unique: vgi-3JnQPOueXi_ikJkoLA-1
X-Mimecast-MFC-AGG-ID: vgi-3JnQPOueXi_ikJkoLA_1747122913
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81D1E1955E7A; Tue, 13 May 2025 07:55:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A90CB30001A1; Tue, 13 May 2025 07:55:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F7C921E66C2; Tue, 13 May 2025 09:55:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/10] qapi: expose rtc-reset-reinjection command
 unconditionally
In-Reply-To: <aCI_A7ymWf-f3fOT@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 12 May 2025 19:33:39 +0100")
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-2-berrange@redhat.com>
 <87ldr4zt3d.fsf@pond.sub.org> <aCI_A7ymWf-f3fOT@redhat.com>
Date: Tue, 13 May 2025 09:55:10 +0200
Message-ID: <8734d9hrmp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, May 10, 2025 at 11:57:10AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > This removes the TARGET_I386 condition from the rtc-reset-reinjection
>> > command. This requires providing a QMP command stub for non-i386 targe=
t.
>> > This in turn requires moving the command out of misc-target.json, since
>> > that will trigger symbol poisoning errors when built from target
>> > independent code.
>> >
>> > Rather than putting the command into misc.json, it is proposed to crea=
te
>> > misc-$TARGET.json files to hold commands whose impl is conceptually
>> > only applicable to a single target. This gives an obvious docs hint to
>> > consumers that the command is only useful in relation a specific targe=
t,
>> > while misc.json is for commands applicable to 2 or more targets.
>>=20
>> Starting with this patch, the series structures the manual like this:
>>=20
>>     =3D Machines
>>     ... contents of machine.json ...
>>     =3D=3D Specific to S390
>>     ... contents of machine-s390.json ...
>>=20
>> and
>>=20
>>     =3D Miscellanea
>>     ... contents of misc.json ...
>>     =3D=3D Specific to ARM
>>     ... contents of misc-arm.json ...
>>     =3D=3D Specific to i386
>>     ... contents of misc-i386.json ...
>>=20
>> Except it doesn't add =3D=3D subsection headers, but that's detail.  The
>> text I show for them here is crap.
>>=20
>> Possible alternative: collect the target-specific stuff in one place
>> rather than two:
>>=20
>>     =3D Targets
>>     =3D=3D ARM
>>     =3D=3D i386
>>     =3D=3D S390
>>=20
>> Again the header text is crap.
>>=20
>> Is separating the current contents of misc-<target>.json from
>> machine-<target>.json useful?
>
> I'm fairly confused what the intended difference is between
> stuff in 'misc.json' and stuff in 'machine.json' already,
> and just preserved that split rather than try to think about
> it in more detail.

Fair enough, we can always rearrange things on top.

>> > The current impl of qmp_rtc_reset_reinject() is a no-op if the i386
>> > RTC is disabled in Kconfig, or if the running machine type lack any
>> > RTC device. Thus the stub impl for non-i386 targets retains this
>> > no-op behaviour, instead of reporting a Error which is the more usual
>> > choice for commands invoked against unsupported configurations.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

>> > diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
>> > new file mode 100644
>> > index 0000000000..d5bfd91405
>> > --- /dev/null
>> > +++ b/qapi/misc-i386.json
>> > @@ -0,0 +1,24 @@
>> > +# -*- Mode: Python -*-
>> > +# vim: filetype=3Dpython
>> > +#
>> > +# SPDX-License-Identifier: GPL-2.0-or-later
>>=20
>> Might be cleaner to add this to all qapi/*.json first, and in a separate
>> patch.
>
> Adding SPDX-License-Identifier to existing files is something we're
> not generally doing, only newly created files are getting it.

I see.

Code motion between files where the license isn't obviously the same
gives me pause.

>> > +
>> > +##
>> > +# @rtc-reset-reinjection:
>> > +#
>> > +# This command will reset the RTC interrupt reinjection backlog.  Can
>> > +# be used if another mechanism to synchronize guest time is in effect,
>> > +# for example QEMU guest agent's guest-set-time command.
>> > +#
>> > +# Use of this command is only applicable for x86 machines with an RTC,
>> > +# and on other machines will silently return without performing any
>> > +# action.
>>=20
>> This paragraph replaces ...
>>=20
>> > +#
>> > +# Since: 2.1
>> > +#
>> > +# .. qmp-example::
>> > +#
>> > +#     -> { "execute": "rtc-reset-reinjection" }
>> > +#     <- { "return": {} }
>> > +##
>> > +{ 'command': 'rtc-reset-reinjection' }
>> > diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> > index 42e4a7417d..5d0ffb0164 100644
>> > --- a/qapi/misc-target.json
>> > +++ b/qapi/misc-target.json
>> > @@ -2,23 +2,6 @@
>> >  # vim: filetype=3Dpython
>> >  #
>> >=20=20
>> > -##
>> > -# @rtc-reset-reinjection:
>> > -#
>> > -# This command will reset the RTC interrupt reinjection backlog.  Can
>> > -# be used if another mechanism to synchronize guest time is in effect,
>> > -# for example QEMU guest agent's guest-set-time command.
>> > -#
>> > -# Since: 2.1
>> > -#
>> > -# .. qmp-example::
>> > -#
>> > -#     -> { "execute": "rtc-reset-reinjection" }
>> > -#     <- { "return": {} }
>> > -##
>> > -{ 'command': 'rtc-reset-reinjection',
>> > -  'if': 'TARGET_I386' }
>>=20
>> ... the conditional.
>>=20
>> Before, attempting to execute the command fails with CommandNotFound.
>>=20
>> Afterwards it succeeds without doing anything.  I think it should fail
>> instead.  CommandNotFound would be a lie, so change it to GenericError.
>
> See also my comment in the commit message that this has different
> behaviour on x86 vs non-x86, when no RTC is present - x86 treats
> "no RTC" as a no-op, but non-x86 treats it as an error.
>
> I don't mind if we preserve this inconsistency though.

I see.

The command is a mess.  It goes back to commit f2ae8abf1fa (mc146818rtc:
add rtc-reset-reinjection QMP command).  Here's the commit message's
rationale:

    It is necessary to reset RTC interrupt reinjection backlog if
    guest time is synchronized via a different mechanism, such as
    QGA's guest-set-time command.
=20=20=20=20
    Failing to do so causes both corrections to be applied (summed),
    resulting in an incorrect guest time.

Plausible enough, but why is the solution limited to target i386
machines with an MC146818 RTC?  I think I found the answer in recent
commit d0be0ac2c37 (hw/i386: move rtc-reset-reinjection command out of
hw/rtc):

    The rtc-reset-reinjection QMP command is specific to x86, other boards =
do not
    have the ACK tracking functionality that is needed for RTC interrupt
    reinjection.  Therefore the QMP command is only included in x86, but
    qmp_rtc_reset_reinjection() is implemented by hw/rtc/mc146818rtc.c
    and requires tracking of all created RTC devices.  Move the implementat=
ion
    to hw/i386, so that 1) it is available even if no RTC device exist
    2) the only RTC that exists is easily found in x86ms->rtc.

So, the time sync problem is serious enough for us to provide a
solution, but it's only serious enough for i386 machines that use the
RTC most common there.  This makes no sense to me.

Code:

    void qmp_rtc_reset_reinjection(Error **errp)
    {
        X86MachineState *x86ms =3D X86_MACHINE(qdev_get_machine());

    #ifdef CONFIG_MC146818RTC
        if (x86ms->rtc) {
            rtc_reset_reinjection(MC146818_RTC(x86ms->rtc));
        }
    #else
        assert(!x86ms->rtc);
    #endif
    }

Behavior:

* target other than i386: CommandNotFound

* else if the machine's ->rtc is null: silently do nothing

* else if CONFIG_MC146818RTC: works as advertized as long ->rtc is an
  MC146818, else crash

* else: crash

WTF!?!

>> > diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
>> > new file mode 100644
>> > index 0000000000..ee2e60d95b
>> > --- /dev/null
>> > +++ b/stubs/monitor-i386-rtc.c
>> > @@ -0,0 +1,10 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qapi/error.h"
>> > +#include "qapi/qapi-commands-misc-i386.h"
>> > +
>> > +void qmp_rtc_reset_reinjection(Error **errp)
>> > +{
>> > +    /* Nothing to do since non-x86 machines lack an RTC */

The comment is wrong: pretty much all machines do have a real time
clock.

>> > +}
>>=20
>> I think I'd create one stub file per qapi/<foo>-<target>.json.
>
> That's what I started doing but I forgot that doesn't work out well
> with the linker.
>
> The linker's granularity for dropping stubs is per-file, not per-symbol.
>
> If /any/ method in a stub/nnn.c file is needed, the linker will pull in
> all methods. This results in duplicate symbol errors if only a subset
> of stub methods were actually needed.
>
> This forces us to have a separate stub file per build configuration
> scenario that can affect use of stubs.

You're right.


