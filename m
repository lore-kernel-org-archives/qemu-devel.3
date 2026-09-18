Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F04DC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7gZZ-0004GX-97; Fri, 18 Sep 2026 17:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7gZW-0004BI-UY
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 17:56:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7gZR-000373-L8
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 17:56:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C200D21DB0;
 Fri, 18 Sep 2026 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789768592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSupzlOjZXxO5d++9IUKd7X6vzexwIwk1jsKdF60F+Q=;
 b=QcYLbi4nexc1aKMHgftDaOHtXUpYC8/v7sah6JEtEqpKka4lQuWn74RaGJDpW20qlKHE8T
 Do/18xkFf3S/4lXqq9dReAHngL2kURBOeAX7jv0182ICUuzJ1bJxHpt0gUkaj5fo9UchRg
 xykvTiGDU11JfDhu57n6OpBZHV8VlmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789768592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSupzlOjZXxO5d++9IUKd7X6vzexwIwk1jsKdF60F+Q=;
 b=YkYuiXxhTlG0kN8DIM7G5cNhjVi9Df9EWlD0LcTQPJLO09gdztxpA13mxhLQCJEMlBYMz7
 cVNVVEQyNRtO1CCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789768587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSupzlOjZXxO5d++9IUKd7X6vzexwIwk1jsKdF60F+Q=;
 b=t8l4dm5OlNrz5nr3bHzhCpGjA5ft9MaCl/tT9EY9Q+mCw0F1/Qkrpfdp5CbphIvckPAZi9
 Lsi3DQn1Jisk0eBRFTnCCvBysz0o3TGkaEwN4CNkP3If7lZqT1cC8VcwlPlJbKuPV/OKRG
 2SP9l9D4M+BC5Iq+JRff7tO3GtE4Ts0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789768587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSupzlOjZXxO5d++9IUKd7X6vzexwIwk1jsKdF60F+Q=;
 b=OHLuFxhLycYXQz3sEVfb/4AETzn/U5+hBsE93yotFfxPO073Vj8xmleXCiyHoGZt9bfrcQ
 h0pk58uDDbV623BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA5A1348F;
 Fri, 18 Sep 2026 21:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id adOmI4qzrWqHVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 21:56:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/10] system: add a watchdog for the Big QEMU Lock
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
Date: Fri, 18 Sep 2026 18:56:16 -0300
Message-ID: <87mrterzpb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 qualcomm.com:email]
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

"Denis V. Lunev" <den@openvz.org> writes:

