Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21149CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXw1-000055-QE; Wed, 22 Oct 2025 08:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXvy-0008Vd-3j
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:27:18 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXvv-0007xj-2S
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:27:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04AAD1F38D;
 Wed, 22 Oct 2025 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761136029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sod3AmwW+S4yPn3ofc/oTw9FxtSxl/W1Z9ed7NyRSUI=;
 b=0S8tbAIcSgQumpV29BqJKpW7L/A09d1SISg+l5yO1cDpTRcCYFvQ3tiwFZqtNH+S4wras9
 TbFoiysFRUwXblvIXtSTAIMPKZa0tt7jE2E/9I8CpNujx+ptMfRsUf3FO3BjQ0yMfDkBCo
 z3P5Pu80ArWNcSUSIx3DJRpgOQo4n2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761136029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sod3AmwW+S4yPn3ofc/oTw9FxtSxl/W1Z9ed7NyRSUI=;
 b=9L6uUSb1c3CdBHrOJi8bzoWpVGtKwRaK63NUAdrZKwIBZo4FzVOjPIYaqwnZP8tTrVekaZ
 29GGBkDJLO1qYSAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dFwgQUOq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Deh0U3W8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761136025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sod3AmwW+S4yPn3ofc/oTw9FxtSxl/W1Z9ed7NyRSUI=;
 b=dFwgQUOqVH43O5rRszvWp+0PuvRkOeZvMY0dvHOV7u9+p16nELGmqjsXEnym/sIHjLOzcj
 itfugAC3yR53srqCwmYfDV6GGFSGipP6d7DTLmFDEmfM62QiXmdM4qDcUmTcmrVLyCmWip
 f4Uc/VN5yFaS9KIvgN2FEVlPg/MZ5yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761136025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sod3AmwW+S4yPn3ofc/oTw9FxtSxl/W1Z9ed7NyRSUI=;
 b=Deh0U3W8PPS/285qI2tilzJyx8N2CmjTz4ZRqh+FHmhF0WbCCIzP2QpB9upTe/WFzDuefL
 cfLafp1b9uSLc1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 771C913A29;
 Wed, 22 Oct 2025 12:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P0a2DpjN+Gi/LAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Oct 2025 12:27:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon
 <armenon@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 2/4] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
In-Reply-To: <20251021220407.2662288-3-peterx@redhat.com>
References: <20251021220407.2662288-1-peterx@redhat.com>
 <20251021220407.2662288-3-peterx@redhat.com>
Date: Wed, 22 Oct 2025 09:27:01 -0300
Message-ID: <87a51jt94a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 04AAD1F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> Per reported and analyzed by Peter:
>
> https://lore.kernel.org/r/CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com
>
> mfd leak is a false positive, try to use a coverity annotation (which I
> didn't find manual myself, but still give it a shot).
>
> Fix the other one by capture error if setenv() failed.  When at it, pass
> the error to the top (cpr_state_save()).  Along the way, changing all
> retval to bool when errp is around.
>
> Resolves: Coverity CID 1641391
> Resolves: Coverity CID 1641392
> Fixes: efc6587313 ("migration: cpr-exec save and load")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/cpr.h |  4 ++--
>  migration/cpr-exec.c    | 10 ++++++++--
>  migration/cpr.c         | 15 +++++++++------
>  migration/migration.c   |  2 +-
>  4 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index a412d6663c..027cb98073 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -41,7 +41,7 @@ MigMode cpr_get_incoming_mode(void);
>  void cpr_set_incoming_mode(MigMode mode);
>  bool cpr_is_incoming(void);
>  
> -int cpr_state_save(MigrationChannel *channel, Error **errp);
> +bool cpr_state_save(MigrationChannel *channel, Error **errp);
>  int cpr_state_load(MigrationChannel *channel, Error **errp);
>  void cpr_state_close(void);
>  struct QIOChannel *cpr_state_ioc(void);
> @@ -56,7 +56,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>  void cpr_exec_init(void);
>  QEMUFile *cpr_exec_output(Error **errp);
>  QEMUFile *cpr_exec_input(Error **errp);
> -void cpr_exec_persist_state(QEMUFile *f);
> +bool cpr_exec_persist_state(QEMUFile *f, Error **errp);
>  bool cpr_exec_has_state(void);
>  void cpr_exec_unpersist_state(void);
>  void cpr_exec_unpreserve_fds(void);
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index d57714bc5d..087ca94c87 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -40,16 +40,22 @@ static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>      return qemu_file_new_output(ioc);
>  }
>  
> -void cpr_exec_persist_state(QEMUFile *f)
> +bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
>  {
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> +    /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
>      int mfd = dup(fioc->fd);
>      char val[16];
>  
>      /* Remember mfd in environment for post-exec load */
>      qemu_clear_cloexec(mfd);
>      snprintf(val, sizeof(val), "%d", mfd);
> -    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
> +    if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
> +        error_setg(errp, "Setting env %s = %s failed", CPR_EXEC_STATE_NAME, val);
> +        return false;
> +    }
> +
> +    return true;
>  }
>  
>  static int cpr_exec_find_state(void)
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 22dbac7c72..adee2a919a 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -176,7 +176,7 @@ bool cpr_is_incoming(void)
>      return incoming_mode != MIG_MODE_NONE;
>  }
>  
> -int cpr_state_save(MigrationChannel *channel, Error **errp)
> +bool cpr_state_save(MigrationChannel *channel, Error **errp)
>  {
>      int ret;
>      QEMUFile *f;
> @@ -190,10 +190,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>      } else if (mode == MIG_MODE_CPR_EXEC) {
>          f = cpr_exec_output(errp);
>      } else {
> -        return 0;
> +        return true;
>      }
>      if (!f) {
> -        return -1;
> +        return false;
>      }
>  
>      qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
> @@ -202,11 +202,14 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>      ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
>      if (ret) {
>          qemu_fclose(f);
> -        return ret;
> +        return false;
>      }
>  
>      if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> -        cpr_exec_persist_state(f);
> +        if (!cpr_exec_persist_state(f, errp)) {
> +            qemu_fclose(f);
> +            return false;
> +        }
>      }
>  
>      /*
> @@ -217,7 +220,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>      qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
>                           NULL);
>      cpr_state_file = f;
> -    return 0;
> +    return true;
>  }
>  
>  int cpr_state_load(MigrationChannel *channel, Error **errp)
> diff --git a/migration/migration.c b/migration/migration.c
> index a63b46bbef..c8a5712993 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2301,7 +2301,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>  
> -    if (cpr_state_save(cpr_channel, &local_err)) {
> +    if (!cpr_state_save(cpr_channel, &local_err)) {
>          goto out;
>      }

Thanks!

Reviewed-by: Fabiano Rosas <farosas@suse.de>

