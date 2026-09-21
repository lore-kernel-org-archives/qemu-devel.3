Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCAAC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lTz-0003Of-GM; Mon, 21 Sep 2026 17:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8lTp-0003OI-3K
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:23:18 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8lTn-0006Vs-An
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:23:16 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA82C21C07;
 Mon, 21 Sep 2026 21:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790025789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f09wMQXzpnr93cPjX+OZO+pnG5wxWe/On2ZtMBCg7m0=;
 b=GNOdBi62aiHHEdjHClBQ8tqs3pklmHDC+2mn/b+QL5jE5EWdpa5THtCrVepOXU1JHJ4g4p
 rNdki5G8kDEDGjDHZnmLI9QMICZTHv0/4omPZq+V81BWj7zZdqy2VewAqEbrec/de28lMk
 R+C+CoLtYaKOjzyGjpCRWpxP0f/HgUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790025789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f09wMQXzpnr93cPjX+OZO+pnG5wxWe/On2ZtMBCg7m0=;
 b=J1m9LJMFsVSz4Pbc8MZj3k3HR6nI2ZMswnYnuJrknuE2XqnU83MOVfh2m18DyGvtePPT4a
 7y4LvLArNpLyfvAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790025784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f09wMQXzpnr93cPjX+OZO+pnG5wxWe/On2ZtMBCg7m0=;
 b=Uw1zXlgshnvH/rjMR9MZi7z6PF/m7u4s4XQfVpG6C212kJq+CgaEKfew4lllXs5IoR3+aZ
 KtsX25IGdy83z0c+gOyfiIrE1c9bsrypNvD9TqhUvQk62mFFfeVcfsA0SJAB3W3CgWXse3
 CCkcCoiAMs74sd++CpGVznJRUPLYHS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790025784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f09wMQXzpnr93cPjX+OZO+pnG5wxWe/On2ZtMBCg7m0=;
 b=+kIyTlhM9uFI0WCxvQmB97u9NavB3wazuVYqPoUr2PZje1TwzUJpK/DTCxBh6agAvKmqin
 gtzv/KVm2wNO3RCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6967413793;
 Mon, 21 Sep 2026 21:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6DbYAzigsWqIbAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Sep 2026 21:23:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH] accel: Fix qtest deadlock during unplug
In-Reply-To: <f5882baf-9f06-4bcf-bcc3-3110ad584e7a@oss.qualcomm.com>
References: <20260918140037.3082357-1-farosas@suse.de>
 <f5882baf-9f06-4bcf-bcc3-3110ad584e7a@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 18:22:57 -0300
Message-ID: <87h5ji70zy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Hi Fabiano,
>
> On 2026-09-18 16:00, Fabiano Rosas wrote:
>> This is a revert of one hunk of commit d5e33b5f8f ("accel: make all
>> calls to qemu_process_cpu_events look the same"). It regressed
>> device-plug-test on ppc64. Run this in a loop and it deadlocks before
>> 50 iterations:
>>=20
>> QTEST_QEMU_BINARY=3D./qemu-system-ppc64 ./tests/qtest/device-plug-test -p
>> /ppc64/device-plug/spapr-cpu-unplug-request
>>=20
>> The deadlocked stacks are:
>> T0:
>>   #0  in sigtimedwait
>>   #1  in sigwait
>>   #2  in dummy_cpu_thread_fn (arg=3D0x558ed4db8eb0) at ../accel/dummy-cp=
us.c:52
>>=20
>> T1:
>>   #2  in qemu_thread_join (thread=3D0x55e3803dfc60) at ../util/qemu-thre=
ad-posix.c:554
>>   #3  in cpu_remove_sync (cpu=3D0x558ed4db8eb0) at ../system/cpus.c:633
>>   #4  in ppc_cpu_unrealize (dev=3D0x558ed4db8eb0) at ../target/ppc/cpu_i=
nit.c:6967
>>=20
>> What the test does is to queue a cpu unplug request to be executed
>> during system reset. So we end up with two cpu_exit() calls affecting
>> the dummy loop, one via pause_all_cpus() and another via
>> cpu_remove_sync().
>
> I don't understand why we have these few per-target cpu_remove_sync()
> calls. IMO it should only be called by core vcpu accel scheduler layer.
>

TLDR: ppc introduced it at the machine level (spapr_cpu_core.c) to handle
cpu hot-unplug. It later got moved into cpu unrealize.

Let's look at the history:

1) cpu_remove_sync() was introduced to deal with hot-unplug failures.
2c579042e3 (cpu: Add a sync version of cpu_remove(), 2016-05-12)

2) The cpu->unplug logic is due to the possibility of requesting a cpu
unplug, leaving the cpu object in the list and then later plugging the
cpu again and re-using that object (I'm not sure, looks more like a
comment from KVM point of view).
4c055ab54f (cpu: Reclaim vCPU objects, 2016-05-12)

3) For x86, it seems cpu_remove_sync() is called just for regular
cleanup.
c884776e9d (target-i386: Add x86_cpu_unrealizefn(), 2016-06-24)

3) The _sync version got later turned into the default with the removal
of the async one.
dbadee4ff4 (cpus: join thread when removing a vCPU, 2018-01-30)

I'm confused about two aspects of this:

1) Checking cpu->unplug in the run loops in general because it seems to
make most of cpu_can_run() redundant since cpu->stop is also set during
cpu_remove_sync(). It's not clear to me what sort of concurrency can
keep the loop going once cpu->unplug=3Dtrue.

To me it looks like we could very well move the cpu->unplug check into
cpu_can_run(), move qemu_process_cpu_events(cpu) back to the end of the
loop and merge both (where there are two) calls to cpu_can_run(). E.g.:

    do {
        bql_unlock();
        excp =3D tcg_cpu_exec(cpu);
        qemu_process_cpu_events(cpu);
        bql_lock();
    } while (cpu_can_run());

2) Not all targets set cpu->unplug, but the check happens for all. What
exactly stops their vcpus threads? And, obviously, is it safe to now use
cpu->unplug.




