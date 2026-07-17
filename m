Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF17C44512
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 00:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkWL9-0002Zb-Bz; Thu, 16 Jul 2026 20:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wkWL7-0002Wo-K2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 20:22:05 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wkWL4-0001b1-I0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 20:22:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A41493E2F;
 Fri, 17 Jul 2026 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784247720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E5cTqNy8gBYgcdyB4ThHi7Nj6h4ZR6CJEAAVn2zp5k=;
 b=DW/jghbgo6hV+fs2U90ujddRO89/D56aaHgjNiVJs3pfbNKfHbz0TJqTPFPFFDJ/nJ0z8Z
 GS6NLEczMq4SIUux9wzzdHytwuuhuZdV+N/cWW3HLHw8FqryIv7AQlWhFOH3EL0iO/fGxv
 ORrpisdYFwJ1SgYe3lUZOHqTgGrGsq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784247720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E5cTqNy8gBYgcdyB4ThHi7Nj6h4ZR6CJEAAVn2zp5k=;
 b=CBRxJBBKsZ2dleR0huPfR8Gfy1IfzyoNqIL3AvbSttgJwkfKJhJFAMoWVf7mgIV2Jw4Cwo
 dIDN+hPA7Pv/eUCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784247720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E5cTqNy8gBYgcdyB4ThHi7Nj6h4ZR6CJEAAVn2zp5k=;
 b=DW/jghbgo6hV+fs2U90ujddRO89/D56aaHgjNiVJs3pfbNKfHbz0TJqTPFPFFDJ/nJ0z8Z
 GS6NLEczMq4SIUux9wzzdHytwuuhuZdV+N/cWW3HLHw8FqryIv7AQlWhFOH3EL0iO/fGxv
 ORrpisdYFwJ1SgYe3lUZOHqTgGrGsq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784247720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E5cTqNy8gBYgcdyB4ThHi7Nj6h4ZR6CJEAAVn2zp5k=;
 b=CBRxJBBKsZ2dleR0huPfR8Gfy1IfzyoNqIL3AvbSttgJwkfKJhJFAMoWVf7mgIV2Jw4Cwo
 dIDN+hPA7Pv/eUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 383C9779AA;
 Fri, 17 Jul 2026 00:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4SDpAqh1WWrWeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jul 2026 00:22:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mauro Matteo
 Cascella <mcascell@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
In-Reply-To: <alk3U6P_W0z-XNF1@x1.local>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <alj7gF_ayHO7Dvb7@x1.local> <87cxwm4vkc.fsf@suse.de>
 <alk3U6P_W0z-XNF1@x1.local>
Date: Thu, 16 Jul 2026 21:21:53 -0300
Message-ID: <87a4rq4g9q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jul 16, 2026 at 03:51:31PM -0300, Fabiano Rosas wrote:
>> > I wonder if we can simply above 5 points into something simpler, or skip
>> > for now?  To me, what is out of scope is more valuable to be put into doc,
>> > because I bet 99% if not all of existing "security issues" on migration in
>> > past few months fall into it.. so it saves huge time already for triaging.
>> 
>> I want to reduce the guesswork both when reporting issues and when
>> triaging. People tend to sit around and imagine infinite scenarios, it's
>> not productive.
>> 
>> This section is so we can point at it and ask for some indication of any
>> of the points above. Otherwise we'll get the random bug report saying
>> that weird behavior was achieved, therefore CVE. These are the
>> situations I could think of that would obviously be worthy of further
>> consideration.
>> 
>> Could you expand on why you think this is not worth having? I don't
>> think I understand it.
>
> I didn't expect to point to a bug report into "IN SCOPE" category.  IMHO,
> the major use case for the doc is to point a bug report into "OUT OF SCOPE"
> category.. then we can easily justify an issue to be not a CVE candidate.
>
> When it is a real security issue, we likely need to evaluate it case by
> case, but first it needs to not directly fall int OUT OF SCOPE first.
>
> I think it could be that I hardly have any real experience with a legit
> security report versus migration yet, but we have richer experience on
> "what we don't think is a security issue, but only a bug" thanks to AI.. so
> NOT IN SCOPE is easier to list to me than IN SCOPE ones.
>

I see.

