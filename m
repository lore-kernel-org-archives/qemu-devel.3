Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0CCE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYcQ-0003jL-Hp; Fri, 06 Dec 2024 08:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJYcM-0003j9-AO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:43:38 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJYcK-0006IJ-9r
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:43:37 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBB4C1F38E;
 Fri,  6 Dec 2024 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733492614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFyCSmBBSnA2/8/RKUeYwJNpubNYQqhUkdOl+aPdZwA=;
 b=ju5GOH7FLqCHwvEuTjglpTmV9NnjceK/dRxtMoY+cMbHARxphoFboTW//+w7agd3WYzhON
 3qUhdot+QQXPYuP+P6VonPX4sZVSczitv8qdsoRbKz3x+Niveo26Sg+ib8aJz2kqr3IvFa
 QszEax+HUCvvM4eKRj8ctVGDWMp2wTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733492614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFyCSmBBSnA2/8/RKUeYwJNpubNYQqhUkdOl+aPdZwA=;
 b=YUJ9s3VaeO8QqebJim+vRcqaOezBtEgKuYBhb0fx+8SuRCoBC3SHTS0g1AuwDGq3j8+kql
 E3F8B31ZRuA0nbDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733492614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFyCSmBBSnA2/8/RKUeYwJNpubNYQqhUkdOl+aPdZwA=;
 b=ju5GOH7FLqCHwvEuTjglpTmV9NnjceK/dRxtMoY+cMbHARxphoFboTW//+w7agd3WYzhON
 3qUhdot+QQXPYuP+P6VonPX4sZVSczitv8qdsoRbKz3x+Niveo26Sg+ib8aJz2kqr3IvFa
 QszEax+HUCvvM4eKRj8ctVGDWMp2wTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733492614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFyCSmBBSnA2/8/RKUeYwJNpubNYQqhUkdOl+aPdZwA=;
 b=YUJ9s3VaeO8QqebJim+vRcqaOezBtEgKuYBhb0fx+8SuRCoBC3SHTS0g1AuwDGq3j8+kql
 E3F8B31ZRuA0nbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5380813647;
 Fri,  6 Dec 2024 13:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DvTWBob/UmfyWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 13:43:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 3/7] migration/ram: Move RAM_SAVE_FLAG* into ram.h
In-Reply-To: <20241206005834.1050905-4-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-4-peterx@redhat.com>
Date: Fri, 06 Dec 2024 10:43:31 -0300
Message-ID: <874j3hc4fw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Firstly, we're going to use the multifd flag soon in multifd code, so ram.c
> isn't gonna work.
>
> Secondly, we have a separate RDMA flag dangling around, which is definitely
> not obvious.  There's one comment that helps, but not too much.
>
> We should just put it altogether, so nothing will get overlooked.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

just some comments about preexisting stuff:

> ---
>  migration/ram.h  | 25 +++++++++++++++++++++++++
>  migration/rdma.h |  7 -------
>  migration/ram.c  | 21 ---------------------
>  3 files changed, 25 insertions(+), 28 deletions(-)
>
> diff --git a/migration/ram.h b/migration/ram.h
> index 0d1981f888..cfdcccd266 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -33,6 +33,31 @@
>  #include "exec/cpu-common.h"
>  #include "io/channel.h"
>  
> +/*
> + * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
> + * worked for pages that were filled with the same char.  We switched
> + * it to only search for the zero value.  And to avoid confusion with
> + * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
> + *
> + * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
> + *
> + * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.

Aren't these already covered by git log? The comment makes it seem like
some special situation, but I think we're just documenting history here,
no?

> + */
> +#define RAM_SAVE_FLAG_FULL     0x01
> +#define RAM_SAVE_FLAG_ZERO     0x02
> +#define RAM_SAVE_FLAG_MEM_SIZE 0x04
> +#define RAM_SAVE_FLAG_PAGE     0x08
> +#define RAM_SAVE_FLAG_EOS      0x10
> +#define RAM_SAVE_FLAG_CONTINUE 0x20
> +#define RAM_SAVE_FLAG_XBZRLE   0x40
> +/*
> + * ONLY USED IN RDMA: Whenever this is found in the data stream, the flags
> + * will be passed to rdma functions in the incoming-migration side.
> + */
> +#define RAM_SAVE_FLAG_HOOK     0x80

No 0x100?

> +#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
> +/* We can't use any flag that is bigger than 0x200 */

Where does that limitation come from again? I know that
RAM_SAVE_FLAG_MEM_SIZE shares a u64 with something else:

  qemu_put_be64(f, ram_bytes_total_with_ignored() |
  RAM_SAVE_FLAG_MEM_SIZE);

For RAM_SAVE_FLAG_ZERO and RAM_SAVE_FLAG_PAGE, it might be a u32 (offset
is ram_addr_t):

  save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);

But others just go by themselves:

qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);


> +
>  extern XBZRLECacheStats xbzrle_counters;
>  
>  /* Should be holding either ram_list.mutex, or the RCU lock. */
> diff --git a/migration/rdma.h b/migration/rdma.h
> index a8d27f33b8..f55f28bbed 100644
> --- a/migration/rdma.h
> +++ b/migration/rdma.h
> @@ -33,13 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
>  #define RAM_CONTROL_ROUND     1
>  #define RAM_CONTROL_FINISH    3
>  
> -/*
> - * Whenever this is found in the data stream, the flags
> - * will be passed to rdma functions in the incoming-migration
> - * side.
> - */
> -#define RAM_SAVE_FLAG_HOOK     0x80
> -
>  #define RAM_SAVE_CONTROL_NOT_SUPP -1000
>  #define RAM_SAVE_CONTROL_DELAYED  -2000
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 7284c34bd8..44010ff325 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -71,27 +71,6 @@
>  /***********************************************************/
>  /* ram save/restore */
>  
> -/*
> - * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
> - * worked for pages that were filled with the same char.  We switched
> - * it to only search for the zero value.  And to avoid confusion with
> - * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
> - *
> - * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
> - *
> - * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
> - */
> -#define RAM_SAVE_FLAG_FULL     0x01
> -#define RAM_SAVE_FLAG_ZERO     0x02
> -#define RAM_SAVE_FLAG_MEM_SIZE 0x04
> -#define RAM_SAVE_FLAG_PAGE     0x08
> -#define RAM_SAVE_FLAG_EOS      0x10
> -#define RAM_SAVE_FLAG_CONTINUE 0x20
> -#define RAM_SAVE_FLAG_XBZRLE   0x40
> -/* 0x80 is reserved in rdma.h for RAM_SAVE_FLAG_HOOK */
> -#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
> -/* We can't use any flag that is bigger than 0x200 */
> -
>  /*
>   * mapped-ram migration supports O_DIRECT, so we need to make sure the
>   * userspace buffer, the IO operation size and the file offset are

