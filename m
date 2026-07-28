Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F45C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonxq-0008CU-FI; Tue, 28 Jul 2026 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonxn-00083p-8X
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:59:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonxl-0000E3-18
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:59:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F104C7C49B;
 Tue, 28 Jul 2026 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785268775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9EL0CXmu7v5jOGHm9kC2Rt0uRXI5wCl402bNEwnByM=;
 b=jsBQTvS2XEP+KPkDtbgm3lGmcFzMtHmDlzOvfB5GYIggB2FUQlDd/5P/xodVrou70TH3YF
 /OeTgEzcjSkG0vTEOIRzkG3Y8nUScLzs4NqIV3yMhifA+CFptBfPfximUw/E1pfPFDKrrK
 xCcSlFONngLeYmtMY3MXJ/Z2iNVebvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785268775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9EL0CXmu7v5jOGHm9kC2Rt0uRXI5wCl402bNEwnByM=;
 b=THZIJXqSf7ftscJV5DPUcip+5Yr7GedopygKNkhJKUBnsLILKTsbrLEsqs5elnEskPKMLJ
 4aVGhaDsADhJsVCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785268770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9EL0CXmu7v5jOGHm9kC2Rt0uRXI5wCl402bNEwnByM=;
 b=O75W8UdXmcsx1sqg4ZV/VJlFY2iC17AJRSWJbFxqR9dBfNMdbpy5UwjYpdzU+5B5kAEmmH
 BaGsbnUFlZ+C/2jKy9te0SETFNxa/qBFc7rnQVv7+DxAaYRKBsppaUKmTH6rZQj3khHUpn
 qt+mRl6UeBJ1po0YmYDUZT5XWCdkBDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785268770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9EL0CXmu7v5jOGHm9kC2Rt0uRXI5wCl402bNEwnByM=;
 b=VjMNzVQUNw9ssnAdsCciCROwhHqiHP1lZDq4Rtdw3q8ECk54+IDoEkyPtxMHkvD+ZgX304
 fwM+R4G6F/cB6VBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F814779B1;
 Tue, 28 Jul 2026 19:59:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RWIKGCIKaWpDUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 19:59:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, Feifan Qian
 <bea1e@proton.me>
Subject: Re: [PATCH 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
In-Reply-To: <amjiLyOJF92okvik@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-5-peterx@redhat.com> <amjXxDH73ah-dUGE@redhat.com>
 <amjiLyOJF92okvik@x1.local>
Date: Tue, 28 Jul 2026 16:59:20 -0300
Message-ID: <87o6fqopgn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jul 28, 2026 at 05:24:36PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Jul 28, 2026 at 11:52:46AM -0400, Peter Xu wrote:
>> > In an unlikely case, when a migration stream is attached to the destin=
ation
>> > QEMU and only send <4 bytes to the channel as magic, it's possible that
>> > migration_channel_read_peek() may spin forever without yielding in the=
 main
>> > thread causing two unwanted consequences:
>> >=20
>> > - CPU will spin 100% waiting for the rest bytes until it reaches 4
>> > - (more importantly..) Main thread is stuck during this process as the=
 qio
>> >   operation won't really yield the coroutine
>> >=20
>> > Fix it by consuming the bytes that arrived.
>> >=20
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
>> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Reported-by: Feifan Qian <bea1e@proton.me>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/channel.c | 26 +++++++++++++++++++++++---
>> >  1 file changed, 23 insertions(+), 3 deletions(-)
>> >=20
>> > diff --git a/migration/channel.c b/migration/channel.c
>> > index 1e2935f926..28fe1d2906 100644
>> > --- a/migration/channel.c
>> > +++ b/migration/channel.c
>> > @@ -294,11 +294,31 @@ int migration_channel_read_peek(QIOChannel *ioc,
>> >              return -1;
>> >          }
>> >=20=20
>> > -        if (len =3D=3D buflen) {
>> > +        if (len =3D=3D iov.iov_len) {
>> >              break;
>> > -        }
>> > +        } else if (len =3D=3D 0) {
>> > +            qio_channel_wait_cond(ioc, G_IO_IN);
>> > +        } else {
>> > +            ssize_t received =3D len;
>> >=20=20
>> > -        qio_channel_wait_cond(ioc, G_IO_IN);
>> > +            /*
>> > +             * Partially arrived, read out to make qio_channel_wait_c=
ond()
>> > +             * won't return immediately, causing an unwanted spin on =
this
>> > +             * CPU.
>> > +             */
>> > +            iov.iov_len =3D len;
>> > +            len =3D qio_channel_readv_full(ioc, &iov, 1, NULL, NULL, =
0, errp);
>>=20
>> Sure this breaks the API behaviour that the caller is expecting to
>> see.
>>=20
>> migration_channel_identify will call migration_channel_read_peek
>> to match the magic bytes.
>>=20
>> But something later in the flow will actually try to read the magic
>> bytes.  By consuming them in this migration_channel_read_peek
>> method, surely we're breaking the code that wants to read the bytes
>> later.
>
> Ah right, stupid me.  The best then is for partial read we apply a manual
> wait.
>
> I can also revert 604bb1badc ("migration: Properly wait on G_IO_IN when
> peeking messages"), looping with 1ms interval for data isn't too bad.  But
> the best is we only do that for partial, so:
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 1e2935f926..88f89521f8 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -296,9 +296,19 @@ int migration_channel_read_peek(QIOChannel *ioc,
>
>          if (len =3D=3D buflen) {
>              break;
> +        } else if (len =3D=3D 0) {
> +            qio_channel_wait_cond(ioc, G_IO_IN);
> +        } else {
> +            /*
> +             * When partially ready, we can't use qio_channel_wait_cond()
> +             * because it will return immediately.  Apply a manual wait.
> +             */
> +            if (qemu_in_coroutine()) {

There's no coroutine at this point, could replace this with an assert.

> +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
> +            } else {
> +                g_usleep(1000);
> +            }
>          }
> -
> -        qio_channel_wait_cond(ioc, G_IO_IN);
>      }
>
>      return 0;
>
> Any preference?
>
> Thanks,
>
>>=20
>> > +            /*
>> > +             * QIO_CHANNEL_ERR_BLOCK also shouldn't happen, due to the
>> > +             * prior peek just happened.  We should be pretty sure we=
 will
>> > +             * read what we peeked, or the channel was broken.
>> > +             */
>> > +            if (len !=3D received) {
>> > +                return -1;
>> > +            }
>> > +            iov.iov_base +=3D received;
>> > +            iov.iov_len =3D buflen - received;
>> > +        }
>> >      }
>> >=20=20
>> >      return 0;
>> > --=20
>> > 2.54.0
>> >=20
>>=20
>> With regards,
>> Daniel
>> --=20
>> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
>> |: https://libvirt.org          ~~          https://entangle-photo.org :|
>> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>>=20

