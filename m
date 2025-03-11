Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270E5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxk1-0000aq-8W; Tue, 11 Mar 2025 07:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxjy-0000aV-81
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:25:42 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxjr-0004ya-LM
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=+6Hs0jX012LzGMG0nwF2ftziDxnkubticlgkJM7A54k=; b=bY79mDRB7Q+p/uAdMHVzRaFxNG
 O/oi66E/Eofzm5gAVkG9XpTj6/x4z7MbNMAurSpW7CzP53tpqIMsHI5r8ZllJZFMBgrA/RTUKn1tv
 cgXifrjiGWyJUy50ya6+DXJA//0OvdTh0v3HznU+CnEW0htlGTXbI7XZb7S+uwGkj/UqYSaYGgYVn
 2b0v5/XiVvqJNKKRjqotZLgOZBbj2Ffxc9n6P9PkMkQTqTOLTLX1Hc9+sAXi3pMM/xUY8WW6r2rEc
 L3/JXJg2vyyUuuay2NPXuQKu7lIIIQMW5BU6owinp/XdPqXdDQf6xhCwoKqu5MMiKRj/cbO0qzuJh
 dvb615U7oS98JmhKsxRU+fwl9HVCBi4mArlVlYPlrtuIKwGxFC8gBe/dvaJsS69kwXi5AZslVE+Mb
 nteU9yjBN6qHlVuhkckySKi0+8U1Oa74cXH1ZeQU+QOntnfq6mtIeMfyLhhVdjbDsE6auBngmtjYb
 yqfCJ9C/p9zFx+94vRcs8N/beKOMSMMrfpBUErZ1hmr+U3L0QaNCYaUP7oXQg8kHxYJGAQzOFs3+l
 1/kAsf9GpSM4b135dgKe4g/XK+F/CXOaJMAzGJoDAOZBSZOsmWnuf9+NI2qASvAyTvASlYxNYdsXg
 B1uxeqsKyHAD7ABfk4uFmDb4SDigAygm6VpYK3GXA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/4] 9pfs: Introduce futimens file op
Date: Tue, 11 Mar 2025 12:25:32 +0100
Message-ID: <2866105.kX3A4kTrED@silver>
In-Reply-To: <20250310171101.138380-5-groug@kaod.org>
References: <20250310171101.138380-1-groug@kaod.org>
 <20250310171101.138380-5-groug@kaod.org>
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

