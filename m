Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE30CC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbvE-0001Va-Ha; Tue, 01 Apr 2025 09:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzbua-0000ma-Fx
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzbuY-0006mu-2V
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743515053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uStuQa0FmcOdgtFM3GEHpttxtdUK9V+iHWCzAJHKHqs=;
 b=Fvo0IHEgrsiZEUyuquTMluFpn0SnLvBZyNNT1OVGKb8cojB7pDqreLbgTDtajHEMSvu5FV
 NNSNOsDUVP0QaPGmO7SnvD2Lt2SJS3a6I6lXmzZLaKK+VJVB6xoESDfZ6OUzRy9DS1NxET
 /IkNkKHqthicFQzVZhiNAZZvZDUQfVk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-_SunuaUHNPODiTz4FT48fg-1; Tue,
 01 Apr 2025 09:44:10 -0400
X-MC-Unique: _SunuaUHNPODiTz4FT48fg-1
X-Mimecast-MFC-AGG-ID: _SunuaUHNPODiTz4FT48fg_1743515049
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A9F71809CA3; Tue,  1 Apr 2025 13:44:09 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 951191955D81; Tue,  1 Apr 2025 13:44:06 +0000 (UTC)
Date: Tue, 1 Apr 2025 08:44:03 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH 01/15] fuse: Copy write buffer content before polling
Message-ID: <re2wbm3hv4tqymmyan2rovwvxvfayh4rkyzn6ckjuoqlysmyjb@iscof2qe4fvg>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160635.118812-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325160635.118812-1-hreitz@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Tue, Mar 25, 2025 at 05:06:35PM +0100, Hanna Czenczek wrote:
> Polling in I/O functions can lead to nested read_from_fuse_export()
> calls, overwriting the request buffer's content.  The only function
> affected by this is fuse_write(), which therefore must use a bounce
> buffer or corruption may occur.
> 
> Note that in addition we do not know whether libfuse-internal structures
> can cope with this nesting, and even if we did, we probably cannot rely
> on it in the future.  This is the main reason why we want to remove
> libfuse from the I/O path.
> 

> @@ -624,6 +630,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>                         size_t size, off_t offset, struct fuse_file_info *fi)
>  {
>      FuseExport *exp = fuse_req_userdata(req);
> +    void *copied;

Do we have a good way to annotate variables that require qemu_vfree()
if non-NULL for automatic cleanup?  If so, should this be annotated
and set to NULL here,...

>      int64_t length;
>      int ret;
>  
> @@ -638,6 +645,14 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>          return;
>      }
>  
> +    /*
> +     * Heed the note on read_from_fuse_export(): If we poll (which any blk_*()
> +     * I/O function may do), read_from_fuse_export() may be nested, overwriting
> +     * the request buffer content.  Therefore, we must copy it here.
> +     */
> +    copied = blk_blockalign(exp->common.blk, size);
> +    memcpy(copied, buf, size);
> +
>      /**
>       * Clients will expect short writes at EOF, so we have to limit
>       * offset+size to the image length.
> @@ -645,7 +660,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>      length = blk_getlength(exp->common.blk);
>      if (length < 0) {
>          fuse_reply_err(req, -length);
> -        return;
> +        goto free_buffer;

...so that this and similar hunks are not needed?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


