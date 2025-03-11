Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AFBC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxXy-0003Zv-MI; Tue, 11 Mar 2025 07:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxXv-0003Y1-NN
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:13:16 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxXq-00029n-DN
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=aq9FhKYkU2fCBnWgWdTHoBBQOoeJMfhB04bLD6w78jw=; b=lGMNqeg+KZ+D9vxXfrE3uwn6R2
 KjF+wP9H39lEF/xg586jKoYDSzHplO4MhF+bwu05ndUjJaIy6vTHwRG+74j7oWEy0snmon/Y5NZ6A
 UelegVsSm5Uk2M6/wxJIb98j/At8Z601aKWb8xIXNLFL/A8NQ2c9Qt9NkOnqjpXGJg4Lv9M0GjL1J
 eDB6UGMwO9xf6K+rPpz/68LOx/0qT1vxC1cntYtBOp/rNMmOG1Xq17d45nMsnvP+iT6fGKJqy3v1j
 yUfQFw3m5PJQWdi4K0moJ9o4X0qdhrbl8FobQgsXHwob5H8XaeBCYlxfdisehY7Szs/6ucibeY88U
 6W5h60KpKmcdo43mpCPLoh/suYdj0UGTvwDmcl++8mxCZ4aw4D1MX8ikGO+9bJqFS+dZKN6e/8Uhf
 m4fx0GLGb2s94jVIRY9FoWCdOi2LmaicQiVP/g84xZ5u0i5UHXvxC2EKO4rk64GH8qgmmwj736WDD
 gY+ZjZt0FUw6Gf9SI2j0XjGlkkVDYz13CqpvjRjUX10SC9aw1tyERAXLmIfoi2infOeS9yvDYV4ko
 W3xo1WBmagZ6Ec2r00LeSG87458USA7f6z8JEyano4uDGo4qI9udrpjmQpx/GBnkrPobz7thjecc2
 fMGMtajpi7l6brXPW/F10P0Oat5XUlMbeDwbOyKzA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/4] 9pfs: Don't use file descriptors in core code
Date: Tue, 11 Mar 2025 12:13:06 +0100
Message-ID: <5513162.Wvc2JcUQ7O@silver>
In-Reply-To: <20250310171101.138380-3-groug@kaod.org>
References: <20250310171101.138380-1-groug@kaod.org>
 <20250310171101.138380-3-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.47, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Monday, March 10, 2025 6:10:59 PM CET Greg Kurz wrote:
> v9fs_getattr() currently peeks into V9fsFidOpenState to know if a fid
> has a valid file descriptor or directory stream. Even though the fields
> are accessible, this is an implementation detail of the local backend
> that should not be manipulated directly by the server code.
> 
> Abstract that with a new has_valid_handle() backend operation.
> 
> Make the existing local_fid_fd() helper more robust so that it
> can cope with P9_FID_NONE or a null directory stream and reuse
> it.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  fsdev/file-op-9p.h |  1 +
>  hw/9pfs/9p-local.c | 12 +++++++++---
>  hw/9pfs/9p-synth.c |  6 ++++++
>  hw/9pfs/9p.c       |  9 ++++++---
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 4997677460e8..39fee185f4ce 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -164,6 +164,7 @@ struct FileOperations {
>      int (*renameat)(FsContext *ctx, V9fsPath *olddir, const char *old_name,
>                      V9fsPath *newdir, const char *new_name);
>      int (*unlinkat)(FsContext *ctx, V9fsPath *dir, const char *name, int flags);
> +    bool (*has_valid_handle)(int fid_type, V9fsFidOpenState *fs);
>  };
>  
>  #endif
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index c4366c867988..03e5304ef888 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -768,11 +768,11 @@ out:
>  
>  static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
>  {
> -    int fd;
> +    int fd = -1;
>  
> -    if (fid_type == P9_FID_DIR) {
> +    if (fid_type == P9_FID_DIR && fs->dir.stream != NULL) {
>          fd = dirfd(fs->dir.stream);
> -    } else {
> +    } else if (fid_type == P9_FID_FILE) {
>          fd = fs->fd;
>      }

Follow-up on previous patch, this could be reduced to:

static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
{
    if (fid_type == P9_FID_DIR && fs->dir.stream != NULL) {
        return dirfd(fs->dir.stream);
    } else if (fid_type == P9_FID_FILE) {
        return fs->fd;
    }
    return -1; /* POSIX invalid file handle */
}

or even:

static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
{
    return (fid_type == P9_FID_DIR && fs->dir.stream != NULL) ?
               dirfd(fs->dir.stream) :
                   (fid_type == P9_FID_FILE) ? fs->fd :
                       -1; /* POSIX invalid file handle */
}

>  
> @@ -1576,6 +1576,11 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
>      return 0;
>  }
>  
> +static bool local_has_valid_handle(int fid_type, V9fsFidOpenState *fs)
> +{
> +    return local_fid_fd(fid_type, fs) != -1;
> +}

I would avoid the implied dirfd() call here. It's usually just a libc function
on user side, so usually no context switch, but who knows if that applies to
all systems. So adapted to existing code this would be:

static bool local_has_valid_handle(int fid_type, V9fsFidOpenState *fs)
{
    return (fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
           (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream != NULL);
}

>  FileOperations local_ops = {
>      .parse_opts = local_parse_opts,
>      .init  = local_init,
> @@ -1613,4 +1618,5 @@ FileOperations local_ops = {
>      .name_to_path = local_name_to_path,
>      .renameat  = local_renameat,
>      .unlinkat = local_unlinkat,
> +    .has_valid_handle = local_has_valid_handle,
>  };
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 2abaf3a2918a..fa0b187a1b80 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -615,6 +615,11 @@ static int synth_init(FsContext *ctx, Error **errp)
>      return 0;
>  }
>  
> +static bool synth_has_valid_handle(int fid_type, V9fsFidOpenState *fs)
> +{
> +    return false;
> +}
> +

I was worried that this would cause the synth tests to fail, but apparently it
does not break them. So fine.

>  FileOperations synth_ops = {
>      .init         = synth_init,
>      .lstat        = synth_lstat,
> @@ -650,4 +655,5 @@ FileOperations synth_ops = {
>      .name_to_path = synth_name_to_path,
>      .renameat     = synth_renameat,
>      .unlinkat     = synth_unlinkat,
> +    .has_valid_handle = synth_has_valid_handle,

Mabye rather has_valid_file_handle?

>  };
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 7cad2bce6209..969fb2f8c494 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1574,6 +1574,11 @@ out_nofid:
>      pdu_complete(pdu, err);
>  }
>  
> +static bool fid_has_valid_handle(V9fsState *s, V9fsFidState *fidp)
> +{
> +    return s->ops->has_valid_handle(fidp->fid_type, &fidp->fs);
> +}
> +
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



