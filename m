Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79506C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNCq-0000qT-Cq; Wed, 29 May 2024 13:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sCNCo-0000pu-Pb
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:35:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sCNCj-0000o0-BM
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:35:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CCEE205DF;
 Wed, 29 May 2024 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717004110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCKv8CDRY9QXBGA+dc7XkLhnOWR2elbfYdevVZyYQVg=;
 b=rWx0sKWlF3lZRjpxfgk14v8lhtTYED/T2BHdOrGliMSzXfAz+3IoIMNzP1us+vOF0P7TPc
 HnlMcwaV7hqUEXzdEKp0dhjAJ+R5bEe+it7rs5tRobBkJU5/UYFeW9srSGV1p0/uUuDrgy
 4nvWWrsZZdp0gO2wz1Khs7XZpOtPevs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717004110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCKv8CDRY9QXBGA+dc7XkLhnOWR2elbfYdevVZyYQVg=;
 b=1w77JGmczG9cXr426pDyi+HJd7ebDICdTLVKmxwM37GX9VWsdsz+wa7TaHq/qGEBkwwL05
 4CzVh0iVQa6kAZCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rWx0sKWl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1w77JGmc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717004110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCKv8CDRY9QXBGA+dc7XkLhnOWR2elbfYdevVZyYQVg=;
 b=rWx0sKWlF3lZRjpxfgk14v8lhtTYED/T2BHdOrGliMSzXfAz+3IoIMNzP1us+vOF0P7TPc
 HnlMcwaV7hqUEXzdEKp0dhjAJ+R5bEe+it7rs5tRobBkJU5/UYFeW9srSGV1p0/uUuDrgy
 4nvWWrsZZdp0gO2wz1Khs7XZpOtPevs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717004110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCKv8CDRY9QXBGA+dc7XkLhnOWR2elbfYdevVZyYQVg=;
 b=1w77JGmczG9cXr426pDyi+HJd7ebDICdTLVKmxwM37GX9VWsdsz+wa7TaHq/qGEBkwwL05
 4CzVh0iVQa6kAZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 184A013A6B;
 Wed, 29 May 2024 17:35:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SzTjM01nV2awGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 May 2024 17:35:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migrate-test: Add a postcopy memfile test
In-Reply-To: <ZldOal1YdAWLB5pj@x1n>
References: <20240529041322.701525-1-npiggin@gmail.com>
 <875xuwg4mx.fsf@suse.de> <ZldOal1YdAWLB5pj@x1n>
Date: Wed, 29 May 2024 14:35:07 -0300
Message-ID: <87zfs8ed2s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8CCEE205DF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,redhat.com];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, May 29, 2024 at 09:54:30AM -0300, Fabiano Rosas wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > Postcopy requires userfaultfd support, which requires tmpfs if a memory
>> > file is used.
>> >
>> > This adds back support for /dev/shm memory files, but adds preallocation
>> > to skip environments where that mount is limited in size.
>> >
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >
>> > How about this? This goes on top of the reset of the patches
>> > (I'll re-send them all as a series if we can get to some agreement).
>> >
>> > This adds back the /dev/shm option with preallocation and adds a test
>> > case that requires tmpfs.
>> 
>> Peter has stronger opinions on this than I do. I'll leave it to him to
>> decide.
>
> Sorry if I gave that feeling; it's more of a stronger willingness to at
> some point enable shmem for QEMU migration, rather than wanting to push
> back what Nicholas was trying to do.

Of course, I didn't mean to imply that. I just saying that using /tmp
would have been fine with me and I don't want to get in the way.

> Enabling more arch for migration
> tests is definitely worthwhile on its own.
>
> Shmem is just some blank spot that IMHO we should start to think about
> better coverarge. E.g. it is the only sane way to boot the VM that is able
> to do fast qemu upgrades using ignore-shared, that was true even before
> Steve's cpr-exec work, which would be much easier than anonymous. And it's
> also possible shmem can be (in the next 3-5 years) the 1G page provider to
> replace hugetlb for postcopy's sake - this one is far beyond our current
> discussion so I won't extend..

Interesting, good to know.

>
> IMHO shmem should just be a major backend just like anonymous, and the only
> possible file backend we can test in CI - as hugetlb is harder to manage
> there.
>
>> 
>> Just note that now we're making the CI less deterministic in relation to
>> the migration tests. When a test that uses shmem fails, we'll not be
>> able to consistently reproduce because the test might not even run
>> depending on what has consumed the shmem first.
>> 
>> Let's also take care that the other consumers of shmem (I think just
>> ivshmem-test) are able to cope with the migration-test taking all the
>> space, otherwise the CI will still break.
>
> Looks like ivshmem-test only uses 1MB shmem constantly so probably that
> will succeed if the migration test will, but true they face the same
> challenge and they interfere with each other..  that test sidently pass
> (instead of skip) if mktempshm() fails.  I guess we don't have a way to
> solidly test shmem as shmem simply may not be around.

Here we have each of the 5 migration archs taking up some amount of
memory + each of the 3 supported arches for ivshmem. They all could be
running in parallel through make check. In practice there's maybe less
overlap due to timing and not all CI jobs building all archs, but still.

>
> For this patch alone personally I'd avoid using "use_uffd_memfile" as the
> name, as that's definitely confusing, since shmem can be tested in other
> setups too without uffd.  Nicolas, please feel free to move ahead with your
> arch enablement series with /tmp if you want to separate the shmem issue.

Or just leave ignore_shared untouched for the ppc series.

>
> Thanks,

