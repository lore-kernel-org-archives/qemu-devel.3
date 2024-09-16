Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E305CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 20:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqIg1-0006JA-E2; Mon, 16 Sep 2024 16:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqIfz-0006IV-At
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 16:50:27 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqIfx-0001C7-DM
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 16:50:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A84C421A60;
 Mon, 16 Sep 2024 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726519823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfOQw2Iyiw/pffAi7elz8B73349NwN48eDqWi18zkyE=;
 b=HKYwp7b5XzbGXciarh0eC4wbb5MKOrSWT/yMDQJJ/m2PLjXK7Nr8bTUL3idzIEXyBihnwm
 VFXVfMzcKKiakog3xoEDPZcDsuXYaiVei4JpiDTJHfrXqGdX535fxVz/W7a1wxZCr1w5sh
 ZCjIAEiGW4BIANXwe3sv3chDqBPTDzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726519823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfOQw2Iyiw/pffAi7elz8B73349NwN48eDqWi18zkyE=;
 b=YhUbzNWiexSFSGZquIzcPuWpqHmI6pX2JdVqoBl3oqzdspNP6VdmQkO4H42YpwNOm+DRxT
 hBELRKUHEsLTSdAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bAVvRa1B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G2n1m1C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726519821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfOQw2Iyiw/pffAi7elz8B73349NwN48eDqWi18zkyE=;
 b=bAVvRa1BlaQLwwXFR1dgXR4xiWWyOxiqiiCDaEuTJGPVFgDzVCWQ38HWJtXfQ1k3nvtI6t
 cLjaxZyZslxrS1lVFPY+EHlvKE9ReBCkRHc3EM2lqTrobn0h1r7kG6LZCNKUY8ZVIAUS2k
 gRwFyOcEi42+3sQjzQH55WPcnFCwEsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726519821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfOQw2Iyiw/pffAi7elz8B73349NwN48eDqWi18zkyE=;
 b=G2n1m1C5ks+89lv2nuUvCuzSZKM/ZrFDAU/oH3vpWPVfl6d4z8TR/kD5Tmgxn8ljPZ4gzw
 hxpcslmIhOby5+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32D6E139CE;
 Mon, 16 Sep 2024 20:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bX6hOgya6Ga+IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Sep 2024 20:50:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH v1 5/7] migration: Support background dirty bitmap sync
 and throttle
In-Reply-To: <d74bc4ffb073c886bc566e7d771910db844cec1b.1726390099.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <d74bc4ffb073c886bc566e7d771910db844cec1b.1726390099.git.yong.huang@smartx.com>
Date: Mon, 16 Sep 2024 17:50:18 -0300
Message-ID: <87setzz5kl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A84C421A60
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[smartx.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> When VM is configured with huge memory, the current throttle logic
> doesn't look like to scale, because migration_trigger_throttle()
> is only called for each iteration, so it won't be invoked for a long
> time if one iteration can take a long time.
>
> The background sync and throttle aim to fix the above issue by
> synchronizing the remote dirty bitmap and triggering the throttle
> once detect that iteration lasts a long time.
>
> This is a trade-off between synchronization overhead and CPU throttle
> impact.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/migration.c        | 12 +++++++++++
>  tests/qtest/migration-test.c | 39 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 055d527ff6..af8b22fa15 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1416,6 +1416,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>  
>          trace_migrate_fd_cleanup();
>          bql_unlock();
> +        migration_background_sync_cleanup();
>          if (s->migration_thread_running) {
>              qemu_thread_join(&s->thread);
>              s->migration_thread_running = false;
> @@ -3263,6 +3264,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  
>      if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
>          trace_migration_thread_low_pending(pending_size);
> +        migration_background_sync_cleanup();

This one is redundant with the migrate_fd_cleanup() call at the end of
migration_iteration_finish().

>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }
> @@ -3508,6 +3510,16 @@ static void *migration_thread(void *opaque)
>      ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>      bql_unlock();
>  
> +    if (!migrate_dirty_limit()) {
> +        /*
> +         * Initiate the background sync watcher in order to guarantee
> +         * that the CPU throttling acts appropriately. Dirty Limit
> +         * doesn't use CPU throttle to make guest down, so ignore that
> +         * case.
> +         */
> +        migration_background_sync_setup();
> +    }
> +
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
>  
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b796a90cad..e0e94d26be 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -281,6 +281,11 @@ static uint64_t get_migration_pass(QTestState *who)
>      return read_ram_property_int(who, "iteration-count");
>  }
>  
> +static uint64_t get_dirty_sync_count(QTestState *who)
> +{
> +    return read_ram_property_int(who, "dirty-sync-count");
> +}
> +
>  static void read_blocktime(QTestState *who)
>  {
>      QDict *rsp_return;
> @@ -468,6 +473,12 @@ static void migrate_ensure_converge(QTestState *who)
>      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
>  }
>  
> +static void migrate_ensure_iteration_last_long(QTestState *who)
> +{
> +    /* Set 10Byte/s bandwidth limit to make the iteration last long enough */
> +    migrate_set_parameter_int(who, "max-bandwidth", 10);
> +}
> +
>  /*
>   * Our goal is to ensure that we run a single full migration
>   * iteration, and also dirty memory, ensuring that at least
> @@ -2791,6 +2802,10 @@ static void test_migrate_auto_converge(void)
>       * so we need to decrease a bandwidth.
>       */
>      const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
> +    uint64_t prev_iter_cnt = 0, iter_cnt;
> +    uint64_t iter_cnt_changes = 0;
> +    uint64_t prev_dirty_sync_cnt = 0, dirty_sync_cnt;
> +    uint64_t dirty_sync_cnt_changes = 0;
>  
>      if (test_migrate_start(&from, &to, uri, &args)) {
>          return;
> @@ -2827,6 +2842,30 @@ static void test_migrate_auto_converge(void)
>      } while (true);
>      /* The first percentage of throttling should be at least init_pct */
>      g_assert_cmpint(percentage, >=, init_pct);
> +
> +    /* Make sure the iteration take a long time enough */
> +    migrate_ensure_iteration_last_long(from);
> +
> +    /*
> +     * End the loop when the dirty sync count or iteration count changes.
> +     */
> +    while (iter_cnt_changes < 2 && dirty_sync_cnt_changes < 2) {
> +        usleep(1000 * 1000);
> +        iter_cnt = get_migration_pass(from);
> +        iter_cnt_changes += (iter_cnt != prev_iter_cnt);
> +        prev_iter_cnt = iter_cnt;
> +
> +        dirty_sync_cnt = get_dirty_sync_count(from);
> +        dirty_sync_cnt_changes += (dirty_sync_cnt != prev_dirty_sync_cnt);
> +        prev_dirty_sync_cnt = dirty_sync_cnt;
> +    }
> +
> +    /*
> +     * The dirty sync count must have changed because we are in the same
> +     * iteration.
> +     */
> +    g_assert_cmpint(iter_cnt_changes , < , dirty_sync_cnt_changes);
> +
>      /* Now, when we tested that throttling works, let it converge */
>      migrate_ensure_converge(from);

