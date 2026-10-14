Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F6CCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6sx-0007oO-VZ; Wed, 14 Oct 2026 17:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH6sx-0007oE-2V
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:51:43 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH6sv-0004lO-IS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:51:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A7311F7D2;
 Wed, 14 Oct 2026 21:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792014700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwnpv0U/OsjpCU4qnLqb07ATmSw/cb+w5+21PNonANs=;
 b=bKMaWNPqvNeNgxgUWKuhV8FNTcrAHM8rMuFSW+eqMj96OSvmtLW1LNJV0tOYMqNF2NxNAm
 /zmTb5Up5GmtGonRzG3uimkYnvVZ5PjG5Y8eH+e/1G8QJXyMpgWVo/XPLx8qgnPQep2Ylh
 jEMa9X9yz+lxzASE6Jr2GeZVTOFeEA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792014700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwnpv0U/OsjpCU4qnLqb07ATmSw/cb+w5+21PNonANs=;
 b=JyY8xb4l1dFKKo1jga3olWGeLQiGBik2g7YEQHbmvMFyZiizbUJOf4lWHZoyiL9ewRIH7h
 +DFqcdyT9+QqwnBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bKMaWNPq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JyY8xb4l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792014700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwnpv0U/OsjpCU4qnLqb07ATmSw/cb+w5+21PNonANs=;
 b=bKMaWNPqvNeNgxgUWKuhV8FNTcrAHM8rMuFSW+eqMj96OSvmtLW1LNJV0tOYMqNF2NxNAm
 /zmTb5Up5GmtGonRzG3uimkYnvVZ5PjG5Y8eH+e/1G8QJXyMpgWVo/XPLx8qgnPQep2Ylh
 jEMa9X9yz+lxzASE6Jr2GeZVTOFeEA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792014700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwnpv0U/OsjpCU4qnLqb07ATmSw/cb+w5+21PNonANs=;
 b=JyY8xb4l1dFKKo1jga3olWGeLQiGBik2g7YEQHbmvMFyZiizbUJOf4lWHZoyiL9ewRIH7h
 +DFqcdyT9+QqwnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 658541368E;
 Wed, 14 Oct 2026 21:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dRUfA2v5z2p6YgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Oct 2026 21:51:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 3/7] migration: Fix socket listen backlog
In-Reply-To: <20261006182046.3767283-4-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-4-peterx@redhat.com>
Date: Wed, 14 Oct 2026 18:51:28 -0300
Message-ID: <87bj8wlzmn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0A7311F7D2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
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

> QEMU incoming side may have set a wrong listen() backlog.  After the
> support of multifd + postcopy now we have four possibilities on setting t=
he
> backlog, some of them are wrong:
>
>   Vanilla:            1 (correct)
>   Multifd:            N (wrong, should be N+1)
>   Preempt:            2 (correct)
>   Multifd+Preempt:    N (wrong, should be N+2)
>
> No real report for this, found by code observation only.  Logically the
> backlog (pending accept requests on destination on the listening sockets)
> needs to be the maximum of possible channels.  Otherwise if the accept
> queue full on destination, source QEMU may hit connection errors.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Fixes: 0705e56496 ("multifd: Use number of channels as listen backlog")
> Fixes: e274188612 ("migration: enable multifd and postcopy together")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/socket.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/migration/socket.c b/migration/socket.c
> index f57f1a8e7c..31bfa1eeeb 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -139,21 +139,32 @@ socket_incoming_migration_end(void *opaque)
>      object_unref(OBJECT(listener));
>  }
>=20=20
> +static int socket_get_max_channels(void)
> +{
> +    /* The main channel is always wanted */
> +    int num =3D 1;
> +
> +    if (migrate_multifd()) {
> +        num +=3D migrate_multifd_channels();
> +    }
> +
> +    if (migrate_postcopy_preempt()) {
> +        /* The preempt channel */
> +        num +=3D 1;
> +    }
> +
> +    return num;
> +}
> +
>  void socket_connect_incoming(SocketAddress *saddr, Error **errp)
>  {
>      QIONetListener *listener =3D qio_net_listener_new();
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      size_t i;
> -    int num =3D 1;
> +    int num =3D socket_get_max_channels();
>=20=20
>      qio_net_listener_set_name(listener, "migration-socket-listener");
>=20=20
> -    if (migrate_multifd()) {
> -        num =3D migrate_multifd_channels();
> -    } else if (migrate_postcopy_preempt()) {
> -        num =3D RAM_CHANNEL_MAX;
> -    }
> -
>      if (qio_net_listener_open_sync(listener, saddr, num, errp) < 0) {
>          object_unref(OBJECT(listener));
>          return;

Reviewed-by: Fabiano Rosas <farosas@suse.de>

