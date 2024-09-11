Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC3CEE57DB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 21:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soUqv-00036h-OG; Wed, 11 Sep 2024 17:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1soUqp-00035e-SK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 17:26:11 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1soUql-0006iJ-LP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 17:26:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 346201FB3D;
 Wed, 11 Sep 2024 21:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726089964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTv2JVRfuInRFkCwXABd+66HPgVwOzXht3ZAWPcc6xI=;
 b=f1tfkMY/+Q/Euzzx+RL0bq/Aapo8dLQmwi+5F2FvfTT1xPIxB6FEKm0y8j8zj+gtxaJlkT
 QS1hB/Qn2vA+ep0a+rFZfkmhTHPefvKuUGSe15WVsnxiosVgOF1U/+J9xQOIVVy0OBIIVk
 8hd/NsNdHJZg49IAyJwJSXQrsy5bClw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726089964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTv2JVRfuInRFkCwXABd+66HPgVwOzXht3ZAWPcc6xI=;
 b=BvH4gMyHvnJNiO7TRG+kKRbFwbBq/lPwt8s9h6VyoA6jaW+B+U7de2tiKFy0XJMNLA25fy
 I8WEvvsDD9MJaeCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="f1tfkMY/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BvH4gMyH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726089964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTv2JVRfuInRFkCwXABd+66HPgVwOzXht3ZAWPcc6xI=;
 b=f1tfkMY/+Q/Euzzx+RL0bq/Aapo8dLQmwi+5F2FvfTT1xPIxB6FEKm0y8j8zj+gtxaJlkT
 QS1hB/Qn2vA+ep0a+rFZfkmhTHPefvKuUGSe15WVsnxiosVgOF1U/+J9xQOIVVy0OBIIVk
 8hd/NsNdHJZg49IAyJwJSXQrsy5bClw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726089964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTv2JVRfuInRFkCwXABd+66HPgVwOzXht3ZAWPcc6xI=;
 b=BvH4gMyHvnJNiO7TRG+kKRbFwbBq/lPwt8s9h6VyoA6jaW+B+U7de2tiKFy0XJMNLA25fy
 I8WEvvsDD9MJaeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0907132CB;
 Wed, 11 Sep 2024 21:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1e96HesK4manVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Sep 2024 21:26:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Hyman Huang
 <yong.huang@smartx.com>, qemu-devel@nongnu.org, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, David
 Hildenbrand <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
