Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F94C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5ju-0001jK-8F; Thu, 06 Feb 2025 12:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg5ji-0001dZ-Mi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:32:23 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg5jf-0002am-Ox
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:32:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEEDE21108;
 Thu,  6 Feb 2025 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738863136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6pb0IqDA+7Xa4XD5HohUjev5daSHq0HsKilvvKX6r4=;
 b=O/l/O7FBjbCWc9Qk6Xha0oTgzVKea3UPggAFF9ArwinQzvVemmYUgUidrzrTMWcUyJpw+N
 DYhJu7ADGyYPekwHITMBHqTmNDkUcbvm3tcDwLjz6AKTN4nRFfZq5Pdx2VtTiU+WXIC6zA
 1tGowKuwT9vB/blUxq4lOH9dKs+WGDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738863136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6pb0IqDA+7Xa4XD5HohUjev5daSHq0HsKilvvKX6r4=;
 b=T+mHXzCIuZOSIXRG9dik+8NtkMFNOOKZ46JV9HWaAdWFVrnYuTT6g2f6kcOCovyF+1gRro
 AiKcThlyShjVd6DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738863135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6pb0IqDA+7Xa4XD5HohUjev5daSHq0HsKilvvKX6r4=;
 b=cZxB8jlIkQmF1uZWCMlBDg7VkSBE2RAuOAXnVfMshnjyeVkgGG2FqS4MUi4rHHEtOkFiEI
 NJ3xIz89ygpcrGtZCIgguTHxYFb+34SpS4JsVOdgasL6zNiKkLIxtu7Vu9wEGZTweE2aaa
 moKF1faNqwdvc7jWJrw8/YEx0vHgcSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738863135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6pb0IqDA+7Xa4XD5HohUjev5daSHq0HsKilvvKX6r4=;
 b=c+YmhWk83Z5nDh5GaQFkOkSMDC+y/nJMA62rFoLxdOdmK7rJjqwaEUdC+CYQJxcAChzLw/
 8Fi9qAfgWUIc4hAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 227D613697;
 Thu,  6 Feb 2025 17:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BEM+NB7ypGf+XwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Feb 2025 17:32:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?Daniel_P=2E_Be?=
 =?utf-8?Q?rrang=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dri?=
 =?utf-8?Q?c?= Le Goater
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
In-Reply-To: <eba9c2d2-5a20-489c-aa89-8adde2781c7a@maciej.szmigiero.name>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
 <Z6Iy0wY-lsx3M71M@x1.local> <Z6I0mzWEsl5y57Zj@redhat.com>
 <87zfj0mcmy.fsf@suse.de> <87wme4m8ci.fsf@suse.de>
 <192db6a6-f3ff-4cf9-8537-b849fb3a97b3@maciej.szmigiero.name>
 <87tt97ma9l.fsf@suse.de>
 <ac6f56c0-58d9-45a4-bbf4-6b28649a8952@maciej.szmigiero.name>
 <87msezm75y.fsf@suse.de>
 <eba9c2d2-5a20-489c-aa89-8adde2781c7a@maciej.szmigiero.name>
Date: Thu, 06 Feb 2025 14:32:12 -0300
Message-ID: <87jza3m12b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 6.02.2025 16:20, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>=20
>>> On 6.02.2025 15:13, Fabiano Rosas wrote:
>>>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>>>
>>>>> On 5.02.2025 21:42, Fabiano Rosas wrote:
>>>>>> Fabiano Rosas <farosas@suse.de> writes:
>>>>>>
>>>>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>>>>>
>>>>>>>> On Tue, Feb 04, 2025 at 10:31:31AM -0500, Peter Xu wrote:
>>>>>>>>> On Tue, Feb 04, 2025 at 03:39:00PM +0100, Maciej S. Szmigiero wro=
te:
>>>>>>>>>> On 3.02.2025 23:56, Peter Xu wrote:
>>>>>>>>>>> On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero w=
rote:
>>>>>>>>>>>> On 3.02.2025 21:20, Peter Xu wrote:
>>>>>>>>>>>>> On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero=
 wrote:
