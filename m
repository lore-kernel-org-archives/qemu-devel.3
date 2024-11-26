Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B47D6555A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2xg-0002cN-5F; Tue, 26 Nov 2024 16:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG2xR-0002Ji-BP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG2xO-0001sM-Sa
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69AC91F74D;
 Tue, 26 Nov 2024 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732655928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zF1tp96OCcRBkeRqR1s1pS4ltX9lpLn7X08QiFGkf58=;
 b=LCVDkXmSaFO+5mh/c3ncfa+ZYX5lbSkBJaiwBROf8MYk2qd0zxeqS9yDGi/Nrk3PZuFJ5q
 HmxY4qEZjPaQrDnE9r7WCFheBBb7RX3kN/uSn4ACvmjUfi89/KbUtfdFqHoX2vjx+vvRlJ
 /f1fAkNUiqbTO/9uWKiv21S1zp7feJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732655928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zF1tp96OCcRBkeRqR1s1pS4ltX9lpLn7X08QiFGkf58=;
 b=oKcyW4EJCRqlqwiuVAXeCxMf4Gd9Qv32GZgOHgI2nMJNR8+5ns2dTp3NN3Sm315GHVa9nw
 kbrGm35wrW7bh3Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LCVDkXmS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oKcyW4EJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732655928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zF1tp96OCcRBkeRqR1s1pS4ltX9lpLn7X08QiFGkf58=;
 b=LCVDkXmSaFO+5mh/c3ncfa+ZYX5lbSkBJaiwBROf8MYk2qd0zxeqS9yDGi/Nrk3PZuFJ5q
 HmxY4qEZjPaQrDnE9r7WCFheBBb7RX3kN/uSn4ACvmjUfi89/KbUtfdFqHoX2vjx+vvRlJ
 /f1fAkNUiqbTO/9uWKiv21S1zp7feJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732655928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zF1tp96OCcRBkeRqR1s1pS4ltX9lpLn7X08QiFGkf58=;
 b=oKcyW4EJCRqlqwiuVAXeCxMf4Gd9Qv32GZgOHgI2nMJNR8+5ns2dTp3NN3Sm315GHVa9nw
 kbrGm35wrW7bh3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E94A913890;
 Tue, 26 Nov 2024 21:18:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KeeVKzc7RmfTdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 26 Nov 2024 21:18:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
In-Reply-To: <20241126115748.118683-4-ppandit@redhat.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com>
Date: Tue, 26 Nov 2024 18:18:45 -0300
Message-ID: <87ed2xn16y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 69AC91F74D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> Refactor ram_save_target_page legacy and multifd
> functions into one. Other than simplifying it,
> it frees 'migration_ops' object from usage, so it
> is expunged.
>
> When both Multifd and Postcopy modes are enabled,
> to avoid errors, the Multifd threads are active until
> migration reaches the Postcopy mode. This is done by
> checking the state returned by migration_in_postcopy().

This patch should be just the actual refactoring on top of master, with
no mention to postcopy at all.

