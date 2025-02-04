Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29527C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJL5-0000bP-Dz; Tue, 04 Feb 2025 08:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfJL1-0000b2-Ch
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:51:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfJKy-0004HW-Oq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:51:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF2B421114;
 Tue,  4 Feb 2025 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738677093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMTeZzGu5mz5yPjnKR9AsNb6+BeBjrcS+iYqoitHtxQ=;
 b=RzMfs239v4yj3fHk//5mZ8AS6IoZYzf7pzKn7uO0DB21HdlN09ADv2/6bDdz2lR+VIFK/z
 +iRF7vjOU7Duf5PFeHgdyftblSobRFhMBDWNXKfz/ci7U3jbSxmskAlRQUzBKFtH3KRqCo
 ZwYGGDilbCs2YITOwnC33qNXYRqzibQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738677093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMTeZzGu5mz5yPjnKR9AsNb6+BeBjrcS+iYqoitHtxQ=;
 b=giYGevcGnV0LOV7MwcovsTpz45wNCRD8SAOgwJ0MSV7haCMEtCwLzcf/lsNgjamnTQM5ji
 UfD8zIyD/NJIzCDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MGikOez6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wpAv0gLU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738677090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMTeZzGu5mz5yPjnKR9AsNb6+BeBjrcS+iYqoitHtxQ=;
 b=MGikOez635PteEq8ZR3zCRq3UzwAj2mkWQ+PDkLMIQrrPbC0yqaI0sMDpUzeSWEortM/Us
 9FgXlDzvfwVxFHLgxq77C1sWRhEaSYXGs4d+YTuyiCJu5zh1mBdUl+jn2v3mQW2XbI/X8h
 adxFCq9PDKAWBR0ws0uvNyjR7tAdMuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738677090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMTeZzGu5mz5yPjnKR9AsNb6+BeBjrcS+iYqoitHtxQ=;
 b=wpAv0gLUGknRtfcOoZ/7znRamqZn0NhnSC85ifNuKEhV2RXksg5zDWKR7NAuvriemK3mZF
 52zk5e7QsEaNAEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 520741393E;
 Tue,  4 Feb 2025 13:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cYMzBmIbomfEWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 04 Feb 2025 13:51:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
In-Reply-To: <Z6FJuK2FVKhI0C2j@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
Date: Tue, 04 Feb 2025 10:51:27 -0300
Message-ID: <877c65akdc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CF2B421114
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
>> On 3.02.2025 21:20, Peter Xu wrote:
>> > On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
>> > > On 3.02.2025 19:20, Peter Xu wrote:
>> > > > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrot=
e:
>> > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>> > > > >=20
>> > > > > Multifd send channels are terminated by calling
>> > > > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>> > > > > multifd_send_terminate_threads(), which in the TLS case essentia=
lly
>> > > > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
>> > > > >=20
>> > > > > Unfortunately, this does not terminate the TLS session properly =
and
>> > > > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION e=
rror.
>> > > > >=20
>> > > > > The only reason why this wasn't causing migration failures is be=
cause
>> > > > > the current migration code apparently does not check for migrati=
on
>> > > > > error being set after the end of the multifd receive process.
>> > > > >=20
>> > > > > However, this will change soon so the multifd receive code has t=
o be
>> > > > > prepared to not return an error on such premature TLS session EO=
F.
>> > > > > Use the newly introduced QIOChannelTLS method for that.
>> > > > >=20
>> > > > > It's worth noting that even if the sender were to be changed to =
terminate
>> > > > > the TLS connection properly the receive side still needs to rema=
in
>> > > > > compatible with older QEMU bit stream which does not do this.
>> > > >=20
>> > > > If this is an existing bug, we could add a Fixes.
>> > >=20
>> > > It is an existing issue but only uncovered by this patch set.
>> > >=20
>> > > As far as I can see it was always there, so it would need some
>> > > thought where to point that Fixes tag.
>> >=20
>> > If there's no way to trigger a real functional bug anyway, it's also o=
k we
>> > omit the Fixes.
>> >=20
>> > > > Two pure questions..
>> > > >=20
>> > > >     - What is the correct way to terminate the TLS session without=
 this flag?
