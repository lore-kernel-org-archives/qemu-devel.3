Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB78DF364CD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxdn-0004NK-If; Thu, 09 Apr 2026 18:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wAxdl-0004N0-Uz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:14:22 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wAxdk-0002Gf-5M
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:14:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 532CD6A7CF;
 Thu,  9 Apr 2026 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775772858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7j4UjjEo9IqtLM1/EXu0CYuyLZlGrCapR+WK40xCRBM=;
 b=PdMP5iUOkEhuREtQ0iL526s1Q3lWkNSNx0m1slWSxVFIJyPR+hCDPf1utDUyLNzYS4fO/y
 6ZyG/GrAVdbRSoTIAFqvfRz1AS4IQ15Ou886WS+01VQjXidNfptRe+zYqQKbki1eR8ebd4
 vk8diV1qklnN/PkF0TykfRrNIiAyEGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775772858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7j4UjjEo9IqtLM1/EXu0CYuyLZlGrCapR+WK40xCRBM=;
 b=lDkdHtVzKNHkaCVD24CphGeF91Z0GIJtE2L5NdhTk+dqn1Cswigv2oHTKabb2np0jWVJeM
 T/hT6w30VikuWxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775772858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7j4UjjEo9IqtLM1/EXu0CYuyLZlGrCapR+WK40xCRBM=;
 b=PdMP5iUOkEhuREtQ0iL526s1Q3lWkNSNx0m1slWSxVFIJyPR+hCDPf1utDUyLNzYS4fO/y
 6ZyG/GrAVdbRSoTIAFqvfRz1AS4IQ15Ou886WS+01VQjXidNfptRe+zYqQKbki1eR8ebd4
 vk8diV1qklnN/PkF0TykfRrNIiAyEGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775772858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7j4UjjEo9IqtLM1/EXu0CYuyLZlGrCapR+WK40xCRBM=;
 b=lDkdHtVzKNHkaCVD24CphGeF91Z0GIJtE2L5NdhTk+dqn1Cswigv2oHTKabb2np0jWVJeM
 T/hT6w30VikuWxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC7804A0B3;
 Thu,  9 Apr 2026 22:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9/qwJbkk2GnFOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Apr 2026 22:14:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Zhiyi Guo
 <zhguo@redhat.com>, Juraj
 Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Joao Martins
 <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>, Alex
 Williamson <alex@shazbot.org>, Hyman Huang <yong.huang@smartx.com>, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 09/14] migration: Move iteration counter out of RAM
In-Reply-To: <20260408165559.157108-10-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-10-peterx@redhat.com>
Date: Thu, 09 Apr 2026 19:14:15 -0300
Message-ID: <8734136atk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> It used to hide in RAM dirty sync path.  Now with more modules being able
> to slow sync on dirty information, keeping it there may not be good anymore
> because it's not RAM's own concept for iterations: all modules should
> follow.
>
> More importantly, mgmt may try to query dirty info (to make policy
> decisions like adjusting downtime) by listening to iteration count changes
> via QMP events.  So we must make sure the boost of iterations only happens
> _after_ the dirty sync operations with whatever form (RAM's dirty bitmap
> sync, or VFIO's different ioctls to fetch latest dirty info from kernel).
>
> Move this to core migration path to manage, together with the event
> generation, so that it can be well ordered with the sync operations for all
> modules.
>
> This brings a good side effect that we should have an old issue regarding
> to cpu_throttle_dirty_sync_timer_tick() which can randomly boost iteration
> counts (because it invokes sync ops).  Now it won't, which is actually the
> right behavior.
>

Good.

> Said that, we have code (not only QEMU, but likely mgmt too) assuming the
> 1st iteration will always shows dirty count to 1.  Make it initialized with
> 1 this time, because we'll miss the dirty sync for setup() on boosting this
> counter now.
>
> Reviewed-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-stats.h |  3 ++-
>  migration/migration.c       | 29 ++++++++++++++++++++++++++---
>  migration/ram.c             |  6 ------
>  3 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 1153520f7a..326ddb0088 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -43,7 +43,8 @@ typedef struct {
>       */
>      uint64_t dirty_pages_rate;
>      /*
> -     * Number of times we have synchronized guest bitmaps.
> +     * Number of times we have synchronized guest bitmaps.  This always
> +     * starts from 1 for the 1st iteration.
>       */
>      uint64_t dirty_sync_count;
>      /*
> diff --git a/migration/migration.c b/migration/migration.c
> index a9ee3360e1..57d91ad9e3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1654,10 +1654,15 @@ int migrate_init(MigrationState *s, Error **errp)
>      s->threshold_size = 0;
>      s->switchover_acked = false;
>      s->rdma_migration = false;
> +
>      /*
> -     * set mig_stats memory to zero for a new migration
> +     * set mig_stats memory to zero for a new migration.. except the
> +     * iteration counter, which we want to make sure it returns 1 for the
> +     * first iteration.
>       */
>      memset(&mig_stats, 0, sizeof(mig_stats));
> +    mig_stats.dirty_sync_count = 1;
> +
>      migration_reset_vfio_bytes_transferred();
>  
>      s->postcopy_package_loaded = false;
> @@ -3230,10 +3235,28 @@ static bool migration_iteration_next_ready(MigrationState *s,
>  static void migration_iteration_go_next(MigPendingData *pending)
>  {
>      /*
> -     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> -     * into the core layer.
> +     * Do a slow sync first before boosting the iteration count.
>       */
>      qemu_savevm_query_pending(pending, true);
> +
> +    /*
> +     * Boost dirty sync count to reflect we finished one iteration.
> +     *
> +     * NOTE: we need to make sure when this happens (together with the
> +     * event sent below) all modules have slow-synced the pending data
> +     * above.  That means a write mem barrier, but qatomic_add() should be
> +     * enough.
> +     *
> +     * It's because a mgmt could wait on the iteration event to query again
> +     * on pending data for policy changes (e.g. downtime adjustments).  The
> +     * ordering will make sure the query will fetch the latest results from
> +     * all the modules.
> +     */
> +    qatomic_add(&mig_stats.dirty_sync_count, 1);
> +
> +    if (migrate_events()) {
> +        qapi_event_send_migration_pass(mig_stats.dirty_sync_count);
> +    }
>  }
>  
>  /*
> diff --git a/migration/ram.c b/migration/ram.c
> index e5b7217bf5..686162643d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1136,8 +1136,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
>      RAMBlock *block;
>      int64_t end_time;
>  
> -    qatomic_add(&mig_stats.dirty_sync_count, 1);
> -
>      if (!rs->time_last_bitmap_sync) {
>          rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);

Tangent: aren't these updates to time_last_bitmap_sync racy with the
sync from the throttle code?

>      }
> @@ -1172,10 +1170,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
>          rs->num_dirty_pages_period = 0;
>          rs->bytes_xfer_prev = migration_transferred_bytes();
>      }
> -    if (migrate_events()) {
> -        uint64_t generation = qatomic_read(&mig_stats.dirty_sync_count);
> -        qapi_event_send_migration_pass(generation);
> -    }
>  }
>  
>  void migration_bitmap_sync_precopy(bool last_stage)

