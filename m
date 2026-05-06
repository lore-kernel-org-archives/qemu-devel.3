Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F440CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 20:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKjDQ-0004XP-C3; Wed, 06 May 2026 16:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKjDO-0004Wz-Il
 for qemu-devel@nongnu.org; Wed, 06 May 2026 16:51:30 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKjDM-0001Nk-7A
 for qemu-devel@nongnu.org; Wed, 06 May 2026 16:51:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9221B6BD7F;
 Wed,  6 May 2026 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778100683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1Ew1r5Fl0bkTQQueM3y44tlhWggbQy47IVbWt0KezU=;
 b=1XlqsDzsv8+40EjDXQTHTyYT440lADgDv1egJSXzuQM3pesnipRz4Ta0iEUPv2mVZzpGGX
 /e4dOk0ME/vRJDhjhLIWdVFYEWdybCQD4AP8W7rfMqMeLdQ/ID3ALjW+ri4z/Qk0iStLJ7
 3bF1vUmlmLysy8K7TPlt0nK05bFo/WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778100683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1Ew1r5Fl0bkTQQueM3y44tlhWggbQy47IVbWt0KezU=;
 b=/7w3NlQmqS1d0OAPSRGG9i1sbDmSNT+oeHMX4d7n9Y1s2qIYcLpFjOpGNOCO8YUB63gu9q
 lOB5/M3fjbf8EQCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778100682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1Ew1r5Fl0bkTQQueM3y44tlhWggbQy47IVbWt0KezU=;
 b=b5xAuFJIewMjxvHh93f8h4IY//BdD9+PsI4A4UWtF8LCmcZjlZCp9cXT5rKdA9RQBYnnRR
 glJXDQ4tk92vuepVCjUtszM5+REyD1phBqWK/+td4wchRlz2bYm0yquGcgZiGAMFCYvBft
 o8JuvDKnfQE/G28ojhjOlxRIQ/XKnh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778100682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1Ew1r5Fl0bkTQQueM3y44tlhWggbQy47IVbWt0KezU=;
 b=me64dBz67NwvZX5IpIEGoOdG41GuIFhNc8VUn7k1OgdI1TJc7KE9LnmkKpmU+tm7yOLgCr
 SZXMdox32talMzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32262593A3;
 Wed,  6 May 2026 20:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 84VwAcqp+2lHIgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 May 2026 20:51:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>, Ben
 Chaney <bchaney@akamai.com>, Juraj Marcin <jmarcin@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, Pranav Tyagi <prtyagi@redhat.com>, =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] migration: Fix crash on second migration when cancel early
In-Reply-To: <20260421175820.302795-1-peterx@redhat.com>
References: <20260421175820.302795-1-peterx@redhat.com>
Date: Wed, 06 May 2026 17:51:20 -0300
Message-ID: <87pl38xnw7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Sorry for taking too long on this, it fell off my queue. Looks good to
me. I reproduced the original issue and tested this patch under load
with hacked tests:

/mode/transfer/defer + early cancel
/cancel/src/after/setup + 2nd migrate

Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>

BTW, I found it weird that we cannot start a second migration on the
incoming after the first one having never properly started. Trying to
actually do it without shutting down both QEMUs was fun. A bunch of
asserts on the incoming side due to yank. After hacking a little and
using migrate_recover to start the second migration on the incoming, I
managed to make it work, but it hanged mid-transfer for some
reason. Probably some iochannel reset needed.

