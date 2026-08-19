Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F9C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhky-0001cI-Ik; Wed, 19 Aug 2026 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhkn-00013R-8p
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:58:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhkl-0000jw-Qe
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:58:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D0E3B3E99;
 Wed, 19 Aug 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787151530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsSA3OBhMiUOCC34agbtuFJoqr0IlnWDUNTI51o/2C0=;
 b=ai0ie6O8OGcpCQIi9b1SsGS88azmQyxmMPgZLSWLFIRQbaMSr1UbH5y42Cus1kSrhyv55j
 YuGDewoUBLWzXqjXZ+CYWLSPeqRNsGSn0sReppS9zt/r2RerC+ET4Q6IMbVbZk6KKHY2o1
 EyqUSLuje4sqJb+DBBwlAf6cQiEdgd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787151530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsSA3OBhMiUOCC34agbtuFJoqr0IlnWDUNTI51o/2C0=;
 b=aE9/4gkvOYUeuBl7CWz8Ahh3mutH0Bp6GxWNVk5hZ3vJ9dzmvc2G+BK38H96nw49Z+FsTl
 1RI1d4/2Q82ngDCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787151525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsSA3OBhMiUOCC34agbtuFJoqr0IlnWDUNTI51o/2C0=;
 b=j7oJxVtjybme/MCoA1Xbfq8Ed0LcztgRmEkJBK+uECyeHKZV5Qz509VuksslSwkyjKvZ3u
 JOKXGaVHgdqKWUpa16SkgH81zaQq4fLjs7cMtAjTSjoZZu9bfFa8y2qMVzyToshGMChAYs
 Lh8WIqhW/RtFaS+UuICRrkydiinrjQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787151525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsSA3OBhMiUOCC34agbtuFJoqr0IlnWDUNTI51o/2C0=;
 b=cXUVy/Mbm4yHu9DNrCZ/xZyawfNqOdocNCSOSH3nb71D0CfZidKdHOhaT8xHbfBM1ZDhdO
 B9DLdjZ6vQicwlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71532362E;
 Wed, 19 Aug 2026 14:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m8DhEKXEhWo9JgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 14:58:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, lizhijian@fujitsu.com, Yanfei Xu
 <yanfei.xu@bytedance.com>
Subject: Re: [PATCH 1/3] migration/rdma: Fix write-side shutdown
In-Reply-To: <20260817105117.3072040-2-yanfei.xu@bytedance.com>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-2-yanfei.xu@bytedance.com>
Date: Wed, 19 Aug 2026 11:58:34 -0300
Message-ID: <87qzjukvhh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

"Yanfei Xu" <yanfei.xu@bytedance.com> writes:

> qio_channel_rdma_shutdown() reads rdmain for both the input and
> output contexts.  As a result, a write-side shutdown marks the input
> context as errored while leaving the output context active.  A shutdown
> of both directions also fails to stop the output context.
>
> Read rdmaout from the output context so each shutdown direction marks
> the corresponding RDMA context as errored.
>
> Fixes: 54db882f073a ("migration: implement the shutdown for RDMA QIOChannel")
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>  migration/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 438419d189..e17ace62b0 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2982,7 +2982,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
>      RCU_READ_LOCK_GUARD();
>  
>      rdmain = qatomic_rcu_read(&rioc->rdmain);
> -    rdmaout = qatomic_rcu_read(&rioc->rdmain);
> +    rdmaout = qatomic_rcu_read(&rioc->rdmaout);
>  
>      switch (how) {
>      case QIO_CHANNEL_SHUTDOWN_READ:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

