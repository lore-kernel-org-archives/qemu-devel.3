Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8A9E9A754
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4yPg-0001Sb-TH; Tue, 24 Mar 2026 05:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4yMs-0000u2-TR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4yMr-000878-57
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774345688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQEOWLu8gdsX8AWHzc8zelBgkdbmnQ9eyOqd5teKLfs=;
 b=TOaGtuOgean9YfeCy5Z+5xk8FHAhj0JZaffudkSEJ3DEmcAB45mE4BVaucf+Grv3eMNPYK
 dz6AQDdAff5zdY3YeUFe0Y1yMIRwgucrzPPcmy3DDKrdPy8SuJ2eqZ2kJl09zi8i9qB+U+
 0lQcGN2JmwMMnxkX9JPu6q8yEUR6fBU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-tIbua8woP3mdN15LrHvORg-1; Tue,
 24 Mar 2026 05:48:02 -0400
X-MC-Unique: tIbua8woP3mdN15LrHvORg-1
X-Mimecast-MFC-AGG-ID: tIbua8woP3mdN15LrHvORg_1774345681
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DF0518002C9; Tue, 24 Mar 2026 09:48:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.246])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8470019560B7; Tue, 24 Mar 2026 09:47:57 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:47:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: long.yunjian@zte.com.cn
Cc: hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mou.yi@zte.com.cn, liang.xianlong@zte.com.cn
Subject: Re: [PATCH] block: fix annotation
Message-ID: <acJdy1R7nojlNVrW@redhat.com>
References: <20260320091745976o3u3XYI9SyVZ0siV2roHH@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320091745976o3u3XYI9SyVZ0siV2roHH@zte.com.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 20.03.2026 um 02:17 hat long.yunjian@zte.com.cn geschrieben:
> From: Yunjian Long <long.yunjian@zte.com.cn>
> 
> The bdrv_bsc_is_data function is defined in block_int-io.h,
> so the correct annotation is block_int-io.h rather than block_int.h
> 
> Signed-off-by: Yunjian Long <long.yunjian@zte.com.cn>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 48a17f393c..3166114890 100644
> --- a/block.c
> +++ b/block.c
> @@ -8477,7 +8477,7 @@ static bool bdrv_bsc_range_overlaps_locked(BlockDriverState *bs,
>  }
> 
>  /**
> - * See block_int.h for this function's documentation.
> + * See block_int-io.h for this function's documentation.
>   */
>  bool bdrv_bsc_is_data(BlockDriverState *bs, int64_t offset, int64_t *pnum)
>  {

That's right, good catch. A few lines down there is the same problem in
bdrv_bsc_invalidate_range() and bdrv_bsc_fill(). Can you please fix all
of them at once in a v2 patch?

Kevin


