Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011C2D3A68D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5rYk-00034J-8B; Tue, 29 Oct 2024 15:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rYf-00033y-Sq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:07:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rYe-0002Ro-23
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:07:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4986C21EF9;
 Tue, 29 Oct 2024 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730228830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xa9cSuLliqoPth5906kJAy5SeAA/E2vZ8yH/rAx77LY=;
 b=vdRPtNXwj5LItiAEtU/7rcp0yugFWsZoZPpj1RzQ2N2HorVHtTWOESd821S3UmWQtNBCoL
 vi/5ghEDmJaUbhtATAk4DGyTETzJhdTVHGMT/X4hqz79LwI72L248cDojtoV6lW7dsf4wo
 MmIQW2szzUE3yih7zO1kyBJmLJep0qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730228830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xa9cSuLliqoPth5906kJAy5SeAA/E2vZ8yH/rAx77LY=;
 b=iK7u4Y6OYB+BHtPbrujq42/c8LGcY4/u1YDnUnNE5oYOaCx3J+vJh+MHroSKCklFxTtTSb
 NCK/WHuWBASPZPDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730228830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xa9cSuLliqoPth5906kJAy5SeAA/E2vZ8yH/rAx77LY=;
 b=vdRPtNXwj5LItiAEtU/7rcp0yugFWsZoZPpj1RzQ2N2HorVHtTWOESd821S3UmWQtNBCoL
 vi/5ghEDmJaUbhtATAk4DGyTETzJhdTVHGMT/X4hqz79LwI72L248cDojtoV6lW7dsf4wo
 MmIQW2szzUE3yih7zO1kyBJmLJep0qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730228830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xa9cSuLliqoPth5906kJAy5SeAA/E2vZ8yH/rAx77LY=;
 b=iK7u4Y6OYB+BHtPbrujq42/c8LGcY4/u1YDnUnNE5oYOaCx3J+vJh+MHroSKCklFxTtTSb
 NCK/WHuWBASPZPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C45A9136A5;
 Tue, 29 Oct 2024 19:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ulh3Il0yIWcQUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 29 Oct 2024 19:07:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 5/8] migration: Drop migration_is_idle()
In-Reply-To: <20241024213056.1395400-6-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-6-peterx@redhat.com>
Date: Tue, 29 Oct 2024 16:07:07 -0300
Message-ID: <87ttcubuec.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

> Now with the current migration_is_running(), it will report exactly the
> opposite of what will be reported by migration_is_idle().
>
> Drop migration_is_idle(), instead use "!migration_is_running()" which
> should be identical on functionality.
>
> In reality, most of the idle check is inverted, so it's even easier to
> write with "migrate_is_running()" check.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h |  1 -
>  hw/virtio/virtio-mem.c   |  2 +-
>  migration/migration.c    | 21 +--------------------
>  migration/ram.c          |  2 +-
>  system/qdev-monitor.c    |  4 ++--
>  5 files changed, 5 insertions(+), 25 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 86ef160f19..804eb23c06 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>  void migration_object_init(void);
>  void migration_shutdown(void);
>  
> -bool migration_is_idle(void);
>  bool migration_is_active(void);
>  bool migration_is_device(void);
>  bool migration_is_running(void);
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index ae1e81d7ba..80ada89551 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -188,7 +188,7 @@ static bool virtio_mem_is_busy(void)
>       * after plugging them) until we're running on the destination (as we didn't
>       * migrate these blocks when they were unplugged).
>       */
> -    return migration_in_incoming_postcopy() || !migration_is_idle();
> +    return migration_in_incoming_postcopy() || migration_is_running();
>  }
>  
>  typedef int (*virtio_mem_range_cb)(VirtIOMEM *vmem, void *arg,
> diff --git a/migration/migration.c b/migration/migration.c
> index 3365195def..f86c709699 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1636,25 +1636,6 @@ bool migration_in_bg_snapshot(void)
>      return migrate_background_snapshot() && migration_is_running();
>  }
>  
> -bool migration_is_idle(void)
> -{
> -    MigrationState *s = current_migration;
> -
> -    if (!s) {
> -        return true;
> -    }
> -
> -    switch (s->state) {
> -    case MIGRATION_STATUS_NONE:
> -    case MIGRATION_STATUS_CANCELLED:
> -    case MIGRATION_STATUS_COMPLETED:
> -    case MIGRATION_STATUS_FAILED:
> -        return true;
> -    default:
> -        return false;
> -    }
> -}
> -
>  bool migration_is_active(void)
>  {
>      MigrationState *s = current_migration;
> @@ -1733,7 +1714,7 @@ static bool is_busy(Error **reasonp, Error **errp)
>      ERRP_GUARD();
>  
>      /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
> -    if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
> +    if (runstate_check(RUN_STATE_SAVE_VM) || migration_is_running()) {
>          error_propagate_prepend(errp, *reasonp,
>                                  "disallowing migration blocker "
>                                  "(migration/snapshot in progress) for: ");
> diff --git a/migration/ram.c b/migration/ram.c
> index 5646a0b882..504b48d584 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4498,7 +4498,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
>          return;
>      }
>  
> -    if (!migration_is_idle()) {
> +    if (migration_is_running()) {
>          /*
>           * Precopy code on the source cannot deal with the size of RAM blocks
>           * changing at random points in time - especially after sending the
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 1310f35c9f..83fa684475 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -686,7 +686,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>          return NULL;
>      }
>  
> -    if (!migration_is_idle()) {
> +    if (migration_is_running()) {
>          error_setg(errp, "device_add not allowed while migrating");
>          return NULL;
>      }
> @@ -935,7 +935,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
> +    if (migration_is_running() && !dev->allow_unplug_during_migration) {
>          error_setg(errp, "device_del not allowed while migrating");
>          return;
>      }

Good.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

