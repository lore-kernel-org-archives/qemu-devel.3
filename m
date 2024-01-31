Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779D0C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 15:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVCVP-0000HB-TS; Wed, 31 Jan 2024 10:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVCVM-0000H2-2v
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:28:00 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVCVK-0007qq-4V
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:27:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61BB01FB87;
 Wed, 31 Jan 2024 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706714874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+DNZ6I32eZMs6ZzKj2i0TW6Vj+d9c3gaQT//9d5U4w=;
 b=0f08RQj6qIVwNFeWXSNcDoDLwjvsWV2tBmHBL7MQk42arzzZrx0S0/4pR2YmSy6nCWH7Bt
 ZJDIafToyET8UYp0++H2+u1Fy81UHh6omqiHvERfUhXukpx901iWK6Zpa9V+z4ajtVUn9r
 D20KNkthVQRX+I/x5xETjZcqOLJIC0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706714874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+DNZ6I32eZMs6ZzKj2i0TW6Vj+d9c3gaQT//9d5U4w=;
 b=I4oXRkuu1Y8nWbCqv76NndtxWPgsDeD+IeJ4AMpz20Vlk6AxEdA5X4frlIOck7sWPbA7X8
 Upin68eHlH2PsWAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706714874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+DNZ6I32eZMs6ZzKj2i0TW6Vj+d9c3gaQT//9d5U4w=;
 b=0f08RQj6qIVwNFeWXSNcDoDLwjvsWV2tBmHBL7MQk42arzzZrx0S0/4pR2YmSy6nCWH7Bt
 ZJDIafToyET8UYp0++H2+u1Fy81UHh6omqiHvERfUhXukpx901iWK6Zpa9V+z4ajtVUn9r
 D20KNkthVQRX+I/x5xETjZcqOLJIC0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706714874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+DNZ6I32eZMs6ZzKj2i0TW6Vj+d9c3gaQT//9d5U4w=;
 b=I4oXRkuu1Y8nWbCqv76NndtxWPgsDeD+IeJ4AMpz20Vlk6AxEdA5X4frlIOck7sWPbA7X8
 Upin68eHlH2PsWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E023D1347F;
 Wed, 31 Jan 2024 15:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H60hKPlmumWNIgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 15:27:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, Prasad Pandit
 <ppandit@redhat.com>, peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 04/14] migration/multifd: Postpone reset of MultiFDPages_t
In-Reply-To: <20240131103111.306523-5-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-5-peterx@redhat.com>
Date: Wed, 31 Jan 2024 12:27:51 -0300
Message-ID: <87wmrpjzew.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0f08RQj6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I4oXRkuu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 61BB01FB87
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Now we reset MultiFDPages_t object in the multifd sender thread in the
> middle of the sending job.  That's not necessary, because the "*pages"
> struct will not be reused anyway until pending_job is cleared.
>
> Move that to the end after the job is completed, provide a helper to reset
> a "*pages" object.  Use that same helper when free the object too.
>
> This prepares us to keep using p->pages in the follow up patches, where we
> may drop p->normal[].
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

Just an observation about the code below.

> ---
>  migration/multifd.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 2c98023d67..5633ac245a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -172,6 +172,17 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
>      multifd_ops[method] = ops;
>  }
>  
> +/* Reset a MultiFDPages_t* object for the next use */
> +static void multifd_pages_reset(MultiFDPages_t *pages)
> +{
> +    /*
> +     * We don't need to touch offset[] array, because it will be
> +     * overwritten later when reused.
> +     */
> +    pages->num = 0;
> +    pages->block = NULL;

Having to do this at all is a huge overloading of this field. This not
only resets it, but it also communicates to multifd_queue_page() that
the previous payload has been sent. Otherwise, multifd_queue_page()
wouldn't know whether the previous call to multifd_queue_page() has
called multifd_send_pages() or if it has exited early. So this basically
means "the block that was previously here has been sent".

That's why we need the changed=true logic. A
multifd_send_state->pages->block still has a few pages left to send, but
because it's less than pages->allocated, it skips
multifd_send_pages(). The next call to multifd_queue_page() already has
the next ramblock. So we set changed=true, call multifd_send_pages() to
send the remaining pages of that block and recurse into
multifd_queue_page() once more to send the new block.

> +}
> +
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>  {
>      MultiFDInit_t msg = {};
> @@ -248,9 +259,8 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>  
>  static void multifd_pages_clear(MultiFDPages_t *pages)
>  {
> -    pages->num = 0;
> +    multifd_pages_reset(pages);
>      pages->allocated = 0;
> -    pages->block = NULL;
>      g_free(pages->offset);
>      pages->offset = NULL;
>      g_free(pages);
> @@ -704,8 +714,6 @@ static void *multifd_send_thread(void *opaque)
>              p->flags = 0;
>              p->num_packets++;
>              p->total_normal_pages += p->normal_num;
> -            p->pages->num = 0;
> -            p->pages->block = NULL;
>              qemu_mutex_unlock(&p->mutex);
>  
>              trace_multifd_send(p->id, packet_num, p->normal_num, flags,
> @@ -732,6 +740,8 @@ static void *multifd_send_thread(void *opaque)
>  
>              stat64_add(&mig_stats.multifd_bytes,
>                         p->next_packet_size + p->packet_len);
> +
> +            multifd_pages_reset(p->pages);
>              p->next_packet_size = 0;
>              qemu_mutex_lock(&p->mutex);
>              p->pending_job--;