On Monday, March 10, 2025 6:11:01 PM CET Greg Kurz wrote:
> Add an futimens operation to the fs driver and use if when a fid has
> a valid file descriptor. This is required to support more cases where
> the client wants to do an action on an unlinked file which it still
> has an open file decriptor for.
> 
> Only 9P2000.L was considered.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  fsdev/file-op-9p.h |  2 ++
>  hw/9pfs/9p-local.c |  9 +++++++++
>  hw/9pfs/9p-synth.c |  8 ++++++++
>  hw/9pfs/9p-util.h  |  1 +
>  hw/9pfs/9p.c       |  6 +++++-
>  hw/9pfs/cofs.c     | 19 +++++++++++++++++++
>  hw/9pfs/coth.h     |  2 ++
>  7 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 40a40f7d8af8..ee65f4ffad2f 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -167,6 +167,8 @@ struct FileOperations {
>      bool (*has_valid_handle)(int fid_type, V9fsFidOpenState *fs);
>      int (*ftruncate)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
>                       off_t size);
> +    int (*futimens)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> +                    const struct timespec *times);
>  };
>  
>  #endif
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index fa763b0662f5..f8b932802c17 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1104,6 +1104,14 @@ out:
>      return ret;
>  }
>  
> +static int local_futimens(FsContext *s, int fid_type, V9fsFidOpenState *fs,
> +                          const struct timespec *times)
> +{
> +    int fd = local_fid_fd(fid_type, fs);
> +
> +    return qemu_futimens(fd, times);
> +}
> +
>  static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>                                   int flags)
>  {
> @@ -1628,4 +1636,5 @@ FileOperations local_ops = {
>      .unlinkat = local_unlinkat,
>      .has_valid_handle = local_has_valid_handle,
>      .ftruncate = local_ftruncate,
> +    .futimens = local_futimens,
>  };
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 7f0e13f0ddd8..3bf4bb17e767 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -424,6 +424,13 @@ static int synth_utimensat(FsContext *fs_ctx, V9fsPath *path,
>      return 0;
>  }
>  
> +static int synth_futimens(FsContext *fs_ctx, int fid_type, V9fsFidOpenState *fs,
> +                          const struct timespec *buf)
> +{
> +    errno = ENOSYS;
> +    return -1;
> +}
> +
>  static int synth_remove(FsContext *ctx, const char *path)
>  {
>      errno = EPERM;
> @@ -664,4 +671,5 @@ FileOperations synth_ops = {
>      .unlinkat     = synth_unlinkat,
>      .has_valid_handle = synth_has_valid_handle,
>      .ftruncate    = synth_ftruncate,
> +    .futimens     = synth_futimens,
>  };
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 7bc4ec8e85cc..a1924fe3f05a 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -103,6 +103,7 @@ static inline int errno_to_dotl(int err) {
>  #define qemu_renameat   renameat
>  #define qemu_utimensat  utimensat
>  #define qemu_unlinkat   unlinkat
> +#define qemu_futimens   futimens
>  
>  static inline void close_preserve_errno(int fd)
>  {
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 35b2ed900a01..8024cc06a090 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1708,7 +1708,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
>          } else {
>              times[1].tv_nsec = UTIME_OMIT;
>          }
> -        err = v9fs_co_utimensat(pdu, &fidp->path, times);
> +        if (fid_has_valid_handle(pdu->s, fidp)) {
> +            err = v9fs_co_futimens(pdu, fidp, times);
> +        } else {
> +            err = v9fs_co_utimensat(pdu, &fidp->path, times);
> +        }
>          if (err < 0) {
>              goto out;
>          }
> diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
> index 893466fb1a44..12fa8c9fe9cd 100644
> --- a/hw/9pfs/cofs.c
> +++ b/hw/9pfs/cofs.c
> @@ -139,6 +139,25 @@ int coroutine_fn v9fs_co_utimensat(V9fsPDU *pdu, V9fsPath *path,
>      return err;
>  }
>  
> +int coroutine_fn v9fs_co_futimens(V9fsPDU *pdu, V9fsFidState *fidp,
> +                                  struct timespec times[2])
> +{
> +    int err;
> +    V9fsState *s = pdu->s;
> +
> +    if (v9fs_request_cancelled(pdu)) {
> +        return -EINTR;
> +    }
> +    v9fs_co_run_in_worker(
> +        {
> +            err = s->ops->futimens(&s->ctx, fidp->fid_type, &fidp->fs, times);
> +            if (err < 0) {
> +                err = -errno;
> +            }
> +        });
> +    return err;
> +}
> +
>  int coroutine_fn v9fs_co_chown(V9fsPDU *pdu, V9fsPath *path, uid_t uid,
>                                 gid_t gid)
>  {
> diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> index 0b8ee4c56495..9920f98129e9 100644
> --- a/hw/9pfs/coth.h
> +++ b/hw/9pfs/coth.h
> @@ -111,5 +111,7 @@ int coroutine_fn v9fs_co_st_gen(V9fsPDU *pdu, V9fsPath *path, mode_t,
>                                  V9fsStatDotl *v9stat);
>  int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp,
>                                     off_t size);
> +int coroutine_fn v9fs_co_futimens(V9fsPDU *pdu, V9fsFidState *fidp,
> +                                  struct timespec times[2]);
>  
>  #endif

Same nit as with previous patch: I would group v9fs_co_futimens() and
v9fs_co_utimensat() together in this header file for overview reason.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

/Christian



