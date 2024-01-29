Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A34C4828C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTP5-0006wW-2a; Mon, 29 Jan 2024 10:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUTP4-0006ss-2T
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUTP2-0007P7-Ak
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 915B71FCF8;
 Mon, 29 Jan 2024 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706541506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pRyooto8EQZj7xf5iNEWu1lZblYdYHJdC6Z8mmOfT8=;
 b=EE2ICQHlm9PbRp3EMdulWOf/9x2fMI4FcsFqx2FUE0wQrVinjC6iZNDzeJN7Yr4s8YJR66
 /7XibhI1YuY+x331cRRr7uZ5E9k/pvQXgYcw2slXWkRtrbaEIM8vBdcZG176VcqWtGflrp
 TPRdXT+ntBHAleq/uqXKvMemU7DO9+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706541506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pRyooto8EQZj7xf5iNEWu1lZblYdYHJdC6Z8mmOfT8=;
 b=ey3qdZXA1va+edHiuMQolCdCOE2Lma8db1X0yJwpk/0rmtoU0a9xWwCZEd7vumTF+kQNME
 cg0EvUiCIFC0HRDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706541506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pRyooto8EQZj7xf5iNEWu1lZblYdYHJdC6Z8mmOfT8=;
 b=EE2ICQHlm9PbRp3EMdulWOf/9x2fMI4FcsFqx2FUE0wQrVinjC6iZNDzeJN7Yr4s8YJR66
 /7XibhI1YuY+x331cRRr7uZ5E9k/pvQXgYcw2slXWkRtrbaEIM8vBdcZG176VcqWtGflrp
 TPRdXT+ntBHAleq/uqXKvMemU7DO9+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706541506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pRyooto8EQZj7xf5iNEWu1lZblYdYHJdC6Z8mmOfT8=;
 b=ey3qdZXA1va+edHiuMQolCdCOE2Lma8db1X0yJwpk/0rmtoU0a9xWwCZEd7vumTF+kQNME
 cg0EvUiCIFC0HRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CDB413647;
 Mon, 29 Jan 2024 15:18:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ODMjNcHBt2V5QgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Jan 2024 15:18:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
In-Reply-To: <CAFEAcA_uzJKuvY=iTnbG-xAjLn0zHRevzvjoyhjqqiBThveO3Q@mail.gmail.com>
References: <20240122070600.16681-1-peterx@redhat.com>
 <87plxtgyxx.fsf@suse.de> <Za81vJgTjFSGT56r@x1n> <87frygdzjl.fsf@suse.de>
 <CAFEAcA_uzJKuvY=iTnbG-xAjLn0zHRevzvjoyhjqqiBThveO3Q@mail.gmail.com>
Date: Mon, 29 Jan 2024 12:18:23 -0300
Message-ID: <87a5oodv7k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EE2ICQHl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ey3qdZXA
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 915B71FCF8
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 29 Jan 2024 at 13:45, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Peter Xu <peterx@redhat.com> writes:
>> > Fundamentally, IMHO it's because QEMU as a project is used both in
>> > enterprise and personal emulations.  I think it might be too strict to
>> > always request backward migration capability if we know some device / arch
>> > is only used for personal, or educational, purposes.
>>
>> Do we need migration support tiers? =)
>
> We already have them. The tier list is:

Ah that's good. Thanks, Peter.

>
>  * if the machine type is a versioned one, then we maintain
>    forwards compatibility for the versioned machine
>    (i.e. can migrate machine-X.Y of QEMU A.B to the
>     machine-X.Y of a QEMU C.D which is newer than A.B).
>  * if the machine type is not versioned, then we do not make
>    any guarantee of migration compatibility across QEMU versions.
>    Instead the aim is that if the user tries it it either works
>    or gives an error message that the migration failed
>    (e.g. because the version field in a VMState struct was bumped).
>    Migration breaks are generally called out in commit messages.
>    Often for machines in this tier the user is really interested
>    in state-save snapshots for debugging purposes, rather than
>    in a true cross-host-machine migration.
>  * some machine types do not support migration/savevm/loadvm
>    at all, because of devices missing VMState structs. This
>    is not desirable, and for new machine models we try to
>    ensure that they have vmstate structs as part of the minimum
>    quality bar, but it is true of some legacy machine types.

Hm, does this mean in some cases we're requiring new models to have
vmstate only to never look at them again? Or do you mean some versioned
machines are currently broken?

> AIUI we, in the sense of the upstream project, do not support
> backwards migration compatibility (i.e. migrating a machine-X.Y
> from QEMU C.D to QEMU A.B where A.B is an older version than C.D);
> though some downstreams (read: RedHat) may do so.

Here we still need to make a distinction between migration code and
vmstate. If we simply ignore backwards migration then it might become
impossible for downstreams to provide it without major
modifications. But luckily this is the easy case.

>
> thanks
> -- PMM

