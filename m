Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47905C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 23:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5vIm-0002vf-Ty; Fri, 18 Apr 2025 19:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1u5vIk-0002vV-U2
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 19:39:19 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1u5vIi-0000aW-7M
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 19:39:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AB47443645;
 Fri, 18 Apr 2025 23:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE05C4CEE2;
 Fri, 18 Apr 2025 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745019545;
 bh=5wGAQWpQTIZX2l3pQvcOxx8yBagYYlMioXmaNEknYxQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=aCnWgkFbB2SgGMNSuJjwP+IBukVUZqyMytHVi2C9kqoIoh5KiPd0dT85Otn3Rsbp7
 3T+MsOEtHCCrlRJOhpMg0ifDIijRYC83RHxezxbkJrMhvQF9+12C4vWROS+CKhm2iH
 WPS8+7j06z0qkJ4iih84musFRUk1tR1uMDTBfz0GYYwVTWtE1DvuPxS3zgk4dGOIfl
 M9hLdNBLUahUFBl6jQUQX0KoVbXQ+VUtCXAJjYuBepHOv9YQRFYmbybitUe19FaJcc
 qkbgPfA0kGUXkIi7HDEyjzhwocffj3C7AJAXWdIAC5g/5k3kI0ESlDvpIz5AjvgBib
 be0i8ocGOk/Vg==
Date: Fri, 18 Apr 2025 16:39:04 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Aleksandr Partanen <alex.pentagrid@gmail.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>, 
 Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH] xen: mapcache: Fix finding matching entry
In-Reply-To: <20250410144604.214977-1-alex.pentagrid@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2504181638300.785180@ubuntu-linux-20-04-desktop>
References: <20250410144604.214977-1-alex.pentagrid@gmail.com>
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

On Thu, 10 Apr 2025, Aleksandr Partanen wrote:
> If we have request without lock and hit unlocked or invalid
> entry during the search, we remap it immediately,
> even if we have matching entry in next entries in bucket.
> This leads to duplication of mappings of the same size,
> and to possibility of selecting the wrong element
> during invalidation and underflow it's entry->lock counter
> 
> Signed-off-by: Aleksandr Partanen <alex.pentagrid@gmail.com>

Hi Aleksandr, thanks for the patch, it looks correct to me.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


Edgar, would you be able to give it a look as well to make sure?


> ---
>  hw/xen/xen-mapcache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 698b5c53ed..2c8f861fdb 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -376,12 +376,12 @@ tryagain:
>  
>      entry = &mc->entry[address_index % mc->nr_buckets];
>  
> -    while (entry && (lock || entry->lock) && entry->vaddr_base &&
> -            (entry->paddr_index != address_index || entry->size != cache_size ||
> +    while (entry && (!entry->vaddr_base ||
> +            entry->paddr_index != address_index || entry->size != cache_size ||
>               !test_bits(address_offset >> XC_PAGE_SHIFT,
>                   test_bit_size >> XC_PAGE_SHIFT,
>                   entry->valid_mapping))) {
> -        if (!free_entry && !entry->lock) {
> +        if (!free_entry && (!entry->lock || !entry->vaddr_base)) {
>              free_entry = entry;
>              free_pentry = pentry;
>          }
> -- 
> 2.39.5
> 

