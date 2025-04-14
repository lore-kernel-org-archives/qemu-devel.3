Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F22FC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NMZ-0001s3-GS; Mon, 14 Apr 2025 13:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4NMW-0001qp-Qq
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:12:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4NMQ-0004IT-9O
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:12:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 809A321954;
 Mon, 14 Apr 2025 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744650759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KrO+CMdUcFp5SBdh+RA2kJNWlrKSwLRn1adyrb/cIw=;
 b=rumCX+ENZAR6rCbUKoQeh7Wyndqkqx1F+yFYDtv+9HUX5Fb40iENRj4Tybjvzr/qOWhWeD
 sGkf8kwijHCkOut6gYVt1W9htaXZw5cc5yQSyW4P9QwwO5aTmDhFiCLG+9oU7mOiutbpan
 MsOn9NimYrnUYIae6pgFb7WQ+LoWEuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744650759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KrO+CMdUcFp5SBdh+RA2kJNWlrKSwLRn1adyrb/cIw=;
 b=bVvrTLJJtiBvTR4m0LOh/DbCtlK+Ne+kCD28Cp7SOzExZQ5pg9Gud3Axj0TdHdFY0LEj7/
 1Yt6fBjlBBJk81AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744650759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KrO+CMdUcFp5SBdh+RA2kJNWlrKSwLRn1adyrb/cIw=;
 b=rumCX+ENZAR6rCbUKoQeh7Wyndqkqx1F+yFYDtv+9HUX5Fb40iENRj4Tybjvzr/qOWhWeD
 sGkf8kwijHCkOut6gYVt1W9htaXZw5cc5yQSyW4P9QwwO5aTmDhFiCLG+9oU7mOiutbpan
 MsOn9NimYrnUYIae6pgFb7WQ+LoWEuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744650759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KrO+CMdUcFp5SBdh+RA2kJNWlrKSwLRn1adyrb/cIw=;
 b=bVvrTLJJtiBvTR4m0LOh/DbCtlK+Ne+kCD28Cp7SOzExZQ5pg9Gud3Axj0TdHdFY0LEj7/
 1Yt6fBjlBBJk81AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D721336F;
 Mon, 14 Apr 2025 17:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QBuYJwZC/WebQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 14 Apr 2025 17:12:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
In-Reply-To: <Z_07dfI4rFRpvZA1@redhat.com>
References: <20250411191443.22565-1-farosas@suse.de>
 <Z_07dfI4rFRpvZA1@redhat.com>
Date: Mon, 14 Apr 2025 14:12:35 -0300
Message-ID: <87v7r6fz0c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Fri, Apr 11, 2025 at 04:14:30PM -0300, Fabiano Rosas wrote:
>> Open questions:
>> ---------------
>>=20
>> - Deprecations/compat?
>>=20
>> I think we should deprecate migrate-set/query-capabilities and everythin=
g to do
>> with capabilities (specifically the validation in the JSON at the end of=
 the
>> stream).
>>=20
>> For migrate-set/query-parameters, we could probably keep it around indef=
initely,
>> but it'd be convenient to introduce new commands so we can give them new
>> semantics.
>>=20
>> - How to restrict the options that should not be set when the migration =
is in
>> progress?
>>=20
>> i.e.:
>>   all options can be set before migration (initial config)
>>   some options can be set during migration (runtime)
>>=20
>> I thought of adding another type at the top of the hierarchy, with
>> just the options allowed to change at runtime, but that doesn't really
>> stop the others being also set at runtime. I'd need a way to have a
>> set of options that are rejected 'if migration_is_running()', without
>> adding more duplication all around.
>>=20
>> - What about savevm?
>>=20
>> None of this solves the issue of random caps/params being set before
>> calling savevm. We still need to special-case savevm and reject
>> everything. Unless we entirely deprecate setting initial options via
>> set-parameters (or set-config) and require all options to be set as
>> savevm (and migrate) arguments.
>
> I'd suggest we aim for a world where the commands take all options
> as direct args and try to remove the global state eventually.
>

Well, except the options that are adjusted during migration. But yes, I
agree. It all depends on how we proceed with keeping the old commands
around and for how long. If they're still around we can't stop people
from using them and later invoking "savevm" for instance.

> For savevm/loadvm in particular it is very much a foot-gun that
> 'migrate-set-*' will affect them, because savevm/loadvm aren't
> obviously connected to 'migrate-*' commands unless you're aware
> of how QEMU implements savevm internally.
>

Yes, I could perhaps reset all options once savevm is called, maybe that
would be acceptable, then we don't need to check and block every single
one. Once we add support to migration options to savevm, then they'd be
set in the savevm command-line from day 1 and those wouldn't be
reset. We could also keep HMP restricted to savevm without any migration
options. That's be easy to enforce. If the user wants fancy savevm, they
can invoke via QMP.

>> - HMP?
>>=20
>> Can we convert the strings passed via hmp_set_parameters without
>> having an enum of parameters? Duplication problem again.
>
>>=20
>> - incoming defer?
>>=20
>> It seems we cannot do the final step of removing
>> migrate-set-capabilites before we have a form of handshake
>> implemented. That would take the config from qmp_migrate on source and
>> send it to the destination for negotiation.
>
> I'm not sure I understand why the QAPI design changes are tied
> to the new protocol handshake ? I guess you're wanting to avoid
> updating 'migrate_incoming' to accept the new parameters directly ?
>

Yes, without migrate-set-capabilities, we'd need to pass an enormous
command line to -incoming defer to be able to enable capabilities on the
destination. With the handshake, we could transfer them over the wire
somehow. Does that make sense?

>
> With regards,
> Daniel

