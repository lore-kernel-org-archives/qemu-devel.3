Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859BDEE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9H8-0005AS-JC; Tue, 10 Sep 2024 18:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1so9H5-0004Th-So
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:23:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1so9H3-000868-AE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:23:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66AB221A55;
 Tue, 10 Sep 2024 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlfQMGgVDRwhBZb42QR9vuXiegX3X1IHDs3biMprsV4=;
 b=Rhfkyf9Suf7GN/u4fbKlsiceDFK4wPi2+LlmsH0qmJ8FRPmjcxkPC52HBsmWR2fmRLaNZG
 TBPAMq6kz37rhHCGsO+hjybk66hO+li4435U62Ta+ojxgN4xvt27KeghEYoPhur52iSNfI
 rjoEx1ymJ45HGRjCK4EEIPrEg/R5oSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlfQMGgVDRwhBZb42QR9vuXiegX3X1IHDs3biMprsV4=;
 b=OcHWT2TK0/i3cC8gQqi+n95u6/3TrdyjsIlrskNIPeiL3lgPASgGxMxvYzvWryiH9A2DLO
 7Fv7TPxQzlYP61Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rhfkyf9S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OcHWT2TK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlfQMGgVDRwhBZb42QR9vuXiegX3X1IHDs3biMprsV4=;
 b=Rhfkyf9Suf7GN/u4fbKlsiceDFK4wPi2+LlmsH0qmJ8FRPmjcxkPC52HBsmWR2fmRLaNZG
 TBPAMq6kz37rhHCGsO+hjybk66hO+li4435U62Ta+ojxgN4xvt27KeghEYoPhur52iSNfI
 rjoEx1ymJ45HGRjCK4EEIPrEg/R5oSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlfQMGgVDRwhBZb42QR9vuXiegX3X1IHDs3biMprsV4=;
 b=OcHWT2TK0/i3cC8gQqi+n95u6/3TrdyjsIlrskNIPeiL3lgPASgGxMxvYzvWryiH9A2DLO
 7Fv7TPxQzlYP61Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF810132CB;
 Tue, 10 Sep 2024 22:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0mR5IvLG4GZ9OQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Sep 2024 22:23:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Hyman Huang
 <yong.huang@smartx.com>, qemu-devel@nongnu.org, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, David
 Hildenbrand <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
In-Reply-To: <ZuC4pYT-atQwWePv@x1n>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
Date: Tue, 10 Sep 2024 19:23:43 -0300
Message-ID: <87seu7qhao.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 66AB221A55
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Mon, Sep 09, 2024 at 06:54:46PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Sep 09, 2024 at 03:02:57PM +0100, Peter Maydell wrote:
>> >> On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
>> >> >
>> >> > Despite the fact that the responsive CPU throttle is enabled,
>> >> > the dirty sync count may not always increase because this is
>> >> > an optimization that might not happen in any situation.
>> >> >
>> >> > This test case just making sure it doesn't interfere with any
>> >> > current functionality.
>> >> >
>> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> >> 
>> >> tests/qtest/migration-test already runs 75 different
>> >> subtests, takes up a massive chunk of our "make check"
>> >> time, and is very commonly a "times out" test on some
>> >> of our CI jobs. It runs on five different guest CPU
>> >> architectures, each one of which takes between 2 and
>> >> 5 minutes to complete the full migration-test.
>> >> 
>> >> Do we really need to make it even bigger?
>> >
>> > I'll try to find some time in the next few weeks looking into this to see
>> > whether we can further shrink migration test times after previous attemps
>> > from Dan.  At least a low hanging fruit is we should indeed put some more
>> > tests into g_test_slow(), and this new test could also be a candidate (then
>> > we can run "-m slow" for migration PRs only).
>> 
>> I think we could (using -m slow or any other method) separate tests
>> that are generic enough that every CI run should benefit from them
>> vs. tests that are only useful once someone starts touching migration
>> code. I'd say very few in the former category and most of them in the
>> latter.
>> 
>> For an idea of where migration bugs lie, I took a look at what was
>> fixed since 2022:
>> 
>> # bugs | device/subsystem/arch
>> ----------------------------------
>>     54 | migration
>>     10 | vfio
>>      6 | ppc
>>      3 | virtio-gpu
>>      2 | pcie_sriov, tpm_emulator,
>>           vdpa, virtio-rng-pci
>>      1 | arm, block, gpio, lasi,
>>           pci, s390, scsi-disk,
>>           virtio-mem, TCG
>
> Just curious; how did you collect these?

git log --since=2022 and then squinted at it. I wrote a warning to take
this with a grain of salt, but it missed the final version.

>
>> 
>> From these, ignoring the migration bugs, the migration-tests cover some
>> of: arm, ppc, s390, TCG. The device_opts[1] patch hasn't merged yet, but
>> once it is, then virtio-gpu would be covered and we could investigate
>> adding some of the others.
>> 
>> For actual migration code issues:
>> 
>> # bugs | (sub)subsystem | kind
>> ----------------------------------------------
>>     13 | multifd        | correctness/races
>>      8 | ram            | correctness
>>      8 | rdma:          | general programming
>
> 8 rdma bugs??? ouch..

