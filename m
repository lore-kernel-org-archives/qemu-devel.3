Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FBDC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzchw-0002Vf-4c; Tue, 01 Apr 2025 10:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzchu-0002Th-Cf
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzchs-0006Ll-Hz
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743518111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5I8CYBBp4kmYnbRJwXVKv4RgvvuZZfvVc1hOPLnGEc=;
 b=YmhyOX0Ib933fXwjglSu183yG/I+z4rOMoILC23gLzfQwuGEWbR4anaJuN+r6CTBSYpqNt
 PW0xdCqE+ZZ6xvYd3pM72cDt6zOwFJduU7BA8zeqD12lLop7S9POw6+pEzWtM5aVEyu9CA
 HtG1kXNh3uolPhAJSI0WcF31QJ57cbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-IjWcn4EHPpe8JMWYgBqqvQ-1; Tue,
 01 Apr 2025 10:35:08 -0400
X-MC-Unique: IjWcn4EHPpe8JMWYgBqqvQ-1
X-Mimecast-MFC-AGG-ID: IjWcn4EHPpe8JMWYgBqqvQ_1743518107
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFFCB1954B33; Tue,  1 Apr 2025 14:35:07 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3078B180176C; Tue,  1 Apr 2025 14:35:05 +0000 (UTC)
Date: Tue, 1 Apr 2025 09:35:03 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 11/15] fuse: Manually process requests (without libfuse)
Message-ID: <pvipn7y6bo63qthkluaxinsz6cnlp4ld5frdhjcuwla2sknq25@sxvxxkhsx4zv>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-10-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-10-hreitz@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 25, 2025 at 05:06:51PM +0100, Hanna Czenczek wrote:
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

> @@ -247,6 +268,14 @@ static int fuse_export_create(BlockExport *blk_exp,
>  
>      g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
>  
> +    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
> +    ret = fcntl(exp->fuse_fd, F_SETFL, O_NONBLOCK);

fctnl(F_SETFL) should be used in a read-modify-write pattern with
F_GETFL (otherwise, you are nuking any other flags that might have
been important).

See also block/file-posix.c:fcntl_setfl.  Maybe we should hoist that
into a common helper in util/osdep.c?

>  /**
> - * Handle client reads from the exported image.
> + * Handle client reads from the exported image.  Allocates *bufptr and reads
> + * data from the block device into that buffer.

Worth calling out tht *bufptr must be freed with qemu_vfree...

> + * Returns the buffer (read) size on success, and -errno on error.
>   */
> -static void fuse_read(fuse_req_t req, fuse_ino_t inode,
> -                      size_t size, off_t offset, struct fuse_file_info *fi)
> +static ssize_t fuse_read(FuseExport *exp, void **bufptr,
> +                         uint64_t offset, uint32_t size)
...
>  {
>      buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
>      if (!buf) {
> -        fuse_reply_err(req, ENOMEM);
> -        return;
> +        return -ENOMEM;
>      }
>  
>      ret = blk_pread(exp->common.blk, offset, size, buf, 0);
> -    if (ret >= 0) {
> -        fuse_reply_buf(req, buf, size);
> -    } else {
> -        fuse_reply_err(req, -ret);
> +    if (ret < 0) {
> +        qemu_vfree(buf);
> +        return ret;

...since internal cleanup recognizes that plain free() is wrong?

>  #ifdef CONFIG_FUSE_LSEEK
>  /**
>   * Let clients inquire allocation status.
> + * Return the number of bytes written to *out on success, and -errno on error.
>   */
> -static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
> -                       int whence, struct fuse_file_info *fi)
> +static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
> +                          uint64_t offset, uint32_t whence)
>  {
> -    FuseExport *exp = fuse_req_userdata(req);
> -
>      if (whence != SEEK_HOLE && whence != SEEK_DATA) {
> -        fuse_reply_err(req, EINVAL);
> -        return;
> +        return -EINVAL;

Unrelated to this patch, but any reason why we only SEEK_HOLE/DATA
(and not, say, SEEK_SET)?  Is it because we aren't really maintaining
the notion of a current offset?  I guess that works as long as the
caller is always using pread/pwrite (never bare read/write where
depending on our internal offset would matter).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


