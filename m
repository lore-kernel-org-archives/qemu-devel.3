Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97504C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdrHd-0005qG-Dd; Fri, 31 Jan 2025 08:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tdrHV-0005or-1x; Fri, 31 Jan 2025 08:42:01 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tdrHT-0002cR-5C; Fri, 31 Jan 2025 08:42:00 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 984E821114;
 Fri, 31 Jan 2025 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738330916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOXN3L3lPFR8FND0i/VSNLrR+cdqlrVWm8ZZKMvic3E=;
 b=d/506/bhe+nwm1Pe2Cfz+iUC3Aoge0Lcns05bSVb32wdtJ8QR5COlySSvhPLgp2Zq3PUeD
 ZdDvSuBFaCvV/VRIQUARpkwWNcZKnXqhejm6MRte0kjpdJXLW2IzWY2mpLaU9fvBHU/W01
 GHVx2MJ/jx2qKUHQ/dcwR0bUZbeZlAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738330916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOXN3L3lPFR8FND0i/VSNLrR+cdqlrVWm8ZZKMvic3E=;
 b=29sF9/zG66SyIRob4qjLxrHNH34UNQ7ckxVZfGUUR7v9gfZikJ/ErPzfBrGNgaBDAybgFt
 Y3Bg0izRpSez56Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738330916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOXN3L3lPFR8FND0i/VSNLrR+cdqlrVWm8ZZKMvic3E=;
 b=d/506/bhe+nwm1Pe2Cfz+iUC3Aoge0Lcns05bSVb32wdtJ8QR5COlySSvhPLgp2Zq3PUeD
 ZdDvSuBFaCvV/VRIQUARpkwWNcZKnXqhejm6MRte0kjpdJXLW2IzWY2mpLaU9fvBHU/W01
 GHVx2MJ/jx2qKUHQ/dcwR0bUZbeZlAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738330916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOXN3L3lPFR8FND0i/VSNLrR+cdqlrVWm8ZZKMvic3E=;
 b=29sF9/zG66SyIRob4qjLxrHNH34UNQ7ckxVZfGUUR7v9gfZikJ/ErPzfBrGNgaBDAybgFt
 Y3Bg0izRpSez56Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EBA21364B;
 Fri, 31 Jan 2025 13:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ua6bLyPTnGd3awAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 Jan 2025 13:41:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/15] block/export: Add option to allow export of
 inactive nodes
In-Reply-To: <20250131095051.49708-2-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-2-kwolf@redhat.com>
Date: Fri, 31 Jan 2025 10:41:53 -0300
Message-ID: <87a5b7gkwu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Kevin Wolf <kwolf@redhat.com> writes:

