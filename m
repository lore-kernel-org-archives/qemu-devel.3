Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5304C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5RkK-0005RM-67; Thu, 17 Apr 2025 12:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u5RkI-0005RA-M1
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:05:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u5RkE-00028x-Vu
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:05:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7C441F391;
 Thu, 17 Apr 2025 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744905940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aq/R5FECjLRK3/ZFP1SwZE5j4Cp3GhTcl69BgN8anFc=;
 b=msFhv7WOBYcjxHhF2Jp11FGFRLP6mwVRkcCEVoCUON/x0205vIwOHkzj7mII+Qt9javUxG
 vw/Gnrejf+TtqYBzw8nMqj8iH7zEwbHJpjd63qJg0HqW0v0X3uJx3nzp6IY8d/9TE/dsTJ
 Gs8iqbsomSLYLnJIjzySVqi3Y0JlIBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744905940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aq/R5FECjLRK3/ZFP1SwZE5j4Cp3GhTcl69BgN8anFc=;
 b=XzJW0o+IIEL5Pr3/ygvdLOLs6g2fLBniXVDffqho0+bE8Aw2Gry9WQWviby3JJhqTmp1Eo
 Jse5FyWi/OZwUuAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744905940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aq/R5FECjLRK3/ZFP1SwZE5j4Cp3GhTcl69BgN8anFc=;
 b=msFhv7WOBYcjxHhF2Jp11FGFRLP6mwVRkcCEVoCUON/x0205vIwOHkzj7mII+Qt9javUxG
 vw/Gnrejf+TtqYBzw8nMqj8iH7zEwbHJpjd63qJg0HqW0v0X3uJx3nzp6IY8d/9TE/dsTJ
 Gs8iqbsomSLYLnJIjzySVqi3Y0JlIBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744905940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aq/R5FECjLRK3/ZFP1SwZE5j4Cp3GhTcl69BgN8anFc=;
 b=XzJW0o+IIEL5Pr3/ygvdLOLs6g2fLBniXVDffqho0+bE8Aw2Gry9WQWviby3JJhqTmp1Eo
 Jse5FyWi/OZwUuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16F1E1388F;
 Thu, 17 Apr 2025 16:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nE2BMdMmAWhacQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Apr 2025 16:05:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
Date: Thu, 17 Apr 2025 13:05:37 -0300
Message-ID: <87y0vyepta.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.941]; MIME_GOOD(-0.10)[text/plain];
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
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Wed, 16 Apr 2025 at 18:29, Fabiano Rosas <farosas@suse.de> wrote:
>> > The issue is that a zero page is being migrated by multifd but there's
>> > an optimization in place that skips faulting the page in on the
>> > destination. Later during postcopy when the page is found to be missing,
>> > postcopy (@migrate_send_rp_req_pages) believes the page is already
>> > present due to the receivedmap for that pfn being set and thus the code
>> > accessing the guest memory just sits there waiting for the page.
>> >
>> > It seems your series has a logical conflict with this work that was done
>> > a while back:
>> >
>> > https://lore.kernel.org/all/20240401154110.2028453-1-yuan1.liu@intel.com/
>> >
>> > The usage of receivedmap for multifd was supposed to be mutually
>> > exclusive with postcopy. Take a look at the description of that series
>> > and at postcopy_place_page_zero(). We need to figure out what needs to
>> > change and how to do that compatibly. It might just be the case of
>> > memsetting the zero page always for postcopy, but I havent't thought too
>> > much about it.
>
> ===
> $ grep -i avx /proc/cpuinfo
> flags        : avx avx2 avx512f avx512dq avx512ifma avx512cd avx512bw
> avx512vl avx512vbmi avx512_vbmi2 avx512_vnni avx512_bitalg
> avx512_vpopcntdq avx512_vp2intersect
> $
> $ ./configure --enable-kvm --enable-avx512bw --enable-avx2
> --disable-docs --target-list='x86_64-softmmu'
> $ make -sj10 check-qtest
> 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>      OK             193.80s   81 subtests passed
> ===
>
> * One of my machines does seem to support 'avx*' instructions. QEMU is
> configured and built with the 'avx2' and 'avx512bw' support. Still
> migration-tests run fine, without any hang issue observed. Not sure
> why the hang issue is not reproducing on my side. How do you generally
> build QEMU to run these tests?  Does this issue require some specific
> h/w setup/support?
>

