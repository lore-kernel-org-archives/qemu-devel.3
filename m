Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E079BD46BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 19:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlBaI-0001qm-5f; Wed, 28 Jan 2026 14:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlBaG-0001pM-7w
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:52:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlBaE-0001Or-Fq
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:52:12 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C676A33D42;
 Wed, 28 Jan 2026 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769629928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFK+ewLnp0oFFu1lkvxmVKsCrkCDGMONG3hGEUzjMYQ=;
 b=xibpWl7Apt0p5UI+6weK7Vcw9pIyM0IdhR39sM+HlMTL6ruydYbyEBdMFLCgSNU4o2IWJc
 kMszDu0q8JfZ+70tYz2lTUc3/hAmm7Wu80qdMxNtwfh+BhOEffIstn2+pz4DUA8faWX1Te
 GApSiUYtBc8kS55Ur3g3/5YGj97OSLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769629928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFK+ewLnp0oFFu1lkvxmVKsCrkCDGMONG3hGEUzjMYQ=;
 b=3ap6kbL6gxuwiW9zafJVDF5rsqjkezCb/DFPW3ZCpn3viAwFDrkUVPJoe8j7p+18qofRvJ
 5dW8ZCI0o+dNznDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769629928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFK+ewLnp0oFFu1lkvxmVKsCrkCDGMONG3hGEUzjMYQ=;
 b=xibpWl7Apt0p5UI+6weK7Vcw9pIyM0IdhR39sM+HlMTL6ruydYbyEBdMFLCgSNU4o2IWJc
 kMszDu0q8JfZ+70tYz2lTUc3/hAmm7Wu80qdMxNtwfh+BhOEffIstn2+pz4DUA8faWX1Te
 GApSiUYtBc8kS55Ur3g3/5YGj97OSLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769629928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFK+ewLnp0oFFu1lkvxmVKsCrkCDGMONG3hGEUzjMYQ=;
 b=3ap6kbL6gxuwiW9zafJVDF5rsqjkezCb/DFPW3ZCpn3viAwFDrkUVPJoe8j7p+18qofRvJ
 5dW8ZCI0o+dNznDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4191B3EA61;
 Wed, 28 Jan 2026 19:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /86vAOhoeml6NwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 19:52:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 22/24] migration: Make
 qemu_savevm_state_non_iterable() take errp
In-Reply-To: <20260127185254.3954634-23-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-23-peterx@redhat.com>
Date: Wed, 28 Jan 2026 16:52:05 -0300
Message-ID: <87pl6tecre.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

> Let the function report errors to upper layers.  Out of three current
> users, two of them already process the errors, except one outlier,
> qemu_savevm_state_complete_precopy(), where we do it manually for now with
> a comment for TODO.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.h    |  2 +-
>  migration/migration.c |  8 ++++----
>  migration/savevm.c    | 13 +++++++------
>  3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index f2750eca09..6a589b2990 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -74,7 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp);
>  int qemu_load_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_approve_switchover(void);
> -int qemu_savevm_state_non_iterable(QEMUFile *f);
> +int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
>  int qemu_savevm_state_non_iterable_early(QEMUFile *f,
>                                           JSONWriter *vmdesc,
>                                           Error **errp);
> diff --git a/migration/migration.c b/migration/migration.c
> index ddf6faab46..22cfa5f19f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2545,9 +2545,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       */
>      qemu_savevm_send_postcopy_listen(fb);
>  
> -    ret = qemu_savevm_state_non_iterable(fb);
> +    ret = qemu_savevm_state_non_iterable(fb, errp);
>      if (ret) {
> -        error_setg(errp, "Postcopy save non-iterable device states failed");
> +        error_prepend(errp, "Postcopy save non-iterable states failed: ");
>          goto fail_closefb;
>      }
>  
> @@ -3675,8 +3675,8 @@ static void *bg_migration_thread(void *opaque)
>          goto fail_with_bql;
>      }
>  
> -    if (qemu_savevm_state_non_iterable(fb)) {
> -        error_setg(&local_err, "Failed to save non-iterable devices");
> +    if (qemu_savevm_state_non_iterable(fb, &local_err)) {
> +        error_prepend(&local_err, "Failed to save non-iterable devices");

No space or punctuation at the end?

>          goto fail_with_bql;
>      }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c16951b532..130b9764a7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1710,13 +1710,12 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
>      qemu_savevm_state_vm_desc(s, f);
>  }
>  
> -int qemu_savevm_state_non_iterable(QEMUFile *f)
> +int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
>  {
>      MigrationState *ms = migrate_get_current();
>      int64_t start_ts_each, end_ts_each;
>      JSONWriter *vmdesc = ms->vmdesc;
>      SaveStateEntry *se;
> -    Error *local_err = NULL;
>      int ret;
>  
>      /* Making sure cpu states are synchronized before saving non-iterable */
> @@ -1730,10 +1729,8 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
>  
>          start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>  
> -        ret = vmstate_save(f, se, vmdesc, &local_err);
> +        ret = vmstate_save(f, se, vmdesc, errp);
>          if (ret) {
> -            migrate_error_propagate(ms, error_copy(local_err));
> -            error_report_err(local_err);
>              return ret;
>          }
>  
> @@ -1750,6 +1747,7 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
>  int qemu_savevm_state_complete_precopy(MigrationState *s)
>  {
>      QEMUFile *f = s->to_dst_file;
> +    Error *local_err = NULL;
>      int ret;
>  
>      ret = qemu_savevm_state_complete_precopy_iterable(f, false);
> @@ -1757,8 +1755,11 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>          return ret;
>      }
>  
> -    ret = qemu_savevm_state_non_iterable(f);
> +    /* TODO: pass error upper */
> +    ret = qemu_savevm_state_non_iterable(f, &local_err);
>      if (ret) {
> +        migrate_error_propagate(s, error_copy(local_err));
> +        error_report_err(local_err);
>          return ret;
>      }

