Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF7DC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 20:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqIRw-0000lK-0h; Mon, 16 Sep 2024 16:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqIRr-0000ho-3H
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 16:35:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqIRl-00082G-MM
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 16:35:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E4251FD79;
 Mon, 16 Sep 2024 20:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726518936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaiY61qJTf/2hbn0H/uYY44QQIcNEwUnPR1gpUjmp8Y=;
 b=C5QR4zWOuzFRo3ygSIRMUBRw3aj7Rp155ys0L66i6lhP/yshQVa3ateYI3re42PT58mSfS
 rBSrE/fUMDzfjh1qQ+lBZzE0Wx6rrOqIKjELns5+ekHt3U677iDGU31dav92BRrr9k41Uz
 44eaOww3ZdzU9TKgw4zXyAQWTY0EXYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726518936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaiY61qJTf/2hbn0H/uYY44QQIcNEwUnPR1gpUjmp8Y=;
 b=CvTjsuwq2qEEJKrHVQ8pjaYbYPKplJNpxi6KWNGZDcrSzKiEyrJ0PiQBg5Irf/EJawrIWy
 iJ6lFSadk3bx3uCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C5QR4zWO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CvTjsuwq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726518936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaiY61qJTf/2hbn0H/uYY44QQIcNEwUnPR1gpUjmp8Y=;
 b=C5QR4zWOuzFRo3ygSIRMUBRw3aj7Rp155ys0L66i6lhP/yshQVa3ateYI3re42PT58mSfS
 rBSrE/fUMDzfjh1qQ+lBZzE0Wx6rrOqIKjELns5+ekHt3U677iDGU31dav92BRrr9k41Uz
 44eaOww3ZdzU9TKgw4zXyAQWTY0EXYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726518936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaiY61qJTf/2hbn0H/uYY44QQIcNEwUnPR1gpUjmp8Y=;
 b=CvTjsuwq2qEEJKrHVQ8pjaYbYPKplJNpxi6KWNGZDcrSzKiEyrJ0PiQBg5Irf/EJawrIWy
 iJ6lFSadk3bx3uCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F6013A3A;
 Mon, 16 Sep 2024 20:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hTl7FJeW6GbMHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Sep 2024 20:35:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH v1 3/7] qapi/migration: Introduce the iteration-count
In-Reply-To: <654bfad294e2cc3394f744bd8536e0448c0bf550.1726390099.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <654bfad294e2cc3394f744bd8536e0448c0bf550.1726390099.git.yong.huang@smartx.com>
Date: Mon, 16 Sep 2024 17:35:32 -0300
Message-ID: <87v7yvz697.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0E4251FD79
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Hyman Huang <yong.huang@smartx.com> writes:

> The original migration information dirty-sync-count could
> no longer reflect iteration count due to the introduction
> of background synchronization in the next commit;
> add the iteration count to compensate.

I agree with the overall idea, but I feel we're lacking some information
on what determines whether some of the lines below want to use the
iteration count vs. the dirty sync count. Since this patch increments
both variables at the same place, they can still be used interchangeably
unless we add some words to explain the distinction.

So to clarify: 

What do we call an iteration? A call to save_live_iterate(),
migration_iteration_run() or something else?

Why dirty-sync-count should ever have reflected "iteration count"? It
might have been this way by coincidence, but did we ever used it in that
sense (aside from info migrate maybe)?

With the new counter, what kind of meaning can a user extract from that
number aside from "some undescribed thing happened N times" (this might
be included in the migration.json docs)?

>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/migration-stats.h  |  4 ++++
>  migration/migration.c        |  1 +
>  migration/ram.c              | 12 ++++++++----
>  qapi/migration.json          |  6 +++++-
>  tests/qtest/migration-test.c |  2 +-
>  5 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 05290ade76..43ee0f4f05 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -50,6 +50,10 @@ typedef struct {
>       * Number of times we have synchronized guest bitmaps.
>       */
>      Stat64 dirty_sync_count;
> +    /*
> +     * Number of migration iteration processed.
> +     */
> +    Stat64 iteration_count;
>      /*
>       * Number of times zero copy failed to send any page using zero
>       * copy.
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d577..055d527ff6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1197,6 +1197,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->mbps = s->mbps;
>      info->ram->dirty_sync_count =
>          stat64_get(&mig_stats.dirty_sync_count);
> +    info->ram->iteration_count = stat64_get(&mig_stats.iteration_count);
>      info->ram->dirty_sync_missed_zero_copy =
>          stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
>      info->ram->postcopy_requests =
> diff --git a/migration/ram.c b/migration/ram.c
> index e205806a5f..ca5a1b5f16 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -594,7 +594,7 @@ static void xbzrle_cache_zero_page(ram_addr_t current_addr)
>      /* We don't care if this fails to allocate a new cache page
>       * as long as it updated an old one */
>      cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
> -                 stat64_get(&mig_stats.dirty_sync_count));
> +                 stat64_get(&mig_stats.iteration_count));
>  }
>  
>  #define ENCODING_FLAG_XBZRLE 0x1
> @@ -620,7 +620,7 @@ static int save_xbzrle_page(RAMState *rs, PageSearchStatus *pss,
>      int encoded_len = 0, bytes_xbzrle;
>      uint8_t *prev_cached_page;
>      QEMUFile *file = pss->pss_channel;
> -    uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
> +    uint64_t generation = stat64_get(&mig_stats.iteration_count);
>  
>      if (!cache_is_cached(XBZRLE.cache, current_addr, generation)) {
>          xbzrle_counters.cache_miss++;
> @@ -1079,6 +1079,10 @@ static void migration_bitmap_sync(RAMState *rs,
>      RAMBlock *block;
>      int64_t end_time;
>  
> +    if (!background) {
> +        stat64_add(&mig_stats.iteration_count, 1);
> +    }
> +
>      stat64_add(&mig_stats.dirty_sync_count, 1);
>  
>      if (!rs->time_last_bitmap_sync) {
> @@ -1115,8 +1119,8 @@ static void migration_bitmap_sync(RAMState *rs,
>          rs->num_dirty_pages_period = 0;
>          rs->bytes_xfer_prev = migration_transferred_bytes();
>      }
> -    if (migrate_events()) {
> -        uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
> +    if (!background && migrate_events()) {
> +        uint64_t generation = stat64_get(&mig_stats.iteration_count);
>          qapi_event_send_migration_pass(generation);
>      }
>  }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b66cccf107..95b490706c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -60,6 +60,9 @@
>  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>  #     7.1)
>  #
> +# @iteration-count: The number of iterations since migration started.
> +#     (since 9.2)
> +#
>  # Since: 0.14
>  ##
>  { 'struct': 'MigrationStats',
> @@ -72,7 +75,8 @@
>             'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
>             'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
>             'postcopy-bytes': 'uint64',
> -           'dirty-sync-missed-zero-copy': 'uint64' } }
> +           'dirty-sync-missed-zero-copy': 'uint64',
> +           'iteration-count' : 'int' } }
>  
>  ##
>  # @XBZRLECacheStats:
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index d6768d5d71..b796a90cad 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -278,7 +278,7 @@ static int64_t read_migrate_property_int(QTestState *who, const char *property)
>  
>  static uint64_t get_migration_pass(QTestState *who)
>  {
> -    return read_ram_property_int(who, "dirty-sync-count");
> +    return read_ram_property_int(who, "iteration-count");
>  }
>  
>  static void read_blocktime(QTestState *who)