>>>>>>>>>>>>>> On 3.02.2025 19:20, Peter Xu wrote:
>>>>>>>>>>>>>>> On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigie=
ro wrote:
>>>>>>>>>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Multifd send channels are terminated by calling
>>>>>>>>>>>>>>>> qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>>>>>>>>>>>>>>>> multifd_send_terminate_threads(), which in the TLS case es=
sentially
>>>>>>>>>>>>>>>> calls shutdown(SHUT_RDWR) on the underlying raw socket.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Unfortunately, this does not terminate the TLS session pro=
perly and
>>>>>>>>>>>>>>>> the receive side sees this as a GNUTLS_E_PREMATURE_TERMINA=
TION error.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The only reason why this wasn't causing migration failures=
 is because
>>>>>>>>>>>>>>>> the current migration code apparently does not check for m=
igration
>>>>>>>>>>>>>>>> error being set after the end of the multifd receive proce=
ss.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> However, this will change soon so the multifd receive code=
 has to be
>>>>>>>>>>>>>>>> prepared to not return an error on such premature TLS sess=
ion EOF.
>>>>>>>>>>>>>>>> Use the newly introduced QIOChannelTLS method for that.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> It's worth noting that even if the sender were to be chang=
ed to terminate
>>>>>>>>>>>>>>>> the TLS connection properly the receive side still needs t=
o remain
>>>>>>>>>>>>>>>> compatible with older QEMU bit stream which does not do th=
is.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If this is an existing bug, we could add a Fixes.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It is an existing issue but only uncovered by this patch set.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> As far as I can see it was always there, so it would need so=
me
>>>>>>>>>>>>>> thought where to point that Fixes tag.
>>>>>>>>>>>>>
>>>>>>>>>>>>> If there's no way to trigger a real functional bug anyway, it=
's also ok we
>>>>>>>>>>>>> omit the Fixes.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Two pure questions..
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>         - What is the correct way to terminate the TLS sess=
ion without this flag?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I guess one would need to call gnutls_bye() like in this Gnu=
TLS example:
>>>>>>>>>>>>>> https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbff=
b32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>         - Why this is only needed by multifd sessions?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> What uncovered the issue was switching the load threads to u=
sing
>>>>>>>>>>>>>> migrate_set_error() instead of their own result variable
>>>>>>>>>>>>>> (load_threads_ret) which you had requested during the previo=
us
>>>>>>>>>>>>>> patch set version review:
>>>>>>>>>>>>>> https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Turns out that the multifd receive code always returned
>>>>>>>>>>>>>> error in the TLS case, just nothing was previously checking =
for
>>>>>>>>>>>>>> that error presence.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What I was curious is whether this issue also exists for the =
main migration
>>>>>>>>>>>>> channel when with tls, especially when e.g. multifd not enabl=
ed at all.  As
>>>>>>>>>>>>> I don't see anywhere that qemu uses gnutls_bye() for any tls =
session.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I think it's a good to find that we overlooked this before.. =
and IMHO it's
>>>>>>>>>>>>> always good we could fix this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Does it mean we need proper gnutls_bye() somewhere?
>>>>>>>>>>>>>
>>>>>>>>>>>>> If we need an explicit gnutls_bye(), then I wonder if that sh=
ould be done
>>>>>>>>>>>>> on the main channel as well.
>>>>>>>>>>>>
>>>>>>>>>>>> That's a good question and looking at the code qemu_loadvm_sta=
te_main() exits
>>>>>>>>>>>> on receiving "QEMU_VM_EOF" section (that's different from rece=
iving socket EOF)
>>>>>>>>>>>> and then optionally "QEMU_VM_VMDESCRIPTION" section is read wi=
th explicit size
>>>>>>>>>>>> in qemu_loadvm_state() - so still not until channel EOF.
>>>>>>>>>>>
>>>>>>>>>>> I had a closer look, I do feel like such pre-mature termination=
 is caused
