Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54308C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 19:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU9sB-0002kW-FW; Wed, 17 Jul 2024 14:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU9sA-0002ju-1j
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:59:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU9s8-00079e-Cc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:59:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F26DD1FB95;
 Wed, 17 Jul 2024 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721242766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncSEfsOJfx2E+4pcYlKkEddskH3Z2xRKZgUBWUzYmcU=;
 b=Aggg5LiabgxsvIeJVvOilc05VXWWEkrHjNy98XnK6M0vNV/PJXLoMpd3N/9S6+elhtvbLN
 3v1cy6Rfh8mxBXGwgIkLLCcNto3uiEXxsBeXWsLjLGh4b9kOhebzEk8iaCxmZVRKKICAOW
 Dx/EqZmraii8zTySGYl+lawPIeKz8Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721242766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncSEfsOJfx2E+4pcYlKkEddskH3Z2xRKZgUBWUzYmcU=;
 b=wB4K4x5Rvs1BKC0QScKXxGzJWUM1LOsDkY/AhQ+TQyllJlv3jL6X9+tkp4sA23oSA3m2bS
 Bpcr+tVxAGcwFMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721242766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncSEfsOJfx2E+4pcYlKkEddskH3Z2xRKZgUBWUzYmcU=;
 b=Aggg5LiabgxsvIeJVvOilc05VXWWEkrHjNy98XnK6M0vNV/PJXLoMpd3N/9S6+elhtvbLN
 3v1cy6Rfh8mxBXGwgIkLLCcNto3uiEXxsBeXWsLjLGh4b9kOhebzEk8iaCxmZVRKKICAOW
 Dx/EqZmraii8zTySGYl+lawPIeKz8Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721242766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncSEfsOJfx2E+4pcYlKkEddskH3Z2xRKZgUBWUzYmcU=;
 b=wB4K4x5Rvs1BKC0QScKXxGzJWUM1LOsDkY/AhQ+TQyllJlv3jL6X9+tkp4sA23oSA3m2bS
 Bpcr+tVxAGcwFMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71A1E1368F;
 Wed, 17 Jul 2024 18:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sSLSDY0UmGbjUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 18:59:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 04/11] migration: stop vm earlier for cpr
In-Reply-To: <1719776434-435013-5-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-5-git-send-email-steven.sistare@oracle.com>
Date: Wed, 17 Jul 2024 15:59:22 -0300
Message-ID: <87sew726b9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Stop the vm earlier for cpr, to guarantee consistent device state when
> CPR state is saved.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/migration.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 0f47765..8a8e927 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2077,6 +2077,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>      MigrationState *s = migrate_get_current();
>      g_autoptr(MigrationChannel) channel = NULL;
>      MigrationAddress *addr = NULL;
> +    bool stopped = false;
>  
>      /*
>       * Having preliminary checks for uri and channel
> @@ -2120,6 +2121,15 @@ void qmp_migrate(const char *uri, bool has_channels,
>          }
>      }
>  
> +    if (migrate_mode_is_cpr(s)) {
> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> +        if (ret < 0) {
> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> +            goto out;
> +        }
> +        stopped = true;
> +    }
> +
>      if (cpr_state_save(&local_err)) {
>          goto out;
>      }
> @@ -2155,6 +2165,9 @@ out:
>          }
>          migrate_fd_error(s, local_err);
>          error_propagate(errp, local_err);
> +        if (stopped && runstate_is_live(s->vm_old_state)) {
> +            vm_start();
> +        }

What about non-live states? Shouldn't this be:

if (stopped) {
   vm_resume();
}

>          return;
>      }
>  }
> @@ -3738,7 +3751,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      Error *local_err = NULL;
>      uint64_t rate_limit;
>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
> -    int ret;
>  
>      /*
>       * If there's a previous error, free it and prepare for another one.
> @@ -3810,14 +3822,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          return;
>      }
>  
> -    if (migrate_mode_is_cpr(s)) {
> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> -        if (ret < 0) {
> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> -            goto fail;
> -        }
> -    }
> -
>      if (migrate_background_snapshot()) {
>          qemu_thread_create(&s->thread, "mig/snapshot",
>                  bg_migration_thread, s, QEMU_THREAD_JOINABLE);

