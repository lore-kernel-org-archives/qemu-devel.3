Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BAFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woovM-0003Xd-3K; Tue, 28 Jul 2026 17:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woovJ-0003XN-9d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:01:13 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woovH-0003Ko-6M
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:01:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A07B47C57E;
 Tue, 28 Jul 2026 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785272465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJ5OF3WyZ6XsDMyUpWGekSp3ZIeqbyazjY1fBVYJnR8=;
 b=cvOm71XVsxlBb86GOjdrEoARnIkT/c97AP5k+ylEOI+gF6eTXZqCkW3bQaHjdEl2ca6Dsb
 zEaXua8d0KhQD6Pbnj0KcvlP5rpKfm1Jb4fFjQ/GynwLBVkuHtsY+QfokjPvPG+BSgZ5PW
 jwS001eV+uAGwTdb9BKsf/eXF6aqDYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785272465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJ5OF3WyZ6XsDMyUpWGekSp3ZIeqbyazjY1fBVYJnR8=;
 b=V8yA2XUhz6O5/LoxpNkZjzd783TqQnHfglIm+4aqI08ErTs497KlOh3f1X6f+5R/espUw8
 ytSvzDr3C+XoHrBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rRORIL4c;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KVswEpwT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785272461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJ5OF3WyZ6XsDMyUpWGekSp3ZIeqbyazjY1fBVYJnR8=;
 b=rRORIL4ch+N/7Czw4QFCDBOojfyrWVqjnHfcxD+Xp52FZyRnD/oWgiBghA4b4jrwfCD2b0
 oacQr8Vgj3uEo/363n9nkla/WtcnQbcvavfZd/CWCrX+o8gV7zhdkkhRWACLd1DU8xzCiR
 pvPNRVLMxVUWKSQTeTRbivPFdAHcpV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785272461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJ5OF3WyZ6XsDMyUpWGekSp3ZIeqbyazjY1fBVYJnR8=;
 b=KVswEpwT9EKvq4NDlF5NcCkz93+BWwq0u6ugor8YYUPuLUVJKuR1VfDXAT0t6J4M95fZNO
 SGTLeZ1B1WE3kmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40FAF779B1;
 Tue, 28 Jul 2026 21:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zAf1BI0YaWrKCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 21:01:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Juraj
 Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
In-Reply-To: <amkVJZ14O60zAeVt@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-5-peterx@redhat.com> <amjXxDH73ah-dUGE@redhat.com>
 <amjiLyOJF92okvik@x1.local> <87o6fqopgn.fsf@suse.de>
 <amkVJZ14O60zAeVt@x1.local>
