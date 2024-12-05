Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AF9E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBl0-0005Gf-I3; Thu, 05 Dec 2024 08:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJBkz-0005GX-AC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:19:01 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJBkx-0000bI-OJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:19:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28DD71F396;
 Thu,  5 Dec 2024 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733404737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnRMnqey/FjFBwms8cvqMCE6d57Vif9yJwwvQ/4sc4o=;
 b=P7tWTdCYPwwpYPHg/O8bZYNwv0qK8+cB94RWea7cym/tiIK4K5/WEb+rUV5FGt/eG8U96p
 F/NXh3Xgczf7Egn8WmGg+iQyAai+ZzJJ/w/39bH96vjsOcyiWrgiwH3ePkGNiUmYTzb731
 hp8hS67a0nshojHWsq/6cak3q6cyr94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733404737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnRMnqey/FjFBwms8cvqMCE6d57Vif9yJwwvQ/4sc4o=;
 b=x7h+/p+kzBaRL5T1WLQLKA0N/x37eh5Slq2rEP4/AyIpvFgGefQVbV4gl3KKKYZ1qEuUQk
 QHZumhn4/B+dnqAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733404737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnRMnqey/FjFBwms8cvqMCE6d57Vif9yJwwvQ/4sc4o=;
 b=P7tWTdCYPwwpYPHg/O8bZYNwv0qK8+cB94RWea7cym/tiIK4K5/WEb+rUV5FGt/eG8U96p
 F/NXh3Xgczf7Egn8WmGg+iQyAai+ZzJJ/w/39bH96vjsOcyiWrgiwH3ePkGNiUmYTzb731
 hp8hS67a0nshojHWsq/6cak3q6cyr94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733404737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnRMnqey/FjFBwms8cvqMCE6d57Vif9yJwwvQ/4sc4o=;
 b=x7h+/p+kzBaRL5T1WLQLKA0N/x37eh5Slq2rEP4/AyIpvFgGefQVbV4gl3KKKYZ1qEuUQk
 QHZumhn4/B+dnqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A679A132EB;
 Thu,  5 Dec 2024 13:18:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0GpcGkCoUWeqRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Dec 2024 13:18:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
In-Reply-To: <Z1GF7KheH_z5E1lc@redhat.com>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
 <Z1C1V25wydbBlsMb@redhat.com> <Z1DAzzB1SfY_bL17@x1n>
 <Z1GF7KheH_z5E1lc@redhat.com>
Date: Thu, 05 Dec 2024 10:18:53 -0300
Message-ID: <87bjxqi7ya.fsf@suse.de>
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
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Dec 04, 2024 at 03:51:27PM -0500, Peter Xu wrote:
>> On Wed, Dec 04, 2024 at 08:02:31PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> > I would say the difference is like a graceful shutdown vs pulling the
>> > power plug in a bare metal machine
>> >=20
>> > 'cancel' is intended to be graceful. It should leave you with a functi=
onal
>> > QEMU (or refuse to run if unsafe).
>> >=20
>> > 'yank' is intended to be forceful, letting you get out of bad situatio=
ns
>> > that would otherwise require you to kill the entire QEMU process, but
>> > still with possible associated risk data loss to the QEMU backends.
>> >=20
>> > They have overlap, but are none the less different.
>>=20
>> The question is more about whether yank should be used at all for
>> migration only, not about the rest instances.
>>=20
>> My answer is yank should never be used for migration, because
>> "migrate_cancel" also unplugs the power plug.. It's not anything more
>> enforced.  It's only doing less always.
>>=20
>> E.g. migration_yank_iochannel() is exactly what we do with
>> qmp_migrate_cancel() in the first place, only that migrate_cancel only d=
oes
>> it on the main channel (on both qemufiles even if ioc is one), however it
>> should be suffice, and behave the same way, as strong as "yank".
>
> I recall at the time the yank stuff was introduced, one of the scenarios
> they were concerned about was related to locks held by QEMU code. eg that
> there are scenarios where migrate_cancel may not be processed promptly
> enough due to being stalled on mutexes held by other concurrently running
> threads. Now I would expect any such long duration stalls on migration
> mutexes to be bugs, but the intent of yank is to give a recovery mechanism
> that can workaround such bugs.  The yank QMP command only interacts with
> its own local mutexes.

Ok, so that could only mean a thread stuck in recv() while holding the
BQL. I don't think we have any other locks which would stop
migrate_cancel from making progress or other stall situations that could
be helped by a shutdown(). Note that most of locks around qemu_file were
a late addition. I don't think that scenario is possible today. I'll
have to do some tests.

On that note, how is yank supposed to be accessed? I don't see support
in libvirt. Is there a way to hook into QMP after the fact somehow?

