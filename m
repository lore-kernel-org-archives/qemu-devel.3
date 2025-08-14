Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234CDCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 15:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umZeP-0002Vu-BR; Thu, 14 Aug 2025 11:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umZeN-0002Vj-N8
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:13:55 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umZeK-00045p-UJ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:13:55 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBCCC21A45;
 Thu, 14 Aug 2025 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755184427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wQcFz4IgM4L8/ACsZ3R7HLXm50gByPZM0JUjIp11LY=;
 b=tdADqSbgTg+3brKTmIG7LRw45CqM2JNA3QCE4hXpXcq53tm/fVbhM6FQcvZEhx9QdB84wZ
 /tRa9L0J4xP0VhkNmmVT6/M1u/OsoLrRgIeRgz2vU8a+BKHhA19fqBILJJ2GeByrKiKJYX
 hckh/ttZHuMR0ryLGCfx29CASkvut4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755184427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wQcFz4IgM4L8/ACsZ3R7HLXm50gByPZM0JUjIp11LY=;
 b=LEPCgaNXdm6ZVkIBKEauPEAobIphcUoaPVqwHyc2FuE/GCouySh3yilw11GB0t1EAK04y6
 Hdunzfg7PcNjIeBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tdADqSbg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LEPCgaNX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755184427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wQcFz4IgM4L8/ACsZ3R7HLXm50gByPZM0JUjIp11LY=;
 b=tdADqSbgTg+3brKTmIG7LRw45CqM2JNA3QCE4hXpXcq53tm/fVbhM6FQcvZEhx9QdB84wZ
 /tRa9L0J4xP0VhkNmmVT6/M1u/OsoLrRgIeRgz2vU8a+BKHhA19fqBILJJ2GeByrKiKJYX
 hckh/ttZHuMR0ryLGCfx29CASkvut4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755184427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wQcFz4IgM4L8/ACsZ3R7HLXm50gByPZM0JUjIp11LY=;
 b=LEPCgaNXdm6ZVkIBKEauPEAobIphcUoaPVqwHyc2FuE/GCouySh3yilw11GB0t1EAK04y6
 Hdunzfg7PcNjIeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52F9F1368C;
 Thu, 14 Aug 2025 15:13:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDCVBCv9nWhKCgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 14 Aug 2025 15:13:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Eric
 Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 20/24] migration: Allow migrate commands to provide
 the migration config
In-Reply-To: <aJ0DO-cJdPEne7Tr@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-21-farosas@suse.de> <aJ0DO-cJdPEne7Tr@x1.local>
Date: Thu, 14 Aug 2025 12:13:44 -0300
Message-ID: <87y0rmylzr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Queue-Id: DBCCC21A45
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jun 30, 2025 at 04:59:09PM -0300, Fabiano Rosas wrote:
>> Allow the migrate and migrate_incoming commands to pass the migration
>> configuration options all at once, dispensing the use of
>> migrate-set-parameters and migrate-set-capabilities.
>> 
>> The motivation of this is to simplify the interface with the
>> management layer and avoid the usage of several command invocations to
>> configure a migration. It also avoids stale parameters from a previous
>> migration to influence the current migration.
>> 
>> The options that are changed during the migration can still be set
>> with the existing commands.
>> 
>> The order of precedence is:
>> 
>> 'config' argument > -global migration cmdline > migrate-set-parameters
>> > defaults (migration_properties)
>
> Did you make the 2nd/3rd the wrong way?
>
>   config > migrate-set-parameters > -global cmdlines > defaults
>

Good catch. Thanks!

>> 
>> I.e. the config takes precedence over all, values not present in the
>> config assume the default values. The -global migration command line
>> option allows the defaults to be overridden for debug.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Other than that:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

