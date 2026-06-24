Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF676CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOia-0006yQ-LZ; Wed, 24 Jun 2026 10:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcOiR-0006y4-4o
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:36:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcOiM-0002QT-Vd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:36:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B42466D76F;
 Wed, 24 Jun 2026 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782311789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23W8qco7JuMnwZKCHmvkrgsGnTnmIeVNQ3p+uAYI8UM=;
 b=u36Xg32ncYdEsp2eYt+RoCA0+pMFEZLWo3r50+4i4ueEnMoSw/lpMqa0C+Z79vpYkXflqA
 bVZU8nWgq7PrSv72PuvkvyAHBQ8e1p61y/02DFsf6cSguxaMW84+JR7N9G4IXlZMUVgNp8
 u1J5FePqUfZd4jp/7Q6QROvLMhCOg4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782311789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23W8qco7JuMnwZKCHmvkrgsGnTnmIeVNQ3p+uAYI8UM=;
 b=AJqZIhRFfnA9rVsrXTGJHCMKxyBTHD+a0WvWe9pimC3NJg5DmRYYY6UExPrXCO0DU6FAyw
 bCV3rSHPy/4PrXCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Usg/gv2/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yZu1B15B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782311788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23W8qco7JuMnwZKCHmvkrgsGnTnmIeVNQ3p+uAYI8UM=;
 b=Usg/gv2/MU/6eO0OqvrxgEDCIb3hc34oDmZglaB6EfsrQ/gbfDri6tqv3wQcAaTYjSV4+X
 pmzchTkifbzVayQNjqiO7Y3ZQJa6OiGSBg451sqrk9zLnFyzrutDlcw8fZ6PX6pZQjEji0
 Q/oIKPNyzxxlKLF1O8GdKDOInWknpSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782311788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23W8qco7JuMnwZKCHmvkrgsGnTnmIeVNQ3p+uAYI8UM=;
 b=yZu1B15Bi6FfBB/RtIZb22s3My61O9o+px9DjeOt+SU7gZ2+W/m0/WPv+ge2bt2l3QZIsk
 qavfRgoxLsT+asDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5337A779A8;
 Wed, 24 Jun 2026 14:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0m1BCWzrO2rJSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 24 Jun 2026 14:36:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Aadeshveer Singh <aadeshveer07@gmail.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, Aadeshveer Singh
 <aadeshveer07@gmail.com>
Subject: Re: [RFC PATCH 2/5] migration: add support for fault thread to load
 pages from disk
In-Reply-To: <20260618032010.88755-3-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-3-aadeshveer07@gmail.com>
Date: Wed, 24 Jun 2026 11:36:21 -0300
Message-ID: <874iisoviy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B42466D76F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,mailo.com,saferwall.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URG_BIZ=0.573 autolearn=no autolearn_force=no
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

Aadeshveer Singh <aadeshveer07@gmail.com> writes:

