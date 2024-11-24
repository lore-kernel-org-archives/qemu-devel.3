Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300CE668BC
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 19:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFIWn-0005Wz-Iy; Sun, 24 Nov 2024 14:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIWl-0005Wm-8g; Sun, 24 Nov 2024 14:44:15 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIWj-00054t-QW; Sun, 24 Nov 2024 14:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=DkbeZl2bmuqE7np+iMZQiLJwBbgGSb137lt+Mc8mYkE=; b=kCBsHWuBee7kUDq2W8j26la7QW
 INbCzW2e7eUUSlO0n7nzgTs3jfpupm35e2Vs8IdQFClc89FD2HguMdf7Ghoa2Vwjx0IqcZlnLBKeH
 qnFgc97ydriaFSgwrRN/nuJfVXAEuXvBqZnXtQN4h6n5n834JldA85ljzqXl+TddUTCptB4y2kEc3
 KtOpZRoGnLO4EjjMroz2mLgDdOdsgEouRseiTIkGFiBvDjM3AIeQFVPxr7OhC+XsyI4pgD6NbgQzq
 y7bR/2cW4/4/WIokTeBorFDCThLdNXGzj9XrPmrKSbeAmIe1x61gV5IG6fASmUAV5iVmMpTjcub+5
 rIsR1YTHNBJ8e9zMfMbNVbcNkrjYOoiXIFkgA+Zzr8GOsrvkqLSiUT/DogZXYi2VDIwJ3+ctQES1t
 yPkJOhuollyulA8f7+HVj6l12NG11o6l95k19KT4PxtyhF4IHQkUTjOkjtA7YfJwzClow+3cSKJEL
 KNGPojtSLsjOh4EwuicIX7M35aWrC+aSFqTRqv/A6DPHp+Js6HFU4SYXTJgt4L0OQEjWXhSzmzfod
 ZPyG9HqNYDp/jiQD5QwIx8fPS/wE2eepPfuepcdUz1PvnMugZyrwyGmyiocv9f+x5OjfsnC8d5nDX
 sQz80w0dEo5rU/fPLfvTOSnh501gThSnJpGLYb8u4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 5/6] 9pfs: fix 'Tgetattr' after unlink
Date: Sun, 24 Nov 2024 20:44:10 +0100
Message-ID: <17679791.WBpjI8S3sA@silver>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Fixes: 00ede4c2529b ('virtio-9p: getattr server implementation...')

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
>      if (retval < 0) {
>          goto out;
>      }
> 




