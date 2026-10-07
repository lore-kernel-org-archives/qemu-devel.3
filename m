Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BCDCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESeP-00031T-2h; Wed, 07 Oct 2026 10:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xESda-0002xK-9T
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xESdW-0000Tb-Cr
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791383329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HCEWJSHfNpiB/5oxGo3QrP4wiueX0ngHkgBNcrTfiEw=;
 b=Jf7oO6ak8XtIQLmrRjH1wBW+1pTkBAJoEX/PU7L3bKbRqbd0FXrtxbu0ksM8X2hshiyUps
 QUlFNM3z0F9hXw1N9JpJTOu2XbkNUfUDIRST8PoiBToNKNmu2osZp64abqS0QnRQWjWBq5
 5G7Rz2nfCFIgwUyMpCxkQKe7DMkizsc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-slJW1U16PJ2_IRpaL8__4A-1; Wed,
 7 Oct 2026 14:28:46 +0000
X-MC-Unique: slJW1U16PJ2_IRpaL8__4A-1
X-Mimecast-MFC-AGG-ID: slJW1U16PJ2_IRpaL8__4A_1791383325
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FF18197703B; Wed,  7 Oct 2026 14:28:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.219])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D6871956045; Wed,  7 Oct 2026 14:28:43 +0000 (UTC)
Date: Wed, 7 Oct 2026 16:28:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sanne Raymaekers <sraymaek@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, fam@euphon.net
Subject: Re: [PATCH 1/3] block/vmdk: align stream optimized data grains on
 512 byte chunks
Message-ID: <asZXGMSjDidiL-Yd@redhat.com>
References: <20261005133316.198087-1-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005133316.198087-1-sraymaek@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Am 05.10.2026 um 15:33 hat Sanne Raymaekers geschrieben:
> According to the spec: "Each marker and its associated block begin on a
> sector or 512‐byte boundary... There are five types of markers:
> compressed grain markers,..." [^1]
> 
> This means that instead of aligning grains on their typical size (64K),
> in stream optimized disks, grains should be aligned on 512 byte chunks.
> 
> [^1] Virtual Disk Format 5.0 Technical Note.
> 
> Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>

One small thing about the series as a whole first: It's conventional for
QEMU patch series (with more than one patch) to include a cover letter
(i.e. [PATCH 0/3]) that gives you the chance to explain the big picture
and what the series is about, and others to distinguish what is a reply
to the series as a whole as opposed to the first patch specifically. Not
a big deal, but you can just use git format-patch --cover-letter for v2
and edit the cover letter file before sending the series.

For this patch specifically, it shows a real problem in the VMDK code,
but I think the solution isn't quite right. What currently happens when
you write a compressed 64k cluster:

    1. get_cluster_offset() finds that the offset is unallocated and
       gets a new cluster_offset

    2. get_whole_cluster() is normally supposed to initialise those
       parts of a newly allocated cluster (with zeros or from the
       backing file) that won't be written to.

       Because we pass skip_start_bytes = skip_end_bytes = 0 for
       compressed clusters, zeros are written to the whole 64k starting
       from cluster_offset.

    3. vmdk_write_extent() writes the compressed data at cluster_offset,
       overwriting the zeros we just wrote in step 2. The data written
       here can be much smaller than 64k if it compresses well.

If this happen near the end of the image, the 64k write has a side
effect of leaving the image larger than intended.

Your patch replaces this with writing only 512 bytes of zeros in step 2,
however they are still immediately overwritten again by the real
compressed data. So it's not necessarily that the write has the wrong
size, but that it's completely unnecessary I/O - compressed writes
always cover the whole cluster, there is no rest that should get copied
from the backing file.

So I'm wondering if the better fix would be calling get_whole_cluster()
only if !extent->compressed in the first place, saving us the memory
allocation and the I/O that will be immediately overwritten again
anyway.

You could also argue that skip_end_bytes should be passed as n_bytes or
extent->cluster_sectors * BDRV_SECTOR_SIZE for compressed extents,
indicating that there is nothing to be copied, but even then skipping
get_whole_cluster() would save us a useless memory allocation.

>  block/vmdk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index cd8b4ec7c8..3cdca06fff 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1460,9 +1460,11 @@ get_whole_cluster(BlockDriverState *bs, VmdkExtent *extent,
>      int64_t cluster_bytes;
>      uint8_t *whole_grain;
>      bool copy_from_backing;
> +    BDRVVmdkState *s = bs->opaque;
>  
>      /* For COW, align request sector_num to cluster start */
> -    cluster_bytes = extent->cluster_sectors << BDRV_SECTOR_BITS;
> +    cluster_bytes = strcmp(s->create_type, "streamOptimized") == 0 ? SECTOR_SIZE
> +      : extent->cluster_sectors << BDRV_SECTOR_BITS;

Doing string comparisons for each request isn't great. I think
extent->compressed should have the same meaning.

>      offset = QEMU_ALIGN_DOWN(offset, cluster_bytes);
>      whole_grain = qemu_blockalign(bs, cluster_bytes);
>      copy_from_backing = bs->backing && !zeroed;

Kevin