>>>>>>>>>>> by explicit shutdown()s of the iochannels, looks like that can =
cause issue
>>>>>>>>>>> even after everything is sent.  Then I noticed indeed multifd s=
ender
>>>>>>>>>>> iochannels will get explicit shutdown()s since commit 077fbb594=
2, while we
>>>>>>>>>>> don't do that for the main channel.  Maybe that is a major diff=
erence.
>>>>>>>>>>>
>>>>>>>>>>> Now I wonder whether we should shutdown() the channel at all if=
 migration
>>>>>>>>>>> succeeded, because looks like it can cause tls session to inter=
rupt even if
>>>>>>>>>>> the shutdown() is done after sent everything, and if so it'll e=
xplain why
>>>>>>>>>>> you hit the issue with tls.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Then I can't see anything else reading the channel until it is=
 closed in
>>>>>>>>>>>> migration_incoming_state_destroy().
>>>>>>>>>>>>
>>>>>>>>>>>> So most likely the main migration channel will never read far =
enough to
>>>>>>>>>>>> reach that GNUTLS_E_PREMATURE_TERMINATION error.
>>>>>>>>>>>>
>>>>>>>>>>>>> If we don't need gnutls_bye(), then should we always ignore p=
re-mature
>>>>>>>>>>>>> termination of tls no matter if it's multifd or non-multifd c=
hannel (or
>>>>>>>>>>>>> even a tls session that is not migration-related)?
>>>>>>>>>>>>
>>>>>>>>>>>> So basically have this patch extended to calling
>>>>>>>>>>>> qio_channel_tls_set_premature_eof_okay() also on the main migr=
ation channel?
>>>>>>>>>>>
>>>>>>>>>>> If above theory can stand, then eof-okay could be a workaround =
papering
>>>>>>>>>>> over the real problem that we shouldn't always shutdown()..
>>>>>>>>>>>
>>>>>>>>>>> Could you have a look at below patch and see whether it can fix=
 the problem
>>>>>>>>>>> you hit too, in replace of these two patches (including the pre=
vious
>>>>>>>>>>> iochannel change)?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Unfortunately, the patch below does not fix the problem:
>>>>>>>>>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS conne=
ction was non-properly terminated.
>>>>>>>>>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS conne=
ction was non-properly terminated.
>>>>>>>>>>
>>>>>>>>>> I think that, even in the absence of shutdown(), if the sender d=
oes not
>>>>>>>>>> call gnutls_bye() the TLS session is considered improperly termi=
nated.
>>>>>>>>>
>>>>>>>>> Ah..
>>>>>>>>>
>>>>>>>>> How about one more change on top of above change to disconnect pr=
operly for
>>>>>>>>> TLS?  Something like gnutls_bye() in qio_channel_tls_close(), wou=
ld that
>>>>>>>>> make sense to you?
>>>>>>>>
>>>>>>>> Calling gnutls_bye from qio_channel_tls_close is not viable for the
>>>>>>>> API contract of qio_channel_close. gnutls_bye needs to be able to
>>>>>>>> perform I/O, which means we need to be able to tell the caller
>>>>>>>> whether it needs to perform an event loop wait for POLLIN or POLLO=
UT.
>>>>>>>>
>>>>>>>> This is the same API design scenario as the gnutls_handshake metho=
d.
>>>>>>>> As such I tdon't think it is practical to abstract it inside any
>>>>>>>> existing QIOChannel API call, it'll have to be standalone like
>>>>>>>> qio_channel_tls_handshake() is.
>>>>>>>>
>>>>>>>
>>>>>>> I implemented the call to gnutls_bye:
>>>>>>> https://gitlab.com/farosas/qemu/-/commits/migration-tls-bye
>>>>>>>
>>>>>>> Then while testing it I realised we actually have a regression from=
 9.2:
