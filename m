Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD07CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Iv7-0005nx-PU; Mon, 13 Oct 2025 09:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8Iv5-0005nj-9U
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8Iv1-0007sX-Ds
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760363331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZZOdIj0WJbhPf+HRKNJRI8o+WG+4YP5VrWoH0VPpP0g=;
 b=PU9s9k5qxpSkPZtJNVyu73x/gv5VlMsQ/AzYB59y0Ysn7x1Y2oy6k4wHw1BqT10bOLGzUk
 H8vppg0A1agnBhUNBQKT9XhePE5mQ/tMXCeVR4+Zu/OqYFsBlq4S1J9xbZlsGZQZ8HV/Uz
 96crB+kIBpxLRvT2fdyJ7L3PWG9CyL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-EKXPoH-zNNKNmLXWQstP3Q-1; Mon,
 13 Oct 2025 09:48:50 -0400
X-MC-Unique: EKXPoH-zNNKNmLXWQstP3Q-1
X-Mimecast-MFC-AGG-ID: EKXPoH-zNNKNmLXWQstP3Q_1760363329
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 685DC18004D4; Mon, 13 Oct 2025 13:48:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 519881954102; Mon, 13 Oct 2025 13:48:47 +0000 (UTC)
Date: Mon, 13 Oct 2025 15:48:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 01/21] fuse: Copy write buffer content before polling
Message-ID: <aO0DPXT9ltavNN-Q@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
> aio_poll() in I/O functions can lead to nested read_from_fuse_export()
> calls, overwriting the request buffer's content.  The only function
> affected by this is fuse_write(), which therefore must use a bounce
> buffer or corruption may occur.
> 
> Note that in addition we do not know whether libfuse-internal structures
> can cope with this nesting, and even if we did, we probably cannot rely
> on it in the future.  This is the main reason why we want to remove
> libfuse from the I/O path.
> 
> I do not have a good reproducer for this other than:
> 
> $ dd if=/dev/urandom of=image bs=1M count=4096
> $ dd if=/dev/zero of=copy bs=1M count=4096
> $ touch fuse-export
> $ qemu-storage-daemon \
>     --blockdev file,node-name=file,filename=copy \
>     --export \
>     fuse,id=exp,node-name=file,mountpoint=fuse-export,writable=true \
>     &
> 
> Other shell:
> $ qemu-img convert -p -n -f raw -O raw -t none image fuse-export
> $ killall -SIGINT qemu-storage-daemon
> $ qemu-img compare image copy
> Content mismatch at offset 0!
> 
> (The -t none in qemu-img convert is important.)
> 
> I tried reproducing this with throttle and small aio_write requests from
> another qemu-io instance, but for some reason all requests are perfectly
> serialized then.
> 
> I think in theory we should get parallel writes only if we set
> fi->parallel_direct_writes in fuse_open().  In fact, I can confirm that
> if we do that, that throttle-based reproducer works (i.e. does get
> parallel (nested) write requests).  I have no idea why we still get
> parallel requests with qemu-img convert anyway.
> 
> Also, a later patch in this series will set fi->parallel_direct_writes
> and note that it makes basically no difference when running fio on the
> current libfuse-based version of our code.  It does make a difference
> without libfuse.  So something quite fishy is going on.
> 
> I will try to investigate further what the root cause is, but I think
> for now let's assume that calling blk_pwrite() can invalidate the buffer
> contents through nested polling.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 465cc9891d..b967e88d2b 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -301,6 +301,12 @@ static void read_from_fuse_export(void *opaque)
>          goto out;
>      }
>  
> +    /*
> +     * Note that aio_poll() in any request-processing function can lead to a
> +     * nested read_from_fuse_export() call, which will overwrite the contents of
> +     * exp->fuse_buf.  Anything that takes a buffer needs to take care that the
> +     * content is copied before potentially polling via aio_poll().
> +     */
>      fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);

Arguably, the better fix might be to just use a different buffer while
the previous one is still in use. But this specific code doesn't survive
until the end of the series anyway (though the bounce buffer for writes
does, unfortunately).

>  out:
> @@ -624,6 +630,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>                         size_t size, off_t offset, struct fuse_file_info *fi)
>  {
>      FuseExport *exp = fuse_req_userdata(req);
> +    void *copied;
>      int64_t length;
>      int ret;

The patch could be even simpler with QEMU_AUTO_VFREE here.

Either way:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>


