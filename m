Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BE3C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQv2-0005eF-5m; Thu, 16 Jul 2026 14:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wkQum-0005cF-NZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:34:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wkQuk-0005kg-GN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:34:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A52778A82;
 Thu, 16 Jul 2026 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784226867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceBwEwjzvX4x+QhQ6lncO7S5wgBPBE5cBZdNibCW/Mc=;
 b=2O6ODfcUugIkQqKdA1fr7dpfRwTLzV+o679WRLmXFghGepgHejnsptRGNCiXgES5EI7cqb
 cluCeUqt22jm3XSTFFkjsHOXLAdyoN6NmqVTKQj5DtBBTH0E6czSxoGY7YGKVFTlrtp2oo
 7DPI7x9cuYp94TPtPUgU7W04k/Uw9Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784226867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceBwEwjzvX4x+QhQ6lncO7S5wgBPBE5cBZdNibCW/Mc=;
 b=7kAlwymG1GyzfHXmL6GqyKx82mW0PTvP84Ynub0D+PMQzNFVK+ualIf/VgCNUxzJG55RHV
 B3PSOD721seID4Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784226867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceBwEwjzvX4x+QhQ6lncO7S5wgBPBE5cBZdNibCW/Mc=;
 b=2O6ODfcUugIkQqKdA1fr7dpfRwTLzV+o679WRLmXFghGepgHejnsptRGNCiXgES5EI7cqb
 cluCeUqt22jm3XSTFFkjsHOXLAdyoN6NmqVTKQj5DtBBTH0E6czSxoGY7YGKVFTlrtp2oo
 7DPI7x9cuYp94TPtPUgU7W04k/Uw9Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784226867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceBwEwjzvX4x+QhQ6lncO7S5wgBPBE5cBZdNibCW/Mc=;
 b=7kAlwymG1GyzfHXmL6GqyKx82mW0PTvP84Ynub0D+PMQzNFVK+ualIf/VgCNUxzJG55RHV
 B3PSOD721seID4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFCE4779AD;
 Thu, 16 Jul 2026 18:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ucq+LzIkWWqjMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 Jul 2026 18:34:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
In-Reply-To: <alj4V6I__bCOjRTt@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <alj4V6I__bCOjRTt@redhat.com>
Date: Thu, 16 Jul 2026 15:34:20 -0300
Message-ID: <87ech24wcz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Thu, Jul 16, 2026 at 11:08:49AM -0300, Fabiano Rosas wrote:
>
>> Assumptions:
>>=20
>> A) The migration stream is assumed to be secured by TLS on a per-host
>> basis.
>>=20
>> B) For migration streams stored to file, including snapshots, it is
>> assumed that the storage file is authentic, i.e. the files are owned by
>> the party performing the live migration and have not been tampered with.
>
> Can you clarify "the party performing the live migration" ?
>
> Is that referring to the "guest owner" who initiates the migration,
> or is that referring to the mgmt app control plane.
>

I was thinking that the entity issuing qmp_migrate/loadvm should
guarantee the integrity of the file up to that moment and while QEMU is
reading it.

I would say when there's a management application, that is the entity
we're talking about, but could very well be an end-user issuing commands
to QEMU directly.

> The risk I've always been concerned about is the guest owner
> tampering with state files, though I'm increasing coming to
> the view point that state files must *never* be allowed to be
> modified by the guest owner. Mgmt apps must either prevent
> that through storage permissions, or detect that by digitally
> signing state files that are theoretically writable by guest
> owners & validate sig before restore.
>

I think it makes sense for the management app to impose such a
constraint. I'm not so sure about QEMU expecting that it does,
though. Some apps might have a different opinion and the users are
probably not going to like losing access.

Doesn't the guest owner already have control over what goes in the
migration stream in the first place?

>
>> C) The network ports used for migration are expected to be available
>> only during migration. No long-standing listening destination QEMU
>> process.
>
> I wonder, does that make a difference to our risk ?
>
> If we're concerned about an undesirable app/client conjnectnig to a
> open network port, QEMU has that threat no matter how short the time
> windows is that the ports are accepting incoming clients.  So I'm
> not sure this point helps us.
>

I'm more worried about an unexpected migration. An incoming vm will just
take whatever is given to it. If there is a (legitimate) migration
happening in a short window of time, attempts to hijack that destination
machine would cause a migration failure and be detectable.

Now I'm also thinking of an eavesdropper tagging along in some multifd
channel, if that's even possible.

