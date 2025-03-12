Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E4BC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMfy-0005GZ-EU; Wed, 12 Mar 2025 10:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMfk-00057u-3U
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:03:04 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMfi-0008S5-A5
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=lxY5MQuil5N8r2rfgw3I/U6CjdHmTEbvtlbHT3+U43s=; b=vf1i2DSI6AaUSDd0nru3kaCJ0L
 vh9j/kxHkygrQYL1Fh1MxNqVf64h31UYlyDpMaGHG6TRZWw8Z6WcQU1kDZBk6UXfB2u2xEFVq8c+T
 H5NuAZsqEitYm2s6GJ9UiHdQYhaVBpMvXQ4KQxZiUM8lcR66WetQ/Zt+MtdOMX/tvaz/55Au0AFub
 AIe/yiJ/G+Ry/GlZmT9rLkgMKBydkU2Rrru7JTl/QBmzZhEM/HPTLGhMfmmvOFzmckIRkSfcsg+zW
 8l7V/AeJ6fjcKYOqhcWJ9q+5XowlNU9rzHIYjGa/fAZy04nTrC6yLUqSNZsqtuLUNopdsQFE7/Vem
 vQddBYb4UAr6Np+5VIinmELAC3/8Aew7kwKj1egY9ORz8koMD0+E4esJpE3TEja2r2Iee9oHMKn17
 6ks+n9Eh+8r3n7vB+DoFKFHR155/spyb3q26MjnMJfyYI1tSwdn5t7cEhKpJC+Q5QPHeD4c5Jud+p
 tV5ZjEKHh7WPNjfUkHf4SBAqaJkH2bFBmQwszb0ElEcvAsBVWYQfYAFmX8pRP9zHZToxMAJkbVVfJ
 x7icAkSALWZokeD/A33YCAJUhce7mgfNb9Kqt4LbB5vDF9+mxjkyHEn+CvL/PajDtFbnEpxcCB+Y0
 Cn3AtZBvn9UgIU03wbLmIAVGoeHoxpU+F6+q4VDmE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 2/6] 9pfs: Don't use file descriptors in core code
Date: Wed, 12 Mar 2025 15:02:51 +0100
Message-ID: <2371222.HHjt5ElpTA@silver>
In-Reply-To: <20250311172809.250913-3-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
 <20250311172809.250913-3-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.687, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tuesday, March 11, 2025 6:28:05 PM CET Greg Kurz wrote:
> v9fs_getattr() currently peeks into V9fsFidOpenState to know if a fid
> has a valid file descriptor or directory stream. Even though the fields
> are accessible, this is an implementation detail of the local backend
> that should not be manipulated directly by the server code.
> 
> Abstract that with a new has_valid_file_handle() backend operation.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> v2: - rename to has_valid_file_handle()
>     - don't reuse local_fid_fd()
> ---
>  fsdev/file-op-9p.h | 1 +
>  hw/9pfs/9p-local.c | 8 ++++++++
>  hw/9pfs/9p-synth.c | 6 ++++++
>  hw/9pfs/9p.c       | 9 ++++++---
>  4 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 4997677460e8..b815cea44e85 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -164,6 +164,7 @@ struct FileOperations {
>      int (*renameat)(FsContext *ctx, V9fsPath *olddir, const char *old_name,
>                      V9fsPath *newdir, const char *new_name);
>      int (*unlinkat)(FsContext *ctx, V9fsPath *dir, const char *name, int flags);
> +    bool (*has_valid_file_handle)(int fid_type, V9fsFidOpenState *fs);
>  };
>  
>  #endif
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 99b9560a528b..b16132299f2c 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1572,6 +1572,13 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
>      return 0;
>  }
>  
> +static bool local_has_valid_file_handle(int fid_type, V9fsFidOpenState *fs)
> +{
> +    return
> +        (fid_type == P9_FID_FILE && fs->fd != -1) ||
> +        (fid_type == P9_FID_DIR && fs->dir.stream != NULL);
> +}
> +
>  FileOperations local_ops = {
>      .parse_opts = local_parse_opts,
>      .init  = local_init,
> @@ -1609,4 +1616,5 @@ FileOperations local_ops = {
>      .name_to_path = local_name_to_path,
>      .renameat  = local_renameat,
>      .unlinkat = local_unlinkat,
> +    .has_valid_file_handle = local_has_valid_file_handle,
>  };
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 2abaf3a2918a..be0492b400e1 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -615,6 +615,11 @@ static int synth_init(FsContext *ctx, Error **errp)
>      return 0;
>  }
>  
> +static bool synth_has_valid_file_handle(int fid_type, V9fsFidOpenState *fs)
> +{
> +    return false;
> +}
> +
>  FileOperations synth_ops = {
>      .init         = synth_init,
>      .lstat        = synth_lstat,
> @@ -650,4 +655,5 @@ FileOperations synth_ops = {
>      .name_to_path = synth_name_to_path,
>      .renameat     = synth_renameat,
>      .unlinkat     = synth_unlinkat,
> +    .has_valid_file_handle = synth_has_valid_file_handle,
>  };
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 7cad2bce6209..10363f1a1df8 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1574,6 +1574,11 @@ out_nofid:
>      pdu_complete(pdu, err);
>  }
>  
> +static bool fid_has_valid_handle(V9fsState *s, V9fsFidState *fidp)
> +{
> +    return s->ops->has_valid_file_handle(fidp->fid_type, &fidp->fs);
> +}
> +

I would also rename that to fid_has_valid_file_handle(), but I can also do
this on my end.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  static void coroutine_fn v9fs_getattr(void *opaque)
>  {
>      int32_t fid;
> @@ -1596,9 +1601,7 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>          retval = -ENOENT;
>          goto out_nofid;
>      }
> -    if ((fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
> -        (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream))
> -    {
> +    if (fid_has_valid_handle(pdu->s, fidp)) {
>          retval = v9fs_co_fstat(pdu, fidp, &stbuf);
>      } else {
>          retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> 



