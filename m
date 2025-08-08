Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D975C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNZJ-0000pt-B4; Fri, 08 Aug 2025 09:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ukNZF-0000fz-73
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:55:33 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ukNZD-0003Hk-3F
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:55:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42D2A5BDE0;
 Fri,  8 Aug 2025 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754661329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebUv/lW/3otBN7J5qDCgoYzpyYeZOYc7iBmL8EHKxAc=;
 b=oUBfcxufjpv1eaMW5MjMXxkEkMcVLRkOeQSE1MkumCenr4M6Gsftxcq1JuA0H+qkdZWdz8
 4xUvugARryGNWkwuoNaQwB1GxBA4cYoYA8mz8Xn2ibHr9OCywzCXK3Qi4WnuLQK5q4IQ7w
 57pNqw9nKxSAUMRZaY55QUN0owhrHIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754661329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebUv/lW/3otBN7J5qDCgoYzpyYeZOYc7iBmL8EHKxAc=;
 b=/jMVmqmKXePMd+1Mk3Ec+XJushxFBbv0bXzrgY2Nn73MfaTrGWMlq1DTuVcJX9LYaovGTm
 Ocm6dxBaBrQdhFAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754661329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebUv/lW/3otBN7J5qDCgoYzpyYeZOYc7iBmL8EHKxAc=;
 b=oUBfcxufjpv1eaMW5MjMXxkEkMcVLRkOeQSE1MkumCenr4M6Gsftxcq1JuA0H+qkdZWdz8
 4xUvugARryGNWkwuoNaQwB1GxBA4cYoYA8mz8Xn2ibHr9OCywzCXK3Qi4WnuLQK5q4IQ7w
 57pNqw9nKxSAUMRZaY55QUN0owhrHIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754661329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebUv/lW/3otBN7J5qDCgoYzpyYeZOYc7iBmL8EHKxAc=;
 b=/jMVmqmKXePMd+1Mk3Ec+XJushxFBbv0bXzrgY2Nn73MfaTrGWMlq1DTuVcJX9LYaovGTm
 Ocm6dxBaBrQdhFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B09111392A;
 Fri,  8 Aug 2025 13:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tjePG9ABlmgXKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Aug 2025 13:55:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yong Huang <yong.huang@smartx.com>, Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
In-Reply-To: <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
Date: Fri, 08 Aug 2025 10:55:25 -0300
Message-ID: <87o6sp2a0i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[smartx.com,web.de];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
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

Yong Huang <yong.huang@smartx.com> writes:

> On Fri, Aug 8, 2025 at 3:02=E2=80=AFPM Lukas Straub <lukasstraub2@web.de>=
 wrote:
>
>> On Fri, 8 Aug 2025 10:36:24 +0800
>> Yong Huang <yong.huang@smartx.com> wrote:
>>
>> > On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub <lukasstraub2@web.=
de> wrote:
>> >
>> > > On Thu,  7 Aug 2025 10:41:17 +0800
>> > > yong.huang@smartx.com wrote:
>> > >
>> > > > From: Hyman Huang <yong.huang@smartx.com>
>> > > >
>> > > > When there are network issues like missing TCP ACKs on the send
>> > > > side during the multifd live migration. At the send side, the error
>> > > > "Connection timed out" is thrown out and source QEMU process stop
>> > > > sending data, at the receive side, The IO-channels may be blocked
>> > > > at recvmsg() and thus the main loop gets stuck and fails to respond
>> > > > to QMP commands consequently.
>> > > > ...
>> > >
>> > > Hi Hyman Huang,
>> > >
>> > > Have you tried the 'yank' command to shutdown the sockets? It exactly
>> > > meant to recover from hangs and should solve your issue.
>> > >
>> > >
>> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#yank-feature
>> >
>> >
>> > Thanks for the comment and advice.
>> >
>> > Let me give more details about the migration state when the issue
>> happens:
>> >
>> > On the source side, libvirt has already aborted the migration job:
>> >
>> > $ virsh domjobinfo fdecd242-f278-4308-8c3b-46e144e55f63
>> > Job type:         Failed
>> > Operation:        Outgoing migration
>> >
>> > QMP query-yank shows that there is no migration yank instance:
>> >
>> > $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
>> > '{"execute":"query-yank"}' --pretty
>> > {
>> >   "return": [
>> >     {
>> >       "type": "chardev",
>> >       "id": "charmonitor"
>> >     },
>> >     {
>> >       "type": "chardev",
>> >       "id": "charchannel0"
>> >     },
>> >     {
>> >       "type": "chardev",
>> >       "id": "libvirt-2-virtio-format"
>> >     }
>> >   ],
>> >   "id": "libvirt-5217"
>> > }
>>
>> You are supposed to run it on the destination side, there the migration
>> yank instance should be present if qemu hangs in the migration code.
>>
>> Also, you need to execute it as an out-of-band command to bypass the
>> main loop. Like this:
>>
>> '{"exec-oob": "yank", "id": "yank0", "arguments": {"instances": [ {"type=
":
>> "migration"} ] } }'
>
> In our case, Libvirt's operation about the VM on the destination side has
> been blocked
> by Migration JOB:
>
> $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
> '{"query-commands"}' --pretty
> error: Timed out during operation: cannot acquire state change lock (held
> by monitor=3DremoteDispatchDomainMigratePrepare3Params)
> Using Libvirt to issue the yank command can not be taken into account.
>
>
>>
>>
>> I'm not sure if libvirt can do that, maybe you need to add an
>> additional qmp socket and do it outside of libvirt. Note that you need
>> to enable the oob feature during qmp negotiation, like this:
>>
>> '{ "execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }'
>
>
> No, I checked Libvirt's source code and figured out that when the QEMU
> monitor is initialized, Libvirt by default disables the OOB.
>
> Therefore, perhaps we can first enable the OOB and add the yank capability
> to Libvirt then adding the yank logic to the necessary path=E2=80=94in our
> instance, the migration code:
>
> qemuMigrationDstFinish=EF=BC=9A
>     if (retcode !=3D 0) {
>         /* Check for a possible error on the monitor in case Finish was c=
alled
>          * earlier than monitor EOF handler got a chance to process the e=
rror
>          */
>         qemuDomainCheckMonitor(driver, vm, QEMU_ASYNC_JOB_MIGRATION_IN);
>         goto endjob;
>     }
>
>
>
>>
>> Regards,
>> Lukas Straub
>>
>> >
>> > The libvirt migration job is stuck as the following backtrace shows; it
>> > shows that migration is waiting for the "Finish" RPC on the destination
>> > side to return.
>> >
>> > ...
>> >
>> > IMHO, the key reason for the issue is that QEMU fails to run the main
>> loop
>> > and fails to respond to QMP, which is not what we usually expected.
>> >
>> > Giving the Libvirt a window of time to issue a QMP and kill the VM is =
the
>> > ideal solution for this issue; this provides an automatic method.
>> >
>> > I do not dig the yank feature, perhaps it is helpful, but only manuall=
y?
>> >
>> > After all, these two options are not exclusive of one another,  I thin=
k.
>> >

Please work with Lukas to figure out whether yank can be used here. I
think that's the correct approach. If the main loop is blocked, then
some out-of-band cancellation routine is needed. migrate_cancel() could
be it, but at the moment it's not. Yank is the second best thing.

The need for a timeout is usually indicative of a design issue. In this
case, the choice of a coroutine for the incoming side is the obvious
one. Peter will tell you all about it! =3D)

