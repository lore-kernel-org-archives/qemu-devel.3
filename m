Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E088C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zOd-0003wf-HN; Tue, 22 Sep 2026 08:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x8zOb-0003vu-0P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x8zOZ-0005rE-3G
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790079285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+Mk2JltUEQDL6dp2YlvMvHa/FyTMrM9ab++wpt6ctE=;
 b=YMX270YKNWANjgSxfV+h/p+eq1kLlXAdXJs3Nlk9VSLQtILxGtUlDS1HLfIC3RRqxqKn3X
 9uM/32v4pe2QmxPRd/5Ox+105yAFrBhDwkISnA7Siy1WzjroLEsylr28Bmq2uhpUYR22Sj
 84ZV/sPhqKWyWlJVq+hMxvShP6x6yt8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-EuvQ02NkNAGR2iO8AeDTuA-1; Tue,
 22 Sep 2026 08:14:41 -0400
X-MC-Unique: EuvQ02NkNAGR2iO8AeDTuA-1
X-Mimecast-MFC-AGG-ID: EuvQ02NkNAGR2iO8AeDTuA_1790079280
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09617195422E; Tue, 22 Sep 2026 12:14:40 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F0D11800586; Tue, 22 Sep 2026 12:14:37 +0000 (UTC)
Date: Tue, 22 Sep 2026 14:14:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 5/9] block/accounting: Add BB field to latency checker
Message-ID: <arJxKg7414J7WnRD@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-6-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831135206.126184-6-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 31.08.2026 um 15:52 hat Hanna Czenczek geschrieben:
> The BlockBackend reference is required to be able to generate the QOM
> path as part of emitted events.
> 
> A weak reference is enough because BlockAcctStats is tied directly to
> one BlockBackend, and will be deleted via block_acct_cleanup() before
> the BlockBackend is truly deleted.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

The subject line is a bit confusing as there is no latency checker yet.
Should it say "to BlockAcctStats"?

>  include/block/accounting.h | 3 ++-
>  block/accounting.c         | 7 ++++++-
>  block/block-backend.c      | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)

> diff --git a/block/block-backend.c b/block/block-backend.c
> index 164bda846f4..ca091a8bf5d 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -369,7 +369,7 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm)
>      blk->on_read_error = BLOCKDEV_ON_ERROR_REPORT;
>      blk->on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
>  
> -    block_acct_init(&blk->stats);
> +    block_acct_init(blk, &blk->stats);

This is the only caller. I'm not sure what other callers could look
like, but now that a BlockBackend is required for it, could the second
parameter ever give any useful additional information (as opposed to
block_acct_init() just accessing blk->stats internally now that it has
blk)?

Kevin


