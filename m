Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6253C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjqm-0002gZ-L1; Tue, 30 Jan 2024 03:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rUjqi-0002g8-Gk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rUjqg-0007Z0-Ch
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706604725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uprIKJrLwi9jpcqs3BHBjV+EYQ1Dkis/M6VaSH87zJY=;
 b=Jwvp0G41WryAlyYd3xL3GgjCQ7jGaWl2KG7pYqxaLxmfEOR2zBQJaQydCeNHabzatm1M/L
 a+4WjzxEEtl+4pW5H0e8yr2UN0vdpDfHce4c2wZewwbHc+Y4p5dU4SaOSH+Ezab5Qc/pkF
 9d8GSZVbZGmdqwiIJPBdTKQ2dHj4bWw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-z56bUC4FN86NyA68LCgvhw-1; Tue,
 30 Jan 2024 03:52:02 -0500
X-MC-Unique: z56bUC4FN86NyA68LCgvhw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B227738562D2;
 Tue, 30 Jan 2024 08:52:01 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7C39A2E;
 Tue, 30 Jan 2024 08:52:00 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:51:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 hreitz@redhat.com
Subject: Re: [PATCH [repost]] block/blkio: Don't assume size_t is 64 bit
Message-ID: <Zbi4r90M8K3o6EgZ@redhat.com>
References: <20240129185427.2952727-1-rjones@redhat.com>
 <20240129185427.2952727-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129185427.2952727-2-rjones@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 29.01.2024 um 19:53 hat Richard W.M. Jones geschrieben:
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

Why not simply make BDRVBlkioState.mem_region_alignment a uint64_t
instead of keeping it size_t and doing an additional conversion with
a check that requires an #if (probably to avoid a warning on 64 bit
hosts because the condition is never true)?

Kevin

>  block/blkio.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index 0a0a6c0f5fd..52d78935147 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -794,6 +794,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
>      const char *blkio_driver = bs->drv->protocol_name;
>      BDRVBlkioState *s = bs->opaque;
>      int ret;
> +    uint64_t val;
>  
>      ret = blkio_create(blkio_driver, &s->blkio);
>      if (ret < 0) {
> @@ -854,7 +855,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      ret = blkio_get_uint64(s->blkio,
>                             "mem-region-alignment",
> -                           &s->mem_region_alignment);
> +                           &val);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
>                           "failed to get mem-region-alignment: %s",
> @@ -862,6 +863,15 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
>          blkio_destroy(&s->blkio);
>          return ret;
>      }
> +#if HOST_LONG_BITS == 32
> +    if (val > SIZE_MAX) {
> +        error_setg_errno(errp, ERANGE,
> +                         "mem-region-alignment too large for size_t");
> +        blkio_destroy(&s->blkio);
> +        return -ERANGE;
> +    }
> +#endif
> +    s->mem_region_alignment = (size_t)val;
>  
>      ret = blkio_get_bool(s->blkio,
>                           "may-pin-mem-regions",
> -- 
> 2.43.0
> 


