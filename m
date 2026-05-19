Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB11DCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLxX-0005Ah-4O; Tue, 19 May 2026 11:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPLx6-00055s-Tm
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:01:48 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPLx3-0002fq-80
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:01:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AF7C60121;
 Tue, 19 May 2026 15:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CDBC2BCB3;
 Tue, 19 May 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779202903;
 bh=1LeZ7aaDt0fOQkBu34KD+Jm+fXwQzL0U0/52fSh7Sao=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=s5T3NDjsHAXKjbWg6TX53DFy9GHC/e5EhfD5BcEv4/vgC9iSCc0iMhXnhPAaZJb/p
 F4asnog+qvcLx2Zl1LEL6lKTfYe5y5drnmfxws15hC9nzeVhFEp9yHw2MkUZhlCO+8
 a2yj6+xs0qOCn6XrhIgE9/CVkLHlhW57SX5iF/ftdMk8fiyD+KSJMY/Tw1imUVtYIZ
 4KvnHIvnwmYFGTKhpbARrtfISDzgBWOeWP3RgmS+CV/VJdvpQsanYj3LrbJK1WX8GS
 Jt0wrce5uHsMHFltVbgwuZ7QdiTfQfY/z6nNc6WAVtXawtLWMKCS9fX8LlyJ0roeJX
 NPRKnqIjw4vtw==
Date: Tue, 19 May 2026 16:01:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 03/10] cxl-type3: Properly unmap the
 memory-backend on device exit
Message-ID: <20260519160136.4115234b@jic23-huawei>
In-Reply-To: <20260429135717.3048713-4-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-4-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, 29 Apr 2026 14:48:37 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> Currently the backend remains mapped, meaning that if the device owning
> the backend is hot-removed, it cannot be readded in the same QEMU
> instance.
> 
> Signed-off-by: Joshua Lant <joshualant@gmail.com>

Gah.  That sounds like a fix we should have in place today.

Can you send it as a separate patch with an appropriate
Fixes tag.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 68cd04b7d9..414c776028 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1072,12 +1072,15 @@ static void ct3_exit(PCIDevice *pci_dev)
>      cxl_destroy_cci(&ct3d->cci);
>      if (ct3d->dc.host_dc) {
>          cxl_destroy_dc_regions(ct3d);
> +        host_memory_backend_set_mapped(ct3d->dc.host_dc, false);
>          address_space_destroy(&ct3d->dc.host_dc_as);
>      }
>      if (ct3d->hostpmem) {
> +        host_memory_backend_set_mapped(ct3d->hostpmem, false);
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
>      if (ct3d->hostvmem) {
> +        host_memory_backend_set_mapped(ct3d->hostvmem, false);
>          address_space_destroy(&ct3d->hostvmem_as);
>      }
>  }


