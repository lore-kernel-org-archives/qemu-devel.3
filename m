Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE711062894
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IyU-0001kk-7F; Wed, 11 Mar 2026 08:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0IyN-0001kY-5l
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:47:35 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0IyL-0002Bg-IF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:47:34 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1031E4D34D;
 Wed, 11 Mar 2026 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773233252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alQdADdKVrZFUvuX2gSOBn0lL0pgZHefCG+h5mj6oX4=;
 b=TVGLqzwdAOq8U7iyGIcKy8g4ANfDgerCDEbOrNazq/Kz4Mpf5Bg67e9dTcTi9lzu3Zg3Uo
 EAWwU4PVGFY3xpcP/A0YUEj/dHIBfelqErdBpiUJSskREgd3SJiVaUsBE1voD+FQzTYKuz
 j1kDBK0x/GE0jH/1uWW4IYrRXHJE4XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773233252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alQdADdKVrZFUvuX2gSOBn0lL0pgZHefCG+h5mj6oX4=;
 b=jaUYef1lqBFHn9I8i+QUvsI5DwBGa15jgYiPzO/dBP4UX6wO67Nt/IasCs5M0nUjrv9GNU
 qX5PvAkStKyWNzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773233252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alQdADdKVrZFUvuX2gSOBn0lL0pgZHefCG+h5mj6oX4=;
 b=TVGLqzwdAOq8U7iyGIcKy8g4ANfDgerCDEbOrNazq/Kz4Mpf5Bg67e9dTcTi9lzu3Zg3Uo
 EAWwU4PVGFY3xpcP/A0YUEj/dHIBfelqErdBpiUJSskREgd3SJiVaUsBE1voD+FQzTYKuz
 j1kDBK0x/GE0jH/1uWW4IYrRXHJE4XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773233252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alQdADdKVrZFUvuX2gSOBn0lL0pgZHefCG+h5mj6oX4=;
 b=jaUYef1lqBFHn9I8i+QUvsI5DwBGa15jgYiPzO/dBP4UX6wO67Nt/IasCs5M0nUjrv9GNU
 qX5PvAkStKyWNzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F263FA0E;
 Wed, 11 Mar 2026 12:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PwOSFGNksWnuKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 12:47:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: luzhipeng <luzhipeng@cestc.cn>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, luzhipeng <luzhipeng@cestc.cn>
Subject: Re: [PATCH] qmp: Add ram-block-set/get-migratable commands
In-Reply-To: <20260311100116.984-1-luzhipeng@cestc.cn>
References: <20260311100116.984-1-luzhipeng@cestc.cn>
Date: Wed, 11 Mar 2026 09:47:29 -0300
Message-ID: <87ldfyzg66.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, cestc.cn:email,
 imap1.dmz-prg2.suse.org:helo]
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

luzhipeng <luzhipeng@cestc.cn> writes:

> Introduce two new QMP commands to manage RAMBlock migratable state:
> 1. ram-block-set-migratable: Dynamically set a RAMBlock's migratable state
> 2. ram-block-get-migratable: Query a RAMBlock's migratable state
>

Hi! Could you provide more information on what are the use-cases for the
new commands?

In particular, what is the condition that can cause a ramblock to become
migratable/unmigratable at runtime that cannot be detected by QEMU
itself?

> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
> ---
>  migration/ram.c     | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json | 39 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 979751f61b..8b4fd8226d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -234,6 +234,54 @@ bool migrate_ram_is_ignored(RAMBlock *block)
>                                      && qemu_ram_is_named_file(block));
>  }
>  
> +void qmp_ram_block_set_migratable(const char *name,
> +                                  bool migratable, Error **errp)
> +{
> +    RAMBlock *rb = qemu_ram_block_by_name(name);
> +    if (!rb) {
> +        error_setg(errp, "RAMBlock '%s' not found", name);
> +        return;
> +    }
> +
> +    if (migration_is_running()) {
> +        error_setg(errp, "Cannot modify RAMBlock migratable state
> +                   during migration");
> +        return;
> +    }
> +
> +    if (migratable) {
> +        qemu_ram_set_migratable(rb);
> +        info_report("RAMBlock '%s' marked as migratable", name);
> +    } else {
> +        qemu_ram_unset_migratable(rb);
> +        info_report("RAMBlock '%s' marked as non-migratable", name);
> +    }
> +}
> +
> +/**
> + * qmp_ram_block_get_migratable:
> + * @name: Name of RAMBlock to query
> + * @errp: Error object
> + *
> + * Return: RamBlockMigratableInfo
> + */
> +RamBlockMigratableInfo *qmp_ram_block_get_migratable(const char *name,
> +                                                     Error **errp)
> +{
> +    RAMBlock *rb;
> +    RamBlockMigratableInfo *info = g_new0(RamBlockMigratableInfo, 1);
> +    rb = qemu_ram_block_by_name(name);
> +    if (!rb) {
> +        g_free(info);
> +        error_setg(errp, "RAMBlock '%s' not found", name);
> +        return NULL;
> +    }
> +    info->migratable = qemu_ram_is_migratable(rb);
> +    info_report("RAMBlock '%s' migratable state: %s", name,
> +                 info->migratable ? "true" : "false");
> +    return info;
> +}
> +
>  #undef RAMBLOCK_FOREACH
>  
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47..483116db49 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -2233,3 +2233,42 @@
>    'data': { 'job-id': 'str',
>              'tag': 'str',
>              'devices': ['str'] } }
> +
> +##
> +# @ram-block-set-migratable:
> +#
> +# Set the migratable state of a specific RAMBlock.
> +#
> +# @name: Name of the RAMBlock to modify
> +# @migratable: true to enable migration for the RAMBlock,
> +# false to disable
> +#
> +# Since: 11.1
> +##
> +{ 'command': 'ram-block-set-migratable',
> +  'data': { 'name': 'str', 'migratable': 'bool' } }
> +
> +##
> +# @RamBlockMigratableInfo:
> +#
> +# Information about a RAMBlock's migratable state
> +#
> +# @migratable: true if the RAMBlock is migratable, false otherwise
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RamBlockMigratableInfo', 'data': { 'migratable': 'bool' } }
> +
> +##
> +# @ram-block-get-migratable:
> +#
> +# Get the migratable state of a specific RAMBlock.
> +#
> +# @name: Name of the RAMBlock to query
> +#
> +# Returns: RamBlockMigratableInfo containing the migratable state
> +#
> +# Since: 11.1
> +##
> +{ 'command': 'ram-block-get-migratable', 'data': { 'name': 'str' },
> +                                         'returns': 'RamBlockMigratableInfo' }