> A vCPU thread reacquires the BQL on every exit that needs userspace. A
> holder that keeps it for tens of seconds stops every vCPU, the guest
> reports a soft lockup or panics, and qemu itself records nothing. The
> guest log is the only evidence, and it cannot say whether the hypervisor
> held the lock or the guest wedged on its own.
>
> This series adds a BQL watchdog. A sampler thread watches a sequence
> counter that bql_update_status() advances on every acquire and release.
> One odd value across the whole window means one owner held the lock for
> the whole window. On expiry the watchdog names the holder and prints the
> state of every other thread:
>
>   qemu-system-x86_64: 2026-09-15T15:53:57Z BQL held for more than 100 ms =
by thread 168146
>     168146  qemu-system-x86  S
>         pc 0x785a4dbcb884 liburing.so.2+0x2884
>         wchan io_cqring_wait
>     168147  call_rcu         S
>         pc 0x785a4d534acb syscall+0x1b
>         wchan futex_do_wait
>     168148  IO mon_iothread  S
>         pc 0x785a4d4ac802 libc.so.6+0xac802
>         wchan poll_schedule_timeout.constprop.0
>
> With CAP_SYS_ADMIN the wchan line becomes the kernel stack. The pc line
> comes from signalling each thread and reading the program counter out of
> its signal frame, which is what tells a thread spinning in userspace
> from one asleep in a syscall.
>
> The watchdog is off by default and stays quiet under a debugger. Two
> machine properties drive it: bql-watchdog-ms sets the deadline, on the
> command line or over qom-set at any time, and bql-watchdog-abort turns
> the report into a core dump for hosts where the answer is worth more
> than the guest.
>
> Patches 1 to 6 are the pieces: a fix for bql_locked across the timed
> condvar wait, a debugger check, the per-thread state reader and its
> kernel stack and program counter extensions, and the signal reserved for
> the latter. Patches 7 to 9 are the watchdog itself. Patch 10 is a
> functional test that holds the BQL through an HMP qemu-io write to a
> null-co node with a latency longer than the deadline.
>
> The program counter lives at a host specific offset in the signal frame,
> so patch 6 reads it through a host/include header. The Linux headers for
> aarch64, ppc64, riscv64, s390x and loongarch64 repeat what linux-user's
> host-signal.h already knows about those frames, but only the x86_64 one
> has been compiled here, and the Windows half of patch 1 has not been
> compiled either.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
>
> Denis V. Lunev (10):
>   util/qemu-thread: track bql_locked across the timed condvar wait
>   oslib: add qemu_debugger_attached()
>   oslib: add qemu_thread_states()
>   oslib: report kernel stacks in qemu_thread_states()
>   util/qemu-thread: reserve a signal for thread introspection
>   oslib: report each thread's program counter
>   system/cpus: report a BQL held past a deadline
>   system/cpus: hold off the BQL watchdog under a debugger
>   system/cpus: add bql-watchdog-abort
>   tests/functional: cover the BQL watchdog
>
>  host/include/aarch64/host/signal-pc.h         |  20 ++
>  host/include/generic/host/signal-pc.h         |  11 +
>  host/include/loongarch64/host/signal-pc.h     |  20 ++
>  host/include/ppc64/host/signal-pc.h           |  22 ++
>  host/include/riscv64/host/signal-pc.h         |  20 ++
>  host/include/s390x/host/signal-pc.h           |  20 ++
>  host/include/x86_64/host/signal-pc.h          |  20 ++
>  hw/core/machine.c                             |  44 +++
>  include/qemu/osdep.h                          |  29 ++
>  include/system/cpus.h                         |   8 +
>  meson.build                                   |   2 +
>  qemu-options.hx                               |  11 +
>  system/cpus.c                                 | 143 ++++++++
>  tests/functional/generic/meson.build          |   1 +
>  tests/functional/generic/test_bql_watchdog.py |  60 ++++
>  util/oslib-posix.c                            | 316 ++++++++++++++++++
>  util/oslib-win32.c                            |  10 +
>  util/qemu-thread-posix.c                      |   8 +-
>  util/qemu-thread-win32.c                      |   4 +-
>  19 files changed, 765 insertions(+), 4 deletions(-)
>  create mode 100644 host/include/aarch64/host/signal-pc.h
>  create mode 100644 host/include/generic/host/signal-pc.h
>  create mode 100644 host/include/loongarch64/host/signal-pc.h
>  create mode 100644 host/include/ppc64/host/signal-pc.h
>  create mode 100644 host/include/riscv64/host/signal-pc.h
>  create mode 100644 host/include/s390x/host/signal-pc.h
>  create mode 100644 host/include/x86_64/host/signal-pc.h
>  create mode 100755 tests/functional/generic/test_bql_watchdog.py

The problem you state is definitely a pervasive one and I've encountered
it many times. It's a pain do debug. I'm working (on and off, you know
how it goes) on a perf improvement for dirty logging disabling, which is
basically this issue after migrate_cancel. I've been writing custom code
to track the blocking windows, so this series looks like it could help a
lot.

I'm putting it on my queue to review, I'll make some time for it soon.

One other thing I have in flight is a change to qtests to allow testing
a linux guest while a worker thread does some BQL intensive work in
parallel such as serial IO. I'm currently checking the guest serial
console for panics and lockups, but the watchdog would report the issue
right at the source.

