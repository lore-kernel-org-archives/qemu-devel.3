Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19080C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 20:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmEU-00056L-HK; Wed, 05 Feb 2025 15:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfmES-00056C-6E
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:42:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfmEP-0007mW-Bq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:42:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D72D2115F;
 Wed,  5 Feb 2025 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738788161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWurYZw7lW5fhWI8BUlg8s2eSyCca//W5GAdfkWWYzg=;
 b=GDXx2ZfC1x2l9+S9Jpgitr8zXeD4PEuQxgsup3MY6jWVUrLpaPNZVdYE6Ti383lQiVnFmE
 hw2sCaNUZxc873B7TyORwAVZ4nnspyhQT0SNTz4+u0DCDW4kcazD4DFU7r2lpwTA/1/e5p
 U8TU/Hu3i28fEo6bze2Rh/7rxq9F+tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738788161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWurYZw7lW5fhWI8BUlg8s2eSyCca//W5GAdfkWWYzg=;
 b=tZFrKdz9EdESY9O0RIP2t4M9lityv3F9P7sSSC71e79rHY+MIP6/v6Siq8BCe8p7DwPtQS
 QCVVQdLFXyTQqgCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GDXx2ZfC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tZFrKdz9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738788161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWurYZw7lW5fhWI8BUlg8s2eSyCca//W5GAdfkWWYzg=;
 b=GDXx2ZfC1x2l9+S9Jpgitr8zXeD4PEuQxgsup3MY6jWVUrLpaPNZVdYE6Ti383lQiVnFmE
 hw2sCaNUZxc873B7TyORwAVZ4nnspyhQT0SNTz4+u0DCDW4kcazD4DFU7r2lpwTA/1/e5p
 U8TU/Hu3i28fEo6bze2Rh/7rxq9F+tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738788161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWurYZw7lW5fhWI8BUlg8s2eSyCca//W5GAdfkWWYzg=;
 b=tZFrKdz9EdESY9O0RIP2t4M9lityv3F9P7sSSC71e79rHY+MIP6/v6Siq8BCe8p7DwPtQS
 QCVVQdLFXyTQqgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A31D213694;
 Wed,  5 Feb 2025 20:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rA7LGEDNo2f5fAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 05 Feb 2025 20:42:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
In-Reply-To: <87zfj0mcmy.fsf@suse.de>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
 <Z6Iy0wY-lsx3M71M@x1.local> <Z6I0mzWEsl5y57Zj@redhat.com>
 <87zfj0mcmy.fsf@suse.de>
Date: Wed, 05 Feb 2025 17:42:37 -0300
Message-ID: <87wme4m8ci.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3D72D2115F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Fabiano Rosas <farosas@suse.de> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Tue, Feb 04, 2025 at 10:31:31AM -0500, Peter Xu wrote:
>>> On Tue, Feb 04, 2025 at 03:39:00PM +0100, Maciej S. Szmigiero wrote:
>>> > On 3.02.2025 23:56, Peter Xu wrote:
>>> > > On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
>>> > > > On 3.02.2025 21:20, Peter Xu wrote:
>>> > > > > On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero w=
rote:
>>> > > > > > On 3.02.2025 19:20, Peter Xu wrote:
>>> > > > > > > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigie=
ro wrote:
>>> > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>> > > > > > > >=20
>>> > > > > > > > Multifd send channels are terminated by calling
>>> > > > > > > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>>> > > > > > > > multifd_send_terminate_threads(), which in the TLS case e=
ssentially
>>> > > > > > > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
>>> > > > > > > >=20
>>> > > > > > > > Unfortunately, this does not terminate the TLS session pr=
operly and
>>> > > > > > > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMIN=
ATION error.
>>> > > > > > > >=20
>>> > > > > > > > The only reason why this wasn't causing migration failure=
s is because
>>> > > > > > > > the current migration code apparently does not check for =
migration
>>> > > > > > > > error being set after the end of the multifd receive proc=
ess.
>>> > > > > > > >=20
>>> > > > > > > > However, this will change soon so the multifd receive cod=
e has to be
>>> > > > > > > > prepared to not return an error on such premature TLS ses=
sion EOF.
>>> > > > > > > > Use the newly introduced QIOChannelTLS method for that.
>>> > > > > > > >=20
>>> > > > > > > > It's worth noting that even if the sender were to be chan=
ged to terminate
>>> > > > > > > > the TLS connection properly the receive side still needs =
to remain
>>> > > > > > > > compatible with older QEMU bit stream which does not do t=
his.
>>> > > > > > >=20
>>> > > > > > > If this is an existing bug, we could add a Fixes.
>>> > > > > >=20
>>> > > > > > It is an existing issue but only uncovered by this patch set.
>>> > > > > >=20
>>> > > > > > As far as I can see it was always there, so it would need some
>>> > > > > > thought where to point that Fixes tag.
>>> > > > >=20
>>> > > > > If there's no way to trigger a real functional bug anyway, it's=
 also ok we
>>> > > > > omit the Fixes.
>>> > > > >=20
>>> > > > > > > Two pure questions..
>>> > > > > > >=20
>>> > > > > > >      - What is the correct way to terminate the TLS session=
 without this flag?
>>> > > > > >=20
>>> > > > > > I guess one would need to call gnutls_bye() like in this GnuT=
LS example:
>>> > > > > > https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb=
32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
>>> > > > > >=20
>>> > > > > > >      - Why this is only needed by multifd sessions?
>>> > > > > >=20
>>> > > > > > What uncovered the issue was switching the load threads to us=
ing
>>> > > > > > migrate_set_error() instead of their own result variable
>>> > > > > > (load_threads_ret) which you had requested during the previous
>>> > > > > > patch set version review:
>>> > > > > > https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
>>> > > > > >=20
>>> > > > > > Turns out that the multifd receive code always returned
>>> > > > > > error in the TLS case, just nothing was previously checking f=
or
>>> > > > > > that error presence.
>>> > > > >=20
>>> > > > > What I was curious is whether this issue also exists for the ma=
in migration
>>> > > > > channel when with tls, especially when e.g. multifd not enabled=
 at all.  As
