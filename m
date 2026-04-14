Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C92F9D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 19:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCjX3-0001Yd-SJ; Tue, 14 Apr 2026 15:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCjX2-0001YU-Rl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:34:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCjWz-0003we-Hp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:34:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E5BA6A7D0;
 Tue, 14 Apr 2026 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776195277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B8MLEkllSQ+melihNx1n1KRo8qJWb94Umq8HvGWcTs=;
 b=ZRsJeVU8hmwBmw0x8hmwTphk0vGL2Uvhm6jMpU2ufXsleFfoAlp5y6FGzH0s2KYdjV4eIL
 I/17qdT2WrjsXA9c+tygm5XQ93iBjTSFpuHXyIr6xiv/dXXWCWRR5Ghr3clyTc7+3jhOj5
 QDDFxaS1xKjsGC7aTGJvDSXicSAQ/MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776195277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B8MLEkllSQ+melihNx1n1KRo8qJWb94Umq8HvGWcTs=;
 b=3PKCglFyN5vjiY2hzSIjfa+zfTzRLac37C+XS2RT20bq7BSte4Uc96QJN7EBGbcTvrgJQy
 7ZY9w6UJwiJxDKAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776195277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B8MLEkllSQ+melihNx1n1KRo8qJWb94Umq8HvGWcTs=;
 b=ZRsJeVU8hmwBmw0x8hmwTphk0vGL2Uvhm6jMpU2ufXsleFfoAlp5y6FGzH0s2KYdjV4eIL
 I/17qdT2WrjsXA9c+tygm5XQ93iBjTSFpuHXyIr6xiv/dXXWCWRR5Ghr3clyTc7+3jhOj5
 QDDFxaS1xKjsGC7aTGJvDSXicSAQ/MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776195277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B8MLEkllSQ+melihNx1n1KRo8qJWb94Umq8HvGWcTs=;
 b=3PKCglFyN5vjiY2hzSIjfa+zfTzRLac37C+XS2RT20bq7BSte4Uc96QJN7EBGbcTvrgJQy
 7ZY9w6UJwiJxDKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C464B5EE;
 Tue, 14 Apr 2026 19:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q4NBHMyW3mnCKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 19:34:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 19/31] migration: Normalize tls arguments
In-Reply-To: <ad6OcvW1II8Q3gO1@x1.local>
References: <20251223142959.1460293-1-peterx@redhat.com>
 <20251223142959.1460293-20-peterx@redhat.com>
 <a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name>
 <ad6OcvW1II8Q3gO1@x1.local>
Date: Tue, 14 Apr 2026 16:34:30 -0300
Message-ID: <87340xz67t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Tue, Apr 14, 2026 at 06:56:27PM +0200, Maciej S. Szmigiero wrote:
>> On 23.12.2025 15:29, Peter Xu wrote:
>> > From: Fabiano Rosas <farosas@suse.de>
>> > 
>> > The migration parameters tls_creds, tls_authz and tls_hostname
>> > currently have a non-uniform handling. When used as arguments to
>> > migrate-set-parameters, their type is StrOrNull and when used as
>> > return value from query-migrate-parameters their type is a plain
>> > string.
>> > 
>> > Not only having to convert between the types is cumbersome, but it
>> > also creates the issue of requiring two different QAPI types to be
>> > used, one for each command. MigrateSetParameters is used for
>> > migrate-set-parameters with the TLS arguments as StrOrNull while
>> > MigrationParameters is used for query-migrate-parameters with the TLS
>> > arguments as str.
>> > 
>> > Since StrOrNull could be considered a superset of str, change the type
>> > of the TLS arguments in MigrationParameters to StrOrNull. Also ensure
>> > that QTYPE_QNULL is never used.
>> > 
>> > 1) migrate-set-parameters will always write QTYPE_QSTRING to
>> >    s->parameters, either an empty or non-empty string.
>> > 
>> > 2) query-migrate-parameters will always return a QTYPE_QSTRING, either
>> >    empty or non-empty.
>> > 
>> > 3) the migrate_tls_* helpers will always return a non-empty string or
>> >    NULL, for the internal migration code's consumption.
>> > 
>> > Points (1) and (2) above help simplify the parameters validation and
>> > the query command handling because s->parameters is already kept in
>> > the format that query-migrate-parameters (and info migrate_paramters)
>> > expect. Point (3) is so people don't need to care about StrOrNull in
>> > migration code.
>> > 
>> > This will allow the type duplication to be removed in the next
>> > patches.
>> > 
>> > Note that the type of @tls_creds, @tls-hostname, @tls-authz changes
>> > from str to StrOrNull in introspection of the query-migrate-parameters
>> > command. We accept this imprecision to enable de-duplication.
>> > 
>> > There's no need to free the TLS options in
>> > migration_instance_finalize() because they're freed by the qdev
>> > properties .release method.
>> > 
>> > Temporary in this patch:
>> > migrate_params_test_apply() copies s->parameters into a temporary
>> > structure, so it's necessary to drop the references to the TLS options
>> > if they were not set by the user to avoid double-free. This is fixed
>> > in the next patches.
>> > 
>> > Acked-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > Link: https://lore.kernel.org/r/20251215220041.12657-6-farosas@suse.de
>> > [peterx: in hmp_info_migrate_parameters(), remove an extra dump of
>> >   max_postcopy_bandwidth, introduced likely by accident]
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >   qapi/migration.json            |   6 +-
>> >   migration/options.h            |   1 +
>> >   migration/migration-hmp-cmds.c |   6 +-
>> >   migration/options.c            | 144 +++++++++++++++++++--------------
>> >   migration/tls.c                |   2 +-
>> >   5 files changed, 93 insertions(+), 66 deletions(-)
>> > 
>> > diff --git a/migration/options.c b/migration/options.c
>> > index d55f3104be..6ef3c56fb6 100644
>> > --- a/migration/options.c
>> > +++ b/migration/options.c
>> (..)
>> > @@ -1243,7 +1274,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>> >   #ifdef CONFIG_LINUX
>> >       if (migrate_zero_copy_send() &&
>> >           ((params->has_multifd_compression && params->multifd_compression) ||
>> > -         (params->tls_creds && *params->tls_creds))) {
>> > +         *params->tls_creds->u.s)) {
>> >           error_setg(errp,
>> >                      "Zero copy only available for non-compressed non-TLS multifd migration");
>> >           return false;
>> The above change gives me easily triggerable NULL pointer dereference:
>> > $ qemu-system-x86_64 -monitor stdio -global migration.x-multifd=true -global migration.x-zero-copy-send=true
>> > QEMU 10.2.93 monitor - type 'help' for more information
>> > VNC server running on ::1:5900
>> > (qemu) migrate_set_parameter downtime-limit 500
>> > Segmentation fault
>
> Oops..
>

Why do you guys still let me touch this codebase?

>> 
>> I guess params->tls_creds really needs that NULL check before being accessed.
>
> Yeah, my gut feeling is we got this special casing of using a temp
> parameter object..  I'll leave Fabiano to double check on that and send
> patch..
>
> Thanks for the report!

Good that I write my bugs with matching fixes to go along.

https://lore.kernel.org/r/20260202224101.20568-3-farosas@suse.de

I'll repost with a better commit message.

