Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9DED3F074
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7Ni-0007HG-Sk; Wed, 28 Jan 2026 10:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Ne-0007D8-MC
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:22:54 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Nc-0003Ol-V1
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:22:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E910E5BCCA;
 Wed, 28 Jan 2026 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvAEU5FevYyTKE7787EEszo3tERzPx+U7svgAyut2wg=;
 b=FFwPOD0eqLog1Zdl7MhnGl/gfOKP0oQ2zsdg/TU9evoDUAxI53Q6lr1dPGj7No35MIaMZd
 +CLljpub6jmcmDj+m8Xg2SDKm9bjeYPzQMU8pAJjSeiWSKhKtWzcRo6+LSvcnMY0bKXJw/
 nXa7retG7EqQDbuGmBqdzLggselKoHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvAEU5FevYyTKE7787EEszo3tERzPx+U7svgAyut2wg=;
 b=YA3MEi31mlszPJih8RjmDDKUWshFgkvZTHmiYTrythgBdyX1YHa0h9AUTvO0ZdKJFZhScU
 SUl9n24lBXdpIcCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FFwPOD0e;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YA3MEi31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvAEU5FevYyTKE7787EEszo3tERzPx+U7svgAyut2wg=;
 b=FFwPOD0eqLog1Zdl7MhnGl/gfOKP0oQ2zsdg/TU9evoDUAxI53Q6lr1dPGj7No35MIaMZd
 +CLljpub6jmcmDj+m8Xg2SDKm9bjeYPzQMU8pAJjSeiWSKhKtWzcRo6+LSvcnMY0bKXJw/
 nXa7retG7EqQDbuGmBqdzLggselKoHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvAEU5FevYyTKE7787EEszo3tERzPx+U7svgAyut2wg=;
 b=YA3MEi31mlszPJih8RjmDDKUWshFgkvZTHmiYTrythgBdyX1YHa0h9AUTvO0ZdKJFZhScU
 SUl9n24lBXdpIcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5981D3EA62;
 Wed, 28 Jan 2026 15:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H9M3B8cpemkENwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 15:22:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 16/24] migration: Split
 qemu_savevm_state_complete_precopy_non_iterable()
In-Reply-To: <20260127185254.3954634-17-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-17-peterx@redhat.com>
Date: Wed, 28 Jan 2026 12:22:44 -0300
Message-ID: <875x8lg3sr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: E910E5BCCA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Split the function, making itself to be the helper to dump all non-iterable
> device states (early_vmsd excluded).  Move the precopy end logic out to the
> two callers that need it.
>
> With it, we can remove the in_postcopy parameter.  Meanwhile, renaming the
> function to be qemu_savevm_state_non_iterable(): we don't need the keyword
> "complete" because non-iterable doesn't iterate anyway, and we don't need
> precopy because we moved precopy specialties out.
>
> NOTE: this patch introduced one new migrate_get_current() user; will be
> removed in follow up patch.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.h    |  3 +--
>  migration/migration.c |  7 +++++--
>  migration/savevm.c    | 12 ++++--------
>  3 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index f957f851ef..57b96133d5 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -74,8 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp);
>  int qemu_load_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_approve_switchover(void);
> -int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> -        bool in_postcopy);
> +int qemu_savevm_state_non_iterable(QEMUFile *f);
>  
>  bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
>                                     char *buf, size_t len, Error **errp);
> diff --git a/migration/migration.c b/migration/migration.c
> index e3f1cc7b2e..c6e54d2a3f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2545,7 +2545,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       */
>      qemu_savevm_send_postcopy_listen(fb);
>  
> -    ret = qemu_savevm_state_complete_precopy_non_iterable(fb, true);
> +    ret = qemu_savevm_state_non_iterable(fb);
>      if (ret) {
>          error_setg(errp, "Postcopy save non-iterable device states failed");
>          goto fail_closefb;
> @@ -3678,9 +3678,12 @@ static void *bg_migration_thread(void *opaque)
>          goto fail;
>      }
>  
> -    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false)) {
> +    if (qemu_savevm_state_non_iterable(fb)) {
>          goto fail;
>      }
> +
> +    qemu_savevm_state_end_precopy(s, fb);
> +
>      /*
>       * Since we are going to get non-iterable state data directly
>       * from s->bioc->data, explicit flush is needed here.
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 41560b97a4..e1918d4f38 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1691,8 +1691,7 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
>      qemu_savevm_state_vm_desc(s, f);
>  }
>  
> -int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> -                                                    bool in_postcopy)
> +int qemu_savevm_state_non_iterable(QEMUFile *f)
>  {
>      MigrationState *ms = migrate_get_current();
>      int64_t start_ts_each, end_ts_each;
> @@ -1724,11 +1723,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>                                      end_ts_each - start_ts_each);
>      }
>  
> -    if (!in_postcopy) {
> -        /* Postcopy stream will still be going */
> -        qemu_savevm_state_end_precopy(ms, f);
> -    }
> -
>      trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
>  
>      return 0;
> @@ -1743,11 +1737,13 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f)
>          return ret;
>      }
>  
> -    ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
> +    ret = qemu_savevm_state_non_iterable(f);
>      if (ret) {
>          return ret;
>      }
>  
> +    qemu_savevm_state_end_precopy(migrate_get_current(), f);
> +
>      return qemu_fflush(f);
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

