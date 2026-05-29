Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD25CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxjb-0002ha-6C; Fri, 29 May 2026 09:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSxjW-0002go-Ja
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSxjS-0005n2-Gd
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780063116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jybq5PqfkAkVsAuo/kEZFJVGNKVFlXSHOtKxIqagVJ0=;
 b=YCs0kU1SZ5/YydGbpUKNctS2xEt5F7wOsLNM19prZY8ZbKz/zxkNToEmUMWPVWiDxTBayo
 44hjKh08luFXoAmuALU4hziXServuG/8N+AW8qbEmGknfBJNr8B7wTQmmAOSVR4VPm1RYR
 Xi/sQb1BbOMRulYNvSESnEQiMVfa4M4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-sN-HO3zOMsC3UtPPMLcUjQ-1; Fri,
 29 May 2026 09:58:34 -0400
X-MC-Unique: sN-HO3zOMsC3UtPPMLcUjQ-1
X-Mimecast-MFC-AGG-ID: sN-HO3zOMsC3UtPPMLcUjQ_1780063113
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D9E1800367; Fri, 29 May 2026 13:58:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A29C180034E; Fri, 29 May 2026 13:58:29 +0000 (UTC)
Date: Fri, 29 May 2026 15:58:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, hreitz@redhat.com
Subject: Re: [PATCH] block/io: skip conflict scan when no serialising
 requests exist
Message-ID: <ahmbg7HxmLV7GMvF@redhat.com>
References: <20260529031215.59494-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529031215.59494-1-guobin@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 29.05.2026 um 05:12 hat Bin Guo geschrieben:
> bdrv_find_conflicting_request() always linearly scans the
> tracked_requests list looking for overlapping serialising requests.
> However, BlockDriverState already maintains a serialising_in_flight
> atomic counter that is incremented/decremented as serialising
> requests are created/destroyed.
> 
> When the counter is zero there are no serialising requests in the
> list and the scan is guaranteed to find nothing, so return NULL
> immediately.  This complements the existing fast path in
> bdrv_wait_serialising_requests() which checks the same counter
> before acquiring reqs_lock.
> 
> No functional change.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  block/io.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/io.c b/block/io.c
> index e8fb4ede4d..eb7ba59a90 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -649,6 +649,15 @@ bdrv_find_conflicting_request(BdrvTrackedRequest *self)
>  {
>      BdrvTrackedRequest *req;
>  
> +    /*
> +     * Fast path: if there are no serialising requests in flight, there
> +     * can be no conflicts.  This mirrors the check in
> +     * bdrv_wait_serialising_requests().
> +     */
> +    if (!qatomic_read(&self->bs->serialising_in_flight)) {
> +        return NULL;
> +    }

Isn't this dead code? You get the following callers:

- bdrv_wait_serialising_requests_locked
  - bdrv_wait_serialising_requests: Already has the check, as you
    mention in the commit message
  - bdrv_make_request_serialising: tracked_request_set_serialising()
    increases bs->serialising_in_flight
- bdrv_co_write_req_prepare: tracked_request_set_serialising() again

I think the only way this could trigger if you hit the minimal race
window in bdrv_wait_serialising_requests() between the identical check
and taking the lock.

Kevin