In-Reply-To: <ZuH_pvnTCumKuXTh@x1n>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n>
Date: Wed, 11 Sep 2024 18:26:01 -0300
Message-ID: <87bk0trifq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 346201FB3D
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> On Wed, Sep 11, 2024 at 04:48:21PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Sep 10, 2024 at 07:23:43PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Mon, Sep 09, 2024 at 06:54:46PM -0300, Fabiano Rosas wrote:
>> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> 
>> >> >> > On Mon, Sep 09, 2024 at 03:02:57PM +0100, Peter Maydell wrote:
>> >> >> >> On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
>> >> >> >> >
>> >> >> >> > Despite the fact that the responsive CPU throttle is enabled,
>> >> >> >> > the dirty sync count may not always increase because this is
>> >> >> >> > an optimization that might not happen in any situation.
>> >> >> >> >
>> >> >> >> > This test case just making sure it doesn't interfere with any
>> >> >> >> > current functionality.
>> >> >> >> >
>> >> >> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> >> >> >> 
>> >> >> >> tests/qtest/migration-test already runs 75 different
>> >> >> >> subtests, takes up a massive chunk of our "make check"
>> >> >> >> time, and is very commonly a "times out" test on some
>> >> >> >> of our CI jobs. It runs on five different guest CPU
>> >> >> >> architectures, each one of which takes between 2 and
>> >> >> >> 5 minutes to complete the full migration-test.
>> >> >> >> 
>> >> >> >> Do we really need to make it even bigger?
>> >> >> >
>> >> >> > I'll try to find some time in the next few weeks looking into this to see
>> >> >> > whether we can further shrink migration test times after previous attemps
>> >> >> > from Dan.  At least a low hanging fruit is we should indeed put some more
>> >> >> > tests into g_test_slow(), and this new test could also be a candidate (then
>> >> >> > we can run "-m slow" for migration PRs only).
>> >> >> 
>> >> >> I think we could (using -m slow or any other method) separate tests
>> >> >> that are generic enough that every CI run should benefit from them
>> >> >> vs. tests that are only useful once someone starts touching migration
>> >> >> code. I'd say very few in the former category and most of them in the
>> >> >> latter.
>> >> >> 
>> >> >> For an idea of where migration bugs lie, I took a look at what was
>> >> >> fixed since 2022:
>> >> >> 
>> >> >> # bugs | device/subsystem/arch
>> >> >> ----------------------------------
>> >> >>     54 | migration
>> >> >>     10 | vfio
>> >> >>      6 | ppc
>> >> >>      3 | virtio-gpu
>> >> >>      2 | pcie_sriov, tpm_emulator,
>> >> >>           vdpa, virtio-rng-pci
>> >> >>      1 | arm, block, gpio, lasi,
>> >> >>           pci, s390, scsi-disk,
>> >> >>           virtio-mem, TCG
>> >> >
>> >> > Just curious; how did you collect these?
>> >> 
>> >> git log --since=2022 and then squinted at it. I wrote a warning to take
>> >> this with a grain of salt, but it missed the final version.
>> >> 
>> >> >
>> >> >> 
>> >> >> From these, ignoring the migration bugs, the migration-tests cover some
>> >> >> of: arm, ppc, s390, TCG. The device_opts[1] patch hasn't merged yet, but
>> >> >> once it is, then virtio-gpu would be covered and we could investigate
>> >> >> adding some of the others.
>> >> >> 
>> >> >> For actual migration code issues:
>> >> >> 
>> >> >> # bugs | (sub)subsystem | kind
>> >> >> ----------------------------------------------
>> >> >>     13 | multifd        | correctness/races
>> >> >>      8 | ram            | correctness
>> >> >>      8 | rdma:          | general programming
>> >> >
>> >> > 8 rdma bugs??? ouch..
>> >> 
>> >> Mostly caught by a cleanup from Markus. Silly stuff like of mixed signed
>> >> integer comparisons and bugs in error handling. I don't even want to
>> >> look too much at it.
>> >> 
>> >> ...hopefully this release we'll manage to resolve that situation.
>> >> 
>> >> >
>> >> >>      7 | qmp            | new api bugs
>> >> >>      5 | postcopy       | races
>> >> >>      4 | file:          | leaks
>> >> >>      3 | return path    | races
>> >> >>      3 | fd_cleanup     | races
>> >> >>      2 | savevm, aio/coroutines
>> >> >>      1 | xbzrle, colo, dirtyrate, exec:,
>> >> >>           windows, iochannel, qemufile,
>> >> >>           arch (ppc64le)
>> >> >> 
>> >> >> Here, the migration-tests cover well: multifd, ram, qmp, postcopy,
>> >> >> file, rp, fd_cleanup, iochannel, qemufile, xbzrle.
>> >> >> 
>> >> >> My suggestion is we run per arch:
>> >> >> 
>> >> >> "/precopy/tcp/plain"
>> >> >> "/precopy/tcp/tls/psk/match",
>> >> >> "/postcopy/plain"
>> >> >> "/postcopy/preempt/plain"
>> >> >> "/postcopy/preempt/recovery/plain"
>> >> >> "/multifd/tcp/plain/cancel"
>> >> >> "/multifd/tcp/uri/plain/none"
>> >> >
>> >> > Don't you want to still keep a few multifd / file tests?
>> >> 
>> >> Not really, but I won't object if you want to add some more in there. To
>> >> be honest, I want to get out of people's way as much as I can because
>> >> having to revisit this every couple of months is stressful to me.
>> >
>> > I hope migration tests are not too obstructive yet so far :) - this
>> > discussion is still within a context where we might add one more slow test
>> > in CI, and we probably simply should make it a -m slow test.
>> >
>> >> 
>> >> My rationale for those is:
>> >> 
>> >> "/precopy/tcp/plain":
>> >>  Smoke test, the most common migration
>> >
>> > E.g. unix is missing, and I'm not sure which we use for e.g. kubevirt.
>> >
>> > And note that even if unix shares the socket iochannel with tcp, it may not
>> > work the same.  For example, if you remember I mentioned I was looking at
>> > threadify the dest qemu receive side, i have a draft there but currently it
>> > has a bug to hang a unix migration, not tcp..
>> 
>> Ok, let's add a unix one, no problem.
>> 
>> >
>> > So IMHO it's not easy to justify which we can simply drop, if we still want
>> > to provide some good gating in CI.
>> 
>> It's not exactly about dropping, it's about which ones need to be run at
>> *every* invocation of make check (x5 because of the multiple archs) and
>
> Yeah, indeed we could consider reducing the number of runs, maybe.  However
> I do remember we used to have migration-test bugs only reproduced with some
> specific distro, well..
>
> Now I'm looking at the pipelines..
>
> Why 5x, btw?

5x because migration-test supports 5 architectures (i386, x86_64, ppc64,
aarch64, s390x), so if your build includes all of those, make check will
run migration-test five times.

>  I saw alphine, centos, debian, fedora, opensuse, ubuntu,
> cfi-x86_64, then compat-x86_64.  So that's 8x?  They're for the same arch
> (amd64) so far.

