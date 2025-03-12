Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C809C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMk8-0001Vd-6k; Wed, 12 Mar 2025 10:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMk5-0001Pv-U4
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:07:30 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMk2-0000wO-IX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=JFaUfIH8B6I1EUYp4I4ePatGGx1T5CUez+vC0TaFP9U=; b=SvoXA71FeNnQTVD5s2HjjRiPYO
 S98LYyY70/f2y5Yv/93BrDOCE0qqWqpnxOSqqz0bHJcLLc3EJw0Omypivy5v/SqG4s8x24qwZy23p
 HVXam3pY6Ieg1dHDONos1Lr41bS5Y3poNM4K4J0KqsrOSS+UgovaDJbnAlpRazEc0onLncBYn3qUE
 u3D8B6jl0exz117d3nt2egzMWWeVCxxMTNauHQ5n4RZ4jcLDqAOR4Q6puHcldGHu2Cil+l3jjd4H/
 C0yLsWER2jZ8IpU8F0cOb4AyUhGHbYw5gYLeyAg1Q3CLkC3Q6EEo07b//UIavAmzxiTMqUVdY5pA7
 tR/Zzw62TXvU+PECmkWY4LbaFpVSsFvl4vsmbejL+Lq38AlBhAUWD2O13/2NH6zH9D06N1Ty2X62o
 XCDrB6LKiay+jOJnqCV4LVGM9v8cT3lKKr5A0Swx2+fyv4Tc964BUBFq/qbrNLX3nR8aeNreY4vsV
 zcc0Z8WHa7CnnFeJBAwEbcsmmNfbaKhbCxa9AFDUXYmtavxSLCM5+WhImwXfOEJoyX+urziPeu2ka
 lIiYqdxYfkc1wYk3m4ucu2tKWJFBfr4p/6TsstMVPvZ8TqBxWVw6AOvMXZ04B7jGTR/11u3wDmn+M
 bOAUtYsq8d0qvmWHoBTmMs85DRG6skN+FBdkJ8Xl4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 3/6] 9pfs: Introduce ftruncate file op
Date: Wed, 12 Mar 2025 15:07:20 +0100
Message-ID: <2348866.qVP5gfYQ7p@silver>
In-Reply-To: <20250311172809.250913-4-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
 <20250311172809.250913-4-groug@kaod.org>
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

