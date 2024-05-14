Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83646C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wPO-0001dh-8s; Tue, 14 May 2024 13:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6wP6-0001ZG-3C
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:57:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6wOz-0008EC-SX
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:57:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07CBF1FDBE;
 Tue, 14 May 2024 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715709441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yYTY9Wgz/LMRk7fmGG4kjxZdUNDUlgbzs/gM2N+WZo=;
 b=HNkowWZoRGY46zfyHDzlJu1sgsesKb88YQrXSgwda3ORtH/V62rsXqr6tzKxpS26WBzxet
 vPMo9aQAlYfOmPhzEGl1YGJw50kjMVdaoLqgA3bX041sBHCgKCoB1E3YvLEyg7RqY8Zx++
 2zcVOgm9ig2+0PvtLUrUjkJtmgfhSho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715709441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yYTY9Wgz/LMRk7fmGG4kjxZdUNDUlgbzs/gM2N+WZo=;
 b=VXq1T0UhT3ltC10aXXOSILXYoa3m59CJ/fKCA7kD13fLr48FmkW5JOQHQcP77QWoVoo78v
 s/A/HQFX3fcDRYBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715709441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yYTY9Wgz/LMRk7fmGG4kjxZdUNDUlgbzs/gM2N+WZo=;
 b=HNkowWZoRGY46zfyHDzlJu1sgsesKb88YQrXSgwda3ORtH/V62rsXqr6tzKxpS26WBzxet
 vPMo9aQAlYfOmPhzEGl1YGJw50kjMVdaoLqgA3bX041sBHCgKCoB1E3YvLEyg7RqY8Zx++
 2zcVOgm9ig2+0PvtLUrUjkJtmgfhSho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715709441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yYTY9Wgz/LMRk7fmGG4kjxZdUNDUlgbzs/gM2N+WZo=;
 b=VXq1T0UhT3ltC10aXXOSILXYoa3m59CJ/fKCA7kD13fLr48FmkW5JOQHQcP77QWoVoo78v
 s/A/HQFX3fcDRYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82FA6137C3;
 Tue, 14 May 2024 17:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Bs+TEgCmQ2azeAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 May 2024 17:57:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
In-Reply-To: <87ttj0zdp0.fsf@pond.sub.org>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de> <ZjUnghSvdy-wWtnN@x1n>
 <871q6ioc2r.fsf@suse.de> <ZjVUKCafjreLtLmm@x1n>
 <87ttj0zdp0.fsf@pond.sub.org>
Date: Tue, 14 May 2024 14:57:18 -0300
Message-ID: <87r0e4e0ox.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Fri, May 03, 2024 at 05:49:32PM -0300, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>> 
>>> > On Fri, Apr 26, 2024 at 11:20:37AM -0300, Fabiano Rosas wrote:
>>> >> Add the direct-io migration parameter that tells the migration code to
>>> >> use O_DIRECT when opening the migration stream file whenever possible.
>>> >> 
>>> >> This is currently only used with the mapped-ram migration that has a
>>> >> clear window guaranteed to perform aligned writes.
>>> >> 
>>> >> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> >> ---
>>> >>  include/qemu/osdep.h           |  2 ++
>>> >>  migration/migration-hmp-cmds.c | 11 +++++++++++
>>> >>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>>> >>  migration/options.h            |  1 +
>>> >>  qapi/migration.json            | 18 +++++++++++++++---
>>> >>  util/osdep.c                   |  9 +++++++++
>>> >>  6 files changed, 68 insertions(+), 3 deletions(-)
>>> >> 
>>> >> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>> >> index c7053cdc2b..645c14a65d 100644
>>> >> --- a/include/qemu/osdep.h
>>> >> +++ b/include/qemu/osdep.h
>>> >> @@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
>>> >>  bool qemu_has_ofd_lock(void);
>>> >>  #endif
>>> >>  
>>> >> +bool qemu_has_direct_io(void);
>>> >> +
>>> >>  #if defined(__HAIKU__) && defined(__i386__)
>>> >>  #define FMT_pid "%ld"
>>> >>  #elif defined(WIN64)
>>> >> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>> >> index 7e96ae6ffd..8496a2b34e 100644
>>> >> --- a/migration/migration-hmp-cmds.c
>>> >> +++ b/migration/migration-hmp-cmds.c
>>> >> @@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>> >>          monitor_printf(mon, "%s: %s\n",
>>> >>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>>> >>              qapi_enum_lookup(&MigMode_lookup, params->mode));
>>> >> +
>>> >> +        if (params->has_direct_io) {
>>> >> +            monitor_printf(mon, "%s: %s\n",
>>> >> +                           MigrationParameter_str(
>>> >> +                               MIGRATION_PARAMETER_DIRECT_IO),
>>> >> +                           params->direct_io ? "on" : "off");
>>> >> +        }
>>> >
>>> > This will be the first parameter to optionally display here.  I think it's
>>> > a sign of misuse of has_direct_io field..
>
> Yes.  For similar existing parameters, we do
>
>                assert(params->has_FOO);
>                monitor_printf(mon, "%s: '%s'\n",
>                               MigrationParameter_str(MIGRATION_PARAMETER_FOO),
>                               ... params->FOO as string ...)
>
>>> > IMHO has_direct_io should be best to be kept as "whether direct_io field is
>>> > valid" and that's all of it.  It hopefully shouldn't contain more
>>> > information than that, or otherwise it'll be another small challenge we
>>> > need to overcome when we can remove all these has_* fields, and can also be
>>> > easily overlooked.
>>> 
>>> I don't think I understand why we have those has_* fields. I thought my
>>> usage of 'params->has_direct_io = qemu_has_direct_io()' was the correct
>>> one, i.e. checking whether QEMU has any support for that parameter. Can
>>> you help me out here?
>>
>> Here params is the pointer to "struct MigrationParameters", which is
>> defined in qapi/migration.json.  And we have had "has_*" only because we
>> allow optional fields with asterisks:
>>
>>   { 'struct': 'MigrationParameters',
>>     'data': { '*announce-initial': 'size',
>>               ...
>>               } }
>>
>> So that's why it better only means "whether this field existed", because
>> it's how it is defined.
>>
>> IIRC we (or say, Markus) used to have some attempts deduplicates those
>> *MigrationParameter* things, and if success we have chance to drop has_*
>> fields (in which case we simply always have them; that "has_" makes more
>> sense only if in a QMP session to allow user only specify one or more
>> things if not all).
>
> qapi/migration.json:
>
>     ##
>     # @MigrationParameters:
>     #
> --> # The optional members aren't actually optional.
>     #
>
> In other words, the has_FOO generated for the members of
> MigrationParameters must all be true.
>
> These members became optional when we attempted to de-duplicate
> MigrationParameters and MigrateSetParameters, but failed (see commit
> de63ab61241 "migrate: Share common MigrationParameters struct" and
> commit 1bda8b3c695 "migration: Unshare MigrationParameters struct for
> now").

So what's the blocker for merging MigrationSetParameters and
MigrationParameters? Just the tls_* options?

