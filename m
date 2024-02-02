Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F94C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVukM-0004F1-T2; Fri, 02 Feb 2024 09:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVukK-0004EC-Pq
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:42:24 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVukJ-0006cq-78
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:42:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72B8921F49;
 Fri,  2 Feb 2024 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706884941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XByFp0tN1lhC2tz96rcg5uagoABY6WaXAQKzaeoA+fU=;
 b=1RwgAQSEmMH5HrQ0tEVmgtpkJqaDJx9Vgf5NVugFMRZtf3f/wYY3UBQmslrzdpZAWPyzO7
 gxJ5WT3OnTFA8R5oXm7SmHBfZ/ZdGag0i3TpsuWlIsgMsvlnnufny7jBGjsASWvOCjBW0h
 nhE7vF6xvNBWW0alP4o81Go7+MuIKM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706884941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XByFp0tN1lhC2tz96rcg5uagoABY6WaXAQKzaeoA+fU=;
 b=l2Fa33B3QtkilOZ/fBRstgPoLVucHHkhpNiGIO9qCeOrqDr0e8z1X3JUd/Vv0PnV4HJ9C6
 DtfY2mi7QFkpGoDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706884941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XByFp0tN1lhC2tz96rcg5uagoABY6WaXAQKzaeoA+fU=;
 b=1RwgAQSEmMH5HrQ0tEVmgtpkJqaDJx9Vgf5NVugFMRZtf3f/wYY3UBQmslrzdpZAWPyzO7
 gxJ5WT3OnTFA8R5oXm7SmHBfZ/ZdGag0i3TpsuWlIsgMsvlnnufny7jBGjsASWvOCjBW0h
 nhE7vF6xvNBWW0alP4o81Go7+MuIKM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706884941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XByFp0tN1lhC2tz96rcg5uagoABY6WaXAQKzaeoA+fU=;
 b=l2Fa33B3QtkilOZ/fBRstgPoLVucHHkhpNiGIO9qCeOrqDr0e8z1X3JUd/Vv0PnV4HJ9C6
 DtfY2mi7QFkpGoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E791913A58;
 Fri,  2 Feb 2024 14:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wDY6K0z/vGV+JAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 14:42:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 2/2] migration: Fix return-path thread exit
In-Reply-To: <20240201184853.890471-3-clg@redhat.com>
References: <20240201184853.890471-1-clg@redhat.com>
 <20240201184853.890471-3-clg@redhat.com>
Date: Fri, 02 Feb 2024 11:42:18 -0300
Message-ID: <8734ubhqr9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.66 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.56)[98.02%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

At close_return_path_on_source, qemu_file_shutdown() and checking
ms->to_dst_file are done under the qemu_file_lock, so how could
migrate_fd_cleanup() have cleared the pointer but the ms->to_dst_file
check have passed?

>
> Close the file after calling close_return_path_on_source() so that the
> shutdown succeeds and the return-path thread exits.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  migration/migration.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 2c3362235c7651c11d581f3c3639571f1f9636ef..1e0b6acaedc272e8ce26ad40b=
e2c42177f5fd14e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1314,6 +1314,7 @@ void migrate_set_state(int *state, int old_state, i=
nt new_state)
>  static void migrate_fd_cleanup(MigrationState *s)
>  {
>      int file_error =3D 0;
> +    QEMUFile *tmp =3D NULL;
>=20=20
>      g_free(s->hostname);
>      s->hostname =3D NULL;
> @@ -1323,8 +1324,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>      qemu_savevm_state_cleanup();
>=20=20
>      if (s->to_dst_file) {
> -        QEMUFile *tmp;
> -
>          trace_migrate_fd_cleanup();
>          bql_unlock();
>          if (s->migration_thread_running) {
> @@ -1344,15 +1343,14 @@ static void migrate_fd_cleanup(MigrationState *s)
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
>      close_return_path_on_source(s, file_error);
>=20=20
> +    if (tmp) {
> +        qemu_fclose(tmp);
> +    }
> +
>      assert(!migration_is_active(s));
>=20=20
>      if (s->state =3D=3D MIGRATION_STATUS_CANCELLING) {