I agree we should fine tune this in CI, but this is a different
discussion. We can't currently skip migration-test without skipping make
check-qtest. I proposed a while ago to have a separate make
check-migration, but people didn't like that, maybe we should revisit
the idea.

>
> Maybe we can skip some indeed.
>
>> at every git branch push in CI (unless -o ci.skip). For gating we don't
>> need all the tests. Many of them are testing the same core code with
>> just a few differences at the margins.
>> 
>> >  And I won't be 100% surprised if some
>> > other non-migration PR (e.g. io/) changed some slight bit that unix is
>> > broken and tcp keeps working, for example, then we loose some CI benefits.
>> 
>> IMO, these non-migration PRs are exactly what we have to worry
>> about. Because migration PRs would run with -m slow and we'd catch the
>> issue there.
>> 
>> >
>> >> 
>> >> "/precopy/tcp/tls/psk/match":
>> >>  Something might change in the distro regarding tls. Such as:
>> >>  https://gitlab.com/qemu-project/qemu/-/issues/1937
>> >> 
>> >> "/postcopy/plain":
>> >>  Smoke test for postcopy
>> >> 
>> >> "/postcopy/preempt/plain":
>> >>  Just to exercise the preempt thread
>> >> 
>> >> "/postcopy/preempt/recovery/plain":
>> >>  Recovery has had some issues with races in the past
>> >> 
>> >> "/multifd/tcp/plain/cancel":
>> >>  The MVP of catching concurrency issues
>> >> 
>> >> "/multifd/tcp/uri/plain/none":
>> >>  Smoke test for multifd
>> >> 
>> >> All in all, these will test basic funcionality and run very often. The
>> >> more tests we add to this set, the less return we get in relation to the
>> >> time they take.
>> >
>> > This is true.  We can try to discuss more on which is more important; I
>> > still think something might be good to be added on top of above.
>> 
>> Sure, just add what you think we need.
>
> Let's leave the detailed discussion on what to choose until the patch
> phase.  IIUC this can be the last we do.

ok

>
> We've just queued your other patch to "slow down" the two time consuming
> tests, we save 40s for each CI kick (total ~90s now locally, so that's 30%
> cut already all acrosss!), not so bad as a start.
>
> Then if we can remove some out of 8 (e.g., we can choose 2-3), then if it's
> 3 system runs, it'll be another 62% cut, a total of:
>
>   1.0 - 9/13 * 3/8 = ~75%
>
> So if we keep removing 5 system running it we can reduce it to only a
> quarter time comparing to before for each CI run.
>
> Would that be good enough already for us to live for quite a few more
> releases?  They're so far all low hanging fruits.

Reducing the runs in CI is not a low hanging fruit. We'd need to first
split migration-test from check-qtest somehow. But that would mean not
running migration-test at all during make check, which is worse than
just reducing migration-test while keeping it in make check.

>
> If we want to move further (and you think we should then start with
> reducing test case, rather than profiling the test cases), then feel free
> to go ahead and send a patch when you're ready.  But maybe you don't want
> to bother after you notice that we can already shrink 75% of runtime even
> without dropping anything.  Your call!

I don't think we're discussing total CI time at this point, so the math
doesn't really add up. We're not looking into making the CI finish
faster. We're looking into making migration-test finish faster. That
would reduce timeouts in CI, speed-up make check and reduce the chance
of random race conditions* affecting other people/staging runs.

*- like the one I'm debugging at this very moment in multifd+ppc, are
   you aware of that btw?

>
>> 
>> >
>> > There's also the other way - at some point, I still want to improve
>> > migration-test run speed, and please have a look if you like too at some
>> > point: so there's still chance (average is ~2sec as of now), IMHO, we don't
>> > lose anything in CI but runs simply faster.
>> 
>> My only idea, but it requires a bit of work, is to do unit testing on
>> the interfaces. Anything before migration_fd_connect(). Then we could
>> stop doing a full migration for those.
>
> What I'm thinking is some further profiling, like what Dan used to do.  I
> feel like we still have chance, considering what we run as guest image is
> simply a loop.. so basically zero boot time logically.

I started looking again today into code coverage tools to see if we can
trim the tests that are redundant. But no promises, I already have a
queue of stuff that's pending.

