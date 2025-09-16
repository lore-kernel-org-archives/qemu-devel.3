Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A482BCAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 21:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uydIZ-0006No-7s; Tue, 16 Sep 2025 17:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uydIU-0006Mp-Or
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 17:33:13 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uydIR-0003Zz-0f
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 17:33:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67EA91F387;
 Tue, 16 Sep 2025 21:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758058383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfsjTD3LBh9pPwJNrfZwYxlkI6WpqMlWHdwN83X7nQo=;
 b=fu6+rdWVJpXaBHktt+KDY2GKSgknfSb+oYM29qra+LfmQZtd0l3mQK7yrbfE2VegePaLZg
 hCPAN9AYqVYxDcC5QdKBfBnHPASd6Ao7Tsj6GTPoWoozpV6gEDCYbANrllqxdRr7kKFi9/
 TA+jrtMEUEcrLU5QgcP0tSTs2bgpjhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758058383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfsjTD3LBh9pPwJNrfZwYxlkI6WpqMlWHdwN83X7nQo=;
 b=PtSJ1XBl2/9q6wS7OPliZg4ZMwEONjF8KYc90M68wsiqphU8VhN/Rm2dzrSrDRnBDjbX0p
 bI2GhpGxl5+/toDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fu6+rdWV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PtSJ1XBl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758058383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfsjTD3LBh9pPwJNrfZwYxlkI6WpqMlWHdwN83X7nQo=;
 b=fu6+rdWVJpXaBHktt+KDY2GKSgknfSb+oYM29qra+LfmQZtd0l3mQK7yrbfE2VegePaLZg
 hCPAN9AYqVYxDcC5QdKBfBnHPASd6Ao7Tsj6GTPoWoozpV6gEDCYbANrllqxdRr7kKFi9/
 TA+jrtMEUEcrLU5QgcP0tSTs2bgpjhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758058383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfsjTD3LBh9pPwJNrfZwYxlkI6WpqMlWHdwN83X7nQo=;
 b=PtSJ1XBl2/9q6wS7OPliZg4ZMwEONjF8KYc90M68wsiqphU8VhN/Rm2dzrSrDRnBDjbX0p
 bI2GhpGxl5+/toDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B848F139CB;
 Tue, 16 Sep 2025 21:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f6R1HY7XyWgLTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Sep 2025 21:33:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
Date: Tue, 16 Sep 2025 18:32:59 -0300
Message-ID: <87zfau13sk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 67EA91F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[14]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
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

Peter Xu <peterx@redhat.com> writes:

> [this is an early RFC, not for merge, but to collect initial feedbacks]
>
> Background
> ==========
>
> Nowadays, live migration heavily depends on threads. For example, most of
> the major features that will be used nowadays in live migration (multifd,
> postcopy, mapped-ram, vfio, etc.) all work with threads internally.
>
> But still, from time to time, we'll see some coroutines floating around the
> migration context.  The major one is precopy's loadvm, which is internally
> a coroutine.  It is still a critical path that any live migration depends on.
>

I always wanted to be an archaeologist:

https://lists.gnu.org/archive/html/qemu-devel//2012-08/msg01136.html

I was expecting to find some complicated chain of events leading to the
choice of using a coroutine, but no.

> A mixture of using both coroutines and threads is prone to issues.  Some
> examples can refer to commit e65cec5e5d ("migration/ram: Yield periodically
> to the main loop") or commit 7afbdada7e ("migration/postcopy: ensure
> preempt channel is ready before loading states").
>
> Overview
> ========
>
> This series tries to move migration further into the thread-based model, by
> allowing the loadvm process to happen in a thread rather than in the main
> thread with a coroutine.
>
> Luckily, since the qio channel code is always ready for both cases, IO
> paths should all be fine.
>
> Note that loadvm for postcopy already happens in a ram load thread which is
> separate.  However, RAM is just the simple case here, even it has its own
> challenges (on atomically update of the pgtables), its complexity lies in
> the kernel.
>
> For precopy, loadvm has quite a few operations that will need BQL.  The
> question is we can't take BQL for the whole process of loadvm, because
> that'll block the main thread from executions (e.g. QMP hangs).  Here, the
> finer granule we can push BQL the better.  This series so far chose
> somewhere in the middle, by taking BQL on majorly these two places:
>
>   - CPU synchronizations
>   - Device START/FULL sections
>
> After this series applied, most of the rest loadvm path will run without
> BQL anymore.  There is a more detailed discussion / todo in the commit
> message of patch "migration: Thread-ify precopy vmstate load process"
> explaning how to further split the BQL critical sections.
>
> I was trying to split the patches into smaller ones if possible, but it's
> still quite challenging so there's one major patch that does the work.
>
> After the series applied, the only leftover pieces in migration/ that would
> use a coroutine is snapshot save/load/delete jobs.
>

Which are then fine because the work itself runs on the main loop,
right? So the bottom-half scheduling could be left as a coroutine.

> Tests
> =====
>
> Default CI passes.
>
> RDMA unit tests pass as usual. I also tried out cancellation / failure
> tests over RDMA channels, making sure nothing is stuck.
>
> I also roughly measured how long it takes to run the whole 80+ migration
> qtest suite, and see no measurable difference before / after this series.
>
> Risks
> =====
>
> This series has the risk of breaking things.  I would be surprised if it
> didn't..
>
> I confess I didn't test anything on COLO but only from code observations
> and analysis.  COLO maintainers: could you add some unit tests to QEMU's
> qtests?
>
> The current way of taking BQL during FULL section load may cause issues, it
> means when the IOs are unstable we could be waiting for IO (in the new
> migration incoming thread) with BQL held.  This is low possibility, though,
> only happens when the network halts during flushing the device states.
> However still possible.  One solution is to further breakdown the BQL
> critical sections to smaller sections, as mentioned in TODO.
>
> Anything more than welcomed: suggestions, questions, objections, tests..
>
> Todo
> ====
>
> - Test COLO?
> - Finer grained BQL breakdown
> - More..
>
> Thanks,
>
> Peter Xu (9):
>   migration/vfio: Remove BQL implication in
>     vfio_multifd_switchover_start()
>   migration/rdma: Fix wrong context in qio_channel_rdma_shutdown()
>   migration/rdma: Allow qemu_rdma_wait_comp_channel work with thread
>   migration/rdma: Change io_create_watch() to return immediately
>   migration: Thread-ify precopy vmstate load process
>   migration/rdma: Remove coroutine path in qemu_rdma_wait_comp_channel
>   migration/postcopy: Remove workaround on wait preempt channel
>   migration/ram: Remove workaround on ram yield during load
>   migration/rdma: Remove rdma_cm_poll_handler
>
>  include/migration/colo.h    |   6 +-
>  migration/migration.h       |  52 +++++++--
>  migration/savevm.h          |   5 +-
>  hw/vfio/migration-multifd.c |   9 +-
>  migration/channel.c         |   7 +-
>  migration/colo-stubs.c      |   2 +-
>  migration/colo.c            |  23 +---
>  migration/migration.c       |  62 ++++++++---
>  migration/ram.c             |  13 +--
>  migration/rdma.c            | 206 ++++++++----------------------------
>  migration/savevm.c          |  85 +++++++--------
>  migration/trace-events      |   4 +-
>  12 files changed, 196 insertions(+), 278 deletions(-)

