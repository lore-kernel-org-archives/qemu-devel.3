Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560DCD3B9B6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFy2o-0002ON-Co; Tue, 26 Nov 2024 11:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFy2e-0002De-0T; Tue, 26 Nov 2024 11:03:56 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFy2b-00072E-Pm; Tue, 26 Nov 2024 11:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=q7k6bRtacP0CjBJrFRFglTJccmkNYO6ZeYDRELeEm+A=; b=RWG2uQXxpu+0ys36Um86UGr8K1
 e/3AqMtg5moxVh3afIBtlxplri1s2C469M+vdiyLGbNuV/XJassPa8nrN7TPmHEfC4DYKub5uDyuP
 csySwm5Lrtk3zDtQFD/7OKV8ayH2euzaksl5U+KazO30zxVimXna6XnFkMmyKYpkA/nfMDjqXfVy3
 eTvEIgxIYissCoI7jstgxpL0s6cs+9pL1VFTyZG2q1LrM477EI4y9AZ2tdPjFzQdG1gOouMZZXJQ/
 X7axu+tshR1ZoCGmKT4GWuGvOQt69c1kwHPqj9MFqmvFLlihrTp0QQ82xDa6FWycTCf+6cehSoPuE
 G5DoeUZ0CUGjuLGag1ro8UqrtAUByIvkIW6tf66oIJvTSH/B5asyAVGoyJfo46jgiDMyLTXyicqMs
 RIf9QLIcNK4bKBpWotovOutKqzqBJYlo4cWmIdtxz+H+RVd9vu34ZkxaIXAXVI9VNk/zFtkfj4HMM
 ZQ+hG5uTVlsbEMmBV62rcnw8P5TC7tS2OLb/Gp0DWnYGmho2vgEFt/UXq8H+SmrVAk3oWKbN+PWdM
 BJZrOFgJ+oNpP9lsllQJ4mCjRSYusguu/yoBqoPe3mKGxrflule0SyrMpgpvKBNFvLPyE67BJnMsA
 9TdsS5xgn4Q5YHkndCNeubm+Dk3KmCZRhbhtonUG8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 5/6] 9pfs: fix 'Tgetattr' after unlink
Date: Tue, 26 Nov 2024 17:03:45 +0100
Message-ID: <5608682.ghPI0kNXTk@silver>
In-Reply-To: <4c41ad47f449a5cc8bfa9285743e029080d5f324.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <4c41ad47f449a5cc8bfa9285743e029080d5f324.1732465720.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sunday, November 24, 2024 4:50:03 PM CET Christian Schoenebeck wrote:
> With a valid file ID (FID) of an open file, it should be possible to send
> a 'Tgettattr' 9p request and successfully receive a 'Rgetattr' response,
> even if the file has been removed in the meantime. Currently this would
> fail with ENOENT.
> 
> I.e. this fixes the following misbehaviour with a 9p Linux client:
> 
>   open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
>   unlink("/home/tst/filename") = 0
>   fstat(3, 0x23aa1a8) = -1 ENOENT (No such file or directory)
> 
> Expected results:
> 
>   open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
>   unlink("/home/tst/filename") = 0
>   fstat(3, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
> 
> This is because 9p server is always using a path name based stat() call
> which fails as soon as the file got removed. So to fix this, use fstat()
> whenever we have an open file descriptor already.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/103
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 851e36b9a1..578517739a 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1596,7 +1596,13 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>          retval = -ENOENT;
>          goto out_nofid;
>      }
> -    retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> +    if ((fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
> +        (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream))
> +    {
> +        retval = v9fs_co_fstat(pdu, fidp, &stbuf);
> +    } else {
> +        retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> +    }

As for performance fstat() vs. lstat(): with glibc >= 2.39 and/or Linux
kernel >= 6.6, fstat() is Theta(1) whereas lstat() is O(log n). So fstat() is
faster than lstat() and hence prioritizing fstat() over lstat() does make
sense here IMO.

That's because on Linux kernel side fstat() is implemented by a simple
constant time linear array access via file descriptor number, whereas lstat()
needs to lookup the path and hence walk a tree.

There is a caveat though: Both on glibc and Linux kernel side there was a
performance bug each, which were both fixed in September 2023 by glibc 2.39
and Linux kernel 6.6 respectively:

kernel fix: https://github.com/torvalds/linux/commit/9013c51

glibc fix: https://github.com/bminor/glibc/commit/551101e

So on glibc side, due to a misconception, they inappropriately translated
fstat(fd, buf) -> fstatat(fd, "", buf, AT_EMPTY_PATH) for a long time, instead
of just calling fstat() directly as ought to be and done now.

And on kernel side, the negative performance impact of case AT_EMPTY_PATH +
empty string wasn't considered in fstatat() implementation. This case is now
short-circuited right at the beginning of the function.

/Christian



