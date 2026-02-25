Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077DCFD3776
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvJ3U-0004RX-Jf; Wed, 25 Feb 2026 12:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvJ3F-0004Le-CX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvJ3B-0006gH-Gl
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772041911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fouLb1AyMieRDapitL3C+TjPohhV6a4iNuE3Iflfv0=;
 b=QrfW01EVxesc5sG0BH64s378aHuJsP8+8rBZ8HuJopCxynfS0ewEFxx8DseQWlitum77Iz
 GoDM+ihWtiv1fPNdinAcIXWvarsmmgSxxMMllyFe1WYbsquIVDEn6y3ANsDnmgEgSSJjA9
 IgqAlO6dLigEgN/wChKb1pRvOP2ZJIc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-J4NKIIygOVKPcTemxOZWOA-1; Wed,
 25 Feb 2026 12:51:47 -0500
X-MC-Unique: J4NKIIygOVKPcTemxOZWOA-1
X-Mimecast-MFC-AGG-ID: J4NKIIygOVKPcTemxOZWOA_1772041905
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3961518004BB; Wed, 25 Feb 2026 17:51:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B7953003D91; Wed, 25 Feb 2026 17:51:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4E3221E692D; Wed, 25 Feb 2026 18:51:41 +0100 (CET)
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
Subject: Re: [PATCH v6 22/27] util: introduce common helper for error-report
 & log code
In-Reply-To: <aZ8gui1kR5mRDVHx@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 25 Feb 2026 16:18:02 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-23-berrange@redhat.com>
 <87342yb120.fsf@pond.sub.org> <aZ8gui1kR5mRDVHx@redhat.com>
Date: Wed, 25 Feb 2026 18:51:41 +0100
Message-ID: <87pl5siudu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Feb 18, 2026 at 03:04:23PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The error-report and log code both have a need to add prefixes
>> > to messages they are printing, with the current example being
>> > a timestamp.
>> >
>> > The format and configuration they use should be consistent, so
>> > providing a common helper will ensure this is always the case.
>> > Initially the helper only emits a timestamp, but future patches
>> > will expand this.
>> >
>> > This takes the liberty of assigning the new file to the same
>> > maintainer as the existing error-report.c file, given it will
>> > be extracting some functionality from the latter.
>>=20
>> Fair.
>>=20
>> > While vreport() dynamically changes between reporting to the
>> > monitor vs stderr, depending on whether HMP is active or not,
>> > message prefixes are only ever used in the non-HMP case. Thus
>> > the helper API can take a FILE * object and not have to deal
>> > with the monitor at all.
>> >
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  MAINTAINERS            |  2 ++
>> >  include/qemu/message.h | 28 ++++++++++++++++++++++++++++
>> >  util/meson.build       |  1 +
>> >  util/message.c         | 23 +++++++++++++++++++++++
>> >  4 files changed, 54 insertions(+)
>> >  create mode 100644 include/qemu/message.h
>> >  create mode 100644 util/message.c
>
> snip
>
>> > diff --git a/util/message.c b/util/message.c
>> > new file mode 100644
>> > index 0000000000..99a403f9d0
>> > --- /dev/null
>> > +++ b/util/message.c
>> > @@ -0,0 +1,23 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> > +
>> > +#include "qemu/osdep.h"
>> > +
>> > +#include "qemu/message.h"
>> > +#include "monitor/monitor.h"
>>=20
>> Superfluous #include.
>>=20
>> It'll become used in PATCH 26, for qemu_thread_get_name().  Should
>> include qemu/thread.h there instead.
>
> opps, yes.
>
>> > +
>> > +static int message_format;
>> > +
>> > +void qmessage_set_format(int flags)
>> > +{
>> > +    message_format =3D flags;
>> > +}
>> > +
>> > +void qmessage_context_print(FILE *fp)
>> > +{
>> > +    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
>> > +        g_autoptr(GDateTime) dt =3D g_date_time_new_now_utc();
>> > +        g_autofree char *timestr =3D g_date_time_format_iso8601(dt);
>> > +        fputs(timestr, fp);
>> > +        fputc(' ', fp);
>>=20
>> The context string is either empty, or it ends with a space, for ease of
>> use.  Okay.
>>=20
>> I'd go for
>>=20
>>            fprintf(fp, "%s ", timestr);
>
> Previous reviewer comments preferred fputs/c to avoid
> redundant printf string interpolation since qemu_log
> could be used in fairly hot code paths  at times.

Looking at the bright side (for you): you get to pick the reviewer to
side with!

>> > +    }
>> > +}
>>=20
>> Alright, everybody's favorite topic: naming.
>>=20
>> message.[ch] aren't about messages, but message *prefixes*.  You call
>> them "context" in qmessage_context_print().  I'm fine with "context".
>
> The use of "message" was a somewhat forward looking thing, guessing
> at possible other needs related to message ouput.
>
> In particular I think there's scope for the Location handling APIs to
> be in this file instead of error-report.c.
>
> So one could imagine  qmessage_loc_push/pop  APis later.
>
>> External symbols are prefixed with qmessage_.  I prefer such prefixes to
>> match the filename.
>
> My view is that they do match if you pretend the 'q' is implicit by
> this living inside qemu.git ;-P
>
>> Prefix in util/ overwhelmingly start with qemu_.
>
> Naturally my choice was based on what I've previously done for
> naming in io/, crypto/ and auth/, etc where all the C APIs have
> a leading 'q' to scope them to QEMU, but this is omitted in the
> directory/file names :-)

I like local consistency.

Actually, I'd like global consistency, but that's a lost cause in QEMU.

>> Somewhat long prefixes feel okay here, as these symbols are used only a
>> couple of times.  qemu_message_context_ might be too long, though.
>>=20
>> Could use the classic technique of murdering vowels: to qemu_msg_ctxt_.
>>=20
>> Thoughts?
>
> IMHO, despite the existing usage in util/, "qemu_" is overkill as a
> naming prefix.

qemu_msg_ is exactly as long as qmessage_.  If one is overkill, so is
the other :)

> A plain 'q' prefix is most liable to clash with "Qt" library functions,
> but we don't consume that in QEMU so largely not neccessary to worry
> about unless perhaps dragged in indirectly via a 3rd party dep
>
> With regards,
> Daniel


