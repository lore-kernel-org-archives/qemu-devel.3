Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD95E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZTR-00014i-0R; Tue, 17 Dec 2024 10:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNZTK-00013x-JS; Tue, 17 Dec 2024 10:26:55 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNZTF-00059S-91; Tue, 17 Dec 2024 10:26:54 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4775321157;
 Tue, 17 Dec 2024 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734449207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AKRNRuFju2hq/ZYAhw2F1m7cfBcgkqHN6/9anGtjvOA=;
 b=WEGAK8uPNYPzT0Y3KdTEoqvbVreIqZyV7q1rbFVA97Z2j3qOUYby1shZAIoEkYJxc/00rY
 aILWbVNqarRHJVtOyXMqG6pr27OQ0ygvjrZSFgIFUVIk4cJbsFQyCbNMS5/iPeSqf3IUUp
 jtMBs2Xx7/WWFWA6/+k2SKd1LKf5CDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734449207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AKRNRuFju2hq/ZYAhw2F1m7cfBcgkqHN6/9anGtjvOA=;
 b=kZ0trdVx1vEV9bumJ+SeG8JRK+69Lxc/hmCm87MMum+wcvLp/tHTep2SLIee5Z4pWa+egE
 MT2V09deH8l6YpDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734449207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AKRNRuFju2hq/ZYAhw2F1m7cfBcgkqHN6/9anGtjvOA=;
 b=WEGAK8uPNYPzT0Y3KdTEoqvbVreIqZyV7q1rbFVA97Z2j3qOUYby1shZAIoEkYJxc/00rY
 aILWbVNqarRHJVtOyXMqG6pr27OQ0ygvjrZSFgIFUVIk4cJbsFQyCbNMS5/iPeSqf3IUUp
 jtMBs2Xx7/WWFWA6/+k2SKd1LKf5CDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734449207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AKRNRuFju2hq/ZYAhw2F1m7cfBcgkqHN6/9anGtjvOA=;
 b=kZ0trdVx1vEV9bumJ+SeG8JRK+69Lxc/hmCm87MMum+wcvLp/tHTep2SLIee5Z4pWa+egE
 MT2V09deH8l6YpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C399C132EA;
 Tue, 17 Dec 2024 15:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pHkQIjaYYWcCJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 15:26:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Andrey
 Drobyshev <andrey.drobyshev@virtuozzo.com>, Eric Blake
 <eblake@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin
 Wolf <kwolf@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 0/6] migration/block: disk activation rewrite
In-Reply-To: <20241206230838.1111496-1-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
Date: Tue, 17 Dec 2024 12:26:44 -0300
Message-ID: <87h672wcsr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> CI: https://gitlab.com/peterx/qemu/-/pipelines/1577280033
>  (note: it's a pipeline of two patchsets, to save CI credits and time)
>
> v1: https://lore.kernel.org/r/20241204005138.702289-1-peterx@redhat.com
>
> This is v2 of the series, removing RFC tag, because my goal is to have them
> (or some newer version) merged.
>
> The major change is I merged last three patches, and did quite some changes
> here and there, to make sure the global disk activation status is always
> consistent.  The whole idea is still the same.  I say changelog won't help.
>
> I also temporarily dropped Fabiano's ping-pong test cases to avoid
> different versions floating on the list (as I know a new version is coming
> at some point. Fabiano: you're taking over the 10.0 pulls, so I assume
> you're aware so there's no concern on order of merges).  I'll review the
> test cases separately when they're ready, but this series is still tested
> with that pingpong test and it keeps working.
>
> I started looking at this problem as a whole when reviewing Fabiano's
> series, especially the patch (for a QEMU crash [1]):
>
> https://lore.kernel.org/r/20241125144612.16194-5-farosas@suse.de
>
> The proposed patch could work, but it's unwanted to add such side effect to
> migration.  So I start to think about whether we can provide a cleaner
> approach, because migration doesn't need the disks to be active to work at
> all.  Hence we should try to avoid adding a migration ABI (which doesn't
> matter now, but may matter some day) into prepare phase on disk activation
> status.  Migration should happen with disks inactivated.
>
> It's also a pure wish that, if bdrv_inactivate_all() could be benign to be
> called even if all disks are already inactive.  Then the bug is also gone.
> After all, similar call on bdrv_activate_all() upon all-active disks is all
> fine.  I hope that wish could still be fair.  But I don't know well on
> block layer to say anything meaningful.
>
> And when I was looking at that, I found more things spread all over the
> place on disk activation.  I decided to clean all of them up, while
> hopefully fixing the QEMU crash [1] too.
>
> For this v2, I did some more tests, I want to make sure all the past paths
> keep working at least on failure or cancel races, also in postcopy failure
> cases.  So I did below and they all run pass (when I said "emulated" below,
> I meant I hacked something to trigger those race / rare failures, because
> they aren't easy to trigger with vanilla binary):
>
> - Tested generic migrate_cancel during precopy, disk activation won't be
>   affected.  Disk status reports correct values in tracepoints.
>
> - Test Fabiano's ping-pong migration tests on PAUSED state VM.
>
> - Emulated precopy failure before sending non-iterable, disk inactivation
>   won't happen, and also activation won't trigger after migration cleanups
>   (even if activation on top of activate disk is benign, I checked traces
>   to make sure it'll provide consistent disk status, skipping activation).
>
> - Emulated precopy failure right after sending non-iterable. Disks will be
>   inactivated, but then can be reactivated properly before VM starts.
>
> - Emulated postcopy failure when sending the packed data (which is after
>   disk invalidated), and making sure src VM will get back to live properly,
>   re-activate the disks before starting.
>
> - Emulated concurrent migrate_cancel at the end of migration_completion()
>   of precopy, after disk inactivated.  Disks can be reactivated properly.
>
>   NOTE: here if dest QEMU didn't quit before migrate_cancel,
>   bdrv_activate_all() can crash src QEMU.  This behavior should be the same
>   before/after this patch.
>
> Comments welcomed, thanks.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2395
>
> Peter Xu (6):
>   migration: Add helper to get target runstate
>   qmp/cont: Only activate disks if migration completed
>   migration/block: Make late-block-active the default
>   migration/block: Apply late-block-active behavior to postcopy
>   migration/block: Fix possible race with block_inactive
>   migration/block: Rewrite disk activation
>
>  include/migration/misc.h |   4 ++
>  migration/migration.h    |   6 +-
>  migration/block-active.c |  94 +++++++++++++++++++++++++++
>  migration/colo.c         |   2 +-
>  migration/migration.c    | 136 +++++++++++++++------------------------
>  migration/savevm.c       |  46 ++++++-------
>  monitor/qmp-cmds.c       |  22 +++----
>  migration/meson.build    |   1 +
>  migration/trace-events   |   3 +
>  9 files changed, 188 insertions(+), 126 deletions(-)
>  create mode 100644 migration/block-active.c

Queued, thanks!

