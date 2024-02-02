Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C68FC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 20:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0RO-0000IS-1O; Fri, 02 Feb 2024 15:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW0RM-0000I3-Aa
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:47:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW0RK-0008CZ-J2
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:47:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 00C332222A;
 Fri,  2 Feb 2024 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706906829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7h/w6gY1Zo/ZkkP/nuWo/bB3IPlKoBjITOwB+wYQBjs=;
 b=nSBFg5cvX8oUFvhh13qiWoUssxq9P500d6tZfV7EzwBmQhB3QL4NmeouXpYZui+9K020b5
 Zfup5cMiFFLbB75Zz2H2f8HGydFiQXfXm5jDZd9X7BUAchMUdwOFjLhNoRYeg6Uf68ZdV1
 rVWc4PHfzMj2lx7BVfMNrdmbJtzendE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706906829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7h/w6gY1Zo/ZkkP/nuWo/bB3IPlKoBjITOwB+wYQBjs=;
 b=iAwjoRA2wvznVfozbNWBsRpzvrL283jwesk+0Da4G4ACFEJTyF6LQ00okk9xXi9njH4Sr0
 fMJmuDFKbW0Up2CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706906829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7h/w6gY1Zo/ZkkP/nuWo/bB3IPlKoBjITOwB+wYQBjs=;
 b=nSBFg5cvX8oUFvhh13qiWoUssxq9P500d6tZfV7EzwBmQhB3QL4NmeouXpYZui+9K020b5
 Zfup5cMiFFLbB75Zz2H2f8HGydFiQXfXm5jDZd9X7BUAchMUdwOFjLhNoRYeg6Uf68ZdV1
 rVWc4PHfzMj2lx7BVfMNrdmbJtzendE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706906829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7h/w6gY1Zo/ZkkP/nuWo/bB3IPlKoBjITOwB+wYQBjs=;
 b=iAwjoRA2wvznVfozbNWBsRpzvrL283jwesk+0Da4G4ACFEJTyF6LQ00okk9xXi9njH4Sr0
 fMJmuDFKbW0Up2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7573D13A58;
 Fri,  2 Feb 2024 20:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jZv1DsxUvWW1dwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 20:47:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 18/23] migration/multifd: Rewrite multifd_queue_page()
In-Reply-To: <20240202102857.110210-19-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-19-peterx@redhat.com>
Date: Fri, 02 Feb 2024 17:47:05 -0300
Message-ID: <87cyteh9va.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> The current multifd_queue_page() is not easy to read and follow.  It is not
> good with a few reasons:
>
>   - No helper at all to show what exactly does a condition mean; in short,
>   readability is low.
>
>   - Rely on pages->ramblock being cleared to detect an empty queue.  It's
>   slightly an overload of the ramblock pointer, per Fabiano [1], which I
>   also agree.
>
>   - Contains a self recursion, even if not necessary..
>
> Rewrite this function.  We add some comments to make it even clearer on
> what it does.
>
> [1] https://lore.kernel.org/r/87wmrpjzew.fsf@suse.de
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

Patch looks good, but I have a question below.

> ---
>  migration/multifd.c | 56 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 35d4e8ad1f..4ab8e6eff2 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -506,35 +506,53 @@ static bool multifd_send_pages(void)
>      return true;
>  }
>  
> +static inline bool multifd_queue_empty(MultiFDPages_t *pages)
> +{
> +    return pages->num == 0;
> +}
> +
> +static inline bool multifd_queue_full(MultiFDPages_t *pages)
> +{
> +    return pages->num == pages->allocated;
> +}
> +
> +static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
> +{
> +    pages->offset[pages->num++] = offset;
> +}
> +
>  /* Returns true if enqueue successful, false otherwise */
>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>  {
> -    MultiFDPages_t *pages = multifd_send_state->pages;
> -    bool changed = false;
> +    MultiFDPages_t *pages;
> +
> +retry:
> +    pages = multifd_send_state->pages;
>  
> -    if (!pages->block) {
> +    /* If the queue is empty, we can already enqueue now */
> +    if (multifd_queue_empty(pages)) {
>          pages->block = block;
> +        multifd_enqueue(pages, offset);
> +        return true;
>      }
>  
> -    if (pages->block == block) {
> -        pages->offset[pages->num] = offset;
> -        pages->num++;
> -
> -        if (pages->num < pages->allocated) {
> -            return true;
> +    /*
> +     * Not empty, meanwhile we need a flush.  It can because of either:
> +     *
> +     * (1) The page is not on the same ramblock of previous ones, or,
> +     * (2) The queue is full.
> +     *
> +     * After flush, always retry.
> +     */
> +    if (pages->block != block || multifd_queue_full(pages)) {
> +        if (!multifd_send_pages()) {
> +            return false;
>          }
> -    } else {
> -        changed = true;
> -    }
> -
> -    if (!multifd_send_pages()) {
> -        return false;
> -    }
> -
> -    if (changed) {
> -        return multifd_queue_page(block, offset);
> +        goto retry;
>      }
>  
> +    /* Not empty, and we still have space, do it! */
> +    multifd_enqueue(pages, offset);

Hm, here you're missing the flush of the last group of pages of the last
ramblock. Just like current code...

...which means we're relying on the multifd_send_pages() at
multifd_send_sync_main() to send the last few pages. So how can that
work when multifd_flush_after_each_section==false? Because it skips the
sync flag, but would also skip the last send. I'm confused.

