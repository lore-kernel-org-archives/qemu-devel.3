Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983C3C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 21:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVICm-0006ZD-Oe; Wed, 31 Jan 2024 16:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVICl-0006Xe-Cs
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 16:33:11 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVICZ-0004Ct-PH
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 16:33:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF6D31F86C;
 Wed, 31 Jan 2024 21:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706736777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCSfcyqtS9wuiOFXYPRtG5vJD5P6ntiairjfZbpWJDs=;
 b=153o5fnMKNPHdaSO/9YH53DOk4RmefF6gP3PysNayQCBDpGzSrxiZNhfOiJp/QNezy0l5l
 Np/cuyJNiIJteFXOLfP2VdV8AwVIDCuGmSSDLFEochogdNp9+DAtkFNW1Qm0IvNBNv4Xie
 saUvyr/JYpJYqYNykyEC6SKCEbpkukE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706736777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCSfcyqtS9wuiOFXYPRtG5vJD5P6ntiairjfZbpWJDs=;
 b=HFH61Nn9QEnbWVgJ2nCpSymH04hB/A0XmCQy566MAhg3MZTuUKAgn/aLoLY9B+NNpA0Nen
 2amy2w2PYWLEKiDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706736777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCSfcyqtS9wuiOFXYPRtG5vJD5P6ntiairjfZbpWJDs=;
 b=153o5fnMKNPHdaSO/9YH53DOk4RmefF6gP3PysNayQCBDpGzSrxiZNhfOiJp/QNezy0l5l
 Np/cuyJNiIJteFXOLfP2VdV8AwVIDCuGmSSDLFEochogdNp9+DAtkFNW1Qm0IvNBNv4Xie
 saUvyr/JYpJYqYNykyEC6SKCEbpkukE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706736777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCSfcyqtS9wuiOFXYPRtG5vJD5P6ntiairjfZbpWJDs=;
 b=HFH61Nn9QEnbWVgJ2nCpSymH04hB/A0XmCQy566MAhg3MZTuUKAgn/aLoLY9B+NNpA0Nen
 2amy2w2PYWLEKiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A13F1347F;
 Wed, 31 Jan 2024 21:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i3GbDIm8umVKbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 21:32:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, Prasad Pandit
 <ppandit@redhat.com>, peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 12/14] migration/multifd: multifd_send_prepare_header()
In-Reply-To: <20240131103111.306523-13-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-13-peterx@redhat.com>
Date: Wed, 31 Jan 2024 18:32:54 -0300
Message-ID: <87a5oljiih.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.11 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.01)[47.13%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
> Introduce a helper multifd_send_prepare_header() to setup the header packet
> for multifd sender.
>
> It's fine to setup the IOV[0] _before_ send_prepare() because the packet
> buffer is already ready, even if the content is to be filled in.
>
> With this helper, we can already slightly clean up the zero copy path.
>
> Note that I explicitly put it into multifd.h, because I want it inlined
> directly into multifd*.c where necessary later.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

nit below:

> ---
>  migration/multifd.h |  8 ++++++++
>  migration/multifd.c | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 2e4ad0dc56..4ec005f53f 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -209,5 +209,13 @@ typedef struct {
>  
>  void multifd_register_ops(int method, MultiFDMethods *ops);
>  
> +static inline void multifd_send_prepare_header(MultiFDSendParams *p)
> +{
> +    p->iov[0].iov_len = p->packet_len;
> +    p->iov[0].iov_base = p->packet;
> +    p->iovs_num++;
> +}
> +
> +
>  #endif
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 8d4b80f365..1b0035787e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -707,10 +707,14 @@ static void *multifd_send_thread(void *opaque)
>          if (p->pending_job) {
>              MultiFDPages_t *pages = p->pages;
>  
> -            if (use_zero_copy_send) {
> -                p->iovs_num = 0;
> -            } else {
> -                p->iovs_num = 1;
> +            p->iovs_num = 0;
> +
> +            if (!use_zero_copy_send) {
> +                /*
> +                 * Only !zero_copy needs the header in IOV; zerocopy will
> +                 * send it separately.

Could use the same spelling for both mentions to zero copy.

> +                 */
> +                multifd_send_prepare_header(p);
>              }
>  
>              assert(pages->num);
> @@ -730,10 +734,6 @@ static void *multifd_send_thread(void *opaque)
>                  if (ret != 0) {
>                      break;
>                  }
> -            } else {
> -                /* Send header using the same writev call */
> -                p->iov[0].iov_len = p->packet_len;
> -                p->iov[0].iov_base = p->packet;
>              }
>  
>              ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,