>> D) The network used for migration is expected to be adequately isolated.
>
> Is that intended to be in additional to (A) or instead of (A) ?
>
> If in addition to (A) then I'm wondering what benefits listing
> this point brings - what risks are eliminated that TLS does not
> already eliminate ?
>

In addition. Then maybe you're right that there's no additional benefit,
I can't think of a scenario. However it's common practice for admins to
not use TLS and rely on network isolation. I don't want to make it seem
that TLS is mandatory. As Peter pointed out, it's not a default
configuration.

>> E) The migration source QEMU process is assumed to be secure. Compromise
>> of the source QEMU process is nonetheless possible but exploiting the
>> migration process is expected to grant no further privileges.
>
> This is the tricky assumption.
>
> Cnsider source host as 2 QEMU processes, one of tenant A and
> one for tenant B.
>
> If tenant A compromises their QEMU, and can wait until a live
> migration for tenant B is initiating, potentially tenant A can
> connect to a dest QEMU for tenant B. I would consider that to
> be gaining privileges.
>

I thought of that, but I can't understand how "dest QEMU for tenant B"
isn't just "dest QEMU for tenant A that has now took over". If none of
the stream from source B is reaching dest B, then that's harmless.

Unless some scenario like what I mentioned above with multifd is in
play.

Now, can tenant A bug their QEMU to the point that it receives a
migration from tenant B? Then that falls into IN SCOPE point 2 below.

Maybe we need to have a parentheses for the multi-tenant scenario.

I think we need some guideline to help triaging the infinite
hypotheticals of "what if source QEMU magically puts X one the stream?".

> With TLS we lack fine grained authentication in common setups
> today that rely on x509 certs configured per-host, not per-QEMU.
>
> In current libvirt we're introducing oout of the box support for
> TLS PSK, which means live migration sessions will be tied to
> individual matched (src,dst) QEMU pairs, so even if tenant A is
> compromised they would be able to do a TLS handshake for tenant
> B's dst QEMU.
>

ITYM "wouldn't be able".

> I'd like app mgmt apps to switch to PSK instad of x509 for
> live migration, but that'll take along time.
>

Is TLS PSK a reasonable setup to expect and to include in this policy?

> None the less if we can assume the source QEMU is trusted,
> then that eliminates a huge class of security vulnerabilities,
> turning them all into hardening bugs, so I understand this is
> very appealing to declare.
>

It is, I'm keen to do it. I expect a compromised QEMU to be either a
very rare situation or to fall into the "you have bigger problems"
area. But if we decide it's an important vector of attack, so be it.

>> For security consideration, the following are considered:
>>=20
>> OUT OF SCOPE:
>>=20
>> 1) Abort of destination QEMU process while migration is still in course.
>> Rationale: the source virtual machine is not affected.
>
> Ack.
>
>>=20
>> 2) Migration failure.
>> Rationale: eventual failed migrations are part of normal operation.
>
> Ack.
>=20=20
>> 3) Memory over-allocation issues in the destination QEMU process.
>> Rationale: the destination host's operating system is expected to
>> constrain resource usage. Process termination due to OOM falls under
>> point 1 above.
>
> Ack, that falls under our general exlclusion already too, though
> we might finesse the language a bit more.
>
>> IN SCOPE:
>>=20
>> 1) Privilege escalation from the guest operating system into the
>> destination QEMU process or host.
>>=20
>> 2) Tampering or exfiltration of migration stream data by a third party
>> at a lower privilege level than either QEMU processes involved in the
>> migration.
>>=20
>> 3) Termination of the source QEMU process by source virtual machine
>> guest userspace, including by forcing host OS resource constraints to
>> be reached.
>>=20
>> 4) Other tampering or exfiltration of data from the source QEMU process
>> if reached from migration code or migration stream manipulation.
>>=20
>> 5) Causing source QEMU process to enter a state from which migration is
>> not possible permanently.
>>=20
>> The overall effect of this policy is that only legitimately produced
>> migration data is considered for security implications, whether that
>> data is malicious or buggy.
>
> WIth this it seems like the only 2 scenarios where a migration security
> flaw can be issued are:
>
>  * Something goes wrong before/during the TLS handshake
>  * A bug in source QEMU, somehow allows a guest OS user
>    to set magic device data that turns into an exploitable
>    VM state record.
>

We don't need a bug in source QEMU, the magic data could be within
accepted parameters.

> Again, certainly appealing, but for the edge case that even with TLS,
> we don't have fine grained access control, so we know the source is
> a valid QEMU, but we don't know if it is the QEMU we expected.
>
> With regards,
> Daniel

