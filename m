Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1923C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctnQ-0006fq-3l; Wed, 21 Feb 2024 16:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rctnO-0006fe-3G
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:06:26 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rctnL-00078j-TY
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:06:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DE9F1FB7F;
 Wed, 21 Feb 2024 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708549582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SerqdHuV8+6tkxP9iUEOH0nI559jeDUFXwZIqM5mvl8=;
 b=msmEHUjDRHmPFyEfKJVCho0TqMgAs3zVYYTNlidt76j5h/+do9Ipdov74qoSqEf/8AAlAG
 VW5GUK6YzFgEttY296m7XeveGGKvgv/Ib/AtiBVHuhmrSoRoAajRgIsOQoKZxTwnAjXe5P
 cPvQytYHAqBlS1wSCFHGQzAUoYORjJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708549582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SerqdHuV8+6tkxP9iUEOH0nI559jeDUFXwZIqM5mvl8=;
 b=jnbakoYMUZCZg2caNHZaosmS5DmNemmigRvq9xi8hxc28bWz1fPWLAWNjHjjmlQWqPAiBt
 6m4FEtHZfGv6nFCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708549582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SerqdHuV8+6tkxP9iUEOH0nI559jeDUFXwZIqM5mvl8=;
 b=msmEHUjDRHmPFyEfKJVCho0TqMgAs3zVYYTNlidt76j5h/+do9Ipdov74qoSqEf/8AAlAG
 VW5GUK6YzFgEttY296m7XeveGGKvgv/Ib/AtiBVHuhmrSoRoAajRgIsOQoKZxTwnAjXe5P
 cPvQytYHAqBlS1wSCFHGQzAUoYORjJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708549582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SerqdHuV8+6tkxP9iUEOH0nI559jeDUFXwZIqM5mvl8=;
 b=jnbakoYMUZCZg2caNHZaosmS5DmNemmigRvq9xi8hxc28bWz1fPWLAWNjHjjmlQWqPAiBt
 6m4FEtHZfGv6nFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EB50139D0;
 Wed, 21 Feb 2024 21:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +8lwFc1l1mUbXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 21:06:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 4/7] migration/multifd: Enable zero page checking
 from multifd threads.
In-Reply-To: <20240216224002.1476890-5-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com>
Date: Wed, 21 Feb 2024 18:06:19 -0300
Message-ID: <875xyhbk8k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=msmEHUjD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jnbakoYM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 1DE9F1FB7F
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> This change adds a dedicated handler for MigrationOps::ram_save_target_page in

nit: Add a dedicated handler...

Usually "this patch/change" is used only when necessary to avoid
ambiguity.

> multifd live migration. Now zero page checking can be done in the multifd threads
> and this becomes the default configuration. We still provide backward compatibility
> where zero page checking is done from the migration main thread.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/multifd.c |  1 +
>  migration/options.c |  2 +-
>  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index fbb40ea10b..ef5dad1019 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"

This include...

>  #include "qemu/rcu.h"
> +#include "qemu/cutils.h"

is there already.

>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/ramblock.h"
> diff --git a/migration/options.c b/migration/options.c
> index 3c603391b0..3c79b6ccd4 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -181,7 +181,7 @@ Property migration_properties[] = {
>                        MIG_MODE_NORMAL),
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>                         parameters.zero_page_detection,
> -                       ZERO_PAGE_DETECTION_LEGACY),
> +                       ZERO_PAGE_DETECTION_MULTIFD),

I think we'll need something to avoid a 9.0 -> 8.2 migration with this
enabled. Otherwise it will go along happily until we get data corruption
because the new QEMU didn't send any zero pages on the migration thread
and the old QEMU did not look for them in the multifd packet.

Perhaps bumping the MULTIFD_VERSION when ZERO_PAGE_DETECTION_MULTIFD is
in use. We'd just need to fix the test in the new QEMU to check
(msg.version > MULTIFD_VERSION) instead of (msg.version != MULTIFD_VERSION).

>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> diff --git a/migration/ram.c b/migration/ram.c
> index 5ece9f042e..b088c5a98c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
>      QEMUFile *file = pss->pss_channel;
>      int len = 0;
>  
> -    if (migrate_zero_page_detection() != ZERO_PAGE_DETECTION_LEGACY) {
> -        return 0;
> -    }

How does 'none' work now?

> -
>      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>          return 0;
>      }
> @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
>  
>  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
>  {
> +    assert(migrate_multifd());
> +    assert(!migrate_compress());
> +    assert(!migration_in_postcopy());

Drop these, please. Keep only the asserts that are likely to trigger
during development, such as the existing ones at multifd_send_pages.

> +
>      if (!multifd_queue_page(block, offset)) {
>          return -1;
>      }
> @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
>   */
>  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>  {
> -    RAMBlock *block = pss->block;
>      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>  
> @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>          return 1;
>      }
>  
> +    return ram_save_page(rs, pss);

Look at where git put this! Are you using the default diff algorithm? If
not try using --patience to see if it improves the diff.

> +}
> +
> +/**
> + * ram_save_target_page_multifd: save one target page
> + *
> + * Returns the number of pages written

We could be more precise here:

 ram_save_target_page_multifd: send one target page to multifd workers
 
 Returns 1 if the page was queued, -1 otherwise.

> + *
> + * @rs: current RAM state
> + * @pss: data about the page we want to send
> + */
> +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
> +{
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> +
> +    /* Multifd is not compatible with old compression. */
> +    assert(!migrate_compress());

This should already be enforced at options.c.

> +
> +    /* Multifd is not compabible with postcopy. */
> +    assert(!migration_in_postcopy());

Same here.

> +
>      /*
> -     * Do not use multifd in postcopy as one whole host page should be
> -     * placed.  Meanwhile postcopy requires atomic update of pages, so even
> -     * if host page size == guest page size the dest guest during run may
> -     * still see partially copied pages which is data corruption.
> +     * Backward compatibility support. While using multifd live
> +     * migration, we still need to handle zero page checking on the
> +     * migration main thread.
>       */
> -    if (migrate_multifd() && !migration_in_postcopy()) {
> -        return ram_save_multifd_page(block, offset);
> +    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> +        if (save_zero_page(rs, pss, offset)) {
> +            return 1;
> +        }
>      }
>  
> -    return ram_save_page(rs, pss);
> +    return ram_save_multifd_page(block, offset);
>  }
>  
>  /* Should be called before sending a host page */
> @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      }
>  
>      migration_ops = g_malloc0(sizeof(MigrationOps));
> -    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> +
> +    if (migrate_multifd()) {
> +        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
> +    } else {
> +        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> +    }
>  
>      bql_unlock();
>      ret = multifd_send_sync_main();

