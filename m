Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ADAC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVALO-0002Ap-BY; Wed, 31 Jan 2024 08:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVALI-0002AJ-6K
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:09:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVALC-0003vB-9Y
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:09:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9218B1F37C;
 Wed, 31 Jan 2024 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706706559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JaDrnTo/rQvKGpq4pjEfpNXnbNZaJHYmh8TcujvCZU=;
 b=AmfGO21IbdsoWIdOxtDN5J4gtQ86OJrtPscp4n80gV6hIavHbowfMpmgeskx8LATvRCWuj
 lXiVRKAFUm1m6Pk8XaX1wXRmjmTux4nkyGAhz479pemDJ/baP0rX11MwscuczZf82Xu7cD
 mGYxtQ4h/HmbnkkuHtsrlx/Y5AivqWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706706559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JaDrnTo/rQvKGpq4pjEfpNXnbNZaJHYmh8TcujvCZU=;
 b=yAwZ2X8EQQXSIq+z6PdAdij1SndIrWyADw+zobxkKA6pl+OjUHKloWJMrsB7ctkbiUl0qX
 wk8K9fVzHBZ18dBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706706559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JaDrnTo/rQvKGpq4pjEfpNXnbNZaJHYmh8TcujvCZU=;
 b=AmfGO21IbdsoWIdOxtDN5J4gtQ86OJrtPscp4n80gV6hIavHbowfMpmgeskx8LATvRCWuj
 lXiVRKAFUm1m6Pk8XaX1wXRmjmTux4nkyGAhz479pemDJ/baP0rX11MwscuczZf82Xu7cD
 mGYxtQ4h/HmbnkkuHtsrlx/Y5AivqWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706706559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JaDrnTo/rQvKGpq4pjEfpNXnbNZaJHYmh8TcujvCZU=;
 b=yAwZ2X8EQQXSIq+z6PdAdij1SndIrWyADw+zobxkKA6pl+OjUHKloWJMrsB7ctkbiUl0qX
 wk8K9fVzHBZ18dBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA911347F;
 Wed, 31 Jan 2024 13:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VO4pNX5GumWhAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 13:09:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
In-Reply-To: <ZbnG3qkMBPdsQxan@x1n>
References: <20240126041725.124562-7-peterx@redhat.com>
 <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de> <ZbcSqyGNLGu7ugBb@x1n> <87sf2ge3qu.fsf@suse.de>
 <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de> <ZbnG3qkMBPdsQxan@x1n>
