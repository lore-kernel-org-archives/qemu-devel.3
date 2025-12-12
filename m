Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173D7D59D95
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 21:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUAew-0006aP-QM; Fri, 12 Dec 2025 16:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vUAeu-0006ZH-H5
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 16:26:40 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vUAes-0006a8-GB
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 16:26:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B625E33696;
 Fri, 12 Dec 2025 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765574796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0A06cF7I5UP/VBr+lEisLZkWfnv9ku1yUfhdy4TGoI=;
 b=PWlsX/TZ4Xp3pXFdtfPBLY2R0QeNHVf6slcRce9S+4w/lzCRWiVotAToL3MjjOhIhfwxCC
 2mKTRASSlx388m0CODGmt+Nxu6fmbKIBU525eXw0vijHn/nIIXRkOwiHS2LP8qFrr6L73v
 NA0esnTRzc9QjU0lSXc1vH/+uWgdq3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765574796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0A06cF7I5UP/VBr+lEisLZkWfnv9ku1yUfhdy4TGoI=;
 b=rkKzTgGcDgNR0nikxtW+xSzNl3VaHimMdVrzboMHSWiix0k0MAzPck6p3H7klcymbWVmwG
 5OnIfYe/8XcgmTDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JFba8xQf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FYFC9LsA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765574795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0A06cF7I5UP/VBr+lEisLZkWfnv9ku1yUfhdy4TGoI=;
 b=JFba8xQfwRWQLgeTvPGGFfZH7GkZua+ck2+0kH4aSoLf4YhmdzNJxUVfOnMZjpA2hANiHX
 yZ+idBE2UoSaXQLgWsTvai5WyZcazFUdqjZ+oQ/+XbYU3SMmkJtyOTiegikiUPw1VSYZks
 p8hGp5rD6bqQIgyjt+GGeSQcMnhe18s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765574795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0A06cF7I5UP/VBr+lEisLZkWfnv9ku1yUfhdy4TGoI=;
 b=FYFC9LsAKq53PT3TmMfu7eh6tzrJyeBHMLGFRbxT/KM/A1arms5rkRwMnuQ/DPuhAMuoK6
 S9QASJYWCfU0rQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 253823EA63;
 Fri, 12 Dec 2025 21:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +XdCNYqIPGknOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Dec 2025 21:26:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
In-Reply-To: <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora> <87jyyxkna0.fsf@suse.de>
 <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com>
Date: Fri, 12 Dec 2025 18:26:32 -0300
Message-ID: <87jyyrv1br.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B625E33696
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Thomas Huth <thuth@redhat.com> writes:

> On 08/12/2025 16.26, Fabiano Rosas wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>>> On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> When shutting down a guest that is currently in progress of being
>>>> migrated, there is a chance that QEMU might crash during bdrv_delete().
>>>> The backtrace looks like this:
>>>>
>>>>   Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
>>>>
>>>>   [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
>>>>   0x000002aa00664012 in bdrv_delete (bs=3D0x2aa00f875c0) at ../../deve=
l/qemu/block.c:5560
>>>>   5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
>>>>   (gdb) bt
>>>>   #0  0x000002aa00664012 in bdrv_delete (bs=3D0x2aa00f875c0) at ../../=
devel/qemu/block.c:5560
>>>>   #1  bdrv_unref (bs=3D0x2aa00f875c0) at ../../devel/qemu/block.c:7170
>>>>   Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
>>>>
>>=20
>> How does the migration thread reaches here? Is this from
>> migration_block_inactivate()?
>
> Unfortunately, gdb was not very helpful here (claiming that it cannot acc=
ess=20
> the memory and stack anymore), so I had to do some printf debugging. This=
 is=20
> what seems to happen:
>
> Main thread:=C2=A0qemu_cleanup() calls =C2=A0migration_shutdown()=C2=A0--=
>=20
> migration_cancel() which signals the migration thread to cancel the migra=
tion.
>
> Migration thread: migration_thread() got kicked out the loop and calls=20
> migration_iteration_finish(), which tries to get the BQL via bql_lock() b=
ut=20
> that is currently held by another thread, so the migration thread is bloc=
ked=20
> here.
>
> Main thread: qemu_cleanup() advances to bdrv_close_all() that uses=20
> blockdev_close_all_bdrv_states() to unref all BDS. The BDS with the name=
=20
> 'libvirt-1-storage' gets deleted via bdrv_delete() that way.
>

Has qmp_blockdev_del() ever been called to remove the BDS from the
monitor_bdrv_states list? Otherwise your debugging seems to indicate
blockdev_close_all_bdrv_states() is dropping the last reference to bs,
but it's still accessible from bdrv_next() via
bdrv_next_monitor_owned().

> Migration thread: Later, migration_iteration_finish() finally gets the BQ=
L,=20
> and calls the migration_block_activate() function in the=20
> MIGRATION_STATUS_CANCELLING case statement. This calls bdrv_activate_all(=
).
> bdrv_activate_all() gets a pointer to that 'libvirt-1-storage' BDS again=
=20
> from bdrv_first(), and during the bdrv_next() that BDS gets unref'ed agai=
n=20
> which is causing the crash.
>
> =3D=3D> Why is bdrv_first() still providing a BDS that have been deleted =
by=20
> other threads earlier?
>

>>> It sounds like the migration thread does not hold block graph refcounts
>>> and assumes the BlockDriverStates it uses have a long enough lifetime.
>>>
>>> I don't know the migration code well enough to say whether joining in
>>> migration_shutdown() is okay. Another option would be expicitly holding
>>> the necessary refcounts in the migration thread.
>>=20
>> I agree. In principle and also because shuffling the joining around
>> feels like something that's prone to introduce other bugs.
>
> I'm a little bit lost here right now ... Can you suggest a place where we=
=20
> would need to increase the refcounts in the migration thread?
>
>   Thomas

