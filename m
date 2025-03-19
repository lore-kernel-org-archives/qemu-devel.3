Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45B8C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusJu-0003uF-UV; Wed, 19 Mar 2025 08:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tusJe-0003sg-Fg
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:14:38 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tusJa-0007ip-Pb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8UJZGYRinVl9Mybxrh+cIh5fNWy6Qyf9rQkxjpSCXVg=; b=LHVom49qUZ/skOOkuRpRxNQoPo
 m1L3Pw9GpvRYJte4vuZWC+wH99uPtQ6cPDNUkEiGQ4KGYco4W7E34Tp9lMH5Bom66rWYRMCcudigM
 XjgIIFv3+Q2M0f6K18VPQ+ekCZI9hqfhw5qmKxdbteY74oWgf8ZgdmB64CZbDEFyldFkDXnMIKsJB
 3CVSRkBAgQvWO2APFLYrEdfNtWaqAR/EQBPCvuchEvaq35n8ecYMNIc8n2mvq6VsTL1p9Yta54eD3
 sjIpyrIkbbIyvDktl0HNI1ejdls0vX0EQWD706qSnMYXAE+SUFd4jmjmTx4skxRRKMDxa+tvKUnAV
 NoniFuww3mwRsFjQan0jIrt/8p8+RePmmUoIle/QE5KF91NyWCFCb2jCt2LR9nruljn00dBVyYCEY
 NCeVpc7Ma5b8n48Whyg3+zHNgLtPGRiiGXcnjoauhlzM7+YIiaWbt3GkbuRgE9HNL216rTHSTWeAb
 yWfXd2ErVtLv3cN6V3NtJ8sW4ddh/wcU7oqj02/X1/FLvJ1Yme+qw6XCet2Ii8lcECJf+1GWSjhXy
 UlG4HfMh8Wx0iQRrRqUjERUWt9k04Yi3NpI1j7WMBOtQrUnu3kJ1Xe30b8OaZE4mv90KKviePnMJB
 Sw8FO9qL9/OVwIBMTyWYHQur5YHO/AuTzeZo3Hdp8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: fix 'total_open_fd' decrementation
Date: Wed, 19 Mar 2025 13:14:27 +0100
Message-ID: <1820249.RkjqyYWvsj@silver>
In-Reply-To: <E1tuqQb-004R61-AZ@kylie.crudebyte.com>
References: <E1tuqQb-004R61-AZ@kylie.crudebyte.com>
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

On Wednesday, March 19, 2025 11:08:58 AM CET Christian Schoenebeck wrote:
> According to 'man 2 close' errors returned by close() should only be used
> for either diagnostic purposes or for catching data loss due to a previous
> write error, as an error result of close() usually indicates a deferred
> error of a previous write operation.
> 
> Therefore not decrementing 'total_open_fd' on a close() error is wrong
> and would yield in a higher open file descriptor count than actually the
> case, leading to 9p server reclaiming open file descriptors too soon.
> 
> Based-on: <20250312152933.383967-7-groug@kaod.org>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c     | 14 ++++++++------
>  hw/9pfs/codir.c  |  3 ++-
>  hw/9pfs/cofile.c |  3 ++-
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index b22df3aa2b..f4ca8e4db5 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -434,7 +434,6 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>      V9fsFidState *f;
>      GHashTableIter iter;
>      gpointer fid;
> -    int err;
>      int nclosed = 0;
>  
>      /* prevent multiple coroutines running this function simultaniously */
> @@ -507,13 +506,16 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>       */
>      v9fs_co_run_in_worker({
>          QSLIST_FOREACH(f, &reclaim_list, reclaim_next) {
> -            err = (f->fid_type == P9_FID_DIR) ?
> +            /*
> +             * 'man 2 close' suggests to ignore close() errors except of EBADF,
> +             * not checking for EBADF here either as FIDs were picked above by
> +             * having a valid file descriptor
> +             */
> +            (f->fid_type == P9_FID_DIR) ?
>                  s->ops->closedir(&s->ctx, &f->fs_reclaim) :
>                  s->ops->close(&s->ctx, &f->fs_reclaim);
> -            if (!err) {
> -                /* total_open_fd must only be mutated on main thread */
> -                nclosed++;
> -            }
> +            /* total_open_fd must only be mutated on main thread */
> +            nclosed++;
>          }
>      });
>      total_open_fd -= nclosed;
> diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> index 2068a4779d..f1fd97c8a7 100644
> --- a/hw/9pfs/codir.c
> +++ b/hw/9pfs/codir.c
> @@ -353,7 +353,8 @@ int coroutine_fn v9fs_co_closedir(V9fsPDU *pdu, V9fsFidOpenState *fs)
>                  err = -errno;
>              }
>          });
> -    if (!err) {
> +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> +    if (!err || errno != EBADF) {
>          total_open_fd--;
>      }
>      return err;

Or, as EBADF is somewhat unexpected here (assuming v9fs_co_closedir() was
called by checking for a valid file handle), maybe it would make sense to log
this?

    if (unlikely(err && errno == EBADF)) {
        error_report("v9fs_co_closedir() failed with EBADF");  
    } else {
        total_open_fd--;
    }

In the sense, if EBADF happens here, it's an indication for a bug in 9p
server.

> diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
> index 71174c3e4a..1e9f6da42a 100644
> --- a/hw/9pfs/cofile.c
> +++ b/hw/9pfs/cofile.c
> @@ -197,7 +197,8 @@ int coroutine_fn v9fs_co_close(V9fsPDU *pdu, V9fsFidOpenState *fs)
>                  err = -errno;
>              }
>          });
> -    if (!err) {
> +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> +    if (!err || errno != EBADF) {
>          total_open_fd--;
>      }
>      return err;

Same here then.

/Christian



