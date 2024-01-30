Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3A7C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmrH-0003U4-Uz; Tue, 30 Jan 2024 07:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rUmrF-0003Tj-Vg
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:04:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rUmrD-0003B7-Vi
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706616290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrPbHroXc8LubIRJ4U88nP2GxbND/O/II1Xs4Dlkgds=;
 b=HxuUJz1AItD7oLuwWU2tDgNS7UAWY97R4AKjzNZ5xSJecBzn2khzCR8BYCfZKCUwNjK+kz
 Q0/vvbqydJ5//J7y1YcIWI2sgFsX5xa11qR5skoV7QTwChTqBImHK6cV4NKSGXTgiPDPmP
 CwQt1hsba9uOky3bVfb1xPleMIvPJpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-MZkS_jIxMfqfdYC1MIwRUg-1; Tue, 30 Jan 2024 07:04:49 -0500
X-MC-Unique: MZkS_jIxMfqfdYC1MIwRUg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1938868901;
 Tue, 30 Jan 2024 12:04:48 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E134A492BC6;
 Tue, 30 Jan 2024 12:04:47 +0000 (UTC)
Date: Tue, 30 Jan 2024 13:04:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 hreitz@redhat.com
Subject: Re: [PATCH [repost]] block/blkio: Don't assume size_t is 64 bit
Message-ID: <Zbjl3jQbF05QcQD5@redhat.com>
References: <20240129185427.2952727-1-rjones@redhat.com>
 <20240129185427.2952727-2-rjones@redhat.com>
 <Zbi4r90M8K3o6EgZ@redhat.com> <20240130103050.GJ7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130103050.GJ7636@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 30.01.2024 um 11:30 hat Richard W.M. Jones geschrieben:
> On Tue, Jan 30, 2024 at 09:51:59AM +0100, Kevin Wolf wrote:
> > Am 29.01.2024 um 19:53 hat Richard W.M. Jones geschrieben:
> > > With GCC 14 the code failed to compile on i686 (and was wrong for any
> > > version of GCC):
> > > 
> > > ../block/blkio.c: In function ‘blkio_file_open’:
> > > ../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
> > >   857 |                            &s->mem_region_alignment);
> > >       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
> > >       |                            |
> > >       |                            size_t * {aka unsigned int *}
> > > In file included from ../block/blkio.c:12:
> > > /usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
> > >    49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
> > >       |                                                         ~~~~~~~~~~^~~~~
> > > 
> > > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > 
> > Why not simply make BDRVBlkioState.mem_region_alignment a uint64_t
> > instead of keeping it size_t and doing an additional conversion with
> > a check that requires an #if (probably to avoid a warning on 64 bit
> > hosts because the condition is never true)?
> 
> The smaller change (attached) does work on i686, but this worries me a
> little (although it doesn't give any error or warning):
> 
>     if (((uintptr_t)host | size) % s->mem_region_alignment) {
>     error_setg(errp, "unaligned buf %p with size %zu", host, size);
>         return BMRR_FAIL;
>     }

I don't see the problem? The calculation will now be done in 64 bits
even on a 32 bit host, but that seems fine to me. Is there a trap I'm
missing?

Kevin

> From 500f3a81652dcefa79a4864c1f3fa6747c16952e Mon Sep 17 00:00:00 2001
> From: "Richard W.M. Jones" <rjones@redhat.com>
> Date: Mon, 29 Jan 2024 18:20:46 +0000
> Subject: [PATCH] block/blkio: Make s->mem_region_alignment be 64 bits
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> With GCC 14 the code failed to compile on i686 (and was wrong for any
> version of GCC):
> 
> ../block/blkio.c: In function ‘blkio_file_open’:
> ../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
>   857 |                            &s->mem_region_alignment);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
>       |                            |
>       |                            size_t * {aka unsigned int *}
> In file included from ../block/blkio.c:12:
> /usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
>    49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
>       |                                                         ~~~~~~~~~~^~~~~
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  block/blkio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index 0a0a6c0f5fd..bc2f21784c7 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -68,7 +68,7 @@ typedef struct {
>      CoQueue bounce_available;
>  
>      /* The value of the "mem-region-alignment" property */
> -    size_t mem_region_alignment;
> +    uint64_t mem_region_alignment;
>  
>      /* Can we skip adding/deleting blkio_mem_regions? */
>      bool needs_mem_regions;
> -- 
> 2.43.0
> 


