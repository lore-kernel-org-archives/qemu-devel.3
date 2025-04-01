Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAA8C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 20:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tziBg-0000rW-Dj; Tue, 01 Apr 2025 16:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tziAb-0000m0-KG
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 16:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tziAV-0001fj-Mp
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 16:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743539107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ho1FBETEWWPMRHNp6hxtfXjBrcBi9PTFayifvyycm/M=;
 b=W68UTrXW0+KMmqyGUJr57YKl7gGaTjZlJVjK0hhtXimweas1C7F4xOW+xXLQnnxc+q2a2p
 cqAUFwkcz7wxlHfhzWgZB9CftdlypBRzwOT5p8nrtpwFiksFUiC8qK5GWq0aoQMjct3iaK
 Bf0+sUbL7apbuSphhlNUXe4djG+NS90=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-sJuYgN_NOYOyA_bzTEWPwg-1; Tue,
 01 Apr 2025 16:25:03 -0400
X-MC-Unique: sJuYgN_NOYOyA_bzTEWPwg-1
X-Mimecast-MFC-AGG-ID: sJuYgN_NOYOyA_bzTEWPwg_1743539102
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7D811800266; Tue,  1 Apr 2025 20:25:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFEC93001D0E; Tue,  1 Apr 2025 20:24:59 +0000 (UTC)
Date: Tue, 1 Apr 2025 15:24:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 15/15] fuse: Increase MAX_WRITE_SIZE with a second buffer
Message-ID: <w3zwzqyhnkkoayjsfj3ozfmipsynwdevl5my4ra4g7gxqlbeni@lesuztmxb5bc>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-14-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-14-hreitz@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 25, 2025 at 05:06:55PM +0100, Hanna Czenczek wrote:
> We probably want to support larger write sizes than just 4k; 64k seems
> nice.  However, we cannot read partial requests from the FUSE FD, we
> always have to read requests in full; so our read buffer must be large
> enough to accommodate potential 64k writes if we want to support that.
> 
> Always allocating FuseRequest objects with 64k buffers in them seems
> wasteful, though.  But we can get around the issue by splitting the
> buffer into two and using readv(): One part will hold all normal (up to
> 4k) write requests and all other requests, and a second part (the
> "spill-over buffer") will be used only for larger write requests.  Each
> FuseQueue has its own spill-over buffer, and only if we find it used
> when reading a request will we move its ownership into the FuseRequest
> object and allocate a new spill-over buffer for the queue.
> 
> This way, we get to support "large" write sizes without having to
> allocate big buffers when they aren't used.
> 
> Also, this even reduces the size of the FuseRequest objects because the
> read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
> the requests we support are not quite so large (except for >4k writes),
> so until now, we basically had to have useless padding in there.
> 
> With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
> is easily met and we can decrease the size of the buffer portion that is
> right inside of FuseRequest.
> 
> As for benchmarks, the benefit of this patch can be shown easily by
> writing a 4G image (with qemu-img convert) to a FUSE export:
> - Before this patch: Takes 25.6 s (14.4 s with -t none)
> - After this patch: Takes 4.5 s (5.5 s with -t none)

Hmm - 64k is still small for some tasks; with qcow2, you can have
clusters up to 2M, and writing a cluster at a time seems to be a
reasonable desire.  Or in other storage areas, nbdcopy (from libnbd)
defaults to 256k and allows up to 32M, or we can even look at lvm that
defaults to extent size of 4M (although with lvm thin volumes,
behavior is more like qcow2 with subclusters in that you don't have to
allocate the entire extent at once).

Maybe it makes sense to have this as a hierarchichal spillover (first
level spills over to 64k, second level spills over to 2M or whatever
ACTUAL maximum you are willing to support)?

Or you can feel free to ignore my comments on this patch - allowing
64k instead of 4k is ALREADY a nice change.

> @@ -501,7 +547,20 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
>          goto no_request;
>      }
>  
> -    ret = RETRY_ON_EINTR(read(fuse_fd, q->request_buf, sizeof(q->request_buf)));
> +    /*
> +     * If handling the last request consumed the spill-over buffer, allocate a
> +     * new one.  Align it to the block device's alignment, which admittedly is
> +     * only useful if FUSE_IN_PLACE_WRITE_BYTES is aligned, too.

What are typical block device minimum alignments?  If 4k is typical,
then it should be easy to make FUSE_IN_PLACE_WRITE_BYTES be 4k.  If
64k is typical, we're already doomed at being aligned.  Is being
unaligned going to cause the block layer to add bounce buffers on us,
if the block layer has a larger alignment than what we use here?

> @@ -915,17 +983,25 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
>  }
>  
>  /**
> - * Handle client writes to the exported image.  @buf has the data to be written
> - * and will be copied to a bounce buffer before yielding for the first time.
> + * Handle client writes to the exported image.  @in_place_buf has the first
> + * FUSE_IN_PLACE_WRITE_BYTES bytes of the data to be written, @spillover_buf
> + * contains the rest (if any; NULL otherwise).
> + * Data in @in_place_buf is assumed to be overwritten after yielding, so will
> + * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
> + * assumed to be exclusively owned and will be used as-is.

Makes sense, although it leads to some interesting bookkeeping.  (I'm
wondering if nbd would benefit from this split-level buffering, since
it supports reads and writes up to 32M)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