There's nothing unusual here that I know of. Configure line is just
--target-list=x86_64-softmmu --enable-debug --disable-docs --disable-plugins.

> * Not sure how/why page faults happen during the Multifd phase when
> the guest on the destination is not running. If 'receivedmap' says
> that page is present, code accessing guest memory should just access
> whatever is available/present in that space, without waiting. I'll try
> to see what zero pages do, how page-faults occur during postcopy and
> how they are serviced. Let's see..

It's not that page faults happen during multifd. The page was already
sent during precopy, but multifd-recv didn't write to it, it just marked
the receivedmap. When postcopy starts, the page gets accessed and
faults. Since postcopy is on, the migration wants to request the page
from the source, but it's present in the receivedmap, so it doesn't
ask. No page ever comes and the code hangs waiting for the page fault to
be serviced (or potentially faults continuously? I'm not sure on the
details).

>
> * Another suggestion is, maybe we should review and pull at least the
> refactoring patches so that in the next revisions we don't have to
> redo them. We can hold back the "enable multifd and postcopy together"
> patch that causes this guest hang issue to surface.
>

That's reasonable. But I won't be available for the next two
weeks. Peter is going to be back in the meantime, let's hear what he has
to say about this postcopy issue. I'll provide my r-bs.

>> > There's also other issues with the series:
>> >
>> > https://gitlab.com/farosas/qemu/-/pipelines/1770488059
>> >
>> > The CI workers don't support userfaultfd so the tests need to check for
>> > that properly. We have MigrationTestEnv::has_uffd for that.
>> >
>> > Lastly, I have seem some weirdness with TLS channels disconnections
>> > leading to asserts in qio_channel_shutdown() in my testing. I'll get a
>> > better look at those tomorrow.
>>
>> Ok, you can ignore this last paragraph. I was seeing the postcopy
>> recovery test disconnect messages, those are benign.
>
> * ie. ignore everything after - "There's also other issues with this
> series: " ?  OR just the last one " ...with TLS channels..." ??
> Postcopy tests are added only if (env->has_uffd) check returns true.
>

Only the TLS part. The CI is failing with just this series. I didn't
change anything there. Maybe there's a bug in the userfaultfd detection?
I'll leave it to you, here's the error:

# Running /ppc64/migration/multifd+postcopy/tcp/plain/cancel
# Using machine type: pseries-10.0
# starting QEMU: exec ./qemu-system-ppc64 -qtest
#  unix:/tmp/qtest-1305.sock -qtest-log /dev/null -chardev
#  socket,path=/tmp/qtest-1305.qmp,id=char0 -mon
#  chardev=char0,mode=control -display none -audio none -accel kvm -accel
#  tcg -machine pseries-10.0,vsmt=8 -name source,debug-threads=on -m 256M
#  -serial file:/tmp/migration-test-X0SO42/src_serial -nodefaults
#  -machine
#  cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off,
#  -bios /tmp/migration-test-X0SO42/bootsect 2>/dev/null -accel qtest
# starting QEMU: exec ./qemu-system-ppc64 -qtest
#  unix:/tmp/qtest-1305.sock -qtest-log /dev/null -chardev
#  socket,path=/tmp/qtest-1305.qmp,id=char0 -mon
#  chardev=char0,mode=control -display none -audio none -accel kvm -accel
#  tcg -machine pseries-10.0,vsmt=8 -name target,debug-threads=on -m 256M
#  -serial file:/tmp/migration-test-X0SO42/dest_serial -incoming defer
#  -nodefaults -machine
#  cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off,
#  -bios /tmp/migration-test-X0SO42/bootsect 2>/dev/null -accel qtest
# {
#     "error": {
#         "class": "GenericError",
#         "desc": "Postcopy is not supported: Userfaultfd not available: Function not implemented"
#     }
# }


