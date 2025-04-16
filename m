Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BD3C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54G7-0007Vs-IL; Wed, 16 Apr 2025 11:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u54Fc-0006yF-So
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 11:00:34 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u54Fa-0003SC-JW
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 11:00:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D34F2117D;
 Wed, 16 Apr 2025 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744815628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeB3sJiYkadl4AXl8IkBT5cyObhxo5FEso6CwCa7Lfo=;
 b=dD/D3zbKcTlVJPvIe9VaMQz43Tve/7lnLNHl2qXrfAWUX224KbjCnKDxmh5mRnQI3LEv4u
 uT0jTHlKWjIamau8gER9fr9djrbAVocqjdXRLydgVDAGCY0u2in3f3/OilRsuWQ+HPdam+
 luMHWnhZuelfewj9J7/9CVLSguS5mv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744815628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeB3sJiYkadl4AXl8IkBT5cyObhxo5FEso6CwCa7Lfo=;
 b=e2wYgsjQnogSyzqr/DhI69DlyWhuN1Zrkcs3Bk0gUjfQMZroiOKYTzngUOl42Y2jsVjHce
 rck6V+mwoDu6C/BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="dD/D3zbK";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e2wYgsjQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744815628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeB3sJiYkadl4AXl8IkBT5cyObhxo5FEso6CwCa7Lfo=;
 b=dD/D3zbKcTlVJPvIe9VaMQz43Tve/7lnLNHl2qXrfAWUX224KbjCnKDxmh5mRnQI3LEv4u
 uT0jTHlKWjIamau8gER9fr9djrbAVocqjdXRLydgVDAGCY0u2in3f3/OilRsuWQ+HPdam+
 luMHWnhZuelfewj9J7/9CVLSguS5mv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744815628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeB3sJiYkadl4AXl8IkBT5cyObhxo5FEso6CwCa7Lfo=;
 b=e2wYgsjQnogSyzqr/DhI69DlyWhuN1Zrkcs3Bk0gUjfQMZroiOKYTzngUOl42Y2jsVjHce
 rck6V+mwoDu6C/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDD4813976;
 Wed, 16 Apr 2025 15:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BUD/IgvG/2fEVwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Apr 2025 15:00:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
In-Reply-To: <874iyomdat.fsf@pond.sub.org>
References: <20250411191443.22565-1-farosas@suse.de>
 <Z_07dfI4rFRpvZA1@redhat.com> <874iyomdat.fsf@pond.sub.org>
Date: Wed, 16 Apr 2025 12:00:25 -0300
Message-ID: <875xj4f8xi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5D34F2117D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Markus Armbruster <armbru@redhat.com> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Fri, Apr 11, 2025 at 04:14:30PM -0300, Fabiano Rosas wrote:
>>> Open questions:
>>> ---------------
>>>=20
>>> - Deprecations/compat?
>>>=20
>>> I think we should deprecate migrate-set/query-capabilities and everythi=
ng to do
>>> with capabilities (specifically the validation in the JSON at the end o=
f the
>>> stream).
>>>=20
>>> For migrate-set/query-parameters, we could probably keep it around inde=
finitely,
>>> but it'd be convenient to introduce new commands so we can give them new
>>> semantics.
>>>=20
>>> - How to restrict the options that should not be set when the migration=
 is in
>>> progress?
>>>=20
>>> i.e.:
>>>   all options can be set before migration (initial config)
>>>   some options can be set during migration (runtime)
>>>=20
>>> I thought of adding another type at the top of the hierarchy, with
>>> just the options allowed to change at runtime, but that doesn't really
>>> stop the others being also set at runtime. I'd need a way to have a
>>> set of options that are rejected 'if migration_is_running()', without
>>> adding more duplication all around.
>>>=20
>>> - What about savevm?
>>>=20
>>> None of this solves the issue of random caps/params being set before
>>> calling savevm. We still need to special-case savevm and reject
>>> everything. Unless we entirely deprecate setting initial options via
>>> set-parameters (or set-config) and require all options to be set as
>>> savevm (and migrate) arguments.
>>
>> I'd suggest we aim for a world where the commands take all options
>> as direct args and try to remove the global state eventually.
>
> Yes.
>
> Even better: make it a job.
>

What do we gain from that in relation to being able to pass ~50
parameters to a command? I don't see it. I think that's the actual crux
here, too many options and how to get them from the QAPI into the
migration core for consumption.

The current usage of MigrationParameters as both the return type for
query-set-parameters and the global parameter store for the migration
state is really dissonant. What do the has_* fields even mean when
accessed via MigrationState::parameters? This series is not doing any
better in that regard, mind you. I'm almost tempted to ask that we
expose the QDict from the marshaling function directly to the migration
code, at least that's a data type that makes sense internally.