>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/multifd-nocomp.c |  3 +-
>  migration/ram.c            | 74 ++++++++++++--------------------------
>  2 files changed, 24 insertions(+), 53 deletions(-)
>
> v1: Further refactor ram_save_target_page() function to conflate
>     save_zero_page() calls.
>
>     Add migration_in_postcopy() call to check migration state
>     instead of combining it with migrate_multifd().
>
> v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u
>
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 55191152f9..e92821e8f6 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -14,6 +14,7 @@
>  #include "exec/ramblock.h"
>  #include "exec/target_page.h"
>  #include "file.h"
> +#include "migration.h"
>  #include "multifd.h"
>  #include "options.h"
>  #include "qapi/error.h"
> @@ -345,7 +346,7 @@ retry:
>  
>  int multifd_ram_flush_and_sync(void)
>  {
> -    if (!migrate_multifd()) {
> +    if (!migrate_multifd() || migration_in_postcopy()) {
>          return 0;
>      }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 05ff9eb328..9d1ec6209c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -467,13 +467,6 @@ void ram_transferred_add(uint64_t bytes)
>      }
>  }
>  
> -struct MigrationOps {
> -    int (*ram_save_target_page)(RAMState *rs, PageSearchStatus *pss);
> -};
> -typedef struct MigrationOps MigrationOps;
> -
> -MigrationOps *migration_ops;
> -
>  static int ram_save_host_page_urgent(PageSearchStatus *pss);
>  
>  /* NOTE: page is the PFN not real ram_addr_t. */
> @@ -1323,9 +1316,9 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (migrate_multifd() &&
> -                (!migrate_multifd_flush_after_each_section() ||
> -                 migrate_mapped_ram())) {
> +            if (migrate_multifd() && !migration_in_postcopy()
> +                && (!migrate_multifd_flush_after_each_section()
> +                    || migrate_mapped_ram())) {

This is getting out of hand. We can't keep growing this condition every
time something new comes up. Any ideas?

>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_ram_flush_and_sync();
>                  if (ret < 0) {
> @@ -1986,55 +1979,39 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
>  }
>  
>  /**
> - * ram_save_target_page_legacy: save one target page
> + * ram_save_target_page: save one target page to the precopy thread
> + * OR to multifd workers.
>   *
> - * Returns the number of pages written
> + * Multifd mode: returns 1 if the page was queued, -1 otherwise.
> + * Non-multifd mode: returns the number of pages written.

Yes, although I wonder if we should keep documenting this when we only
call this function for a single page and it always returns at most 1.

>   *
>   * @rs: current RAM state
>   * @pss: data about the page we want to send
>   */
> -static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
> +static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>  {
>      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>  
> +    if (!migrate_multifd()
> +        || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> +        if (save_zero_page(rs, pss, offset)) {
> +            return 1;
> +        }
> +    }
> +
> +    if (migrate_multifd() && !migration_in_postcopy()) {
> +        RAMBlock *block = pss->block;
> +        return ram_save_multifd_page(block, offset);
> +    }
> +
>      if (control_save_page(pss, offset, &res)) {
>          return res;
>      }
>  
> -    if (save_zero_page(rs, pss, offset)) {
> -        return 1;
> -    }
> -
>      return ram_save_page(rs, pss);
>  }
>  
> -/**
> - * ram_save_target_page_multifd: send one target page to multifd workers
> - *
> - * Returns 1 if the page was queued, -1 otherwise.
> - *
> - * @rs: current RAM state
> - * @pss: data about the page we want to send
> - */
> -static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
> -{
> -    RAMBlock *block = pss->block;
> -    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> -
> -    /*
> -     * While using multifd live migration, we still need to handle zero
> -     * page checking on the migration main thread.
> -     */
> -    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> -        if (save_zero_page(rs, pss, offset)) {
> -            return 1;
> -        }
> -    }
> -
> -    return ram_save_multifd_page(block, offset);
> -}
> -
>  /* Should be called before sending a host page */
>  static void pss_host_page_prepare(PageSearchStatus *pss)
>  {
> @@ -2121,7 +2098,7 @@ static int ram_save_host_page_urgent(PageSearchStatus *pss)
>  
>          if (page_dirty) {
>              /* Be strict to return code; it must be 1, or what else? */

... this^ comment, for instance.

> -            if (migration_ops->ram_save_target_page(rs, pss) != 1) {
> +            if (ram_save_target_page(rs, pss) != 1) {
>                  error_report_once("%s: ram_save_target_page failed", __func__);
>                  ret = -1;
>                  goto out;
> @@ -2190,7 +2167,7 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
>              if (preempt_active) {
>                  qemu_mutex_unlock(&rs->bitmap_mutex);
>              }
> -            tmppages = migration_ops->ram_save_target_page(rs, pss);
> +            tmppages = ram_save_target_page(rs, pss);
>              if (tmppages >= 0) {
>                  pages += tmppages;
>                  /*
> @@ -2388,8 +2365,6 @@ static void ram_save_cleanup(void *opaque)
>      xbzrle_cleanup();
>      multifd_ram_save_cleanup();
>      ram_state_cleanup(rsp);
> -    g_free(migration_ops);
> -    migration_ops = NULL;
>  }
>  
>  static void ram_state_reset(RAMState *rs)
> @@ -3055,13 +3030,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>          return ret;
>      }
>  
> -    migration_ops = g_malloc0(sizeof(MigrationOps));
> -
>      if (migrate_multifd()) {
>          multifd_ram_save_setup();
> -        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
> -    } else {
> -        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
>      }
>  
>      bql_unlock();

