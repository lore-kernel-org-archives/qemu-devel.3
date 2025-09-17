Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F02BCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyx3G-0005P9-Hs; Wed, 17 Sep 2025 14:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyx3D-0005OF-WF
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:38:44 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyx3C-00069e-6H
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:38:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D4D25C214;
 Wed, 17 Sep 2025 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758134319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQM60jFDGP1rgnw3s8S+VcYEW6BNwBHuoaK16sYwvmI=;
 b=zzDoZ26MOl4B6Cl7JKotxjoPdbBmZMQjKOf2NjI/gOslvSO4cT6+pK8SQFg4hPMuAuKGx4
 UIucFe6vBWvQ6/Zr0doLxRSjeaQz8tC7gYvRTkyYEPh6kOrDNx74Lrdq918nua8FxrEVP6
 lfdjpojCsmKp8jAkcRH5Hbb8IaWrOSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758134319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQM60jFDGP1rgnw3s8S+VcYEW6BNwBHuoaK16sYwvmI=;
 b=oci7aHmFNY4ZIVoRccVHh9m6RpOu/k4Ewpm44LJsJWbOwwVhF5kI8zzm8N4I/SvpujaPgL
 WNZM4Afl8gJHniBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758134319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQM60jFDGP1rgnw3s8S+VcYEW6BNwBHuoaK16sYwvmI=;
 b=zzDoZ26MOl4B6Cl7JKotxjoPdbBmZMQjKOf2NjI/gOslvSO4cT6+pK8SQFg4hPMuAuKGx4
 UIucFe6vBWvQ6/Zr0doLxRSjeaQz8tC7gYvRTkyYEPh6kOrDNx74Lrdq918nua8FxrEVP6
 lfdjpojCsmKp8jAkcRH5Hbb8IaWrOSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758134319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQM60jFDGP1rgnw3s8S+VcYEW6BNwBHuoaK16sYwvmI=;
 b=oci7aHmFNY4ZIVoRccVHh9m6RpOu/k4Ewpm44LJsJWbOwwVhF5kI8zzm8N4I/SvpujaPgL
 WNZM4Afl8gJHniBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86AFB1368D;
 Wed, 17 Sep 2025 18:38:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fN29EC4Ay2hJVwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 18:38:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 9/9] migration/rdma: Remove rdma_cm_poll_handler
In-Reply-To: <20250827205949.364606-10-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-10-peterx@redhat.com>
Date: Wed, 17 Sep 2025 15:38:35 -0300
Message-ID: <877bxwx6tw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[14];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

> This almost reverts commit 923709896b1b01fb982c93492ad01b233e6b6023.
>
> It was needed because the RDMA iochannel on dest QEMU used to only yield
> without monitoring the fd.  Now it should be monitored by the same poll()
> similarly on the src QEMU in qemu_rdma_wait_comp_channel().  So even
> without the fd handler, dest QEMU should be able to receive the events.
>
> I tested this by initiating an RDMA migration, then do two things:
>
>   - Either does migrate_cancel on src, or,
>   - Directly kill destination QEMU
>
> In both cases, the other side of QEMU will be able to receive the
> disconnect event in qemu_rdma_wait_comp_channel() and properly cancel or
> fail the migration.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 7751262460..da7fd48bf3 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3045,32 +3045,6 @@ int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>  
>  static void rdma_accept_incoming_migration(void *opaque);
>  
> -static void rdma_cm_poll_handler(void *opaque)
> -{
> -    RDMAContext *rdma = opaque;
> -    struct rdma_cm_event *cm_event;
> -
> -    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
> -        error_report("get_cm_event failed %d", errno);
> -        return;
> -    }
> -
> -    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
> -        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
> -        if (!rdma->errored &&
> -            migration_incoming_get_current()->state !=
> -              MIGRATION_STATUS_COMPLETED) {
> -            error_report("receive cm event, cm event is %d", cm_event->event);
> -            rdma->errored = true;
> -            if (rdma->return_path) {
> -                rdma->return_path->errored = true;
> -            }
> -        }
> -        rdma_ack_cm_event(cm_event);
> -    }
> -    rdma_ack_cm_event(cm_event);
> -}
> -
>  static int qemu_rdma_accept(RDMAContext *rdma)
>  {
>      Error *err = NULL;
> @@ -3188,8 +3162,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>                              NULL,
>                              (void *)(intptr_t)rdma->return_path);
>      } else {
> -        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
> -                            NULL, rdma);
> +        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);

I'm not familiar with this code, but is this left here to remove the
handler? Can't we remove this line altogether?

>      }
>  
>      ret = rdma_accept(rdma->cm_id, &conn_param);

