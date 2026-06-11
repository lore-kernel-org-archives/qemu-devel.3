Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7B4CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgWh-0006AG-5H; Thu, 11 Jun 2026 10:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXgWf-00069i-Bh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:36:57 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXgWd-0002rG-9P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:36:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A5C175DD3;
 Thu, 11 Jun 2026 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781188613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98e91pVuWmQXgXSR9efovE49gh5elHJ4VtQUj2ALPSc=;
 b=gSoYlhi4gmGdRBN4cf4VUternMd3qMvvOH9ATldmJOJV6GIbWKSTViY63MY8QMgV93njL9
 s1O0ZDDfxVs9qEYGL72lZaQPHbFW0b4Z4Ny9XS0LrrBb9RCiwDYqevENTpA6ftwi35ocfP
 ADU1gSkGPWjUgzUl9NMY6LqgJan2vQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781188613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98e91pVuWmQXgXSR9efovE49gh5elHJ4VtQUj2ALPSc=;
 b=J46yJcOxKRRWmTeVDhPyC1+Y5w2XoVHQeQIw31Gugs8iQrXxF5q9etI+tFV5gFymxU0JOp
 6mvlc0m1rUPn9bCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781188613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98e91pVuWmQXgXSR9efovE49gh5elHJ4VtQUj2ALPSc=;
 b=gSoYlhi4gmGdRBN4cf4VUternMd3qMvvOH9ATldmJOJV6GIbWKSTViY63MY8QMgV93njL9
 s1O0ZDDfxVs9qEYGL72lZaQPHbFW0b4Z4Ny9XS0LrrBb9RCiwDYqevENTpA6ftwi35ocfP
 ADU1gSkGPWjUgzUl9NMY6LqgJan2vQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781188613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98e91pVuWmQXgXSR9efovE49gh5elHJ4VtQUj2ALPSc=;
 b=J46yJcOxKRRWmTeVDhPyC1+Y5w2XoVHQeQIw31Gugs8iQrXxF5q9etI+tFV5gFymxU0JOp
 6mvlc0m1rUPn9bCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA9E2779A7;
 Thu, 11 Jun 2026 14:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zEH4IATIKmqYWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jun 2026 14:36:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Peter Maydell
 <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini <pbonzini@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Sana Sharma <sansshar@redhat.com>, =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
In-Reply-To: <aiq9g60bOnvsOQOy@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com> <aimNv51iMZ_yEgDG@redhat.com>
 <aimvTYDsv_-Xsboy@x1.local> <aiq9g60bOnvsOQOy@redhat.com>
