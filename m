Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A9FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 08:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJqV7-0001w0-7W; Wed, 19 Jun 2024 04:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sJqV6-0001vS-4d
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 04:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sJqV4-0002dA-69
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 04:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718785020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBQQUtp4GvWrOcNZ/4EPvOiPb3P4tzr3+IHoazeb+lM=;
 b=iw5nM1GnAGP5hWGVH0iWTYs98AHQUfqnZIhnDNTG1aLyJ0/MhQvoziWmGj8qknT28BAE9K
 O8IZ23c4D0e4Z76/lMhiabcgAN484oyEJVwFWZeEsWiHdSu/72Pz2p5vfjKdPrvBbSRrEb
 sPNDX6V+Cgwqwrv5utcAjzwAMl9sHhs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-PeGrnm2gNMWq-CXTRWfbuw-1; Wed,
 19 Jun 2024 04:16:53 -0400
X-MC-Unique: PeGrnm2gNMWq-CXTRWfbuw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C7CC195608C; Wed, 19 Jun 2024 08:16:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A661956048; Wed, 19 Jun 2024 08:16:50 +0000 (UTC)
Date: Wed, 19 Jun 2024 10:16:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block/file-posix: Consider discard flag when opening
Message-ID: <ZnKT8ECzHjpLGOm_@redhat.com>
References: <20240618212457.714456-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618212457.714456-1-nsoffer@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am 18.06.2024 um 23:24 hat Nir Soffer geschrieben:
> Set has_discard only when BDRV_O_UNMAP is not set. With this users that
> want to keep their images fully allocated can disable hole punching
> when writing zeros or discarding using:
> 
>    -drive file=thick.img,discard=off
> 
> This change is not entirely correct since it changes the default discard
> behavior.  Previously we always allowed punching holes, but now you have
> must use discard=unmap|on to enable it. We probably need to add the
> BDDR_O_UNMAP flag by default.
> 
> make check still works, so maybe we don't have tests for sparsifying
> images, or maybe you need to run special tests that do not run by
> default. We needs tests for keeping images non-sparse.
> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>

So first of all, I agree with you that this patch is wrong. ;-)

At first, I failed to understand the problem this is trying to solve. I
put a debug message in handle_aiocb_discard() and tried with which
options it triggers. [1] To me, this looked exactly like it should be.
We only try to discard blocks when discard=unmap is given as an option.

That leaves the case of write_zeroes. And while at the first sight, the
code looked good, we do seem to have a problem there and it tried to
unmap even with discard=off.

>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index be25e35ff6..acac2abadc 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -738,11 +738,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          ret = -EINVAL;
>          goto fail;
>      }
>  #endif /* !defined(CONFIG_LINUX_IO_URING) */
>  
> -    s->has_discard = true;
> +    s->has_discard = !!(bdrv_flags & BDRV_O_UNMAP);
>      s->has_write_zeroes = true;
>  
>      if (fstat(s->fd, &st) < 0) {
>          ret = -errno;
>          error_setg_errno(errp, errno, "Could not stat file");

s->has_discard is about what the host supports, not about the semantics
of the QEMU block node. So this doesn't feel right to me.

So for the buggy case, write_zeroes, bdrv_co_pwrite_zeroes() has code
that considers the case and clears the ~BDRV_REQ_MAY_UNMAP flags:

    if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
        flags &= ~BDRV_REQ_MAY_UNMAP;
    }

But it turns out that we don't necessarily even go through this function
for the top node which has discard=off, so it can't take effect:

