Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1606CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyyg3-00061E-HA; Wed, 17 Sep 2025 16:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyyg2-00060y-9u
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:22:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyyg0-0003Mt-8T
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:22:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACEB134880;
 Wed, 17 Sep 2025 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758140569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=so+FyYFYr2xshx+OnL3X4EnkbPl1BnJAUSj4c+svqC0=;
 b=sFkNbt6xeXz00WryaPTBoVsCbzw1KG+ky1TcHuepj+W2GP/JZ4oV9nohsJdQYXdrfgYtNq
 h3mwZLdc8azo2TWLu3uaI9KPEO4IFntzjfoeqvnurI6Gs5E6ArcsIgAoh9ka/RmBC022nz
 QI7PEOpKXyf7m2ar0Hu8tMuKr7g/XM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758140569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=so+FyYFYr2xshx+OnL3X4EnkbPl1BnJAUSj4c+svqC0=;
 b=mfqbqrRqE33ikQpNjT3d4Qf42dqnjM+GNG8icCZyy5TPTsG4BSHb1RJP4veMVhvAvHYtv4
 +0bJD4j5YtYzujBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758140569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=so+FyYFYr2xshx+OnL3X4EnkbPl1BnJAUSj4c+svqC0=;
 b=sFkNbt6xeXz00WryaPTBoVsCbzw1KG+ky1TcHuepj+W2GP/JZ4oV9nohsJdQYXdrfgYtNq
 h3mwZLdc8azo2TWLu3uaI9KPEO4IFntzjfoeqvnurI6Gs5E6ArcsIgAoh9ka/RmBC022nz
 QI7PEOpKXyf7m2ar0Hu8tMuKr7g/XM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758140569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=so+FyYFYr2xshx+OnL3X4EnkbPl1BnJAUSj4c+svqC0=;
 b=mfqbqrRqE33ikQpNjT3d4Qf42dqnjM+GNG8icCZyy5TPTsG4BSHb1RJP4veMVhvAvHYtv4
 +0bJD4j5YtYzujBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22E4E1368D;
 Wed, 17 Sep 2025 20:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2N1zNJgYy2hRdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 20:22:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Xiaohui Li
 <xiaohli@redhat.com>
Subject: Re: [PATCH 1/3] migration/tls: Gracefully shutdown main and preempt
 channels
In-Reply-To: <20250910160144.1762894-2-peterx@redhat.com>
References: <20250910160144.1762894-1-peterx@redhat.com>
 <20250910160144.1762894-2-peterx@redhat.com>
Date: Wed, 17 Sep 2025 17:22:46 -0300
Message-ID: <871po4x209.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

> QEMU supported graceful shutdowns for multifd channels starting from commit
> 48796f6b44 ("migration/multifd: Terminate the TLS connection").  Then error
> check was enabled for premature TLS terminations.
>
> Now if we run the preempt TLS unit test, the test would pass, but there
> will be a warning reported:
>
> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> ok 1 /x86_64/migration/postcopy/preempt/tls/psk
>
> To fix it, make the rest channels to be gracefully terminated too when it's
> a TLS channel.
>
> One note is that the qemufile helper needs to be in migration.c not
> qemu-file.c, because qemu-file.c will be linked in unit tests, which will
> not link channel.c unfortunately.
>
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.h   |  3 +++
>  migration/migration.h |  2 ++
>  migration/channel.c   | 13 +++++++++++++
>  migration/migration.c | 24 +++++++++++++++++++++++-
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/migration/channel.h b/migration/channel.h
> index 5bdb8208a7..0b25dd7c5b 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -29,4 +29,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
>                                  const char *buf,
>                                  const size_t buflen,
>                                  Error **errp);
> +
> +bool migration_channel_shutdown_gracefully(QIOChannel *c, Error **errp);
> +
>  #endif
> diff --git a/migration/migration.h b/migration/migration.h
> index 01329bf824..b5763af057 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -594,4 +594,6 @@ void migration_bitmap_sync_precopy(bool last_stage);
>  void dirty_bitmap_mig_init(void);
>  bool should_send_vmdesc(void);
>  
> +bool qemu_file_shutdown_gracefully(QEMUFile *f, Error **errp);
> +
>  #endif
> diff --git a/migration/channel.c b/migration/channel.c
> index a547b1fbfe..1ae839e5fe 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -145,3 +145,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
>  
>      return 0;
>  }
> +
> +/*
> + * This is only needed for a successful migration, no-op for non-TLS
> + * channels.  For unexpected interruptions, use qio_channel_shutdown().
> + */
> +bool migration_channel_shutdown_gracefully(QIOChannel *c, Error **errp)
> +{

    ERRP_GUARD();

due to dereferencing errp below

> +    if (object_dynamic_cast((Object *)c, TYPE_QIO_CHANNEL_TLS)) {
> +        qio_channel_tls_bye(QIO_CHANNEL_TLS(c), errp);
> +    }
> +
> +    return *errp == NULL;
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..7015c2b5e0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -113,6 +113,27 @@ static bool close_return_path_on_source(MigrationState *s);
>  static void migration_completion_end(MigrationState *s);
>  static void migrate_hup_delete(MigrationState *s);
>  
> +/*
> + * See migration_channel_shutdown_gracefully().  The "graceful" versions
> + * are only needed if migration succeeded.
> + */
> +bool qemu_file_shutdown_gracefully(QEMUFile *f, Error **errp)
> +{
> +    int ret;
> +
> +    if (!migration_channel_shutdown_gracefully(qemu_file_get_ioc(f), errp)) {
> +        return false;
> +    }
> +
> +    ret = qemu_file_shutdown(f);
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "qemu_file_shutdown() failed");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void migration_downtime_start(MigrationState *s)
>  {
>      trace_vmstate_downtime_checkpoint("src-downtime-start");
> @@ -2473,11 +2494,12 @@ static void migration_release_dst_files(MigrationState *ms)
>       */
>      if (ms->postcopy_qemufile_src) {
>          migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
> -        qemu_file_shutdown(ms->postcopy_qemufile_src);
> +        qemu_file_shutdown_gracefully(ms->postcopy_qemufile_src, &error_warn);
>          qemu_fclose(ms->postcopy_qemufile_src);
>          ms->postcopy_qemufile_src = NULL;
>      }
>  
> +    qemu_file_shutdown_gracefully(file, &error_warn);
>      qemu_fclose(file);
>  }

