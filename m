Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF2EC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 01:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wktfL-0003SX-M0; Fri, 17 Jul 2026 21:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wktfF-0003SC-RO; Fri, 17 Jul 2026 21:16:29 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wktfE-0004NE-B8; Fri, 17 Jul 2026 21:16:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92F414397A;
 Sat, 18 Jul 2026 01:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EFB1F000E9;
 Sat, 18 Jul 2026 01:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784337381;
 bh=a+ejCJXZ8E0G5TxHT1XlkLEgo05f1WOmKU9FYIQKbWU=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=QPanwKEFzZl5ILlVGlSF5y5ZZj/mZLBBaba6Bzu9iuINnqeCJlY/NUz7Z4kUin7Ks
 GUzkjZmFRNrfCMf24V4ljv3f6ofRNctUcQZxGiPaGMX5sXCfFKvYGDco7XtcbrGOrW
 hDicv29rwfAAcJsVxLcdS+UmXmTMz6FCVYKef4ptLe8X0ERaHVhr9TYcdWUmMrr7BO
 aekZH6iZfyM0yJl5UxZ6XvmdWux5DWIdahFejwSckPrx/XcVphtuqVJNknSzyRg0EB
 L8EDh4u5hXDpXRZP1WzfgqCFFdJdk/ZYAoQtjZFvkK5ExNSxh2Iz1JbnkTc2BxA4UU
 tRXKJgXTIviVQ==
Date: Fri, 17 Jul 2026 18:16:21 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/4] xen-block: Fix inverted error check in
 xen_cdrom_realize()
In-Reply-To: <20260716170923.2125858-3-Mitsuru.Kariya@oss.nttdata.com>
Message-ID: <alpine.DEB.2.22.394.2607171816130.16921@ubuntu-linux-20-04-desktop>
References: <20260716170923.2125858-1-Mitsuru.Kariya@oss.nttdata.com>
 <20260716170923.2125858-3-Mitsuru.Kariya@oss.nttdata.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 17 Jul 2026, Mitsuru Kariya wrote:
> xen_cdrom_realize() checks the return value of blk_attach_dev() with
> 
>     if (!rc) {
>         error_setg_errno(errp, -rc, "failed to create drive");
>         return;
>     }
> 
> but blk_attach_dev() returns 0 on success and a negative errno on
> failure.  The condition is inverted: a successful attach (rc == 0) is
> reported as an error and fails realize, while a real failure (rc < 0)
> is silently ignored.
> 
> Here blk_attach_dev() is called on a BlockBackend just created by
> blk_new(), so blk->dev is NULL and its only failure path (-EBUSY)
> cannot be taken.  Replace the bogus check with an assertion, matching
> the other empty-drive realize paths (scsi-disk, ide, fdc, swim).
> 
> Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>


Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  hw/block/xen-block.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 474c12fe4a..abf9df2eee 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -762,10 +762,7 @@ static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
>          conf->blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
>  
>          rc = blk_attach_dev(conf->blk, DEVICE(blockdev));
> -        if (!rc) {
> -            error_setg_errno(errp, -rc, "failed to create drive");
> -            return;
> -        }
> +        assert(rc == 0);
>      }
>  
>      blockdev->info = VDISK_READONLY | VDISK_CDROM;
> -- 
> 2.43.0
> 

