Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7B2C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWdY-0007Yg-8P; Tue, 05 Mar 2024 10:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhWdU-0007XP-Tc
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:23:20 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhWdS-00020j-3Y
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:23:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA8ED774BB;
 Tue,  5 Mar 2024 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709652192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hkk9YhglkhBSGXowRfLIaqX2rEpN5bWcxYkCzRuLDcM=;
 b=YmeEJGtGrJk+od6wadE0gKl+CSxnO9tps0I0Xy10O28zEhAV9lvSjVcgBFj+8LHjkgsWkP
 GJpMfhTdSLBb6YPMp3AANpMln1xj7D421SbT7RZI7FOLyT8EZxhNWO2TttUrmV60cSLmL8
 QWaNYvCpUf/WPTDrXo197SF59CcQipg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709652192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hkk9YhglkhBSGXowRfLIaqX2rEpN5bWcxYkCzRuLDcM=;
 b=05txm0/MgnhuF1vVWsrV+tR4lTLmy1mEDi4Vcm0Qh+10XwbQAXkRbT2U4tz+zo/HkvGi14
 nkmyNgT+xGnRj0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709652192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hkk9YhglkhBSGXowRfLIaqX2rEpN5bWcxYkCzRuLDcM=;
 b=YmeEJGtGrJk+od6wadE0gKl+CSxnO9tps0I0Xy10O28zEhAV9lvSjVcgBFj+8LHjkgsWkP
 GJpMfhTdSLBb6YPMp3AANpMln1xj7D421SbT7RZI7FOLyT8EZxhNWO2TttUrmV60cSLmL8
 QWaNYvCpUf/WPTDrXo197SF59CcQipg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709652192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hkk9YhglkhBSGXowRfLIaqX2rEpN5bWcxYkCzRuLDcM=;
 b=05txm0/MgnhuF1vVWsrV+tR4lTLmy1mEDi4Vcm0Qh+10XwbQAXkRbT2U4tz+zo/HkvGi14
 nkmyNgT+xGnRj0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 335B713A5B;
 Tue,  5 Mar 2024 15:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 866DOt8452X/bAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Mar 2024 15:23:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Claudio Fontana
 <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
In-Reply-To: <ZeZ6pI0O4-3ZQ10A@x1n>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com> <ZeXEROyMmHffj1b2@x1n>
 <ZeXIoVho09HtXKQQ@x1n> <87r0gp21py.fsf@suse.de>
 <ZeY3c-zFV-i1mrrP@redhat.com> <ZeZ6pI0O4-3ZQ10A@x1n>
