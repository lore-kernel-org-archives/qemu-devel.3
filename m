Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DFAF9EDCD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXgT-0007Ch-Vg; Wed, 22 Apr 2026 09:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFXfq-0007AP-AW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:31:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFXfl-0000Ky-Tj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:31:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 097116A81C;
 Wed, 22 Apr 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776864669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsY66juZdA4eO/bL7Unwm/4BXmuMiyZqtBauxvGQ0b8=;
 b=LBLH4baBO1ZOMzXPK6MzhGSgQTcepgPZ13jSja98kYX4aUNCHhqySRZtDjP2/OTbSCY/Ql
 kEmMd9TGAJpu5MH9aUQ/6EXPCySt5Heso90oGZnpUFAyyHOW4JU36rTFYackb7klaG3XO9
 hbtUPJC52N8VGThOe8Juu0nCyFhi0io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776864669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsY66juZdA4eO/bL7Unwm/4BXmuMiyZqtBauxvGQ0b8=;
 b=xIH7z70tGPIctK21eGKn6u8fAOauJRs/nZxJfwE4lhtlhwsAgS2ekvh8Q1UCIhKhMqgm8U
 WIyXI87BOdM/i2DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LBLH4baB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xIH7z70t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776864669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsY66juZdA4eO/bL7Unwm/4BXmuMiyZqtBauxvGQ0b8=;
 b=LBLH4baBO1ZOMzXPK6MzhGSgQTcepgPZ13jSja98kYX4aUNCHhqySRZtDjP2/OTbSCY/Ql
 kEmMd9TGAJpu5MH9aUQ/6EXPCySt5Heso90oGZnpUFAyyHOW4JU36rTFYackb7klaG3XO9
 hbtUPJC52N8VGThOe8Juu0nCyFhi0io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776864669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsY66juZdA4eO/bL7Unwm/4BXmuMiyZqtBauxvGQ0b8=;
 b=xIH7z70tGPIctK21eGKn6u8fAOauJRs/nZxJfwE4lhtlhwsAgS2ekvh8Q1UCIhKhMqgm8U
 WIyXI87BOdM/i2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B6B5593AF;
 Wed, 22 Apr 2026 13:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vRHJGpzN6GmpKgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Apr 2026 13:31:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>, Ben
 Chaney <bchaney@akamai.com>, Juraj Marcin <jmarcin@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, Pranav Tyagi <prtyagi@redhat.com>, =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] migration: Fix crash on second migration when cancel early
In-Reply-To: <20260421175820.302795-1-peterx@redhat.com>
References: <20260421175820.302795-1-peterx@redhat.com>
Date: Wed, 22 Apr 2026 10:31:06 -0300
Message-ID: <87wlxzdsv9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 097116A81C
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> Marc-Andr=C3=A9 reported an issue on QEMU crash when retrying a cancelled
> migration during early setup phase, see "Link:" for more information, and
> also easy way to reproduce.
>
> This patch is a replacement of the prior fix proposed by not only switchi=
ng
> to migration_cleanup(), but also fixing it from CPR side, so that we track
> hup_source properly to know if src QEMU is waiting or the HUP signal.
>
> To put it simple: this chunk of special casing in migration_cancel() shou=
ld
> not affect normal migration, but only cpr-transfer migration to cover the
> small window when the src QEMU is waiting for a HUP signal on cpr
> channel (so that src QEMU can continue the migration on the main channel).
>
> To achieve that, we'll also need to remember to detach the hup_source
> whenenver invoked: after that point, we should always be able to cleanup
> the migration.
>
> It's not a generic operation to explicitly detach a gsource from its
> context while in its dispatch() function.  But it should be safe, because
> gsource disptch() will only happen with a boosted refcount for the
> dispatcher so that the gsource will not be freed until the callback
> completes. It's also safe to return G_SOURCE_REMOVE after the gsource is
> detached, as glib will simply ignore the G_SOURCE_REMOVE.
>
> One can refer to latest 2.86.5 glib code in g_main_dispatch() for that:
>
> https://github.com/GNOME/glib/blob/2.86.5/glib/gmain.c#L3592
>
> When at this, add a bunch of assertions to make sure nothing surprises us.
>
> After this patch applied, the 2nd migration will not crash QEMU, instead
> it'll be in CANCELLING until the socket connection times out (it will take
> ~2min on my Fedora default kernel).  During this process no 2nd migration
> will be allowed, and after it timed out migration can be restarted.
>
> It's because so far we don't have control over socket_connect_outgoing(),
> or anything yet managed by a task executed in qio_task_run_in_thread().
> Speeding up the cancellation to be left for future.
>
> I also tested cpr-transfer by only providing cpr channel not the main
> channel (with -incoming defer), kickoff migration on source, then cancel =
it
> on source directly without providing the main channel.  It keeps working.
>
> I wanted to add an unit test for that but it'll need to refactor current
> cpr-transfer tests first; let's leave it for later.
>
> Link: https://lore.kernel.org/r/20260417184742.293061-1-marcandre.lureau@=
redhat.com
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/cpr.h  |  1 +
>  migration/migration.h    |  5 +++++
>  migration/cpr-transfer.c | 10 ++++++++++
>  migration/migration.c    | 31 +++++++++++++++++++++++--------
>  4 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 5850fd1788..ebf09a2f0a 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -57,6 +57,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel,=
 Error **errp);
