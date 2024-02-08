Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D8BC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 13:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY4TE-0005xe-Ds; Thu, 08 Feb 2024 08:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY4TC-0005xE-RH
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:29:38 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY4TB-0002Hy-39
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:29:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 567CA21F8D;
 Thu,  8 Feb 2024 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707398975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/L4EO7m720G9JNwpCafm/bl3QGEm5EHRlJhEuWbisA=;
 b=aIgHUE8fJrlRh1N68vk9M4XtJlXQou3Z88s/0PAfMPNctyNi6SMsRtZRNRkQPlyfTGx813
 WqXKJ1TBG6/SbduCXRmbVkJEzrknFCkH85Ko0fE/InTMBm1a+cM68DqCugfomq55QU86Z9
 Btmalsj8wU1P2y9Nb+lkcL78tR1V+Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707398975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/L4EO7m720G9JNwpCafm/bl3QGEm5EHRlJhEuWbisA=;
 b=Z3bbIdmpUQjrZ/pR3ievuct9QhX9xHLapHt0s8+v43Bs2TKI052okVOdBhMMI56vnut/W/
 Fz0+uF1lKfxYcrAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707398975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/L4EO7m720G9JNwpCafm/bl3QGEm5EHRlJhEuWbisA=;
 b=aIgHUE8fJrlRh1N68vk9M4XtJlXQou3Z88s/0PAfMPNctyNi6SMsRtZRNRkQPlyfTGx813
 WqXKJ1TBG6/SbduCXRmbVkJEzrknFCkH85Ko0fE/InTMBm1a+cM68DqCugfomq55QU86Z9
 Btmalsj8wU1P2y9Nb+lkcL78tR1V+Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707398975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/L4EO7m720G9JNwpCafm/bl3QGEm5EHRlJhEuWbisA=;
 b=Z3bbIdmpUQjrZ/pR3ievuct9QhX9xHLapHt0s8+v43Bs2TKI052okVOdBhMMI56vnut/W/
 Fz0+uF1lKfxYcrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B6013984;
 Thu,  8 Feb 2024 13:29:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CXohJz7XxGVTVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 Feb 2024 13:29:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
In-Reply-To: <20240207133347.1115903-15-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com>
Date: Thu, 08 Feb 2024 10:29:32 -0300
Message-ID: <87v86zaxtv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aIgHUE8f;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z3bbIdmp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 567CA21F8D
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> In case of error, close_return_path_on_source() can perform a shutdown
> to exit the return-path thread.  However, in migrate_fd_cleanup(),
> 'to_dst_file' is closed before calling close_return_path_on_source()
> and the shutdown fails, leaving the source and destination waiting for
> an event to occur.

Hi, C=C3=A9dric

Are you sure this is not caused by patch 13? That 'if (ms->to_dst_file'
was there to avoid this sort of thing happening.

Is there some reordering possibility that I'm not spotting in the code
below? I think the data dependency on to_dst_file shouldn't allow it.

migrate_fd_cleanup:
        qemu_mutex_lock(&s->qemu_file_lock);
        tmp =3D s->to_dst_file;
        s->to_dst_file =3D NULL;
        qemu_mutex_unlock(&s->qemu_file_lock);
        ...
        qemu_fclose(tmp);

close_return_path_on_source:
    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
            qemu_file_get_error(ms->to_dst_file)) {
            qemu_file_shutdown(ms->rp_state.from_dst_file);
        }
    }

I'm thinking maybe the culprit is the close_return_path_on_source() at
migration_completion(). It might be possible for it to race with the
migrate_fd_cleanup_bh from migration_iteration_finish().

If that's the case, then I think that one possible fix would be to hold
the BQL at migration_completion() so the BH doesn't get dispatched until
we properly close the return path.

>
> Close the file after calling close_return_path_on_source() so that the
> shutdown succeeds and the return-path thread exits.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>
>  This is an RFC because the correct fix implies reworking the QEMUFile
>  construct, built on top of the QEMU I/O channel.
>
>  migration/migration.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 5f55af3d7624750ca416c4177781241b3e291e5d..de329f2c553288935d8247482=
86e79e535929b8b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1313,6 +1313,8 @@ void migrate_set_state(int *state, int old_state, i=
nt new_state)
>=20=20
>  static void migrate_fd_cleanup(MigrationState *s)
>  {
> +    QEMUFile *tmp =3D NULL;
> +
>      g_free(s->hostname);
>      s->hostname =3D NULL;
>      json_writer_free(s->vmdesc);
> @@ -1321,8 +1323,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>      qemu_savevm_state_cleanup();
>=20=20
>      if (s->to_dst_file) {
> -        QEMUFile *tmp;
> -
>          trace_migrate_fd_cleanup();
>          bql_unlock();
>          if (s->migration_thread_running) {
> @@ -1341,15 +1341,14 @@ static void migrate_fd_cleanup(MigrationState *s)
>           * critical section won't block for long.
>           */
>          migration_ioc_unregister_yank_from_file(tmp);
> -        qemu_fclose(tmp);
>      }
>=20=20
> -    /*
> -     * We already cleaned up to_dst_file, so errors from the return
> -     * path might be due to that, ignore them.
> -     */
>      close_return_path_on_source(s);
>=20=20
> +    if (tmp) {
> +        qemu_fclose(tmp);
> +    }
> +
>      assert(!migration_is_active(s));
>=20=20
>      if (s->state =3D=3D MIGRATION_STATUS_CANCELLING) {