>>> > > > > I don't see anywhere that qemu uses gnutls_bye() for any tls se=
ssion.
>>> > > > >=20
>>> > > > > I think it's a good to find that we overlooked this before.. an=
d IMHO it's
>>> > > > > always good we could fix this.
>>> > > > >=20
>>> > > > > Does it mean we need proper gnutls_bye() somewhere?
>>> > > > >=20
>>> > > > > If we need an explicit gnutls_bye(), then I wonder if that shou=
ld be done
>>> > > > > on the main channel as well.
>>> > > >=20
>>> > > > That's a good question and looking at the code qemu_loadvm_state_=
main() exits
>>> > > > on receiving "QEMU_VM_EOF" section (that's different from receivi=
ng socket EOF)
>>> > > > and then optionally "QEMU_VM_VMDESCRIPTION" section is read with =
explicit size
>>> > > > in qemu_loadvm_state() - so still not until channel EOF.
>>> > >=20
>>> > > I had a closer look, I do feel like such pre-mature termination is =
caused
>>> > > by explicit shutdown()s of the iochannels, looks like that can caus=
e issue
>>> > > even after everything is sent.  Then I noticed indeed multifd sender
>>> > > iochannels will get explicit shutdown()s since commit 077fbb5942, w=
hile we
>>> > > don't do that for the main channel.  Maybe that is a major differen=
ce.
>>> > >=20
>>> > > Now I wonder whether we should shutdown() the channel at all if mig=
ration
>>> > > succeeded, because looks like it can cause tls session to interrupt=
 even if
>>> > > the shutdown() is done after sent everything, and if so it'll expla=
in why
>>> > > you hit the issue with tls.
>>> > >=20
>>> > > >=20
>>> > > > Then I can't see anything else reading the channel until it is cl=
osed in
>>> > > > migration_incoming_state_destroy().
>>> > > >=20
>>> > > > So most likely the main migration channel will never read far eno=
ugh to
>>> > > > reach that GNUTLS_E_PREMATURE_TERMINATION error.
>>> > > >=20
>>> > > > > If we don't need gnutls_bye(), then should we always ignore pre=
-mature
>>> > > > > termination of tls no matter if it's multifd or non-multifd cha=
nnel (or
>>> > > > > even a tls session that is not migration-related)?
>>> > > >=20
>>> > > > So basically have this patch extended to calling
>>> > > > qio_channel_tls_set_premature_eof_okay() also on the main migrati=
on channel?
>>> > >=20
>>> > > If above theory can stand, then eof-okay could be a workaround pape=
ring
>>> > > over the real problem that we shouldn't always shutdown()..
>>> > >=20
>>> > > Could you have a look at below patch and see whether it can fix the=
 problem
>>> > > you hit too, in replace of these two patches (including the previous
>>> > > iochannel change)?
>>> > >=20
>>> >=20
>>> > Unfortunately, the patch below does not fix the problem:
>>> > > qemu-system-x86_64: Cannot read from TLS channel: The TLS connectio=
n was non-properly terminated.
>>> > > qemu-system-x86_64: Cannot read from TLS channel: The TLS connectio=
n was non-properly terminated.
>>> >=20
>>> > I think that, even in the absence of shutdown(), if the sender does n=
ot
>>> > call gnutls_bye() the TLS session is considered improperly terminated.
>>>=20
>>> Ah..
>>>=20
>>> How about one more change on top of above change to disconnect properly=
 for
>>> TLS?  Something like gnutls_bye() in qio_channel_tls_close(), would that
>>> make sense to you?
>>
>> Calling gnutls_bye from qio_channel_tls_close is not viable for the
>> API contract of qio_channel_close. gnutls_bye needs to be able to
>> perform I/O, which means we need to be able to tell the caller
>> whether it needs to perform an event loop wait for POLLIN or POLLOUT.
>>
>> This is the same API design scenario as the gnutls_handshake method.
>> As such I tdon't think it is practical to abstract it inside any
>> existing QIOChannel API call, it'll have to be standalone like
>> qio_channel_tls_handshake() is.
>>
>
> I implemented the call to gnutls_bye:
> https://gitlab.com/farosas/qemu/-/commits/migration-tls-bye
>
> Then while testing it I realised we actually have a regression from 9.2:
>
> 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")
>
> It seems that patch somehow affected the ordering between src shutdown
> vs. recv shutdown and now the recv channels are staying around to see
> the connection being broken. Or something... I'm still looking into it.
>

Ok, so the issue is that the recv side would previously be stuck at the
sync semaphore and multifd_recv_terminate_threads() would kick it only
after 'exiting' was set, so no further recv() would happen.

After the patch, there's no final sync anymore, so the recv thread loops
around and waits at the recv() until multifd_send_terminate_threads()
closes the connection.

Waiting on sem_sync as before would lead to a cleaner termination
process IMO, but I don't think it's worth the extra complexity of
introducing a sync to the device state migration.

So I think we'll have to go with one of the approaches suggested on this
thread (gnutls_bye or premature_ok). I'm fine either way, but let's make
sure we add a reference to the patch above and some words explaining the
situation.

(let me know if anyone prefers the gnutls_bye approach I have implemented
and I can send a proper series)

>>
>> With regards,
>> Daniel

