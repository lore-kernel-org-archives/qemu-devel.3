Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A193C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Z97-0001rx-82; Fri, 18 Sep 2026 10:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7Z95-0001r8-3o
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:00:55 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7Z93-0005Ss-3W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:00:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6DE4521BDC;
 Fri, 18 Sep 2026 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789740045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8QyPloTWcVw3s4xV118IIMjWQL4aQRwrpQY+gOcLL7o=;
 b=LhidxqST4qVhMj8aQLdBLaPQDEVY3ugJOWnl610Hsx4csOjWqeehlPe8FEvS/ZD0rLmRCU
 +4wBb3mrSZ2VHJB9Qn4U+jpmOucIagUoghJAg1Fh/I3wEOUsugB8j/n4e0owzVDeHxYyds
 CzqmSIfdGBqteYxSwjBp2cE0lCjFrWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789740045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8QyPloTWcVw3s4xV118IIMjWQL4aQRwrpQY+gOcLL7o=;
 b=5bysM5DTaQL+BFvoovFkSu/MoZpTMXBnwNjJKQsbue5kusYvyqA+jrhQ2uPPR0pcHv4KW4
 RFVYk4YojV8YlFDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mhbdqnkO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="uIl/dfEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789740041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8QyPloTWcVw3s4xV118IIMjWQL4aQRwrpQY+gOcLL7o=;
 b=mhbdqnkOTrwyYeUrf7dyemYgdLAkrzmqh+ihpBNezBCXWT+5BL+05HD6gLUYmU/m06IO4m
 aItJw08i0n6rFyC9iBUWiwONseCCRMsVH7ssM+sGZ3N3z7CCKIXBmwKglbWRXrNN2XrnwQ
 WhdxAr0lII4Mg2NES1Q+eKgEMqcl/1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789740041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8QyPloTWcVw3s4xV118IIMjWQL4aQRwrpQY+gOcLL7o=;
 b=uIl/dfEWKGtZC9zzk3gpI/I4iosma75iNnWyhzzi1BV1mn80ibbBnRQSRyJ1sql7arzx0m
 RXNurv2Bbl8aokBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34B7F1348F;
 Fri, 18 Sep 2026 14:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bn1KMgdErWqLXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 14:00:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] accel: Fix qtest deadlock during unplug
Date: Fri, 18 Sep 2026 11:00:37 -0300
Message-ID: <20260918140037.3082357-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6DE4521BDC
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

This is a revert of one hunk of commit d5e33b5f8f ("accel: make all
calls to qemu_process_cpu_events look the same"). It regressed
device-plug-test on ppc64. Run this in a loop and it deadlocks before
50 iterations:

QTEST_QEMU_BINARY=./qemu-system-ppc64 ./tests/qtest/device-plug-test -p
/ppc64/device-plug/spapr-cpu-unplug-request

The deadlocked stacks are:
T0:
 #0  in sigtimedwait
 #1  in sigwait
 #2  in dummy_cpu_thread_fn (arg=0x558ed4db8eb0) at ../accel/dummy-cpus.c:52

T1:
 #2  in qemu_thread_join (thread=0x55e3803dfc60) at ../util/qemu-thread-posix.c:554
 #3  in cpu_remove_sync (cpu=0x558ed4db8eb0) at ../system/cpus.c:633
 #4  in ppc_cpu_unrealize (dev=0x558ed4db8eb0) at ../target/ppc/cpu_init.c:6967

What the test does is to queue a cpu unplug request to be executed
during system reset. So we end up with two cpu_exit() calls affecting
the dummy loop, one via pause_all_cpus() and another via
cpu_remove_sync().

Moving qemu_process_cpu_events() to the top of the loop has made the
release of the halt_cond + the read of cpu->unplug not happen
atomically regarding the BQL anymore.

One cpu_exit() call will cause qemu_process_cpu_events() to make
progress, the BQL be release and the pending SIG_IPI to be consumed by
sigwait(). But since the BQL is unlocked, the second qemu_cpu_kick()
invocation can execute entirely while the BQL is unlocked and issue:

i) another broadcast on halt_cond, which will be queued and,
ii) another signal, which will be discarded

After the sigwait() returns and qemu_process_cpu_events() executes
again in the next loop iteration, it exits right away due to the cond
already being posted, but the sigwait() call for that loop won't see
any signal. The thread cannot be joined at this point so there's a
deadlock.

Since the dummy_cpu loop is so simple, I think the best way to fix
this is to revert that part of the change and move
qemu_process_cpu_events() back to the end of the loop, where it will
be within the same BQL locking window as the cpu->unplug check.

Fixes: d5e33b5f8f ("accel: make all calls to qemu_process_cpu_events look the same")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
CI run: https://gitlab.com/farosas/qemu/-/pipelines/2861429046
---
 accel/dummy-cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 5752f6302c..225a47c31f 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -43,7 +43,6 @@ static void *dummy_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
-        qemu_process_cpu_events(cpu);
         bql_unlock();
 #ifndef _WIN32
         do {
@@ -58,6 +57,7 @@ static void *dummy_cpu_thread_fn(void *arg)
         qemu_sem_wait(&cpu->sem);
 #endif
         bql_lock();
+        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug);
 
     bql_unlock();
-- 
2.53.0


