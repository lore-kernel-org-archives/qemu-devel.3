Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21519C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMd9-0003Li-Is; Wed, 12 Mar 2025 10:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMd4-0003Hi-8n
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:00:15 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMd2-0008C2-BQ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=TlYXLVOUVWyJThyx4rJkVQpGV+3Xixgk2/Vmq5lLGoo=; b=XYIBWffleqsXdLu3fut1gHYUu0
 wYRrJyjz2TmuQ9HqrTFPYILODIF7A2ff7BqqJKQfeyVyeCr0OoCF4SamXxHmcBImNBd+M/OKx9WrE
 /WFAAsMwPez/6zjKCJTYuxbP6T+0W7j+T9QA5uUMIw0ebDVvLK1MfnzHMPZ0l8t+fvKIgnI/quZSW
 cZYhvsUFP5Xa9I2/FAvXq1Fisg3Yb+RWLjSIdChO6BlhlZpoF2xCw22XlgufjjZ/8vsyVG21/qVyh
 RyD6c8TyzA1x8ZjHGrq8AN2mxO78Me1Ticz5eBm2OC8i4HE4tKYLVO41rBTj3SkVIRJPt5sgCMpxo
 GUYi0neC7siHqcf9bQY9U3SJY64yR8BiZ0hO3rx2DuRksBnnquoyTb7dQPa+YE74YKNsJMo7H1cis
 ELEx3BKl3CmyV1+7Ryq565R4sEerRZ2o28ObqO8KJoX71D87KD5XmOHvynrAZd6pvMmq2DJ0pGAT3
 MtDMOEztj66QpL0fkQa/Q3C2O9TGlGvvleHI0P2FcrtJ0snqQEYK09ElqsU8E1qKRjhWbRM3RRy0r
 5/TJsMMaLVvDhCuEm6iN4npg5rlmw9Wf8ZjT6S9g8wERWXJN/WprFtS0EhsSWz1GBsPxEkujZhtmU
 W38flDjfGpXjv2m4owxRfUMOgP/nmCamzxXTwEHtQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 1/6] 9pfs: local : Introduce local_fid_fd() helper
Date: Wed, 12 Mar 2025 15:00:07 +0100
Message-ID: <5328011.opueANnkRj@silver>
In-Reply-To: <20250311172809.250913-2-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
 <20250311172809.250913-2-groug@kaod.org>
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

On Tuesday, March 11, 2025 6:28:04 PM CET Greg Kurz wrote:
> Factor out duplicated code to a single helper. More users to come.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> v2: - simplified local_fid_fd()
> ---

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  hw/9pfs/9p-local.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 928523afcc6c..99b9560a528b 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -766,16 +766,19 @@ out:
>      return err;
>  }
>  
> -static int local_fstat(FsContext *fs_ctx, int fid_type,
> -                       V9fsFidOpenState *fs, struct stat *stbuf)
> +static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
>  {
> -    int err, fd;
> -
>      if (fid_type == P9_FID_DIR) {
> -        fd = dirfd(fs->dir.stream);
> +        return dirfd(fs->dir.stream);
>      } else {
> -        fd = fs->fd;
> +        return fs->fd;
>      }
> +}
> +
> +static int local_fstat(FsContext *fs_ctx, int fid_type,
> +                       V9fsFidOpenState *fs, struct stat *stbuf)
> +{
> +    int err, fd = local_fid_fd(fid_type, fs);
>  
>      err = fstat(fd, stbuf);
>      if (err) {
> @@ -1167,13 +1170,7 @@ out:
>  static int local_fsync(FsContext *ctx, int fid_type,
>                         V9fsFidOpenState *fs, int datasync)
>  {
> -    int fd;
> -
> -    if (fid_type == P9_FID_DIR) {
> -        fd = dirfd(fs->dir.stream);
> -    } else {
> -        fd = fs->fd;
> -    }
> +    int fd = local_fid_fd(fid_type, fs);
>  
>      if (datasync) {
>          return qemu_fdatasync(fd);
> 