Date: Wed, 31 Jan 2024 10:09:16 -0300
Message-ID: <878r45lkeb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AmfGO21I;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yAwZ2X8E
X-Spamd-Result: default: False [-6.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 BAYES_HAM(-3.00)[100.00%]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9218B1F37C
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Tue, Jan 30, 2024 at 06:23:10PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Jan 30, 2024 at 10:18:07AM +0000, Peter Maydell wrote:
>> >> On Mon, 29 Jan 2024 at 23:31, Fabiano Rosas <farosas@suse.de> wrote:
>> >> >
>> >> > Fabiano Rosas <farosas@suse.de> writes:
>> >> >
>> >> > > Peter Xu <peterx@redhat.com> writes:
>> >> > >
>> >> > >> On Fri, Jan 26, 2024 at 11:54:32AM -0300, Fabiano Rosas wrote:
>> >> > > The issue that occurs to me now is that 'cpu host' will not work with
>> >> > > TCG. We might actually need to go poking /dev/kvm for this to work.
>> >> >
>> >> > Nevermind this last part. There's not going to be a scenario where we
>> >> > build with CONFIG_KVM, but run in an environment that does not support
>> >> > KVM.
>> >> 
>> >> Yes, there is. We'll build with CONFIG_KVM on any aarch64 host,
>> >> but that doesn't imply that the user running the build and
>> >> test has permissions for /dev/kvm.
>> >
>> > I'm actually pretty confused on why this would be a problem even for
>> > neoverse-n1: can we just try to use KVM, if it fails then use TCG?
>> > Something like:
>> >
>> >   (construct qemu cmdline)
>> >   ..
>> > #ifdef CONFIG_KVM
>> 
>> >   "-accel kvm "
>> > #endif
>> >   "-accel tcg "
>> >   ..
>> >
>> > ?
>> > IIUC if we specify two "-accel", we'll try the first, then if failed then
>> > the 2nd?
>> 
>> Aside from '-cpu max', there's no -accel and -cpu combination that works
>> on all of:
>> 
>> x86_64 host - TCG-only
>> aarch64 host - KVM & TCG
>> aarch64 host with --disable-tcg - KVM-only
>> aarch64 host without access to /dev/kvm - TCG-only
>> 
>> And the cpus are:
>> host - KVM-only
>> neoverse-n1 - TCG-only
>> 
>> We'll need something like:
>> 
>> /* covers aarch64 host with --disable-tcg */
>> if (qtest_has_accel("kvm") && !qtest_has_accel("tcg")) {
>>    if (open("/dev/kvm", O_RDONLY) < 0) {
>>        g_test_skip()
>>    } else {
>>        "-accel kvm -cpu host"
>>    }
>> }
>> 
>> /* covers x86_64 host */
>> if (!qtest_has_accel("kvm") && qtest_has_accel("tcg")) {
>>    "-accel tcg -cpu neoverse-n1"
>> }
>> 
>> /* covers aarch64 host */
>> if (qtest_has_accel("kvm") && qtest_has_accel("tcg")) {
>>    if (open("/dev/kvm", O_RDONLY) < 0) {
>>       "-accel tcg -cpu neoverse-n1"
>>    } else {
>>       "-accel kvm -cpu host"
>>    }
>> }
>
> The open("/dev/kvm") logic more or less duplicates what QEMU already does
> when init accelerators:
>
>     if (!qemu_opts_foreach(qemu_find_opts("accel"),
>                            do_configure_accelerator, &init_failed, &error_fatal)) {
>         if (!init_failed) {
>             error_report("no accelerator found");
>         }
>         exit(1);
>     }
>
> If /dev/kvm not accessible I think it'll already fallback to tcg here, as
> do_configure_accelerator() for kvm will just silently fail for qtest.  I
> hope we can still rely on that for /dev/kvm access issues.

If we ask for KVM and it falls back to TCG, we need a cpu that supports
both. We don't have that. I've put some command-line combinations at the
end of the email[1], take a look.

If we ask for KVM only and /dev/kvm is not accessible, the test will
fail and we can prevent that by checking beforehand. It's much simpler
to check first and do the right thing than to run the QEMU binary and
somehow work around the test failure in migration-test.

>
> Hmm, I just notice that test_migrate_start() already has this later:
>
>         "-accel kvm%s -accel tcg "
>
> So we're actually good from that regard, AFAIU.
>
> Then did I understand it right that in the failure case KVM is properly
> initialized, however it crashed later in neoverse-n1 asking for TCG?  So

It didn't crash. It simply does not accept the neoverse-n1 with KVM
because it's unsupported:

 qemu-system-aarch64: KVM is not supported for this guest CPU type
 qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument

> the logic in the accel code above didn't really work to do a real fallback?

Yep, it didn't.

> A backtrace of such crash would help, maybe; I tried to find it in the
> pipeline log but I can only see:
>
>   ----------------------------------- stderr -----------------------------------
>   Broken pipe
>   ../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

We need to fix the QTEST_LOG logic someday. It currently hides QEMU
stderr. But when we enable logging then it logs every single serial read
and write and query-migrate in the face of the earth and it floods the
logs.

>
> Or, is there some aarch64 cpu that will have a stable CPU ABI (not like
> -max, which is unstable), meanwhile supports both TCG + KVM?

Not as far as I know.

>
> Another thing I noticed that we may need to be caution is that currently
> gic is also using max version:
>
>         machine_opts = "gic-version=max";
>
> We may want to choose a sane version too, probably altogether with the
> patch?

Good point.


====================
[1]
On x86_64:
==========

-cpu host
---------
 $ ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm
 qemu-system-aarch64: -accel kvm: invalid accelerator kvm

 $ ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg
 qemu-system-aarch64: unable to find CPU model 'host'

 $ ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm -accel tcg
 qemu-system-aarch64: -accel kvm: invalid accelerator kvm
 qemu-system-aarch64: falling back to tcg
 qemu-system-aarch64: unable to find CPU model 'host'

 $ ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg -accel kvm
 qemu-system-aarch64: unable to find CPU model 'host'

-cpu neoverse-n1
----------------
 $ ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel tcg
 works

 $ ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel kvm
 qemu-system-aarch64: -accel kvm: invalid accelerator kvm

 $ ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel kvm -accel tcg
 qemu-system-aarch64: -accel kvm: invalid accelerator kvm
 qemu-system-aarch64: falling back to tcg
 works

 $ ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel tcg -accel kvm
 works

On aarch64:
===========

-cpu host
---------
 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm
 works

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg
 qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm -accel tcg
 works

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg -accel kvm
 qemu-system-aarch64: The 'host' CPU type can only be used with KVM or
 HVF

-cpu neoverse-n1
----------------

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel kvm
 qemu-system-aarch64: KVM is not supported for this guest CPU type
 qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel tcg
 works

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel kvm -accel tcg
 qemu-system-aarch64: KVM is not supported for this guest CPU type
 qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel tcg -accel kvm
 works

On aarch64 --disable-tcg:
=========================

-cpu host
---------

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm
 works

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg
 qemu-system-aarch64: -accel tcg: invalid accelerator tcg

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm -accel tcg
 works

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg -accel kvm
 qemu-system-aarch64: -accel tcg: invalid accelerator tcg
 qemu-system-aarch64: falling back to KVM
 works

-cpu neoverse-n1
----------------

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel kvm
 qemu-system-aarch64: unable to find CPU model 'neoverse-n1'

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel tcg
 qemu-system-aarch64: -accel tcg: invalid accelerator tcg

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel kvm -accel tcg
 qemu-system-aarch64: unable to find CPU model 'neoverse-n1'

 # ./qemu-system-aarch64 -nographic -machine virt -cpu neoverse-n1 -accel tcg -accel kvm
 qemu-system-aarch64: -accel tcg: invalid accelerator tcg
 qemu-system-aarch64: falling back to KVM
 qemu-system-aarch64: unable to find CPU model 'neoverse-n1'

On aarch64 without access to /dev/kvm:
======================================

-cpu host
---------

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm
 Could not access KVM kernel module: No such file or directory
 qemu-system-aarch64: -accel kvm: failed to initialize kvm: No such file
 or directory

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg
 qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel kvm -accel tcg
 Could not access KVM kernel module: No such file or directory
 qemu-system-aarch64: -accel kvm: failed to initialize kvm: No such file or directory
 qemu-system-aarch64: falling back to tcg
 qemu-system-aarch64: The 'host' CPU type can only be used with KVM or
 HVF

 # ./qemu-system-aarch64 -nographic -machine virt -cpu host -accel tcg -accel kvm
 qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