>> > >=20
>> > > I guess one would need to call gnutls_bye() like in this GnuTLS exam=
ple:
>> > > https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003=
b34ecad596e3/doc/examples/ex-client-anon.c#L102
>> > >=20
>> > > >     - Why this is only needed by multifd sessions?
>> > >=20
>> > > What uncovered the issue was switching the load threads to using
>> > > migrate_set_error() instead of their own result variable
>> > > (load_threads_ret) which you had requested during the previous
>> > > patch set version review:
>> > > https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
>> > >=20
>> > > Turns out that the multifd receive code always returned
>> > > error in the TLS case, just nothing was previously checking for
>> > > that error presence.
>> >=20
>> > What I was curious is whether this issue also exists for the main migr=
ation
>> > channel when with tls, especially when e.g. multifd not enabled at all=
.  As
>> > I don't see anywhere that qemu uses gnutls_bye() for any tls session.
>> >=20
>> > I think it's a good to find that we overlooked this before.. and IMHO =
it's
>> > always good we could fix this.
>> >=20
>> > Does it mean we need proper gnutls_bye() somewhere?
>> >=20
>> > If we need an explicit gnutls_bye(), then I wonder if that should be d=
one
>> > on the main channel as well.
>>=20
>> That's a good question and looking at the code qemu_loadvm_state_main() =
exits
>> on receiving "QEMU_VM_EOF" section (that's different from receiving sock=
et EOF)
>> and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explici=
t size
>> in qemu_loadvm_state() - so still not until channel EOF.
>
> I had a closer look, I do feel like such pre-mature termination is caused
> by explicit shutdown()s of the iochannels, looks like that can cause issue
> even after everything is sent.  Then I noticed indeed multifd sender
> iochannels will get explicit shutdown()s since commit 077fbb5942, while we
> don't do that for the main channel.  Maybe that is a major difference.
>
> Now I wonder whether we should shutdown() the channel at all if migration
> succeeded, because looks like it can cause tls session to interrupt even =
if
> the shutdown() is done after sent everything, and if so it'll explain why
> you hit the issue with tls.
>
>>=20
>> Then I can't see anything else reading the channel until it is closed in
>> migration_incoming_state_destroy().
>>=20
>> So most likely the main migration channel will never read far enough to
>> reach that GNUTLS_E_PREMATURE_TERMINATION error.
>>=20
>> > If we don't need gnutls_bye(), then should we always ignore pre-mature
>> > termination of tls no matter if it's multifd or non-multifd channel (or
>> > even a tls session that is not migration-related)?
>>=20
>> So basically have this patch extended to calling
>> qio_channel_tls_set_premature_eof_okay() also on the main migration chan=
nel?
>
> If above theory can stand, then eof-okay could be a workaround papering
> over the real problem that we shouldn't always shutdown()..
>
> Could you have a look at below patch and see whether it can fix the probl=
em
> you hit too, in replace of these two patches (including the previous
> iochannel change)?
>
> Thanks,
>
> =3D=3D=3D8<=3D=3D=3D
> From 3147084174b0e0bda076ad205ae139f8fc433892 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 3 Feb 2025 17:27:45 -0500
> Subject: [PATCH] migration: Avoid shutdown multifd channels if migration
>  succeeded
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Multifd channels behave differently from the main channel when shutting
> down: the sender side will always shutdown() on the multifd iochannels, no
> matter whether migration succeeded or not.  QEMU doesn't do that on src.
>
> Such behavior was introduced in commit 077fbb5942 ("multifd: Shut down the
> QIO channels to avoid blocking the send threads when they are terminated.=
")
> to fix a hang issue when multifd enabled.

I'm always skeptical of "hangs" being fixed with shutdown(), when the
multifd code has had multiple issues with incorrect locking and ordering
of thread creation/deletion.

>
> This might be problematic though, especially in TLS context, because it
> looks like such shutdown() on src (even if succeeded) could cause
> destination multifd iochannels to receive pre-mature terminations of TLS
> sessions.

Speaking of TLS, enabling asan and running the TLS tests crashes QEMU in
a very obscure way. May or may not be related to thread termination
issues. I've been skipping postcopy/recovery/tls/psk when doing asan
builds for a while now. Just FYI, I'm not asking we take action on this
and I'm keeping an eye on it.

>
> It's debatable whether such shutdown() should be explicitly done even for=
 a
> succeeded migration.  This patch moves the shutdown() instead from
> finalization phase into qmp_migrate_cancel(), so that we only do the
> shutdown() when cancels, and we should avoid such when it succeeds.
>
> When at it, keep all the shutdown() code together, moving the return path
> shutdown() (which seems a bit redundant, but no harm to do) to where the
> rest channels are shutdown.
>
> Cc: Li Zhang <lizhang@suse.de>

This will bounce, she's no longer at SUSE.

> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h   |  1 +
>  migration/migration.c | 24 +++++++++++++++++-------
>  migration/multifd.c   | 14 +++++++++++---
>  3 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index bd785b9873..26ef94ac93 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -340,6 +340,7 @@ static inline void multifd_send_prepare_header(MultiF=
DSendParams *p)
>=20=20
>  void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
>  bool multifd_send(MultiFDSendData **send_data);
> +void multifd_send_shutdown_iochannels(void);
>  MultiFDSendData *multifd_send_data_alloc(void);
>=20=20
>  static inline uint32_t multifd_ram_page_size(void)
> diff --git a/migration/migration.c b/migration/migration.c
> index 74c50cc72c..e43f8222dc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1565,13 +1565,6 @@ static void migrate_fd_cancel(MigrationState *s)
>=20=20
>      trace_migrate_fd_cancel();
>=20=20
> -    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> -        if (s->rp_state.from_dst_file) {
> -            /* shutdown the rp socket, so causing the rp thread to shutd=
own */
> -            qemu_file_shutdown(s->rp_state.from_dst_file);
> -        }
> -    }
> -
>      do {
>          old_state =3D s->state;
>          if (!migration_is_running()) {
> @@ -1594,6 +1587,23 @@ static void migrate_fd_cancel(MigrationState *s)
>              if (s->to_dst_file) {
>                  qemu_file_shutdown(s->to_dst_file);
>              }
> +            /*
> +             * Above should work already, because the iochannel is shared
> +             * between outgoing and return path qemufiles, however just =
to
> +             * be on the safe side to set qemufile error on return path =
too
> +             * if existed.
> +             */
> +            if (s->rp_state.from_dst_file) {
> +                qemu_file_shutdown(s->rp_state.from_dst_file);
> +            }
> +        }
> +
> +        /*
> +         * We need to shutdown multifd channels too if they are availabl=
e,
> +         * to make sure no multifd send threads will be stuck at syscall=
s.
> +         */
> +        if (migrate_multifd()) {
> +            multifd_send_shutdown_iochannels();
>          }
>      }
>=20=20
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ab73d6d984..96bcbb1e0c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -384,6 +384,17 @@ static void multifd_send_set_error(Error *err)
>      }
>  }
>=20=20
> +void multifd_send_shutdown_iochannels(void)
> +{
> +    QIOChannel *c;
> +    int i;
> +
> +    for (i =3D 0; i < migrate_multifd_channels(); i++) {
> +        c =3D multifd_send_state->params[i].c;
> +        qio_channel_shutdown(c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> +    }
> +}
> +
>  static void multifd_send_terminate_threads(void)
>  {
>      int i;
> @@ -404,9 +415,6 @@ static void multifd_send_terminate_threads(void)
>          MultiFDSendParams *p =3D &multifd_send_state->params[i];
>=20=20
>          qemu_sem_post(&p->sem);
> -        if (p->c) {
> -            qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> -        }
>      }
>=20=20
>      /*
> --=20
> 2.47.0

