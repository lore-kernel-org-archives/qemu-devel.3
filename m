Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D53E7316D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu1Y-0005tb-Be; Mon, 02 Feb 2026 08:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmu1S-0005t4-EZ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:31:23 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmu1Q-0002Jd-OY
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:31:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79A633E734;
 Mon,  2 Feb 2026 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770039077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L6iY7ObJ7mP2I67j/FLppjdriKg+kykQQZ5IeZLuoOM=;
 b=iQcaJ6iqeCU1crgFEY//ySJjqgzKd2YDYECjWrk061ebltEjplnD+SZKV3Td5aHCLjL30a
 0sVjlfnWbGY+uwhkRRRw0FqdtNMo9tclHo8NBZQCbizLmOevJtwqdEbXSIqhKDrN/x6dN9
 XP34Y35Tg5I5bTdK/8/rpITiOCwovLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770039077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L6iY7ObJ7mP2I67j/FLppjdriKg+kykQQZ5IeZLuoOM=;
 b=zGWrpesLZU9QOu8X4rENu5I3gBgdblCMgnGbQVY2AJGNTyvhVddEkQ0F5/V9GJdBbl1TaF
 9gTDCzyA8w9jAcDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770039077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L6iY7ObJ7mP2I67j/FLppjdriKg+kykQQZ5IeZLuoOM=;
 b=iQcaJ6iqeCU1crgFEY//ySJjqgzKd2YDYECjWrk061ebltEjplnD+SZKV3Td5aHCLjL30a
 0sVjlfnWbGY+uwhkRRRw0FqdtNMo9tclHo8NBZQCbizLmOevJtwqdEbXSIqhKDrN/x6dN9
 XP34Y35Tg5I5bTdK/8/rpITiOCwovLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770039077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L6iY7ObJ7mP2I67j/FLppjdriKg+kykQQZ5IeZLuoOM=;
 b=zGWrpesLZU9QOu8X4rENu5I3gBgdblCMgnGbQVY2AJGNTyvhVddEkQ0F5/V9GJdBbl1TaF
 9gTDCzyA8w9jAcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D92ED3EA62;
 Mon,  2 Feb 2026 13:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIdUJiSngGkOVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 13:31:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>, =?utf-8?Q?Daniel_P=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan
 <hamza.khan@nutanix.com>, Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt
 <johunt@akamai.com>, Max Tottenham <mtottenh@akamai.com>, Ben Chaney
 <bchaney@akamai.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v4 1/8] migration: stop vm earlier for cpr
In-Reply-To: <20260128-cpr-tap-v4-1-48e334d4216b@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <20260128-cpr-tap-v4-1-48e334d4216b@akamai.com>
Date: Mon, 02 Feb 2026 10:31:14 -0300
Message-ID: <87wm0vs259.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Ben Chaney <bchaney@akamai.com> writes:

> From: Steve Sistare <steven.sistare@oracle.com>
>
> Stop the vm earlier for cpr, before cpr_save_state which causes new QEMU
> to proceed and initialize devices.  We must guarantee devices are stopped
> in old QEMU, and all source notifiers called, before they are initialized
> in new QEMU.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> ---
>  migration/migration.c | 57 +++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 1bcde301f7..f36e59d9e8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1654,6 +1654,7 @@ void migration_cancel(void)
>                            MIGRATION_STATUS_CANCELLED);
>          cpr_state_close();
>          migrate_hup_delete(s);
> +        vm_resume(s->vm_old_state);
>      }
>  }
>  
> @@ -2212,6 +2213,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>      MigrationAddress *addr = NULL;
>      MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>      MigrationChannel *cpr_channel = NULL;
> +    bool stopped = false;
>  

This is not needed anymore, all cleanup now happens after
migration_connect_error_propagate -> migration_cleanup.

>      /*
>       * Having preliminary checks for uri and channel
> @@ -2264,6 +2266,46 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    /*
> +     * CPR-transfer  ordering:
> +     *
> +     *   SOURCE                              TARGET
> +     *   ------                              ------
> +     *                                       cpr_state_load() blocks
> +     *   |                                        |
> +     *   |  1. migration_stop_vm()                |
> +     *   |     VM stopped, devices quiesced       |
> +     *   |                                        | Waiting for
> +     *   |  2. notifiers (PRECOPY_SETUP)          | FDs from source
> +     *   |     vhost_reset_owner() releases       |
> +     *   |     device ownership                   |

Patch 2 should come before, then. Otherwise this is not accurate.

> +     *   |                                        |
> +     *   |  3. cpr_state_save() ---- FDs -------> |
> +     *   |                                        |
> +     *   v                                        v
> +     *   postmigrate                         Device init begins
> +     *                                       - cpr_find_fd()
> +     *                                       - vhost_dev_init()
> +     *                                       - VHOST_SET_OWNER
> +     *
> +     * Step 3 is the synchronization/cut-over point. Target proceeds immediately
> +     * upon receiving FDs, so steps 1-2 must complete otherwise:
> +     * - Target's VHOST_SET_OWNER fails with -EBUSY (source still owns)
> +     * - Race between source I/O and target device init
> +     *
> +     *  We stop the VM early (before FD transfer) to prevent this race.
> +     *  Unlike regular migration, CPR-transfer passes memory via FD (memfd)
> +     *  rather than copying RAM, so early VM stop should have minimal downtime.
> +     */
> +    if (migrate_mode_is_cpr(s)) {
> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> +        if (ret < 0) {
> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> +            goto out;
> +        }
> +        stopped = true;
> +    }
> +
>      if (!cpr_state_save(cpr_channel, &local_err)) {
>          goto out;
>      }
> @@ -2290,6 +2332,9 @@ out:
>      if (local_err) {
>          migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
> +        if (stopped) {
> +            vm_resume(s->vm_old_state);
> +        }

This resume should now happen at migration_cleanup.

>      }
>  }
>  
> @@ -2334,6 +2379,9 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>          }
>          migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
> +        if (migrate_mode_is_cpr(s)) {
> +            vm_resume(s->vm_old_state);
> +        }

Same here.

>          return;
>      }
>  }
> @@ -4017,7 +4065,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      Error *local_err = NULL;
>      uint64_t rate_limit;
>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
> -    int ret;
>  
>      /*
>       * If there's a previous error, free it and prepare for another one.
> @@ -4088,14 +4135,6 @@ void migration_connect(MigrationState *s, Error *error_in)
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
>      /*
>       * Take a refcount to make sure the migration object won't get freed by
>       * the main thread already in migration_shutdown().