Mostly caught by a cleanup from Markus. Silly stuff like of mixed signed
integer comparisons and bugs in error handling. I don't even want to
look too much at it.

...hopefully this release we'll manage to resolve that situation.

>
>>      7 | qmp            | new api bugs
>>      5 | postcopy       | races
>>      4 | file:          | leaks
>>      3 | return path    | races
>>      3 | fd_cleanup     | races
>>      2 | savevm, aio/coroutines
>>      1 | xbzrle, colo, dirtyrate, exec:,
>>           windows, iochannel, qemufile,
>>           arch (ppc64le)
>> 
>> Here, the migration-tests cover well: multifd, ram, qmp, postcopy,
>> file, rp, fd_cleanup, iochannel, qemufile, xbzrle.
>> 
>> My suggestion is we run per arch:
>> 
>> "/precopy/tcp/plain"
>> "/precopy/tcp/tls/psk/match",
>> "/postcopy/plain"
>> "/postcopy/preempt/plain"
>> "/postcopy/preempt/recovery/plain"
>> "/multifd/tcp/plain/cancel"
>> "/multifd/tcp/uri/plain/none"
>
> Don't you want to still keep a few multifd / file tests?

Not really, but I won't object if you want to add some more in there. To
be honest, I want to get out of people's way as much as I can because
having to revisit this every couple of months is stressful to me.

My rationale for those is:

"/precopy/tcp/plain":
 Smoke test, the most common migration

"/precopy/tcp/tls/psk/match":
 Something might change in the distro regarding tls. Such as:
 https://gitlab.com/qemu-project/qemu/-/issues/1937

"/postcopy/plain":
 Smoke test for postcopy

"/postcopy/preempt/plain":
 Just to exercise the preempt thread

"/postcopy/preempt/recovery/plain":
 Recovery has had some issues with races in the past

"/multifd/tcp/plain/cancel":
 The MVP of catching concurrency issues

"/multifd/tcp/uri/plain/none":
 Smoke test for multifd

All in all, these will test basic funcionality and run very often. The
more tests we add to this set, the less return we get in relation to the
time they take.

>
> IIUC some file ops can still be relevant to archs.  Multifd still has one
> bug that can only reproduce on arm64.. but not x86_64.  I remember it's a
> race condition when migration finishes, and the issue could be memory
> ordering relevant, but maybe not.

I'm not aware of anything. I believe the last arm64 bug we had was the
threadinfo stuff[1]. If you remember what it's about, let me know.

1- 01ec0f3a92 ("migration/multifd: Protect accesses to migration_threads").

>
>> 
>> and x86 gets extra:
>> 
>> "/precopy/unix/suspend/live"
>> "/precopy/unix/suspend/notlive"
>> "/dirty_ring"
>
> dirty ring will be disabled anyway when !x86, so probably not a major
> concern.
>
>> 
>> (the other dirty_* tests are too slow)
>
> These are the 10 slowest tests when I run locally:
>
> /x86_64/migration/multifd/tcp/tls/x509/allow-anon-client 2.41
> /x86_64/migration/postcopy/recovery/plain 2.43
> /x86_64/migration/multifd/tcp/tls/x509/default-host 2.66
> /x86_64/migration/multifd/tcp/tls/x509/override-host 2.86
> /x86_64/migration/postcopy/tls/psk 2.91
> /x86_64/migration/postcopy/preempt/recovery/tls/psk 3.08
> /x86_64/migration/postcopy/preempt/tls/psk 3.30
> /x86_64/migration/postcopy/recovery/tls/psk 3.81
> /x86_64/migration/vcpu_dirty_limit 13.29
> /x86_64/migration/precopy/unix/xbzrle 27.55
>
> Are you aware of people using xbzrle at all?

Nope.

>
>> 
>> All the rest go behind a knob that people touching migration code will
>> enable.
>> 
>> wdyt?
>
> Agree with the general idea, but I worry above exact list can be too small.

We won't stop running the full set of tests. We can run them in our
forks' CI as much as we want. There are no cases of people reporting a
migration bug because their 'make check' caught something that ours
didn't.

Besides, the main strength of CI is to catch bugs when someone makes a
code change. If people touch migration code, then we'll run it in our CI
anyway. If they touch device code and that device is migrated by default
then any one of the simple tests will catch the issue when it runs via
the migration-compat job. If the device is not enabled by default, then
no tests will catch it.

The worst case scenario is they touch some code completely unrelated and
their 'make check' or CI run breaks because of some race in the
migration code. That's not what CI is for, that's just an annoyance for
everyone. I'd rather it breaks in our hands and then we'll go fix it.

>
> IMHO we can definitely, at least, move the last two into slow list
> (vcpu_dirty_limit and xbzrle), then it'll already save us 40sec each run..

Agreed. I'll send a patch once I get out from under downstream stuff.

>
>> 
>> 1- allows adding devices to QEMU cmdline for migration-test
>> https://lore.kernel.org/r/20240523201922.28007-4-farosas@suse.de
>> 

