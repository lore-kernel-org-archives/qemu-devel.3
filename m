Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC83C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 14:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkOaM-0007X8-UB; Tue, 18 Feb 2025 09:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkOaJ-0007Ws-NV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:28:28 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkOaH-0005WE-PB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:28:27 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C83AE2116B;
 Tue, 18 Feb 2025 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739888903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRoqjRZHLDJXuqj1jyt9XxaCfIwD31hDGBeTZMj1j0w=;
 b=T22U1F1YCM9jaOanVQzNkNvW0xlE84gz0EsZZZ5m/E9uCWueRssiDu88MaZ3y2gprJROvT
 Ur2zlWUORimigUbTC82AJzvKeWXDgCx6Js5m8oUP1YMIXPZWx8WHaBvXeeM4AI5zIsL3v2
 kpZ6PV5MRGZoGMmGNTlkFeFOl+/HwNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739888903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRoqjRZHLDJXuqj1jyt9XxaCfIwD31hDGBeTZMj1j0w=;
 b=VqQiFLgQKcPqQq50APZs8huyZB22bpKjmuzBS16+BrKwTTVuhF8aOOoPCQY8hS41L8h6W5
 R5juMfqqlRLT3+AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739888903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRoqjRZHLDJXuqj1jyt9XxaCfIwD31hDGBeTZMj1j0w=;
 b=T22U1F1YCM9jaOanVQzNkNvW0xlE84gz0EsZZZ5m/E9uCWueRssiDu88MaZ3y2gprJROvT
 Ur2zlWUORimigUbTC82AJzvKeWXDgCx6Js5m8oUP1YMIXPZWx8WHaBvXeeM4AI5zIsL3v2
 kpZ6PV5MRGZoGMmGNTlkFeFOl+/HwNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739888903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRoqjRZHLDJXuqj1jyt9XxaCfIwD31hDGBeTZMj1j0w=;
 b=VqQiFLgQKcPqQq50APZs8huyZB22bpKjmuzBS16+BrKwTTVuhF8aOOoPCQY8hS41L8h6W5
 R5juMfqqlRLT3+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41F69132C7;
 Tue, 18 Feb 2025 14:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mmwvAAeZtGc4YgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Feb 2025 14:28:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 4/4] tests/qtest/migration: add postcopy tests with
 multifd
In-Reply-To: <CAE8KmOzknFTcKnSp3iQwhV__e0_r-kJnXDy3x3zeyrohH5B6Tg@mail.gmail.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-5-ppandit@redhat.com> <871pvwvb69.fsf@suse.de>
 <CAE8KmOzknFTcKnSp3iQwhV__e0_r-kJnXDy3x3zeyrohH5B6Tg@mail.gmail.com>
Date: Tue, 18 Feb 2025 11:28:20 -0300
Message-ID: <875xl79vjv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: permerror client-ip=195.135.223.130;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Mon, 17 Feb 2025 at 21:03, Fabiano Rosas <farosas@suse.de> wrote:
>> > @@ -110,6 +129,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>> >              "/migration/postcopy/recovery/double-failures/reconnect",
>> >              test_postcopy_recovery_fail_reconnect);
>> >
>> > +        migration_test_add("/migration/multifd+postcopy/plain",
>> > +                           test_multifd_postcopy);
>> > +        migration_test_add("/migration/multifd+postcopy/preempt/plain",
>> > +                           test_multifd_postcopy_preempt);
>>
>> For postcopy-tests.c I'd use /migration/postcopy/multifd so we can run
>> them all via command-line. These are also the only ones actually doing
>> postcopy migration. We need to distinguish multifd+postcopy proper from
>> merely postcopy-ram=true.
>
> * ie. repalce 'multifd+postcopy'  with '../postcopy/multifd/' only in
> postcopy-tests.c? And keep other instances unchanged?
>

Yes. Or do someting else for the others, I don't have a preference. But
we need to have this be different in a way that people expecting to test
postcopy can do that along with the rest of the postcopy tests and we
also make it more clear that postcopy is not actually being tested in
the precopy tests.

These would actually do postcopy:
postcopy/multifd
multifd/postcopy

These just enable the postcopy cap:
precopy/postcopy-ram/
multifd/postcopy-ram/

The exact names could change...

> ...
>> >
>> > +static void test_multifd_postcopy_tcp_cancel(void)
>> > +{
>> > +    postcopy_ram = true;
>> > +    test_multifd_tcp_cancel();
>> > +    postcopy_ram = false;
>>
>> You could pass this in, there's just one other caller.
>
> * Sorry, what do you mean here?

To make postcopy_ram be passed in as an argument to
test_multifd_tcp_cancel(). Having globals tend to get in the way of
refactoring stuff later. We already had issues with tmpfs being global
all over the place.

>
> Thank you.
> ---
>   - Prasad