>
>> 
>> >
>> >> 
>> >> >
>> >> > IIUC some file ops can still be relevant to archs.  Multifd still has one
>> >> > bug that can only reproduce on arm64.. but not x86_64.  I remember it's a
>> >> > race condition when migration finishes, and the issue could be memory
>> >> > ordering relevant, but maybe not.
>> >> 
>> >> I'm not aware of anything. I believe the last arm64 bug we had was the
>> >> threadinfo stuff[1]. If you remember what it's about, let me know.
>> >> 
>> >> 1- 01ec0f3a92 ("migration/multifd: Protect accesses to migration_threads").
>> >
>> > https://issues.redhat.com/browse/RHEL-45628
>> 
>> Interesting. But if multifd/tcp/plain/cancel doesn't catch this I don't
>> think other tests will. Also, we don't have tests for zerocopy AFAIK.
>
> That'll be challenging as it requires locked_vm limit.
>
>> 
>> >
>> > On RH side Bandan is looking at it, but he's during a long holidays
>> > recently.
>> 
>> Good luck to him.
>> 
>> >
>> >> 
>> >> >
>> >> >> 
>> >> >> and x86 gets extra:
>> >> >> 
>> >> >> "/precopy/unix/suspend/live"
>> >> >> "/precopy/unix/suspend/notlive"
>> >> >> "/dirty_ring"
>> >> >
>> >> > dirty ring will be disabled anyway when !x86, so probably not a major
>> >> > concern.
>> >> >
>> >> >> 
>> >> >> (the other dirty_* tests are too slow)
>> >> >
>> >> > These are the 10 slowest tests when I run locally:
>> >> >
>> >> > /x86_64/migration/multifd/tcp/tls/x509/allow-anon-client 2.41
>> >> > /x86_64/migration/postcopy/recovery/plain 2.43
>> >> > /x86_64/migration/multifd/tcp/tls/x509/default-host 2.66
>> >> > /x86_64/migration/multifd/tcp/tls/x509/override-host 2.86
>> >> > /x86_64/migration/postcopy/tls/psk 2.91
>> >> > /x86_64/migration/postcopy/preempt/recovery/tls/psk 3.08
>> >> > /x86_64/migration/postcopy/preempt/tls/psk 3.30
>> >> > /x86_64/migration/postcopy/recovery/tls/psk 3.81
>> >> > /x86_64/migration/vcpu_dirty_limit 13.29
>> >> > /x86_64/migration/precopy/unix/xbzrle 27.55
>> >> >
>> >> > Are you aware of people using xbzrle at all?
>> >> 
>> >> Nope.
>> >> 
>> >> >
>> >> >> 
>> >> >> All the rest go behind a knob that people touching migration code will
>> >> >> enable.
>> >> >> 
>> >> >> wdyt?
>> >> >
>> >> > Agree with the general idea, but I worry above exact list can be too small.
>> >> 
>> >> We won't stop running the full set of tests. We can run them in our
>> >> forks' CI as much as we want. There are no cases of people reporting a
>> >> migration bug because their 'make check' caught something that ours
>> >> didn't.
>> >
>> > IIUC it's hard to say - when the test is in CI maintainers can catch them
>> > already before sending a formal PR.
>> >
>> > If the test is run by default in make check, a developer can trigger a
>> > migration issue (with his/her patch applied) then one can notice it
>> > introduced a bug, fix it, then post the patches.  We won't know whether
>> > that happened.
>> 
>> Good point.
>> 
>> >
>> > So one thing we can do (if you think worthwhile to do it now) is we shrink
>> > the default test case a lot as you proposed, then we wait and see what
>> > breaks, and then we gradually add tests back when it can be used to find
>> > breakages.  But that'll also take time if it really can find such tests,
>> > because then we'll need to debug them one by one (instead of developer /
>> > maintainer looking into them with their expertise knowledge..).  I'm not
>> > sure whether it's worthwhile to do it now, but I don't feel strongly if we
>> > can still have a reliable set of default test cases.
>> 
>> We first need a way to enable them for the migration CI. Do we have a
>> variable that CI understands that can be used to enable slow tests?
>
> I'm not aware of.  Yes sounds like we should have one if it doesn't exist.
>
>> 
>> >
>> >> 
>> >> Besides, the main strength of CI is to catch bugs when someone makes a
>> >> code change. If people touch migration code, then we'll run it in our CI
>> >> anyway. If they touch device code and that device is migrated by default
>> >> then any one of the simple tests will catch the issue when it runs via
>> >> the migration-compat job. If the device is not enabled by default, then
>> >> no tests will catch it.
>> >> 
>> >> The worst case scenario is they touch some code completely unrelated and
>> >> their 'make check' or CI run breaks because of some race in the
>> >> migration code. That's not what CI is for, that's just an annoyance for
>> >> everyone. I'd rather it breaks in our hands and then we'll go fix it.
>> >> 
>> >> >
>> >> > IMHO we can definitely, at least, move the last two into slow list
>> >> > (vcpu_dirty_limit and xbzrle), then it'll already save us 40sec each run..
>> >> 
>> >> Agreed. I'll send a patch once I get out from under downstream stuff.
>> >> 
>> >> >
>> >> >> 
>> >> >> 1- allows adding devices to QEMU cmdline for migration-test
>> >> >> https://lore.kernel.org/r/20240523201922.28007-4-farosas@suse.de
>> >> >> 
>> >> 
>> 

