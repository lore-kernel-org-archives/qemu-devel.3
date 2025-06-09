Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AE7C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdcm-00022s-3S; Mon, 09 Jun 2025 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uOdcj-00022h-ES
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:37:17 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uOdcd-00060Q-Pq
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:37:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1F2D1F456;
 Mon,  9 Jun 2025 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749479826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlENU0vUNNqRgnMiptc3u6MIMrT0xqk2bCUiNY092ws=;
 b=HGRJjtGyPr/Petu7HNtoR/xtkxJGtpqEC8tAb28X6K3PYIrbfpxGwTeBGD9DhgY0tgIlNO
 TAs9xDTLhjHwEY6/BGhIJPsTHuQ4+VKOf/VGhfwwoJV9ARNMCi3UvbuJslF6DcpOI2hYXj
 AuwR+GU1NX29aRCB/9YpQU0R7Mh5Zp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749479826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlENU0vUNNqRgnMiptc3u6MIMrT0xqk2bCUiNY092ws=;
 b=hKe8BAqSpzgJ87g+SVy5omNx7vZ2oBqImSqVe1ZI9MR5UqceI8faSG/HD7c9VS4xjSn4wk
 DvI9WKMeU6037CCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DQiYfpfA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n7REgAUU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749479825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlENU0vUNNqRgnMiptc3u6MIMrT0xqk2bCUiNY092ws=;
 b=DQiYfpfAgcX5vKpKQy2x0bDu4xm4yYxVmiwc+Q7ApI8NW7ZxJAhCd2M2QVQmTst6wN/RUa
 Z1FcvOQVXq7Ut4LXuQoUkuLNrJZLAErqxok/Kkz0gFp0H8qFp+BhT9oqdg7ENFivB0jdGJ
 fsWiPNxjgvM2n1A6V6CidFv8G74kyKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749479825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlENU0vUNNqRgnMiptc3u6MIMrT0xqk2bCUiNY092ws=;
 b=n7REgAUUfTiFpkV6zO1vOgBQ2K7BZgAxi/WkjW9lQO3bpmc4CU0VrqxKKiJVrj1r2Vg7zZ
 cWcd9a9Ln5T6jZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D12F13A1D;
 Mon,  9 Jun 2025 14:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nxxYA5HxRmghcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Jun 2025 14:37:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
In-Reply-To: <aENUrociiqlFuPpz@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de> <aENBda_y3v3y4ptS@x1.local>
 <874iwswrex.fsf@suse.de> <aENUrociiqlFuPpz@x1.local>
Date: Mon, 09 Jun 2025 11:37:02 -0300
Message-ID: <87y0u1ugkx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D1F2D1F456
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
>> >> Allow the migrate and migrate_incoming commands to pass the migration
>> >> configuration options all at once, dispensing the use of
>> >> migrate-set-parameters and migrate-set-capabilities.
>> >> 
>> >> The motivation of this is to simplify the interface with the
>> >> management layer and avoid the usage of several command invocations to
>> >> configure a migration. It also avoids stale parameters from a previous
>> >> migration to influence the current migration.
>> >> 
>> >> The options that are changed during the migration can still be set
>> >> with the existing commands.
>> >> 
>> >> The order of precedence is:
>> >> 
>> >> 'config' argument > -global cmdline > defaults (migration_properties)
>> >
>> > Could we still keep the QMP migrate-set-parameters values?
>> >
>> >   'config' argument > QMP setups using migrate-set-parameters >
>> >     -global cmdline > defaults (migration_properties)
>> >
>> 
>> That's the case. I failed to mention it in the commit message. IOW it
>> behaves just like today, but the new 'config' way takes precedence over
>> all.
>
> Referring to below chunk of code:
>
> [...]
>
>> >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
>> >> +                             Error **errp)
>> >> +{
>> >> +    ERRP_GUARD();
>> >> +
>> >> +    assert(bql_locked());
>> >> +
>> >> +    /* reset to default parameters */
>> >> +    migrate_params_apply(&s->defaults);
>
> IIUC here it'll reset all global parameters using the initial defaults
> first, then apply the "config" specified in "migrate" QMP command?
>

Yes, this is so any previously set parameter via migrate-set-parameter
gets erased. I think what we want (but feel free to disagree) is to have
the migrate-set-parameter _eventually_ only handle parameters that need
to be modifed during migration runtime. Anything else can be done via
passing config to qmp_migrate.

For -global, I don't have a preference. Having -global take precedence
over all would require a way to know which options were present in the
command-line and which are just the defaults seet in
migration_properties. I currently don't know how to do that. If it is at
all possible (within reason) we could make the change, no worries.

> I think there're actually two separate questions to be asked, to make it
> clearer, they are:

Here it got ambiguous when you say "global", I've been using -global to
refer to the cmdline -global migration.foo, but others have used global
to mean s->parameters (which has an extended lifetime). Could you
clarify?

>
>   (1) Whether we should allow QMP "migrate" 'config' parameter to overwrite
>       global setup?
>
>   (2) Whether we should allow previous QMP global setup to be used even if
>       QMP "migrate" provided 'config' parameter?
>
> So IIUC the patch does (1) YES (2) NO, while what I think might be more
> intuitive is (1) NO (2) YES.
>
>> >> +
>> >> +    /* overwrite with the new ones */
>> >> +    qmp_migrate_set_parameters(new, errp);
>> >> +    if (*errp) {
>> >> +        return false;
>> >> +    }
>> >> +
>> >> +    return true;
>> >> +}

