Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E7EC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGv6-0006OV-UO; Mon, 31 Mar 2025 11:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzGur-0006L2-8n
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:19:19 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzGum-0006qv-Qd
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:19:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51FF31F452;
 Mon, 31 Mar 2025 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743434341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysoJEtUlkwj3bmSNPu5ussTeXpVEyqYmS23kBOCMNmM=;
 b=JUeC6vbKJXfzdvXxe1lHc+VJf4Wx42qu+R6Woc8DJtGVq2jLsNDD3IKVCCzBoXfJ6HpIbm
 G21hsk+pBQYT4YuFY6Ib4xqdD96pDV2HcxDIbzSmxW9lIbepODWqFAhobbp2i2WLrjFm+o
 pMnYyASQ7FPVHXbNPRgxaDYo7MSb1SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743434341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysoJEtUlkwj3bmSNPu5ussTeXpVEyqYmS23kBOCMNmM=;
 b=AhpXnkXkhdeVL5Y9hGV2WQcUiWQbRpyggIuBfaWqbCTZhTTAp5TSaYO3rcuqVNpkY0QG+n
 bWI5sJmlw9nwcHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743434341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysoJEtUlkwj3bmSNPu5ussTeXpVEyqYmS23kBOCMNmM=;
 b=JUeC6vbKJXfzdvXxe1lHc+VJf4Wx42qu+R6Woc8DJtGVq2jLsNDD3IKVCCzBoXfJ6HpIbm
 G21hsk+pBQYT4YuFY6Ib4xqdD96pDV2HcxDIbzSmxW9lIbepODWqFAhobbp2i2WLrjFm+o
 pMnYyASQ7FPVHXbNPRgxaDYo7MSb1SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743434341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysoJEtUlkwj3bmSNPu5ussTeXpVEyqYmS23kBOCMNmM=;
 b=AhpXnkXkhdeVL5Y9hGV2WQcUiWQbRpyggIuBfaWqbCTZhTTAp5TSaYO3rcuqVNpkY0QG+n
 bWI5sJmlw9nwcHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9DEA13A1F;
 Mon, 31 Mar 2025 15:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TAyqHWSy6mdtSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 31 Mar 2025 15:19:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v8 7/7] migration/ram: Implement save_postcopy_prepare()
In-Reply-To: <20250318123846.1370312-8-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-8-ppandit@redhat.com>
Date: Mon, 31 Mar 2025 12:18:57 -0300
Message-ID: <87semtkz32.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Peter Xu <peterx@redhat.com>
>
> Implement save_postcopy_prepare(), preparing for the enablement of both
> multifd and postcopy.
>
> Please see the rich comment for the rationals.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/ram.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> v8:
> - New patch
>
> v7:
> - https://lore.kernel.org/qemu-devel/20250228121749.553184-1-ppandit@redhat.com/T/#t
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 6fd88cbf2a..04fde7ba6b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4419,6 +4419,42 @@ static int ram_resume_prepare(MigrationState *s, void *opaque)
>      return 0;
>  }
>  
> +static bool ram_save_postcopy_prepare(QEMUFile *f, void *opaque, Error **errp)
> +{
> +    int ret;
> +
> +    if (migrate_multifd()) {
> +        /*
> +         * When multifd is enabled, source QEMU needs to make sure all the
> +         * pages queued before postcopy starts to be flushed.

s/to be/have been/

> +         *
> +         * Meanwhile, the load of these pages must happen before switching

s/Meanwhile,//

> +         * to postcopy.  It's because loading of guest pages (so far) in
> +         * multifd recv threads is still non-atomic, so the load cannot
> +         * happen with vCPUs running on destination side.
> +         *
> +         * This flush and sync will guarantee those pages loaded _before_

s/loaded/are loaded/

> +         * postcopy starts on destination. The rational is, this happens

s/rational/rationale/

> +         * before VM stops (and before source QEMU sends all the rest of
> +         * the postcopy messages).  So when the destination QEMU received
> +         * the postcopy messages, it must have received the sync message on
> +         * the main channel (either RAM_SAVE_FLAG_MULTIFD_FLUSH, or
> +         * RAM_SAVE_FLAG_EOS), and such message should have guaranteed all
> +         * previous guest pages queued in the multifd channels to be
> +         * completely loaded.
> +         */
> +        ret = multifd_ram_flush_and_sync(f);
> +        if (ret < 0) {
> +            error_setg(errp, "%s: multifd flush and sync failed", __func__);
> +            return false;
> +        }
> +    }
> +
> +    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +
> +    return true;
> +}
> +
>  void postcopy_preempt_shutdown_file(MigrationState *s)
>  {
>      qemu_put_be64(s->postcopy_qemufile_src, RAM_SAVE_FLAG_EOS);
> @@ -4438,6 +4474,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>      .load_setup = ram_load_setup,
>      .load_cleanup = ram_load_cleanup,
>      .resume_prepare = ram_resume_prepare,
> +    .save_postcopy_prepare = ram_save_postcopy_prepare,
>  };
>  
>  static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,