> Add an option in BlockExportOptions to allow creating an export on an
> inactive node without activating the node. This mode needs to be
> explicitly supported by the export type (so that it doesn't perform any
> operations that are forbidden for inactive nodes), so this patch alone
> doesn't allow this option to be successfully used yet.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json             | 10 +++++++++-
>  include/block/block-global-state.h |  3 +++
>  include/block/export.h             |  3 +++
>  block.c                            |  4 ++++
>  block/export/export.c              | 31 ++++++++++++++++++++----------
>  5 files changed, 40 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index ce33fe378d..117b05d13c 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -372,6 +372,13 @@
>  #     cannot be moved to the iothread.  The default is false.
>  #     (since: 5.2)
>  #
> +# @allow-inactive: If true, the export allows the exported node to be inactive.
> +#     If it is created for an inactive block node, the node remains inactive. If
> +#     the export type doesn't support running on an inactive node, an error is
> +#     returned. If false, inactive block nodes are automatically activated before
> +#     creating the export and trying to inactivate them later fails.
> +#     (since: 10.0; default: false)
> +#
>  # Since: 4.2
>  ##
>  { 'union': 'BlockExportOptions',
> @@ -381,7 +388,8 @@
>              '*iothread': 'str',
>              'node-name': 'str',
>              '*writable': 'bool',
> -            '*writethrough': 'bool' },
> +            '*writethrough': 'bool',
> +            '*allow-inactive': 'bool' },
>    'discriminator': 'type',
>    'data': {
>        'nbd': 'BlockExportOptionsNbd',
> diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
> index 22ec21117d..9be34b3c99 100644
> --- a/include/block/block-global-state.h
> +++ b/include/block/block-global-state.h
> @@ -175,6 +175,9 @@ BlockDriverState * GRAPH_RDLOCK
>  check_to_replace_node(BlockDriverState *parent_bs, const char *node_name,
>                        Error **errp);
>  
> +
> +bool GRAPH_RDLOCK bdrv_is_inactive(BlockDriverState *bs);
> +
>  int no_coroutine_fn GRAPH_RDLOCK
>  bdrv_activate(BlockDriverState *bs, Error **errp);
>  
> diff --git a/include/block/export.h b/include/block/export.h
> index f2fe0f8078..4bd9531d4d 100644
> --- a/include/block/export.h
> +++ b/include/block/export.h
> @@ -29,6 +29,9 @@ typedef struct BlockExportDriver {
>       */
>      size_t instance_size;
>  
> +    /* True if the export type supports running on an inactive node */
> +    bool supports_inactive;
> +
>      /* Creates and starts a new block export */
>      int (*create)(BlockExport *, BlockExportOptions *, Error **);
>  
> diff --git a/block.c b/block.c
> index 61e131e71f..7eeb8d076e 100644
> --- a/block.c
> +++ b/block.c
> @@ -6845,6 +6845,10 @@ void bdrv_init_with_whitelist(void)
>      bdrv_init();
>  }
>  
> +bool bdrv_is_inactive(BlockDriverState *bs) {
> +    return bs->open_flags & BDRV_O_INACTIVE;
> +}

This function is needed by patch 1/15.

> +
>  int bdrv_activate(BlockDriverState *bs, Error **errp)
>  {
>      BdrvChild *child, *parent;
> diff --git a/block/export/export.c b/block/export/export.c
> index bac42b8608..f3bbf11070 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -75,6 +75,7 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
>  BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>  {
>      bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
> +    bool allow_inactive = export->has_allow_inactive && export->allow_inactive;
>      const BlockExportDriver *drv;
>      BlockExport *exp = NULL;
>      BlockDriverState *bs;
> @@ -138,17 +139,24 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>          }
>      }
>  
> -    /*
> -     * Block exports are used for non-shared storage migration. Make sure
> -     * that BDRV_O_INACTIVE is cleared and the image is ready for write
> -     * access since the export could be available before migration handover.
> -     * ctx was acquired in the caller.
> -     */
>      bdrv_graph_rdlock_main_loop();
> -    ret = bdrv_activate(bs, errp);
> -    if (ret < 0) {
> -        bdrv_graph_rdunlock_main_loop();
> -        goto fail;
> +    if (allow_inactive) {
> +        if (!drv->supports_inactive) {
> +            error_setg(errp, "Export type does not support inactive exports");
> +            bdrv_graph_rdunlock_main_loop();
> +            goto fail;
> +        }
> +    } else {
> +        /*
> +         * Block exports are used for non-shared storage migration. Make sure
> +         * that BDRV_O_INACTIVE is cleared and the image is ready for write
> +         * access since the export could be available before migration handover.
> +         */
> +        ret = bdrv_activate(bs, errp);
> +        if (ret < 0) {
> +            bdrv_graph_rdunlock_main_loop();
> +            goto fail;
> +        }
>      }
>      bdrv_graph_rdunlock_main_loop();
>  
> @@ -162,6 +170,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>      if (!fixed_iothread) {
>          blk_set_allow_aio_context_change(blk, true);
>      }
> +    if (allow_inactive) {
> +        blk_set_force_allow_inactivate(blk);
> +    }
>  
>      ret = blk_insert_bs(blk, bs, errp);
>      if (ret < 0) {

