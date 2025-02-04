Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1C6C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNcW-00057V-VC; Tue, 04 Feb 2025 13:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfNcS-0004xC-0h
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:25:56 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfNcP-00030D-ES
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:25:55 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23A4A1F387;
 Tue,  4 Feb 2025 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738693548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVI+tAyFTbqU6QJKAiO0eivVRy1jp1V+Y59sEP8DsMQ=;
 b=uldUurxkeLvv+VgPLThPm+hz0KnBle/frSw4L4mI1cRAgmzue7Q63dt9W3grpELBZ+zMpL
 WiIenozfyI/e1cokw9G3H3gZGw9I9CUXxd8ekBcN4G/ryhKJETsnKRN04p7XghhPJoVPLI
 iaXuIAhyONlLbNdiEkdunj85sWYKBgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738693548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVI+tAyFTbqU6QJKAiO0eivVRy1jp1V+Y59sEP8DsMQ=;
 b=OdMn85AHNsAp514u9DNXPWcGnasp0bTzbaa5vHx9O9fYiXqs5R2QWCDnppY/ibhCO7tr50
 NrmkUicE+afifWCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738693548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVI+tAyFTbqU6QJKAiO0eivVRy1jp1V+Y59sEP8DsMQ=;
 b=uldUurxkeLvv+VgPLThPm+hz0KnBle/frSw4L4mI1cRAgmzue7Q63dt9W3grpELBZ+zMpL
 WiIenozfyI/e1cokw9G3H3gZGw9I9CUXxd8ekBcN4G/ryhKJETsnKRN04p7XghhPJoVPLI
 iaXuIAhyONlLbNdiEkdunj85sWYKBgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738693548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVI+tAyFTbqU6QJKAiO0eivVRy1jp1V+Y59sEP8DsMQ=;
 b=OdMn85AHNsAp514u9DNXPWcGnasp0bTzbaa5vHx9O9fYiXqs5R2QWCDnppY/ibhCO7tr50
 NrmkUicE+afifWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 999BE1393E;
 Tue,  4 Feb 2025 18:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VEswGKtbomcuOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 04 Feb 2025 18:25:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
In-Reply-To: <Z6I6FF_4r_uVUlWU@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local> <Z6ItUtb-NhKnn8hy@redhat.com>
 <Z6I6FF_4r_uVUlWU@x1.local>
Date: Tue, 04 Feb 2025 15:25:41 -0300
Message-ID: <874j19o9cq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Tue, Feb 04, 2025 at 03:08:02PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, Feb 03, 2025 at 01:20:01PM -0500, Peter Xu wrote:
>> > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
>> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>> > >=20
>> > > Multifd send channels are terminated by calling
>> > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>> > > multifd_send_terminate_threads(), which in the TLS case essentially
>> > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
>> > >=20
>> > > Unfortunately, this does not terminate the TLS session properly and
>> > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
>> > >=20
>> > > The only reason why this wasn't causing migration failures is because
>> > > the current migration code apparently does not check for migration
>> > > error being set after the end of the multifd receive process.
>> > >=20
>> > > However, this will change soon so the multifd receive code has to be
>> > > prepared to not return an error on such premature TLS session EOF.
>> > > Use the newly introduced QIOChannelTLS method for that.
>> > >=20
>> > > It's worth noting that even if the sender were to be changed to term=
inate
>> > > the TLS connection properly the receive side still needs to remain
>> > > compatible with older QEMU bit stream which does not do this.
>> >=20
>> > If this is an existing bug, we could add a Fixes.
>> >=20
>> > Two pure questions..
>> >=20
>> >   - What is the correct way to terminate the TLS session without this =
flag?
>> >=20
>> >   - Why this is only needed by multifd sessions?
>>=20
>> Graceful TLS termination (via gnutls_bye()) should only be important to
>> security if the QEMU protocol in question does not know how much data it
>> is expecting to recieve. ie it cannot otherwise distinguish between an
>> expected EOF, and a premature EOF triggered by an attacker.
>>=20
>> If the migration protocol has sufficient info to know when a chanel is
>> expected to see EOF, then we should stop trying to read from the TLS
>> channel before seeing the underlying EOF.
>>=20
>> Ignoring GNUTLS_E_PREMATURE_TERMINATION would be valid if we know that
>> migration will still fail corretly in the case of a malicious attack
>> causing premature termination.
>>=20
>> If there's a risk that migration may succeed, but with incomplete data,
>> then we would need the full gnutls_bye dance.
>
> IIUC that's not required for migration then, because migration should know
> exactly how much data to receive, and migration should need to verify that
> and fail if the received data didn't match the expectation along the way.
> We also have QEMU_VM_EOF as the end mark of stream.

The migration overall can detect whether EOF should have been reached,
but multifd threads cannot. If one multifd channel experiences an issue
and sees a premature termination, but ignores it, then that's a hang in
QEMU because nothing provided the syncs needed (p->sem_sync, most
likely).

Aren't we just postponing a bug?

>
> Said that, are we sure any pre-mature termination will only happen after
> all data read in the receive buffer that was sent?
>
> To ask in another way: what happens if the source QEMU sends everything a=
nd
> shutdown()/close() the channel, meanwhile the dest QEMU sees both (1) rest
> data to read, and (2) a pre-mature terminatino of TLS session in a read()
> syscall.  Would (2) be reported even before (1), or the order guaranteed
> that read of the residue data in (1) always happen before (2) (considering
> dest QEMU can be slow sometime on consuming the network buffers)?
>
> Thanks,

