Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A5BD3EE67
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 14:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vivTq-0003cs-MM; Thu, 22 Jan 2026 09:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vivTp-0003a5-Qw
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 09:16:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vivTo-0003ll-20
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 09:16:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B51A5BCE5;
 Thu, 22 Jan 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769091370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDcPmKYsKUUHUYRReJNPgNmBgA8mMcyAYhiz5u9lHzE=;
 b=mJwWt/XtFQtnixkrhfnVpacEK54JNMJmdSknIyCuzVvATVaMXnabBhfq4CF+t0IbqUSuW+
 FRfUJqFadrlpmkURGLaNlY5NwAO3ADQSwhATibZtKVR+JQMB11N7YXnhgu6i43q52YOM9s
 YY8LaLwT5xGajCKwnEdzFW54tJhqugM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769091370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDcPmKYsKUUHUYRReJNPgNmBgA8mMcyAYhiz5u9lHzE=;
 b=vrMtHbWDikrbpeLIjOgl9/90iqlgMZ45DUwcAuOurjvG3kDrOwwB1qlL/zRm70N+Z118nQ
 tjnv/iTGIMbTmACg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769091369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDcPmKYsKUUHUYRReJNPgNmBgA8mMcyAYhiz5u9lHzE=;
 b=MkVV5QJnEwabJ+2Vx5dpbPJcUVvNzSmOs4jhHKWG+ywTvSReYBkaR2LqCz2+bZDtIwatLh
 CQgjWBU52FiBFQ82R8OuNKml+aWx9VNqxfA5Yoyxu9F7uTYsqXb2RvhlKJy2lCrYagnakK
 ZCisVR5p8dJoaP2br2B5+KGhYGJ/GG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769091369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDcPmKYsKUUHUYRReJNPgNmBgA8mMcyAYhiz5u9lHzE=;
 b=pWpWhCs+4m4Iv+qb+/5kdTBimGGTd2F6MT2FFt45igDRMg/o+YCBiJmx9mW0Zj86etg4/K
 jZOiB1ek8j8Q44AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8238B1395E;
 Thu, 22 Jan 2026 14:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jQ/mECgxcmmAGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Jan 2026 14:16:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
In-Reply-To: <CAE8KmOzaP2HTU2b4aBqhFZ1VCv6mRO94-MzQA4Ua0o2F6L8EbA@mail.gmail.com>
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
 <CAE8KmOx-HbzqDGt12mMxNHcTocq2rWSrksgrns-PdHWCPDJacg@mail.gmail.com>
 <87a4y7kugt.fsf@suse.de>
 <CAE8KmOzaP2HTU2b4aBqhFZ1VCv6mRO94-MzQA4Ua0o2F6L8EbA@mail.gmail.com>
Date: Thu, 22 Jan 2026 11:16:05 -0300
Message-ID: <87wm19ka1m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Wed, 21 Jan 2026 at 18:12, Fabiano Rosas <farosas@suse.de> wrote:
>> In general, I think that whenever we determine what protects a data
>> structure from concurrent access we should make it obvious.
>>
>> So this assert is here to provide _some_ assurance that this routine is protected.
>
> * Yes, but it is not obvious that we are checking bql_locked() to
> protect from concurrent access to the global MigrationState object.
> Secondly for concurrent access, other threads should be running.
> ===
> Thread 1 "qemu-system-x86" hit Breakpoint 1, migrate_params_apply
> (params=0x7ffcb6627840) at ../migration/options.c:1392
> 1392    {
> (gdb) n
> 1393        MigrationState *s = migrate_get_current();
> (gdb) p bql_locked()
> $3 = true
> (gdb) p migration_is_running()
> $4 = false
> (gdb)
>
> Thread 1 "qemu-system-x86" hit Breakpoint 1, migrate_params_apply
> (params=0x7ffcb6627840) at ../migration/options.c:1392
> 1392    {
> (gdb) n
> 1393        MigrationState *s = migrate_get_current();
> (gdb) p bql_locked()
> $5 = true
> (gdb) p migration_is_running()
> $6 = false
> (gdb)
> ===
> * migrate_params_apply() is called twice:
>     1. At the beginning when libvirtd(8) initiates migration
>     2. To reset migration options if we kill migration on the
> destination side by killing VM or connection.

This is one usage. People are free to invoke QMP commands whenever they want.

> Both times it is called from the main Thread-1, BQL is locked and
> other migration threads are not running.
>
> * If we are trying to futureproof this function so that no one should
> be able to call migrate_params_apply() from other threads without bql
> - that seems like a long shot. Because it is reachable only from
> qmp_migrate_set_parameters(), which is invoked by an external QMP
> user. Ie. someone would have to explicitly send
> qmp_migrate_set_parameters() command while migration is running, but
> even then it'll still be invoked by the main thread-1, with
> bql_locked=true. no?
>

Setting parameters while running is common, our tests do it all the time
to adjust convergence options.

Where the command is invoked from is a bad assumption to make. There's
coroutines, iocontexts, oob, etc. These things change all the time and
we don't see it. Look at all the work done in the block layer to assert 

In this case, it will be invoked from the main loop and with BQL taken,
yes. That's not code under the migration subsystem's control, we should
not rely on that never changing. If we can check the requirements at the
entry point into the subsystem, we'll be better protected against
changes in other parts of QEMU that we didn't oversee.

Peter is now going through the painful exercise of removing the incoming
coroutine and playing the whack-a-mole of "BQL or no BQL?". Locks should
be fine-grained, protect specific bits of data and be heavily
documented. Analysing where the function is currently invoked from and
inferring about thread-safety is a pitfall.

(note that a simple /*called with BQL taken*/ would already count)

> * I'm thinking maybe we can skip assert(bql_locked()) and related
> header inclusion.
>

Fine, on the basis that it's out of scope for the patch anyway.

> Thank you.
> ---
>   - Prasad