Date: Tue, 28 Jul 2026 18:00:50 -0300
Message-ID: <87ecgmomm5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A07B47C57E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> On Tue, Jul 28, 2026 at 04:59:20PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Tue, Jul 28, 2026 at 05:24:36PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> >> On Tue, Jul 28, 2026 at 11:52:46AM -0400, Peter Xu wrote:
>> >> > In an unlikely case, when a migration stream is attached to the des=
tination
>> >> > QEMU and only send <4 bytes to the channel as magic, it's possible =
that
>> >> > migration_channel_read_peek() may spin forever without yielding in =
the main
>> >> > thread causing two unwanted consequences:
>> >> >=20
>> >> > - CPU will spin 100% waiting for the rest bytes until it reaches 4
>> >> > - (more importantly..) Main thread is stuck during this process as =
the qio
>> >> >   operation won't really yield the coroutine
>> >> >=20
>> >> > Fix it by consuming the bytes that arrived.
>> >> >=20
>> >> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
>> >> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> >> > Reported-by: Feifan Qian <bea1e@proton.me>
>> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> >> > ---
>> >> >  migration/channel.c | 26 +++++++++++++++++++++++---
>> >> >  1 file changed, 23 insertions(+), 3 deletions(-)
>> >> >=20
>> >> > diff --git a/migration/channel.c b/migration/channel.c
>> >> > index 1e2935f926..28fe1d2906 100644
>> >> > --- a/migration/channel.c
>> >> > +++ b/migration/channel.c
>> >> > @@ -294,11 +294,31 @@ int migration_channel_read_peek(QIOChannel *i=
oc,
>> >> >              return -1;
>> >> >          }
>> >> >=20=20
>> >> > -        if (len =3D=3D buflen) {
>> >> > +        if (len =3D=3D iov.iov_len) {
>> >> >              break;
>> >> > -        }
>> >> > +        } else if (len =3D=3D 0) {
>> >> > +            qio_channel_wait_cond(ioc, G_IO_IN);
>> >> > +        } else {
>> >> > +            ssize_t received =3D len;
>> >> >=20=20
>> >> > -        qio_channel_wait_cond(ioc, G_IO_IN);
>> >> > +            /*
>> >> > +             * Partially arrived, read out to make qio_channel_wai=
t_cond()
>> >> > +             * won't return immediately, causing an unwanted spin =
on this
>> >> > +             * CPU.
>> >> > +             */
>> >> > +            iov.iov_len =3D len;
>> >> > +            len =3D qio_channel_readv_full(ioc, &iov, 1, NULL, NUL=
L, 0, errp);
>> >>=20
>> >> Sure this breaks the API behaviour that the caller is expecting to
>> >> see.
>> >>=20
>> >> migration_channel_identify will call migration_channel_read_peek
>> >> to match the magic bytes.
>> >>=20
>> >> But something later in the flow will actually try to read the magic
>> >> bytes.  By consuming them in this migration_channel_read_peek
>> >> method, surely we're breaking the code that wants to read the bytes
>> >> later.
>> >
>> > Ah right, stupid me.  The best then is for partial read we apply a man=
ual
>> > wait.
>> >
>> > I can also revert 604bb1badc ("migration: Properly wait on G_IO_IN when
>> > peeking messages"), looping with 1ms interval for data isn't too bad. =
 But
>> > the best is we only do that for partial, so:
>> >
>> > diff --git a/migration/channel.c b/migration/channel.c
>> > index 1e2935f926..88f89521f8 100644
>> > --- a/migration/channel.c
>> > +++ b/migration/channel.c
>> > @@ -296,9 +296,19 @@ int migration_channel_read_peek(QIOChannel *ioc,
>> >
>> >          if (len =3D=3D buflen) {
>> >              break;
>> > +        } else if (len =3D=3D 0) {
>> > +            qio_channel_wait_cond(ioc, G_IO_IN);
>> > +        } else {
>> > +            /*
>> > +             * When partially ready, we can't use qio_channel_wait_co=
nd()
>> > +             * because it will return immediately.  Apply a manual wa=
it.
>> > +             */
>> > +            if (qemu_in_coroutine()) {
>>=20
>> There's no coroutine at this point, could replace this with an assert.
>
> Hmm, true..  Then it means this can stuck the main thread even if no data
> arrived (len=3D=3D0), hang monitors..  I hope it's not a major issue and
> shouldn't easily happen in real life, because normally when src connected,
> at least the headers will be dumped very soon.
>

If I'm not mistaken the watch only dispatches when there's IO.

> I'll switch to assert for now.
>
>>=20
>> > +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
>> > +            } else {
>> > +                g_usleep(1000);
>> > +            }
>> >          }
>> > -
>> > -        qio_channel_wait_cond(ioc, G_IO_IN);
>> >      }
>> >
>> >      return 0;
>> >
>> > Any preference?
>> >
>> > Thanks,
>> >
>> >>=20
>> >> > +            /*
>> >> > +             * QIO_CHANNEL_ERR_BLOCK also shouldn't happen, due to=
 the
>> >> > +             * prior peek just happened.  We should be pretty sure=
 we will
>> >> > +             * read what we peeked, or the channel was broken.
>> >> > +             */
>> >> > +            if (len !=3D received) {
>> >> > +                return -1;
>> >> > +            }
>> >> > +            iov.iov_base +=3D received;
>> >> > +            iov.iov_len =3D buflen - received;
>> >> > +        }
>> >> >      }
>> >> >=20=20
>> >> >      return 0;
>> >> > --=20
>> >> > 2.54.0
>> >> >=20
>> >>=20
>> >> With regards,
>> >> Daniel
>> >> --=20
>> >> |: https://berrange.com       ~~        https://hachyderm.io/@berrang=
e :|
>> >> |: https://libvirt.org          ~~          https://entangle-photo.or=
g :|
>> >> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.co=
m :|
>> >>=20
>>=20