>  void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
>                                  void *opaque);
>  void cpr_transfer_source_destroy(MigrationState *s);
> +bool cpr_transfer_source_active(MigrationState *s);
>=20=20
>  void cpr_exec_init(void);
>  QEMUFile *cpr_exec_output(Error **errp);
> diff --git a/migration/migration.h b/migration/migration.h
> index b6888daced..2bc2787480 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -514,6 +514,11 @@ struct MigrationState {
>      bool postcopy_package_loaded;
>      QemuEvent postcopy_package_loaded_event;
>=20=20
> +    /*
> +     * When set, it means cpr-transfer is waiting for the HUP signal from
> +     * destination to continue the 2nd step of migration via the main
> +     * channel.
> +     */
>      GSource *hup_source;
>=20=20
>      /*
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index 61d5c9dce2..9defe7bad7 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -6,6 +6,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-migration.h"
> @@ -79,6 +80,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel,=
 Error **errp)
>  void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
>                                  void *opaque)
>  {
> +    assert(bql_locked());
>      s->hup_source =3D qio_channel_create_watch(cpr_state_ioc(), G_IO_HUP=
);

Before I review the patch in detail, let me just make a high level
comment here:

I wonder if we should have a "register" in the iochannel layer for the
several watches we create. So we could at migration_cancel time call
g_clear_handle/g_source_destroy on all at the same time. The management
of these source ids is getting too particular.

I'm seeing that exec, fd and file migration all ignore the id returned
by channel-watch.c. In the case of exec this is causing
qio_channel_command_finalize() to be skipped, leaving the exec'ed
command process behind! So what I did as an experiment was to register
watches like this:

  static inline void migration_watch_data(void) {};
=20=20
  qio_channel_add_watch_full(ioc, G_IO_IN, exec_accept_incoming_migration,
                             migration_watch_data, NULL,
                             g_main_context_get_thread_default());

and at migrate_cancel():

  while(g_source_remove_by_user_data(migration_watch_data));

It feels to me that a wrapper around this, or even a hashtable of "func
ptr->GSource" or "str->GSource id" would allow us to call a (say)
qio_channel_clear_watches() and avoid having to do the management in
each of the clients.

We already have stuff like IOWatchPoll which kind of already wraps the
watch creation in a sense.

>      g_source_set_callback(s->hup_source,
>                            (GSourceFunc)func,
> @@ -89,9 +91,17 @@ void cpr_transfer_add_hup_watch(MigrationState *s, QIO=
ChannelFunc func,
>=20=20
>  void cpr_transfer_source_destroy(MigrationState *s)
>  {
> +    assert(bql_locked());
>      if (s->hup_source) {
>          g_source_destroy(s->hup_source);
>          g_source_unref(s->hup_source);
>          s->hup_source =3D NULL;
>      }
>  }
> +
> +bool cpr_transfer_source_active(MigrationState *s)
> +{
> +    /* Whenever the HUP gsource is available, it's active. */
> +    assert(bql_locked());
> +    return s->hup_source;
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c9aaa6e58..58c1e56766 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1469,14 +1469,19 @@ void migration_cancel(void)
>      }
>=20=20
>      /*
> -     * If migration_connect_outgoing has not been called, then there
> -     * is no path that will complete the cancellation. Do it now.
> -     */
> -    if (setup && !s->to_dst_file) {
> -        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
> -                          MIGRATION_STATUS_CANCELLED);
> -        cpr_state_close();
> -        cpr_transfer_source_destroy(s);
> +     * This is cpr-transfer specific processing.
> +     *
> +     * If this is true, it means cpr-transfer migration is waiting for t=
he
> +     * destination to send HUP event on CPR channel to continue the next
> +     * phase.  If so, do the cleanup proactively to avoid get stuck in
> +     * CANCELLING state.
> +     */
> +    if (cpr_transfer_source_active(s)) {
> +        assert(migrate_mode() =3D=3D MIG_MODE_CPR_TRANSFER);
> +        assert(setup && !s->to_dst_file);
> +        migration_cleanup(s);
> +        /* Now all things should have been released */
> +        assert(!cpr_transfer_source_active(s));
>      }
>  }
>=20=20
> @@ -2009,12 +2014,22 @@ static gboolean migration_connect_outgoing_cb(QIO=
Channel *channel,
>      MigrationState *s =3D migrate_get_current();
>      Error *local_err =3D NULL;
>=20=20
> +    /*
> +     * Detach and release the GSource right after use.  We rely on this =
to
> +     * detect this small cpr-transfer window of "waiting for HUP event".
> +     */
> +    cpr_transfer_source_destroy(s);
> +
>      migration_connect_outgoing(s, opaque, &local_err);
>=20=20
>      if (local_err) {
>          migration_connect_error_propagate(s, local_err);
>      }
>=20=20
> +    /*
> +     * This is redundant as we do cpr_transfer_source_destroy() at the
> +     * entry, but it's benign; glib will just skip the detach.
> +     */
>      return G_SOURCE_REMOVE;
>  }

