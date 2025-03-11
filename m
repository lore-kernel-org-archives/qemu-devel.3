Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D741C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxJk-0002GI-OT; Tue, 11 Mar 2025 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxJi-0002Dc-C4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:58:34 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxJg-00067M-9m
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=35xgzA2vyZvZXoFcBAnyPSHNqzactHeOfN3+cNnyEzE=; b=XkJVc1o3aKvM1HAPS2FPaElCFO
 iSZCfvBIdpqAA9HvO4cSWB2U9k+EWmtPKi7I4ZI9I61Jx27DU1ScyAIiov0cC/bGomhPHhrA4NdVZ
 GkJTE4ZjTip0DXO4WJi+eZVU88fgPhvZ//cVnck7luRIGjM6/ttx8Q6lY66UdXGcAM5xseYb8wbPc
 DYK5e5vR957IDdjmsZ/oXWt9oT74WmL9LyrY/aUyt6RXGa9aRIb7NhDb53N7VdJ3xoE/T6cKGnq7b
 /BUQHtiKz3NiFVcnJ9OlTU0XmQeQ0TU2keQ62wPN20UAljaIl5500kEW0nmuTEuGBJNzA+0YjC0yq
 gW6rIZjwik53MybMMowKoKc7MuWe0sJUDuhWue1gdzPMpddmysjlnqLKK2FuzkkxeCo3yvjqopWSW
 vGc0JEfhzODUbD2Y4tGyX2yf6/oOzqZxu/BAjcOYKSikVWPGYFjSElqELPI9FLtsIcssad84oC82m
 X/2IqEG0BUABEpj/L2gb3694eYKQMkUIQZZzr1nhLmJDWynX/aKWZ46tLQQ4D8InooiBeXQ5ESwvu
 JEnYGdy/2KkdwqlRHL2C3CmLg7OWKy1YetoVov5NkqHpSulIAlYmEpjLTwUguMMaQjRDwrpYw0nSg
 Ras9YU08gpuHT9/dzYjRZhNZORoLVupyxxOuKMFhA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/4] 9pfs: local : Introduce local_fid_fd() helper
Date: Tue, 11 Mar 2025 11:58:28 +0100
Message-ID: <23860256.nhtPhaig3F@silver>
In-Reply-To: <20250310171101.138380-2-groug@kaod.org>
References: <20250310171101.138380-1-groug@kaod.org>
 <20250310171101.138380-2-groug@kaod.org>
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

On Monday, March 10, 2025 6:10:58 PM CET Greg Kurz wrote:
> Factor out duplicated code to a single helper. More users to come.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 928523afcc6c..c4366c867988 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -766,10 +766,9 @@ out:
>      return err;
>  }
>  
> -static int local_fstat(FsContext *fs_ctx, int fid_type,
> -                       V9fsFidOpenState *fs, struct stat *stbuf)
> +static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
>  {
> -    int err, fd;
> +    int fd;
>  
>      if (fid_type == P9_FID_DIR) {
>          fd = dirfd(fs->dir.stream);
> @@ -777,6 +776,14 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
>          fd = fs->fd;
>      }
>  
> +    return fd;
> +}

Maybe simplifying this like:

static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
{
    if (fid_type == P9_FID_DIR) {
        return dirfd(fs->dir.stream);
    } else {
        return fs->fd;
    }
}

or even just:

static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
{
    return (fid_type == P9_FID_DIR) ? dirfd(fs->dir.stream) : return fs->fd;
}

/Christian

> +
> +static int local_fstat(FsContext *fs_ctx, int fid_type,
> +                       V9fsFidOpenState *fs, struct stat *stbuf)
> +{
> +    int err, fd = local_fid_fd(fid_type, fs);
> +
>      err = fstat(fd, stbuf);
>      if (err) {
>          return err;
> @@ -1167,13 +1174,7 @@ out:
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



