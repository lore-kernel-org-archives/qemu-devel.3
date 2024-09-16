Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5711C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqJ0g-0004SB-AT; Mon, 16 Sep 2024 17:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqJ0a-0004P6-On
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 17:11:44 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqJ0W-0003L1-Qm
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 17:11:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30B0B1FD8A;
 Mon, 16 Sep 2024 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726521099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mF5HcSJAEWyPjeokqx5ZuBK4G0iXJKtQhpLfa4xR7QI=;
 b=hoqegeVhQNBZ883dqhLel+sjt8OgABGVZPNbzYSwfVv/zOY615jErsWg5M62mYN+skcZFX
 bRoNiRbu1REvn09fYmEGRESkaN3jVrGx9JWUkLfjwKY5JEchk6nLSQ7H6atD8FDswZih5e
 Q1wBx/mWMyvUopK3O6I8Tu/2bb9NUu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726521099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mF5HcSJAEWyPjeokqx5ZuBK4G0iXJKtQhpLfa4xR7QI=;
 b=LpebWK+kPzL3HXt+kUNsnJSJljuK4NW2+SZb97TqeAKd6nRrPTN9wyaaHR6a9NF1ScUW/l
 L4l4J12D0pPAe1Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726521099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mF5HcSJAEWyPjeokqx5ZuBK4G0iXJKtQhpLfa4xR7QI=;
 b=hoqegeVhQNBZ883dqhLel+sjt8OgABGVZPNbzYSwfVv/zOY615jErsWg5M62mYN+skcZFX
 bRoNiRbu1REvn09fYmEGRESkaN3jVrGx9JWUkLfjwKY5JEchk6nLSQ7H6atD8FDswZih5e
 Q1wBx/mWMyvUopK3O6I8Tu/2bb9NUu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726521099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mF5HcSJAEWyPjeokqx5ZuBK4G0iXJKtQhpLfa4xR7QI=;
 b=LpebWK+kPzL3HXt+kUNsnJSJljuK4NW2+SZb97TqeAKd6nRrPTN9wyaaHR6a9NF1ScUW/l
 L4l4J12D0pPAe1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3670139CE;
 Mon, 16 Sep 2024 21:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EfBuGgqf6GZMJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Sep 2024 21:11:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
In-Reply-To: <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
Date: Mon, 16 Sep 2024 18:11:36 -0300
Message-ID: <87msk7z4l3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 smartx.com:email]
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

Hyman Huang <yong.huang@smartx.com> writes:

> shadow_bmap, iter_bmap and iter_dirty_pages are introduced
> to satisfy the need for background sync.
>
> Meanwhile, introduce enumeration of sync method.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  include/exec/ramblock.h | 45 +++++++++++++++++++++++++++++++++++++++++
>  migration/ram.c         |  6 ++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 0babd105c0..0e327bc0ae 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -24,6 +24,30 @@
>  #include "qemu/rcu.h"
>  #include "exec/ramlist.h"
>  
> +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap */
> +
> +/*
> + * The old-fashioned sync, which is, in turn, used for CPU
> + * throttle and memory transfer.

I'm not sure I follow what "in turn" is supposed to mean in this
sentence. Could you clarify?

> + */
> +#define RAMBLOCK_SYN_LEGACY_ITER   (1U << 0)

So ITER is as opposed to background? I'm a bit confused with the terms.

> +
> +/*
> + * The modern sync, which is, in turn, used for CPU throttle
> + * and memory transfer.
> + */
> +#define RAMBLOCK_SYN_MODERN_ITER   (1U << 1)
> +
> +/* The modern sync, which is used for CPU throttle only */
> +#define RAMBLOCK_SYN_MODERN_BACKGROUND    (1U << 2)

What's the plan for the "legacy" part? To be removed soon? Do we want to
remove it now? Maybe better to not use the modern/legacy terms unless we
want to give the impression that the legacy one is discontinued.

> +
> +#define RAMBLOCK_SYN_MASK  (0x7)
> +
> +typedef enum RAMBlockSynMode {
> +    RAMBLOCK_SYN_LEGACY, /* Old-fashined mode */
> +    RAMBLOCK_SYN_MODERN, /* Background-sync-supported mode */
> +} RAMBlockSynMode;

I'm also wondering wheter we need this enum + the flags or one of them
would suffice. I'm looking at code like this in the following patches,
for instance:

+    if (sync_mode == RAMBLOCK_SYN_MODERN) {
+        if (background) {
+            flag = RAMBLOCK_SYN_MODERN_BACKGROUND;
+        } else {
+            flag = RAMBLOCK_SYN_MODERN_ITER;
+        }
+    }

Couldn't we use LEGACY/BG/ITER?

> +
>  struct RAMBlock {
>      struct rcu_head rcu;
>      struct MemoryRegion *mr;
> @@ -89,6 +113,27 @@ struct RAMBlock {
>       * could not have been valid on the source.
>       */
>      ram_addr_t postcopy_length;
> +
> +    /*
> +     * Used to backup the bmap during background sync to see whether any dirty
> +     * pages were sent during that time.
> +     */
> +    unsigned long *shadow_bmap;
> +
> +    /*
> +     * The bitmap "bmap," which was initially used for both sync and memory
> +     * transfer, will be replaced by two bitmaps: the previously used "bmap"
> +     * and the recently added "iter_bmap." Only the memory transfer is
> +     * conducted with the previously used "bmap"; the recently added
> +     * "iter_bmap" is utilized for dirty bitmap sync.
> +     */
> +    unsigned long *iter_bmap;
> +
> +    /* Number of new dirty pages during iteration */
> +    uint64_t iter_dirty_pages;
> +
> +    /* If background sync has shown up during iteration */
> +    bool background_sync_shown_up;
>  };
>  #endif
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 67ca3d5d51..f29faa82d6 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2362,6 +2362,10 @@ static void ram_bitmaps_destroy(void)
>          block->bmap = NULL;
>          g_free(block->file_bmap);
>          block->file_bmap = NULL;
> +        g_free(block->shadow_bmap);
> +        block->shadow_bmap = NULL;
> +        g_free(block->iter_bmap);
> +        block->iter_bmap = NULL;
>      }
>  }
>  
> @@ -2753,6 +2757,8 @@ static void ram_list_init_bitmaps(void)
>              }
>              block->clear_bmap_shift = shift;
>              block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> +            block->shadow_bmap = bitmap_new(pages);
> +            block->iter_bmap = bitmap_new(pages);
>          }
>      }
>  }

