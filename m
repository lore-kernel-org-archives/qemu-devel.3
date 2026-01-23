Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64251D74EC2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGob-0002ui-Cp; Fri, 23 Jan 2026 08:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGlL-0001GN-QJ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:59:49 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGlJ-0005SR-7B
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:59:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BD875BCD4;
 Fri, 23 Jan 2026 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769173178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNXdz38m3Os5+CJzOZVYB1v8BDs7xEChJW4gRK8XftI=;
 b=r4l305gJeG9EYvdJ1JVWJiMdbYaLN7Z8FhwTr71vB1ZcOcKzRwnZeV9rDqAyazpEZQWwAg
 oRGxrv+cxR9nUovogosxKastSIySK48sAShnRExe+gD5NyRd6rPUYBZ3P0wHAip9p0tqSn
 tKF3kw+DfIuAPrrr+98N3ctQwYx1SpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769173178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNXdz38m3Os5+CJzOZVYB1v8BDs7xEChJW4gRK8XftI=;
 b=QyM2InHS6UKny8fLF7uQsKzRJtJp3KxX4AoWJzogiSkiNaIBYCanxnHHsl1GYLDc1QNKE5
 +uzSgC6E0G6CY0Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r4l305gJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QyM2InHS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769173178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNXdz38m3Os5+CJzOZVYB1v8BDs7xEChJW4gRK8XftI=;
 b=r4l305gJeG9EYvdJ1JVWJiMdbYaLN7Z8FhwTr71vB1ZcOcKzRwnZeV9rDqAyazpEZQWwAg
 oRGxrv+cxR9nUovogosxKastSIySK48sAShnRExe+gD5NyRd6rPUYBZ3P0wHAip9p0tqSn
 tKF3kw+DfIuAPrrr+98N3ctQwYx1SpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769173178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNXdz38m3Os5+CJzOZVYB1v8BDs7xEChJW4gRK8XftI=;
 b=QyM2InHS6UKny8fLF7uQsKzRJtJp3KxX4AoWJzogiSkiNaIBYCanxnHHsl1GYLDc1QNKE5
 +uzSgC6E0G6CY0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D01E3136AA;
 Fri, 23 Jan 2026 12:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kcniI7lwc2lETQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 12:59:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 3/5] migration: Notify migration FAILED before starting VM
In-Reply-To: <20260122230331.3543312-4-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-4-peterx@redhat.com>
Date: Fri, 23 Jan 2026 09:59:35 -0300
Message-ID: <874iocjxhk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6BD875BCD4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> Devices may opt-in migration FAILED notifiers to be invoked when migration
> fails.  Currently, the notifications happen in migration_cleanup().  It is
> normally fine, but maybe not ideal if there's dependency of the fallback
> v.s. VM starts.
>
> This patch moves the FAILED notification earlier, so that if the failure
> happened during switchover, it'll notify before VM restart.
>

The change to FAILED in patch 2 should come to this patch to avoid
having a window where the notification only happens at the end.

> After walking over all existing FAILED notifier users, I got the conclusi=
on
> that this should also be a cleaner approach at least from design POV.
>
> We have these notifier users, where the first two do not need to trap
> FAILED:
>
> |----------------------------+-------------------------------------+-----=
----------------|
> | device                     | handler                             | even=
ts needed       |
> |----------------------------+-------------------------------------+-----=
----------------|
> | gicv3                      | kvm_arm_gicv3_notifier              | DONE=
                |
> | vfio_iommufd / vfio_legacy | vfio_cpr_reboot_notifier            | SETU=
P               |
> | cpr-exec                   | cpr_exec_notifier                   | FAIL=
ED, DONE        |
> | virtio-net                 | virtio_net_migration_state_notifier | SETU=
P, FAILED       |
> | vfio                       | vfio_migration_state_notifier       | FAIL=
ED              |
> | vdpa                       | vdpa_net_migration_state_notifier   | SETU=
P, FAILED       |
> | spice [*]                  | migration_state_notifier            | SETU=
P, FAILED, DONE |
> |----------------------------+-------------------------------------+-----=
----------------|
>
> For cpr-exec, it tries to cleanup some cpr-exec specific fd or env
> variables.  This should be fine either way, as long as before
> migration_cleanup().
>
> For virtio-net, we need to re-plug the primary device back to guest in the
> failover mode.  Likely benign.
>
> VFIO needs to re-start the device if FAILED.  IIUC it should do it before
> vm_start(), if the VFIO device can be put into a STOPed state due to
> migration, we should logically make it running again before vCPUs run.
>
> VDPA will disable SVQ when migration is FAILED.  Likely benign too, but
> looks better if we can do it before resuming vCPUs.
>
> For spice, we should rely on "spice_server_migrate_end(false)" to retake
> the ownership.  Benign, but looks more reasonable if the spice client does
> it before VM runs again.
>
> Note that this change may introduce slightly more downtime, if the
> migration failed exactly at the switchover phase.  But that's very rare,
> and even if it happens, none of above expects a long delay, but a short
> one, likely will be buried in the total downtime even if failed.
>
> Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 91775f8472..1d9a2fc068 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1481,7 +1481,6 @@ static void migration_cleanup_json_writer(Migration=
State *s)
>=20=20
>  static void migration_cleanup(MigrationState *s)
>  {
> -    MigrationEventType type;
>      QEMUFile *tmp =3D NULL;
>=20=20
>      trace_migration_cleanup();
> @@ -1535,9 +1534,15 @@ static void migration_cleanup(MigrationState *s)
>          /* It is used on info migrate.  We can't free it */
>          error_report_err(error_copy(s->error));
>      }
> -    type =3D migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
> -                                     MIG_EVENT_PRECOPY_DONE;
> -    migration_call_notifiers(s, type, NULL);
> +
> +    /*
> +     * FAILED notification should have already happened.  Notify DONE if
> +     * migration completed successfully.
> +     */
> +    if (!migration_has_failed(s)) {
> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_DONE, NULL);
> +    }
> +
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
>=20=20
> @@ -3589,6 +3594,13 @@ static void migration_iteration_finish(MigrationSt=
ate *s)
>              error_free(local_err);
>              break;
>          }
> +
> +        /*
> +         * Notify FAILED before starting VM, so that devices can invoke
> +         * necessary fallbacks before vCPUs run again.
> +         */
> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> +
>          if (runstate_is_live(s->vm_old_state)) {
>              if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>                  vm_start();