Date: Thu, 11 Jun 2026 11:36:46 -0300
Message-ID: <87h5n94001.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, gnu.org:url,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Wed, Jun 10, 2026 at 02:39:09PM -0400, Peter Xu wrote:
>> On Wed, Jun 10, 2026 at 05:15:59PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> > On Tue, Jun 09, 2026 at 01:25:09PM -0400, Peter Xu wrote:
>> > > Create object-property-ptr.[ch] files to include all the helpers for
>> > > object_property_add*_ptr().
>> > >=20
>> > > These set of helpers are handy because they look extremely familiar =
with
>> > > qdev-properties, allowing the caller to provide a pointer and it will
>> > > manage all the setters and getters.
>> > >=20
>> > > The follow up patches may introduce more of such helpers.  Since obj=
ect.c
>> > > has been already too big, split that part out.
>> >=20
>> > The "ptr" helpers are all instance level properties which is a concept
>> > we discourage from new usage, in favour of class level properties.
>> >=20
>> > I don't think we should be adding more "ptr" helpers, but rather
>> > planning to eliminiate the (surprisingly little) usage of the
>> > existing ones.
>>=20
>> The other way to do similar thing is qdev's offset way, but IMHO that's
>> more awkward to remember an offset of a pointer then do math everytime.
>> Essentially, from technical pov we need at least one uintptr_t to store
>> either (1) offset, or (2) field pointer when there's a field that is bou=
nd
>> to a prop.  IMHO (2) can be better otherwise we'll need to do all the ma=
ths
>> to calculate offsets then when access we add the offset back and do a fo=
rce
>> cast.  It seems not necessary.
>
> There shouldn't be any need to play with field offsets either. Just
> define the setters & getters to directly access the fields.
>
> Take some samples from the "machine_class_init" in hw/core/machine.c
> as an example of the normal design pattern:
>
>     object_class_property_add_str(oc, "dumpdtb",
>         machine_get_dumpdtb, machine_set_dumpdtb);
>     object_class_property_set_description(oc, "dumpdtb",
>         "Dump current dtb to a file and quit");
>
>    ..snip..
>
>     object_class_property_add_bool(oc, "dump-guest-core",
>         machine_get_dump_guest_core, machine_set_dump_guest_core);
>     object_class_property_set_description(oc, "dump-guest-core",
>         "Include guest memory in a core dump");
>
> These are paired with:
>
>   static char *machine_get_dumpdtb(Object *obj, Error **errp)
>   {
>       MachineState *ms =3D MACHINE(obj);
>
>       return g_strdup(ms->dumpdtb);
>   }
>
>   static void machine_set_dumpdtb(Object *obj, const char *value, Error *=
*errp)
>   {
>       MachineState *ms =3D MACHINE(obj);
>
>       g_free(ms->dumpdtb);
>       ms->dumpdtb =3D g_strdup(value);
>   }
>
> and
>
>   static bool machine_get_dump_guest_core(Object *obj, Error **errp)
>   {
>       MachineState *ms =3D MACHINE(obj);
>
>       return ms->dump_guest_core;
>   }
>
>   static void machine_set_dump_guest_core(Object *obj, bool value, Error =
**errp)
>   {
>       MachineState *ms =3D MACHINE(obj);
>
>       if (!value && QEMU_MADV_DONTDUMP =3D=3D QEMU_MADV_INVALID) {
>           error_setg(errp, "Dumping guest memory cannot be disabled on th=
is host");
>           return;
>       }
>       ms->dump_guest_core =3D value;
>   }
>
>
> and defaults (if needed) are set in  the instance init method:
>
>   static void machine_initfn(Object *obj)
>   {
>       MachineState *ms =3D MACHINE(obj);
>       MachineClass *mc =3D MACHINE_GET_CLASS(obj);
>
>       ms->dump_guest_core =3D true;
>       ms->mem_merge =3D (QEMU_MADV_MERGEABLE !=3D QEMU_MADV_INVALID);
>       ...
>   }
>

Thanks for the practical example. In this usage, do you think there
would be a way to avoid having 53 getters and setters? We often run into
this issue of the rest of QEMU having just a handful of options and
migration having a ton. Anything we can do to streamline this would be
good.

>> OTOH, I still see value on non-class instance properties (that sometimes=
 we
>> don't even want to have some props avail for the class, but conditional =
to
>> some instances when created dynamically).  If that is needed, IMHO it's
>> fine we still provide per-instance properties.
>
> Conditionally registering properties on instances is an anti-pattern
> IMHO. It results in objects that cannot have all their properties
> statically introspected.
>
> If a class needs different subsets of properties for different
> scenarios, that is potentially a sign there ought to be a base
> class and two or more specialized subclasses. Or that the
> property needs a more explicit "unset" state in addition to
> its other valid values.
>
> For introspection we hack around the use of instance properties
> by instantiating every object in order to trigger registration of
> instance props.  This is such a gross hack that it periodically=20
> suffers crashes from objects not expecting to be instantiated
> in this context and having undesired side-effects. Class props
> are the only sane way to reliably provide introspection without
> side-effects.
>
>> Is there any pointer I can read about the discussion previously on this?
>
> I don't know that there's a particular thread in recent times
> that I'd point to, just my ancient series from when I introduced
> class properties for QOM back in 2015 and started the effort to
> convert away from instances properties.
>
>   https://lists.gnu.org/archive/html/qemu-devel/2015-08/msg03112.html
>

Anything we can do to avoid stumbling into this again? Should we add
some words to object_property_add() discouraging instance properties?

>
>
>>=20
>> Thanks,
>>=20
>> --=20
>> Peter Xu
>>=20
>
> With regards,
> Daniel