> Neither do I have very clear idea after reading the five examples given.
>
> To make it clearer on what I meant, I can start by asking some questions on
> the five examples listed IN SCOPE.  You don't need to answer all, or
> maybe.. no need to answer any of them, just to show my confusions on
> reading the examples (hence the request of simplifications, or removal, at
> first version).
>

Thanks, let's see if I can defend myself! =)

>> 1) Privilege escalation from the guest operating system into the
>> destination QEMU process or host.
>
> Do you mean any form of guest operation to cause privilege escalation?
> Obviously, it must be about during a live migration happening, otherwise I
> don't see how it is relevant to migration, but then is this only talking
> about a postcopy use case (where dest QEMU has vCPU running)?  After all,
> precopy migration guest operations all done on source, so if there's any
> privilege escalation, it needs to happen on source host first.
>
> Also, I am a bit lost on why this is special for migration.  Such issue can
> happen on any host without migration.  It's a bit unclear to me.
>

I mean when the guest OS does some trickery that gets propagated to the
destination machine via migration and the person controlling that guest
gets privileges on the QEMU process on the destination. Injecting a
payload of some sort, or setting up a device to allow later
exploitation.

>> 
>> 2) Tampering or exfiltration of migration stream data by a third party
>> at a lower privilege level than either QEMU processes involved in the
>> migration.
>
> If we have the ASSUMPTION describing migration stream is secure, why do we
> worry about third party hijacking migration stream?  Someone already
> breached?
>

We assume the stream is secure, but there could still be a bug in the
migration code that allows a thirdy party to read the stream. As for
"tampering", you're right that's probably already covered by the
assumptions we made earlier.

>> 
>> 3) Termination of the source QEMU process by source virtual machine
>> guest userspace, including by forcing host OS resource constraints to
>> be reached.
>
> This is also not clear on how it correlates to migration, because IIUC this
> can also happen without migration.  Maybe it's trying to catch the cases
> where it only can be attacked during migration?
>

Yes, say the userspace inside the guest does something that causes the
migration code to crash when qmp_migrate is issued, for instance. I'm
not saying it's a simple thing to happen, just that IF it happens, then
we have already reasoned about it and agreed that it has the potential
to become a CVE.

> What is "guest userspace"?  Is that the userspace of the guest OS?
>

Yes, assuming the OS itself already has ways to shoot itself in the foot
by tampering with devices. But the userspace is in another layer, it
could attempt to do bad things to the OS.

>> 
>> 4) Other tampering or exfiltration of data from the source QEMU process
>> if reached from migration code or migration stream manipulation.
>
> This is a very generic statement to me, even though I think it's correct..
> Say, how stream can be manipulated with TLS encryption?  If it's
> manipulated from the guest, is the guest data being tampered on its own or
> some other data?
>

Right, this is a catchall meaning: even with all of the above, if
someone finds a way to do this, the previous points do not invalidate
this find.

I guess I wrote all of these with a sense of providing some assurance
that even though we'll possibly be rejecting various bugs as
non-security related, there are still clear situations where there's a
security implication and we're aware of it.

>> 
>> 5) Causing source QEMU process to enter a state from which migration is
>> not possible permanently.
>
> This is a very valid one and clear to understand.  However I don't know if
> any of such would really happen, though.

I don't think it matters if it would happen. If it ever does, we think
it's bad enough that it will be considered for a CVE. "Considered", as
opposed to just filing it as a normal bug. But the analysis could still
result in nothing and we'd treat it as just a bug anyway.

> It's easier to happen to me when e.g. we leaked memory in QMP handlers
> which may cause DoS rather than "cannot migrate anymore"..
>

What I'm talking about in this particular point is about putting an
admin in a situation where they can only resort to shutting down the
virtual machine. This is a counterpart to the "failed migrations are
normal" assumption up above; failed migrations can be easily worked
around, but permanent failure cannot.

> Also, if it's only the VM itself got affected (say, attacker from guest
> within causing its VM not migratable), then the damage it can cause is very
> limited too.  I'm not 100% sure I know how severe is such, and whether it's
> CVE.

Fair point, maybe it's not super relevant indeed. Note I'm not trying to
say that these items will become CVEs, just that if someone can put an
argument that they can happen, then it's something we'll gladly look
into.

---

See if my answers clarify the situation a bit. It's ok if you still want
to remove the text after reading them. What's more important is that we
hash these things out so we're all in the same page.

Thanks for taking the time to write down your thoughts.

