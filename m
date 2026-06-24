Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B72CCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPFj-0003wc-E5; Wed, 24 Jun 2026 11:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcPFV-0003sl-TL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:10:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcPFT-0001zg-6b
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:10:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41DFC75E74;
 Wed, 24 Jun 2026 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782313840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qFTVWixYb867stxe2//gz19SJR2pKN1zyiu8tDH4ew=;
 b=MYY4Ih0nUFfor8zh3LAXLZuJOGZoZ5CJqRfJXi2TGze0oMN2SuXEtgYL7dq6CPdrncCtdr
 nLgVIVvZ4NgwvSMfI33ndkNDUXPQ8Hd0LvSlil6osFFlWumX94TgyizR+GYMuazRZaP8vu
 a0JlbGvuECxyU39t1zyP4M9MNCuJqwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782313840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qFTVWixYb867stxe2//gz19SJR2pKN1zyiu8tDH4ew=;
 b=W/aYIzHznVq6sfs+1vmXqbAyskJDHutEWCE0KQ3Wm18H2JFt2okejiCAP1/6KepuRRXESw
 Q+axkvQyJmNAcuCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MYY4Ih0n;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="W/aYIzHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782313840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qFTVWixYb867stxe2//gz19SJR2pKN1zyiu8tDH4ew=;
 b=MYY4Ih0nUFfor8zh3LAXLZuJOGZoZ5CJqRfJXi2TGze0oMN2SuXEtgYL7dq6CPdrncCtdr
 nLgVIVvZ4NgwvSMfI33ndkNDUXPQ8Hd0LvSlil6osFFlWumX94TgyizR+GYMuazRZaP8vu
 a0JlbGvuECxyU39t1zyP4M9MNCuJqwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782313840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qFTVWixYb867stxe2//gz19SJR2pKN1zyiu8tDH4ew=;
 b=W/aYIzHznVq6sfs+1vmXqbAyskJDHutEWCE0KQ3Wm18H2JFt2okejiCAP1/6KepuRRXESw
 Q+axkvQyJmNAcuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4EFF779A8;
 Wed, 24 Jun 2026 15:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9E3zKG/zO2oNbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 24 Jun 2026 15:10:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Aadeshveer Singh <aadeshveer07@gmail.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, Aadeshveer Singh
 <aadeshveer07@gmail.com>
Subject: Re: [RFC PATCH 4/5] migration: write up code to run fast snapshot
 load in qemu_loadvm_state
In-Reply-To: <20260618032010.88755-5-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-5-aadeshveer07@gmail.com>
Date: Wed, 24 Jun 2026 12:10:29 -0300
Message-ID: <87y0g4nfdm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,mailo.com,saferwall.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 41DFC75E74
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Aadeshveer Singh <aadeshveer07@gmail.com> writes:

> When both mapped-ram and postcopy-ram are set, divert from
> qemu_loadvm_state to run fast snapshot load
>
> Initialize postcopy RAM state and register RAM Blocks with userfaultfd
> via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup().
> Launch fault thread before VM to serve faults for some hardwares
> emulation that need to read RAM (like vapic devices). Populate bitmaps
> and offset tables while reading file in qemu_loadvm_state_main. Call to
> qemu_loadvm_state_postcopy() which starts the VM using
> loadvm_postcopy_handle_run_bh() and launches eager load thread.
>
> Skip scheduling process_incoming_migration_bh() in
> process_incoming_migration_co(), for fast snapshot load as the state
> cleanup is managed by eager load thread on completion.
>
> Skip setting migration status to ACTIVE in process_incoming_migration_co
> and set set it to POSTCOPY_DEVICE in qemu_loadvm_state() itself.
>
> Remove the capability check that rejected mapped-ram and postcopy-ram
> being set simultaneously, as this combination now corresponds to fast
> snapshot load. The corresponding test will be updated in following
> patch.
>
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/migration.c | 10 ++++++---
>  migration/options.c   |  6 -----
>  migration/savevm.c    | 52 +++++++++++++++++++++++++++++++++++++++++--
>  migration/savevm.h    |  2 ++
>  4 files changed, 59 insertions(+), 11 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..e1ac310e20 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -756,8 +756,10 @@ process_incoming_migration_co(void *opaque)
>  
>      mis->largest_page_size = qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
> -    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> -                      MIGRATION_STATUS_ACTIVE);
> +    if (!migrate_fast_snapshot_load()) {
> +        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_ACTIVE);
> +    }
>  
>      mis->loadvm_co = qemu_coroutine_self();
>      ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> @@ -786,7 +788,9 @@ process_incoming_migration_co(void *opaque)
>          colo_incoming_co();
>      }
>  
> -    migration_bh_schedule(process_incoming_migration_bh, mis);
> +    if (!migrate_fast_snapshot_load()) {
> +        migration_bh_schedule(process_incoming_migration_bh, mis);
> +    }

This inconspicuous 4 line hunk will cause bugs for years to come. =D

We should try to include the fast_snapshot actions within the incoming
BH so the paths are the same in both types of migration. Ideally we'd
merge all the BHs in a single one.

>      goto out;
>  
>  fail:
> diff --git a/migration/options.c b/migration/options.c
> index 5f80dd5b42..3f447cf7b2 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -732,12 +732,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>                         "Mapped-ram migration is incompatible with xbzrle");
>              return false;
>          }
> -
> -        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> -            error_setg(errp,
> -                       "Mapped-ram migration is incompatible with postcopy");
> -            return false;
> -        }

Just checking: Does this allow any type of migration that is not covered
by this series?

>      }
>  
>      /*
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 23adaf9dd9..f10cc3c2fc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2959,6 +2959,32 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>      return true;
>  }
>  
> +/*
> + * Starts the VM and launches the eager thread for fast snapshot load
> + */
> +int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mis,
> +                               Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret = 0;
> +
> +    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
> +
> +    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
> +
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> +                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +
> +    ret = postcopy_ram_eager_load_setup(mis);
> +    if (ret) {
> +        error_prepend(errp,
> +                      "Failed to setup eager load for fast snapshot load: ");
> +        return ret;
> +    }
> +
> +    return ret;
> +}
> +
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp)
>  {
> @@ -3067,8 +3093,30 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>  
>      cpu_synchronize_all_pre_loadvm();
>  
> -    ret = qemu_loadvm_state_main(f, mis, errp);
> -    qemu_event_set(&mis->main_thread_load_event);
> +    if (migrate_fast_snapshot_load()) {
> +        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_POSTCOPY_DEVICE);
> +
> +        if (ram_postcopy_incoming_init(mis, errp)) {
> +            return -EINVAL;
> +        }
> +
> +        postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
> +        if (postcopy_ram_incoming_setup(mis)) {
> +            return -EINVAL;
> +        }
> +
> +        ret = qemu_loadvm_state_main(f, mis, errp);
> +
> +        qemu_event_set(&mis->main_thread_load_event);
> +
> +        if (ret == 0) {
> +            ret = qemu_loadvm_state_postcopy(f, mis, errp);
> +        }
> +    } else {
> +        ret = qemu_loadvm_state_main(f, mis, errp);
> +        qemu_event_set(&mis->main_thread_load_event);
> +    }
>  
>      trace_qemu_loadvm_state_post_main(ret);
>  
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 96fdf96d4e..9656acd7fe 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -67,6 +67,8 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>  int qemu_save_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> +int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mis,
> +                               Error **errp);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp);
>  int qemu_load_device_state(QEMUFile *f, Error **errp);

