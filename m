Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697D0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAoN-0005ou-6E; Wed, 31 Jul 2024 11:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZAoK-0005nq-JZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZAoD-0000cG-1k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722438007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5UQANs8DPXnGU/DEvo+pFarUfp6jcExKXPzs7NcN1M4=;
 b=YF1TYRWXOPsSc4O5r28Ie1Bcgtabu4H8TSnISxEbWfSY+NHFuMfQxBXIuYNCD+KqdAPziM
 9z16VcUjUCAGI5FcU1+JCd/fa7uRL17DlP4I3uXhGfq3SaSiPEYoJZKnIQIPuYHjCMUd8B
 mgofqCgXHLpZaWbVY+Dz4lygrXYBgvM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-vKOAmP_HNYi1zlbbDmZVAA-1; Wed,
 31 Jul 2024 10:59:54 -0400
X-MC-Unique: vKOAmP_HNYi1zlbbDmZVAA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E3101955BEE; Wed, 31 Jul 2024 14:59:53 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.1])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FFED1955D42; Wed, 31 Jul 2024 14:59:50 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:59:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/7] block/vdi.c: Avoid potential overflow when
 calculating size of write
Message-ID: <ZqpRZBezv0VA-fuu@redhat.com>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143617.3391947-2-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 31.07.2024 um 16:36 hat Peter Maydell geschrieben:
> In vdi_co_pwritev() we multiply a sector count by SECTOR_SIZE to
> get the size to write in bytes. Coverity notes that this means that
> we do the multiply as a 32x32->32 multiply before converting to
> 64 bits, which has the potential to overflow.
> 
> This is very unlikely to happen, since the block map has 4 bytes per
> block and the maximum number of blocks in the image must fit into a
> 32-bit integer.  But we can keep Coverity happy by including a cast
> so we do a 64-bit multiply here.
> 
> Resolves: Coverity CID 1508076
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  block/vdi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/vdi.c b/block/vdi.c
> index 6363da08cee..27c60ba18d0 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -728,7 +728,7 @@ nonallocating_write:
>          logout("will write %u block map sectors starting from entry %u\n",
>                 n_sectors, bmap_first);
>          ret = bdrv_co_pwrite(bs->file, bmap_offset * SECTOR_SIZE,
> -                             n_sectors * SECTOR_SIZE, base, 0);
> +                             n_sectors * (uint64_t)SECTOR_SIZE, base, 0);
>      }

I wonder if we shouldn't just make VDI's SECTOR_SIZE 64 bits like
BDRV_SECTOR_SIZE. It's easy to miss the cast in individual places.

Kevin


