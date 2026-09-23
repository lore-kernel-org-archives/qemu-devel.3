Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4823AC9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mfe-0005zo-MG; Wed, 23 Sep 2026 09:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9MfQ-0005yy-Sa
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:05:46 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9MfN-0005le-3c
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:05:44 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 303EC21B0F;
 Wed, 23 Sep 2026 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790168733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+O15SXI4V8AbygwSjXTNDmq7kvRn4gtEmkHVLbM0oXU=;
 b=FQRHvWgjXXWutuJltFv1fGRagzMos4cRb+HOjsqUZXyBe0bUTKspYbTPUbKzmC/VjCfSfN
 vxlqiY2CuPSr8UEhk3E7VcEGltfdFxDsPfP0Pt2fCQgkvmGjYNCD0Az7T9+HQlKWTXjvA0
 zDrlc3+7m97VQDirCX7Oz4GI4S+j2rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790168733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+O15SXI4V8AbygwSjXTNDmq7kvRn4gtEmkHVLbM0oXU=;
 b=K9W23yGnesPPcV74fZNs6J/4e/gWYqSxvLQuIp7Dwi0cY2jJHscI4/0GNtHFf7DAaBbQe2
 1PcaCcqZeMdLakCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790168729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+O15SXI4V8AbygwSjXTNDmq7kvRn4gtEmkHVLbM0oXU=;
 b=VxEi8VxkfeHYkG40xg1wBIwWvVeYpw1YGWCaKfXrTFFh3lmglOWmE7dqMXU9bNYkIMTwSh
 3e1SE2FSsmatB1t5tzLyZUegwzhnHoTjvVGiWS6pJUSS6lrolWFrSwDtjH5eAxtGMXzGxM
 50e7kfeDWmb8iFhHxKRw6qXmnMsJEzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790168729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+O15SXI4V8AbygwSjXTNDmq7kvRn4gtEmkHVLbM0oXU=;
 b=H1ZjdhQraPeboKdSziNnvkXmOY9PYJHM2Y9aUmfaeHh8Q1RqBT/3NZ5ejK3u3XJ8AlgpxR
 mHJStrWUnrHfCoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D5213A6B;
 Wed, 23 Sep 2026 13:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cQhuEpjOs2oXDQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Sep 2026 13:05:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Shivang Upadhyay <shivangu@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Doru =?utf-8?Q?Bl=C3=A2nzeanu?=
 <dblanzeanu@linux.microsoft.com>, Magnus Kulke
 <magnuskulke@linux.microsoft.com>
Subject: Re: [PATCH] accel: Fix qtest deadlock during unplug
In-Reply-To: <20260918140037.3082357-1-farosas@suse.de>
References: <20260918140037.3082357-1-farosas@suse.de>
Date: Wed, 23 Sep 2026 10:05:22 -0300
Message-ID: <87ld8s9kz1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[gitlab.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Fabiano Rosas <farosas@suse.de> writes:

> This is a revert of one hunk of commit d5e33b5f8f ("accel: make all
> calls to qemu_process_cpu_events look the same"). It regressed
> device-plug-test on ppc64. Run this in a loop and it deadlocks before
> 50 iterations:
>
> QTEST_QEMU_BINARY=./qemu-system-ppc64 ./tests/qtest/device-plug-test -p
> /ppc64/device-plug/spapr-cpu-unplug-request
>
> The deadlocked stacks are:
> T0:
>  #0  in sigtimedwait
>  #1  in sigwait
>  #2  in dummy_cpu_thread_fn (arg=0x558ed4db8eb0) at ../accel/dummy-cpus.c:52
>
> T1:
>  #2  in qemu_thread_join (thread=0x55e3803dfc60) at ../util/qemu-thread-posix.c:554
>  #3  in cpu_remove_sync (cpu=0x558ed4db8eb0) at ../system/cpus.c:633
>  #4  in ppc_cpu_unrealize (dev=0x558ed4db8eb0) at ../target/ppc/cpu_init.c:6967
>
> What the test does is to queue a cpu unplug request to be executed
> during system reset. So we end up with two cpu_exit() calls affecting
> the dummy loop, one via pause_all_cpus() and another via
> cpu_remove_sync().
>
> Moving qemu_process_cpu_events() to the top of the loop has made the
> release of the halt_cond + the read of cpu->unplug not happen
> atomically regarding the BQL anymore.
>
> One cpu_exit() call will cause qemu_process_cpu_events() to make
> progress, the BQL be release and the pending SIG_IPI to be consumed by
> sigwait(). But since the BQL is unlocked, the second qemu_cpu_kick()
> invocation can execute entirely while the BQL is unlocked and issue:
>
> i) another broadcast on halt_cond, which will be queued and,
> ii) another signal, which will be discarded
>
> After the sigwait() returns and qemu_process_cpu_events() executes
> again in the next loop iteration, it exits right away due to the cond
> already being posted, but the sigwait() call for that loop won't see
> any signal. The thread cannot be joined at this point so there's a
> deadlock.
>
> Since the dummy_cpu loop is so simple, I think the best way to fix
> this is to revert that part of the change and move
> qemu_process_cpu_events() back to the end of the loop, where it will
> be within the same BQL locking window as the cpu->unplug check.
>
> Fixes: d5e33b5f8f ("accel: make all calls to qemu_process_cpu_events look the same")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2861429046
> ---
>  accel/dummy-cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
> index 5752f6302c..225a47c31f 100644
> --- a/accel/dummy-cpus.c
> +++ b/accel/dummy-cpus.c
> @@ -43,7 +43,6 @@ static void *dummy_cpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
> -        qemu_process_cpu_events(cpu);
>          bql_unlock();
>  #ifndef _WIN32
>          do {
> @@ -58,6 +57,7 @@ static void *dummy_cpu_thread_fn(void *arg)
>          qemu_sem_wait(&cpu->sem);
>  #endif
>          bql_lock();
> +        qemu_process_cpu_events(cpu);
>      } while (!cpu->unplug);
>  
>      bql_unlock();

+ppc and mshv folks

@Chinmay, just to make you aware that there's a broken test for ppc

@Shivang, we're discussing about cpu_remove_sync() down in this thread,
maybe that's of interest to you. Philippe is suggesting we could maybe
move the call up a layer.

@Doru, Magnus, for your awareness. This bug is about the dummy
cpu thread that qtest and xen use, but the pattern of coming out of
qemu_process_cpu_events() and unlocking the BQL is present in mshv as
well.