> In fast snapshot load, we would like to serve faults as soon as possible
> hence loading pages directly instead of requesting a source
>
> Add postcopy_mapped_ram_load_page() function which serves single page
> fault by reading the snapshot file. It uses bitmap_test_and_clear_atomic
> on pending_bmap to coordinate between threads so each page is loaded
> exactly once. Non-zero pages are read using qemu_get_buffer_at into a
> temporary page (for loading page atomically), which is then placed using
> postcopy_place_page. Zero pages are placed directly using
> postcopy_place_page_zero.
>
> Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> instead of requesting source in case of fast snapshot load. to_src_file
> check is bypassed in fast snapshot load case as there is no source
>
> Allocate another channel in postcopy_temp_pages_setup(like the preempt
> case), for both the fault thread and eager thread to load pages
> independently.
>
> In case of failure to read required page crash the system using assert
> as disk failure is critical and VM cannot be recovered.
>
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/postcopy-ram.c | 92 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 75 insertions(+), 17 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index f5ef93f193..1ec20a07dd 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -949,6 +949,53 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                         pagesize);
>  }
>  
> +/*
> + * Load a page from RAMBlock at offset at given host address.
> + * Used by postcopy ram fault thread and eager thread in fast snapshot load
> + * case. rb_offset: Offset of page in RAMBlock haddr: Base of page where to load
> + * in page Channel: Used to identify between threads and use corresponding temp
> + * pages Returns 0 on success
> + */
> +static int postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> +                                         RAMBlock *rb, ram_addr_t rb_offset,
> +                                         uint64_t haddr, int channel)
> +{
> +    int ret = 0;
> +    unsigned long page;
> +    void *host = (void *)haddr;
> +    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
> +    size_t read;
> +
> +    page = rb_offset >> TARGET_PAGE_BITS;
> +
> +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> +        if (test_bit(page, rb->nonzeropages)) {
> +            /*
> +             * qemu_get_buffer_at uses preadv which is thread safe we do not
> +             * need different channels
> +             */
> +            read = qemu_get_buffer_at(mis->from_src_file, place_source,
> +                                      TARGET_PAGE_SIZE,
> +                                      rb->pages_offset + rb_offset);
> +
> +            g_assert(read == TARGET_PAGE_SIZE);
> +
> +            ret = postcopy_place_page(mis, host, place_source, rb);
> +            if (ret) {
> +                return ret;
> +            }
> +
> +        } else {
> +            /* zero page */
> +            ret = postcopy_place_page_zero(mis, host, rb);
> +            if (ret) {
> +                return ret;
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
>  /*
>   * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
>   * also optional: when zero is provided, the fault accounting will be ignored.
> @@ -1320,11 +1367,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
>              break;
>          }
>  
> -        if (!mis->to_src_file) {
> +        if (!migrate_fast_snapshot_load() && !mis->to_src_file) {
>              /*
> -             * Possibly someone tells us that the return path is
> -             * broken already using the event. We should hold until
> -             * the channel is rebuilt.
> +             * Fast snapshot load has no to src file or in other case someone
> +             * possibly tells us that the return path is broken already using
> +             * the event. We should hold until the channel is rebuilt.
>               */
>              postcopy_pause_fault_thread(mis);
>          }
> @@ -1387,18 +1434,26 @@ static void *postcopy_ram_fault_thread(void *opaque)
>                                                  qemu_ram_get_idstr(rb),
>                                                  rb_offset,
>                                                  msg.arg.pagefault.feat.ptid);
> +
> +            if (migrate_fast_snapshot_load()) {

You probably want to check mapped_ram here instead as this is already
under the postcopy path.

I haven't reviewed the entire series yet, but I'm questioning whether we
need the new term (fast snapshot) at all.

> +                if (postcopy_mapped_ram_load_page(
> +                        mis, rb, rb_offset, msg.arg.pagefault.address, 1)) {
> +                    break;
> +                }
> +            } else {
>  retry:
> -            /*
> -             * Send the request to the source - we want to request one
> -             * of our host page sizes (which is >= TPS)
> -             */
> -            ret = postcopy_request_page(mis, rb, rb_offset,
> -                                        msg.arg.pagefault.address,
> -                                        msg.arg.pagefault.feat.ptid);
> -            if (ret) {
> -                /* May be network failure, try to wait for recovery */
> -                postcopy_pause_fault_thread(mis);
> -                goto retry;
> +                /*
> +                 * Send the request to the source - we want to request one
> +                 * of our host page sizes (which is >= TPS)
> +                 */
> +                ret = postcopy_request_page(mis, rb, rb_offset,
> +                                            msg.arg.pagefault.address,
> +                                            msg.arg.pagefault.feat.ptid);
> +                if (ret) {
> +                    /* May be network failure, try to wait for recovery */
> +                    postcopy_pause_fault_thread(mis);
> +                    goto retry;
> +                }
>              }
>          }
>  
> @@ -1471,8 +1526,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>      unsigned i, channels;
>      void *temp_page;
>  
> -    if (migrate_postcopy_preempt()) {
> -        /* If preemption enabled, need extra channel for urgent requests */
> +    if (migrate_postcopy_preempt() || migrate_fast_snapshot_load()) {
> +        /*
> +         * If preemption enabled or it is fast snapshot load, need extra channel
> +         * for urgent requests/faults
> +         */
>          mis->postcopy_channels = RAM_CHANNEL_MAX;
>      } else {
>          /* Both precopy/postcopy on the same channel */