>>>>>>>
>>>>>>> 1d457daf86 ("migration/multifd: Further remove the SYNC on complete=
")
>>>>>>>
>>>>>>> It seems that patch somehow affected the ordering between src shutd=
own
>>>>>>> vs. recv shutdown and now the recv channels are staying around to s=
ee
>>>>>>> the connection being broken. Or something... I'm still looking into=
 it.
>>>>>>>
>>>>>>
>>>>>> Ok, so the issue is that the recv side would previously be stuck at =
the
>>>>>> sync semaphore and multifd_recv_terminate_threads() would kick it on=
ly
>>>>>> after 'exiting' was set, so no further recv() would happen.
>>>>>>
>>>>>> After the patch, there's no final sync anymore, so the recv thread l=
oops
>>>>>> around and waits at the recv() until multifd_send_terminate_threads()
>>>>>> closes the connection.
>>>>>>
>>>>>> Waiting on sem_sync as before would lead to a cleaner termination
>>>>>> process IMO, but I don't think it's worth the extra complexity of
>>>>>> introducing a sync to the device state migration.
>>>>>>
>>>>>> So I think we'll have to go with one of the approaches suggested on =
this
>>>>>> thread (gnutls_bye or premature_ok). I'm fine either way, but let's =
make
>>>>>> sure we add a reference to the patch above and some words explaining=
 the
>>>>>> situation.
>>>>>
>>>>> We still need premature_ok for handling older QEMU versions that do n=
ot
>>>>> terminate the TLS stream correctly since the TLS test regression happ=
ens
>>>>> even without device state transfer being enabled.
>>>>
>>>> What exactly is the impact of this issue to the device state series?
>>>>   From the cover letter:
>>>>
>>>>     * qemu_loadvm_load_thread_pool now reports error via migrate_set_e=
rror()
>>>>     instead of dedicated load_threads_ret variable.
>>>>
>>>>     * Since the change above uncovered an issue with respect to multif=
d send
>>>>     channels not terminating TLS session properly QIOChannelTLS now al=
lows
>>>>     gracefully handling this situation.
>>>>
>>>> I understand qemu_loadvm_load_thread_pool() is attempting to use
>>>> migrate_set_error() but an error is already set by the recv_thread. Is
>>>> that the issue?
>>>
>>> Yes, when we test for load threads error in the TLS case we see that mu=
ltifd TLS
>>> one.
>>> We need to know whether the load threads succeeded so we either continu=
e with the
>>> migration or abort it.
>>>
>>>> I wonder if we could isolate somehow this so it doesn't
>>>> impact this series.
>>>
>>> The previous version simply used a dedicated load_threads_ret variable
>>> so it wasn't affected but Peter likes migrate_set_error() more for
>>> migration thread pools.
>>>=20=20=20=20
>>>>>
>>>>> So I think that's what we should use generally.
>>>>>=20=20=20=20=20
>>>>
>>>> For premature_ok, we need to make sure it will not hang QEMU if the
>>>> connection gets unexpectedly closed. The current code checks for
>>>> shutdown() having already happened, which is fine because it means we'=
re
>>>> already on the way out. However, if any ol' recv() can now ignore a
>>>> premature termination error, then the recv_thread will not trigger
>>>> cleanup of the multifd_recv threads.
>>>
>>> Enabling premature_ok just turns GNUTLS_E_PREMATURE_TERMINATION error
>>> on EOF into a normal EOF.
>>>
>>> The receive thread will exit on either one:
>>>>            if (ret =3D=3D 0 || ret =3D=3D -1) {   /* 0: EOF  -1: Error=
 */
>>>>                  break;
>>>>              }
>>>
>>> It's true that multifd_recv_terminate_threads() will only be called
>>> by multifd_recv_cleanup() or multifd_recv_shutdown() in this case,
>>> however this is already the case for non-TLS migration.
>>>
>>=20
>> My point is that a premature termination sets local_err and a
>> premature_ok=3D=3Dtrue doesn't.=20
>
> * Only in the TLS case - the non-TLS doesn't set any error even with
> premature_ok=3D=3Dtrue (assuming there hasn't been any other error during
> receive)
>
> * If there *has* been other any other error during receive then it
> will be set and the code flow will be the same even with premature_ok=3D=
=3Dtrue.
>

Sure, I'm not implying the change affects non-TLS. I'm just arguing that
non-TLS behavior should not be taken into consideration because it
doesn't ignore any errors anyway.

The whole (and only) point I'm making is what happens when
e.g. multifd_send shuts down the connection prematurely due to a
bug. IIUC, premature_ok would make that be treated as normal EOF in
multifd_recv and that is a problem because any thread that sees an error
should terminate all others instead of just exiting.

Currently, GNUTLS_E_PREMATURE_TERMINATION doesn't abort migration, but
it does cause multifd_recv_terminate_threads() to be executed. The
change from this series will make it so that
GNUTLS_E_PREMATURE_TERMINATION never leads to
multifd_recv_terminate_threads(), while the correct behavior would be to
trigger cleanup always, except for the very last recv().

>> So it's not the same as non-TLS migration
>> because there we don't have a way to ignore any errors.
>
> The GNUTLS_E_PREMATURE_TERMINATION error can't happen in the non-TLS case
> so by definition we can't ignore it in the non-TLS case.
>
> And we don't ignore any other error in the TLS/non-TLS case.
>
>> Multifd recv threads can't discern an EOF in the middle of the migration
>> from an EOF after all data has been received. The former is definitely
>> an error and should cause migration to abort, multifd threads to
>> cleanup, etc.
>
> So in this case we should set the QIO_CHANNEL_READ_RELAXED_EOF flag on
> the multifd channel recv thread main loop only, and leave the
> mid-stream page receive methods report GNUTLS_E_PREMATURE_TERMINATION
> as usual.
>

The multifd recv loop is where I don't want to have RELAXED_EOF. Except
for the last recv() call. Which of course we can't differentiate unless
we use something like gnutls_bye() of MULTIFD_FLAG_EOS as you suggest
below.

> This makes the TLS case work the same with respect to premature
> EOF as the non-TLS case since the non-TLS case can't detect premature
> EOF in the multifd channel recv thread main loop either.
>
>>> So if there was a bug with multifd threads shutdown it would have
>>> already been manifesting on the non-TLS migration.
>>>
>>=20
>> Even if non-TLS behaved the same, why would we choose to port a bug to
>> the TLS implementation?
>>=20
>> We could of course decide at this point to punt the problem forward and
>> when it shows up, we'd have to go implement gnutls_bye() to allow the
>> distinction between good-EOF/bad-EOF or maybe add an extra sync at the
>> end of migration to make sure the last recv() call is only started after
>> the source has already shutdown() the channel.
>
> If we do some kind of a premature EOF detection then it should probably
> work for the non-TLS case too (since that's probably by far the most
> common use case).
> So adding some MULTIFD_FLAG_EOS would make the most sense and would work
> even with QIO_CHANNEL_READ_RELAXED_EOF being set.
>

Indeed, if MULTIFD_FLAG_EOS is not seen, the recv thread could treat any
EOF as an error. The question is whether we can add that without
disrupting multifd synchronization too much.

> In any case we'd still need some kind of a compatibility behavior for
> the TLS bit stream emitted by older QEMU versions (which is always
> improperly terminated).
>

There is no compat issue. For <=3D 9.2, QEMU is still doing an extra
multifd_send_sync_main(), which results in an extra MULTIFD_FLAG_SYNC on
the destination and it gets stuck waiting for the
RAM_SAVE_FLAG_MULTIFD_FLUSH that never comes. Therefore the src always
closes the connection before dst reaches the extra recv().

I test migration both ways with 2 previous QEMU versions and the
gnutls_bye() series passes all tests. I also put an assert at
tlssession.c and never triggers for GNUTLS_E_PREMATURE_TERMINATION. The
MULTIFD_FLAG_EOS should behave the same.

