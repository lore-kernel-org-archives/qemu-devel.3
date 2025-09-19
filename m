Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF40ACAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 16:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzdj0-0007wk-Rl; Fri, 19 Sep 2025 12:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzdiz-0007wZ-Ae
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:12:41 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzdiw-00056b-Qy
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:12:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EAD31F7F1;
 Fri, 19 Sep 2025 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758298354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8hdfoWc94qlI9DC1OsQ/y8tfGgOUigm+MM0x3Ug2PzY=;
 b=PimrPmwLOlind63Ph3GnuxL/rf73y8taVDykjcVlHkkIDUFG/tswwY1lifAawOt98cCal7
 XVzlzZYX82ZucObjfIXH5O2XhVwIJSjMMv8oEKzOuN2ZbKYPwaLTW2YEaGU9I92kGzfVZh
 S9+gv3WRiptpJTGo+tmbcQ15bpxUruc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758298354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8hdfoWc94qlI9DC1OsQ/y8tfGgOUigm+MM0x3Ug2PzY=;
 b=1hQ4H+b6/pgeX6ZneDJug9nfFrBKgY+aW6iHvth/P6Rrb+QCEK3X6JbnA5tMnEtXW7j6mT
 dPfgKCMj2JuYlGAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758298353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8hdfoWc94qlI9DC1OsQ/y8tfGgOUigm+MM0x3Ug2PzY=;
 b=dkQ75L9//V+BX/kvxNMtnAJlwFwSHKFT8RCp7LIvUHQ51YpwoPDEWs6tN7huN0uECWqpr8
 DQYEzrkqtozTkd0bGcL2p8InHFqsEiygzhaVn/O2Rt56uHs0yo4hRLFhi8KANhKMspmP97
 w9vSjw9pG4zVDFraQP2nzkOmh+WusmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758298353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8hdfoWc94qlI9DC1OsQ/y8tfGgOUigm+MM0x3Ug2PzY=;
 b=W8GP8e5ZCOUK5/O6phUliPFLX6mL+zzoCqk5ovmMdoZoR/gnnQ7K8ZJGp7Z1+BQpdhKKqD
 shqlydfessyxwVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEB6E13A39;
 Fri, 19 Sep 2025 16:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4xvFI/CAzWgFTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Sep 2025 16:12:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/4] migration: Do not try to start VM if disk
 activation fails
In-Reply-To: <20250915115918.3520735-2-jmarcin@redhat.com>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-2-jmarcin@redhat.com>
Date: Fri, 19 Sep 2025 13:12:30 -0300
Message-ID: <87segito9d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Juraj Marcin <jmarcin@redhat.com> writes:

> From: Peter Xu <peterx@redhat.com>
>
> If a rare split brain happens (e.g. dest QEMU started running somehow,
> taking shared drive locks), src QEMU may not be able to activate the
> drives anymore.  In this case, src QEMU shouldn't start the VM or it might
> crash the block layer later with something like:
>
> bdrv_co_write_req_prepare: Assertion `!(bs->open_flags &
> BDRV_O_INACTIVE)' failed.

This patch doesn't fix the assert, so I think it's best not to mention
it at all. We've had a few instances of this assert (or similar) and
there's a fair chance someone still looks at git log searching for a
backport.

>
> Meanwhile, src QEMU cannot try to continue either even if dest QEMU can
> release the drive locks (e.g. by QMP "stop").  Because as long as dest QEMU
> started running, it means dest QEMU's RAM is the only version that is
> consistent with current status of the shared storage.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..54dac3db88 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3502,6 +3502,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  
>  static void migration_iteration_finish(MigrationState *s)
>  {
> +    Error *local_err = NULL;
> +
>      bql_lock();
>  
>      /*
> @@ -3525,11 +3527,28 @@ static void migration_iteration_finish(MigrationState *s)
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
> -        /*
> -         * Re-activate the block drives if they're inactivated.  Note, COLO
> -         * shouldn't use block_active at all, so it should be no-op there.
> -         */
> -        migration_block_activate(NULL);
> +        if (!migration_block_activate(&local_err)) {
> +            /*
> +            * Re-activate the block drives if they're inactivated.

Comment formatting is wrong.

> +            *
> +            * If it fails (e.g. in case of a split brain, where dest QEMU
> +            * might have taken some of the drive locks and running!), do
> +            * not start VM, instead wait for mgmt to decide the next step.
> +            *
> +            * If dest already started, it means dest QEMU should contain
> +            * all the data it needs and it properly owns all the drive
> +            * locks.  Then even if src QEMU got a FAILED in migration, it
> +            * normally should mean we should treat the migration as
> +            * COMPLETED.
> +            *
> +            * NOTE: it's not safe anymore to start VM on src now even if
> +            * dest would release the drive locks.  It's because as long as
> +            * dest started running then only dest QEMU's RAM is consistent
> +            * with the shared storage.
> +            */
> +            error_free(local_err);
> +            break;
> +        }
>          if (runstate_is_live(s->vm_old_state)) {
>              if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>                  vm_start();

Reviewed-by: Fabiano Rosas <farosas@suse.de>

