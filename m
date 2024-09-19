Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6976CF3941
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 14:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHms-0000iQ-7S; Thu, 19 Sep 2024 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srHmq-0000hE-Ij
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:05:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srHmo-0000Kd-OH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:05:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A0FF3390C;
 Thu, 19 Sep 2024 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726754731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBuDBYWD4ocfm689UJF8LWs2H2zZIbTRnbe+5QeqBUQ=;
 b=axrgDVNl502mEn00oSPbsqzmeq9UPs4MBcibF5vloytM6gksjlkACvsVrq4r5YU3c4fT22
 +ogQKCUDFdcgspaUwVc8PZhrKMiNVlh9n+XIDyBBaySjweV6KyqbMUu8m/i19xeAE8NExl
 VPI09UYxvNDAkNfCss1Ezy+W+f0iIwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726754731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBuDBYWD4ocfm689UJF8LWs2H2zZIbTRnbe+5QeqBUQ=;
 b=+hP+fy2K0qLoKx8hm7c5q/8Fae4VCtZenvyqaqBVBC4WzCVwvE/gjof3J9+HBwdHNTl1fU
 XI0VnJsKLt0ZCZDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726754731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBuDBYWD4ocfm689UJF8LWs2H2zZIbTRnbe+5QeqBUQ=;
 b=axrgDVNl502mEn00oSPbsqzmeq9UPs4MBcibF5vloytM6gksjlkACvsVrq4r5YU3c4fT22
 +ogQKCUDFdcgspaUwVc8PZhrKMiNVlh9n+XIDyBBaySjweV6KyqbMUu8m/i19xeAE8NExl
 VPI09UYxvNDAkNfCss1Ezy+W+f0iIwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726754731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBuDBYWD4ocfm689UJF8LWs2H2zZIbTRnbe+5QeqBUQ=;
 b=+hP+fy2K0qLoKx8hm7c5q/8Fae4VCtZenvyqaqBVBC4WzCVwvE/gjof3J9+HBwdHNTl1fU
 XI0VnJsKLt0ZCZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 960BD13A5F;
 Thu, 19 Sep 2024 14:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aKNTF6ov7GZQSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Sep 2024 14:05:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David
 Hildenbrand <david@redhat.com>
Subject: Re: [PULL v2 0/6] Migration 20240917 patches
In-Reply-To: <CAFEAcA_9HKtTciFtrs9T9PG06GgYdoDoCASeBi7wO9CswA=1tw@mail.gmail.com>
References: <20240918183151.6413-1-peterx@redhat.com>
 <CAFEAcA9MsybcOa9pGeU7EHuqvRqfBk4TSwYR_tkHF2Xbc19Yuw@mail.gmail.com>
 <ZuwSGJODsyj_bA4P@x1n>
 <CAFEAcA_9HKtTciFtrs9T9PG06GgYdoDoCASeBi7wO9CswA=1tw@mail.gmail.com>
Date: Thu, 19 Sep 2024 11:05:28 -0300
Message-ID: <87r09feo2f.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 19 Sept 2024 at 12:59, Peter Xu <peterx@redhat.com> wrote:
>>
>> On Thu, Sep 19, 2024 at 10:08:25AM +0100, Peter Maydell wrote:
>> > Thanks for looking at the issues with the migration tests.
>> > This run went through first time without my needing to retry any
>> > jobs, so fingers crossed that we have at least improved the reliability.
>> > (I have a feeling there's still something funny with the k8s runners,
>> > but that's not migration-test specific, it's just that test tends
>> > to be the longest running and so most likely to be affected.)
>>
>> Kudos all go to Fabiano for debugging the hard problem.
>>
>> And yes, please let either of us know if it fails again, we can either keep
>> looking, or still can disable it when necessary (if it takes long to debug).
>
> On the subject of potential races in the migration code,
> there's a couple of outstanding Coverity issues that might
> be worth looking at. If they're false-positives let me know
> and I can reclassify them in Coverity.
>
> CID 1527402: In migrate_fd_cleanup() Coverity thinks there's
> a race because we read s->to_dst_file in the "if (s->to_dst_file)"
> check without holding the qemu_file_lock. This might be a
> false-positive because the race Coverity identifies happens
> if two threads both call migrate_fd_cleanup() at the same
> time, which is probably not permitted. (But OTOH taking a
> mutex gets you for free any necessary memory barriers...)

Yes, we shouldn't rely on mental gymnastics to prove that there's no
concurrent access.

@peterx, that RH bug you showed me could very well be caused by this
race, except that I don't see how fd_cleanup could race with
itself. Just having the lock would probably save us time even thinking
about it.

>
> CID 1527413: In postcopy_pause_incoming() we read
> mis->postcopy_qemufile_dst without holding the
> postcopy_prio_thread_mutex which we use to protect the write
> to that field, so Coverity thinks there's a race if two
> threads call this function at once.

At first sight, it seems like a real problem. We did a good pass on
these races on the source side, but the destination side hasn't been
investigated yet.

Unfortunately, these QEMUFile races are not trivial to fix due to
several design pain points, such as:

- the QEMUFile pointer validity being sometimes used to imply no error
  has happened before;

- the various shutdown() calls that serve both as a way to kick a read()
  that's stuck, but also to cause some other part of the code to realise
  there has been an error (due to the point above);

- the yank feature which has weird semantics regarding whether it
  operates on an iochannel or qemufile;

- migrate_fd_cancel() that _can_ run concurrently with anything else;

- the need to ensure the other end of migration also reacts to
  error/cancel on this side;

>
> (The only other migration Coverity issue is CID 1560071,
> which is the "better to use pstrcpy()" not-really-a-bug
> we discussed in another thread.)
>
> thanks
> -- PMM