(gdb) bt
#0  0x00007ffff4f2f144 in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007ffff4ed765e in raise () at /lib64/libc.so.6
#2  0x00007ffff4ebf902 in abort () at /lib64/libc.so.6
#3  0x000055555615aff0 in raw_do_pwrite_zeroes (bs=0x555557f4bcf0, offset=0, bytes=1048576, flags=BDRV_REQ_MAY_UNMAP, blkdev=false) at ../block/file-posix.c:3643
#4  0x000055555615557e in raw_co_pwrite_zeroes (bs=0x555557f4bcf0, offset=0, bytes=1048576, flags=BDRV_REQ_MAY_UNMAP) at ../block/file-posix.c:3655
#5  0x00005555560cde2a in bdrv_co_do_pwrite_zeroes (bs=0x555557f4bcf0, offset=0, bytes=1048576, flags=6) at ../block/io.c:1901
#6  0x00005555560c72f9 in bdrv_aligned_pwritev (child=0x555557f51460, req=0x7fffed5ff800, offset=0, bytes=1048576, align=1, qiov=0x0, qiov_offset=0, flags=6) at ../block/io.c:2100
#7  0x00005555560c6b41 in bdrv_co_do_zero_pwritev (child=0x555557f51460, offset=0, bytes=1048576, flags=6, req=0x7fffed5ff800) at ../block/io.c:2183
#8  0x00005555560c6647 in bdrv_co_pwritev_part (child=0x555557f51460, offset=0, bytes=1048576, qiov=0x0, qiov_offset=0, flags=6) at ../block/io.c:2283
#9  0x00005555560c634f in bdrv_co_pwritev (child=0x555557f51460, offset=0, bytes=1048576, qiov=0x0, flags=6) at ../block/io.c:2216
#10 0x00005555560c75b5 in bdrv_co_pwrite_zeroes (child=0x555557f51460, offset=0, bytes=1048576, flags=BDRV_REQ_MAY_UNMAP) at ../block/io.c:2322
#11 0x0000555556117d24 in raw_co_pwrite_zeroes (bs=0x555557f44980, offset=0, bytes=1048576, flags=BDRV_REQ_MAY_UNMAP) at ../block/raw-format.c:307
#12 0x00005555560cde2a in bdrv_co_do_pwrite_zeroes (bs=0x555557f44980, offset=0, bytes=1048576, flags=6) at ../block/io.c:1901
#13 0x00005555560c72f9 in bdrv_aligned_pwritev (child=0x555557f513f0, req=0x7fffed5ffd90, offset=0, bytes=1048576, align=1, qiov=0x0, qiov_offset=0, flags=6) at ../block/io.c:2100
#14 0x00005555560c6b41 in bdrv_co_do_zero_pwritev (child=0x555557f513f0, offset=0, bytes=1048576, flags=6, req=0x7fffed5ffd90) at ../block/io.c:2183
#15 0x00005555560c6647 in bdrv_co_pwritev_part (child=0x555557f513f0, offset=0, bytes=1048576, qiov=0x0, qiov_offset=0, flags=6) at ../block/io.c:2283
#16 0x00005555560ad741 in blk_co_do_pwritev_part (blk=0x555557f51660, offset=0, bytes=1048576, qiov=0x0, qiov_offset=0, flags=6) at ../block/block-backend.c:1425
#17 0x00005555560ad5f2 in blk_co_pwritev_part (blk=0x555557f51660, offset=0, bytes=1048576, qiov=0x0, qiov_offset=0, flags=6) at ../block/block-backend.c:1440
#18 0x00005555560ad8cf in blk_co_pwritev (blk=0x555557f51660, offset=0, bytes=1048576, qiov=0x0, flags=6) at ../block/block-backend.c:1462
#19 0x00005555560b0f79 in blk_co_pwrite_zeroes (blk=0x555557f51660, offset=0, bytes=1048576, flags=6) at ../block/block-backend.c:2590
#20 0x000055555606d240 in blk_co_pwrite_zeroes_entry (opaque=0x7fffffffbc18) at block/block-gen.c:2162
#21 0x00005555562c36ba in coroutine_trampoline (i0=1475685216, i1=21845) at ../util/coroutine-ucontext.c:175
#22 0x00007ffff4ef1190 in ??? () at /lib64/libc.so.6
#23 0x00007fffffffc010 in ??? ()
#24 0x0000000000000000 in ??? ()

I haven't checked the details yet, but my first impression is that this
check should probably move to bdrv_co_do_pwrite_zeroes().

Kevin


[1] Tests I did:

# For discard

$ echo -e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 -drive if=none,file=/tmp/test.raw,format=raw -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
(qemu) qemu-io none0 "discard 0 1M"
discard 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 00.00 sec (396.171 GiB/sec and 405679.5132 ops/sec)
(qemu) quit

$ echo -e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 -drive if=none,file=/tmp/test.raw,format=raw,discard=unmap -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
(qemu) qemu-io none0 "discard 0 1M"
handle_aiocb_discard
discard 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 00.00 sec (6.623 GiB/sec and 6782.2820 ops/sec)
(qemu) quit

$ echo -e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 -drive if=none,file=/tmp/test.raw,format=raw,discard=off -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
(qemu) qemu-io none0 "discard 0 1M"
discard 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 00.00 sec (375.168 GiB/sec and 384172.1091 ops/sec)
(qemu) quit

# For write_zeroes

$ echo -e 'qemu-io none0 "write -zu 0 1M"\nquit' | ./qemu-system-x86_64 -drive if=none,file=/tmp/test.raw,format=raw,discard=unmap -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
(qemu) qemu-io none0 "write -zu 0 1M"
handle_aiocb_write_zeroes_unmap
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 00.00 sec (4.943 GiB/sec and 5061.5997 ops/sec)
(qemu) quit
$ echo -e 'qemu-io none0 "write -zu 0 1M"\nquit' | ./qemu-system-x86_64 -drive if=none,file=/tmp/test.raw,format=raw,discard=off -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
(qemu) qemu-io none0 "write -zu 0 1M"
handle_aiocb_write_zeroes_unmap
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 00.00 sec (7.208 GiB/sec and 7381.4357 ops/sec)
(qemu) quit