Date: Tue, 05 Mar 2024 12:23:09 -0300
Message-ID: <87bk7sitya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YmeEJGtG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="05txm0/M"
X-Spamd-Result: default: False [-5.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AA8ED774BB
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Mar 04, 2024 at 09:04:51PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, Mar 04, 2024 at 05:15:05PM -0300, Fabiano Rosas wrote:
>> > Peter Xu <peterx@redhat.com> writes:
>> >=20
>> > > On Mon, Mar 04, 2024 at 08:53:24PM +0800, Peter Xu wrote:
>> > >> On Mon, Mar 04, 2024 at 12:42:25PM +0000, Daniel P. Berrang=C3=A9 w=
rote:
>> > >> > On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
>> > >> > > Fabiano,
>> > >> > >=20
>> > >> > > On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
>> > >> > > > =3D> guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop =
dirtying memory
>> > >> > >=20
>> > >> > > I'm curious normally how much time does it take to do the final=
 fdatasync()
>> > >> > > for you when you did this test.
>> >=20
>> > I measured and it takes ~4s for the live migration and ~2s for the
>> > non-live. I didn't notice this before because the VM goes into
>> > postmigrate, so it's paused anyway.
>
> For my case it took me tens of seconds at least, if not go into minutes,
> which I didn't measure.
>
> I could have dirtied harder, or I just had a slower disk.  IIUC the worst
> case is all cache dirty (didn't yet writeback in the kernel), say 100GB,
> assuming the disk bandwidth 1GB/s (that's the bw of my test machine hard
> drive of 1M chunk dd for a 10GB file, even without a sync..), IIUC it mea=
ns
> it could take 1min or more in reality.
>
>> >=20
>> > >> > >=20
>> > >> > > I finally got a relatively large system today and gave it a qui=
ck shot over
>> > >> > > 128G (100G busy dirty) mapped-ram snapshot with 8 multifd chann=
els.  The
>> > >> > > migration save/load does all fine, so I don't think there's any=
thing wrong
>> > >> > > with the patchset, however when save completes (I'll need to st=
op the
>> > >> > > workload as my disk isn't fast enough I guess..) I'll always hi=
t a super
>> > >> > > long hang of QEMU on fdatasync() on XFS during which the main t=
hread is in
>> > >> > > UNINTERRUPTIBLE state.
>> > >> >=20
>> > >> > That isn't very surprising. If you don't have O_DIRECT enabled, t=
hen
>> > >> > all that disk I/O from the migrate is going to be in RAM, and thu=
s the
>> > >> > fdatasync() is likely to trigger writing out alot of data.
>> > >> >=20
>> > >> > Blocking the main QEMU thread though is pretty unhelpful. That su=
ggests
>> > >> > the data sync needs to be moved to a non-main thread.
>> > >>=20
>> > >> Perhaps migration thread itself can also be a candidate, then.
>> > >>=20
>> > >> >=20
>> > >> > With O_DIRECT meanwhile there should be essentially no hit from f=
datasync.
>> > >>=20
>> > >> The update of COMPLETED status can be a good place of a marker poin=
t to
>> > >> show such flush done if from the gut feeling of a user POV.  If tha=
t makes
>> > >> sense, maybe we can do that sync before setting COMPLETED.
>> >=20
>> > At the migration completion I believe the multifd threads will have
>> > already cleaned up and dropped the reference to the channel, it might =
be
>> > too late then.
>> >=20
>> > In the multifd threads, we'll be wasting (like we are today) the extra
>> > syscalls after the first sync succeeds.
>> >=20
>> > >>=20
>> > >> No matter which thread does that sync, it's still a pity that it'll=
 go into
>> > >> UNINTERRUPTIBLE during fdatasync(), then whoever wants to e.g. atta=
ch a gdb
>> > >> onto it to have a look will also hang.
>> > >
>> > > Or... would it be nicer we get rid of the fdatasync() but leave that=
 for
>> > > upper layers?  QEMU used to support file: migration already, it never
>> > > manage cache behavior; it does smell like something shouldn't be don=
e in
>> > > QEMU when thinking about it, at least mapped-ram is nothing special =
to me
>> > > from this regard.
>> > >
>> > > User should be able to control that either manually (sync), or Libvi=
rt can
>> > > do that after QEMU quits; after all Libvirt holds the fd itself?  It=
 should
>> > > allow us to get rid of above UNINTERRUPTIBLE / un-debuggable period =
of QEMU
>> > > went away.  Another side benefit: rather than holding all of QEMU re=
sources
>> > > (especially, guest RAM) when waiting for a super slow disk flush, Li=
bvirt /
>> > > upper layer can do that separately after releasing all the QEMU reso=
urces
>> > > first.
>> >=20
>> > I like the idea of QEMU having a self-contained
>> > implementation. Specially since we'll add O_DIRECT support, which is
>> > already quite heavy-handed if we're talking about managing cache
>> > behavior.
>
> O_DIRECT is optionally selected by the user by setting the new parameter
> first, so the user is still in full control - it's still user's decision =
on
> how cache should be managed, even if QEMU needs explicit changes to suppo=
rt
> and expose the new parameter.
>
> For fdatasync(), I think it's slightly different in that it doesn't requi=
re
> anything implemented in QEMU, as the snapshot is always in the form of a
> file, and file is pretty common concept which well supports sync semantics
> separately.  Instead of providing yet another parameter to control it, we
> can just avoid that datasync.
>
> Besides what I already described above as reasons, I think it's also legal
> if an user wants to temporarily flush a VM into a disk (in paused state),
> run some RAM-intense loads (which can immediately make use of guest's RAM
> which is directly freed, but may _not_ always require a page cache flush),
> then relaunch the VM.  In that case keeping some cache around might help
> already to speedup relaunching to avoid unnecessary swap-ins/swap-outs.
>
>> >=20
>> > However, it's not trivial to find the right place to add the sync.
>> > Wherever we put it there will be some implications, such as ensuring t=
he
>> > sync works even after migration failure, avoiding concurrent cleanup,
>> > etc.
>> >=20
>> > In any case, I don't think it's correct to have the sync at
>> > qio_channel_close(), now that we've seen it might block for a long
>> > time. We could at the very least have a qio_channel_flush()[1] which t=
he
>> > QIOChannelFile implements with fdatasync(). Then the clients can choose
>> > when to sync.
>>=20
>> Yes, I agree with de-coupling it.
>
> Yes, that decoupling makes sense to me.  That definitely answers some of =
my
> previous confusions.
>
> The following question is whether we should require a qio_channel_flush()
> by default at anywhere around the end of migration for mapped-ram, in whi=
ch
> case I lean towards removing it completely.  In all cases, considering the
> time it could hang qemu (possible in minutes) we may want to change that
> behavior for 9.0 if possible.

Ok, I'll remove it for 9.0 then. And I guess I'll also remove the flush
completely since there are no other users except for migration.