On Tuesday, March 11, 2025 6:28:06 PM CET Greg Kurz wrote:
> Add an ftruncate operation to the fs driver and use if when a fid has
> a valid file descriptor. This is required to support more cases where
> the client wants to do an action on an unlinked file which it still
> has an open file decriptor for.
> 
> Only 9P2000.L was considered.
> 
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> v2: - moved v9fs_co_ftruncate() near v9fs_co_truncate() in coth.h
>     - similar change in file-op-9p.h
> ---
>  fsdev/file-op-9p.h |  2 ++
>  hw/9pfs/9p-local.c |  9 +++++++++
>  hw/9pfs/9p-synth.c |  8 ++++++++
>  hw/9pfs/9p.c       |  6 +++++-
>  hw/9pfs/cofs.c     | 18 ++++++++++++++++++
>  hw/9pfs/coth.h     |  2 ++
>  6 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index b815cea44e85..26ba1438c0ed 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -152,6 +152,8 @@ struct FileOperations {
>      int (*fstat)(FsContext *, int, V9fsFidOpenState *, struct stat *);
>      int (*rename)(FsContext *, const char *, const char *);
>      int (*truncate)(FsContext *, V9fsPath *, off_t);
> +    int (*ftruncate)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> +                     off_t size);
>      int (*fsync)(FsContext *, int, V9fsFidOpenState *, int);
>      int (*statfs)(FsContext *s, V9fsPath *path, struct statfs *stbuf);
>      ssize_t (*lgetxattr)(FsContext *, V9fsPath *,
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index b16132299f2c..0b33da8d2a46 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1042,6 +1042,14 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
>      return ret;
>  }
>  
> +static int local_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> +                           off_t size)
> +{
> +    int fd = local_fid_fd(fid_type, fs);
> +
> +    return ftruncate(fd, size);
> +}
> +
>  static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
>  {
>      char *dirpath = g_path_get_dirname(fs_path->data);
> @@ -1617,4 +1625,5 @@ FileOperations local_ops = {
>      .renameat  = local_renameat,
>      .unlinkat = local_unlinkat,
>      .has_valid_file_handle = local_has_valid_file_handle,
> +    .ftruncate = local_ftruncate,
>  };
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index be0492b400e1..3d28afc4d03d 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -356,6 +356,13 @@ static int synth_truncate(FsContext *ctx, V9fsPath *path, off_t offset)
>      return -1;
>  }
>  
> +static int synth_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> +                           off_t size)
> +{
> +    errno = ENOSYS;
> +    return -1;
> +}
> +
>  static int synth_chmod(FsContext *fs_ctx, V9fsPath *path, FsCred *credp)
>  {
>      errno = EPERM;
> @@ -656,4 +663,5 @@ FileOperations synth_ops = {
>      .renameat     = synth_renameat,
>      .unlinkat     = synth_unlinkat,
>      .has_valid_file_handle = synth_has_valid_file_handle,
> +    .ftruncate    = synth_ftruncate,
>  };
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 10363f1a1df8..4616bd763012 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1733,7 +1733,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
>          }
>      }
>      if (v9iattr.valid & (P9_ATTR_SIZE)) {
> -        err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
> +        if (fid_has_valid_handle(pdu->s, fidp)) {
> +            err = v9fs_co_ftruncate(pdu, fidp, v9iattr.size);
> +        } else {
> +            err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
> +        }

Like with previous patch, s/fid_has_valid_handle/fid_has_valid_file_handle/,
the rest is fine.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>          if (err < 0) {
>              goto out;
>          }
> diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
> index 67e3ae5c5ccd..893466fb1a44 100644
> --- a/hw/9pfs/cofs.c
> +++ b/hw/9pfs/cofs.c
> @@ -184,6 +184,24 @@ int coroutine_fn v9fs_co_truncate(V9fsPDU *pdu, V9fsPath *path, off_t size)
>      return err;
>  }
>  
> +int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp, off_t size)
> +{
> +    int err;
> +    V9fsState *s = pdu->s;
> +
> +    if (v9fs_request_cancelled(pdu)) {
> +        return -EINTR;
> +    }
> +    v9fs_co_run_in_worker(
> +        {
> +            err = s->ops->ftruncate(&s->ctx, fidp->fid_type, &fidp->fs, size);
> +            if (err < 0) {
> +                err = -errno;
> +            }
> +        });
> +    return err;
> +}
> +
>  int coroutine_fn v9fs_co_mknod(V9fsPDU *pdu, V9fsFidState *fidp,
>                                 V9fsString *name, uid_t uid, gid_t gid,
>                                 dev_t dev, mode_t mode, struct stat *stbuf)
> diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> index 2c54249b3577..62e922dc12e3 100644
> --- a/hw/9pfs/coth.h
> +++ b/hw/9pfs/coth.h
> @@ -73,6 +73,8 @@ int coroutine_fn v9fs_co_chmod(V9fsPDU *, V9fsPath *, mode_t);
>  int coroutine_fn v9fs_co_utimensat(V9fsPDU *, V9fsPath *, struct timespec [2]);
>  int coroutine_fn v9fs_co_chown(V9fsPDU *, V9fsPath *, uid_t, gid_t);
>  int coroutine_fn v9fs_co_truncate(V9fsPDU *, V9fsPath *, off_t);
> +int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp,
> +                                   off_t size);
>  int coroutine_fn v9fs_co_llistxattr(V9fsPDU *, V9fsPath *, void *, size_t);
>  int coroutine_fn v9fs_co_lgetxattr(V9fsPDU *, V9fsPath *,
>                                     V9fsString *, void *, size_t);
> 



