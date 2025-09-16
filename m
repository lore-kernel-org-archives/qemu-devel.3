Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADB9CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 22:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyeKp-0000OK-EF; Tue, 16 Sep 2025 18:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyeKn-0000Nn-0A
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 18:39:37 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyeKl-0003xz-9u
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 18:39:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF6AA1F387;
 Tue, 16 Sep 2025 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758062374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MnBdihMLi9coYUwHFYWo4DfI8FDgNlV8XDmh95O2ch0=;
 b=jySPXeFsRrDw7sfGlj1T8pbXTy4frj0TGwrZ6Qd56kfY+4j6f9iASDbXC/JECb0Vyz/Aa+
 jvyMB/H99sb/OOyY4/YOli2ZWnaHdDguorEnFwrAKid/pvdXoD/znhL4Ygnd7Yxt5pAuvY
 rzLx07Aw2Rl79hyXuDiXJSUCN/MEG9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758062374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MnBdihMLi9coYUwHFYWo4DfI8FDgNlV8XDmh95O2ch0=;
 b=a2SunHpwyRCPkMkR4GFuDl5R3ANMe0tNewbnDyM97SXJXXEOLPaF2XoJkJUWXB+knDntI/
 Z19+/prYd3kGoNBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HXWVjF9/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GRxsOMyu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758062373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MnBdihMLi9coYUwHFYWo4DfI8FDgNlV8XDmh95O2ch0=;
 b=HXWVjF9/3S4v+nSiR2RgUCX6JSAmYJbagj/t+yQQxP8tItT+9eep6tuyQJVqnG/fUPtgd6
 1TufSvkEzryoAyxWaM/3oeAFzuntLLzm0z4OnIVPnIrWl/Xr78QAJ40HGG6fBp/GGLLTuS
 JTid8ZFvsQMr+LzPhLwkdFxxSvZW9ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758062373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MnBdihMLi9coYUwHFYWo4DfI8FDgNlV8XDmh95O2ch0=;
 b=GRxsOMyu/QtyL9GvzU/2geUtsVtK3an6OdahGDb6XlDK6fLgPcgUAIJF3ysljXtu6kRiQL
 35jyurjHJixjJSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17DF513A63;
 Tue, 16 Sep 2025 22:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HorAMSTnyWgKYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Sep 2025 22:39:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 6/9] migration/rdma: Remove coroutine path in
 qemu_rdma_wait_comp_channel
In-Reply-To: <20250827205949.364606-7-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-7-peterx@redhat.com>
Date: Tue, 16 Sep 2025 19:39:30 -0300
Message-ID: <87ikhivx7h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[14];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: AF6AA1F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> Now after threadified dest VM load during precopy, we will always in a
> thread context rather than within a coroutine.  We can remove this path
> now.
>
> With that, migration_started_on_destination can go away too.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 102 +++++++++++++++++++----------------------------
>  1 file changed, 41 insertions(+), 61 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 2b995513aa..7751262460 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -29,7 +29,6 @@
>  #include "qemu/rcu.h"
>  #include "qemu/sockets.h"
>  #include "qemu/bitmap.h"
> -#include "qemu/coroutine.h"
>  #include "system/memory.h"
>  #include <sys/socket.h>
>  #include <netdb.h>
> @@ -357,13 +356,6 @@ typedef struct RDMAContext {
>      /* Index of the next RAMBlock received during block registration */
>      unsigned int    next_src_index;
>  
> -    /*
> -     * Migration on *destination* started.
> -     * Then use coroutine yield function.
> -     * Source runs in a thread, so we don't care.
> -     */
> -    int migration_started_on_destination;
> -
>      int total_registrations;
>      int total_writes;
>  
> @@ -1353,66 +1345,55 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
>      struct rdma_cm_event *cm_event;
>  
>      /*
> -     * Coroutine doesn't start until migration_fd_process_incoming()
> -     * so don't yield unless we know we're running inside of a coroutine.
> +     * This is the source or dest side, either during precopy or
> +     * postcopy.  We're always in a separate thread when reaching here.
> +     * Poll the fd.  We need to be able to handle 'cancel' or an error
> +     * without hanging forever.
>       */
> -    if (rdma->migration_started_on_destination &&
> -        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE &&
> -        qemu_in_coroutine()) {
> -        yield_until_fd_readable(comp_channel->fd);
> -    } else {
> -        /* This is the source side, we're in a separate thread
> -         * or destination prior to migration_fd_process_incoming()
> -         * after postcopy, the destination also in a separate thread.
> -         * we can't yield; so we have to poll the fd.
> -         * But we need to be able to handle 'cancel' or an error
> -         * without hanging forever.
> -         */
> -        while (!rdma->errored && !rdma->received_error) {
> -            GPollFD pfds[2];
> -            pfds[0].fd = comp_channel->fd;
> -            pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> -            pfds[0].revents = 0;
> -
> -            pfds[1].fd = rdma->channel->fd;
> -            pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> -            pfds[1].revents = 0;
> -
> -            /* 0.1s timeout, should be fine for a 'cancel' */
> -            switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
> -            case 2:
> -            case 1: /* fd active */
> -                if (pfds[0].revents) {
> -                    return 0;
> -                }
> +    while (!rdma->errored && !rdma->received_error) {
> +        GPollFD pfds[2];
> +        pfds[0].fd = comp_channel->fd;
> +        pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> +        pfds[0].revents = 0;
> +
> +        pfds[1].fd = rdma->channel->fd;
> +        pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> +        pfds[1].revents = 0;
> +
> +        /* 0.1s timeout, should be fine for a 'cancel' */
> +        switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {

Don't glib have facilities for polling? Isn't this what
qio_channel_rdma_create_watch() is for already?

> +        case 2:
> +        case 1: /* fd active */
> +            if (pfds[0].revents) {
> +                return 0;
> +            }
>  
> -                if (pfds[1].revents) {
> -                    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
> -                        return -1;
> -                    }
> +            if (pfds[1].revents) {
> +                if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
> +                    return -1;
> +                }
>  
> -                    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
> -                        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
> -                        rdma_ack_cm_event(cm_event);
> -                        return -1;
> -                    }
> +                if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
> +                    cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
>                      rdma_ack_cm_event(cm_event);
> +                    return -1;
>                  }
> -                break;
> +                rdma_ack_cm_event(cm_event);
> +            }
> +            break;
>  
> -            case 0: /* Timeout, go around again */
> -                break;
> +        case 0: /* Timeout, go around again */
> +            break;
>  
> -            default: /* Error of some type -
> -                      * I don't trust errno from qemu_poll_ns
> -                     */
> -                return -1;
> -            }
> +        default: /* Error of some type -
> +                  * I don't trust errno from qemu_poll_ns
> +                  */
> +            return -1;
> +        }
>  
> -            if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
> -                /* Bail out and let the cancellation happen */
> -                return -1;
> -            }
> +        if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
> +            /* Bail out and let the cancellation happen */
> +            return -1;
>          }
>      }
>  
> @@ -3817,7 +3798,6 @@ static void rdma_accept_incoming_migration(void *opaque)
>          return;
>      }
>  
> -    rdma->migration_started_on_destination = 1;
>      migration_fd_process_incoming(f);
>  }

