Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D4CFD8FF4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 19:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvh0x-0001HJ-LL; Thu, 26 Feb 2026 14:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvh0v-0001GH-Aw
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvh0t-0000cx-Pr
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772134026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//r4q/GNtoRK8A1QDy1k3nlQsH+0Z0HYZ+0+plNbQwg=;
 b=MARakf4qivRumKDgnnmM2UkpzBMZvPedql5DDfMQK66cv4joEPHi44t6i5hKgORwpAp04R
 uDUSe1LFxAuav+D7m9G1aiTdYuu0ZE9fKBDud6Q79ZLkH81Ac19nC3aZh7Kq9dpYOsGmEG
 iXRNqotLzr2ZyoX4LlY44Y2opLzfgm4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-kuw9CDOOM9KdrzhElBIvgQ-1; Thu,
 26 Feb 2026 14:27:03 -0500
X-MC-Unique: kuw9CDOOM9KdrzhElBIvgQ-1
X-Mimecast-MFC-AGG-ID: kuw9CDOOM9KdrzhElBIvgQ_1772134022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D827B1956095; Thu, 26 Feb 2026 19:27:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54E2030001B9; Thu, 26 Feb 2026 19:26:59 +0000 (UTC)
Date: Thu, 26 Feb 2026 20:26:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v4 16/24] fuse: Manually process requests (without libfuse)
Message-ID: <aaCegU1HXp17bM2A@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
 <20260218132633.29748-17-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218132633.29748-17-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

Am 18.02.2026 um 14:26 hat Hanna Czenczek geschrieben:
> Manually read requests from the /dev/fuse FD and process them, without
> using libfuse.  This allows us to safely add parallel request processing
> in coroutines later, without having to worry about libfuse internals.
> (Technically, we already have exactly that problem with
> read_from_fuse_export()/read_from_fuse_fd() nesting.)
> 
> We will continue to use libfuse for mounting the filesystem; fusermount3
> is a effectively a helper program of libfuse, so it should know best how
> to interact with it.  (Doing it manually without libfuse, while doable,
> is a bit of a pain, and it is not clear to me how stable the "protocol"
> actually is.)
> 
> Take this opportunity of quite a major rewrite to update the Copyright
> line with corrected information that has surfaced in the meantime.
> 
> Here are some benchmarks from before this patch (4k, iodepth=16, libaio;
> except 'sync', which are iodepth=1 and pvsync2):
> 
> file:
>   read:
>     seq aio:    99.8k ±1.5k IOPS
>     rand aio:   50.5k ±1.0k
>     seq sync:   36.1k ±1.1k
>     rand sync:  10.0k ±0.1k
>   write:
>     seq aio:    72.0k ±9.3k
>     rand aio:   70.6k ±2.5k
>     seq sync:   30.6k ±0.8k
>     rand sync:  30.1k ±1.0k
> null:
>   read:
>     seq aio:   157.9k ±4.7k
>     rand aio:  158.7k ±4.8k
>     seq sync:   80.2k ±2.8k
>     rand sync:  77.5k ±3.8k
>   write:
>     seq aio:   154.3k ±3.6k
>     rand aio:  154.3k ±4.2k
>     seq sync:   76.1k ±5.2k
>     rand sync:  72.9k ±4.0k
> 
> And with this patch applied:
> 
> file:
>   read:
>     seq aio:   106.8k ±1.9k (+7%)
>     rand aio:   48.3k ±8.8k (-4%)
>     seq sync:   35.5k ±1.4k (-2%)
>     rand sync:  10.0k ±0.2k (±0%)
>   write:
>     seq aio:    76.3k ±6.6k (+6%)
>     rand aio:   76.4k ±1.5k (+8%)
>     seq sync:   31.6k ±0.6k (+3%)
>     rand sync:  30.9k ±0.8k (+3%)
> null:
>   read:
>     seq aio:   161.7k ±6.0k (+2%)
>     rand aio:  165.6k ±7.1k (+4%)
>     seq sync:   80.5k ±3.0k (±0%)
>     rand sync:  78.5k ±3.1k (+1%)
>   write:
>     seq aio:   185.1k ±3.3k (+20%)
>     rand aio:  186.7k ±4.8k (+21%)
>     seq sync:   82.5k ±4.2k (+8%)
>     rand sync:  78.7k ±3.2k (+8%)
> 
> So not much difference, aside from write AIO to a null-co export getting
> a bit better.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 944 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 720 insertions(+), 224 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index af0a8de17b..c481fb72a2 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -1,7 +1,7 @@
>  /*
>   * Present a block device as a raw image through FUSE
>   *
> - * Copyright (c) 2020 Max Reitz <mreitz@redhat.com>
> + * Copyright (c) 2020, 2025 Hanna Czenczek <hreitz@redhat.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -27,12 +27,15 @@
>  #include "block/qapi.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-block.h"
> +#include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "system/block-backend.h"
>  
>  #include <fuse.h>
>  #include <fuse_lowlevel.h>
>  
> +#include "standard-headers/linux/fuse.h"
> +
>  #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
>  #include <linux/falloc.h>
>  #endif
> @@ -42,17 +45,102 @@
>  #endif
>  
>  /* Prevent overly long bounce buffer allocations */
> -#define FUSE_MAX_BOUNCE_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
> +#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
> +/* Small enough to fit in the request buffer */
> +#define FUSE_MAX_WRITE_BYTES (64 * 1024)

Is the comment stale now that you moved to two separate buffers?

>  /**
> - * Handle client reads from the exported image.
> + * Handle client reads from the exported image.  Allocates *bufptr and reads
> + * data from the block device into that buffer.
> + * Returns the buffer (read) size on success, and -errno on error.
> + * After use, *bufptr must be freed via qemu_vfree().
>   */
> -static void fuse_read(fuse_req_t req, fuse_ino_t inode,
> -                      size_t size, off_t offset, struct fuse_file_info *fi)
> +static ssize_t fuse_read(FuseExport *exp, void **bufptr,
> +                         uint64_t offset, uint32_t size)
>  {
> -    FuseExport *exp = fuse_req_userdata(req);
>      int64_t blk_len;
>      void *buf;
>      int ret;
>  
>      /* Limited by max_read, should not happen */
> -    if (size > FUSE_MAX_BOUNCE_BYTES) {
> -        fuse_reply_err(req, EINVAL);
> -        return;
> +    if (size > FUSE_MAX_READ_BYTES) {
> +        return -EINVAL;
>      }
>  
>      /**
> @@ -653,18 +954,12 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
>       */
>      blk_len = blk_getlength(exp->common.blk);
>      if (blk_len < 0) {
> -        fuse_reply_err(req, -blk_len);
> -        return;
> +        return blk_len;
>      }
>  
>      if (offset >= blk_len) {
> -        /*
> -         * Technically libfuse does not allow returning a zero error code for
> -         * read requests, but in practice this is a 0-length read (and a future
> -         * commit will change this code anyway)
> -         */
> -        fuse_reply_err(req, 0);
> -        return;
> +        *bufptr = NULL;
> +        return 0;

It feels a bit inconsistent to set *bufptr = NULL here, but not in the
error paths. Both cases depend on it being NULL afterwards, but the
caller already makes sure that it is NULL when it calls fuse_read().

>      }
>  
>      if (offset + size > blk_len) {

Overall, this feels much nicer than v3!

Kevin


